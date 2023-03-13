Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308D5C6FD1C
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 13:31:15 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.19380.1678714269011491424
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 13 Mar 2023 06:31:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=nl4EAc3k;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id a9so12903637plh.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 13 Mar 2023 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678714268;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6rKY0+1gXfAfQCQn93jITVtroV8We0gWj1OxXoGJZZ8=;
        b=nl4EAc3kK4GcGY2vHbt4Ecj28AxaDc3M35eWz95z3sQK8s8PdAm42XOGlwgXAG35zy
         zI5VUOKX2HNU/hmyIaQJuvL93bI8vUF4hBxh9K3kn8FdxfYCgkWc9Ih1iZreGcj5c+G/
         4jufQYkVQ6NawbWN6AtXzXGpLnbDZ1tFai3IfqnmwpMUwr8ZCiZcfNi6rpATHg0Q1b3E
         QBq5qKkD+MJWnTHiYY4FqQnTuN5kubUuIPmh7+43286WRYMHPdXxiQDDDZVRR16veIYn
         g5a9A1PN2xaa/4GnaIaVTkEp4w874nppa2jYLSoUACSRR8P3ToVaWcmW9hq9EgiuYWnU
         +2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678714268;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6rKY0+1gXfAfQCQn93jITVtroV8We0gWj1OxXoGJZZ8=;
        b=4Dc2mSdxy6AfNIPyiHt1IPbUzslzu0MHvWtDxrNXXC16U+vffuzyrxEkTI3BGFYcWs
         B5daUi1O/C3MYPOUUWBfbmg6dQcgJ8DYjyNHID6yB+qf7sLbOfOK+lm//mNl1Zr3gIXs
         HC68AAaTRHmWxU4UE/RHeNscGFw5YKl1GODat5taB3kGlAr9AD1KVs9njxZLQX+KgzON
         MMOggvtJhCHLELibrcVdGDQ/ATkeBfMTWqKpJvUjHVY/yOCdzHKetF5oDiqy3Co4fZWY
         6O/8vI3G3CjkGlzk3g4qqM8vvmbaaQPR1hFmdWXF3fUaRoIREv7oy4s6IyNcSyluEg4f
         cfmw==
X-Gm-Message-State: AO0yUKWzcLMQGsNSgtmb6Orh7Ro7YaZZeNPAkDU18UHydhkUx5Dyw1+X
	H/30xKK/6tuALT2D4SGAGsKns2mXUsHaM/FC8E7F/YAe
X-Google-Smtp-Source: AK7set+4kt2BpQuwcM033pmf/eelPH8ZeKwxGr4yn0jo2loFg1iXIK7yqocP0K2VKLrfs5JBbGO9iQ==
X-Received: by 2002:a05:6a20:918a:b0:cd:9664:3d5a with SMTP id v10-20020a056a20918a00b000cd96643d5amr37885878pzd.22.1678714267901;
        Mon, 13 Mar 2023 06:31:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p4-20020a62ab04000000b005e099d7c30bsm4377499pff.205.2023.03.13.06.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 06:31:07 -0700 (PDT)
Message-ID: <640f259b.620a0220.f847b.6b75@mx.google.com>
Date: Mon, 13 Mar 2023 06:31:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.173-cip28
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-timers: 7 runs,
 10 regressions (v5.10.173-cip28)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Mar 2023 13:31:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11009

cip/linux-5.10.y-cip ltp-timers: 7 runs, 10 regressions (v5.10.173-cip28)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.173-cip28/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.173-cip28
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2988848bfa1d1f2c02318f2193b06874fb5f62eb

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3cbaaddf6f785d91aeb370beb75d0623f8c48624 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/640f1a0059f9b886c88c864a

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230303.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640f1a0059f=
9b886c88c864f
        failing since 86 days (last pass: v5.10.158-cip22, first fail: v5.1=
0.158-cip22-7-g92462fd9830b) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640f1a0059f=
9b886c88c864f
        failing since 86 days (last pass: v5.10.158-cip22, first fail: v5.1=
0.158-cip22-7-g92462fd9830b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/640f1a75186f7906a18c8644

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230303.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640f1a75186=
f7906a18c8649
        failing since 40 days (last pass: v5.10.162-cip24, first fail: v5.1=
0.165-cip25) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640f1a75186=
f7906a18c8649
        failing since 40 days (last pass: v5.10.162-cip24, first fail: v5.1=
0.165-cip25) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/640f1b2ac0ccdb3fc68c86cf

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230303.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640f1b2ac0c=
cdb3fc68c86d4
        failing since 30 days (last pass: v5.10.165-cip25, first fail: v5.1=
0.167-cip26) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640f1b2ac0c=
cdb3fc68c86d4
        failing since 30 days (last pass: v5.10.165-cip25, first fail: v5.1=
0.167-cip26) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/640f2506a7a14440298c865b

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230303.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640f2506a7a=
14440298c8660
        failing since 129 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640f2506a7a=
14440298c8660
        failing since 129 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/640f21e5e71d360a0f8c8643

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230303.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640f21e5e71=
d360a0f8c8648
        failing since 129 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640f21e5e71=
d360a0f8c8648
        failing since 129 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =

 =20

