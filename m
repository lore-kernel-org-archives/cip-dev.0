Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF900CA5539
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 16:13:40 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web10.964.1694621611987303195
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Sep 2023 09:13:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=0KaKlgBn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1c3d8fb23d9so16056565ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Sep 2023 09:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694621611; x=1695226411; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qOWvWX6hbP2tuf9gRMrRfl3PHmGsqML3CkMfvm3deHY=;
        b=0KaKlgBn26GmIxNl2Z028s5PNtAhNEx7SRAXK+gsBwBw2HPU3TCmXK80n4HpYADLZT
         a+2OJQSt1j50L9XOayn06DoctMmFxWOiq02I0NZjHlCsk6vP/QbRbslOtwnHyzomnkM2
         b58SR4Byt5e9NYjzr3qLIpcfdNcbA8oNLHfTBPIAWjlgnIpw6G3Xu+bxT6KEhJ0qo/BK
         89i4CdyorzBtIRynSVvmMBAt0BFffWn66m5EaPuwRohdkenOJQQUrfSyNsIdY8E5A58h
         4+ILG4E9PxYZ/VrLmBBfVUedzSvS+cRVsAuMKuXEi0SZqdIz3TL2e8/Ua8py6IIHUjGb
         hqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694621611; x=1695226411;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOWvWX6hbP2tuf9gRMrRfl3PHmGsqML3CkMfvm3deHY=;
        b=Y2YHhu2lKd7K9gWQDwkuAVvWc8O5fLLY6bzimErjwGvpo23xLvAHr3UQ7MXgYYY/Af
         mQCDtdfSadRXbJ8+p26CG2+tNgTzkmyoD7ob9qpZh3Z92Z3zhWzIdlR3z39Ln4tLrBVe
         O943hvG8DG1R17JrAkKmkxdBOjIQOzj3ZSb1SCFBeAcUpPq/5M1sM7Ksbf6SaWQNAslS
         M/Ddje26uUwhqLGNkzLpiaHGduVZq4YQ+4L97vEE+xaJ0MUzfF3zmr8nvw6Mrc8N1RJQ
         IFE4a4J73sF7+Ml2R3tjThgDZ1FFljUsyo6SpvI8wLbB1k6D9JwdEj98Axm17wRSWKU3
         /7Fw==
X-Gm-Message-State: AOJu0YzMgSl71/aqoXFKt7N2BB8SgZI8q8IpK8EM1Rzdois3FwqzUZE0
	ZD2qT0CXY/DQPOzUFyoa0By5ZZ0f9DBMLP1oGJo=
X-Google-Smtp-Source: AGHT+IED615RwdlsPt0agkV+fcqkaJ7kl4YtWQFd3Y3Ud5y8/k682/8pUdnMopRlPMqrnTlAyVG2oQ==
X-Received: by 2002:a17:902:cec2:b0:1bb:25bd:d09c with SMTP id d2-20020a170902cec200b001bb25bdd09cmr3786233plg.1.1694621610693;
        Wed, 13 Sep 2023 09:13:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p15-20020a170902e74f00b001bb8be10a84sm6747347plf.304.2023.09.13.09.13.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 09:13:30 -0700 (PDT)
Message-ID: <6501dfaa.170a0220.1fb99.58ad@mx.google.com>
Date: Wed, 13 Sep 2023 09:13:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.191-cip38-29-g9e1aa2001db86
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 15 runs,
 5 regressions (v5.10.191-cip38-29-g9e1aa2001db86)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 16:13:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13104

cip-gitlab/ci/pavel/linux-test baseline-nfs: 15 runs, 5 regressions (v5.10.=
191-cip38-29-g9e1aa2001db86)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
beaglebone-black             | arm   | lab-broonie | gcc-10   | omap2plus_d=
efconfig | 1          =

beaglebone-black             | arm   | lab-cip     | gcc-10   | omap2plus_d=
efconfig | 1          =

imx6q-udoo                   | arm   | lab-broonie | gcc-10   | imx_v6_v7_d=
efconfig | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig  =
         | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig  =
         | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.191-cip38-29-g9e1aa2001db86/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.191-cip38-29-g9e1aa2001db86
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      9e1aa2001db862da32812062860b8756cbc8890a =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
beaglebone-black             | arm   | lab-broonie | gcc-10   | omap2plus_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d3580c866c24988a0a9b

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/6501d3580c866c24988a0aba
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:20:50.173346  /lava-105166/1/../bin/lava-test-case
    2023-09-13T15:20:50.241604  <8>[   52.260164] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
beaglebone-black             | arm   | lab-cip     | gcc-10   | omap2plus_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d34b0c866c24988a0a5f

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/6501d34b0c866c24988a0a81
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:20:29.874255  /lava-1008432/1/../bin/lava-test-case
    2023-09-13T15:20:29.939203  <8>[   45.757358] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
imx6q-udoo                   | arm   | lab-broonie | gcc-10   | imx_v6_v7_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d1dbe795e21e048a0a5d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6501d1dbe795e21e0=
48a0a5e
        failing since 21 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, fir=
st fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d3ecb9dbc6569d8a0a42

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.sound-card: https://kernelci.org/test/case/id/6501d=
3ecb9dbc6569d8a0a49
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-13T15:23:15.232243  /lava-105171/1/../bin/lava-test-case
    2023-09-13T15:23:15.473787  <8>[   42.446901] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/6501d459e3ae06dd768a0b29

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm64/defconfig/gcc-10/lab-cip/baseline-=
nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/arm64/defconfig/gcc-10/lab-cip/baseline-=
nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6501d459e3ae06dd7=
68a0b2a
        failing since 28 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d) =

 =20

