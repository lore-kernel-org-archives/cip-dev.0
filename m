Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6C3C77B7F
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 14:44:39 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.28167.1684507478741690922
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 19 May 2023 07:44:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=blZcLzY/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ae6b4c5a53so13380305ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 19 May 2023 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684507478; x=1687099478;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wCCcdkGwCt66dKUTDEgKDXYSQLgCYz2vA0Bu8xDFrXc=;
        b=blZcLzY/6CPZcFPqYi7nh1MCtphapraG7BgD70uHdsCHQ9cfSKz4c7E5Tj3LisLHIB
         K4A0I5I/S55bFWaCH4fUQeK3SUfCVm3YRAInCcR4UEHBFW4UfUaPP+H52lmYg3EePm+K
         lKJ4u7/eTTVGd67oMZU3jnrFEo+ujzZueFi8WPFmxA+uinxXtYFxizIHUX4B7VX/819I
         tfetNsvfb8DwOaGixoa0IkDshvFdWQgolvJlak3vQZ4+5gZ65KTquLvusHWL9TlXiNLQ
         FTnagffCJOSj6c3UDVTYO/pUw5hRmt4TtcM1Q6KgopRP/ZEUyVP0wPUdV8B+4uT4BAnc
         /L1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684507478; x=1687099478;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wCCcdkGwCt66dKUTDEgKDXYSQLgCYz2vA0Bu8xDFrXc=;
        b=KGQLVyCt2EvvJwxN0ucOytgeBbNxZQjffcdeKRiD0wH1jmDS+eilBdFbB4OGNobH3N
         8YKxPc+unxHhH4T3V+xp9DUFSkjPcG1k7U0e57/jz1JHDIA41QOo/rZmuV0erHNLuGFY
         DtBRfsuUQq96ztsVHDd8wxD75K1R1JfYIEcpFPlIyfQcRW+X3rwsfiJm+tUXoFErpgX6
         CIlfOYQy+nqTBJhVdb1Ie9aTOHv+zWiu8ugzwDw83gZmbRoobdJNQ7x9am81lfbfVJU1
         79uXFSCYmv+9goyYMuL8ORi/ohtx6mvEq+ajV3DO3HyxHKh2w6h/voZQ9aD7w7jCvQoA
         /0FA==
X-Gm-Message-State: AC+VfDzv7tyj6PkZzb6ztvrsKG3nERJOY04n+x6HPs9XaSyowUyZYoqy
	AzenCbwEG00ndpUPZ3wcUOI65VXhXdLUXCP8jsngMw==
X-Google-Smtp-Source: ACHHUZ5vaLQPSdv+qPO1iHAtbkvv5g1OlKdeLTcpole5Uq0urqcLTjqOBo/5CEGo88nM8l5/GWAsoQ==
X-Received: by 2002:a17:902:d70b:b0:1ac:a058:555e with SMTP id w11-20020a170902d70b00b001aca058555emr2434661ply.8.1684507477676;
        Fri, 19 May 2023 07:44:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902db0300b001a4fe00a8d4sm3557619plx.90.2023.05.19.07.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:44:37 -0700 (PDT)
Message-ID: <64678b55.170a0220.2b2b5.6b63@mx.google.com>
Date: Fri, 19 May 2023 07:44:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.283-cip98
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip baseline-nfs: 33 runs,
 4 regressions (v4.19.283-cip98)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 14:44:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11562

cip/linux-4.19.y-cip baseline-nfs: 33 runs, 4 regressions (v4.19.283-cip98)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
beaglebone-black | arm   | lab-broonie   | gcc-10   | multi_v7_defconfig   =
      | 1          =

beaglebone-black | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig  =
      | 1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.283-cip98/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.283-cip98
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      31603fc59adb456f6eb0f58de8bb989b41572c2a =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
beaglebone-black | arm   | lab-broonie   | gcc-10   | multi_v7_defconfig   =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/6467839c40a823212a2e8607

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.283=
-cip98/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.283=
-cip98/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6467839c40a823212=
a2e8608
        new failure (last pass: v4.19.280-cip96) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
beaglebone-black | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig  =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/6467851947cb732ea42e8625

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.283=
-cip98/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-b=
lack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.283=
-cip98/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-b=
lack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6467851947cb732ea=
42e8626
        new failure (last pass: v4.19.280-cip96) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6467820068171393222e85f5

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.283=
-cip98/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.283=
-cip98/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/6467820068171393222e85ff
        failing since 58 days (last pass: v4.19.276-cip93, first fail: v4.1=
9.277-cip94)

    2023-05-19T14:04:40.578329  /lava-10389294/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/6467820068171393222e8600
        failing since 58 days (last pass: v4.19.276-cip93, first fail: v4.1=
9.277-cip94)

    2023-05-19T14:04:36.923856  /lava-10389294/1/../bin/lava-test-case

    2023-05-19T14:04:40.355625  [   56.867137] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

