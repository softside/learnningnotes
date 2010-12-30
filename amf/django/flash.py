# vim: fileencoding=utf8
from django.http import HttpResponse
from django.template import loader
try:
    from cStringIO import StringIO
except ImportError:
    from StringIO import StringIO
try:
    import xml.etree.cElementTree as ET
except ImportError:
    import xml.etree.ElementTree as ET


def is_test_upload(request):
    return len(request.raw_post_data) == 0

class TestUploadException(Exception):

    def __init__(self):
        pass

def get_uploaded_image(request, uploadDataFieldName='Filedata'):
    from PIL import Image
    if is_test_upload(request):
        raise TestUploadException
    uploaded_file = request.FILES[uploadDataFieldName]
    f = StringIO(uploaded_file.get('content'))
    image = Image.open(f)
    image.__len__ = lambda: len(uploaded_file.get('content'))
    image.filename = uploaded_file.get('filename')
    image.content_type = uploaded_file.get('content-type')
    image.dispose = lambda: f.close()
    return image

def get_request_xml(request):
    xmlstr = request.raw_post_data
    doc = ET.parse(StringIO(xmlstr)).getroot()
    return doc

def render_to_response_as_xml(*args, **kwargs):
    return HttpResponse(loader.render_to_string(*args, **kwargs),
            mimetype='text/xml; charset=utf-8')
