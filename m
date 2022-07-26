Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B17C00144
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 15:24:34 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.8110.1658849068094509698
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 26 Jul 2022 08:24:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=TPGGfRBb;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id g17so13648757plh.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 26 Jul 2022 08:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=lHjIVnFevUaFA6JAsPC6yCIIEHaFMJa+7ui25rylWh4=;
        b=TPGGfRBb7hswax0Cd3dhu+yFQMji/eKFXRzy8PlOfqgtmEvzMuHj1oswNQSTh2wnfz
         S0ri6v5mXa8B3a3t0zAUFwePa+Tp9bda2hB54FKG1tzQkuvOkzVyTI4pU460SMbin8PG
         o+Ed5rSIOGspvsq4UsMmn+cBFGHwvcdPvcxYXkxK2cczBZb9teyuwRrhI9zyhT+7Gwvh
         /j+XO+u5m6FIw2dfX6MXdxLZbHuQALDy/Emt9esNw/1UXdxw//MX8JLcBJv1Qhyf7UGH
         yeRDye661eQGiJQgH9D8x9liFH2R5DqJCnRS2+JURcSmMRLCtSoGjyOUQdLHNS+WLozy
         YZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=lHjIVnFevUaFA6JAsPC6yCIIEHaFMJa+7ui25rylWh4=;
        b=5Pmp99P0Jl8CEDwqSWyUZ+kN0KlU6tAfkihjKRNIakIoXsJya48FbGMWtkY0o5rs8n
         V3s5fTt4EECBy54n75o1C2ZYg8BXvdL0LHbqpIT8AkMLipXbgK5yE/3n6o2XHDuZNBUC
         utKz2c8sAyqC8znI6oTysEoT/OC6YCVjBpZJ2LPQuMku49G+waFyFsmJ+arwkc8f5jX2
         oBzeMB2VeEu+T9BNLcNd1Iw1oOYbJHtbqF0db5BREhC7Hy+N/y2VPrnEaL6ZuRhdiAsq
         zKvJhncM6f7QXNsMD6N063qNPymtc1xu+CB8HfSzLMf0kbWp1v39lwv4DuWcS48tV9cb
         NoBw==
X-Gm-Message-State: AJIora8DakqlIYzX5MgAvk1bzkSc9JCX+mtHp4vrq/YtI7hv7CQ04snJ
	xIl86DQvXqgwiQZ6hVP5UNk0VUOebYzIcye6
X-Google-Smtp-Source: 
 AGRyM1t5LJy1/XEQfEHbm02BInthStn0zyIaS0ZJHtLJvebtyp8bN5z54ROINnfZiBgmTBtN5jB6OQ==
X-Received: by 2002:a17:902:ab13:b0:16c:bc10:85a9 with SMTP id
 ik19-20020a170902ab1300b0016cbc1085a9mr17168129plb.7.1658849067428;
        Tue, 26 Jul 2022 08:24:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 q13-20020a65684d000000b00419cde333eesm10273022pgt.64.2022.07.26.08.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:24:27 -0700 (PDT)
Message-ID: <62e0072b.1c69fb81.c579.fdc7@mx.google.com>
Date: Tue, 26 Jul 2022 08:24:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-36-g21d9d56f4de5a
Subject: cip/linux-5.10.y-cip smc: 12 runs,
 6 regressions (v5.10.129-cip12-36-g21d9d56f4de5a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 15:24:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8939

cip/linux-5.10.y-cip smc: 12 runs, 6 regressions (v5.10.129-cip12-36-g21d9d=
56f4de5a)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.129-cip12-36-g21d9d56f4de5a/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.129-cip12-36-g21d9d56f4de5a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      21d9d56f4de5acd415b12aecf82f754e9e6065fb =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/62dff48c2d8c9667f5daf067

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/62dff48c2d8c9667f5=
daf073
        failing since 22 days (last pass: v5.10.125-cip10, first fail: v5.1=
0.126-cip11)

    2022-07-26T14:04:39.515574  <8>[   12.741090] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/62dff48c2d8c9667f5=
daf074
        failing since 22 days (last pass: v5.10.125-cip10, first fail: v5.1=
0.126-cip11)

    2022-07-26T14:04:39.496981  <8>[   12.722773] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62dff931db2a61c5a1daf06d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62dff931db2a61c5a1daf06e
        new failure (last pass: v5.10.83-cip1-178-g2cf1d12aab81) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/62dffc792ff5ccd292daf089

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62dffc792ff5ccd292daf08a
        failing since 28 days (last pass: v5.10.112-cip6, first fail: v5.10=
.125-cip10) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62dff8eb1b6fdf9c00daf083

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62dff8eb1b6fdf9c00daf084
        new failure (last pass: v5.10.83-cip1-178-g2cf1d12aab81) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/62dff41eeb6d23a6a2daf056

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/x86_64/x86_64_defconfig/gcc-10/lab-collabora/smc-q=
emu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/x86_64/x86_64_defconfig/gcc-10/lab-collabora/smc-q=
emu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/62dff41eeb6d23a6a2=
daf058
        new failure (last pass: v5.10.129-cip12-12-g93db31b19404)

    2022-07-26T14:02:57.387971  <8>[    2.384499] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2020-0543 RESULT=3Dfail>   =

 =20

