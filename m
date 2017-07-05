From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Wed, 05 Jul 2017 15:19:08 +0100
Subject: [cip-dev] running health checks from behind a web proxy
Message-ID: <87fueb6k6b.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

There is a known issue with b at d when running a lava QEMU health check
from behind a web proxy.

When attempting to retrieve the kernel, it produces the error

Invalid job data:
  ["HTTPSConnectionPool(host='images.validation.linaro.org', port=443):
  Max retries exceeded with url: /kvm/standard/stretch-2.img.gz
   (Caused by NewConnectionError('<requests.packages.urllib3.connection.VerifiedHTTPSConnection
  object@0x7f430c9b9c50>: Failed to establish a new connection: [Errno -5] No address associated with hostname',))"]

see:
https://gitlab.com/cip-project/cip-testing/testing/issues/99

As b at d is intended to use locally built artefacts and the default QEMU health
check uses a remote kernel, a suggested work around for this test would be to copy
https://images.validation.linaro.org/kvm/standard/stretch-2.img.gz
locally to /var/www/images/kernel-ci/qemu (a new directory)
and alter the health check to use the url
http://localhost:8010/qemu/stretch-2.img.gz

which should avoid the use of any web proxies.

You'll probably need a fairly clean copy of the VM with plenty of free
disk space to manage the extra copy of the kernel.

Thoughts? Hoping to discuss this further at tomorrow's open meeting.

Robert
