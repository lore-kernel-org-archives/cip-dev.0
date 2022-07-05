Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29245C43334
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 03:08:15 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web11.79863.1656990487696266824
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 20:08:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=SEmirQm3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id
 g16-20020a17090a7d1000b001ea9f820449so15416953pjl.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 20:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=2O0Y1aJqrKMXJLcdAA62g16Ibrcrb4BT5WKbt4bZu68=;
        b=SEmirQm30QnME4yLJYf66hYGulozsqyUIbfd2H8BGblIM1mJddqoqc85OXdOH86qqS
         DEdgRIshhiHU1AtBPnHophT2adR+jHHG2oYDapcMkA5t7vL1v7ZHuMhgtT5Iyyh9vqq5
         fsakTSAKS3tKi41ySgQGY2RiYYg4IBCKnDb9HGUS/ZvyIRfuVP/rpT4q79H2/o30U5zk
         ZuCOiuLBo52TxYfU5tF08xuilTNVl8lGwwNlv/F6nT6tT7VlgX7VcgRTL9qcnMsoMnHL
         pVCth8iTtg4VMrjjpu85FVY+BgyaOsKJaGclNQa5dDnWu7ja1oNam7uREuRmnhCL367z
         6j7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=2O0Y1aJqrKMXJLcdAA62g16Ibrcrb4BT5WKbt4bZu68=;
        b=15CYbvnUJw8yb461iNMnqE5R6rjdJiYY9hTqqYFT26zve4NSyon65Amp2yqFrk2Hk1
         Tx1mukYUecvbNdei0HwMdS0texcC/uyFLMJJnrofGIy5LW04+1P065fF3i17yGpJTP6C
         JKBZivzteC7Ch+QYE9fGtnbb1+ZEH49H/U52+QBdzWJjD08HQQPws7WDRXu3QFYUm8X1
         fQ14yerQvidGr3l+ytHM18EwVGUKCxi0IgvZMxi6jDTssTZX17WCQ1/PBXzzLh5nZMYR
         WkmIL57O+qwaNNj8Ptftja/5txOQArsFWT6illlEcvl9VwPkCRltpRXZieXladjsywzU
         Argw==
X-Gm-Message-State: AJIora+ELMzrEtj4XqTFWbhlJVQzTuog+HnQp/sqLA0skn6E0V6sJY8W
	pffnoG7QTafnuqGIRd5k95wqU8yye8DdzdKN
X-Google-Smtp-Source: 
 AGRyM1tDj/l3HTtndoTL2WcCWC+1GG8R0RtRNLqCLBMVI6lBFIYEFFFufztQO3c9TX/6UnnVka8q7A==
X-Received: by 2002:a17:902:854a:b0:16b:a3c3:ed8c with SMTP id
 d10-20020a170902854a00b0016ba3c3ed8cmr30921182plo.167.1656990487015;
        Mon, 04 Jul 2022 20:08:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 a8-20020a656048000000b003db7de758besm21163265pgp.5.2022.07.04.20.08.06
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 20:08:06 -0700 (PDT)
Message-ID: <62c3ab16.1c69fb81.2a5b5.de9d@mx.google.com>
Date: Mon, 04 Jul 2022 20:08:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.249-cip76-53-ga202ffa2bce5
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-cip-nfs: 2 runs,
 1 regressions (v4.19.249-cip76-53-ga202ffa2bce5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 03:08:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8663

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-cip-nfs: 2 runs, 1 regr=
essions (v4.19.249-cip76-53-ga202ffa2bce5)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.249-cip76-53-ga202ffa2bce5/plan/baseline-=
cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.249-cip76-53-ga202ffa2bce5
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a202ffa2bce55da1a3b9c1f6ff2594af0b4e2d68 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/62c3a029dc36cea32da39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-53-ga202ffa2bce5/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-53-ga202ffa2bce5/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62c3a029dc36c=
ea32da39bce
        failing since 28 days (last pass: v4.19.242-cip73-50-gd57bc44cb340,=
 first fail: v4.19.245-cip74-32-g2d021d7a9e637) =

 =20

