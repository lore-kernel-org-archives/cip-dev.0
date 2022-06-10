Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289D2C433EF
	for <webhook@archiver.kernel.org>; Fri, 10 Jun 2022 11:50:39 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web11.26128.1654861829054801977
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 10 Jun 2022 04:50:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=5OMmOUHY;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id c18so16216142pgh.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 10 Jun 2022 04:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ML4goz7PbF7US3ghZ9jnfyTp/K9T+CtCG7wH3Vd6qss=;
        b=5OMmOUHYdHnldNhWhdNsqOnOC87/fJzRrKGy4CQMkIKe+wnbuVueAicFm7geig4FhH
         wftdlql27XYAtZklCxNK9c3RXu91fUhEEJxf76w2M1sxeuAGBzR+bUrRcT2l8I1o50CE
         dOXTBPINo8xlkMeQMCjRyJYodapDVuV4+XGrzq+/NkBplQL7uUicVK0Ut3vnPwUmI0Q/
         4D3DTZF96pBOA8uRkJ0M9ZhYzw2qVfqKnbg47ek7qveDGYgwTsJx4NYV2avhrmJeiaiE
         0QMufPyxGWf7EN2jF9lehpuEdj2aMlApy4vSIVh+X8TIp67nhvOcf9nu3ZVphT87AlpL
         Fr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ML4goz7PbF7US3ghZ9jnfyTp/K9T+CtCG7wH3Vd6qss=;
        b=JI3zN6rbnf/253V+e1I22S2w4epMql0I9eOf1OWYAZc8XgmW70mdCu/+lHLkYXVEaY
         jzSZtHetp5N/M+IAl88ClSi1iYLfnyhSKkCF8h0VLiNfhlpeCjfdzpXC92ruH+o3FIYJ
         fFQPd5d9sOIdePZNhbuTughmwqOMS68TD8w8u35ZR/8HBHoIfpt/ZfNaGSIBrMQIcpvm
         5bEtxRyzysUo69RcO2i7UIpkMM3xDjgrmRn7Gu1QksTJNNf82+cjMUjHj9KVgbkqxzNw
         2yRfD1RmY+kDd7B1fVITOJTRCImzrCNC37nCAJMMitl6JkODvqsGIFYVNgyghxf2uVr5
         lESw==
X-Gm-Message-State: AOAM533slIpI5kLejMKLPyevoewypZ+dBuFhysigCDydXhhvB7GtFtGs
	T22yMLv6LYYg+3zsxGJHfcs/pmLb4ZXL41XFmUA=
X-Google-Smtp-Source: 
 ABdhPJyvWhAYyGBEFuNVqWYus2jyW5lbAq7f6fbnnut7x0zoO7SeRDSWU4Ev4x81BDfK4AJUUcAuzg==
X-Received: by 2002:a63:81c6:0:b0:3fc:8ba2:9f9a with SMTP id
 t189-20020a6381c6000000b003fc8ba29f9amr40368456pgd.432.1654861828364;
        Fri, 10 Jun 2022 04:50:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 la19-20020a17090b161300b001dfffd861cbsm1529177pjb.21.2022.06.10.04.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 04:50:28 -0700 (PDT)
Message-ID: <62a33004.1c69fb81.a0f09.1ee5@mx.google.com>
Date: Fri, 10 Jun 2022 04:50:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.246-cip75
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip baseline-nfs: 31 runs,
 1 regressions (v4.19.246-cip75)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Jun 2022 11:50:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8535

cip/linux-4.19.y-cip baseline-nfs: 31 runs, 1 regressions (v4.19.246-cip75)

Regressions Summary
-------------------

platform   | arch | lab          | compiler | defconfig       | regressions
-----------+------+--------------+----------+-----------------+------------
jetson-tk1 | arm  | lab-baylibre | gcc-10   | tegra_defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.246-cip75/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.246-cip75
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      38ce181ac6ca9f3decdd389cbfd0a38fecdb28c7 =



Test Regressions
---------------- =



platform   | arch | lab          | compiler | defconfig       | regressions
-----------+------+--------------+----------+-----------------+------------
jetson-tk1 | arm  | lab-baylibre | gcc-10   | tegra_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62a32729f0f47a11a7a39fbd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.246=
-cip75/arm/tegra_defconfig/gcc-10/lab-baylibre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.246=
-cip75/arm/tegra_defconfig/gcc-10/lab-baylibre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220603.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62a32729f0f47a11a=
7a39fbe
        failing since 10 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.245-cip74) =

 =20

