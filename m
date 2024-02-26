Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480B6C54798
	for <webhook@archiver.kernel.org>; Mon, 26 Feb 2024 03:15:36 +0000 (UTC)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
 by mx.groups.io with SMTP id smtpd.web11.12907.1708917327951405581
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 25 Feb 2024 19:15:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=VQgL3B42;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.219.180, mailfrom: bot@kernelci.org)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc745927098so2414917276.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 25 Feb 2024 19:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708917326; x=1709522126; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uYwZQ79GMdyguEBvzNezMC/Yz7I5dd/tkJqSMf1Ibko=;
        b=VQgL3B427Yo6ehNxLpryybVehUdEcnGBmHZQBwiCYmdcRFCFeA0JetbdASOKEFp97d
         jCnPMR5ldt5raEOvU2oCSvt11hmPs+3GykN9UXvTdoot7AqjCV3Hu2nTUpTQ1Qbcodh8
         wlw3w3MZw8eN/vjs32HQZOnlf+jNSOC+NsSlNfENt/PtZtqW2K+vo0+E98zz4YjlvU2H
         wlpv3B4tvNBmpgjiKIZmjHvBQzoqk+oaG4N62Ed+GFWmmacanuEY+UFIiW7AQTUWLVNy
         kFtAXH5EjeoAnIHgVkeJYkkmy3ecejpFefNnHs7hh1YLIa1vuiSF8aEW3ioMD/BFsMft
         JNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708917326; x=1709522126;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYwZQ79GMdyguEBvzNezMC/Yz7I5dd/tkJqSMf1Ibko=;
        b=oO9fDxyBM2P89wOISOsQVxWXKXRhecpojQOJPGe12cphUXwR5XU0YWIwTUrhu6f6gs
         CWCHBGSoFjmcmRsEYrP7bl9LQKPUGSAvTI5OcsLlu5QoasJi9vMqQmKyB+F6Bn464nn1
         qO6oQBVje1YGdnTc+yjBkRKxDXWoEQxBkr2ptJaszWaOfuRmIOwGW0vHGT/inxzdEIaI
         jwI39ZI3NQK6SsSvyrKcJqf72INcjqajIcHWdMv/F1u7IlwL+3xUL6+tg6kQv3dv0GGj
         hBQzdt027JBQi6DA4OvnbgOubKL5a166Lg699UGgVBsp/m+k3m06gQpDx3BMOrFjJxN4
         xD4g==
X-Gm-Message-State: AOJu0Yxj8+WrRgC/8ejHhn2YOVVjr5GAAwvRXKfnc6xfmNMUOc/SnL44
	dvJ6YlOPF9+KwVj43dPJc/5z9owvoAyjvyQnPePh4B3304XLjPYyzQSU1yW9/oqE0JtsJZPVaY1
	r
X-Google-Smtp-Source: AGHT+IGJ0Lpr/RUV0I+tsgTnX4UZfu0q2ORLBA1d28g94MV3VtyBnZ+vLxPX/7NdwYdIKXED7dm0vw==
X-Received: by 2002:a5b:c07:0:b0:dcd:9808:2563 with SMTP id f7-20020a5b0c07000000b00dcd98082563mr3584909ybq.38.1708917326536;
        Sun, 25 Feb 2024 19:15:26 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p21-20020a631e55000000b005cfbf96c733sm2969218pgm.30.2024.02.25.19.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:15:26 -0800 (PST)
Message-ID: <65dc024e.630a0220.9a3e6.788c@mx.google.com>
Date: Sun, 25 Feb 2024 19:15:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Kernel: v6.1.78-cip15
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip baseline-nfs: 64 runs,
 1 regressions (v6.1.78-cip15)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 26 Feb 2024 03:15:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15085

cip/linux-6.1.y-cip baseline-nfs: 64 runs, 1 regressions (v6.1.78-cip15)

Regressions Summary
-------------------

platform   | arch | lab             | compiler | defconfig          | regre=
ssions
-----------+------+-----------------+----------+--------------------+------=
------
imx53-qsrb | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig | 1    =
      =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.78-cip15/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.78-cip15
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8e0cf035f64a98ea0d7ed2527a547f39866c37ba =



Test Regressions
---------------- =



platform   | arch | lab             | compiler | defconfig          | regre=
ssions
-----------+------+-----------------+----------+--------------------+------=
------
imx53-qsrb | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/65dbf502dcc1cbe64f637074

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.78-ci=
p15/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-nfs-imx53-qsrb.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.78-ci=
p15/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-nfs-imx53-qsrb.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65dbf502dcc1cbe64f637079
        new failure (last pass: v6.1.31-53-g486caac40d06)

    2024-02-26T02:18:32.419682  + set +x
    2024-02-26T02:18:32.419855  [   29.065650] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1028941_1.6.2.3.1>
    2024-02-26T02:18:32.528471  #
    2024-02-26T02:18:32.629792  / # #export SHELL=3D/bin/sh
    2024-02-26T02:18:32.630292  =

    2024-02-26T02:18:32.731186  / # export SHELL=3D/bin/sh. /lava-1028941/e=
nvironment
    2024-02-26T02:18:32.731606  =

    2024-02-26T02:18:32.832365  / # . /lava-1028941/environment/lava-102894=
1/bin/lava-test-runner /lava-1028941/1
    2024-02-26T02:18:32.832987  =

    2024-02-26T02:18:32.835701  / # /lava-1028941/bin/lava-test-runner /lav=
a-1028941/1 =

    ... (12 line(s) more)  =

 =20

