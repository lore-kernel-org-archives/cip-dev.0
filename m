From: pavel@denx.de (Pavel Machek)
Date: Thu, 16 Jan 2020 14:25:27 +0100
Subject: [cip-dev] RT Testing
In-Reply-To: <TYAPR01MB2285FB4BDC74EB669E362E89B7340@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <TYAPR01MB2285FB4BDC74EB669E362E89B7340@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <20200116132526.GA14898@duo.ucw.cz>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> Addressing this email to all of you as both RT and CIP Core are involved.
> 
> I started to look into RT testing in more detail today.
> 
> I've created an RT configuration for the RZ/G1 boards:
> https://gitlab.com/patersonc/cip-kernel-config/blob/chris/add_renesas_rt_configs/4.4.y-cip-rt/arm/renesas_shmobile-rt_defconfig
> I'll do something similar for the RZ/G2 boards soon.
> 
> Built it with linux-4.4.y-cip-rt and run cyclic test:
> https://lava.ciplatform.org/scheduler/job/9828
> Times look okay to an rt-untrained eye:
> T: 0 ( 1169) P:98 I:1000 C:  59993 Min:     13 Act:   16 Avg:   16 Max:      33
> 
> Compared to a run with linux-4.4.y-cip:
> https://lava.ciplatform.org/scheduler/job/9829
> T: 0 (  938) P:98 I:1000 C:   6000 Min:   1618 Act: 9604 Avg: 9603 Max:   14550
> 
> Pavel, does the above look okay/useful to you? Or is cyclictest not worth running unless there is some load on the system?
>

Even basic cyclictest is good to have, but it would be really good to
have some kind of background load. I'd expect latency to raise by
factor of 3 in make -j 5 of kernel.

I tried to come up with simpler test reproducing comparable latencies,
but I did not get there. This creates cca factor of two for me:

cat /dev/urandom | head -c 10000000 | gzip -9 - > delme.random.gz
echo "Initial phase done"
for A in `seq 222`; do
    ( zcat delme.random.gz | gzip -9 - | zcat > /dev/null; echo -n [$A done] ) &
done

What is easily available on the test systems? gzip? python? bzip2?

Best regards,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20200116/e96de03b/attachment.sig>
