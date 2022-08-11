Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27241C19F2A
	for <webhook@archiver.kernel.org>; Thu, 11 Aug 2022 14:57:30 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web09.7326.1660229841260523699
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 11 Aug 2022 07:57:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=tHqksIu3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id ha11so17911408pjb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 11 Aug 2022 07:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=yKGjMIUNxcryJT91rfPyPzotImE+SONNztbGrnx0fdc=;
        b=tHqksIu3vtmIwu1EpPJ10f0pIO/dIt7arYxAbTIhEZpD4xdBMYzLRszoGVy8/SCUdK
         N6/9Le4CVJn5Fa9XJ+WnBgtpuoy/DyXQFgBRUF6DG85lQu2FZu94Jre7NcDH8X8wUsZG
         S4tLpAO0kAnP5gYNjuFBruHnuK7kWXYqvNtO70ZeOWdhoFjc+ak8Iw740gdpYGBIsRY+
         JDj3EwbYmHpCDgdjAnmFpcVCFOLFiojJqOpuIHtCRDEvGvFbWytO3CLU7gOVTW7JX4sh
         WVYyd7vm/aFqwD+utblAJt4zrs2NN/AnYHaFSxF1iOIYJNAYH0DpL1nzf9YuAoQkM/a0
         8Suw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=yKGjMIUNxcryJT91rfPyPzotImE+SONNztbGrnx0fdc=;
        b=ZziYI7CQbzH+0tfkG6RpOoYkM0h01jgc6q1COjhUhssDkv6MeDcPWnSC3BEgjXNnXe
         yy0KgT3vc9SBo0TdT3NPGoHUHPEPQqu3lFM51nRjBP92M9tQSHxmIiz7XUKzEelO+xkT
         6gC0S3gvfmPuDdvtA+E1yGd3S8XLRyEaIoGPyaMlRU3f8QGg01gzqkdzRrlRpxrsEUEL
         yllQ0siO3zuurkXR2uECSRfAmUQ0QSHF0GVMUl4x+zVBAUC6DnICpd4QcGi8OHo13Fr+
         oWsRO/7zBVqSu9Pct7lz45QrrCT0njN9FHP5TBMGYFX5ura4gaZ6ctBgx4thMDsZN5u5
         7Uiw==
X-Gm-Message-State: ACgBeo00cu+eh0PJdoCBly7aQVixwmvWIw3OacVZcNXK25O63JsOzwm1
	t5TWjP1IcilJwv3BbUoamHM3w1x4ziDD7B3noJk=
X-Google-Smtp-Source: 
 AA6agR74utA1NG5NaI6sVyJATD8X5to514Xzz0nwBSvAZSXDgcBNofKfY9MTc8/9SN3GFKJMZzA4tw==
X-Received: by 2002:a17:902:8302:b0:16d:bf03:847c with SMTP id
 bd2-20020a170902830200b0016dbf03847cmr32745256plb.125.1660229840302;
        Thu, 11 Aug 2022 07:57:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 i22-20020a63cd16000000b0041c30f78fa6sm11490389pgg.69.2022.08.11.07.57.17
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 07:57:17 -0700 (PDT)
Message-ID: <62f518cd.630a0220.cc9d8.2b4a@mx.google.com>
Date: Thu, 11 Aug 2022 07:57:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.252-cip78-146-g6acc38498265c
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-cip-nfs: 7 runs,
 1 regressions (v4.19.252-cip78-146-g6acc38498265c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Aug 2022 14:57:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9157

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-cip-nfs: 7 runs, 1 regr=
essions (v4.19.252-cip78-146-g6acc38498265c)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.252-cip78-146-g6acc38498265c/plan/baselin=
e-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.252-cip78-146-g6acc38498265c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6acc38498265c7429063eae4888e1bc9fd68ccd4 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/62f512cbce8e88ee36daf068

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.252-cip78-146-g6acc38498265c/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.252-cip78-146-g6acc38498265c/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62f512cbce8e8=
8ee36daf069
        new failure (last pass: v4.19.252-cip78-113-gb7034e0f773f8) =

 =20

