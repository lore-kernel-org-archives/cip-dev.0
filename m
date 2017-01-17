From: don.f.brown@comcast.net (Don Brown)
Date: Tue, 17 Jan 2017 11:04:04 -0500
Subject: [cip-dev] kernelci setup fails
Message-ID: <CANm2L4=-ZamtbxhvuY7wVRBja3P1YiL0cGkgVb_FPrFciFS3nA@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Daniel,

I have the same problem and worked on it yesterday from several angles. My
notes are logged in Issue #12 in the GitLab repo. The link is:

https://gitlab.com/cip-project/testing/issues/12


Sincerely,

Don Brown. PMP
don.f.brown at comcast.net
Mobile: (317) 560-0513
Here's to Life, Linux and the Pursuit of Happiness

On Tue, Jan 17, 2017 at 7:00 AM, <cip-dev-request@lists.cip-project.org>
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
>    1. kernelci setup fails (Daniel Wagner)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Tue, 17 Jan 2017 09:49:37 +0100
> From: Daniel Wagner <wagi@monom.org>
> To: cip-dev at lists.cip-project.org
> Subject: [cip-dev] kernelci setup fails
> Message-ID: <f6c5c137-3fc9-c175-4889-5cf16480f167@monom.org>
> Content-Type: text/plain; charset=utf-8
>
> Hi,
>
> running 'vagrant up' from a clean setup consistently fails with this:
>
>
> ==> default: TASK [setup] ******************************
> *************************************
> ==> default: ok: [kernel-ci-backend]
> ==> default:
> ==> default: TASK [common : Tweak kernel configuration for performance]
> *********************
> ==> default: changed: [kernel-ci-backend]
> ==> default:
> ==> default: TASK [install-deps : Install OS dependencies]
> **********************************
> ==> default: failed: [kernel-ci-backend] (item=[u'build-essential',
> u'git', u'lsb-release', u'python-apt', u'python-pip', u'python-pycurl',
> u'python-virtualenv', u'python2.7-dev', u'sysfsutils', u'python3',
> u'python3-yaml', u'python3-setproctitle', u'python3-zmq']) => {"failed":
> true, "item": ["build-essential", "git", "lsb-release", "python-apt",
> "python-pip", "python-pycurl", "python-virtualenv", "python2.7-dev",
> "sysfsutils", "python3", "python3-yaml", "python3-setproctitle",
> "python3-zmq"], "msg": "No package matching 'python3-setproctitle' is
> available"}
>
>
> A quick search for setproctitle tells me it is installed via
>
>         kernelci-backend-config/roles/install-deps/tasks/main.yml:    -
> python3-setproctitle
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
>
> cheers,
> daniel
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
> End of cip-dev Digest, Vol 8, Issue 6
> *************************************
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20170117/01ad92a1/attachment.html>
