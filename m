Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B60C433EF
	for <webhook@archiver.kernel.org>; Thu,  7 Jul 2022 06:37:42 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web08.2645.1657175859850322746
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 06 Jul 2022 23:37:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=Bz3WT92Q;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id x184so4079273pfx.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 06 Jul 2022 23:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=5C7lbymd1sTpWnwMY69xkVa7otXgDfWxkLfW22l/5Wo=;
        b=Bz3WT92Qasc2HjcEAiKXQZhLhvGMHkjuXZYfnjT9SP4IQQPInnF8UI4CUS1EClfyKp
         9RFD1TWcqAFvLN6iUCBml2yqgJfwNxhst10vuuUMoWIs36tSRVJjfRaGPR3fGRFpDfzO
         8yxKYlyBIKyrzZrk3nK0GoJ193IheHcUsRJmlPc6lTJH7zLztJHGl8nSNaXvc83KlE4Q
         wDx3WvRCHFu+f2acZkub861ZVI32TpYJLTAeDb5AlbBg/nG33ZDh3ynUQq4fTDwFQ353
         Y04mXIS2uqP/+OkHnQWqgKZoTIF6bEtRJ2Ov6bw8+FeqSzARWZD+aHNNzgVi63gpMClF
         NbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=5C7lbymd1sTpWnwMY69xkVa7otXgDfWxkLfW22l/5Wo=;
        b=ALCHvYFbI/cM30M2MHRfMmrqDoh3fDvChuE+AKOg8eD4s9Xqncd1WZcGKabe2MbIli
         ET+o0IOjxUidP6lb2IPyd4ijyNGoEJU82NYfOvP4dPxy9e+9/Xk14L/XOsvFJmtFRwrn
         9yzh9w2Z6T438XIvmLEr/V1y52gmuuUvpM+3uDBYO9PDhXwu5ij2la7+zWxtmAwhoeVe
         rUygVWynkfoHjAwwYy0FCWjwdZX+mUGktHz1hLaaftXojaxrgpwVRuluNRnUAvNkl0dy
         l7oDNKXMT4dvHUwliE7kDCmbUg0czLSAYCx2v9+KmI3nUPpkVCSqnxX+E/ACH/CtYMWv
         3Yig==
X-Gm-Message-State: AJIora/+vdJH2rRc8eQUWzmN68YcZATMB124SGJY30Y3wDg/qqidpttL
	FfCbGcQGLYpyBdvweE9HC0WkSnBWKZuIbB8A
X-Google-Smtp-Source: 
 AGRyM1vmsB7jGmOfYfKgses6N3/TH+yOK+3sLEAHTKzARtyAH4VEz9FXNZng/qNPp8tPURuqfWRO5A==
X-Received: by 2002:a63:f70c:0:b0:412:1877:7e1c with SMTP id
 x12-20020a63f70c000000b0041218777e1cmr22463700pgh.621.1657175858854;
        Wed, 06 Jul 2022 23:37:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 n5-20020a170902d2c500b0015e9f45c1f4sm27143896plc.186.2022.07.06.23.37.38
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 23:37:38 -0700 (PDT)
Message-ID: <62c67f32.1c69fb81.ed810.6e55@mx.google.com>
Date: Wed, 06 Jul 2022 23:37:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.126-cip11-116-gef362fbbff528
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 13 runs,
 3 regressions (v5.10.126-cip11-116-gef362fbbff528)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Jul 2022 06:37:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8706

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 13 runs, 3 reg=
ressions (v5.10.126-cip11-116-gef362fbbff528)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig | 1          =

beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.126-cip11-116-gef362fbbff528/plan/baselin=
e-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.126-cip11-116-gef362fbbff528
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ef362fbbff528b6dc0695b488cfc8cde20b404e4 =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62c6745ea3bfd66bbba39bd5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62c6745ea3bfd=
66bbba39bd6
        new failure (last pass: v5.10.126-cip11-1-gc5218dc69ff1) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62c673d0f5f564d72da39bef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62c673d0f5f56=
4d72da39bf0
        new failure (last pass: v5.10.126-cip11-1-gc5218dc69ff1) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/62c67a245d6c869c76a39bf7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/arm64/defconfig/gcc-10/lab-=
cip/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/arm64/defconfig/gcc-10/lab-=
cip/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm64/cip-core-image-kernelci-cip-core-buster-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62c67a245d6c8=
69c76a39bf8
        new failure (last pass: v5.10.126-cip11-1-gc5218dc69ff1) =

 =20

