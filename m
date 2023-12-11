Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14303C4167B
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 09:16:02 +0000 (UTC)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
 by mx.groups.io with SMTP id smtpd.web10.4467.1702286161695002369
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 11 Dec 2023 01:16:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=eqoLwn9X;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.179, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b9efed2e6fso2036825b6e.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 11 Dec 2023 01:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702286160; x=1702890960; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCngs9sf3Q2KQ+66h+poSGK7ZJfpY/+MNs9iunyilQk=;
        b=eqoLwn9XpXu0tqHJmDaAjpeH1EL7uJ7GYRnSBahrCG/VnabCDAjoEsZm0jI7D5CJrX
         aN5vPlI5NGMZOwKrxSdFCPd5e1OgIStzCPMXhxONUvvmkD7TVwxPcSEI6oXAPFWDV6Kj
         FsYLeKg/zHuTUlVE3dATJDp5Vv0/PRrrhgmuJn/ZsGTtRkk5whon3KtAeD9s0OxBJUW9
         TX/9czKaCOP1fI9LyDjLD3jhSiWrsm+D+Z2BrNix6Pk1S56psETswWRspB7M0yKIIkuI
         LnMblgXJEuklUFWEDfhsxGhWWgc+RrrZWE1wfe1Do/6HomuhsZ0WtKI+m2Zki1POfBUO
         M+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702286160; x=1702890960;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZCngs9sf3Q2KQ+66h+poSGK7ZJfpY/+MNs9iunyilQk=;
        b=K8A6IdAWw2BPVQ79k27VPBmXBgAVvDHz8tbN20hnxAchB5E9+AgL0U9BiJ8HfiWttV
         Dbq4/VLlPn9RN8bjhvmaip7iFH3feIE2AvRY+5wEmRxK677Rl3DqelrorlMKds6aLxIM
         oxXUk8tHWozji3+kaV+gYj7TEVcZz5rSU4axQ6U7ghG1muZMYbCYZsHIaLB2gZE22WNw
         +f0W+Ps0mj0h1aVQOIMZP7ocOKhq87iGFZVPeW2wg1Pw1YgXlYYguSvKa6dOEZjKqnXR
         NrTMQWPxb+//rW66xkBm4qjYJoOFpV7Fra+4NGqmaWbvpG6H2zNQfW1VSmkP9Kh/KCIu
         T9mA==
X-Gm-Message-State: AOJu0YyY18+NIefgZJui5+RvXsQqWxOZCnn9XclUUebKkDM03rZEQ2F7
	oEbH1q5g1qnaMNLTuTPFsbUqKL4iIduZnRL6h45AdQ==
X-Google-Smtp-Source: AGHT+IEFZkXKWHLSABfXguX2x070OMfgalX+FDS2qiFezGBsH06HxGVdjfVWg78RSXpkwsi1fL+5cg==
X-Received: by 2002:a05:6358:6f14:b0:170:68c8:1894 with SMTP id r20-20020a0563586f1400b0017068c81894mr4654997rwn.64.1702286160360;
        Mon, 11 Dec 2023 01:16:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n56-20020a056a000d7800b006ce75e0ef83sm6064863pfv.179.2023.12.11.01.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 01:15:59 -0800 (PST)
Message-ID: <6576d34f.050a0220.5ef1f.02c8@mx.google.com>
Date: Mon, 11 Dec 2023 01:15:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1187-g657481329b53c
Subject: cip/linux-4.4.y-cip baseline-cip-nfs: 4 runs,
 2 regressions (v4.4.302-cip72-1187-g657481329b53c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 09:16:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13998

cip/linux-4.4.y-cip baseline-cip-nfs: 4 runs, 2 regressions (v4.4.302-cip72=
-1187-g657481329b53c)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =

beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-1187-g657481329b53c/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-1187-g657481329b53c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      657481329b53c9dc746b686cfa529666e967e8c8 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/6576ce4b12b36aaa6be1357d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1187-g657481329b53c/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1187-g657481329b53c/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/6576ce4b12b36=
aaa6be1357e
        new failure (last pass: v4.4.302-cip70) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/6576cdc5e65a51559ee13483

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1187-g657481329b53c/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1187-g657481329b53c/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/6576cdc5e65a5=
1559ee13484
        new failure (last pass: v4.4.302-cip70) =

 =20

