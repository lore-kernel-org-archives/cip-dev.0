From: daniel.wagner@siemens.com (Daniel Wagner)
Date: Tue, 17 Jan 2017 17:36:54 +0100
Subject: [cip-dev] kernelci setup fails
In-Reply-To: <e50a3001-d769-5a28-7dde-0850f5247324@siemens.com>
References: <f6c5c137-3fc9-c175-4889-5cf16480f167@monom.org>
	<587E248C.2090002@codethink.co.uk>
	<e50a3001-d769-5a28-7dde-0850f5247324@siemens.com>
Message-ID: <9cf9f75f-30bd-9be5-cbe2-4ca1baa6d193@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 01/17/2017 03:43 PM, Daniel Wagner wrote:
> http://packages.ubuntu.com/search?keywords=python3-setproctitle
> 
>     xenial (16.04LTS) (python): A setproctitle implementation for Python
> (Python 3) [universe]
>     1.1.8-1build2: amd64 arm64 armhf i386 powerpc ppc64el s390x
>     yakkety (16.10) (python): A setproctitle implementation for Python
> (Python 3)
>     1.1.8-1ubuntu2: amd64 arm64 armhf i386 powerpc ppc64el s390x
>     zesty (python): Setproctitle implementation for Python 3
>     1.1.10-1: amd64 arm64 armhf i386 powerpc ppc64el s390x
> 
> So this package is just not part of the trusty version. Is there a
> specific reason to stick to trusty?

I gave it a try, no luck though:

==> default: TASK [install-deps : Install MongoDB]
******************************************
==> default: failed: [kernel-ci-backend] (item=[u'mongodb-org',
u'libsnappy1']) => {"failed": true, "item": ["mongodb-org",
"libsnappy1"], "msg": "No package matching 'libsnappy1' is available"}


So I am stuck at the same level as Don is. Anyway, I was wondering how
to be able to have local copies of the kernelci code and use that one as
source instead of the hard coded git urls. It seems rather hard to work
on the setup if you can't change it :)

What about having an option which mounts the local kernelci repos into
the virtual machine? Obviously, the kernelci ansible script would also
need to be modified to allow overwrites.

Thanks,
Daniel
