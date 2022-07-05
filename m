Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60500C43334
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 03:54:45 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web08.80475.1656993278985510464
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 20:54:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=vSCK48eu;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id
 t5-20020a17090a6a0500b001ef965b262eso1001519pjj.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 20:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=UlFwk8lvseFNPmVYklhcL2KsatICXHOCIavWVGDPBLc=;
        b=vSCK48euUm8AwDXCGXCqlH8QKOWv9Xsq204qfnc4INocpIeNiDlyYrc1IqskgKsCxf
         UcGL2NJ+sYiYLKtSeVyeOmC7DWuK8FxkJKRr15EM7Omx/h0jAGjNSsYsLaDH2Usfhr5R
         OYXnEnlgSC+e9vtaNVpiwkEGR2GGPaWFFTKc47X32rPTiGxJa2OCksoMZ3eT99pFiD3Z
         wyAw7p3ryRfr212LrN9R16ixhurZ1nf6wUOcc1GSMypYG6pJ8nbnTfC59zV0AkrT+eSm
         6qsrjHmmOUmPU7xKV1RZzzxCqoGSXOmyhFUO/m9nbEPGJiDGKAuw6Mk7KLi6Bu3/qci9
         K9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=UlFwk8lvseFNPmVYklhcL2KsatICXHOCIavWVGDPBLc=;
        b=MyFapdXxPAa+tcbv6H+GcGb5iSnB+yTZ+Y9eZcfqoNEjSrvL+xBoX1qcoMcQglKP23
         yFO+wtg3RF0kUhgw1mcW6wuJ55ODvK3uR1hVT4umB5ZO0Mdv/f/FThhGdKgID218ymWD
         2a+ST6Hj5oZgaMZiArv1OhTjijvF1qkACKZoC9WJxtKcbz1GeCt0NX94EI4BGLqDk+Wk
         tfEmBHaThEvRIKIc4eFtF80gTIY0VR+3LF6c86iug+tQA+UQDysB78ULOfE+iWw6LpyV
         NILuxpYHgsi8UHm1Z8KxFnL2/uI08mZamcduRfiEpxj85CIMA4A59/h2+Gn/3ZcfJngr
         4GWA==
X-Gm-Message-State: AJIora9BiYDh7kjhh1GOjvAjfpR4GE8vEjg/aAFcnmFJRNPHEt1h5IMi
	aIfzjsf6Q1JObQx8g2er6B3/I6i6jV8WG0FL
X-Google-Smtp-Source: 
 AGRyM1tv+uoRS+A8kxmfJYLX56onrPPjugM6pwNoG2JMVJKquizGmBwiPIGuK8QXtH9NCKQVCuQhfQ==
X-Received: by 2002:a17:90a:f40c:b0:1ef:8132:368f with SMTP id
 ch12-20020a17090af40c00b001ef8132368fmr13722033pjb.81.1656993278107;
        Mon, 04 Jul 2022 20:54:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 14-20020a17090a174e00b001ef8397571asm4096311pjm.35.2022.07.04.20.54.37
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 20:54:37 -0700 (PDT)
Message-ID: <62c3b5fd.1c69fb81.9d264.5c40@mx.google.com>
Date: Mon, 04 Jul 2022 20:54:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.125-cip10-120-gf70f522cb972
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 5 runs,
 1 regressions (v5.10.125-cip10-120-gf70f522cb972)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 03:54:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8667

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 5 runs, 1 regressi=
ons (v5.10.125-cip10-120-gf70f522cb972)

Regressions Summary
-------------------

platform   | arch | lab          | compiler | defconfig       | regressions
-----------+------+--------------+----------+-----------------+------------
jetson-tk1 | arm  | lab-baylibre | gcc-10   | tegra_defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.125-cip10-120-gf70f522cb972/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.125-cip10-120-gf70f522cb972
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f70f522cb9729264739dd5a10a8e68d86241981f =



Test Regressions
---------------- =



platform   | arch | lab          | compiler | defconfig       | regressions
-----------+------+--------------+----------+-----------------+------------
jetson-tk1 | arm  | lab-baylibre | gcc-10   | tegra_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62c3aec3b8ee856b6fa39bdd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-120-gf70f522cb972/arm/tegra_defconfig/gcc-10/l=
ab-baylibre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-120-gf70f522cb972/arm/tegra_defconfig/gcc-10/l=
ab-baylibre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62c3aec3b8ee856b6=
fa39bde
        failing since 35 days (last pass: v5.10.112-cip6-289-g2969e096d186,=
 first fail: v5.10.118-465-g0af29783a3c9) =

 =20

