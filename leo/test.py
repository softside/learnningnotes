import os
import sys
import unittest

TEST_MEMBER_ID = 566
TEST_SNS_ID = 551
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
    
    def testaddWantToBuyAMF(self):
        # Not exist member
        from apps.webservice.trade import addWantToBuyAMF
        from apps.webservice.trade import getWantToBuyAMF
        from apps.webservice.trade import addWantToSaleAMF
        from apps.webservice.trade import getWantToSaleAMF
        from apps.webservice.trade import tradeWantToSaleAMF
        from apps.webservice.trade import tradeWantToBuyAMF
        from apps.products.cache import get_fish_with_stylecolor
        #res = getWantToSaleAMF(self.request, "mouren",414)
        #res = addWantToSaleAMF(self.request,"mouren",1222,1222)
        res = tradeWantToSaleAMF(self.request,'mouren',414,1)
        print 'getWantToSaleAMF'
        print res



if __name__ == '__main__':
    unittest.main()
