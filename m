From: pavel@denx.de (Pavel Machek)
Date: Mon, 15 Jul 2019 10:41:30 +0200
Subject: [cip-dev] RT testing
In-Reply-To: <TYAPR01MB2285F72DD7C51D8D1E2C38B3B7F10@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <TYAPR01MB2285F72DD7C51D8D1E2C38B3B7F10@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <20190715084130.GA27894@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

(List added to the cc).

> Here are the links I was pasting into the Zoom chat regarding RT testing.

Thanks for all the help!

I got -cip-rt kernel to work on EBV Socrates, and it seems to be
suitable machine for testing. Latencies are under 70 usec under normal
loads. They go up-to 150 usec in longer tests and under very heavy
loads... These results are also consistent with osdal data:
https://www.osadl.org/Latency-plot-of-system-in-rack-7-slot.qa-latencyplot-r7s5.0.html?shadow=1

On iwg20m, I was getting 299 usec on cyclictest alone (job/1726) and
some mysterious 2000usec+ latencies on 4.19.50-cip3-rt1 (job/1797). I verified
Thinkpad X60 is not suitable due to hwlat. Thinkpad T40p is somehow
more promising (nothing detected by hwlat), but latencies cyclictest
is often in 500 usec range, and I have seen 755 usec with
4.4.176-cip31-rt23.

So.. EBV Socrates seems like best board to test on. Fortunately we
have very similar board in the lab:
https://lava.ciplatform.org/scheduler/device_type/Altera-Terasic-Deo-Nano
.

I believe we should do the following steps:

1) Add -rt configuration for socfpga to cip-kernel-config repositories
   (me)

2) Enable CONFIG_HIGH_RES_TIMERS=y in all configs (realtime or not) so
   we have comparison (me)

3) Prepare rt and non-rt kernels for socfpga. (I can do it one time,
   but it would be good to do it automatically as part of checkin tests).

4) Tune cyclictest (length of test, background load) so that it
   reproduces cca 100 usec latency on socfpga. If we set threshold to
   cca 200 usec, it should consistently fail on non-RT_FULL
   configurations. (I'll need help).

Best regards,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190715/9643f7e5/attachment.sig>
