From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Thu, 16 Jan 2020 11:36:34 +0000
Subject: [cip-dev] RT Testing
In-Reply-To: <b0abdce4-62f4-400a-8c27-73c44d8ff9ca@monom.org>
References: <TYAPR01MB2285FB4BDC74EB669E362E89B7340@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <b0abdce4-62f4-400a-8c27-73c44d8ff9ca@monom.org>
Message-ID: <TYAPR01MB228534D71164FBB006EF8E0DB7360@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Daniel,

> From: Daniel Wagner <wagi@monom.org>
> Sent: 16 January 2020 09:25
> 
> Hi Chris,
> 
> On Tue, Jan 14, 2020 at 05:01:54PM +0000, Chris Paterson wrote:
> > Hello Pavel, Hayashi-san, Jan, Daniel,
> >
> > Addressing this email to all of you as both RT and CIP Core are involved.
> >
> > I started to look into RT testing in more detail today.
> 
> Welcome on board :)
> 
> > I've created an RT configuration for the RZ/G1 boards:
> > https://gitlab.com/patersonc/cip-kernel-
> config/blob/chris/add_renesas_rt_configs/4.4.y-cip-rt/arm/renesas_shmobile-
> rt_defconfig
> > I'll do something similar for the RZ/G2 boards soon.
> 
> I am using merge_config.sh to build the configuration. There are some
> catches but generally it works good. I've hacked a small tool for
> automization around it. With this the configuration is allways
> generated from scratch using kconfig.

Not a bad idea. I'll give it a go. Do you have an 'RT' config fragment you can share?
I guess it depends on what approach the Kernel maintainers would rather take.

Maintainers: Do we want dedicated RT configurations for CIP? Or just try and apply RT to all configurations (or a sub-selection) in cip-kernel-configs?

> 
> > Built it with linux-4.4.y-cip-rt and run cyclic test:
> > https://lava.ciplatform.org/scheduler/job/9828
> > Times look okay to an rt-untrained eye:
> > T: 0 ( 1169) P:98 I:1000 C:  59993 Min:     13 Act:   16 Avg:   16 Max:      33
> >
> > Compared to a run with linux-4.4.y-cip:
> > https://lava.ciplatform.org/scheduler/job/9829
> > T: 0 (  938) P:98 I:1000 C:   6000 Min:   1618 Act: 9604 Avg: 9603 Max:   14550
> >
> > Pavel, does the above look okay/useful to you? Or is cyclictest not worth
> running unless there is some load on the system?
> 
> Without load, it's not that interesting.
> 
> > Currently there is an issue with the way that the cyclic test case
> > results are shown (i.e. they aren't) in LAVA due to a change [0]
> > made to Linaro's cyclictest.sh.
> 
> My current test suite for LAVA contains these here:
> 
>      rt_suites = ['0_jd-hackbench',
>                   '0_jd-compile',
>                   '0_jd-stress_ptrace',
>                   '0_cyclicdeadline',
>                   '0_cyclictest',
>                   '0_pi-stress',
>                   '0_pmqtest',
>                   '0_ptsematest',
>                   '0_rt-migrate-test',
>                   '0_signaltest',
>                   '0_sigwaittest',
>                   '0_svsematest']
> 
> 
> > That means that the test parsing now depends on Python, which isn't included
> in the cip-core RFS [1] that is currently being used.
> 
> Sorry about that. I am changed this so that the test are marked failed
> if a value is seen higher as the maximum. Again, I am using my hack
> script to read out the results from the test and use coloring for it:
> 
> $ srt-build c2d jobs result
>    0_jd-hackbench       t1-max-latency      : pass      11.00
>    0_jd-hackbench       t1-avg-latency      : pass       2.37
>    0_jd-hackbench       t1-min-latency      : pass       1.00
>    0_jd-hackbench       t0-max-latency      : pass      10.00
>    0_jd-hackbench       t0-avg-latency      : pass       2.31
>    0_jd-hackbench       t0-min-latency      : pass       1.00
>    0_jd-compile         t1-max-latency      : pass      14.00
>    0_jd-compile         t1-avg-latency      : pass       3.37
>    0_jd-compile         t1-min-latency      : pass       1.00
>    0_jd-compile         t0-max-latency      : pass      14.00
>    0_jd-compile         t0-avg-latency      : pass       3.37
>    0_jd-compile         t0-min-latency      : pass       1.00
>    0_jd-stress_ptrace   t1-max-latency      : pass       7.00
>    0_jd-stress_ptrace   t1-avg-latency      : pass       2.19
>    0_jd-stress_ptrace   t1-min-latency      : pass       2.00
>    0_jd-stress_ptrace   t0-max-latency      : pass       9.00
>    0_jd-stress_ptrace   t0-avg-latency      : pass       2.22
>    0_jd-stress_ptrace   t0-min-latency      : pass       2.00
>    0_cyclicdeadline     t1-max-latency      : fail    3462.00
>    0_cyclicdeadline     t1-avg-latency      : pass    1594.00
>    0_cyclicdeadline     t1-min-latency      : pass       1.00
>    0_cyclicdeadline     t0-max-latency      : fail    3470.00
>    0_cyclicdeadline     t0-avg-latency      : pass    1602.00
>    0_cyclicdeadline     t0-min-latency      : pass       8.00
>    0_cyclictest         t1-max-latency      : pass      11.00
>    0_cyclictest         t1-avg-latency      : pass       2.00
>    0_cyclictest         t1-min-latency      : pass       1.00
>    0_cyclictest         t0-max-latency      : pass      13.00
>    0_cyclictest         t0-avg-latency      : pass       3.00
>    0_cyclictest         t0-min-latency      : pass       1.00
>    0_pi-stress          pi-stress           : pass       0.00
>    0_pmqtest            t3-2-max-latency    : pass      13.00
>    0_pmqtest            t3-2-avg-latency    : pass       4.00
>    0_pmqtest            t3-2-min-latency    : pass       2.00
>    0_pmqtest            t1-0-max-latency    : pass      23.00
>    0_pmqtest            t1-0-avg-latency    : pass       4.00
>    0_pmqtest            t1-0-min-latency    : pass       2.00
>    0_ptsematest         t3-2-max-latency    : pass      11.00
>    0_ptsematest         t3-2-avg-latency    : pass       3.00
>    0_ptsematest         t3-2-min-latency    : pass       2.00
>    0_ptsematest         t1-0-max-latency    : pass      14.00
>    0_ptsematest         t1-0-avg-latency    : pass       3.00
>    0_ptsematest         t1-0-min-latency    : pass       2.00
>    0_rt-migrate-test    t2-p98-avg          : pass      11.00
>    0_rt-migrate-test    t2-p98-tot          : pass     581.00
>    0_rt-migrate-test    t2-p98-min          : pass       9.00
>    0_rt-migrate-test    t2-p98-max          : pass      28.00
>    0_rt-migrate-test    t1-p97-avg          : pass      13.00
>    0_rt-migrate-test    t1-p97-tot          : pass     654.00
>    0_rt-migrate-test    t1-p97-min          : pass       8.00
>    0_rt-migrate-test    t1-p97-max          : pass      34.00
>    0_rt-migrate-test    t0-p96-avg          : pass   19213.00
>    0_rt-migrate-test    t0-p96-tot          : pass  960652.00
>    0_rt-migrate-test    t0-p96-min          : pass      13.00
>    0_rt-migrate-test    t0-p96-max          : pass   20031.00
>    0_signaltest         t0-max-latency      : pass      29.00
>    0_signaltest         t0-avg-latency      : pass       8.00
>    0_signaltest         t0-min-latency      : pass       4.00
>    0_sigwaittest        t3-2-max-latency    : pass      16.00
>    0_sigwaittest        t3-2-avg-latency    : pass       4.00
>    0_sigwaittest        t3-2-min-latency    : pass       2.00
>    0_sigwaittest        t1-0-max-latency    : pass      24.00
>    0_sigwaittest        t1-0-avg-latency    : pass       4.00
>    0_sigwaittest        t1-0-min-latency    : pass       2.00
>    0_svsematest         t3-2-max-latency    : pass      13.00
>    0_svsematest         t3-2-avg-latency    : pass       4.00
>    0_svsematest         t3-2-min-latency    : pass       2.00
>    0_svsematest         t1-0-max-latency    : pass      13.00
>    0_svsematest         t1-0-avg-latency    : pass       4.00
>    0_svsematest         t1-0-min-latency    : pass       2.00
>    0_smoke-tests        linux-posix-lsb_release: pass
>    0_smoke-tests        linux-posix-lscpu   : pass
>    0_smoke-tests        linux-posix-ifconfig: pass
>    0_smoke-tests        linux-posix-vmstat  : pass
>    0_smoke-tests        linux-posix-uname   : pass
>    0_smoke-tests        linux-posix-pwd     : pass
>    0_smoke-tests        linux-posix-lsb_release: pass
>    0_smoke-tests        linux-posix-lscpu   : pass
>    0_smoke-tests        linux-posix-ifconfig: pass
>    0_smoke-tests        linux-posix-vmstat  : pass
>    0_smoke-tests        linux-posix-uname   : pass
>    0_smoke-tests        linux-posix-pwd     : pass
>    0_smoke-tests        linux-posix-lsb_release: pass
>    0_smoke-tests        linux-posix-lscpu   : pass
>    0_smoke-tests        linux-posix-ifconfig: pass
>    0_smoke-tests        linux-posix-vmstat  : pass
>    0_smoke-tests        linux-posix-uname   : pass
>    0_smoke-tests        linux-posix-pwd     : pass
>    0_smoke-tests        linux-posix-lsb_release: pass
>    0_smoke-tests        linux-posix-lscpu   : pass
>    0_smoke-tests        linux-posix-ifconfig: pass
>    0_smoke-tests        linux-posix-vmstat  : pass
>    0_smoke-tests        linux-posix-uname   : pass
>    0_smoke-tests        linux-posix-pwd     : pass
> 
> 
> Trying to figure out from the web interface of LAVA is a bit
> combersome.
> 
> > Do either of the CIP Core profiles include Python support?
> >
> > Linaro test-definitions [2] have the following tests marked within the preempt-
> rt scope:
> >   cyclicdeadline/cyclicdeadline.yaml
> >   pmqtest/pmqtest.yaml
> >   rt-migrate-test/rt-migrate-test.yaml
> >   cyclictest/cyclictest.yaml
> >   svsematest/svsematest.yaml
> >   pi-stress/pi-stress.yaml
> >   signaltest/signaltest.yaml
> >   ptsematest/ptsematest.yaml
> >   sigwaittest/sigwaittest.yaml
> >   hackbench/hackbench.yaml
> >   ltp-realtime/ltp-realtime.yaml
> 
> See above.
> 
> > Which of the above would be valuable to run on CIP RT Kernels?
> 
> Basically you want to run all of the tests in rt-tests.

Does the RT project currently do (or have plans to do) the same?
https://ci-rt.linutronix.de/RT-Test/ seems to indicate that only cyclictest is run (with and without hackbench).

> 
> > A while back Daniel Wagner also did some work on a Jitterdebugger
> > test [3], but it hasn't been merged yet and I'm not sure what the
> > current status is. Any updates Daniel?
> 
> Yeah, I was holding a bit back until I am happy with my setup and
> workflow. One of the major limitations with the current
> test-definitions is the difficulties to setup background workload. To
> make it short, I am not too happy with my current version but it
> works.

Okay.

> 
> > Is anyone able to provide RT config/defconfigs for the x86 and arm
> > boards in the Mentor lab? Or BBB, QEMU etc.? (assuming that the
> > hardware is suitable).
> 
> If you are interested in my configs I have configs for ARMv7 (bbb),
> ARMv8 (RPi3) and x86_64 via my hacktool. It also builds the kernel
> because I didn't setup kernelci for it, so in short I get a complete
> config, build, test setup via 'srt-build bbb lava'

Maybe just the 'RT' config fragment will be enough.

Thanks, Chris

> 
> Thanks,
> Daniel
