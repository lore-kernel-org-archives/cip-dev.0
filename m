Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F77C0015E
	for <webhook@archiver.kernel.org>; Tue, 11 Jul 2023 14:33:18 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web11.1104.1689085991451322823
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Jul 2023 07:33:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=hf0IiHcn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6687446eaccso5074973b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 11 Jul 2023 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689085990; x=1691677990;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BATj7knpFR+MYzhldtuoCL7zKzqjvKhr4aijsVA8YWs=;
        b=hf0IiHcnjpDJY2uIwM5HvdRifVQxdQbex3dH8tSReisuqf6tf0DufGJIuQdBS7gf6j
         a/Ty/cQTv2xFx9f5QruHGMbmHvl1mB7PnuLLBcPyyVuSKf9VH8tHrhQy5QU3XK/0FvXh
         wqibjsBVIes4/tiRhYwbPRGEb1DXeVHluItiNY9laBTAFKIhqsgh1ltf2hLtTykumAZv
         Qt8O0/u131ChEgeRT7BcxuCDL50jao6pR2PGu99QV47GDPEqLdhkV7CmnLbWy4+eiEqG
         wN2FXr575RBT8at+D3VQFwscBLIkm8Dj5tRsCDiIrb+6MGNQsdvR1FaLiptCEUx8gUMl
         ZMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085990; x=1691677990;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BATj7knpFR+MYzhldtuoCL7zKzqjvKhr4aijsVA8YWs=;
        b=Qmb0O+Ei0J/HE+fjTjxhZ/a5tH4EWCjyv6fexFBLZ5ZK/dUGp5yRWQrjOAfb0Bru9k
         FBNjSP/Akc7lAR+0SbaujlXxG1U+ekbQS229XNQwB8uEO+BcZTjE0kTbOZ/hD1IeqBsl
         Jhz6YZjkhedFBuYD3zdkHoGdcRN2E8g1BfbUTs5v1kCESaZGzwVwUJKNbIkEKGfXKSNT
         7k2kuEwcf1FSjaP/AH5+HnN2JwLD+f5FFEZixDIsl4GL8SZ1JYl+oNkgQWo5V0UVBZX0
         2YAH2VWVTKqyeMiH/bwyPUawIFsW4AiFZO0B0qjwkmBruFlRMFAs7dvyj5Wv30KbPeHw
         nrKg==
X-Gm-Message-State: ABy/qLbI4Xob6OJ3YfjvM8SEc7xKC7Je+oEu+uksOAdVFSD3WAxCkAnm
	DuYjbiuCFx+pJPIL595U0kZZRJqjiVwiZE1oF1Sapg==
X-Google-Smtp-Source: APBJJlFOS7D8jjBbuQiGBrYsEhzx5Ah1q527usZv/wReog0YZL5OQlSp4mlR8kXCf2edHRbaAN7RBw==
X-Received: by 2002:a05:6a00:3907:b0:682:4c1c:a0f6 with SMTP id fh7-20020a056a00390700b006824c1ca0f6mr18515270pfb.3.1689085989909;
        Tue, 11 Jul 2023 07:33:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m22-20020aa78a16000000b00682b3d14005sm1791879pfa.87.2023.07.11.07.33.08
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:33:08 -0700 (PDT)
Message-ID: <64ad6824.a70a0220.bcb80.385d@mx.google.com>
Date: Tue, 11 Jul 2023 07:33:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.184-cip36-13-g8201543bbc8b6
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 72 runs,
 19 regressions (v5.10.184-cip36-13-g8201543bbc8b6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jul 2023 14:33:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12309

cip-gitlab/ci/pavel/linux-test baseline: 72 runs, 19 regressions (v5.10.184=
-cip36-13-g8201543bbc8b6)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 2          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 2          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

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

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.184-cip36-13-g8201543bbc8b6/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.184-cip36-13-g8201543bbc8b6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      8201543bbc8b67c2cfc76e71fda24c2e1f8a7920 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad5f10513255dfc8bb2aa0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ad5f10513255dfc8bb2=
aa1
        new failure (last pass: v6.1.31-65-geef5a19d48f6) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad632f660c84e080bb2a75

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/64a=
d632f660c84e080bb2a7a
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-07-11T14:11:37.472955  /lava-714162/1/../bin/lava-test-case
    2023-07-11T14:11:37.510565  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 2          =


  Details:     https://kernelci.org/test/plan/id/64ad5f6446dd337ea1bb2a84

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
4ad5f6446dd337ea1bb2a9f
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-07-11T13:55:36.751592  /lava-714183/1/../bin/lava-test-case
    2023-07-11T13:55:36.795293  <8>[   24.232057] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ad5f6446dd337ea1bb2aba
        failing since 27 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-11T13:55:32.849920  <8>[   20.288109] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 714183_1.5.2.4.1>
    2023-07-11T13:55:32.958409  / # #
    2023-07-11T13:55:33.060592  export SHELL=3D/bin/sh
    2023-07-11T13:55:33.061184  #
    2023-07-11T13:55:33.162688  / # export SHELL=3D/bin/sh. /lava-714183/en=
vironment
    2023-07-11T13:55:33.163255  =

    2023-07-11T13:55:33.264748  / # . /lava-714183/environment/lava-714183/=
bin/lava-test-runner /lava-714183/1
    2023-07-11T13:55:33.265490  =

    2023-07-11T13:55:33.270015  / # /lava-714183/bin/lava-test-runner /lava=
-714183/1
    2023-07-11T13:55:33.372197  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 2          =


  Details:     https://kernelci.org/test/plan/id/64ad5f7a71e948b242bb2a92

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ad5f7a71e948b242bb2a95
        failing since 27 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-11T13:55:53.786610  <8>[   13.076866] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 985058_1.5.2.4.1>
    2023-07-11T13:55:53.896370  / # #
    2023-07-11T13:55:53.997802  export SHELL=3D/bin/sh
    2023-07-11T13:55:53.998108  #
    2023-07-11T13:55:54.099237  / # export SHELL=3D/bin/sh. /lava-985058/en=
vironment
    2023-07-11T13:55:54.099650  =

    2023-07-11T13:55:54.200849  / # . /lava-985058/environment/lava-985058/=
bin/lava-test-runner /lava-985058/1
    2023-07-11T13:55:54.201846  =

    2023-07-11T13:55:54.208018  / # /lava-985058/bin/lava-test-runner /lava=
-985058/1
    2023-07-11T13:55:54.306238  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =


  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
4ad5f7a71e948b242bb2ab0
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-07-11T13:55:57.674631  /lava-985058/1/../bin/lava-test-case
    2023-07-11T13:55:57.712830  <8>[   17.000646] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad5e0db87cfa1d93bb2aa3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ad5e0db87cfa1d93bb2aa8
        failing since 27 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-11T13:50:05.403132  + set +x

    2023-07-11T13:50:05.409918  <8>[   15.055478] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11061501_1.4.2.3.1>

    2023-07-11T13:50:05.518384  / # #

    2023-07-11T13:50:05.620733  export SHELL=3D/bin/sh

    2023-07-11T13:50:05.621429  #

    2023-07-11T13:50:05.722839  / # export SHELL=3D/bin/sh. /lava-11061501/=
environment

    2023-07-11T13:50:05.723543  =


    2023-07-11T13:50:05.825054  / # . /lava-11061501/environment/lava-11061=
501/bin/lava-test-runner /lava-11061501/1

    2023-07-11T13:50:05.826346  =


    2023-07-11T13:50:05.831031  / # /lava-11061501/bin/lava-test-runner /la=
va-11061501/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad5e1db87cfa1d93bb2ad7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ad5e1db87cfa1d93bb2adc
        failing since 27 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-11T13:50:38.511834  + <8>[   12.898533] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11061516_1.4.2.3.1>

    2023-07-11T13:50:38.511913  set +x

    2023-07-11T13:50:38.613255  =


    2023-07-11T13:50:38.713851  / # #export SHELL=3D/bin/sh

    2023-07-11T13:50:38.714031  =


    2023-07-11T13:50:38.814543  / # export SHELL=3D/bin/sh. /lava-11061516/=
environment

    2023-07-11T13:50:38.814757  =


    2023-07-11T13:50:38.915321  / # . /lava-11061516/environment/lava-11061=
516/bin/lava-test-runner /lava-11061516/1

    2023-07-11T13:50:38.915588  =


    2023-07-11T13:50:38.920088  / # /lava-11061516/bin/lava-test-runner /la=
va-11061516/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad5f7b71e948b242bb2ace

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ad5f7b71e948b242bb2=
acf
        failing since 27 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad5f7971e948b242bb2a8f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ad5f7971e948b242bb2=
a90
        failing since 27 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad5e6241e1e73bc5bb2a89

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ad5e6241e1e73bc5bb2a8e
        new failure (last pass: v6.1.31-65-geef5a19d48f6)

    2023-07-11T13:51:21.815940  + set +x
    2023-07-11T13:51:21.816107  [   10.264574] <LAVA_SIGNAL_ENDRUN 0_dmesg =
994829_1.5.2.3.1>
    2023-07-11T13:51:21.924503  / # #
    2023-07-11T13:51:22.026523  export SHELL=3D/bin/sh
    2023-07-11T13:51:22.027008  #
    2023-07-11T13:51:22.128335  / # export SHELL=3D/bin/sh. /lava-994829/en=
vironment
    2023-07-11T13:51:22.128799  =

    2023-07-11T13:51:22.230122  / # . /lava-994829/environment/lava-994829/=
bin/lava-test-runner /lava-994829/1
    2023-07-11T13:51:22.230887  =

    2023-07-11T13:51:22.233578  / # /lava-994829/bin/lava-test-runner /lava=
-994829/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad617d4de2a73f4cbb2ab3

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-broonie/baseline-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-broonie/baseline-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/64ad617d4=
de2a73f4cbb2ab6
        failing since 27 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-11T14:04:33.262667  /lava-714196/1/../bin/lava-test-case
    2023-07-11T14:04:33.272894  <8>[   18.701835] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad618b44c8fad84fbb2a7e

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ad618b44c8fad84fbb2a9a
        failing since 27 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-11T14:04:43.016562  + set +x

    2023-07-11T14:04:43.022006  <8>[   15.604571] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11061666_1.5.2.3.1>

    2023-07-11T14:04:43.131294  / # #

    2023-07-11T14:04:43.233294  export SHELL=3D/bin/sh

    2023-07-11T14:04:43.233940  #

    2023-07-11T14:04:43.335371  / # export SHELL=3D/bin/sh. /lava-11061666/=
environment

    2023-07-11T14:04:43.336121  =


    2023-07-11T14:04:43.437833  / # . /lava-11061666/environment/lava-11061=
666/bin/lava-test-runner /lava-11061666/1

    2023-07-11T14:04:43.439095  =


    2023-07-11T14:04:43.441373  / # /lava-11061666/bin/lava-test-runner /la=
va-11061666/1
 =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad5f3ec44f4f0f73bb2a85

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/mips/malta_defconfig/gcc-10/lab-broonie/=
baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/mips/malta_defconfig/gcc-10/lab-broonie/=
baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ad5f3ec44f4f0f73bb2=
a86
        new failure (last pass: v6.1.31-65-geef5a19d48f6) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad5ef0513255dfc8bb2a8f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/mips/malta_defconfig/gcc-10/lab-collabor=
a/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/mips/malta_defconfig/gcc-10/lab-collabor=
a/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ad5ef0513255dfc8bb2=
a90
        new failure (last pass: v6.1.31-65-geef5a19d48f6) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad5f1f513255dfc8bb2aa6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ad5f1f513255dfc8bb2=
aa7
        failing since 2 days (last pass: v6.1.31-61-g32a95f5a4e3b, first fa=
il: v6.1.31-65-geef5a19d48f6) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64ad61dfa9d89b665dbb2c14

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64ad61dfa9d89b665dbb2c1a
        failing since 27 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-11T14:06:05.739787  /lava-11061665/1/../bin/lava-test-case

    2023-07-11T14:06:05.750216  <8>[   62.081568] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64ad61dfa9d89b665dbb2c1b
        failing since 27 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-11T14:06:04.701731  /lava-11061665/1/../bin/lava-test-case

    2023-07-11T14:06:04.713291  <8>[   61.044308] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad627a55406c5bd6bb2a8f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ad627a55406c5bd6bb2=
a90
        failing since 27 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70) =

 =20

