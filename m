Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE182C7EE22
	for <webhook@archiver.kernel.org>; Thu, 18 May 2023 11:46:36 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web10.15003.1684410389870845977
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 18 May 2023 04:46:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=DD+Cnb75;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2532c2c419dso1492484a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 18 May 2023 04:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684410389; x=1687002389;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9vaSUGa7OMiRBKEVKIU2xVlvzdYb/+kCLCj8UN6oBbw=;
        b=DD+Cnb75LGcW9NYD/gvVq5AyuLmwcMNSWPWEItChs5jAswVDn+7ahvaRLeoSvd5+aS
         NrIn5luR77MWsBkFt8Fk7f2uNDhvm5iXOyf8TegRzCLfTNs+NMi3S22MNFNMysOze8vD
         pJAQcENkUUFD0PiDZhgSKtlETvK/+dhbSdMVREF+lnR0i3el7COOlcHyQ9NQL37COLYB
         odMLu0uqGGyJcj3N0hSTHan6AYi1QzhxjvmiVCFThdjuxKRO+y6G34K+t0UC7EDDzMJT
         oAw6W4V4FuHWHe5usbuRJGEnVElZ7m4ovekAIz1cK3xtOHB8QX7NTFQKQtiRt5j/vQV0
         rDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684410389; x=1687002389;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vaSUGa7OMiRBKEVKIU2xVlvzdYb/+kCLCj8UN6oBbw=;
        b=TBw00/kV0kh3wKfi1TZVgl69ZKzF2FX8JinxagZpfwZFFexO31hj/ILINhXdOVtArw
         w1RKcnanO8WxPV6dxYg5bvRpqbgvFl/jefJjm/lT7XdBKM6wN7uRI0wDmRzPo+tI53hW
         ZpGhlzJBT5rQ42F51tACxr5eSdNJ//9lNiGb9o0cOHzFqZ9XeZlJy6mmGQHi5N6zJeL0
         NSUqYNj78ffnZaU2kYxiRUTL90o3mTrpRruh336MNheCDXpqMC6zNYc5ftlf7JcIWKnu
         ipyRwGCp0oLvHflZSYArOAe5Rse1r3Kkyjr/qxXIrhU2US9Fft24Ydyk+OtfE8p89Asy
         tOLQ==
X-Gm-Message-State: AC+VfDxYllevAnIwaAkdoiRGn5yO/3N/IOQvNnCJt8QS016mATmtYrme
	N+/68F/TwaQvEwk1zM4BA+V6fYqqMuGaQ8n1WyVHVw==
X-Google-Smtp-Source: ACHHUZ7m6oY1zrqMWHCgHKMpNzmJ0QjjrDV9Ctrl0KUwi0SDOBwxH2croQtl7koXOpsZsQqq2mS9YQ==
X-Received: by 2002:a17:902:d50e:b0:1ab:1351:979e with SMTP id b14-20020a170902d50e00b001ab1351979emr2451086plg.10.1684410388602;
        Thu, 18 May 2023 04:46:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jj10-20020a170903048a00b001aad714400asm1205836plb.229.2023.05.18.04.46.27
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 04:46:28 -0700 (PDT)
Message-ID: <64661014.170a0220.e7a40.1a6c@mx.google.com>
Date: Thu, 18 May 2023 04:46:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.179-cip32-471-g18129e1b68691
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 36 runs,
 7 regressions (v5.10.179-cip32-471-g18129e1b68691)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 May 2023 11:46:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11516

cip-gitlab/ci/pavel/linux-test baseline-nfs: 36 runs, 7 regressions (v5.10.=
179-cip32-471-g18129e1b68691)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig         | 1          =

beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.179-cip32-471-g18129e1b68691/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.179-cip32-471-g18129e1b68691
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      18129e1b6869127ae39e5978bb2fe70ecd53f174 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/64660900f6d75df80d2e8603

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64660900f6d75df80=
d2e8604
        new failure (last pass: v5.10.179-cip32-4-g580ea5dd85ae) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/646606a7b1e024f1dd2e85f8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/646606a7b1e024f1d=
d2e85f9
        failing since 1 day (last pass: v5.10.177-cip31-33-gd59f246891e73, =
first fail: v5.10.179-cip32-4-g580ea5dd85ae) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646607e2b28561c9802e85f9

  Results:     50 PASS, 4 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/6=
46607e2b28561c9802e861f
        new failure (last pass: v5.10.179-cip32-4-g580ea5dd85ae)

    2023-05-18T11:11:06.844971  /lava-480097/1/../bin/lava-test-case
    2023-05-18T11:11:06.899585  <8>[   34.012255] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2023-05-18T11:11:06.899929  /lava-480097/1/../bin/lava-test-case   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64660b510ef1ebebf72e8609

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64660b510ef1ebebf=
72e860a
        failing since 1 day (last pass: v5.10.177-cip31-33-gd59f246891e73, =
first fail: v5.10.179-cip32-4-g580ea5dd85ae) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64660ec3786d5f35ba2e85ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig/gcc-10/lab-cip/baseline=
-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig/gcc-10/lab-cip/baseline=
-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64660ec3786d5f35b=
a2e85ed
        new failure (last pass: v5.10.179-cip32-4-g580ea5dd85ae) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/646607ffb28561c9802e8673

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/646607ffb28561c9802e86a6
        failing since 57 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-05-18T11:11:36.181229  /lava-10371775/1/../bin/lava-test-case

    2023-05-18T11:11:36.232074  <8>[  126.155286] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/646607ffb28561c9802e86a7
        failing since 57 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-05-18T11:11:33.295526  <8>[  123.218781] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-05-18T11:11:34.348226  /lava-10371775/1/../bin/lava-test-case

    2023-05-18T11:11:35.151488  <8>[  125.074306] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

