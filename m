Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD6CC4332F
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 22:08:04 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web11.223.1668031668002518053
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 09 Nov 2022 14:07:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=dff0AGKT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id m6so67308pfb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 09 Nov 2022 14:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lr86ipJg6u5EGl8pDV7Il54mZ+Vowg4+rj8b470VBUE=;
        b=dff0AGKTGMLqQPwwJ45lmIAfrXolllQ7ONKchR3YjsFZpSd4B//ZzAIBHHzvsTy8Ul
         mGz+iELnLmi9KIhMxWdNUtbTwTEifYxecmwsROMpmp71vmCBuNteeZBMFNpSTTLe4Fez
         TBEkfSHNDJJnLKH8Hb4+KwlEZKm95GNZmYn0TwCTyPgoFEuPnydS9wFje5lzn9X6mFPG
         NkeZ1cARlmeCSZXS2GQHSnrZTN8mpWQ+FW4OYGlyaHLsSPBuXRSZ+lYDXfm1K+78DnVm
         cJKZ2rTXXqw9XRZhgzqipKoZ0YDQtpAOtKGrFrItcM6gP8VCIfZkn3h1q9EM1nrBn6gg
         LtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lr86ipJg6u5EGl8pDV7Il54mZ+Vowg4+rj8b470VBUE=;
        b=ksS8Ik+znS+BXibpzixLYWMOeiVjxaXduHpyF9yGB/O0IRNovpcMTQP2qpFiJwRQ0K
         +FHux2z9xO3d16niyZ+znYAJtsZ6uQg2qERA/xGR9+QElT4dNxtRz89aYTRhSoJQuaa+
         jmbMmNMSNxuCPhBUew7I+97Nxcd5kSwmIyGUe+/Oa2vppp/gMInHxGnelRzPO/rZa+K5
         1199HxM1T/hi6K/NLxKHDBK86GWgmB/UgDHBZU5C3KgJ6Nox5knl8k0YRGoSnadIZ3Sg
         robiIttiCmO8sqWr9N4GlE11sFRC1cxUwxNJlHIKeNa6SDAUAbFL5TemoCbtQSn1ZO8s
         14HQ==
X-Gm-Message-State: ACrzQf0t9uyq3mK/pk02/HFo1+CIx9aLVUK7FtgNitVV7h6zspyj6eCK
	Fot/K7RpJLspUpW0T9fWgaFH+XyLE2w2AVkpimA=
X-Google-Smtp-Source: AMsMyM5kgcZ74fS9s6TnxQmroSsj2kzaZGtvrXjd8oBQumY0MPDYHB2qMNNprfHlRQQn+6rTXxLyhQ==
X-Received: by 2002:a63:5243:0:b0:43c:96a:8528 with SMTP id s3-20020a635243000000b0043c096a8528mr52805735pgl.47.1668031667168;
        Wed, 09 Nov 2022 14:07:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g74-20020a62524d000000b0055f209690c0sm8759272pfb.50.2022.11.09.14.07.46
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:07:46 -0800 (PST)
Message-ID: <636c24b2.620a0220.43f11.e8c3@mx.google.com>
Date: Wed, 09 Nov 2022 14:07:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-rt74-1329-ga59fc50f38f6
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 33 runs,
 8 regressions (v5.10.145-rt74-1329-ga59fc50f38f6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 22:08:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9972

cip-gitlab/ci/pavel/linux-test baseline-nfs: 33 runs, 8 regressions (v5.10.=
145-rt74-1329-ga59fc50f38f6)

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

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 3          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.145-rt74-1329-ga59fc50f38f6/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.145-rt74-1329-ga59fc50f38f6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a59fc50f38f6208d7d36629eb501bf5191bde812 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
at91sam9g20ek                | arm   | lab-broonie   | gcc-10   | multi_v5_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/636c1ea1080fb59feae7db4e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221024.1/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/636c1ea1080fb59fe=
ae7db4f
        new failure (last pass: v5.10.147-cip18-15-gef247a3cd0ad) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/636c20dbc355af31bee7db6e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm64/defconfig/gcc-10/lab-baylibre/base=
line-nfs-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm64/defconfig/gcc-10/lab-baylibre/base=
line-nfs-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221024.1/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/636c20dbc355af31b=
ee7db6f
        failing since 6 days (last pass: v5.10.145-518-gc75907dbbb95a, firs=
t fail: v5.10.147-cip18-12-gcb2b164780be) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-g12b-odroid-n2         | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/636c20050eddf36353e7db79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm64/defconfig/gcc-10/lab-baylibre/base=
line-nfs-meson-g12b-odroid-n2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm64/defconfig/gcc-10/lab-baylibre/base=
line-nfs-meson-g12b-odroid-n2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221024.1/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/636c20050eddf3635=
3e7db7a
        new failure (last pass: v5.10.147-cip18-15-gef247a3cd0ad) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/636c201a9a972734e5e7db58

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221024.1/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/636c201a9a972734e=
5e7db59
        new failure (last pass: v5.10.147-cip18-15-gef247a3cd0ad) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 3          =


  Details:     https://kernelci.org/test/plan/id/636c1f416cd56d4a76e7db6d

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221024.1/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.cros-ec-sensors-gyro0-probed: https://kernelci.org/=
test/case/id/636c1f416cd56d4a76e7dbb0
        failing since 183 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a)

    2022-11-09T21:44:23.817199  /lava-7922634/1/../bin/lava-test-case
    2022-11-09T21:44:23.845939  <8>[   34.242087] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-gyro0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-sensors-accel1-probed: https://kernelci.org=
/test/case/id/636c1f416cd56d4a76e7dbb1
        failing since 183 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a)

    2022-11-09T21:44:22.742731  /lava-7922634/1/../bin/lava-test-case
    2022-11-09T21:44:22.782429  <8>[   33.174270] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-accel1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-sensors-accel0-probed: https://kernelci.org=
/test/case/id/636c1f416cd56d4a76e7dbb2
        failing since 183 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a)

    2022-11-09T21:44:20.623803  <8>[   31.017979] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-driver-present RESULT=3Dpass>
    2022-11-09T21:44:21.662762  /lava-7922634/1/../bin/lava-test-case
    2022-11-09T21:44:21.702480  <8>[   32.094687] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-accel0-probed RESULT=3Dfail>   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/636c1f476cd56d4a76e7dbcf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm64/defconfig/gcc-10/lab-collabora/bas=
eline-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm64/defconfig/gcc-10/lab-collabora/bas=
eline-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221024.1/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/636c1f476cd56d4a7=
6e7dbd0
        new failure (last pass: v5.10.147-cip18-15-gef247a3cd0ad) =

 =20

