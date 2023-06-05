Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1633C7EE23
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 23:40:48 +0000 (UTC)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
 by mx.groups.io with SMTP id smtpd.web10.140.1686008439110697280
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 16:40:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=g9Lhx1wm;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.44, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1a28817f70bso5244050fac.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 16:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686008438; x=1688600438;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OZz7htHdC3nJG4L4cCJ0KQ7BbE48MnGkaHZeK3LTxRg=;
        b=g9Lhx1wmTcCTGaiqqrk48cEg5h1UFLeaHwBGRGw0nzsVLcD75uAcqD77+zz2UsOeCt
         pK1UEXYrjjkCNPqtjMS9HhmbGP4iQXS+o3pxawOL+Ec1Pfn5O9qrLMhyGep3c4/anEZR
         miw8U54KmFq5YtuSBsedkeztuzaaAr4zYVX50PmQ4tezwg0IaU8CXdpTZ411XVLiFkl2
         1zdqINAlRajRgBNbdM4x9a5YIdUvt4MiugWmKyDeJqnThxVtBI0o5qODzRXJjLLqA1fA
         CahfmOQRRO8Elx3k3om8CDegtGyUAjYLMVih5egoLLVmFUQBOqADwgx7iLYGeGdXQX9q
         Wa8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686008438; x=1688600438;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZz7htHdC3nJG4L4cCJ0KQ7BbE48MnGkaHZeK3LTxRg=;
        b=cGLqCzATtR90MAm9z9iwdx48h7gc/PjBhk30KlVZOzkURan251cTwUtsiCsGZa+Kq+
         JD/8y0h+Lt0U2t0Y55FlWXd2nMLystWEfghnKT7sx+7F9Z+51jrBiQDgsQJXBIh2ZL/N
         3hCCwdXFA1xugSvG08wcqgitwum/huXs0WF4LmxvsQ/Io9uM/QeBrC+4HtRoFANXKHP8
         6yDgPh+ATXCba/Ng2laGS4J2iff7UKEQg4Ct9ioZr4rDnLew3krGnZrVID9jglhwc+xJ
         Uk5gVKY2hVuFJ1J+IqB9BswtbFVllhCB1JRyzK9h8b/UL+qAptNN4s4MWBduWEA8MxEO
         b9AA==
X-Gm-Message-State: AC+VfDxasxV2bev5FzWnsDbSfrdx1GQ89Xy5sTfdT4KC4q4542aH1tVG
	w21F3b2LfoxmE6MzO43AeZ5K7LWQAApspqAaJTvfqw==
X-Google-Smtp-Source: ACHHUZ7//2oQJFOrUmyAsE9uHJZdB+6aPR7Dyjzk7r3xrAI78RAPjw0AFPe2L3XT8BfBCTEOKyMk7w==
X-Received: by 2002:a05:6870:c797:b0:187:e50a:43b7 with SMTP id dy23-20020a056870c79700b00187e50a43b7mr447317oab.1.1686008437867;
        Mon, 05 Jun 2023 16:40:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b38-20020a631b66000000b0051eff0a70d7sm6095046pgm.94.2023.06.05.16.40.37
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 16:40:37 -0700 (PDT)
Message-ID: <647e7275.630a0220.48297.b1ea@mx.google.com>
Date: Mon, 05 Jun 2023 16:40:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1314-g1ab0ac1d7e2e3
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 11 runs,
 1 regressions (v6.1.26-1314-g1ab0ac1d7e2e3)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 23:40:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11830

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 11 runs, 1 regression=
s (v6.1.26-1314-g1ab0ac1d7e2e3)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1314-g1ab0ac1d7e2e3/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1314-g1ab0ac1d7e2e3
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1ab0ac1d7e2e3aeca50f8616b469772a5f010acc =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/647e6d1ed2ac94dcd1f5de47

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/multi_v7_defconfig/gcc-10/lab-broonie/ksel=
ftest-filesystems-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/multi_v7_defconfig/gcc-10/lab-broonie/ksel=
ftest-filesystems-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/armhf/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/647e6d1e=
d2ac94dcd1f5de48
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a) =

 =20

