Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AD9CCA489
	for <webhook@archiver.kernel.org>; Fri, 22 Jul 2022 18:14:17 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web08.11050.1658513653873962073
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 22 Jul 2022 11:14:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=y3KIunEF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id i3so755828pld.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 22 Jul 2022 11:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=TMrQ9f6MS+6gjPcg/9hDO1zpbGk1brD2tidF1jf55XU=;
        b=y3KIunEFAOnl0LpiVkTrW3hAn2BZ+xNu6yvenWWTci6K0tVZ/3R1n2Csz0zPLS8aRF
         w3loTCPQgV2wyy1Wsqksdn29PXwT9wj8DoKxgL5iKZroZ/Y9RR/4tEYwK6iB9vGcD6Uq
         SLXlisecMjzkfcihMYL0frYF5u+02VPnjaAwoBPFkuigRsF5JkBFLJGZSVvAvKr83aB+
         5/AROqarMqS7T1Yrwk8dIRC7lkF/619LsQZPcDy6+OQ4WBUGdY4bQOiuSCArz0ZvnCnY
         oOk51+d9nFifZ8DE3vEi2rOecXoGdgNEcUUVLsjCVslTIme5WLiK7EXnyy1lAdSA0j6C
         ituA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=TMrQ9f6MS+6gjPcg/9hDO1zpbGk1brD2tidF1jf55XU=;
        b=gZkarOuTf8gssZonR00OOnn3Uk++lN6chFbVgxMKJVrVoj4kEIW/WIjKF67RldyTX8
         s8g9aFnvra7Zyt9SSzw9kjMJdGafo6+OIVKk5rcluA3Z7HvIVjp+iYqrbAOc/w9w/G9l
         EEfTfmDMYriBQx7tZ8m4GjSsvjKt9bMonCZtKd6hsE+a6U8Xql3H4NYGqdjKlCDEM5ZO
         LEUUqj2DcHVRMMbii6XClbvfWaX1lllBjOnDKaenhLvnspBkSXnLRfX90DiXJV9hVH8j
         ZW5S0WTEEqD22BKdFxDIdOwsOofKiVyR2sfMtyDBdwk+gBKIgHLaEAkpSSad9aQNCv8y
         kDJw==
X-Gm-Message-State: AJIora8g4xUV64RXaM2xf7lS9gl8MDJPNvXSkVTipswhbIfe2rx5eeFj
	uW6qTC0D4pbR21pOAceXEhlC2YtYwePqntqt
X-Google-Smtp-Source: 
 AGRyM1vaBXnlPUjfJWj3cLvAucwMLTWXsTf92BKKBPJsqEqHc88+5VPBfsvLr3h0OfI8+Kodc7ZgEw==
X-Received: by 2002:a17:90b:3c0d:b0:1f2:31c9:7481 with SMTP id
 pb13-20020a17090b3c0d00b001f231c97481mr10601221pjb.244.1658513653095;
        Fri, 22 Jul 2022 11:14:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 j4-20020a17090276c400b0016d3935eff0sm2739742plt.176.2022.07.22.11.14.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 11:14:12 -0700 (PDT)
Message-ID: <62dae8f4.1c69fb81.2b617.4734@mx.google.com>
Date: Fri, 22 Jul 2022 11:14:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.251-cip77-82-g10c370b53152
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-ipc: 12 runs,
 3 regressions (v4.19.251-cip77-82-g10c370b53152)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Jul 2022 18:14:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8888

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-ipc: 12 runs, 3 regressions =
(v4.19.251-cip77-82-g10c370b53152)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | omap2plus_defconfig=
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.251-cip77-82-g10c370b53152/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.251-cip77-82-g10c370b53152
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      10c370b53152e01c8282be083dc0943e33d50ead

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  bda92ad659a52d38ac810099f69adff626b064c6 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | omap2plus_defconfig=
        | 1          =


  Details:     https://kernelci.org/test/plan/id/62da56bcef38e573b0daf0b3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm/omap2plus_defconfig/gcc-1=
0/lab-cip/ltp-ipc-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm/omap2plus_defconfig/gcc-1=
0/lab-cip/ltp-ipc-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62da56bcef38e573b0daf0=
b4
        new failure (last pass: v4.19.249-cip76-57-gef3cc1b9e556) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/62da5af49fffdc60bbdaf064

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig/gcc-10/lab-ci=
p/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig/gcc-10/lab-ci=
p/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62da5af49fffdc60bbdaf0=
65
        new failure (last pass: v4.19.249-cip76-57-gef3cc1b9e556) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62da647de49d10699adaf058

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62da647de49d10699adaf0=
59
        new failure (last pass: v4.19.249-cip76-57-gef3cc1b9e556) =

 =20

