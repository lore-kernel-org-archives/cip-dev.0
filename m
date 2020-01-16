From: kazuhiro3.hayashi@toshiba.co.jp (kazuhiro3.hayashi at toshiba.co.jp)
Date: Thu, 16 Jan 2020 06:54:54 +0000
Subject: [cip-dev] RT Testing
In-Reply-To: <TYAPR01MB2285FB4BDC74EB669E362E89B7340@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <TYAPR01MB2285FB4BDC74EB669E362E89B7340@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <TYXPR01MB18081C565B8B2F072CC2C9E5E1360@TYXPR01MB1808.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Chris,

Thank you for your updates!

> Hello Pavel, Hayashi-san, Jan, Daniel,
> 
[...]
> 
> Currently there is an issue with the way that the cyclic test case results are shown (i.e. they aren't) in LAVA due to
> a change [0] made to Linaro's cyclictest.sh.
> That means that the test parsing now depends on Python, which isn't included in the cip-core RFS [1] that is currently
> being used.
> 
> Do either of the CIP Core profiles include Python support?

At the moment, we've just started creating the supported package list, so I cannot clearly say Yes.
However, at least, the both profiles can create an image including python only for testing
because the python packages are already provided in upstream projects (isar, meta-debian).

Whether CIP Core provides Python packages or not depends on
what kind of packages will be proposed (requested) by CIP WGs in future.
Currently, several packages which depend on Python packages would be
included in the next proposal from security WG (under review now).

BTW, it would be better to confirm which Python version (2.7 or 3) that cyclictest.sh depends on.
Do you know anything about this?

Kazu

> 
> Linaro test-definitions [2] have the following tests marked within the preempt-rt scope:
>   cyclicdeadline/cyclicdeadline.yaml
>   pmqtest/pmqtest.yaml
>   rt-migrate-test/rt-migrate-test.yaml
>   cyclictest/cyclictest.yaml
>   svsematest/svsematest.yaml
>   pi-stress/pi-stress.yaml
>   signaltest/signaltest.yaml
>   ptsematest/ptsematest.yaml
>   sigwaittest/sigwaittest.yaml
>   hackbench/hackbench.yaml
>   ltp-realtime/ltp-realtime.yaml
> 
> Which of the above would be valuable to run on CIP RT Kernels?
> 
> A while back Daniel Wagner also did some work on a Jitterdebugger test [3], but it hasn't been merged yet and I'm not
> sure what the current status is. Any updates Daniel?
> 
> Is anyone able to provide RT config/defconfigs for the x86 and arm boards in the Mentor lab? Or BBB, QEMU etc.? (assuming
> that the hardware is suitable).
> 
> 
> [0]
> https://github.com/Linaro/test-definitions/commit/4b5c46f275632932b3045f2ee16ad9cae5bb482d#diff-c724b852b75aefda2cc3
> 505c4517828dR50
> [1] https://s3-us-west-2.amazonaws.com/download.cip-project.org/cip-core/iwg20m/core-image-minimal-iwg20m.tar.gz
> [2] https://github.com/Linaro/test-definitions/blob/master/automated/linux
> [3] https://github.com/igaw/test-definitions/blob/preempt-rt/automated/linux/jitterdebugger/jitterdebugger.yaml
> 
> Kind regards, Chris
