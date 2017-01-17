From: daniel.wagner@siemens.com (Daniel Wagner)
Date: Tue, 17 Jan 2017 15:43:46 +0100
Subject: [cip-dev] kernelci setup fails
In-Reply-To: <587E248C.2090002@codethink.co.uk>
References: <f6c5c137-3fc9-c175-4889-5cf16480f167@monom.org>
	<587E248C.2090002@codethink.co.uk>
Message-ID: <e50a3001-d769-5a28-7dde-0850f5247324@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Agustin,

On 01/17/2017 03:05 PM, Agustin Benito Bethencourt wrote:
> maybe this helps?
> 
> https://gitlab.com/cip-project/testing/issues/12
> 
> If this is your case, Don is on it. He talked to one of the kernelci
> developers, Milo Casagrande about it.

Indeed the second bug report in the ticket is the problem I see too.

http://packages.ubuntu.com/search?keywords=python3-setproctitle

    xenial (16.04LTS) (python): A setproctitle implementation for Python
(Python 3) [universe]
    1.1.8-1build2: amd64 arm64 armhf i386 powerpc ppc64el s390x
    yakkety (16.10) (python): A setproctitle implementation for Python
(Python 3)
    1.1.8-1ubuntu2: amd64 arm64 armhf i386 powerpc ppc64el s390x
    zesty (python): Setproctitle implementation for Python 3
    1.1.10-1: amd64 arm64 armhf i386 powerpc ppc64el s390x

So this package is just not part of the trusty version. Is there a
specific reason to stick to trusty?

Thanks,
Daniel
