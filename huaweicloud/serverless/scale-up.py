from huaweicloudsdkcore.auth.credentials import BasicCredentials
from huaweicloudsdkdcs.v2.region.dcs_region import DcsRegion
from huaweicloudsdkcore.exceptions import exceptions
from huaweicloudsdkdcs.v2 import *

if __name__ == "__main__":
    ak = "<AK>"
    sk = "<SK>"

    credentials = BasicCredentials(ak, sk) \

    client = DcsClient.new_builder() \
        .with_credentials(credentials) \
        .with_region(DcsRegion.value_of("ap-southeast-3")) \
        .build()

    try:
        request = ResizeInstanceRequest()
        request.instance_id = "<DCS_ID>"
        request.body = ResizeInstanceBody(
            new_capacity=4,
            spec_code="redis.single.xu1.large.4"
        )
        response = client.resize_instance(request)
        print(response)
    except exceptions.ClientRequestException as e:
        print(e.status_code)
        print(e.request_id)
        print(e.error_code)
        print(e.error_msg)
