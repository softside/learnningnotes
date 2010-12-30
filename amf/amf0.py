# vim: fileencoding=utf8
import codecs
import struct
import re
import datetime
import time
import socket
from decimal import Decimal
from types import *
import amf, amf.utils
try:
    set
except NameError:
    from sets import Set as set, ImmutableSet as frozenset
try:
    import xml.etree.cElementTree as ET
except ImportError:
    import xml.etree.ElementTree as ET
try:
    from cStringIO import StringIO
except ImportError:
    from StringIO import StringIO


UTF8 = 'utf_8'

NUMBER_TO_INT = False
STRING_TO_UNICODE = False


NUMBER_MARKER         = 0x00
BOOLEAN_MARKER        = 0x01
STRING_MARKER         = 0x02
OBJECT_MARKER         = 0x03
MOVIECLIP_MARKER      = 0x04
NULL_MARKER           = 0x05
UNDEFINED_MARKER      = 0x06
REFERENCE_MARKER      = 0x07
ECMA_ARRAY_MARKER     = 0x08
OBJECT_END_MARKER     = 0x09
STRICT_ARRAY_MARKER   = 0x0A
DATE_MARKER           = 0x0B
LONG_STRING_MARKER    = 0x0C
UNSUPPORTED_MARKER    = 0x0D
RECORDSET_MARKER      = 0x0E
XML_DOCUMENT_MARKER   = 0x0F
TYPED_OBJECT_MARKER   = 0x10
AVMPLUS_OBJECT_MARKER = 0x11

read_func_map = {
    NUMBER_MARKER         : 'read_double',
    BOOLEAN_MARKER        : 'read_boolean',
    STRING_MARKER         : 'read_string',
    OBJECT_MARKER         : 'read_object',
    MOVIECLIP_MARKER      : None,
    NULL_MARKER           : None,
    UNDEFINED_MARKER      : None,
    REFERENCE_MARKER      : 'read_reference',
    ECMA_ARRAY_MARKER     : 'read_ecma_array',
    STRICT_ARRAY_MARKER   : 'read_strict_array',
    DATE_MARKER           : 'read_date',
    LONG_STRING_MARKER    : 'read_long_string',
    UNSUPPORTED_MARKER    : None,
    XML_DOCUMENT_MARKER   : 'read_xml_document',
    TYPED_OBJECT_MARKER   : 'read_typed_object',
    AVMPLUS_OBJECT_MARKER : 'read_amf3_data',
}

def read_byte(input, context=None):
    return ord(input.read(1))

def read_int(input, context=None):
    return ((ord(input.read(1)) << 8) | ord(input.read(1)));

def is_int(value):
    return int(value) == value

def read_double(input, context=None):
    bytes = input.read(8)
    float_value = struct.unpack('!d', bytes)[0]
    if NUMBER_TO_INT and is_int(float_value):
        return int(float_value)
    return float_value

def read_boolean(input, context=None):
    return not read_byte(input) == 0

def read_string(input, context=None, length=None):
    if length is None:
        length = read_int(input)
    if length == 0:
        str = ''
    str = input.read(length)
    if STRING_TO_UNICODE:
        return unicode(str, UTF8, 'replace')
    return str

def read_data(input, type, context):
    if type not in read_func_map:
        amf.logger.error("Unsupported Type [type='%s']", type)
        raise Exception("Unsupported type [type='%s']" % (type,))
    func_name = read_func_map[type]
    if func_name is not None:
        func = eval(func_name)
        if callable(func):
            return func(input, context)
    return None

def read_object(input, context):
    key = read_string(input, context)
    type = read_byte(input, context)
    ret = {}
    while type != OBJECT_END_MARKER:
        val = read_data(input, type, context)
        ret[key] = val
        key = read_string(input, context)
        type = read_byte(input)
    return ret
    
def read_reference(input, context):
    reference = read_int(input, context);
    return "(unresolved object #%s)" % reference

def read_ecma_array(input, context):
    input.read(4)
    return read_mixed_object(input, context)

def read_mixed_object(input, context):
    key = read_string(input, context)
    type = read_byte(input)
    ret = {}
    while type != OBJECT_END_MARKER:
        val = read_data(input, type, context)
        if isinstance(key, (int, long, float)):
            key = float(key)
        ret[key] = val
        key = read_string(input, context)
        type = read_byte(input)
    return ret
    
def read_long(input, context=None):
    return ((ord(input.read(1)) << 24) |
            (ord(input.read(1)) << 16) |
            (ord(input.read(1)) << 8) |
            ord(input.read(1)))

def read_strict_array(input, context):
    ret = []
    length = read_long(input)
    for i in range(length):
        type = read_byte(input)
        ret.append(read_data(input, type, context))
    return ret

def read_date(input, context):
    ms = read_double(input) # date in milliseconds from 01/01/1970
    offset = read_int(input)
    if offset > 720:
        offset = - (65536 - offset)
    offset *= -60
    h = offset / 3600
    class TZ(datetime.tzinfo):
        def utcoffset(self, dt):
            return datetime.timedelta(hours=h)
        def dst(self, dt):
            return datetime.timedelta(0)
        def tzname(self, dt):
            return "JST" # TODO: How to deal with other timezone?
    tz = TZ()  
    return datetime.datetime.fromtimestamp(ms / 1000.0, tz) 

def read_long_string(input, context=None):
    length = read_long(input)
    str = input.read(length)
    if STRING_TO_UNICODE:
        return unicode(str, UTF8, 'replace')
    return str

def read_xml_document(input, context=None):
    xmlStr = read_long_string(input)
    return ET.fromstring(xmlStr)

def read_typed_object(input, context):
    type = read_string(input).replace('..', '')
    obj = read_object(input, context)
    amf.utils.logger().debug("read_typed_object() -- type=%s, object=%s", type, str(obj))
    if '_explicitType' not in obj:
        obj['_explicitType'] = type
    return amf.utils.classcast(type, obj)

def read_amf3_data(input, context):
    import amf3
    return amf3.read_data(input, context)

def read_headers(input, message):
    message.version = read_int(input) # client -- 0x00: FP 8 or below, 0x01: FMS, 0x03: FP 9
    header_count = read_int(input)
    for i in range(header_count):
        context = None
        if (message.version == 3):
            context = amf.AMFMessageBodyContext()
        name = read_string(input)
        mustUnderstand = read_boolean(input)
        length = read_long(input) #input.seek(4, 1) # Length in bytes of header
        type = read_byte(input)
        content = read_data(input, type, context)
        amfHeader = { 'name':name, 'mustUnderstand':mustUnderstand, 'content':content }
        message.add_header(amfHeader)

def read_bodies(input, message):
    bodyCount = read_int(input)
    for i in range(bodyCount):
        context = None
        if (message.version == 3):
            context = amf.AMFMessageBodyContext()
        target = read_string(input)
        response = read_string(input)
        length = read_long(input) #input.read(4) # Body length in bytes
        type = read_byte(input)
        amf.utils.logger().debug("AMF Type='%s'", type)
        value = read_data(input, type, context)
        amf_body = amf.AMFMessageBody(target, response, value)
        message.add_body(amf_body)

def read(raw_post_data, options={}):
    NUMBER_TO_INT = options.get('number_to_int', False)
    STRING_TO_UNICODE = options.get('string_to_unicode', False)

    input = StringIO(raw_post_data)
    content_length = len(raw_post_data)
    message = amf.AMFMessage()
    read_headers(input, message)
    read_bodies(input, message)
    return message


write_func_maps = (
        {(BooleanType,)      : 'write_boolean',},
        {(IntType, LongType, FloatType, Decimal)  : 'write_number',},
        {(StringTypes,)      : 'write_string',},
        {(ListType, TupleType, set, frozenset)  : 'write_array',},
        {(DictType,)         : 'write_object',},
        {(datetime.datetime, datetime.date) : 'write_datetime',},
        {(NoneType,)         : 'write_null',},
        {(object,)           : 'write_typed_object',}, # default
        )

def write_data(d, output):
    amf.utils.logger().debug("amf0.write_data(%s)", repr(d))
    d = amf.utils._convert_djangotype_into_standard(d)

    if ET.iselement(d):
        write_xml(d, output)
    else:
        for func_map in write_func_maps:
            types = func_map.keys()[0]
            if isinstance(d, types):
                func = eval(func_map.values()[0])
                if callable(func):
                    func(d, output)
                    return

def write_int(n, output):
    amf.utils.logger().debug("amf0.write_int(%s)", repr(n))
    output.write(struct.pack('!H', n))
    #output.write(struct.pack('H', socket.htons(n)))

def write_byte(b, output):
    amf.utils.logger().debug("amf0.write_byte(%s)", repr(b))
    output.write(struct.pack('B', b))

def write_long(l, output):
    amf.utils.logger().debug("amf0.write_long(%s)", repr(l))
    output.write(struct.pack('!l', long(l)))
    #output.write(struct.pack('l', long(socket.htonl(l))))

def write_utf(s, output):
    s = encode_to_utf8(s)
    amf.utils.logger().debug("amf0.write_utf(%s)", repr(s))
    write_int(len(s), output)
    output.write(s)

def write_binary(b, output):
    write_int(len(b), output)
    output.write(b)

def write_long_utf(s, output):
    amf.utils.logger().debug("amf0.write_long_utf(%s)", repr(s))
    s = encode_to_utf8(s)
    write_long(len(s), output)
    output.write(s)

def encode_to_utf8(s):
    if isinstance(s, unicode):
        s = s.encode(UTF8)
    else:
        s = str(s)
    return s 

def write_string(s, output, context=None):
    amf.utils.logger().debug("amf0.write_string(%s)", repr(s))
    s = encode_to_utf8(s)
    count = len(s) 
    if (count < 65536):
        write_byte(STRING_MARKER, output)
        write_utf(s, output)
    else:
        write_byte(LONG_STRING_MARKER, output)
        write_long_utf(s, output)

def write_array(a, output, context=None):
    amf.utils.logger().debug("amf0.write_array(%s)", repr(a))
    write_byte(STRICT_ARRAY_MARKER, output)
    write_long(len(a), output)
    for e in a:
        write_data(e, output)

def write_double(d, output, context=None):
    amf.utils.logger().debug("amf0.write_double(%s)", repr(d))
    output.write(struct.pack('!d', d))    

def write_object(obj, output, context=None):
    amf.utils.logger().debug("amf0.write_object(%s)", repr(obj))
    write_byte(OBJECT_MARKER, output)
    if 'iteritems' in dir(obj):
        items = obj.iteritems()
    else:
        items = obj.__dict__.iteritems()
    for key, value in items:
        write_utf(key, output)
        write_data(value, output)
    write_int(0, output)
    write_byte(OBJECT_END_MARKER, output)

def write_number(n, output, context=None):
    amf.utils.logger().debug("amf0.write_number(%s)", repr(n))
    if isinstance(n, Decimal): n = float(n)
    write_byte(NUMBER_MARKER, output)
    write_double(float(n), output)

def write_null(n, output, context=None):
    amf.utils.logger().debug("amf0.write_null()")
    write_byte(NULL_MARKER, output)

def write_boolean(b, output, context=None):
    amf.utils.logger().debug("amf0.write_boolean(%s)", repr(b))
    write_byte(BOOLEAN_MARKER, output)
    write_byte(b, output)

def write_datetime(d, output, context=None):
    amf.utils.logger().debug("amf0.write_datetime(%s)", repr(d))
    timestamp = time.mktime(d.timetuple())
    write_byte(DATE_MARKER, output)
    write_double(timestamp * 1000, output)
    write_int(0, output)

def write_xml(document, output, context=None):
    amf.utils.logger().debug("amf0.write_xml(%s)", ET.tostring(document, 'utf-8'))
    write_byte(XML_DOCUMENT_MARKER, output)
    xmlstr = re.sub(r'\>(\n|\r|\r\n| |\t)*\<', '><', ET.tostring(document, 'utf-8').strip())
    write_long_utf(xmlstr, output)

def write_typed_object(obj, output):
    amf.utils.logger().debug("amf0.write_typed_object(%s)", repr(obj))
    write_byte(TYPED_OBJECT_MARKER, output)
    type = amf.utils.get_as_type(obj)
    write_utf(type, output)
    if 'iteritems' in dir(obj): # d is a dict 
        items = obj.iteritems()
    else:
        items = obj.__dict__.iteritems()
    no_return_attrs = amf.utils.get_no_return_attrs(obj)
    for key, value in items:
        if not key in no_return_attrs:
            write_utf(key, output)
            write_data(value, output)
    write_int(0, output)
    write_byte(OBJECT_END_MARKER, output)

def write(message):
    output = StringIO()
    write_int(0, output)
    header_count = len(message.headers)
    write_int(header_count, output)
    for header in message.headers:
        write_utf(header['name'], output)
        write_byte(header.get('mustUnderstand', False), output) # specifies if understaning the hreader is 'required'
        content = StringIO()
        write_data(header['content'], content)
        write_long(len(content.getvalue()), output) # Length in bytes of header
        output.write(content.getvalue())
        content.close()
    body_count = len(message.bodies)
    write_int(body_count, output)
    for body in message.bodies:
        write_utf(body.target, output) # Target
        if body.response is None or body.response == '':
            body.response = 'null'
        write_utf(body.response, output) # Response
        content = StringIO()
        write_data(body.data, content) # Actual data
        write_long(len(content.getvalue()), output) # Body length in bytes
        output.write(content.getvalue())
        content.close()
    try:
        return output.getvalue()
    finally:
        output.close()

