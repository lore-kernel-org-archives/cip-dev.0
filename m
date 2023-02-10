Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46603C636CD
	for <webhook@archiver.kernel.org>; Fri, 10 Feb 2023 11:18:25 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web11.11856.1676027899025642634
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 10 Feb 2023 03:18:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=dCpGmZ6Y;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id s89-20020a17090a2f6200b0023125ebb4b1so5196530pjd.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 10 Feb 2023 03:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JT0XJgSlk01rsGkDC08xV7/IQePTVfCBbL5/KCFPxTg=;
        b=dCpGmZ6YmxtnsXfnyrt4hne3NaebDCx1TQhgSjB/W2HX9vME7u8hBu9Ax2CB7gZMgL
         BteEzWI1bswSSbL3PZqABtSceBX8tdV6oQfOszePV5d8/yFeNfO1Yqx6NDq8etf4kTSM
         InDzdUBivlblhUWhI1uShcnyqiFLHTBvdpN+zGa6FiaXoaoPoEGqtEyToIvjCUB4HQaD
         lY7VUd6meaylv37aYBvZ8yIcXwkH56akXvK6RdJ6YpUco2n+ks9bI3xrkv21JSTpNZ3H
         ZIUom4Mc7Pl5NHdeZY1EU9y4iFvuddaqdfuJKASylDU7Axv/44zT3NpCrLHGB/tVqDHM
         c4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JT0XJgSlk01rsGkDC08xV7/IQePTVfCBbL5/KCFPxTg=;
        b=4Tep3MKOaL+09une80zOP1h3OWxVLbQRBY0ndmg2Esy53+SP7lQ4NEf/CqHfsbE8j4
         jog2OZtggG2/LfFk3BFpu+AbFrMiGnoMxMy1ZkrB1FCC2j4yCDmJ91CV/ia6R6wNBtNG
         BHfT4MJKEfkpMuGuPbCjtHkqNspbBdN5n4R1I0hjfMWJ9jJXXq/mAQKkahq/7soA9m79
         hBz6Ti84G0i0A0sjP1BVnXx09vr1bEj9fIpVy7Gm3wzT/3zJZHlxklCGRxDY40Vk36Ev
         jMkQgQlaZL7p/c+sr24xhNui4lc3+UHw2kgWjv1JABF5YtNG/GBieFfqOQOM0ZCk8RBw
         hIiw==
X-Gm-Message-State: AO0yUKUwRM6YMNTcNWBw/gLyAWedcKsiHBD6fVHt6ZitZuOMRMIoZSxJ
	HnmxAFLLbg2W/CY7n38n4YjCHD4aubILWn48Zdx+Og==
X-Google-Smtp-Source: AK7set/5VDxxcG04a5PjJEu7E1JKBpWx+iYZL+KnnWqvvuWF23J4toW/1QUWDGIercpOpamCxUmHew==
X-Received: by 2002:a17:90b:4c42:b0:233:457f:e71e with SMTP id np2-20020a17090b4c4200b00233457fe71emr4119561pjb.25.1676027898111;
        Fri, 10 Feb 2023 03:18:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c7-20020a17090a674700b00230befd3b2csm5013405pjm.6.2023.02.10.03.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 03:18:17 -0800 (PST)
Message-ID: <63e627f9.170a0220.c0aaa.9a2f@mx.google.com>
Date: Fri, 10 Feb 2023 03:18:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.272-cip91
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip baseline: 83 runs,
 10 regressions (v4.19.272-cip91)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Feb 2023 11:18:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10640

cip/linux-4.19.y-cip baseline: 83 runs, 10 regressions (v4.19.272-cip91)

Regressions Summary
-------------------

platform                   | arch  | lab         | compiler | defconfig    =
                | regressions
---------------------------+-------+-------------+----------+--------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie | gcc-10   | defconfig    =
                | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie | gcc-10   | defconfig+arm=
64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie | gcc-10   | defconfig    =
                | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie | gcc-10   | defconfig+arm=
64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie | gcc-10   | cip://4.19.y-=
...64_defconfig | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie | gcc-10   | defconfig    =
                | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie | gcc-10   | defconfig+arm=
64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie | gcc-10   | defconfig    =
                | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie | gcc-10   | defconfig+arm=
64-chromebook   | 1          =

r8a7743-iwg20d-q7          | arm   | lab-cip     | gcc-10   | shmobile_defc=
onfig           | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.272-cip91/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.272-cip91
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a308535fd0f82d23c6acc4bb20c69066ca01bdd6 =



Test Regressions
---------------- =



platform                   | arch  | lab         | compiler | defconfig    =
                | regressions
---------------------------+-------+-------------+----------+--------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/63e61f440f9c3dae858c8651

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e61f440f9c3dae858c8=
652
        failing since 255 days (last pass: v4.19.237-cip71, first fail: v4.=
19.245-cip74) =

 =



platform                   | arch  | lab         | compiler | defconfig    =
                | regressions
---------------------------+-------+-------------+----------+--------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie | gcc-10   | defconfig+arm=
64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63e622dd91e6e4474b8c8730

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e622dd91e6e4474b8c8=
731
        failing since 244 days (last pass: v4.19.237-cip71, first fail: v4.=
19.246-cip75) =

 =



platform                   | arch  | lab         | compiler | defconfig    =
                | regressions
---------------------------+-------+-------------+----------+--------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/63e61f30f734c2dfca8c86f9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-ue=
fi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-ue=
fi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e61f30f734c2dfca8c8=
6fa
        failing since 255 days (last pass: v4.19.237-cip71, first fail: v4.=
19.245-cip74) =

 =



platform                   | arch  | lab         | compiler | defconfig    =
                | regressions
---------------------------+-------+-------------+----------+--------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie | gcc-10   | defconfig+arm=
64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63e6231cc634e0a6e68c8692

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e6231cc634e0a6e68c8=
693
        failing since 244 days (last pass: v4.19.237-cip71, first fail: v4.=
19.246-cip75) =

 =



platform                   | arch  | lab         | compiler | defconfig    =
                | regressions
---------------------------+-------+-------------+----------+--------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie | gcc-10   | cip://4.19.y-=
...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63e620fc7c4251a39f8c8630

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: cip://4.19.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/arm64/cip---4.19.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie=
/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/arm64/cip---4.19.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie=
/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e620fc7c4251a39f8c8=
631
        failing since 255 days (last pass: v4.19.235-cip70, first fail: v4.=
19.245-cip74) =

 =



platform                   | arch  | lab         | compiler | defconfig    =
                | regressions
---------------------------+-------+-------------+----------+--------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/63e61f470f9c3dae858c865a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e61f470f9c3dae858c8=
65b
        failing since 255 days (last pass: v4.19.237-cip71, first fail: v4.=
19.245-cip74) =

 =



platform                   | arch  | lab         | compiler | defconfig    =
                | regressions
---------------------------+-------+-------------+----------+--------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie | gcc-10   | defconfig+arm=
64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63e62305c634e0a6e68c868e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e62305c634e0a6e68c8=
68f
        failing since 244 days (last pass: v4.19.237-cip71, first fail: v4.=
19.246-cip75) =

 =



platform                   | arch  | lab         | compiler | defconfig    =
                | regressions
---------------------------+-------+-------------+----------+--------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/63e61f460f9c3dae858c8654

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-ue=
fi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-ue=
fi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e61f460f9c3dae858c8=
655
        failing since 255 days (last pass: v4.19.237-cip71, first fail: v4.=
19.245-cip74) =

 =



platform                   | arch  | lab         | compiler | defconfig    =
                | regressions
---------------------------+-------+-------------+----------+--------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie | gcc-10   | defconfig+arm=
64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63e6231a151278ba978c8649

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e6231a151278ba978c8=
64a
        failing since 244 days (last pass: v4.19.237-cip71, first fail: v4.=
19.246-cip75) =

 =



platform                   | arch  | lab         | compiler | defconfig    =
                | regressions
---------------------------+-------+-------------+----------+--------------=
----------------+------------
r8a7743-iwg20d-q7          | arm   | lab-cip     | gcc-10   | shmobile_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e61dffdcee46cc2c8c868b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e61dffdcee46cc2c8c8=
68c
        new failure (last pass: v4.19.271-cip90) =

 =20

