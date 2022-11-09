Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC78C43217
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 23:17:56 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web09.444.1668035875209348455
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 09 Nov 2022 15:17:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=mGEhoCER;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso4672295pjn.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 09 Nov 2022 15:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sV+8/oQb5v+wxQ5mAFFxTenqqXbSWOWPvbhlAAJshh8=;
        b=mGEhoCERSC/jbseldBZsd/WANz4u9g6Agqdmi5jZkj5lv+Y7GKgg0v5meAn6CUr7EU
         lqMHyVCASNPn1yMaLwnHtmjhVUZoqtnJbnIpB1llrDv4VbfWVMKbuZlr0J/ezntGmYL/
         PEH50bF8E7DFlWLFaLcLnTsMR4TkDomfbsEgJWvh7zKEE2WIrhPaEf3f+vf4eHpuIytK
         6K4sB10zwqHMUg2YBzCAbppaBsM8ZZ4v0lcqI3JyfgMRt/DtM3V0viW4BIXEMDOUO51K
         blt4QaYy9vYkfPOf7xgks+rS48BTBoTss3iGreXYbDbQwV0yU9e9qSeLr10fiIV8UQRS
         a2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sV+8/oQb5v+wxQ5mAFFxTenqqXbSWOWPvbhlAAJshh8=;
        b=GoSiBn478K4siLCSRcGpkS4rz7zjjgQAqHryoWS44sS8cbwGYeJn2R4C449b3Owsjp
         siZUhjGyXde3jmLXkKYG0TmWNoHurtdw3Gl8jUzz73dmgzX0kMHqx6T4sn6HxV+88E/3
         BheqQpmn3qvnFMt5D9+m+WBWLIkoN2TONHykcyLAtf5EUAHfle0vn0hmDUpYLbCnqbGe
         8SyfGyR+JdINO9osJK4WDMKKlkd6r33KC2RTnnsejfjc+KIWj5GxFUY+nyfye/M7FJ29
         lc5aUrKPlKo0PfpfsYpbYsuKS/TzisK9QE0ii1DughM4uYTNAUY4FzeFuY/5dDBmNhrY
         vr1Q==
X-Gm-Message-State: ACrzQf0Dvgpf/ZNWRNoUBfpJLfauhCdzpGid5yGQBZrQ/OgxcSguA24X
	UVs95os47oO4/jpG2WM2cPPKLuuGJunlK4Ho9Vo=
X-Google-Smtp-Source: AMsMyM7Yh1OZlrpjfH8yQIsjFpPhMp4phMjG6D47/7Eq112v/woB73yf8FRT4PAZrr5vlz9iytkWFg==
X-Received: by 2002:a17:90a:7e14:b0:210:dcec:ffe9 with SMTP id i20-20020a17090a7e1400b00210dcecffe9mr65301186pjl.157.1668035874377;
        Wed, 09 Nov 2022 15:17:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a9-20020a1709027e4900b00187022627d8sm9595070pln.62.2022.11.09.15.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 15:17:54 -0800 (PST)
Message-ID: <636c3522.170a0220.165a7.02e4@mx.google.com>
Date: Wed, 09 Nov 2022 15:17:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19-rt8
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip-rt ltp-timers: 11 runs,
 16 regressions (v5.10.153-cip19-rt8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 23:17:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9991

cip/linux-5.10.y-cip-rt ltp-timers: 11 runs, 16 regressions (v5.10.153-cip1=
9-rt8)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =

rk3288-veyron-jaq         | arm    | lab-collabora | gcc-10   | defconfig  =
                  | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.153-cip19-rt8/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.153-cip19-rt8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      4b5bf35ef58ec8f9f73fd6fec577de2f6710955f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  b79157c8375cfdd2abfc59f63afe8ea09eaa8c5d =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =


  Details:     https://kernelci.org/test/plan/id/636c24d86c6fdb4bdfe7db67

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-=
collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-=
collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636c24d86c6=
fdb4bdfe7db6c
        new failure (last pass: v5.10.145-cip17-rt7) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636c24d86c6=
fdb4bdfe7db6c
        new failure (last pass: v5.10.145-cip17-rt7) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =


  Details:     https://kernelci.org/test/plan/id/636c23a74295b74024e7db63

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636c23a7429=
5b74024e7db68
        new failure (last pass: v5.10.145-cip17-rt7) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636c23a7429=
5b74024e7db68
        new failure (last pass: v5.10.145-cip17-rt7) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =


  Details:     https://kernelci.org/test/plan/id/636c2862418c345842e7db54

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-=
collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-=
collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636c2862418=
c345842e7db59
        new failure (last pass: v5.10.145-cip17-rt7) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636c2862418=
c345842e7db59
        new failure (last pass: v5.10.145-cip17-rt7) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =


  Details:     https://kernelci.org/test/plan/id/636c24cd727fb59f7ae7db61

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636c24cd727=
fb59f7ae7db66
        new failure (last pass: v5.10.145-cip17-rt7) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636c24cd727=
fb59f7ae7db66
        new failure (last pass: v5.10.145-cip17-rt7) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =


  Details:     https://kernelci.org/test/plan/id/636c24f26c6fdb4bdfe7db81

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-=
collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-=
collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636c24f26c6=
fdb4bdfe7db86
        new failure (last pass: v5.10.145-cip17-rt7) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636c24f26c6=
fdb4bdfe7db86
        new failure (last pass: v5.10.145-cip17-rt7) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =


  Details:     https://kernelci.org/test/plan/id/636c238f69440fcbd0e7db4e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636c238f694=
40fcbd0e7db53
        new failure (last pass: v5.10.145-cip17-rt7) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636c238f694=
40fcbd0e7db53
        new failure (last pass: v5.10.145-cip17-rt7) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =


  Details:     https://kernelci.org/test/plan/id/636c241d9a130a6031e7dbb4

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-=
collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-=
collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636c241d9a1=
30a6031e7dbb9
        new failure (last pass: v5.10.145-cip17-rt7) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636c241d9a1=
30a6031e7dbb9
        new failure (last pass: v5.10.145-cip17-rt7) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora | gcc-10   | defconfig  =
                  | 2          =


  Details:     https://kernelci.org/test/plan/id/636c33b105f8dda771e7dc19

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/arm/defconfig/gcc-10/lab-collabora/ltp-timers-rk3288-veyron-j=
aq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
153-cip19-rt8/arm/defconfig/gcc-10/lab-collabora/ltp-timers-rk3288-veyron-j=
aq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/armhf/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636c33b105f=
8dda771e7dc1e
        new failure (last pass: v5.10.145-cip17-rt7) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/636c33b105f=
8dda771e7dc1e
        new failure (last pass: v5.10.145-cip17-rt7) =

 =20

