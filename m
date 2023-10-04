Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30BFE7B5F3
	for <webhook@archiver.kernel.org>; Wed,  4 Oct 2023 11:11:29 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web11.15730.1696417887912466105
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 04 Oct 2023 04:11:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=d0O9K/6/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1c5db4925f9so6475315ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 04 Oct 2023 04:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696417887; x=1697022687; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+QtTlNGb8XlEpWanDd+yll8RKNFX6oMOxJFzYhfGSCc=;
        b=d0O9K/6/I+R9R17FNZ6yPTKzVUsEdt3XXsZ8JX/mbTuMinDbrVvgfszMnMYzZtL46p
         7XMr7wNB79emPM+fuGERbDEFecSMo9fzLkJhxWSTxUGuGY0O53Bbwbk+3EOD8Mie1KoG
         xDVbpeMKGYly82u/PvekYn9uVF8pCQ9i4bnkAtNJvnfsRYPrR1wUN5UcCwEJy4XDg5EB
         4HaBsCMdxrU4h0PIn+TblpJBKHpuCvgXL1nfI5Tn8He6HGVu3d3DlUIlN0FS6rV/AhQw
         AEqePklUYO6+tYbJkICYKc+rwVJTtpkYx6IPsyzPtpLr2dTHaFL4K5Le/8YmTqMFBeqf
         j4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696417887; x=1697022687;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QtTlNGb8XlEpWanDd+yll8RKNFX6oMOxJFzYhfGSCc=;
        b=PlQMtAftBpS7/yfFABUQCBobPfhkJEtR8Y0hewNT1fUlWj7pnSVC5KzZP2mJroAAUZ
         kOuPSS8gyCjjnLHQvwhYaMaGvGScrmD5JG0qdQKqcLjFFD8w/eM7xQ24dCLbNbi3z/S+
         BEyG+lXKw2lwWzSXp5axktoZi6Mjaak9BAZp3lSBK+N9iJ4aagbmCmbJ0DhpF3szjYi4
         tpkFsIuug/0I+uBbqxOssoo/EPr4ngPDgcy7OcKAV7UnTmj2eUpThxeXDLyoa3N1+689
         V+JRXObpONehTSIvnGQhvV60p2yPwRmmhsEcbrvXMArOGJ70iucO8a42vBwfcYLek5T8
         T8Mg==
X-Gm-Message-State: AOJu0Yxwrz+XdTHyTNdunPpWln7+n5h1jt9ZnLiWSOsTiyH683hzKJVU
	alCpVxgnH3nhoKTDhAptZuNtfOj5tcUGJHj4JBXaxA==
X-Google-Smtp-Source: AGHT+IEMA4ZMBLfX8i2N2r/UZ8fW4D/utrnuoYEFjNytX2I3/PiT/a7CCazsSDXmXj6QMg/8hLcSEA==
X-Received: by 2002:a17:902:f686:b0:1c5:6f43:9502 with SMTP id l6-20020a170902f68600b001c56f439502mr2723688plg.14.1696417885295;
        Wed, 04 Oct 2023 04:11:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902da8200b001b891259eddsm3392874plx.197.2023.10.04.04.11.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 04:11:24 -0700 (PDT)
Message-ID: <651d485c.170a0220.30bd3.8c0c@mx.google.com>
Date: Wed, 04 Oct 2023 04:11:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.194-cip39-1-g53e59f50ca3ff
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 120 runs,
 70 regressions (v5.10.194-cip39-1-g53e59f50ca3ff)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Oct 2023 11:11:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13269

cip-gitlab/ci/pavel/linux-test baseline: 120 runs, 70 regressions (v5.10.19=
4-cip39-1-g53e59f50ca3ff)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig            | 3          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 2          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 7          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 10         =

kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =

kontron-sl28-var3-ads2       | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig              | 1          =

qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 5          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =

rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 5          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-cip39-1-g53e59f50ca3ff/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-cip39-1-g53e59f50ca3ff
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      53e59f50ca3ff023b612a48397ad7e057a9fd408 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651d3c9b430e1c99738a0ac9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651d3c9b430e1c99738a0=
aca
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig            | 3          =


  Details:     https://kernelci.org/test/plan/id/651d3cdf601cbcecaa8a0a77

  Results:     49 PASS, 4 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/at91_dt_defconfig/gcc-10/lab-broonie/=
baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/at91_dt_defconfig/gcc-10/lab-broonie/=
baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/651=
d3cdf601cbcecaa8a0a80
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:22:00.593796  /lava-152015/1/../bin/lava-test-case
    2023-10-04T10:22:00.631780  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =


  * baseline.bootrr.wm8731-driver-present: https://kernelci.org/test/case/i=
d/651d3cdf601cbcecaa8a0a8b
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:21:56.383155  /lava-152015/1/../bin/lava-test-case
    2023-10-04T10:21:56.421331  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Deep=
rom-probed RESULT=3Dblocked>
    2023-10-04T10:21:56.463785  sh: /sys/bus/spi/drivers/wm8731: unknown op=
erand
    2023-10-04T10:21:57.484626  /lava-152015/1/../bin/lava-test-case
    2023-10-04T10:21:57.522897  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dwm8=
731-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
651d3cdf601cbcecaa8a0a8c
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:21:55.281611  /lava-152015/1/../bin/lava-test-case
    2023-10-04T10:21:55.320553  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dat2=
4-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/651d3d6b6fa1f5eec28a0a4c

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/multi_v5_defconfig/gcc-10/lab-broonie=
/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/multi_v5_defconfig/gcc-10/lab-broonie=
/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/651=
d3d6b6fa1f5eec28a0a55
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:24:24.619381  /lava-152017/1/../bin/lava-test-case
    2023-10-04T10:24:24.657630  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d3d6b6fa1f5eec28a0a82
        failing since 12 days (last pass: v5.10.194-cip39-500-gc5c4e5fc1681=
7, first fail: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:24:10.108019  + set +x
    2023-10-04T10:24:10.108509  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 152017_1.5.2=
.4.1>
    2023-10-04T10:24:10.221931  / # #
    2023-10-04T10:24:10.325092  export SHELL=3D/bin/sh
    2023-10-04T10:24:10.325937  #
    2023-10-04T10:24:10.428038  / # export SHELL=3D/bin/sh. /lava-152017/en=
vironment
    2023-10-04T10:24:10.428854  =

    2023-10-04T10:24:10.530949  / # . /lava-152017/environment/lava-152017/=
bin/lava-test-runner /lava-152017/1
    2023-10-04T10:24:10.532304  =

    2023-10-04T10:24:10.535962  / # /lava-152017/bin/lava-test-runner /lava=
-152017/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/651d39c9bd9cbffa938a0ae8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/bcm2835_defconfig/gcc-10/lab-collabor=
a/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/bcm2835_defconfig/gcc-10/lab-collabor=
a/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d39c9bd9cbffa938a0af1
        failing since 48 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-10-04T10:13:12.485037  / # #

    2023-10-04T10:13:12.587163  export SHELL=3D/bin/sh

    2023-10-04T10:13:12.587937  #

    2023-10-04T10:13:12.689329  / # export SHELL=3D/bin/sh. /lava-11675733/=
environment

    2023-10-04T10:13:12.690040  =


    2023-10-04T10:13:12.791458  / # . /lava-11675733/environment/lava-11675=
733/bin/lava-test-runner /lava-11675733/1

    2023-10-04T10:13:12.792600  =


    2023-10-04T10:13:12.809345  / # /lava-11675733/bin/lava-test-runner /la=
va-11675733/1

    2023-10-04T10:13:12.917058  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-04T10:13:12.917564  + cd /lava-11675733/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651d3e8ed8f5a20d7b8a0b10

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-collabo=
ra/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-collabo=
ra/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651d3e8ed8f5a20d7b8a0=
b11
        failing since 48 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/651d3e73d8f5a20d7b8a0ac2

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/651d3e73d=
8f5a20d7b8a0ac9
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:29:00.247926  /lava-152069/1/../bin/lava-test-case
    2023-10-04T10:29:00.282234  <8>[   46.376791] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/65=
1d3e73d8f5a20d7b8a0aca
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:28:59.187105  /lava-152069/1/../bin/lava-test-case
    2023-10-04T10:28:59.222140  <8>[   45.315798] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/651d3e73d8f5a20d7b8a0acc
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:28:57.015500  /lava-152069/1/../bin/lava-test-case
    2023-10-04T10:28:57.051000  <8>[   43.144695] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-10-04T10:28:58.077179  /lava-152069/1/../bin/lava-test-case
    2023-10-04T10:28:58.115029  <8>[   44.206023] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
651d3e73d8f5a20d7b8a0acd
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:28:54.890704  /lava-152069/1/../bin/lava-test-case
    2023-10-04T10:28:54.929296  <8>[   41.022824] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-10-04T10:28:55.954685  /lava-152069/1/../bin/lava-test-case
    2023-10-04T10:28:55.986776  <8>[   42.080356] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/651d3e73d8f5a20d7b8a0ace
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:28:52.768633  /lava-152069/1/../bin/lava-test-case
    2023-10-04T10:28:52.803129  <8>[   38.897008] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-10-04T10:28:53.829913  /lava-152069/1/../bin/lava-test-case
    2023-10-04T10:28:53.863981  <8>[   39.957118] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/651d3e74d8f5a20d7b8a0ada
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:28:40.831788  /lava-152069/1/../bin/lava-test-case
    2023-10-04T10:28:40.870464  <8>[   26.962988] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d3e74d8f5a20d7b8a0af1
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:28:35.070213  <8>[   21.164713] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 152069_1.5.2.4.1>
    2023-10-04T10:28:35.180142  / # #
    2023-10-04T10:28:35.283136  export SHELL=3D/bin/sh
    2023-10-04T10:28:35.283854  #
    2023-10-04T10:28:35.386124  / # export SHELL=3D/bin/sh. /lava-152069/en=
vironment
    2023-10-04T10:28:35.386841  =

    2023-10-04T10:28:35.489172  / # . /lava-152069/environment/lava-152069/=
bin/lava-test-runner /lava-152069/1
    2023-10-04T10:28:35.490431  =

    2023-10-04T10:28:35.495247  / # /lava-152069/bin/lava-test-runner /lava=
-152069/1
    2023-10-04T10:28:35.589946  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d3c710ccada03798a0a74

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/omap2plus_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/omap2plus_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651d3c710ccada03798a0=
a75
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d412cfe00f676058a0a55

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/omap2plus_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/omap2plus_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
51d412cfe00f676058a0a77
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:40:37.055108  /lava-1016756/1/../bin/lava-test-case
    2023-10-04T10:40:37.095074  <8>[   18.003748] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651d3f66f6b61a09918a0a44

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-nxp/baseline-f=
sl-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-nxp/baseline-f=
sl-ls1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d3f66f6b61a09918a0a4b
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:32:48.302316  [   22.651134] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1253645_1.5.2.4.1>
    2023-10-04T10:32:48.408310  =

    2023-10-04T10:32:48.509578  / # #export SHELL=3D/bin/sh
    2023-10-04T10:32:48.510029  =

    2023-10-04T10:32:48.611017  / # export SHELL=3D/bin/sh. /lava-1253645/e=
nvironment
    2023-10-04T10:32:48.611485  =

    2023-10-04T10:32:48.712494  / # . /lava-1253645/environment/lava-125364=
5/bin/lava-test-runner /lava-1253645/1
    2023-10-04T10:32:48.713257  =

    2023-10-04T10:32:48.717355  / # /lava-1253645/bin/lava-test-runner /lav=
a-1253645/1
    2023-10-04T10:32:48.735992  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651d3b8fdc43a8855e8a0a6e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d3b8fdc43a8855e8a0a77
        failing since 48 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-10-04T10:16:49.875997  + set +x<8>[   11.360907] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11675834_1.4.2.3.1>

    2023-10-04T10:16:49.876103  =


    2023-10-04T10:16:49.978132  #

    2023-10-04T10:16:50.078893  / # #export SHELL=3D/bin/sh

    2023-10-04T10:16:50.079070  =


    2023-10-04T10:16:50.179592  / # export SHELL=3D/bin/sh. /lava-11675834/=
environment

    2023-10-04T10:16:50.179771  =


    2023-10-04T10:16:50.280276  / # . /lava-11675834/environment/lava-11675=
834/bin/lava-test-runner /lava-11675834/1

    2023-10-04T10:16:50.280506  =


    2023-10-04T10:16:50.285687  / # /lava-11675834/bin/lava-test-runner /la=
va-11675834/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d3ecd486e9149358a0a52

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/imx_v6_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/imx_v6_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651d3ecd486e9149358a0=
a53
        failing since 42 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, fir=
st fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651d40396f3263f72a8a0a86

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651d40396f3263f72a8a0=
a87
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d3eccc3ca4061088a0a74

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/imx_v6_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/imx_v6_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651d3eccc3ca4061088a0=
a75
        failing since 42 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, fir=
st fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651d403bf5103f9a938a0a5a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651d403bf5103f9a938a0=
a5b
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d3dc324fd974c288a0a5b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/imx_v6_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/imx_v6_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d3dc324fd974c288a0a64
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:25:48.594240  + set +x
    2023-10-04T10:25:48.594546  [   10.317903] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1002460_1.5.2.3.1>
    2023-10-04T10:25:48.702408  / # #
    2023-10-04T10:25:48.804165  export SHELL=3D/bin/sh
    2023-10-04T10:25:48.804802  #
    2023-10-04T10:25:48.906341  / # export SHELL=3D/bin/sh. /lava-1002460/e=
nvironment
    2023-10-04T10:25:48.907077  =

    2023-10-04T10:25:49.008746  / # . /lava-1002460/environment/lava-100246=
0/bin/lava-test-runner /lava-1002460/1
    2023-10-04T10:25:49.009489  =

    2023-10-04T10:25:49.012453  / # /lava-1002460/bin/lava-test-runner /lav=
a-1002460/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651d3e270bcb4eb6108a0acc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-pengutr=
onix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-pengutr=
onix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d3e270bcb4eb6108a0ad5
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:27:44.871412  + set[    7.248915] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1002461_1.5.2.3.1>
    2023-10-04T10:27:44.871586   +x
    2023-10-04T10:27:44.977158  / # #
    2023-10-04T10:27:45.078977  export SHELL=3D/bin/sh
    2023-10-04T10:27:45.079447  #
    2023-10-04T10:27:45.180794  / # export SHELL=3D/bin/sh. /lava-1002461/e=
nvironment
    2023-10-04T10:27:45.181304  =

    2023-10-04T10:27:45.282660  / # . /lava-1002461/environment/lava-100246=
1/bin/lava-test-runner /lava-1002461/1
    2023-10-04T10:27:45.283394  =

    2023-10-04T10:27:45.285682  / # /lava-1002461/bin/lava-test-runner /lav=
a-1002461/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d3dfc9326e5af1d8a0a71

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/ba=
seline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/ba=
seline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
651d3dfc9326e5af1d8a0a79
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:26:50.048241  /lava-1253640/1/../bin/lava-test-case
    2023-10-04T10:26:50.080237  <8>[   32.022451] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dall-cpus-are-online RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651d3e60d8f5a20d7b8a0ab7

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-nxp/bas=
eline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-nxp/bas=
eline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
651d3e60d8f5a20d7b8a0abf
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:28:42.473112  /lava-1253642/1/../bin/lava-test-case
    2023-10-04T10:28:42.494155  <8>[   24.970329] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dall-cpus-are-online RESULT=3Dfail>
    2023-10-04T10:28:42.494455  /lava-1253642/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 10         =


  Details:     https://kernelci.org/test/plan/id/651d3febd7fb3777808a0a50

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.led7-probed: https://kernelci.org/test/case/id/651d3fec=
d7fb3777808a0a61
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:35:02.102270  /lava-152074/1/../bin/lava-test-case
    2023-10-04T10:35:02.125331  <8>[   26.855666] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>
    2023-10-04T10:35:02.125871  /lava-152074/1/../bin/lava-test-case   =


  * baseline.bootrr.led6-probed: https://kernelci.org/test/case/id/651d3fec=
d7fb3777808a0a62
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:35:01.072203  /lava-152074/1/../bin/lava-test-case
    2023-10-04T10:35:01.095226  <8>[   25.825716] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline.bootrr.led5-probed: https://kernelci.org/test/case/id/651d3fec=
d7fb3777808a0a63
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:35:00.043230  /lava-152074/1/../bin/lava-test-case
    2023-10-04T10:35:00.065191  <8>[   24.795797] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline.bootrr.led4-probed: https://kernelci.org/test/case/id/651d3fec=
d7fb3777808a0a64
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:34:59.014075  /lava-152074/1/../bin/lava-test-case
    2023-10-04T10:34:59.036048  <8>[   23.767027] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline.bootrr.led3-probed: https://kernelci.org/test/case/id/651d3fec=
d7fb3777808a0a65
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:34:57.984926  /lava-152074/1/../bin/lava-test-case
    2023-10-04T10:34:58.006912  <8>[   22.737672] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline.bootrr.led2-probed: https://kernelci.org/test/case/id/651d3fec=
d7fb3777808a0a66
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:34:56.955918  /lava-152074/1/../bin/lava-test-case
    2023-10-04T10:34:56.977863  <8>[   21.708945] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline.bootrr.led1-probed: https://kernelci.org/test/case/id/651d3fec=
d7fb3777808a0a67
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:34:55.926735  /lava-152074/1/../bin/lava-test-case
    2023-10-04T10:34:55.948826  <8>[   20.680043] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline.bootrr.led0-probed: https://kernelci.org/test/case/id/651d3fec=
d7fb3777808a0a68
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:34:54.897632  /lava-152074/1/../bin/lava-test-case
    2023-10-04T10:34:54.919709  <8>[   19.650916] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =


  * baseline.bootrr.iommu1-probed: https://kernelci.org/test/case/id/651d3f=
ecd7fb3777808a0a7b
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:34:53.311270  <6>[   18.035594] input: PS/2 Generic Mouse=
 as /devices/platform/bus@8000000/bus@8000000:motherboard-bus/bus@8000000:m=
otherboard-bus:iofpga-bus@300000000/1c070000.kmi/serio1/input/input4
    2023-10-04T10:34:53.441783  <4>[   18.161248] psmouse serio1: Failed to=
 enable mouse on 1c070000.kmi
    2023-10-04T10:34:53.442332  /lava-152074/1/../bin/lava-test-case   =


  * baseline.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case/id/=
651d3fecd7fb3777808a0a88
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:34:52.079310  /lava-152074/1/../bin/lava-test-case
    2023-10-04T10:34:52.101304  <8>[   16.832055] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =


  Details:     https://kernelci.org/test/plan/id/651d3f2b3e7056b5cb8a0a81

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-kontron/baseli=
ne-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-kontron/baseli=
ne-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
651d3f2b3e7056b5cb8a0ac5
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:31:58.828515  /lava-384166/1/../bin/lava-test-case
    2023-10-04T10:31:58.831826  <8>[   13.552087] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/651d3f2b3e7056b5cb8a0ac6
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:31:59.840966  /lava-384166/1/../bin/lava-test-case
    2023-10-04T10:31:59.844346  <8>[   14.569737] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-10-04T10:32:00.864032  /lava-384166/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/651d3f2b3e7056b5cb8a0add
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:32:03.279270  /lava-384166/1/../bin/lava-test-case
    2023-10-04T10:32:03.282567  <8>[   18.001761] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =


  Details:     https://kernelci.org/test/plan/id/651d3f292f566af9dd8a0a60

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-kontron/baseli=
ne-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-kontron/baseli=
ne-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
651d3f292f566af9dd8a0aab
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:31:53.198598  /lava-384165/1/../bin/lava-test-case
    2023-10-04T10:31:53.201869  <8>[   10.953833] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/651d3f292f566af9dd8a0aac
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:31:54.212207  /lava-384165/1/../bin/lava-test-case
    2023-10-04T10:31:54.215314  <8>[   11.972541] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-10-04T10:31:55.234514  /lava-384165/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/651d3f292f566af9dd8a0ac1
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:31:57.666620  /lava-384165/1/../bin/lava-test-case
    2023-10-04T10:31:57.669945  <8>[   15.422013] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651d407c52fab6345f8a0a46

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/651d407c5=
2fab6345f8a0a4d
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:37:43.434222  /lava-152099/1/../bin/lava-test-case
    2023-10-04T10:37:43.446024  <8>[   18.812603] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>
    2023-10-04T10:37:43.446428  + set +x   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/651d421aa24c119c218a0a50

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-broonie/baseline-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-broonie/baseline-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/651d421aa=
24c119c218a0a57
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:44:16.676812  /lava-152117/1/../bin/lava-test-case
    2023-10-04T10:44:16.689476  <8>[   19.065531] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>
    2023-10-04T10:44:16.689860  + set +x   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/651d42044a064c5b7d8a0ab5

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d42044a064c5b7d8a0ac5
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:43:59.989741  + set +x

    2023-10-04T10:43:59.996965  <8>[   15.624179] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11675976_1.5.2.3.1>

    2023-10-04T10:44:00.102251  / # #

    2023-10-04T10:44:00.202894  export SHELL=3D/bin/sh

    2023-10-04T10:44:00.203139  #

    2023-10-04T10:44:00.303885  / # export SHELL=3D/bin/sh. /lava-11675976/=
environment

    2023-10-04T10:44:00.304532  =


    2023-10-04T10:44:00.406114  / # . /lava-11675976/environment/lava-11675=
976/bin/lava-test-runner /lava-11675976/1

    2023-10-04T10:44:00.407380  =


    2023-10-04T10:44:00.410265  / # /lava-11675976/bin/lava-test-runner /la=
va-11675976/1
 =

    ... (20 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/651d3cda601cbcecaa8a0a71

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/mips/malta_defconfig/gcc-10/lab-broonie/b=
aseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/mips/malta_defconfig/gcc-10/lab-broonie/b=
aseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651d3cda601cbcecaa8a0=
a72
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/651d3cc0601cbcecaa8a0a48

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/mips/malta_defconfig/gcc-10/lab-collabora=
/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/mips/malta_defconfig/gcc-10/lab-collabora=
/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651d3cc0601cbcecaa8a0=
a49
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651d391a30f74588d58a0a47

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/shmobile_defconfig/gcc-10/lab-cip/bas=
eline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/shmobile_defconfig/gcc-10/lab-cip/bas=
eline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651d391a30f74588d58a0=
a48
        failing since 14 days (last pass: v6.1.52-cip5-29-g9fee06894d496, f=
irst fail: v5.10.194-cip39-500-gc5c4e5fc16817) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4433d7b25492468a0a60

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d4433d7b25492468a0a67
        failing since 35 days (last pass: v6.1.46-cip4-rt2, first fail: v5.=
10.191-cip38-2-g05fb42f86d06a)

    2023-10-04T10:53:19.839251  + set +x
    2023-10-04T10:53:19.839471  <8>[   83.932956] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1016814_1.5.2.4.1>
    2023-10-04T10:53:19.945154  / # #
    2023-10-04T10:53:21.406133  export SHELL=3D/bin/sh
    2023-10-04T10:53:21.426656  #
    2023-10-04T10:53:21.426866  / # export SHELL=3D/bin/sh
    2023-10-04T10:53:23.380659  / # . /lava-1016814/environment
    2023-10-04T10:53:26.975198  /lava-1016814/bin/lava-test-runner /lava-10=
16814/1
    2023-10-04T10:53:26.995786  . /lava-1016814/environment
    2023-10-04T10:53:26.995894  / # /lava-1016814/bin/lava-test-runner /lav=
a-1016814/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4306e4729107758a0a6a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d4306e4729107758a0a71
        failing since 48 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-10-04T10:48:15.418514  + set +x
    2023-10-04T10:48:15.418729  <8>[   84.284084] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1016826_1.5.2.4.1>
    2023-10-04T10:48:15.524483  / # #
    2023-10-04T10:48:16.986694  export SHELL=3D/bin/sh
    2023-10-04T10:48:17.007265  #
    2023-10-04T10:48:17.007470  / # export SHELL=3D/bin/sh
    2023-10-04T10:48:18.963042  / # . /lava-1016826/environment
    2023-10-04T10:48:22.561692  /lava-1016826/bin/lava-test-runner /lava-10=
16826/1
    2023-10-04T10:48:22.582897  . /lava-1016826/environment
    2023-10-04T10:48:22.583088  / # /lava-1016826/bin/lava-test-runner /lav=
a-1016826/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651d405f242162cb658a0a42

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-cip/baseline-r=
8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-cip/baseline-r=
8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d405f242162cb658a0a49
        failing since 12 days (last pass: v5.10.194-cip39-500-gc5c4e5fc1681=
7, first fail: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:36:52.733990  / # #
    2023-10-04T10:36:54.194037  export SHELL=3D/bin/sh
    2023-10-04T10:36:54.214467  #
    2023-10-04T10:36:54.214620  / # export SHELL=3D/bin/sh
    2023-10-04T10:36:56.167816  / # . /lava-1016813/environment
    2023-10-04T10:36:59.761169  /lava-1016813/bin/lava-test-runner /lava-10=
16813/1
    2023-10-04T10:36:59.781947  . /lava-1016813/environment
    2023-10-04T10:36:59.782059  / # /lava-1016813/bin/lava-test-runner /lav=
a-1016813/1
    2023-10-04T10:36:59.860375  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-04T10:36:59.860589  + cd /lava-1016813/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/651d42ca343374622b8a0a75

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d42ca343374622b8a0a7c
        failing since 12 days (last pass: v5.10.194-cip39-500-gc5c4e5fc1681=
7, first fail: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:47:19.067838  / # #
    2023-10-04T10:47:20.528998  export SHELL=3D/bin/sh
    2023-10-04T10:47:20.549418  #
    2023-10-04T10:47:20.549546  / # export SHELL=3D/bin/sh
    2023-10-04T10:47:22.502836  / # . /lava-1016825/environment
    2023-10-04T10:47:26.096277  /lava-1016825/bin/lava-test-runner /lava-10=
16825/1
    2023-10-04T10:47:26.116874  . /lava-1016825/environment
    2023-10-04T10:47:26.116991  / # /lava-1016825/bin/lava-test-runner /lav=
a-1016825/1
    2023-10-04T10:47:26.193973  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-04T10:47:26.194119  + cd /lava-1016825/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651d3f2f8effe7c8e28a0a46

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-collabora/base=
line-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-collabora/base=
line-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d3f2f8effe7c8e28a0a4f
        failing since 76 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-10-04T10:36:27.710966  / # #

    2023-10-04T10:36:27.812858  export SHELL=3D/bin/sh

    2023-10-04T10:36:27.813060  #

    2023-10-04T10:36:27.913501  / # export SHELL=3D/bin/sh. /lava-11675909/=
environment

    2023-10-04T10:36:27.913629  =


    2023-10-04T10:36:28.014069  / # . /lava-11675909/environment/lava-11675=
909/bin/lava-test-runner /lava-11675909/1

    2023-10-04T10:36:28.014262  =


    2023-10-04T10:36:28.024476  / # /lava-11675909/bin/lava-test-runner /la=
va-11675909/1

    2023-10-04T10:36:28.067837  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-04T10:36:28.083694  + cd /lav<8>[   16.413848] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11675909_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 5          =


  Details:     https://kernelci.org/test/plan/id/651d3e3fd8f5a20d7b8a0a43

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-collabo=
ra/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-collabo=
ra/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/test=
/case/id/651d3e3fd8f5a20d7b8a0a5d
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:32:30.163087  <8>[   21.166313] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-iodomain-driver-present RESULT=3Dpass>

    2023-10-04T10:32:31.174047  /lava-11675889/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/651d3e3fd8f5a20d7b8a0a73
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:32:28.748271  <8>[   19.752036] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dfail>

    2023-10-04T10:32:29.760223  /lava-11675889/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/651d3e3fd8f5a20d7b8a0a74
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:32:27.727270  	-w	P<8>[   18.727426] <LAVA_SIGNAL_TESTCAS=
E TEST_CASE_ID=3Ddwmmc_rockchip-driver-present RESULT=3Dpass>

    2023-10-04T10:32:27.730153  ad to last with leading zeros

    2023-10-04T10:32:27.732652  	-s SEP	String separator

    2023-10-04T10:32:27.736578  /lava-11675889/1/../bin/lava-test-case

    2023-10-04T10:32:27.742623  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-10-04T10:32:27.742843  =


    2023-10-04T10:32:27.747174  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-10-04T10:32:27.747228  =


    2023-10-04T10:32:27.752462  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-10-04T10:32:27.754979  FIRST, INC default to 1.
 =

    ... (6 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/651d3e3fd8f5a20d7b8a0a77
        failing since 256 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-10-04T10:32:27.654542  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   18.657553] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-10-04T10:32:27.656477   multi-call binary.

    2023-10-04T10:32:27.656700  =


    2023-10-04T10:32:27.660999  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-10-04T10:32:27.661236  =


    2023-10-04T10:32:27.666171  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/651d3e3fd8f5a20d7b8a0a78
        failing since 256 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-10-04T10:32:27.635451  <8>[   18.639580] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/651d42233d963077928a0a5f

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/651d42233d963077928a0ab1
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:44:41.551056  /lava-11675954/1/../bin/lava-test-case

    2023-10-04T10:44:41.562169  <8>[   62.208912] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/651d42233d963077928a0ab2
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:44:40.514906  /lava-11675954/1/../bin/lava-test-case

    2023-10-04T10:44:40.526039  <8>[   61.173441] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651d3f6e79ba30a2638a0a4c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-collabora/base=
line-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-collabora/base=
line-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d3f6e79ba30a2638a0a55
        failing since 14 days (last pass: v5.10.191-cip38-29-g9e1aa2001db86=
, first fail: v5.10.194-cip39-500-gc5c4e5fc16817)

    2023-10-04T10:35:09.934187  / # #

    2023-10-04T10:35:11.192935  export SHELL=3D/bin/sh

    2023-10-04T10:35:11.203213  #

    2023-10-04T10:35:11.203318  / # export SHELL=3D/bin/sh

    2023-10-04T10:35:12.944140  / # . /lava-11675908/environment

    2023-10-04T10:35:16.147199  /lava-11675908/bin/lava-test-runner /lava-1=
1675908/1

    2023-10-04T10:35:16.158555  . /lava-11675908/environment

    2023-10-04T10:35:16.158866  / # /lava-11675908/bin/lava-test-runner /la=
va-11675908/1

    2023-10-04T10:35:16.213667  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-04T10:35:16.214156  + cd /lava-11675908/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 5          =


  Details:     https://kernelci.org/test/plan/id/651d3f8146163202978a0a5e

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/651d3f814=
6163202978a0a78
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:33:16.205406  /lava-152090/1/../bin/lava-test-case
    2023-10-04T10:33:16.216262  <8>[   25.542181] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Di2s-probed RESULT=3Dblocked>
    2023-10-04T10:33:17.239504  /lava-152090/1/../bin/lava-test-case
    2023-10-04T10:33:17.249765  <8>[   26.576304] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline.bootrr.sun4i-i2s-driver-present: https://kernelci.org/test/cas=
e/id/651d3f8146163202978a0a79
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:33:14.131871  /lava-152090/1/../bin/lava-test-case
    2023-10-04T10:33:14.143578  <8>[   23.468844] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-digital-probed RESULT=3Dblocked>
    2023-10-04T10:33:15.168819  /lava-152090/1/../bin/lava-test-case
    2023-10-04T10:33:15.180383  <8>[   24.505508] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun4i-i2s-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-codec-driver-present: https://kernelci.org/test/c=
ase/id/651d3f8146163202978a0a7a
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:33:12.068385  /lava-152090/1/../bin/lava-test-case
    2023-10-04T10:33:12.080004  <8>[   21.405612] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-analog-probed RESULT=3Dblocked>
    2023-10-04T10:33:13.104690  /lava-152090/1/../bin/lava-test-case
    2023-10-04T10:33:13.113794  <8>[   22.438812] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun50i-codec-analog-driver-present: https://kernelci.or=
g/test/case/id/651d3f8146163202978a0a7b
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:33:11.028525  /lava-152090/1/../bin/lava-test-case
    2023-10-04T10:33:11.041120  <8>[   20.365993] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun50i-codec-analog-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651d3f8146163202978a0a8e
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-04T10:33:07.867640  + set +x
    2023-10-04T10:33:07.871714  <8>[   17.199022] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 152090_1.5.2.4.1>
    2023-10-04T10:33:07.985196  / # #
    2023-10-04T10:33:08.087769  export SHELL=3D/bin/sh
    2023-10-04T10:33:08.088902  #
    2023-10-04T10:33:08.191058  / # export SHELL=3D/bin/sh. /lava-152090/en=
vironment
    2023-10-04T10:33:08.191762  =

    2023-10-04T10:33:08.293649  / # . /lava-152090/environment/lava-152090/=
bin/lava-test-runner /lava-152090/1
    2023-10-04T10:33:08.294367  =

    2023-10-04T10:33:08.298475  / # /lava-152090/bin/lava-test-runner /lava=
-152090/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651d3f6ccffd5c55588a0a45

  Results:     40 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sun8-codec-analog-driver-present: https://kernelci.org/=
test/case/id/651d3f6ccffd5c55588a0a54
        failing since 20 days (last pass: v6.1.46-cip4-14-gb994de8f45440, f=
irst fail: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-10-04T10:33:09.812885  /lava-152093/1/../bin/lava-test-case
    2023-10-04T10:33:09.825222  <8>[   19.808463] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8-codec-analog-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651d403c6f3263f72a8a0a89

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-cip/baseline-z=
ynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-cip/baseline-z=
ynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651d403c6f3263f72a8a0=
a8a
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/651d42a8f7f291a26c8a0a4d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/651d42a8f7f291a26c8a0=
a4e
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099) =

 =20

