From: don.f.brown@comcast.net (Don Brown)
Date: Wed, 18 Jan 2017 21:55:44 -0500
Subject: [cip-dev] kernelci setup fails
Message-ID: <CANm2L4n0XyWRHuqvFGY=_KSSu_ABumVCw2_Q-D3A-dv=A27xew@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Everyone,

I'm reporting on 2 issues today:
1. Re: kernelci setup fails
2. Re: Kernel-CI Frontend broken links to build.log et al.

-----
#1
I have fixed the issue of the Kernel-CI Virtual Machine failing to boot on
the 'python3-setproctitle' and various other libraries.

You can read about it here: https://gitlab.com/cip-project/testing/issues/12

The TL;DR is that the kernelci_backend was broken between 12-Dec-2016 and
the current version. I found that by using the 12-Dec-2016 commit, the
backend booted up just fine.

So, we are back to where we were at the end of December where we can create
builds and view them on the Web Frontend, but the links to the build.log,
kernel.config, kernel image and dtbs are still broken

-----
#2
I have tracked down the general area where the links to the build.log,
kernel.config, kernel image and dtbs are broken. I just need someone who
knows the code to help fix it.

You can read about it here: https://gitlab.com/cip-project/testing/issues/2

Sorry, there is no TL;DR for this one.


Sincerely,

Don Brown. PMP
don.f.brown at comcast.net
Mobile: (317) 560-0513
Here's to Life, Linux and the Pursuit of Happiness

On Tue, Jan 17, 2017 at 12:14 PM, <cip-dev-request@lists.cip-project.org>
wrote:

> Send cip-dev mailing list submissions to
>         cip-dev at lists.cip-project.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         https://lists.cip-project.org/mailman/listinfo/cip-dev
> or, via email, send a message with subject or body 'help' to
>         cip-dev-request at lists.cip-project.org
>
> You can reach the person managing the list at
>         cip-dev-owner at lists.cip-project.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of cip-dev digest..."
>
>
> Today's Topics:
>
>    1. Re: kernelci setup fails (Agustin Benito Bethencourt)
>    2. Re: kernelci setup fails (Daniel Wagner)
>    3. Re: kernelci setup fails (Don Brown)
>    4. Re: kernelci setup fails (Daniel Wagner)
>    5. Re: kernelci setup fails (Daniel Wagner)
>    6. Re: kernelci setup fails (Agustin Benito Bethencourt)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Tue, 17 Jan 2017 15:05:00 +0100
> From: Agustin Benito Bethencourt <agustin.benito@codethink.co.uk>
> To: cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] kernelci setup fails
> Message-ID: <587E248C.2090002@codethink.co.uk>
> Content-Type: text/plain; charset=utf-8; format=flowed
>
> Hi Daniel
>
> On 17/01/17 09:49, Daniel Wagner wrote:
> > Hi,
> >
> > running 'vagrant up' from a clean setup consistently fails with this:
> >
> >
> > ==> default: TASK [setup] ******************************
> *************************************
> > ==> default: ok: [kernel-ci-backend]
> > ==> default:
> > ==> default: TASK [common : Tweak kernel configuration for performance]
> *********************
> > ==> default: changed: [kernel-ci-backend]
> > ==> default:
> > ==> default: TASK [install-deps : Install OS dependencies]
> **********************************
> > ==> default: failed: [kernel-ci-backend] (item=[u'build-essential',
> u'git', u'lsb-release', u'python-apt', u'python-pip', u'python-pycurl',
> u'python-virtualenv', u'python2.7-dev', u'sysfsutils', u'python3',
> u'python3-yaml', u'python3-setproctitle', u'python3-zmq']) => {"failed":
> true, "item": ["build-essential", "git", "lsb-release", "python-apt",
> "python-pip", "python-pycurl", "python-virtualenv", "python2.7-dev",
> "sysfsutils", "python3", "python3-yaml", "python3-setproctitle",
> "python3-zmq"], "msg": "No package matching 'python3-setproctitle' is
> available"}
> >
> >
> > A quick search for setproctitle tells me it is installed via
> >
> >       kernelci-backend-config/roles/install-deps/tasks/main.yml:    -
> python3-setproctitle
> >
> > But ubuntu doesn't seem to know this package:
> >
> > vagrant at vagrant-ubuntu-trusty-64:~$ apt-cache search setproctitle
> > libbsd-dev - utility functions from BSD systems - development files
> > python-setproctitle - A setproctitle implementation for Python
> > python-setproctitle-dbg - A setproctitle implementation for Python
> >
> >
> > I haven't spend time to figure out what this package is doing or
> > how it used. So my quick question how to fix this?
>
> maybe this helps?
>
> https://gitlab.com/cip-project/testing/issues/12
>
> If this is your case, Don is on it. He talked to one of the kernelci
> developers, Milo Casagrande about it.
>
> >
> > cheers,
> > daniel
> > _______________________________________________
> > cip-dev mailing list
> > cip-dev at lists.cip-project.org
> > https://lists.cip-project.org/mailman/listinfo/cip-dev
> >
>
> --
> Agustin Benito Bethencourt
> Principal Consultant - FOSS at Codethink
> agustin.benito at codethink.co.uk
>
>
> ------------------------------
>
> Message: 2
> Date: Tue, 17 Jan 2017 15:43:46 +0100
> From: Daniel Wagner <daniel.wagner@siemens.com>
> To: Agustin Benito Bethencourt <agustin.benito@codethink.co.uk>,
>         cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] kernelci setup fails
> Message-ID: <e50a3001-d769-5a28-7dde-0850f5247324@siemens.com>
> Content-Type: text/plain; charset=windows-1252
>
> Hi Agustin,
>
> On 01/17/2017 03:05 PM, Agustin Benito Bethencourt wrote:
> > maybe this helps?
> >
> > https://gitlab.com/cip-project/testing/issues/12
> >
> > If this is your case, Don is on it. He talked to one of the kernelci
> > developers, Milo Casagrande about it.
>
> Indeed the second bug report in the ticket is the problem I see too.
>
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
>
> Thanks,
> Daniel
>
>
> ------------------------------
>
> Message: 3
> Date: Tue, 17 Jan 2017 11:04:04 -0500
> From: Don Brown <don.f.brown@comcast.net>
> To: cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] kernelci setup fails
> Message-ID:
>         <CANm2L4=-ZamtbxhvuY7wVRBja3P1YiL0cGkgVb_FPrFciFS3nA@mail.
> gmail.com>
> Content-Type: text/plain; charset="utf-8"
>
> Hi Daniel,
>
> I have the same problem and worked on it yesterday from several angles. My
> notes are logged in Issue #12 in the GitLab repo. The link is:
>
> https://gitlab.com/cip-project/testing/issues/12
>
>
> Sincerely,
>
> Don Brown. PMP
> don.f.brown at comcast.net
> Mobile: (317) 560-0513
> Here's to Life, Linux and the Pursuit of Happiness
>
> On Tue, Jan 17, 2017 at 7:00 AM, <cip-dev-request@lists.cip-project.org>
> wrote:
>
> > Send cip-dev mailing list submissions to
> >         cip-dev at lists.cip-project.org
> >
> > To subscribe or unsubscribe via the World Wide Web, visit
> >         https://lists.cip-project.org/mailman/listinfo/cip-dev
> > or, via email, send a message with subject or body 'help' to
> >         cip-dev-request at lists.cip-project.org
> >
> > You can reach the person managing the list at
> >         cip-dev-owner at lists.cip-project.org
> >
> > When replying, please edit your Subject line so it is more specific
> > than "Re: Contents of cip-dev digest..."
> >
> >
> > Today's Topics:
> >
> >    1. kernelci setup fails (Daniel Wagner)
> >
> >
> > ----------------------------------------------------------------------
> >
> > Message: 1
> > Date: Tue, 17 Jan 2017 09:49:37 +0100
> > From: Daniel Wagner <wagi@monom.org>
> > To: cip-dev at lists.cip-project.org
> > Subject: [cip-dev] kernelci setup fails
> > Message-ID: <f6c5c137-3fc9-c175-4889-5cf16480f167@monom.org>
> > Content-Type: text/plain; charset=utf-8
> >
> > Hi,
> >
> > running 'vagrant up' from a clean setup consistently fails with this:
> >
> >
> > ==> default: TASK [setup] ******************************
> > *************************************
> > ==> default: ok: [kernel-ci-backend]
> > ==> default:
> > ==> default: TASK [common : Tweak kernel configuration for performance]
> > *********************
> > ==> default: changed: [kernel-ci-backend]
> > ==> default:
> > ==> default: TASK [install-deps : Install OS dependencies]
> > **********************************
> > ==> default: failed: [kernel-ci-backend] (item=[u'build-essential',
> > u'git', u'lsb-release', u'python-apt', u'python-pip', u'python-pycurl',
> > u'python-virtualenv', u'python2.7-dev', u'sysfsutils', u'python3',
> > u'python3-yaml', u'python3-setproctitle', u'python3-zmq']) => {"failed":
> > true, "item": ["build-essential", "git", "lsb-release", "python-apt",
> > "python-pip", "python-pycurl", "python-virtualenv", "python2.7-dev",
> > "sysfsutils", "python3", "python3-yaml", "python3-setproctitle",
> > "python3-zmq"], "msg": "No package matching 'python3-setproctitle' is
> > available"}
> >
> >
> > A quick search for setproctitle tells me it is installed via
> >
> >         kernelci-backend-config/roles/install-deps/tasks/main.yml:    -
> > python3-setproctitle
> >
> > But ubuntu doesn't seem to know this package:
> >
> > vagrant at vagrant-ubuntu-trusty-64:~$ apt-cache search setproctitle
> > libbsd-dev - utility functions from BSD systems - development files
> > python-setproctitle - A setproctitle implementation for Python
> > python-setproctitle-dbg - A setproctitle implementation for Python
> >
> >
> > I haven't spend time to figure out what this package is doing or
> > how it used. So my quick question how to fix this?
> >
> > cheers,
> > daniel
> >
> >
> > ------------------------------
> >
> > _______________________________________________
> > cip-dev mailing list
> > cip-dev at lists.cip-project.org
> > https://lists.cip-project.org/mailman/listinfo/cip-dev
> >
> >
> > End of cip-dev Digest, Vol 8, Issue 6
> > *************************************
> >
> -------------- next part --------------
> An HTML attachment was scrubbed...
> URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/
> 20170117/01ad92a1/attachment-0001.html>
>
> ------------------------------
>
> Message: 4
> Date: Tue, 17 Jan 2017 17:32:18 +0100
> From: Daniel Wagner <daniel.wagner@siemens.com>
> To: Don Brown <don.f.brown@comcast.net>, cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] kernelci setup fails
> Message-ID: <bf0051c6-fa6f-3ed0-a578-b1cc5e9142bc@siemens.com>
> Content-Type: text/plain; charset=windows-1252
>
> Hi Don,
>
> On 01/17/2017 05:04 PM, Don Brown wrote:
> > I have the same problem and worked on it yesterday from several angles.
> > My notes are logged in Issue #12 in the GitLab repo. The link is:
> >
> > https://gitlab.com/cip-project/testing/issues/12
>
> I'll create a gitlab account soon, so that I can collaborate via the
> ticket system.
>
> Thanks.
> Daniel
>
>
> ------------------------------
>
> Message: 5
> Date: Tue, 17 Jan 2017 17:36:54 +0100
> From: Daniel Wagner <daniel.wagner@siemens.com>
> To: Agustin Benito Bethencourt <agustin.benito@codethink.co.uk>
> Cc: cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] kernelci setup fails
> Message-ID: <9cf9f75f-30bd-9be5-cbe2-4ca1baa6d193@siemens.com>
> Content-Type: text/plain; charset=windows-1252
>
> On 01/17/2017 03:43 PM, Daniel Wagner wrote:
> > http://packages.ubuntu.com/search?keywords=python3-setproctitle
> >
> >     xenial (16.04LTS) (python): A setproctitle implementation for Python
> > (Python 3) [universe]
> >     1.1.8-1build2: amd64 arm64 armhf i386 powerpc ppc64el s390x
> >     yakkety (16.10) (python): A setproctitle implementation for Python
> > (Python 3)
> >     1.1.8-1ubuntu2: amd64 arm64 armhf i386 powerpc ppc64el s390x
> >     zesty (python): Setproctitle implementation for Python 3
> >     1.1.10-1: amd64 arm64 armhf i386 powerpc ppc64el s390x
> >
> > So this package is just not part of the trusty version. Is there a
> > specific reason to stick to trusty?
>
> I gave it a try, no luck though:
>
> ==> default: TASK [install-deps : Install MongoDB]
> ******************************************
> ==> default: failed: [kernel-ci-backend] (item=[u'mongodb-org',
> u'libsnappy1']) => {"failed": true, "item": ["mongodb-org",
> "libsnappy1"], "msg": "No package matching 'libsnappy1' is available"}
>
>
> So I am stuck at the same level as Don is. Anyway, I was wondering how
> to be able to have local copies of the kernelci code and use that one as
> source instead of the hard coded git urls. It seems rather hard to work
> on the setup if you can't change it :)
>
> What about having an option which mounts the local kernelci repos into
> the virtual machine? Obviously, the kernelci ansible script would also
> need to be modified to allow overwrites.
>
> Thanks,
> Daniel
>
>
> ------------------------------
>
> Message: 6
> Date: Tue, 17 Jan 2017 18:14:11 +0100
> From: Agustin Benito Bethencourt <agustin.benito@codethink.co.uk>
> To: cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] kernelci setup fails
> Message-ID: <587E50E3.3080202@codethink.co.uk>
> Content-Type: text/plain; charset=utf-8; format=flowed
>
> Hi,
>
> On 17/01/17 17:32, Daniel Wagner wrote:
> > Hi Don,
> >
> > On 01/17/2017 05:04 PM, Don Brown wrote:
> >> I have the same problem and worked on it yesterday from several angles.
> >> My notes are logged in Issue #12 in the GitLab repo. The link is:
> >>
> >> https://gitlab.com/cip-project/testing/issues/12
> >
> > I'll create a gitlab account soon, so that I can collaborate via the
> > ticket system.
>
> until then...
>
> We have discussed what to do. There are several options:
> 1 Make Python 3.5.2 work on trusty.
> 2 Move on to Ubuntu 16.04
> 3 Move to an in-between version.
> 4 Try to move it into Debian so we can go for a single VM for the whole
> kernelci tolling.
>
> Don is describing in the gitlab ticket his early tries of each option to
> determine which way to go. Although #4 is the desired one, it seems the
> most difficult one as well, so we decided to focus on the initial three.
>
> We want to have the system working first and then we will figure out how
> we can simplify the deployment.
>
> Best Regards
>
> --
> Agustin Benito Bethencourt
> Principal Consultant - FOSS at Codethink
> agustin.benito at codethink.co.uk
>
>
> ------------------------------
>
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
>
>
> End of cip-dev Digest, Vol 8, Issue 7
> *************************************
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20170118/554eb4eb/attachment-0001.html>
