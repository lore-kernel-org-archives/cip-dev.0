Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FCEC00140
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 14:55:04 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web11.7555.1658847299269524158
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 26 Jul 2022 07:54:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=axfQNrpW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id
 e8-20020a17090a280800b001f2fef7886eso880967pjd.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 26 Jul 2022 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=qHIb8EU10jJcncsXthSofp9vu8VrjNP3Tl598FXpJFg=;
        b=axfQNrpW1rK4feq7BNztu2TYbRlU+4YF5wqPw/8OYAcFCpDruJBc6Nfv0hSEiPx98E
         AkAwvibSz0bIZdAdudks0XUu0oWZYINNva+zhmp5ZWqTQSEB4CX24mZdqlAjUrHFh7wa
         0gb4BRhjYvfR9VODFQHhwoV1oHXg2+UONejJnz0PwdSck3qWiaDfNlahGs1Mi3t/runA
         EEX+mjD3oOyI4hlkPP3xr7aavgigIoUK21Hq9JujLOKRNF5PiHAXITw8bQ7RbT9RA1fN
         79ppbHvudNLlBcN1FjxwVe7s+fy9QokChE12Af5BykaQQwvuSIRdGQ04OO6djiOQpL6w
         MGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=qHIb8EU10jJcncsXthSofp9vu8VrjNP3Tl598FXpJFg=;
        b=2YeMe1UOqBnjNEtZEze1GJQwGWkgVRNxOK9RL1rWmVma9eP0go8le2KIGAlpHqoXJf
         kaJCTlZpE7f5OpOXr92SoL4v35hWmHVhZ9NKkxBFTlK1XGhUlE6JEbcWBz4hwl4v3Oic
         UG+fMIsgsMAsdujOJ028vybrLFg3GhHaPHoH0f+/uObhlHGKg+wH9AX2plPtkIebdKLv
         dDgDrNo0biGN6spPHAnsfHztN8KctusycifQsw7QK9ErpKF2aegSGydIaaW7rsvqRW8i
         0h9bbepmopeZHSB4UbrFP80mOQieEY0gu4ZiG69gTW5+ihDUn8L+SfrawIVwf7c9WGuq
         J2ZA==
X-Gm-Message-State: AJIora+U9jmiVp2+CZ1mnDrYC1pSddlKSo61KM9y+geBFmSn+GXwEp+F
	/ATqkqOys6ysUIsH9nlh6KwNKpIFk4QQRotz
X-Google-Smtp-Source: 
 AGRyM1uOj7vK7qiKX/bfv3dfauXejA7N3BerTMuS+SyRTdJBIBDcH9egt7z1fpYO0ayfG6aBSvGy2A==
X-Received: by 2002:a17:90a:1588:b0:1e0:a45c:5c1 with SMTP id
 m8-20020a17090a158800b001e0a45c05c1mr20111069pja.65.1658847298431;
        Tue, 26 Jul 2022 07:54:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 o9-20020a62cd09000000b0052abfc4b4a4sm12125479pfg.12.2022.07.26.07.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 07:54:37 -0700 (PDT)
Message-ID: <62e0002d.1c69fb81.f5ac8.3360@mx.google.com>
Date: Tue, 26 Jul 2022 07:54:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-36-g21d9d56f4de5a
Subject: cip/linux-5.10.y-cip baseline-nfs: 28 runs,
 2 regressions (v5.10.129-cip12-36-g21d9d56f4de5a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 14:55:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8932

cip/linux-5.10.y-cip baseline-nfs: 28 runs, 2 regressions (v5.10.129-cip12-=
36-g21d9d56f4de5a)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre  | gcc-10   | defconfig       =
           | 1          =

rk3399-gru-kevin      | arm64 | lab-collabora | gcc-10   | defconfig+arm64-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.129-cip12-36-g21d9d56f4de5a/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.129-cip12-36-g21d9d56f4de5a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      21d9d56f4de5acd415b12aecf82f754e9e6065fb =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre  | gcc-10   | defconfig       =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/62dffa0d4c6a289a15daf061

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-m=
eson-gxm-khadas-vim2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-m=
eson-gxm-khadas-vim2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62dffa0d4c6a289a1=
5daf062
        failing since 217 days (last pass: v5.10.8-8301-g3d6168cb89f6, firs=
t fail: v5.10.83-cip1-31-gdcbef6602957) =

 =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
rk3399-gru-kevin      | arm64 | lab-collabora | gcc-10   | defconfig+arm64-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62dff91fbdefe46f20daf067

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/62dff91fbdefe46f20daf089
        failing since 119 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2022-07-26T14:24:21.546655  <4>[   37.988152] cdn-dp fec00000.dp: Direc=
t firmware load for rockchip/dptx.bin failed with error -2
    2022-07-26T14:24:21.555943  <4>[   37.998468] cdn-dp fec00000.dp: Falli=
ng back to sysfs fallback for: rockchip/dptx.bin
    2022-07-26T14:24:21.752817  /lava-6895453/1/../bin/lava-test-case   =

 =20

