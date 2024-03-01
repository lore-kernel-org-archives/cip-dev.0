Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38D5C5478C
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 14:52:14 +0000 (UTC)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
 by mx.groups.io with SMTP id smtpd.web10.24805.1709304725141222026
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 06:52:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=WJ3iGPIR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.179, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bbbc6e51d0so1487155b6e.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 06:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709304724; x=1709909524; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i8lKuQ4425OY89VGIxxH3IiNoZ6oRmfFZTgKZKRFeTg=;
        b=WJ3iGPIRM+lFqf6Ns5Z/Vq/3zxREOX5+OhlHNGKQxSafIVLfPKHpXeuhdzsBM/QJSZ
         nB0liC3gbusM5RQ/DEeFieZhhNt/RFCsENxUFJlnT27ZIoFDEf2HExgy1unqbDiBMytU
         1+uXOUQa0ZTwYSFPb7YwGPmxflqFcd3X8g8QcCLJzQK7cqzpYaB3Bj++X/M9RztwIaK9
         EALpLxAokmIlOs4F+z2vM4Q+MpCWkdQ0oUGho36IIWJyuYQ/yKXih4nmjFtD98WolSRb
         XBf62q885DLsbYxOaJ/iPcV+E8xc+HlDnibQUGBnPWM26pHu7jUvLLbJrmPF6bEY862x
         FXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709304724; x=1709909524;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8lKuQ4425OY89VGIxxH3IiNoZ6oRmfFZTgKZKRFeTg=;
        b=TQZ1096zohvalDr4vXcroXQWuKOq2IC15vlZ4ZC7ej+XuGe0Jx9EFLYWtmEGw9oXXB
         TeXzv+yFJO3tkiY/H9k2Di3K3egQjtWE0srXcyRMng+4q0NQTkEaj6XDiFJDxF+CGW5O
         +sARZ3swD7WHpc9Zl7osFBD7N2Z5YnS9iznd3rier/EK4kthFf+wksWTXg7kLekjXeT0
         vmyew0ryXEzAn4rNb0/58xFfeRQgw0ChyDcyRZCeK4y9mSTMz/qGsRWxY4UpSxYNDU8c
         rt491+ssqrWW5bsW4W5tJMq2N8yNAvwrmW+XHq62uIMC7bgcJX8yI09Ar7BI5Fkcbw7G
         lQhA==
X-Gm-Message-State: AOJu0YwCECAKF72N14aQro71p1yeAVyuzHQ/ZONP7tGiPvLxMx2+ivjF
	KeXqB6zI9914P0eNuhzhnzKNCj0plA1fNmzhpQhYURlPbwCjDEOyFykSRpzlnshnKKQBMqGTIlW
	foOw=
X-Google-Smtp-Source: AGHT+IG+p1OZ7BTO6aHMApb9XFNcWsOtqu1y5XhAItJHihdVfcZIKJQOrGR2Q/ivm+Qg4b5Pwj4sVw==
X-Received: by 2002:a05:6808:bd6:b0:3c1:b2c7:f6d3 with SMTP id o22-20020a0568080bd600b003c1b2c7f6d3mr2229582oik.41.1709304723812;
        Fri, 01 Mar 2024 06:52:03 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c2-20020a6566c2000000b005e49bf50ff9sm2788722pgw.0.2024.03.01.06.52.03
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 06:52:03 -0800 (PST)
Message-ID: <65e1eb93.650a0220.2d5b3.bd80@mx.google.com>
Date: Fri, 01 Mar 2024 06:52:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.209-cip44-56-gdc749db3de7d1
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 5 runs,
 3 regressions (v5.10.209-cip44-56-gdc749db3de7d1)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 14:52:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15119

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 5 runs, 3 regressions (v5.=
10.209-cip44-56-gdc749db3de7d1)

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

beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.209-cip44-56-gdc749db3de7d1/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.209-cip44-56-gdc749db3de7d1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      dc749db3de7d1c1c07950e25062de70fd66057ae =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65e1e1e17f786ccd55637016

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e1e1e17f786=
ccd55637017
        failing since 529 days (last pass: v4.4-st20-229-gb433f12afe250, fi=
rst fail: v4.4-st20-231-g7349cef09ddd2) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65e1db7b8cfbc11ad0637034

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e1db7b8cfbc=
11ad0637035
        failing since 102 days (last pass: v4.4-st20-231-g7349cef09ddd2, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65e1e25c87608fa63363701d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e1e25c87608=
fa63363701e
        failing since 102 days (last pass: v4.4-st20-231-g7349cef09ddd2, fi=
rst fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =20

