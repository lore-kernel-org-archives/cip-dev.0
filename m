Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B29FC7EE2F
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 13:36:01 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.76.1686058554869384542
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Jun 2023 06:35:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=JbtQslh2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1b038064d97so54350775ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Jun 2023 06:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686058554; x=1688650554;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Eoig7DXZ1suw2g8HWRy7aW5k6TZB9Ea1xfDolLtgu54=;
        b=JbtQslh2QWhj1DwrICUtlYizeB/Cb53K6lTtJX/4CcmGK43DJ9Rexr3BH2euoZdUr4
         F1S+m2PndosliLbwDYsa+lDlrf47tit4pjjGQQnA6MKgknTuF9ojTtodpgGD7vxtorLZ
         rOPTaWhguWtMy2wEqHZBd76e31lvOqnMohDUQX+f7xbl08nW5lzBFXn5A1ph8OcYAToE
         nwc2CINkNOYLPWxg03uPYmt9VYOFS26TuFTPjjYmW3hgH56xjPA7dVocRcKQbpEzRtDs
         Go/OdpmMzd4Mkhe5ZOoDpWHCUSRXRbVWde4KeSm0xV+/OWHF2E1P8WzI7rATzbkDFk3x
         XRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686058554; x=1688650554;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eoig7DXZ1suw2g8HWRy7aW5k6TZB9Ea1xfDolLtgu54=;
        b=MiYqvZdkQeYstZj6jFUjJ7V0sDmi+RX62OoxiP/bZgnncj6zoMH+lD74pQ78t6lSoF
         vVgn6g314gaIVmhXEQhkK/Omekp6e463pt2a3xXKloiDVMlVqvYslnHCT/gtgdjcVb9l
         QUPvHoly60i3uVgtWbjNDut2kxdkjK9tZSpRkF82CWqnS9NaNRWTP4t4E45V72GHLLXh
         EApONBXbxBWYP3TKgsaHbm/W/X0japOoApOUuKD8YwdYY2vAcOGLfRaxA9SBE6Rl/7Dq
         VuR8bWx+qmux2Se0/BToL7dnO13jh/drvQgrADADn/44fx1cwPoSQE/bYCQXBxmxsUIU
         aPKA==
X-Gm-Message-State: AC+VfDyHcX3krFH7nueUJVPu3PAHA1qqvJUWbtIMifhGhY3q5xo7UI8j
	yl4g1g+Bopl3jOtd8dcAx1Cv22FhBHdHYWshpLC3/g==
X-Google-Smtp-Source: ACHHUZ4s10kYGep0RkYV0qEke5M7MMhCBnngMIrfvlQDWM8SZXd0LJD82xBb0IJYrivWVfJiEiQgfw==
X-Received: by 2002:a17:902:da88:b0:1b1:8ca9:10ca with SMTP id j8-20020a170902da8800b001b18ca910camr13258325plx.33.1686058553864;
        Tue, 06 Jun 2023 06:35:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902780500b001ac444fd07fsm8627034pll.100.2023.06.06.06.35.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 06:35:53 -0700 (PDT)
Message-ID: <647f3639.170a0220.d1fe4.f85f@mx.google.com>
Date: Tue, 06 Jun 2023 06:35:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1320-g1ddf4b637f785
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 8 runs,
 2 regressions (v6.1.26-1320-g1ddf4b637f785)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 13:36:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11886

cip-gitlab/ci/pavel/linux-test kselftest-futex: 8 runs, 2 regressions (v6.1=
.26-1320-g1ddf4b637f785)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =

beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1320-g1ddf4b637f785/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1320-g1ddf4b637f785
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1ddf4b637f7858373296265fe09135a077008de6 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/647f2da0691ee615ecf5de3f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/multi_v7_defconfig/gcc-10/lab-broonie/ksel=
ftest-futex-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/multi_v7_defconfig/gcc-10/lab-broonie/ksel=
ftest-futex-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/647f2da0691ee6=
15ecf5de40
        failing since 0 day (last pass: v5.10.180-cip34-26-gc198172c84b6a, =
first fail: v6.1.26-1314-g1ab0ac1d7e2e3) =

 =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/647f2aaecb6848f2b3f5deb8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/multi_v7_defconfig/gcc-10/lab-cip/kselftes=
t-futex-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/multi_v7_defconfig/gcc-10/lab-cip/kselftes=
t-futex-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/647f2aaecb6848=
f2b3f5deb9
        failing since 0 day (last pass: v5.10.180-cip34-26-gc198172c84b6a, =
first fail: v6.1.26-1314-g1ab0ac1d7e2e3) =

 =20

