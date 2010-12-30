# vim: fileencoding=utf8
from django.http import HttpResponse
from django.test.client import ClientHandler, Client
import amf.client


class RemotingService(amf.client.RemotingService):

    def __init__(self, gatewayUrl, serviceName, version=3):
        amf.client.RemotingService.__init__(self, gatewayUrl, serviceName, version)
        self.client = Client()

    def _post_amf_request(self, postdata):
        response = self.client.post(self.gatewayUrl, postdata, 'application/x-amf')
        return response.content

