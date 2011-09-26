import os
import sys
import unittest

TEST_MEMBER_ID = 586
TEST_SNS_ID = 382090
TEST_SESSION_KEY = '2.f5949b6c07e264dce59b087df9f26115.3600.1270810800-288243096' # Need to get from sns platform


class TradeTestCase(unittest.TestCase):
    def setUp(self):
        # Set up django environment
        pathname = os.path.dirname(sys.argv[0])
        sys.path.append(os.path.abspath(pathname))
        sys.path.append(os.path.normpath(os.path.join(os.path.abspath(pathname), '../')))
        os.environ['DJANGO_SETTINGS_MODULE'] = 'settings'
        
        
        from django.http import HttpRequest
        self.request = HttpRequest()
        from django.contrib.sessions.backends.cache import SessionStore
        self.request.session = SessionStore()
        self.request.session['d746c8dead85ddcbe32112d75d849635'] = TEST_MEMBER_ID
        self.request.session[TEST_SESSION_KEY] = TEST_MEMBER_ID
        self.request.session.save()

    
    def tearDown(self):
        pass
    





