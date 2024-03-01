Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033A3C5475B
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 14:52:15 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web10.24806.1709304725748032637
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 06:52:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=tVpWd18t;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so2040765b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 06:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709304724; x=1709909524; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RimxyzWfKfVbfsSoYEGrKVZAgEJ1UEvJ/2d2gF1+pgk=;
        b=tVpWd18twNsOA/6klkhoSRJOQDVBXHeYhZBaGp6uFbwNemhOOTD956qIao6oIAgfMH
         Kt6OxXSRH9GKyQ7zmZgK3+NHd8PP5+HNFaKE4VEJJHAGCRGbZC0S3djbSMwhoOlSBA3M
         lA/g+3Sg29OS+tf7xbypoNk0TRPkYiieh3ti7/6vaLDvAOqhqbLCpM2QdQ1KbxyLeQcc
         73qu27aWhoTACqXDYjunmCsmKIi7B9ikStMtw6SoSvEt4GxXVLxOXEMugYbgPLygCnqz
         9hGKGZYa+Si+oPDgbWmM/71y6VlEhguTEA3XRO6Fyof73AEzn5gc6u/OdrzTMcF7ruzJ
         jvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709304724; x=1709909524;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RimxyzWfKfVbfsSoYEGrKVZAgEJ1UEvJ/2d2gF1+pgk=;
        b=wjNrQo4uBnpps+S4S12pqirqQncWfwrFHyVkkDoEUK0SKv8H5+YdaDv58ab/PhTkTN
         Ti1niev7S7MB6XIEURu2ChC6a0CJOOow0G3eiyiQ+9G4Rf1lMDlQhijqObKYNLJiJTPj
         81IjcKgt+dijtvtG190lbz2I9Bb0FH2Q9yTgfcFM73aRzR6sZKWhzRSNcxLNzj8krmK8
         nMzQIjWF7GsyFDt/83XNRiFmocv+jM0mezgM5Xt1EVmVe5ZBIoDz12CCwF7eGPVC9FbY
         dB+z5ZTYUCtQYBTqLhmmbo5RRiBIaHQwzgZ8vrJrLJAdDQQV4pu50NWP61RmfR+4qQre
         rvZA==
X-Gm-Message-State: AOJu0YycPzCfzYEMpiZbvHuA8AcOjTxNNYYfh7jJLiHbjbhTp1B1lELR
	tQQHsS2KCcxvHjfEDW1suRvOOacTnpBDfDyglyo8ICR4bqcwWnnb4ISk2LcncITSXwNoUaijGcl
	zCyA=
X-Google-Smtp-Source: AGHT+IE24N9deWRPOD4UmQpT5VKkDuvQuf+Oguj5k7FprOSaDEuVQxC8dyup4E2L5ItXfW+MpE9hrw==
X-Received: by 2002:a05:6a00:27a0:b0:6e5:5f6a:4966 with SMTP id bd32-20020a056a0027a000b006e55f6a4966mr2318300pfb.6.1709304724257;
        Fri, 01 Mar 2024 06:52:04 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e27-20020aa798db000000b006e5af565b1dsm1679820pfm.201.2024.03.01.06.52.03
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 06:52:03 -0800 (PST)
Message-ID: <65e1eb93.a70a0220.673ba.861e@mx.google.com>
Date: Fri, 01 Mar 2024 06:52:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.209-cip44-56-gdc749db3de7d1
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 36 runs,
 12 regressions (v5.10.209-cip44-56-gdc749db3de7d1)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 14:52:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15120

cip-gitlab/ci/pavel/linux-test baseline-nfs: 36 runs, 12 regressions (v5.10=
.209-cip44-56-gdc749db3de7d1)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
acer-cbv514-1h-34uz-brya  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

acer-chromebox-cxi5-brask | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

at91sam9g20ek             | arm    | lab-broonie   | gcc-10   | at91_dt_def=
config          | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig         | 5          =

imx6dl-udoo               | arm    | lab-broonie   | gcc-10   | imx_v6_v7_d=
efconfig        | 1          =

imx6dl-udoo               | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig         | 1          =

imx6q-udoo                | arm    | lab-broonie   | gcc-10   | imx_v6_v7_d=
efconfig        | 1          =

imx6q-udoo                | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig         | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.209-cip44-56-gdc749db3de7d1/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.209-cip44-56-gdc749db3de7d1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      dc749db3de7d1c1c07950e25062de70fd66057ae =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
acer-cbv514-1h-34uz-brya  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1daf2a22753f013637013

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e1daf2a22753f01=
3637014
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
acer-chromebox-cxi5-brask | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1daf1701d3cc2f0637018

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-chromebox-cxi5-brask.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-chromebox-cxi5-brask.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e1daf1701d3cc2f=
0637019
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
at91sam9g20ek             | arm    | lab-broonie   | gcc-10   | at91_dt_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1df234ff2542244637013

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e1df234ff254224=
4637014
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig         | 5          =


  Details:     https://kernelci.org/test/plan/id/65e1e1e57f786ccd55637019

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65e1e=
1e57f786ccd5563701c
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T14:10:28.421880  /lava-649866/1/../bin/lava-test-case
    2024-03-01T14:10:28.497321  <8>[   84.351495] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/65e1e1e57f786ccd5563701f
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T14:10:24.878208  /lava-649866/1/../bin/lava-test-case
    2024-03-01T14:10:24.947884  <8>[   80.801416] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-03-01T14:10:26.010793  /lava-649866/1/../bin/lava-test-case
    2024-03-01T14:10:26.086560  <8>[   81.939366] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/65e1e1e57f786ccd55637020
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T14:10:22.598674  /lava-649866/1/../bin/lava-test-case
    2024-03-01T14:10:22.672276  <8>[   78.525692] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-03-01T14:10:23.736743  /lava-649866/1/../bin/lava-test-case
    2024-03-01T14:10:23.812573  <8>[   79.665627] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/65e1e1e57f786ccd55637021
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T14:10:20.316001  /lava-649866/1/../bin/lava-test-case
    2024-03-01T14:10:20.391015  <8>[   76.245539] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-03-01T14:10:21.456534  /lava-649866/1/../bin/lava-test-case
    2024-03-01T14:10:21.532623  <8>[   77.385453] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/65e1e1e57f786ccd5563702d
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T14:10:07.145166  /lava-649866/1/../bin/lava-test-case
    2024-03-01T14:10:07.222166  <8>[   63.074174] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
imx6dl-udoo               | arm    | lab-broonie   | gcc-10   | imx_v6_v7_d=
efconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1e750e1aea6964b637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e1e750e1aea6964=
b637013
        failing since 16 days (last pass: v4.4.302-cip72-1251-g57b839f01594=
4, first fail: v5.10.209-cip44-51-gdb99ac443b0da) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
imx6dl-udoo               | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1e33f879fcea2c263701d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e1e33f879fcea2c=
263701e
        failing since 16 days (last pass: v4.4.302-cip72-1251-g57b839f01594=
4, first fail: v5.10.209-cip44-51-gdb99ac443b0da) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
imx6q-udoo                | arm    | lab-broonie   | gcc-10   | imx_v6_v7_d=
efconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1e7280950cda50d63701a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e1e7280950cda50=
d63701b
        failing since 16 days (last pass: v4.4.302-cip72-1251-g57b839f01594=
4, first fail: v5.10.209-cip44-51-gdb99ac443b0da) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
imx6q-udoo                | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1e340a717760c13637095

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e1e340a717760c1=
3637096
        failing since 16 days (last pass: v4.4.302-cip72-1251-g57b839f01594=
4, first fail: v5.10.209-cip44-51-gdb99ac443b0da) =

 =20

