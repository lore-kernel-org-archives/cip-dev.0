From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Tue, 14 Jan 2020 17:01:54 +0000
Subject: [cip-dev] RT Testing
Message-ID: <TYAPR01MB2285FB4BDC74EB669E362E89B7340@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Pavel, Hayashi-san, Jan, Daniel,

Addressing this email to all of you as both RT and CIP Core are involved.

I started to look into RT testing in more detail today.

I've created an RT configuration for the RZ/G1 boards:
https://gitlab.com/patersonc/cip-kernel-config/blob/chris/add_renesas_rt_configs/4.4.y-cip-rt/arm/renesas_shmobile-rt_defconfig
I'll do something similar for the RZ/G2 boards soon.

Built it with linux-4.4.y-cip-rt and run cyclic test:
https://lava.ciplatform.org/scheduler/job/9828
Times look okay to an rt-untrained eye:
T: 0 ( 1169) P:98 I:1000 C:  59993 Min:     13 Act:   16 Avg:   16 Max:      33

Compared to a run with linux-4.4.y-cip:
https://lava.ciplatform.org/scheduler/job/9829
T: 0 (  938) P:98 I:1000 C:   6000 Min:   1618 Act: 9604 Avg: 9603 Max:   14550

Pavel, does the above look okay/useful to you? Or is cyclictest not worth running unless there is some load on the system?

Currently there is an issue with the way that the cyclic test case results are shown (i.e. they aren't) in LAVA due to a change [0] made to Linaro's cyclictest.sh.
That means that the test parsing now depends on Python, which isn't included in the cip-core RFS [1] that is currently being used.

Do either of the CIP Core profiles include Python support?

Linaro test-definitions [2] have the following tests marked within the preempt-rt scope:
  cyclicdeadline/cyclicdeadline.yaml
  pmqtest/pmqtest.yaml
  rt-migrate-test/rt-migrate-test.yaml
  cyclictest/cyclictest.yaml
  svsematest/svsematest.yaml
  pi-stress/pi-stress.yaml
  signaltest/signaltest.yaml
  ptsematest/ptsematest.yaml
  sigwaittest/sigwaittest.yaml
  hackbench/hackbench.yaml
  ltp-realtime/ltp-realtime.yaml

Which of the above would be valuable to run on CIP RT Kernels?

A while back Daniel Wagner also did some work on a Jitterdebugger test [3], but it hasn't been merged yet and I'm not sure what the current status is. Any updates Daniel?

Is anyone able to provide RT config/defconfigs for the x86 and arm boards in the Mentor lab? Or BBB, QEMU etc.? (assuming that the hardware is suitable).


[0] https://github.com/Linaro/test-definitions/commit/4b5c46f275632932b3045f2ee16ad9cae5bb482d#diff-c724b852b75aefda2cc3505c4517828dR50
[1] https://s3-us-west-2.amazonaws.com/download.cip-project.org/cip-core/iwg20m/core-image-minimal-iwg20m.tar.gz
[2] https://github.com/Linaro/test-definitions/blob/master/automated/linux
[3] https://github.com/igaw/test-definitions/blob/preempt-rt/automated/linux/jitterdebugger/jitterdebugger.yaml

Kind regards, Chris
