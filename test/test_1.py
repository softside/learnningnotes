from test import TradeTestCase
import unittest
class test_sys(TradeTestCase):
    def test_user(self):
        from apps.webservice.user import getUserInfoAMF
        res = getUserInfoAMF(self.request,'mouren')
        print res

if __name__ == '__main__':
    unittest.main()
