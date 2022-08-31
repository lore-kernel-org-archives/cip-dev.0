Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65588ECAAD4
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 13:22:41 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web10.25676.1661952151726343423
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 06:22:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=Qr4fTj/c;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id
 t11-20020a17090a510b00b001fac77e9d1fso21031132pjh.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 06:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=By9VNqa5E6pq6HFNXeTY2KD5iFF3K/i/+2LuB6a6WWQ=;
        b=Qr4fTj/cDf8ZtpvWxqjVvzAY6dAOWhlAzTVSaOniWEYAhb726/hOihwa7fO2OiBDeu
         BdjsJYxInxK+r3fj2PgwOmnXeIbiC/nNBnPsjQ9V+IWmhfRNueDbmGB1MweVThzUSLa7
         2G9B46qpg70kJZ/Bez+TGKHIllG7FTxKJEBha7iz3wzgycwqJEwYVXW3lK+RtdF7gG0p
         cIfqdpS9qV69kDLenmWc9jmnMyNDWM72sIETDi6UlyI/R4P7XGrLukxgbVeVncOMpUOr
         C2JSBKx9jochd6mqnPfAtyxSKRFK2iZsxnKJ+d0F90ymURh6Dta8vYwm/QaFlK+4ScJs
         ZC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=By9VNqa5E6pq6HFNXeTY2KD5iFF3K/i/+2LuB6a6WWQ=;
        b=HiYrfCMFzhkzSKhj2h7j0aKZUEqeoA4J7iRuGiswHFX19fU9LtVJ+cEzWTIs+4p7kA
         tMpxH57xGNj21vQ/iKIoyC+CNEdQCUfnhEwHp12AGwxyeLpZTHxAyMO9/KdJM3J0lCCl
         UKaglL2H3SOHJi7o7pqZShQ7Z1ubbSayHwIS3OmXJ3e9MThqZh48bs7EtbCg0DxMFbq4
         OtfpccRdqtsAP26cizY6HWQ6/+BFTGbhelGRm/6NQDV+//pwzUmg82unbdTAVWNSOJeO
         2zB5vZ2d6XgxN4BYz6XJ/MqMmgM+SCEIHt+Li3yKuZWwFD1ISuyf2x9LYglBTHZhanL+
         XjAg==
X-Gm-Message-State: ACgBeo39X3fA09/fe0jAmlAE8i4NAd4YEJfJeo2BGR+UuMrGMqF641Bc
	TkQ1s4jS3n634GoQArCM9WAf/1sYIagWv135uUw=
X-Google-Smtp-Source: 
 AA6agR4bGPsXQHt8/UGSGHa7KvYoBRCQ1Qv2Jm+QqfXT6LVvd2Gr3tx18NVMPozWVTdy6ejG5qsSng==
X-Received: by 2002:a17:903:24e:b0:172:6c9d:14e0 with SMTP id
 j14-20020a170903024e00b001726c9d14e0mr25688491plh.84.1661952151015;
        Wed, 31 Aug 2022 06:22:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 bf1-20020a170902b90100b00172a2a41064sm11460994plb.298.2022.08.31.06.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 06:22:30 -0700 (PDT)
Message-ID: <630f6096.170a0220.e4237.4979@mx.google.com>
Date: Wed, 31 Aug 2022 06:22:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.138-cip15
Subject: cip/linux-5.10.y-cip smc: 14 runs, 8 regressions (v5.10.138-cip15)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 13:22:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9344

cip/linux-5.10.y-cip smc: 14 runs, 8 regressions (v5.10.138-cip15)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.138-cip15/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.138-cip15
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f2d94917db95e02bef61288aba5b06e0dfef3a73 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/630f4e5ca1b0ecbb41355649

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/630f4e5ca1b0ecbb41=
355655
        failing since 58 days (last pass: v5.10.125-cip10, first fail: v5.1=
0.126-cip11)

    2022-08-31T12:04:23.917753  <8>[   13.235153] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/630f4e5ca1b0ecbb41=
355656
        failing since 58 days (last pass: v5.10.125-cip10, first fail: v5.1=
0.126-cip11)

    2022-08-31T12:04:23.899946  <8>[   13.217030] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/630f5121f3ca76aae2355650

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/630f5121f3ca76aae2355651
        failing since 27 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/630f53f3cc77696fe1355647

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/smc-qemu_arm64-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/smc-qemu_arm64-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/630f53f3cc77696fe1355648
        failing since 35 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/630f50c5efca3893983556b4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-collabora/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-collabora/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/630f50c5efca3893983556b5
        failing since 27 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/630f53e6a657d6edc835568d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/smc-qemu_arm64=
-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/smc-qemu_arm64=
-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/630f53e6a657d6edc835568e
        failing since 35 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/630f4b6278ffa3941b355662

  Results:     15 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-qemu=
_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-qemu=
_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/630f4b6278ffa3941b=
355664
        failing since 14 days (last pass: v5.10.131-cip13-37-ge3a52725ce96,=
 first fail: v5.10.131-cip13-49-g1145e9c6352e6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/630f4c5207faee24223556b8

  Results:     15 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/x86_64/x86_64_defconfig/gcc-10/lab-collabora/smc-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/x86_64/x86_64_defconfig/gcc-10/lab-collabora/smc-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/630f4c5207faee2422=
3556ba
        failing since 14 days (last pass: v5.10.131-cip13-37-ge3a52725ce96,=
 first fail: v5.10.131-cip13-49-g1145e9c6352e6)

    2022-08-31T11:55:52.797536  <8>[    2.592184] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2020-0543 RESULT=3Dfail>   =

 =20

