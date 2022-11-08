Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6168AC433FE
	for <webhook@archiver.kernel.org>; Tue,  8 Nov 2022 20:37:34 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web11.2341.1667939849936956617
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 08 Nov 2022 12:37:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=v+7Ri6lO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id k7so15202027pll.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 08 Nov 2022 12:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tDOZfoXjV21znMj4ETehibVSO6rlrsBkY6TwZ6oC/oE=;
        b=v+7Ri6lOPeWt7Rxj98PjrKRf/uS0uwlBFyvssOmajzwHnEQIVgNYZXvN/L+aMXeQQR
         rBHffHU7cPu9kZ+RVGZSHFzuw3dKDVxX7OnXnr4csFLJe73DryjuKw7W69CiDc8EL5PZ
         cXuRs7cpjWXtJg8FFIM5HgAuSxTm2ztyub4Gpi3x188VqN3pUHFXqsHBiYulpcMWWWTL
         PeROM8Bsr5qIeBZT4aZo7ZYeupjTe2T7XCd+Yo8rtI5xoWn0bcPwroQnrBA1kLdhd9Wh
         LaM0pzO+geo4qciOSdAy/r08QkMshcQ/XMS4mDA5XkaPpMHcx4i/oNk12NMYoUf117nq
         CCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDOZfoXjV21znMj4ETehibVSO6rlrsBkY6TwZ6oC/oE=;
        b=Wp2Np8Xfb5cQWmNlVIct0wdcxx3shxrcGDnL8t48JsHBXY79bs6cCqqg2ez2Bi3dCw
         pGaYiQK4VH5do5pzJ6IM9KOmEjSE/Tlxjif8BAJCUG+s6IgqMw/e0obD+dvMTUrQY43y
         eOdzs07OfFJmPgeOeJmnzBsMoKaaJK+PLJi3S8gVMZdSVGCM5q8MaA1IP0w7L9Zm0uqR
         QxCWsB+UAeDeym4iCxOlRhB4Yh9wqrWIEl146G3njMt5idA7NKb6dvnviEBCl7ISgWs6
         kc/MsxZ5Px+xeVtmFIcEN6vPod3TBVJalo2LWMuuIggfPHtXgd7aHWARtCI4XPS5hZIR
         vaFw==
X-Gm-Message-State: ACrzQf16DvMtQ9cCXGbLNlHVz61L+PIJAOysKfdA5HOzZVDjdIXAIaSq
	7cF46uIiEAyDFfFAY+vQ9HoBU+PjQlggqHJ/
X-Google-Smtp-Source: AMsMyM7HxPtX5BhAWRup0DTIS7C06cyDgo2Nnc4gLB16LrTrbSWnEOE17VK8czxwY8c/nU4FxmB9rQ==
X-Received: by 2002:a17:903:284:b0:186:bb2c:b041 with SMTP id j4-20020a170903028400b00186bb2cb041mr56871563plr.36.1667939849094;
        Tue, 08 Nov 2022 12:37:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y34-20020a634b22000000b0046fe244ed6esm6160752pga.23.2022.11.08.12.37.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 12:37:28 -0800 (PST)
Message-ID: <636abe08.630a0220.a4964.9d7a@mx.google.com>
Date: Tue, 08 Nov 2022 12:37:28 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-15-gef247a3cd0ad
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 38 runs,
 4 regressions (v5.10.147-cip18-15-gef247a3cd0ad)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Nov 2022 20:37:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9951

cip-gitlab/ci/pavel/linux-test baseline-nfs: 38 runs, 4 regressions (v5.10.=
147-cip18-15-gef247a3cd0ad)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 3          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.147-cip18-15-gef247a3cd0ad/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.147-cip18-15-gef247a3cd0ad
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ef247a3cd0adc25a8015590a0e7652ad30c2b2f7 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/636aba7b0e950158d2e7db62

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-15-gef247a3cd0ad/arm64/defconfig/gcc-10/lab-baylibre/basel=
ine-nfs-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-15-gef247a3cd0ad/arm64/defconfig/gcc-10/lab-baylibre/basel=
ine-nfs-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221024.1/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/636aba7b0e950158d=
2e7db63
        failing since 5 days (last pass: v5.10.145-518-gc75907dbbb95a, firs=
t fail: v5.10.147-cip18-12-gcb2b164780be) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 3          =


  Details:     https://kernelci.org/test/plan/id/636abd68adaa8ccfdde7db6e

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-15-gef247a3cd0ad/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-15-gef247a3cd0ad/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221024.1/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.cros-ec-sensors-gyro0-probed: https://kernelci.org/=
test/case/id/636abd68adaa8ccfdde7dbb1
        failing since 182 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a)

    2022-11-08T20:34:25.550630  /lava-7902924/1/../bin/lava-test-case
    2022-11-08T20:34:25.584415  <8>[   34.555424] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-gyro0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-sensors-accel1-probed: https://kernelci.org=
/test/case/id/636abd68adaa8ccfdde7dbb2
        failing since 182 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a)

    2022-11-08T20:34:23.445851  =

    2022-11-08T20:34:24.482518  /lava-7902924/1/../bin/lava-test-case
    2022-11-08T20:34:24.513593  <8>[   33.484147] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-accel1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-sensors-accel0-probed: https://kernelci.org=
/test/case/id/636abd68adaa8ccfdde7dbb3
        failing since 182 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a)

    2022-11-08T20:34:22.371054  <8>[   31.341777] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-driver-present RESULT=3Dpass>
    2022-11-08T20:34:23.414763  /lava-7902924/1/../bin/lava-test-case
    2022-11-08T20:34:23.415357  =

    2022-11-08T20:34:23.445233  <8>[   32.416417] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-accel0-probed RESULT=3Dfail>   =

 =20

