From: kazuhiro3.hayashi@toshiba.co.jp (kazuhiro3.hayashi at toshiba.co.jp)
Date: Fri, 17 Jan 2020 01:41:21 +0000
Subject: [cip-dev] RT Testing
In-Reply-To: <TYAPR01MB22851DD503672EF581BBBD7AB7360@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <TYAPR01MB2285FB4BDC74EB669E362E89B7340@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <TYXPR01MB18081C565B8B2F072CC2C9E5E1360@TYXPR01MB1808.jpnprd01.prod.outlook.com>
 <TYAPR01MB22851DD503672EF581BBBD7AB7360@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <TYXPR01MB1808135D5FD4044CFEC589CDE1310@TYXPR01MB1808.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Chris,

> Hello,
> 
[...]
> > > Do either of the CIP Core profiles include Python support?
> >
> > At the moment, we've just started creating the supported package list, so I
> > cannot clearly say Yes.
> > However, at least, the both profiles can create an image including python only
> > for testing
> > because the python packages are already provided in upstream projects (isar,
> > meta-debian).
> 
> Okay. I'm thinking that we aren't going to be able to escape having a separate 'testing' version of CIP-Core, based on
> ISAR on the assumption that it has more supported packages then Deby.

The IRC log of yesterday: https://irclogs.baserock.org/cip/%23cip.2020-01-16.log.html

Starting from isar-cip-core would be better if we need to install
various packages for the testing like build-essential.
Deby also can generate an image including enough dependencies
of simple basic suites like LTP, cyclictest, etc. though.

Also, I guess LAVA can install additional packages for testing
(from Debian apt repository or some package directories on S3)
to their standard image after they boot on the target device.
We don't need to provide a separate testing image in this case.

> 
> Or not use CIP-Core for testing the Kernel as punit suggested ??

Personally, I would like to use CIP-Core image(s) for the kernel testing.
I have no concern about providing packages only for testing
as long as CIP is not responsible to maintain them.

> 
> >
> > Whether CIP Core provides Python packages or not depends on
> > what kind of packages will be proposed (requested) by CIP WGs in future.
> > Currently, several packages which depend on Python packages would be
> > included in the next proposal from security WG (under review now).
> >
> > BTW, it would be better to confirm which Python version (2.7 or 3) that
> > cyclictest.sh depends on.
> > Do you know anything about this?
> 
> Either version (thanks Daniel).

Thank you for your confirmation.

> 
> Presumably we'd want to target Python 3 though if that's what the world is moving to?

I think this is one of the important topics to be discussed in CIP Core.
I agree with your idea (target on Python 3), but there are still
some packages in Debian buster that have a run-time dependency on python 2.7, unfortunately.
I would like to create another thread to think about this topic later :)

Best regards,
Kazu


> 
> Kind regards, Chris
> 
> >
> > Kazu
> >
> > >
> > > Linaro test-definitions [2] have the following tests marked within the preempt-
> > rt scope:
> > >   cyclicdeadline/cyclicdeadline.yaml
> > >   pmqtest/pmqtest.yaml
> > >   rt-migrate-test/rt-migrate-test.yaml
> > >   cyclictest/cyclictest.yaml
> > >   svsematest/svsematest.yaml
> > >   pi-stress/pi-stress.yaml
> > >   signaltest/signaltest.yaml
> > >   ptsematest/ptsematest.yaml
> > >   sigwaittest/sigwaittest.yaml
> > >   hackbench/hackbench.yaml
> > >   ltp-realtime/ltp-realtime.yaml
> > >
> > > Which of the above would be valuable to run on CIP RT Kernels?
> > >
> > > A while back Daniel Wagner also did some work on a Jitterdebugger test [3],
> > but it hasn't been merged yet and I'm not
> > > sure what the current status is. Any updates Daniel?
> > >
> > > Is anyone able to provide RT config/defconfigs for the x86 and arm boards in
> > the Mentor lab? Or BBB, QEMU etc.? (assuming
> > > that the hardware is suitable).
> > >
> > >
> > > [0]
> > > https://github.com/Linaro/test-
> > definitions/commit/4b5c46f275632932b3045f2ee16ad9cae5bb482d#diff-
> > c724b852b75aefda2cc3
> > > 505c4517828dR50
> > > [1] https://s3-us-west-2.amazonaws.com/download.cip-project.org/cip-
> > core/iwg20m/core-image-minimal-iwg20m.tar.gz
> > > [2] https://github.com/Linaro/test-definitions/blob/master/automated/linux
> > > [3] https://github.com/igaw/test-definitions/blob/preempt-
> > rt/automated/linux/jitterdebugger/jitterdebugger.yaml
> > >
> > > Kind regards, Chris
