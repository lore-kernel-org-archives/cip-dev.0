From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Tue, 17 Jan 2017 15:05:00 +0100
Subject: [cip-dev] kernelci setup fails
In-Reply-To: <f6c5c137-3fc9-c175-4889-5cf16480f167@monom.org>
References: <f6c5c137-3fc9-c175-4889-5cf16480f167@monom.org>
Message-ID: <587E248C.2090002@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Daniel

On 17/01/17 09:49, Daniel Wagner wrote:
> Hi,
>
> running 'vagrant up' from a clean setup consistently fails with this:
>
>
> ==> default: TASK [setup] *******************************************************************
> ==> default: ok: [kernel-ci-backend]
> ==> default:
> ==> default: TASK [common : Tweak kernel configuration for performance] *********************
> ==> default: changed: [kernel-ci-backend]
> ==> default:
> ==> default: TASK [install-deps : Install OS dependencies] **********************************
> ==> default: failed: [kernel-ci-backend] (item=[u'build-essential', u'git', u'lsb-release', u'python-apt', u'python-pip', u'python-pycurl', u'python-virtualenv', u'python2.7-dev', u'sysfsutils', u'python3', u'python3-yaml', u'python3-setproctitle', u'python3-zmq']) => {"failed": true, "item": ["build-essential", "git", "lsb-release", "python-apt", "python-pip", "python-pycurl", "python-virtualenv", "python2.7-dev", "sysfsutils", "python3", "python3-yaml", "python3-setproctitle", "python3-zmq"], "msg": "No package matching 'python3-setproctitle' is available"}
>
>
> A quick search for setproctitle tells me it is installed via
>
> 	kernelci-backend-config/roles/install-deps/tasks/main.yml:    - python3-setproctitle
>
> But ubuntu doesn't seem to know this package:
>
> vagrant at vagrant-ubuntu-trusty-64:~$ apt-cache search setproctitle
> libbsd-dev - utility functions from BSD systems - development files
> python-setproctitle - A setproctitle implementation for Python
> python-setproctitle-dbg - A setproctitle implementation for Python
>
>
> I haven't spend time to figure out what this package is doing or
> how it used. So my quick question how to fix this?

maybe this helps?

https://gitlab.com/cip-project/testing/issues/12

If this is your case, Don is on it. He talked to one of the kernelci 
developers, Milo Casagrande about it.

>
> cheers,
> daniel
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
>

-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
