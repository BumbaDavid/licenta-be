# custom_auth.py

import logging
from tastypie.authentication import ApiKeyAuthentication
from tastypie.authorization import DjangoAuthorization

logger = logging.getLogger(__name__)


class CustomApiKeyAuthentication(ApiKeyAuthentication):
    def is_authenticated(self, request, **kwargs):
        bypass_auth = request.GET.get('bypass_auth', 'false').lower() == 'true'
        logger.debug(f"CustomApiKeyAuthentication: bypass_auth={bypass_auth}")

        if bypass_auth:
            logger.info("Authentication bypassed due to bypass_auth=True")
            return True

        logger.debug("Proceeding with normal API key authentication")
        result = super().is_authenticated(request, **kwargs)
        if not result:
            logger.warning("API key authentication failed")
        return result


class CustomDjangoAuthorization(DjangoAuthorization):
    def read_list(self, object_list, bundle):
        bypass_auth = bundle.request.GET.get('bypass_auth', 'false').lower() == 'true'
        logger.debug(f"CustomDjangoAuthorization.read_list: bypass_auth={bypass_auth}")

        if bypass_auth:
            logger.info("Authorization bypassed for list view due to bypass_auth=True")
            return object_list
        return super().read_list(object_list, bundle)

    def read_detail(self, object_list, bundle):
        bypass_auth = bundle.request.GET.get('bypass_auth', 'false').lower() == 'true'
        logger.debug(f"CustomDjangoAuthorization.read_detail: bypass_auth={bypass_auth}")

        if bypass_auth:
            logger.info("Authorization bypassed for detail view due to bypass_auth=True")
            return True
        return super().read_detail(object_list, bundle)
