Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46DAC4167B
	for <webhook@archiver.kernel.org>; Sun, 11 Dec 2022 18:34:14 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web10.23495.1670783645081694038
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 11 Dec 2022 10:34:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=yiM5mO1a;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so13325510pjp.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 11 Dec 2022 10:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B0Vs4Q2xh2sBu0K5a1xDOhaRCwxp5a+yC/wz0Uds3LE=;
        b=yiM5mO1a53/aTUScGltS5TzpDYz1GXlCZqJ5chvcyRI5M7wlGJCgXmBXKsGz4m+v+t
         YZ18+JbYEJlSLXKeBb9s+76S2Fz+qhjXWyLS+PMf7HexPmebBlRGwMSjUJX6mk8xjdcb
         /xT18d7HZKYB+BVb+9czKpuTeee6D3PzSgPRYk76ZxIqWPUstWRecrVZ3M7AppnYDz1U
         Zt0ZVTz0cGVDaFa5GfpTnPVOcVbIGRC31wIICPlOyQifbApxOmeJvh7My3iJZoNL9Y/3
         9+/9UIPTxmKNZvMBqxsop9mDBD5WpEium5mOjKBJniJTNnPpi2tFUsAtvn2zQfmMqhdf
         EKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0Vs4Q2xh2sBu0K5a1xDOhaRCwxp5a+yC/wz0Uds3LE=;
        b=RNCcOqgtXTeKOs9WDw6LhOJlauGJsr/C5yKMey8szjHX1WaLNjsWAxxjcei+iYJ3L3
         l2VQT7xIJnn24YP1MYjvZL/6KhaA71S/jzcB+zwVTKJH5wDK55nIplCjdA4v4XNl3CX3
         VdTgN7L9VapA9VemJHtNPwXHT5KH45dVg7ljBU0y396sMybcAjpd4GSDAv/0do6CvYNw
         lChYwTKyFXit2f7b1x8hY/I2VlUO0+BbYJxRQtcI7wZZrUTELY0UyWUxNnHsmVhbceg5
         orauh/RUnUncSCzAQAGlfd1eA091EeDdma6b1ava250U64VJQQ15Fuak1WlwOf8+7dhL
         itaQ==
X-Gm-Message-State: ANoB5pnzmbiOtz3zWZ3PrT1Y0lY9G9vrb2u6OdESudzhnIRzgDymG4oU
	N4muBbO6g0IdY/Pe/1HDpNHhnL2dgrosBQNj
X-Google-Smtp-Source: AA0mqf5L7+e8oZRhdpODdVGD4w8Vk6XwTd6bJD4NBCJcuFYDc4aEBQ3ucmht14LPviUzcqlw6P7jng==
X-Received: by 2002:a17:902:8f8c:b0:186:7fe2:eb4e with SMTP id z12-20020a1709028f8c00b001867fe2eb4emr12993598plo.48.1670783643808;
        Sun, 11 Dec 2022 10:34:03 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902e9c400b0016c50179b1esm4639488plk.152.2022.12.11.10.34.02
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 10:34:03 -0800 (PST)
Message-ID: <6396229b.170a0220.84555.7fdd@mx.google.com>
Date: Sun, 11 Dec 2022 10:34:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.158-cip22-435-g2c52868ae1cbc
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 44 runs,
 6 regressions (v5.10.158-cip22-435-g2c52868ae1cbc)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 11 Dec 2022 18:34:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10198

cip-gitlab/ci/pavel/linux-test baseline-nfs: 44 runs, 6 regressions (v5.10.=
158-cip22-435-g2c52868ae1cbc)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
at91sam9g20ek                | arm   | lab-broonie   | gcc-10   | multi_v5_=
defconfig         | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

meson-g12b-odroid-n2         | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 3          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.158-cip22-435-g2c52868ae1cbc/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.158-cip22-435-g2c52868ae1cbc
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2c52868ae1cbccd8bfb24f6b41a5fd024c1ca7e8 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
at91sam9g20ek                | arm   | lab-broonie   | gcc-10   | multi_v5_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/63961d5d384157aa712abd20

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm/multi_v5_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm/multi_v5_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221202.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63961d5d384157aa7=
12abd21
        new failure (last pass: v4.19.265-cip85-rt27) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/63961d58ce1519174d2abcfa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm64/defconfig/gcc-10/lab-baylibre/bas=
eline-nfs-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm64/defconfig/gcc-10/lab-baylibre/bas=
eline-nfs-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221202.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63961d58ce1519174=
d2abcfb
        failing since 38 days (last pass: v5.10.145-518-gc75907dbbb95a, fir=
st fail: v5.10.147-cip18-12-gcb2b164780be) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-g12b-odroid-n2         | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/63961bf734f6693adf2abe4a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm64/defconfig/gcc-10/lab-baylibre/bas=
eline-nfs-meson-g12b-odroid-n2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm64/defconfig/gcc-10/lab-baylibre/bas=
eline-nfs-meson-g12b-odroid-n2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221202.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63961bf734f6693ad=
f2abe4b
        failing since 31 days (last pass: v5.10.147-cip18-15-gef247a3cd0ad,=
 first fail: v5.10.145-rt74-1329-ga59fc50f38f6) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 3          =


  Details:     https://kernelci.org/test/plan/id/63961c891c8b37425d2abd13

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221202.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.cros-ec-sensors-gyro0-probed: https://kernelci.org/=
test/case/id/63961c891c8b37425d2abd56
        new failure (last pass: v4.19.265-cip85-rt27)

    2022-12-11T18:07:54.459341  /lava-8333373/1/../bin/lava-test-case
    2022-12-11T18:07:54.460250  =

    2022-12-11T18:07:54.499092  <8>[   94.779925] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-gyro0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-sensors-accel1-probed: https://kernelci.org=
/test/case/id/63961c891c8b37425d2abd57
        new failure (last pass: v4.19.265-cip85-rt27)

    2022-12-11T18:07:52.363764  =

    2022-12-11T18:07:53.385585  /lava-8333373/1/../bin/lava-test-case
    2022-12-11T18:07:53.423062  <8>[   93.703183] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-accel1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-sensors-accel0-probed: https://kernelci.org=
/test/case/id/63961c891c8b37425d2abd58
        new failure (last pass: v4.19.265-cip85-rt27)

    2022-12-11T18:07:52.325919  /lava-8333373/1/../bin/lava-test-case
    2022-12-11T18:07:52.363277  <8>[   92.642419] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-accel0-probed RESULT=3Dfail>   =

 =20

