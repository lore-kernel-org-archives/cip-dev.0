Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4433CCA47B
	for <webhook@archiver.kernel.org>; Fri,  8 Jul 2022 23:01:22 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web10.995.1657321277669195102
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Jul 2022 16:01:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=5zvfs4OO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id s21so275520pjq.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Jul 2022 16:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=vb8JL2aOtbQeoWk75bnOUgrBFYagu/wKey1+BuK9C2w=;
        b=5zvfs4OOl598C311VsUcVTTiidx2bzNkG38/Kl8tHHLufDTK/ItjQOPxCOM7JsNrtC
         gTmj2j3H83kY44tpRO6gN0tLpKDDOGDUCE+XfJO2tAljEhTR4JvjdsXnRvfSaZEusNkj
         DbWL+8KTtPzlRq0yDof4Wh4zrdyayM3NbdEhq03Ljl022lXHD3KYN2FntXwk9cJAkDNo
         1DgmhfelNwcGoT2KAsdFP81WMAOZvMMwUyGYAVxCwahyxRSs269yT0s6X2FwBd1POH1r
         sNUy98/VYUUu8p0xbZDtqYPXDm4YU7QKlhD3R2qCP1YzMfHsCO9FyTlmPYbJv3UqneXm
         aPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=vb8JL2aOtbQeoWk75bnOUgrBFYagu/wKey1+BuK9C2w=;
        b=Ilo9z7ydpPjYoG+MmDp4su+PK11RJzbsieEZypbEQ2+8i2J/LD8knVT0eWPqqeJ5Qc
         rZ9rRrPjsiGN8wNk2JsAx8s8vqc1k2oa1FWdMpAQp81hcSdwfzDYG5ots3dCshhx8gzW
         WBQej5j+odrEVyQLe14YzqLYNbfBs+obZhw1NQn07VioHnL3EOr7Pu2Y49CRhCD/U/SR
         FrPQFK7j0nKWZxCyWn91uVGxhRbmyYE/192DcaHGVlennyTS6hwu6L0YgbbbvfEPUkha
         yFFzD4H9U5/4y9H6YkMfVzo6qzH2mmiyNjodHwNJ4wV3IfmbSvpxflHeRvBGkm4ZXfK8
         ebQA==
X-Gm-Message-State: AJIora8YGI9g0QlSQbOLbi6G965hOaJ+u6Jn57i9WYcjSuJeEz/QrhnG
	Ik2xqxsjALcZcq5CqrFE4yba5YqTUXZr0DW9
X-Google-Smtp-Source: 
 AGRyM1v4006RXs8TX0KRvpOLJbQbSrQdkxr7fPbKo+eugCKbxWYz31bluo1GLroYzIFnXS+VYOl/RA==
X-Received: by 2002:a17:903:2281:b0:16a:674e:8949 with SMTP id
 b1-20020a170903228100b0016a674e8949mr6099006plh.49.1657321276754;
        Fri, 08 Jul 2022 16:01:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 p2-20020a170902e74200b0016be596c8afsm30744plf.282.2022.07.08.16.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 16:01:16 -0700 (PDT)
Message-ID: <62c8b73c.1c69fb81.ddbf2.00fb@mx.google.com>
Date: Fri, 08 Jul 2022 16:01:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.251-cip77
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip baseline-nfs: 47 runs,
 2 regressions (v4.19.251-cip77)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Jul 2022 23:01:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8727

cip/linux-4.19.y-cip baseline-nfs: 47 runs, 2 regressions (v4.19.251-cip77)

Regressions Summary
-------------------

platform   | arch | lab          | compiler | defconfig          | regressi=
ons
-----------+------+--------------+----------+--------------------+---------=
---
jetson-tk1 | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1       =
   =

jetson-tk1 | arm  | lab-baylibre | gcc-10   | tegra_defconfig    | 1       =
   =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.251-cip77/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.251-cip77
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e634159f2620ade28a9251a9bc2cc23b84f527f2 =



Test Regressions
---------------- =



platform   | arch | lab          | compiler | defconfig          | regressi=
ons
-----------+------+--------------+----------+--------------------+---------=
---
jetson-tk1 | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/62c8b4246dd9a38308a39bdf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-nfs-jetson-tk1.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-nfs-jetson-tk1.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62c8b4256dd9a3830=
8a39be0
        failing since 39 days (last pass: v4.19.235-cip70, first fail: v4.1=
9.245-cip74) =

 =



platform   | arch | lab          | compiler | defconfig          | regressi=
ons
-----------+------+--------------+----------+--------------------+---------=
---
jetson-tk1 | arm  | lab-baylibre | gcc-10   | tegra_defconfig    | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/62c8b2fc46cead0f0ba39bce

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm/tegra_defconfig/gcc-10/lab-baylibre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm/tegra_defconfig/gcc-10/lab-baylibre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62c8b2fc46cead0f0=
ba39bcf
        failing since 39 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.245-cip74) =

 =20

