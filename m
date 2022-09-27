Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5322DC6FA83
	for <webhook@archiver.kernel.org>; Tue, 27 Sep 2022 10:32:43 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web11.9401.1664274762978688073
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 27 Sep 2022 03:32:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=a77d5YkH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id fs14so8841661pjb.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 27 Sep 2022 03:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=BuIAUk4IZkLIl/FYqx/gJ3xJHTaGMvUSKikn87/Ftbs=;
        b=a77d5YkHb/+XxfpdRHL51M7SAYZi4NSKEWrDIDpOzF5bNPjiMARqz5oQiZKLz7X8Up
         +DzmSwl3jZCd+COmdd5Xh03tepte1XckFFihMzCv2Z7lnPkKv+pvPtzqGicnN6pyS+Lh
         qRDwOIAglqZd16WLDQSiZrXP1VIQJcbXS+2dlfvLw+A0ytzIISpb44bTL1cMEGjIwTke
         IKq2bTcp6ntt89ym9X0n1sEuTMXUjMmSmwMBLVCHsKa/qSwKxRHYmgglnpQ/7JRsM8Xk
         +c8oxvp6F9599NVF06HqZZeoAjMN8Y2AaiS1s5RloQxp6rq8cQdhOYHhhB8A1MMg78ya
         f9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=BuIAUk4IZkLIl/FYqx/gJ3xJHTaGMvUSKikn87/Ftbs=;
        b=c7zMYbhAlPKJUDOsYYvIGYDfCSTZmqBF5/ZfplPCK41mBF08MG8N/qYWPgd8Xrcja6
         2osv02q6ZSGOE5ij1QaYn2S0V/u8iyFpdaNHT1X/QtKKL0EDksc+UMXfVPTsGac3P9t6
         Pma7OzQORi8WdXI1Ge3yyvqa/xCHa36UgNaVDdQqxLkgcQRszbflpZ+t11aXimkXGJCJ
         SA1qDIpmtwO7rTXZHrA+wUV+eanmO5GHiltxDVCkpO3jVCg0BFpZJmwLag7AEgpFXyK4
         wVr/P61z8/1IRnXFtBONpT+lzu790c+eSzjBN8mOwvum0ieHlfmtgcvQvJIkQE5BHwUd
         BGAA==
X-Gm-Message-State: ACrzQf3XMxgFvj8XimuRhtr/UXhFAj92/WpBw1josubKRtnNOXIQ2FDJ
	fqM3XpUdU9+KD2CZqiNnSVHJzXwQ5HS1qqZy
X-Google-Smtp-Source: 
 AMsMyM6nwTY7kvpfIuOxefj0ncolvNXPssmEeUxv1STTEKDnWFt+lTYseN2k6MEb/F/cuCFvK1V5jw==
X-Received: by 2002:a17:902:dac2:b0:178:4dd9:277e with SMTP id
 q2-20020a170902dac200b001784dd9277emr26892857plx.107.1664274762249;
        Tue, 27 Sep 2022 03:32:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 n11-20020a170902d2cb00b001714c36a6e7sm1243716plc.284.2022.09.27.03.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 03:32:41 -0700 (PDT)
Message-ID: <6332d149.170a0220.c7c1c.1b0e@mx.google.com>
Date: Tue, 27 Sep 2022 03:32:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.259-cip82
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip smc: 8 runs, 4 regressions (v4.19.259-cip82)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Sep 2022 10:32:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9561

cip/linux-4.19.y-cip smc: 8 runs, 4 regressions (v4.19.259-cip82)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.259-cip82/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.259-cip82
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      91f283faebd1a92efc2cfe0a3de7c568c87e5ee5 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6332cb3cf30dff5662ec4eae

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.259=
-cip82/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.259=
-cip82/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/6332cb3cf30dff5662=
ec4eba
        failing since 80 days (last pass: v4.19.249-cip76, first fail: v4.1=
9.251-cip77)

    2022-09-27T10:06:39.943540  <8>[   11.258565] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/6332cb3cf30dff5662=
ec4ebb
        failing since 80 days (last pass: v4.19.249-cip76, first fail: v4.1=
9.251-cip77)

    2022-09-27T10:06:39.932695  <8>[   11.247728] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6332bc9aab8aaa162aec4eb0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.259=
-cip82/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/smc-qemu_arm64=
-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.259=
-cip82/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/smc-qemu_arm64=
-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/6332bc9aab8aaa162aec4eb1
        failing since 35 days (last pass: v4.19.226-cip66, first fail: v4.1=
9.255-cip79) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6332c174bc0b98561cec4eaa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.259=
-cip82/arm64/defconfig/gcc-10/lab-collabora/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.259=
-cip82/arm64/defconfig/gcc-10/lab-collabora/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/6332c174bc0b98561cec4eab
        failing since 35 days (last pass: v4.19.226-cip66, first fail: v4.1=
9.255-cip79) =

 =20

