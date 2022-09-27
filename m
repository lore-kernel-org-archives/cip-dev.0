Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27898C6FA86
	for <webhook@archiver.kernel.org>; Tue, 27 Sep 2022 09:39:43 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web09.8913.1664271577423716156
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 27 Sep 2022 02:39:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=syu3fGED;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id b75so9187878pfb.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 27 Sep 2022 02:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=mVBYEbwP26TixhEZK81FCG6+KagndprCpSb9doAtAj4=;
        b=syu3fGEDJPed3wDC00eyFOw5vzUxbU4JAM/UR5ZHJ/33qSAaLtwJEQxlMGUf5JpVFU
         /boNb/O4jIDJZzwT8E65WJxgYPLrfud/JFhgemsNaF82YYw9WX8KQNJ8j19phTEzaWVo
         czImLx9tM7ihdKBgmUobLJI0El/5p+mLQLT9g8LW5h+/XWD4VDgysYZS7hjV/ecgzsXC
         kym0W2zwT36scrjBuKE3cVDmr/crwcpia4zC1AHWZdlPDRGJ4D0nfl2N3P8nJw5t0k3Y
         /Sh+PW/Yg21R2UY7laDEeR/3YL79Jxiz71NE26WrWas2nJFG99bwx/L05rVL0tUnKsed
         TLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=mVBYEbwP26TixhEZK81FCG6+KagndprCpSb9doAtAj4=;
        b=C/s3bJwAwYAxuhYAX7Td1kzvQNn20Ql5G+kK9bC0RW4xvI5k87+UFi/Y7hGSm3MI9E
         NAYXaWfBjleQBtMAy36D+rJmyLyA2iSMJ+WiPl2jzMooYBQUFwnsTX71KhkKSxA7arXu
         JkPmBCBd6btd60Wa7370yQHziTz3t4M3NpJqKPFCFSwikRYZwxV0slGE6EfpbzHKoW2d
         wzB4n5LHSuDy572Z9+lpU9NuNvP4lgWifKoioBCvWTScA89x2muAWt+PmDQOlv90iMyJ
         x+HPtomCXL9b5kuRgahbaIawCPZVlBUKHxEVtkdu0dLUfHwfdRGmRwCLibMR3ayv5CLS
         PzcQ==
X-Gm-Message-State: ACrzQf2Q2aaoL5F9UjSQRSLXgC08UbJcc6XxSq2CIpUA+efFmsSjjN9e
	yTVi49rV7jQ/MiDWbnN72+aHWyPh2ooXmQIK
X-Google-Smtp-Source: 
 AMsMyM7RxudcKidqEuR2Os243w67AEWvf7GDg4jk3YX+QuGozC27XfbwFUhiXFoctexua1d4vZ2SNg==
X-Received: by 2002:a05:6a00:2402:b0:52c:81cf:8df8 with SMTP id
 z2-20020a056a00240200b0052c81cf8df8mr28676438pfh.60.1664271576696;
        Tue, 27 Sep 2022 02:39:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 a9-20020aa794a9000000b0054a1534516dsm1231213pfl.97.2022.09.27.02.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 02:39:36 -0700 (PDT)
Message-ID: <6332c4d8.a70a0220.5b08a.1e38@mx.google.com>
Date: Tue, 27 Sep 2022 02:39:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-cip17
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip smc: 9 runs, 6 regressions (v5.10.145-cip17)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Sep 2022 09:39:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9555

cip/linux-5.10.y-cip smc: 9 runs, 6 regressions (v5.10.145-cip17)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.145-cip17/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.145-cip17
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      93a53e86925ce8c2e0608e173e2c7b952ee61cdd =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6332bd6c92d067e40dec4eac

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/6332bd6c92d067e40d=
ec4eb8
        failing since 85 days (last pass: v5.10.125-cip10, first fail: v5.1=
0.126-cip11)

    2022-09-27T09:07:42.567737  <8>[   12.748690] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/6332bd6c92d067e40d=
ec4eb9
        failing since 85 days (last pass: v5.10.125-cip10, first fail: v5.1=
0.126-cip11)

    2022-09-27T09:07:42.549378  <8>[   12.730500] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6332b1a14f74358703ec4eae

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/arm64/defconfig/gcc-10/lab-collabora/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/arm64/defconfig/gcc-10/lab-collabora/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/6332b1a14f74358703ec4eaf
        failing since 54 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6332b4c9441f6ceb06ec4ec6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/smc-qemu_arm64=
-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/smc-qemu_arm64=
-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/6332b4c9441f6ceb06ec4ec7
        failing since 62 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6332b1b54f74358703ec4ec6

  Results:     15 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-qemu=
_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-qemu=
_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/6332b1b54f74358703=
ec4ec8
        failing since 41 days (last pass: v5.10.131-cip13-37-ge3a52725ce96,=
 first fail: v5.10.131-cip13-49-g1145e9c6352e6)

    2022-09-27T08:17:44.153432  <8>[    2.524083] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2020-0543 RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/6332b22d9119ede8e1ec4ea6

  Results:     15 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/x86_64/x86_64_defconfig/gcc-10/lab-collabora/smc-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/x86_64/x86_64_defconfig/gcc-10/lab-collabora/smc-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/6332b22d9119ede8e1=
ec4ea8
        failing since 41 days (last pass: v5.10.131-cip13-37-ge3a52725ce96,=
 first fail: v5.10.131-cip13-49-g1145e9c6352e6) =

 =20

