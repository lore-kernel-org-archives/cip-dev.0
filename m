Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38655C4167B
	for <webhook@archiver.kernel.org>; Sun, 11 Dec 2022 20:20:25 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.26093.1670790019994973037
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 11 Dec 2022 12:20:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=nvod24Oy;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id w23so10005514ply.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 11 Dec 2022 12:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U+SCw7fs3kovpmI4BenK4v+o/kh3tcfakyyL8pLh+VA=;
        b=nvod24Oy6+5NxIWxmBgcpx3eLC8Pr563i/3aaiDnnoLO0zZyJozEkxtKVG1Xj86g35
         W8IQlC7RIq0G0/EfBeZGFT2OcUwlKqGJ9qUcSUY10vKMiV7KWeDpHgZNTdPMUkb65PCJ
         HjszlXLBEpKTEfCqtBx8R4rexvTQ9OL1ulX6iO6aX96Xc1dpX7+tBKdey8gjYyijyeat
         W+KbV8zE/qwW6BKlwJs08acAE3jsesoBZ0IsgUhWIoyCszQiJOws34EIeOU7NywMkQO2
         0F3G9H7g3tt9BBG2Hhsh9t1kJP0MpmM5DrQtZKptI3olE8xK9GuLAP+ZyKYuRexax88D
         yYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+SCw7fs3kovpmI4BenK4v+o/kh3tcfakyyL8pLh+VA=;
        b=dJHwjakQYYjyDOpmEnUi5Obsz/kDkn6YnughEQCbd03Z2vHOT7hkMTPHHw29DJUjQH
         tYQ1nds/j4cusVNQOO8LqqgelzFhfS27vo1qjtnyYExY0ddqU5D20hxMF+tUH7fZE1Si
         C6joBL/CQyyPVVm8To2FM3ep4U7h62gTcBzIuiDBrsp72SWvIQVnIVyHenvdDUscQ3v1
         09xPEFvIKpJ7E4iWiJwPRttPUG2SYlkbfRt9vwl72Q9obcZ+u8KvJi4kowcVAmtIJ6JA
         PRPJ2Zg8YHxBaV3YwbNvVXsYNkhG8G6LseeF6ZG80eFmlcl0hnjbdB/dB905y4Lo6VEK
         XgLw==
X-Gm-Message-State: ANoB5pnXOzEL3gmYp7FS8LWTOdP38p9tzHDKzhqY+MayDfbyb9QV37nQ
	gbPlzgGUZOzeGtuurFCMUibcO2Jo/wUa/x5WNvU=
X-Google-Smtp-Source: AA0mqf67Cw059K4BT79eIAWNTc1s5nPh1vPsanimFPl5Yilhx7adCGsC2ayA5qnrux7k6TxJZ8BQPw==
X-Received: by 2002:a17:90b:4f89:b0:213:5c5f:f449 with SMTP id qe9-20020a17090b4f8900b002135c5ff449mr15910869pjb.45.1670790018184;
        Sun, 11 Dec 2022 12:20:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 36-20020a17090a0fa700b00213ee5a12c9sm3992292pjz.55.2022.12.11.12.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 12:20:17 -0800 (PST)
Message-ID: <63963b81.170a0220.fe0a2.7247@mx.google.com>
Date: Sun, 11 Dec 2022 12:20:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.158-cip22-rt9
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip-rt ltp-timers: 10 runs,
 16 regressions (v5.10.158-cip22-rt9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 11 Dec 2022 20:20:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10208

cip/linux-5.10.y-cip-rt ltp-timers: 10 runs, 16 regressions (v5.10.158-cip2=
2-rt9)

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

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 2          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+p=
reempt_rt         | 2          =

rk3288-veyron-jaq         | arm    | lab-collabora | gcc-10   | defconfig  =
                  | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.158-cip22-rt9/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.158-cip22-rt9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2c52868ae1cbccd8bfb24f6b41a5fd024c1ca7e8

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  e76de05a93390f5ec7fae2941d8f24d367c9b2b8 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =


  Details:     https://kernelci.org/test/plan/id/63962acc9eccd792532abd29

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-=
collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-=
collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221202.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63962acc9ec=
cd792532abd2e
        failing since 31 days (last pass: v5.10.145-cip17-rt7, first fail: =
v5.10.153-cip19-rt8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63962acc9ec=
cd792532abd2e
        failing since 31 days (last pass: v5.10.145-cip17-rt7, first fail: =
v5.10.153-cip19-rt8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =


  Details:     https://kernelci.org/test/plan/id/63962798e65de572592abcff

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221202.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63962798e65=
de572592abd04
        failing since 31 days (last pass: v5.10.145-cip17-rt7, first fail: =
v5.10.153-cip19-rt8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63962798e65=
de572592abd04
        failing since 31 days (last pass: v5.10.145-cip17-rt7, first fail: =
v5.10.153-cip19-rt8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =


  Details:     https://kernelci.org/test/plan/id/63962ab8c87e1ce5092abcfd

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-=
collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-=
collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221202.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63962ab8c87=
e1ce5092abd02
        failing since 31 days (last pass: v5.10.145-cip17-rt7, first fail: =
v5.10.153-cip19-rt8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63962ab8c87=
e1ce5092abd02
        failing since 31 days (last pass: v5.10.145-cip17-rt7, first fail: =
v5.10.153-cip19-rt8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =


  Details:     https://kernelci.org/test/plan/id/63962b78f2ff650b8f2abd00

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221202.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63962b78f2f=
f650b8f2abd05
        failing since 31 days (last pass: v5.10.145-cip17-rt7, first fail: =
v5.10.153-cip19-rt8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63962b78f2f=
f650b8f2abd05
        failing since 31 days (last pass: v5.10.145-cip17-rt7, first fail: =
v5.10.153-cip19-rt8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =


  Details:     https://kernelci.org/test/plan/id/63962f04bdf41c66292abd08

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-=
collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-=
collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221202.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63962f04bdf=
41c66292abd0d
        failing since 31 days (last pass: v5.10.145-cip17-rt7, first fail: =
v5.10.153-cip19-rt8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63962f04bdf=
41c66292abd0d
        failing since 31 days (last pass: v5.10.145-cip17-rt7, first fail: =
v5.10.153-cip19-rt8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 2          =


  Details:     https://kernelci.org/test/plan/id/63962b99f2ff650b8f2abd25

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg=
2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg=
2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221202.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63962b99f2f=
f650b8f2abd30
        new failure (last pass: v5.10.153-cip19-rt8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63962b99f2f=
f650b8f2abd30
        new failure (last pass: v5.10.153-cip19-rt8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+p=
reempt_rt         | 2          =


  Details:     https://kernelci.org/test/plan/id/63963341879e4f3fd82abd0b

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/arm64/defconfig+preempt_rt/gcc-10/lab-cip/ltp-timers-r8a774a1=
-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/arm64/defconfig+preempt_rt/gcc-10/lab-cip/ltp-timers-r8a774a1=
-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221202.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63963341879=
e4f3fd82abd16
        new failure (last pass: v5.10.153-cip19-rt8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63963341879=
e4f3fd82abd16
        new failure (last pass: v5.10.153-cip19-rt8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora | gcc-10   | defconfig  =
                  | 2          =


  Details:     https://kernelci.org/test/plan/id/639630bfdef888c1162abd15

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/arm/defconfig/gcc-10/lab-collabora/ltp-timers-rk3288-veyron-j=
aq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/arm/defconfig/gcc-10/lab-collabora/ltp-timers-rk3288-veyron-j=
aq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221202.0/armhf/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/639630bfdef=
888c1162abd1a
        failing since 31 days (last pass: v5.10.145-cip17-rt7, first fail: =
v5.10.153-cip19-rt8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/639630bfdef=
888c1162abd1a
        failing since 31 days (last pass: v5.10.145-cip17-rt7, first fail: =
v5.10.153-cip19-rt8) =

 =20

