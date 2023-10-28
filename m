Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFB3C4332F
	for <webhook@archiver.kernel.org>; Sat, 28 Oct 2023 20:28:39 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web11.30084.1698524911451016785
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 28 Oct 2023 13:28:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=1CVPz3l3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.176, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5b9390d6bd3so1639838a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 28 Oct 2023 13:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698524910; x=1699129710; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Orsuo7DZ3L8UJn6VNEEpXtwsyX3d+i+VFBzYeEaa7E0=;
        b=1CVPz3l373M2b8/94/BPokXl1tTdzElDlH9vAAYXMHk5gUl1UHX4JECkFWKVSM7fc8
         cMWmyb0ogILMhhHCImHinOdOH/vv9JSlS5gwLhPrPPdbsmG8c5ja3NJoOoi3ptXnc2IN
         4F3MOrYmxefyFXsdevh98EcdpwDiHDStVv5b7vgRpQuk/7Ip/jmeIXrz8H/KSi9vqlCd
         QGUM7VCi5AjXWLnG+UGotoXzGo2mzu0stpGvbU3rTeExpS6sU/kxQkLp31Te9oRCZKs3
         Owc/qimAEAZ/6DKLXY3X8BLabliklZSnOxfMX5QmGQC3IJ7fqOBdpFS0p+2j2eNAreAF
         y/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698524910; x=1699129710;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Orsuo7DZ3L8UJn6VNEEpXtwsyX3d+i+VFBzYeEaa7E0=;
        b=wgltrvvv2ioTN4iElZpTRwnNY4t14XfTtCZ+xf+TNTLoxdeHb/+PFeyy98wuJKUEkh
         oNlx7PHxsEOUhuYTLhCU1GNn3eKjULFDJuF+KkGqz7NLivfXmdGjUdQKwEfmJSNs+kiA
         bENRgqSjeMqmHok7r33SQaSfIh8HPqmjCHFW5Xb0j1bIOuHleFwcyFrV9HW19DlvlzTl
         Zh8siNFVd7CVBoRTrhGqj3MQVG83iHUHjO3IJ+5CjOdtIiG7k+puwY3S8OILkfvh+jEx
         TgxAYENCVRHobCYRaD2olYjXde9k0rWvBH4kWi81o5y8Cmw/lHFrGhJZKA/94XVP4nEb
         JU4Q==
X-Gm-Message-State: AOJu0Yza6nPxEne8Ifg5TqWbw7F9G5QVQ7UhJpGlz7Pt8G2nBX0+CzyJ
	E883SeOuvjFtu2SsxNCOY5iOAnMN3Ufmb6wO7wk=
X-Google-Smtp-Source: AGHT+IErg1J/RQz6UZMBHO8TURnVFjV+w2SGjgggW2UmpNamz9K2cyuCRxmu0kYEbTiqF9npb0S5TQ==
X-Received: by 2002:a17:90b:1a8e:b0:27c:fa8f:4e91 with SMTP id ng14-20020a17090b1a8e00b0027cfa8f4e91mr10819562pjb.23.1698524910067;
        Sat, 28 Oct 2023 13:28:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id pg14-20020a17090b1e0e00b0026801e06ac1sm3092179pjb.30.2023.10.28.13.28.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 13:28:29 -0700 (PDT)
Message-ID: <653d6eed.170a0220.416ca.88c3@mx.google.com>
Date: Sat, 28 Oct 2023 13:28:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.59-cip8-106-g65bd536c294e
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline: 101 runs,
 10 regressions (v6.1.59-cip8-106-g65bd536c294e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 28 Oct 2023 20:28:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13491

cip-gitlab/ci/pavel/linux-test baseline: 101 runs, 10 regressions (v6.1.59-=
cip8-106-g65bd536c294e)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
imx6dl-udoo                  | arm   | lab-broonie   | gcc-10   | imx_v6_v7=
_defconfig        | 1          =

imx6q-udoo                   | arm   | lab-broonie   | gcc-10   | imx_v6_v7=
_defconfig        | 1          =

imx6ul-14x14-evk             | arm   | lab-nxp       | gcc-10   | imx_v6_v7=
_defconfig        | 1          =

imx8mp-evk                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =

rk3288-veyron-jaq            | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig         | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.59-cip8-106-g65bd536c294e/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.59-cip8-106-g65bd536c294e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      65bd536c294e2f5356dabd805e63516e90d72628 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
imx6dl-udoo                  | arm   | lab-broonie   | gcc-10   | imx_v6_v7=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/653d67a7be0bdeeab4efcefd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653d67a7be0bdeeab4efc=
efe
        failing since 1 day (last pass: v4.4-st20-3596-g73e7f2b880d98, firs=
t fail: v6.1.58-cip7-132-gb38ea1474c159) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
imx6q-udoo                   | arm   | lab-broonie   | gcc-10   | imx_v6_v7=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/653d6845f5dd06ef22efd02a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653d6845f5dd06ef22efd=
02b
        failing since 1 day (last pass: v4.4-st20-3596-g73e7f2b880d98, firs=
t fail: v6.1.58-cip7-132-gb38ea1474c159) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
imx6ul-14x14-evk             | arm   | lab-nxp       | gcc-10   | imx_v6_v7=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/653d6863a6bf63350defcf08

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/base=
line-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/base=
line-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653d6864a6bf63350defc=
f09
        failing since 1 day (last pass: v4.4-st20-3596-g73e7f2b880d98, firs=
t fail: v6.1.58-cip7-132-gb38ea1474c159) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
imx8mp-evk                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/653d67013ad5f75819efcefb

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm64/defconfig/gcc-10/lab-broonie/baseline=
-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm64/defconfig/gcc-10/lab-broonie/baseline=
-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/653d67013ad5f75819efcf03
        failing since 1 day (last pass: v5.10.194-915-g33f52aa14b957, first=
 fail: v6.1.58-cip7-132-gb38ea1474c159)

    2023-10-28T19:54:11.497209  <8>[   20.3#
    2023-10-28T19:54:11.498613  47929] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=
=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-10-28T19:54:11.499009  / # <8>[   20.348565] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 205879_1.5.2.4.1>
    2023-10-28T19:54:12.664274  #export SHELL=3D/bin/sh
    2023-10-28T19:54:12.670360  =

    2023-10-28T19:54:14.168696  / # export SHELL=3D/bin/sh. /lava-205879/en=
vironment
    2023-10-28T19:54:14.174894  =

    2023-10-28T19:54:16.895835  / # . /lava-205879/environment/lava-205879/=
bin/lava-test-runner /lava-205879/1
    2023-10-28T19:54:16.902448  =

    2023-10-28T19:54:16.907438  / # /lava-205879/bin/lava-test-runner /lava=
-205879/1 =

    ... (17 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/653d6877cbaa4a5f86efcf00

  Results:     60 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm64/defconfig/gcc-10/lab-broonie/baseline=
-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm64/defconfig/gcc-10/lab-broonie/baseline=
-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/653d6877cbaa4a5f86efcf3e
        failing since 1 day (last pass: v5.10.194-915-g33f52aa14b957, first=
 fail: v6.1.58-cip7-132-gb38ea1474c159)

    2023-10-28T20:00:30.772098  / # <8>[   24.744661] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 205872_1#
    2023-10-28T20:00:30.874936  export SHELL=3D/bin/sh
    2023-10-28T20:00:30.875712  .5.2.4.1>
    2023-10-28T20:00:30.876178  #
    2023-10-28T20:00:30.977966  / # export SHELL=3D/bin/sh. /lava-205872/en=
vironment
    2023-10-28T20:00:30.978783  =

    2023-10-28T20:00:31.080594  / # . /lava-205872/environment/lava-205872/=
bin/lava-test-runner /lava-205872/1
    2023-10-28T20:00:31.081875  =

    2023-10-28T20:00:31.098602  / # /lava-205872/bin/lava-test-runner /lava=
-205872/1
    2023-10-28T20:00:31.162153  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (44 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/653d6704db22a8b24defcf59

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-broonie/baseline-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-broonie/baseline-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/653d6=
704db22a8b24defcf89
        new failure (last pass: v6.1.58-cip7-132-gb38ea1474c159)

    2023-10-28T19:53:39.624574  /lava-205856/1/../bin/lava-test-case
    2023-10-28T19:53:39.639571  <8>[   19.382306] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2023-10-28T19:53:39.639851  /lava-205856/1/../bin/lava-test-case   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/653d67b39453d26e4defcefa

  Results:     50 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm64/defconfig/gcc-10/lab-broonie/baseline=
-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm64/defconfig/gcc-10/lab-broonie/baseline=
-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/653d6=
7b39453d26e4defcf27
        new failure (last pass: v6.1.58-cip7-132-gb38ea1474c159)

    2023-10-28T19:56:32.066049  /lava-205884/1/../bin/lava-test-case
    2023-10-28T19:56:32.083049  <8>[   19.063666] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2023-10-28T19:56:32.083516  /lava-205884/1/../bin/lava-test-case   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/653d6813ce1aa18256efcf51

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-collabora/baseline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-collabora/baseline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653d6813ce1aa18256efc=
f52
        new failure (last pass: v6.1.58-cip7-132-gb38ea1474c159) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3288-veyron-jaq            | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/653d676d9024cad13eefcf0e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm/multi_v7_defconfig/gcc-10/lab-collabora=
/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm/multi_v7_defconfig/gcc-10/lab-collabora=
/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653d676d9024cad13eefc=
f0f
        new failure (last pass: v4.4-st20-3596-g73e7f2b880d98) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/653d67f46ae760f826efcef6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm64/defconfig/gcc-10/lab-broonie/baseline=
-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm64/defconfig/gcc-10/lab-broonie/baseline=
-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653d67f46ae760f826efc=
ef7
        new failure (last pass: v6.1.58-cip7-132-gb38ea1474c159) =

 =20

