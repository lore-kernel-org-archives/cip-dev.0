Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DC3C43334
	for <webhook@archiver.kernel.org>; Thu, 16 Jun 2022 16:33:44 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web09.20331.1655397218063536719
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 16 Jun 2022 09:33:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=6uW18nIK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id u37so1963405pfg.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 16 Jun 2022 09:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=/myKDiyexs81eM57Absjp3JTMsF/2uEHoaYMvAAhekw=;
        b=6uW18nIKPVZK/eG3+42HUDflxtS2JvUvyPG9inx93YmnRU9oLf//by/GazbW4Rihkd
         P/m33XJUWNsrJjwoEydeP1N2fElrdpvhWryuSZsGl5u2W9eEC5SBBOat/81AsQeOSku6
         WRmRRnDDR3OoZqCgcWX9Yj2+i0SCKjDw4NKygLGlMQn9XDCWqma/3XxZFlOS2gy4LSUA
         Gn+CUKP7zrq8SRgyxQ+LMDnEa33itmB558iXDy76nKJ6RDNP5sfyq7VA3dJa+Q1iCN4G
         uj90jZqY0c/KA2FtwvbrphiiRzLAJvsKNH42LHMda7BAhFxSs/zaijP7QZauX+8NceKP
         Q4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=/myKDiyexs81eM57Absjp3JTMsF/2uEHoaYMvAAhekw=;
        b=mYLuYMHUJunwjRolCH18D4m/znLxn0LABKWCE+ojIOWmIQ+MXGGWCNmlXFSKvhDufD
         W2pmdNEQ7tLbQ8U8PbsNtrPjG6b0I71XG/7g6GlA+Ida62kV8DrDw5MS4gABPTVomAbD
         XAIovRl0quhswOunia/IW6L8kzdG2AUiy4vA5Y+fHelfkvdoh16rfDPYA5dGnntdJ0W4
         CGl1zMqHHCRasvXJJkzAmGdpVf4u2QpZ4P0MIQprcHzzV8+Y/xkgeqTayLSSf1clZrUS
         F0HVsMC7RFr8Ub8/WXIJDesm91t5zf+rhFDBLE5SORRrQVabmigigvBaT3VbVV99NdUo
         qtkw==
X-Gm-Message-State: AJIora/GVNKDc6XMX0V8jTbfdAPeEiL3kdL6cL34wmazOd/8Mc8aFf8Z
	rG4EwEASwEghz2LMMXqL7x7V7orB26Wq/TO7xB8=
X-Google-Smtp-Source: 
 AGRyM1tFyHC+KyYPnTOMtTdpHwOV8r4zh0UFdPV7ne6gnleOCZvgMyFbH/ojfAB+1u1MCNYAIkzDww==
X-Received: by 2002:a63:6a49:0:b0:3fd:df6d:5ba3 with SMTP id
 f70-20020a636a49000000b003fddf6d5ba3mr5151729pgc.385.1655397217250;
        Thu, 16 Jun 2022 09:33:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 v24-20020a17090ad59800b001e33e264fd6sm1761806pju.40.2022.06.16.09.33.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 09:33:36 -0700 (PDT)
Message-ID: <62ab5b60.1c69fb81.3ab1e.23a1@mx.google.com>
Date: Thu, 16 Jun 2022 09:33:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.246-cip75-307-g39a7d45c38bb7
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-cip-nfs: 4 runs,
 1 regressions (v4.19.246-cip75-307-g39a7d45c38bb7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jun 2022 16:33:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8573

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-cip-nfs: 4 runs, 1 regr=
essions (v4.19.246-cip75-307-g39a7d45c38bb7)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.246-cip75-307-g39a7d45c38bb7/plan/baselin=
e-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.246-cip75-307-g39a7d45c38bb7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      39a7d45c38bb7a761b622e3f5d1c8f804a801c29 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/62ab4fa5e5b0ca19c7a39be5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.246-cip75-307-g39a7d45c38bb7/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.246-cip75-307-g39a7d45c38bb7/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62ab4fa5e5b0c=
a19c7a39be6
        new failure (last pass: v4.19.245-cip74-32-g2d021d7a9e637) =

 =20

