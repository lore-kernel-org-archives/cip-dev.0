Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4437AC43217
	for <webhook@archiver.kernel.org>; Sat, 26 Nov 2022 11:33:05 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.68387.1669462375369939244
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 26 Nov 2022 03:32:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=BP3mkZ8i;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id y10so6085307plp.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 26 Nov 2022 03:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kFgO6xZYuQb5n0oSi2sVNcPgsfbdz9lxwEQBkFxbUAs=;
        b=BP3mkZ8iu2hie+cOEz848cqOJSIYCQNeUZWLLRX/f+jpdrlQxqK65+xogMNizK85YK
         8c8HWJ0+o1Q8tWv7k7jR29d2bComyHU/wddlQPoOk9T5N8fEakhsfVIj4kidSWBsvtE1
         SXKUBQ/umlyoD1eLA88ER8H+OqjZ6kcK7sqF2Lv3p1+FUZRGaZuw0/uJeM5GSMw1EOY0
         Rz/uTBAw7eSdOv7q80ID5ZTJakX9VglMSV2L8DQqRJW7mQ0w5OJRpFdKg1eEnY1csFOG
         uJnZSfQHKlg5GtsC9ngtUVy9cbC5z5FsU05XPvoAJ8tmpxL5qNm85MvdfYw+k6IVXfSF
         ULFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kFgO6xZYuQb5n0oSi2sVNcPgsfbdz9lxwEQBkFxbUAs=;
        b=R6kR10SQ6WLh3dr4ZYnVT0PRJMWgFi7ZQZ+57moXG1eaMhodLjF5K9pDWxhKPr6jsw
         +A9GAgBN0GnRbpuBC46fArHaetqxhjg7ObGpQDnSxYL5fyAWiqCbxiVGQ+oG1haA7BsU
         hr02msY5f/PMqYaf24fRL9zYKASki4Du8Tc+0rduo4HKIbo+cxtn4wS4w9fUrUZ+gw81
         Ha4p76PELt0cu5mNTZx1ZRidSDlD3csvyuXJpfbkFmQAk1hpJflH1aDanOqaRBlu09IV
         0JcY2SU6nOzwKCcUr7EnX7zrgVG8MElhWtIqtsJhusakCG2VwjVqGovJ2DTrDioy56Fi
         xf8Q==
X-Gm-Message-State: ANoB5pmio/BYQBODcPQvsVdwbpfORDyrsiBmujCTvNOc3iqzuOS1ouFW
	vxmTYl8KNc5JcjErFrQV7QF2WhphzUULyIhNbtc=
X-Google-Smtp-Source: AA0mqf5GbLLIS2N8vJIv6dCv/a/ZSTTKxahrr9piJxCRPdZMQwEjrAxyRM+tKt7NVogfjU4oVwlVGA==
X-Received: by 2002:a17:90a:d598:b0:218:7734:499 with SMTP id v24-20020a17090ad59800b0021877340499mr45406073pju.2.1669462374460;
        Sat, 26 Nov 2022 03:32:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t70-20020a635f49000000b00460fbe0d75esm3880901pgb.31.2022.11.26.03.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 03:32:53 -0800 (PST)
Message-ID: <6381f965.630a0220.c55e1.51e5@mx.google.com>
Date: Sat, 26 Nov 2022 03:32:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.155-cip21
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline-nfs: 36 runs,
 3 regressions (v5.10.155-cip21)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 26 Nov 2022 11:33:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10116

cip/linux-5.10.y-cip baseline-nfs: 36 runs, 3 regressions (v5.10.155-cip21)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
bcm2711-rpi-4-b       | arm64 | lab-collabora | gcc-10   | defconfig       =
           | 1          =

meson-gxm-khadas-vim2 | arm64 | lab-baylibre  | gcc-10   | defconfig       =
           | 1          =

rk3399-gru-kevin      | arm64 | lab-collabora | gcc-10   | defconfig+arm64-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.155-cip21/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.155-cip21
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      02e30f9cbbfce3d687cb1ab288e46ad20079e8e0 =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
bcm2711-rpi-4-b       | arm64 | lab-collabora | gcc-10   | defconfig       =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/6381f3001b30e1747a2abcfe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-bcm2711-rpi-4-b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-bcm2711-rpi-4-b.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221107.1/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6381f3001b30e1747=
a2abcff
        new failure (last pass: v5.10.154-cip20) =

 =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre  | gcc-10   | defconfig       =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/6381f2dfb02b0894522abd2d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson-gxm-khadas-vi=
m2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson-gxm-khadas-vi=
m2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221107.1/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6381f2dfb02b08945=
22abd2e
        failing since 340 days (last pass: v5.10.8-8301-g3d6168cb89f6, firs=
t fail: v5.10.83-cip1-31-gdcbef6602957) =

 =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
rk3399-gru-kevin      | arm64 | lab-collabora | gcc-10   | defconfig+arm64-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6381f2eeee00b2e9742abd0f

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221107.1/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/6381f2eeee00b2e9742abd31
        failing since 242 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2022-11-26T11:05:04.059196  =

    2022-11-26T11:05:05.097968  /lava-8138471/1/../bin/lava-test-case
    2022-11-26T11:05:05.098394  =

    2022-11-26T11:05:05.129775  <8>[   96.493066] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

