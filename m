Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04A5CD80B5
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 11:50:57 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.89010.1696938657275593511
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 10 Oct 2023 04:50:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=qGfqprZY;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1c60cec8041so33562895ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 10 Oct 2023 04:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696938656; x=1697543456; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tGzCBI8lW6ysF6ega/2ftaN9LMwFx/249GSooc7FQYo=;
        b=qGfqprZYR1AYZoN85lZA0+/Oh2wmS7ITSXmJ1+54QlyHPfzZOOIBNoJEaBMrHedH0W
         iW/DOWEXF8ihLffG2PugoQZnb1uiGqS3P9JCcwQu3eZnkssjQ+CfKzOvjN/w2+IE7eII
         kwkmIia4c2Hd5mac32f0SrS7rqgBzrE2KQXjEL6RgMLUcvQt8R4Pj6Bl2glMvYkN5uFY
         yeR9GwUhGCHradubX4xlkYY5r3xNWqaZkcPgP0/qX503P/s3HkzPpVe1pbhaTZKs6Vwq
         ZE665eCyDNcLQooF1aQZ265dysEi4NmdWqgZaAkGhRHVuXmgO/SySsc4dJKEwAVCATTF
         IiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696938656; x=1697543456;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tGzCBI8lW6ysF6ega/2ftaN9LMwFx/249GSooc7FQYo=;
        b=Y/c6a6z1Bb6n+yLPAUffAK+05zoLPLGO3/aNZyc5iduAVxbLADRHKejjWGb++HDPYt
         4l/4gR11OzpNpPWLW7UL/wmzA/Jeu/xNtK7UQBJ6a4MIksRcta7VriRrM45WN7gz5hA3
         wPl8t8UPmiTUrevT0xjbs7D26fSUKANX+IRiezSk1zPCQ8KhSc2ZcFGIve/CyssuQRdi
         d0FdHFR9MWBqo8myHx+keyI1IedZdDrhA5SZ0VnO1d2HNB+8UddtZUt4B7wOxYa8ydXk
         bF2R4TB4ipezEzo5p5/dge1MiBcCl6HxNaNSzj7M+Ghntijeug5Y2YXzFC5hiUpe/vCN
         tfIQ==
X-Gm-Message-State: AOJu0YzP2kWXteQR4F75tiTFTkXhuHgY9BMT/8qOP3ySyGtoYDtoHgvx
	c8RsL0YwOQU0ZHVmc2D/Zbf9yVYB+DzkvPSfZi2c4A==
X-Google-Smtp-Source: AGHT+IEoU/gtWQx0F9pH21QEfgAdqpjN+1+6cvkS0ow8UkORSxXYOHkir4ybafQh9g4A9GANyq8oHQ==
X-Received: by 2002:a17:902:da89:b0:1c7:3aad:305e with SMTP id j9-20020a170902da8900b001c73aad305emr18044818plx.27.1696938655634;
        Tue, 10 Oct 2023 04:50:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c3c500b001c61bde04a7sm7200600plj.276.2023.10.10.04.50.54
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:50:54 -0700 (PDT)
Message-ID: <65253a9e.170a0220.bb1b2.f2d0@mx.google.com>
Date: Tue, 10 Oct 2023 04:50:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-553-gd498c00818b88
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 46 runs,
 44 regressions (v5.10.194-553-gd498c00818b88)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 11:50:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13360

cip-gitlab/ci/pavel/linux-test baseline-nfs: 46 runs, 44 regressions (v5.10=
.194-553-gd498c00818b88)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig            | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 7          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 11         =

kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 3          =

kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 3          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 5          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-553-gd498c00818b88/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-553-gd498c00818b88
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d498c00818b8876a72d6eb6c2498058ec80d51bb =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65252f330595c434abefcef7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65252f330595c434a=
befcef8
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/6525334f1abe45ea3cefcef5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/at91_dt_defconfig/gcc-10/lab-broonie/base=
line-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/at91_dt_defconfig/gcc-10/lab-broonie/base=
line-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6525334f1abe45ea3=
cefcef6
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525314700753b06a3efcef3

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/multi_v5_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/multi_v5_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6525314700753b06a3efcf2b
        failing since 0 day (last pass: v5.10.194-cip39-1-g53e59f50ca3ff, f=
irst fail: v5.10.194-cip39-552-gc89b2c57483f0)

    2023-10-10T11:10:20.198490  + set +x
    2023-10-10T11:10:20.198740  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 160526_1.6.2=
.4.1>
    2023-10-10T11:10:20.316394  #
    2023-10-10T11:10:20.419580  / # #export SHELL=3D/bin/sh
    2023-10-10T11:10:20.420357  =

    2023-10-10T11:10:20.522274  / # export SHELL=3D/bin/sh. /lava-160526/en=
vironment
    2023-10-10T11:10:20.523033  =

    2023-10-10T11:10:20.625001  / # . /lava-160526/environment/lava-160526/=
bin/lava-test-runner /lava-160526/1
    2023-10-10T11:10:20.626314  =

    2023-10-10T11:10:20.630304  / # /lava-160526/bin/lava-test-runner /lava=
-160526/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/6525314591b965c04aefcf08

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65253=
14591b965c04aefcf0f
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:10:51.200995  /lava-160535/1/../bin/lava-test-case
    2023-10-10T11:10:51.255216  <8>[   79.329434] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/6525314591b965c04aefcf10
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:10:50.090057  /lava-160535/1/../bin/lava-test-case
    2023-10-10T11:10:50.146894  <8>[   78.220669] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/6525314591b965c04aefcf12
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:10:47.717579  /lava-160535/1/../bin/lava-test-case
    2023-10-10T11:10:47.774017  <8>[   75.848012] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-10-10T11:10:48.829665  /lava-160535/1/../bin/lava-test-case
    2023-10-10T11:10:48.925847  <8>[   76.999091] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/6525314591b965c04aefcf13
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:10:45.494174  /lava-160535/1/../bin/lava-test-case
    2023-10-10T11:10:45.553808  <8>[   73.627638] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-10-10T11:10:46.603457  /lava-160535/1/../bin/lava-test-case
    2023-10-10T11:10:46.665787  <8>[   74.739445] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/6525314591b965c04aefcf14
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:10:43.278369  /lava-160535/1/../bin/lava-test-case
    2023-10-10T11:10:43.334851  <8>[   71.409010] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-10-10T11:10:44.387483  /lava-160535/1/../bin/lava-test-case
    2023-10-10T11:10:44.442580  <8>[   72.515907] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/6525314591b965c04aefcf20
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:10:30.521817  /lava-160535/1/../bin/lava-test-case
    2023-10-10T11:10:30.580064  <8>[   58.653215] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6525314591b965c04aefcf39
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:10:23.206029  <8>[   51.281061] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 160535_1.6.2.4.1>
    2023-10-10T11:10:23.321275  / # #
    2023-10-10T11:10:23.424409  export SHELL=3D/bin/sh
    2023-10-10T11:10:23.425195  #
    2023-10-10T11:10:23.527529  / # export SHELL=3D/bin/sh. /lava-160535/en=
vironment
    2023-10-10T11:10:23.528541  =

    2023-10-10T11:10:23.630958  / # . /lava-160535/environment/lava-160535/=
bin/lava-test-runner /lava-160535/1
    2023-10-10T11:10:23.632123  =

    2023-10-10T11:10:23.635829  / # /lava-160535/bin/lava-test-runner /lava=
-160535/1
    2023-10-10T11:10:23.854320  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6525307d995ddb4cdeefcf36

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/omap2plus_defconfig/gcc-10/lab-broonie/ba=
seline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/omap2plus_defconfig/gcc-10/lab-broonie/ba=
seline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/6525307d995ddb4cdeefcf54
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:07:26.452941  /lava-160520/1/../bin/lava-test-case
    2023-10-10T11:07:26.516086  <8>[   51.845933] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65253298eaf945657aefcf75

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/65253298eaf945657aefcf97
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:16:19.573165  /lava-1018704/1/../bin/lava-test-case
    2023-10-10T11:16:19.749625  <8>[   62.707567] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/652530f76480e7ac15efcf2c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/ba=
seline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/ba=
seline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/652530f76480e7ac1=
5efcf2d
        failing since 117 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee92=
1e9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/652533c50877dc001defcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/652533c50877dc001=
defcef4
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/652530f5a76a57df83efcf2a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/ba=
seline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/ba=
seline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/652530f5a76a57df8=
3efcf2b
        failing since 48 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, fir=
st fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/652533dc51cc3b3c6fefcefc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/652533dc51cc3b3c6=
fefcefd
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 11         =


  Details:     https://kernelci.org/test/plan/id/652535d082c07625c9efcef3

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-broonie/baseline-n=
fs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-broonie/baseline-n=
fs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.led7-probed: https://kernelci.org/test/case/id/6525=
35d082c07625c9efcf04
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:30:05.609339  /lava-160607/1/../bin/lava-test-case
    2023-10-10T11:30:05.663339  <8>[   58.614349] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led6-probed: https://kernelci.org/test/case/id/6525=
35d082c07625c9efcf05
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:30:04.522489  /lava-160607/1/../bin/lava-test-case
    2023-10-10T11:30:04.570335  <8>[   57.522932] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led5-probed: https://kernelci.org/test/case/id/6525=
35d082c07625c9efcf06
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:30:03.435821  /lava-160607/1/../bin/lava-test-case
    2023-10-10T11:30:03.483581  <8>[   56.437572] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led4-probed: https://kernelci.org/test/case/id/6525=
35d082c07625c9efcf07
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:30:02.354940  /lava-160607/1/../bin/lava-test-case
    2023-10-10T11:30:02.396636  <8>[   55.347484] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led3-probed: https://kernelci.org/test/case/id/6525=
35d082c07625c9efcf08
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:30:01.272073  /lava-160607/1/../bin/lava-test-case
    2023-10-10T11:30:01.315822  <8>[   54.267441] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led2-probed: https://kernelci.org/test/case/id/6525=
35d082c07625c9efcf09
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:30:00.169381  /lava-160607/1/../bin/lava-test-case
    2023-10-10T11:30:00.217388  <8>[   53.169457] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led1-probed: https://kernelci.org/test/case/id/6525=
35d082c07625c9efcf0a
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:29:59.082570  /lava-160607/1/../bin/lava-test-case
    2023-10-10T11:29:59.130174  <8>[   52.083310] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led0-probed: https://kernelci.org/test/case/id/6525=
35d082c07625c9efcf0b
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:29:57.996630  /lava-160607/1/../bin/lava-test-case
    2023-10-10T11:29:58.043610  <8>[   50.994785] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.iommu1-probed: https://kernelci.org/test/case/id/65=
2535d082c07625c9efcf1e
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:29:55.745066  /lava-160607/1/../bin/lava-test-case
    2023-10-10T11:29:55.792044  <8>[   48.743110] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case=
/id/652535d082c07625c9efcf2b
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:29:53.812241  /lava-160607/1/../bin/lava-test-case
    2023-10-10T11:29:53.852921  <8>[   46.804647] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/652535d082c07625c9efcf33
        failing since 109 days (last pass: v5.10.182-cip35-8-g2391124f19a70=
, first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-10-10T11:29:50.658514  / # #
    2023-10-10T11:29:50.761642  export SHELL=3D/bin/sh
    2023-10-10T11:29:50.762485  #
    2023-10-10T11:29:50.864481  / # export SHELL=3D/bin/sh. /lava-160607/en=
vironment
    2023-10-10T11:29:50.865336  =

    2023-10-10T11:29:50.967441  / # . /lava-160607/environment/lava-160607/=
bin/lava-test-runner /lava-160607/1
    2023-10-10T11:29:50.968824  =

    2023-10-10T11:29:50.987186  / # /lava-160607/bin/lava-test-runner /lava=
-160607/1
    2023-10-10T11:29:51.143821  + export TESTRUN_ID=3D1_bootrr
    2023-10-10T11:29:51.144381  + cd /lava-160607/1/tests/1_bootrr =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 3          =


  Details:     https://kernelci.org/test/plan/id/6525346a1a48b2d67befcf86

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-kontron/baseline-n=
fs-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-kontron/baseline-n=
fs-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/6525346a1a48b2d67befcfca
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:24:12.529275  /lava-384911/1/../bin/lava-test-case
    2023-10-10T11:24:12.532370  <8>[   19.525687] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/6525346a1a48b2d67befcfcb
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:24:13.565263  /lava-384911/1/../bin/lava-test-case
    2023-10-10T11:24:13.568339  <8>[   20.561900] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-10-10T11:24:14.574411  /lava-384911/1/../bin/lava-test-case
    2023-10-10T11:24:14.603225  <8>[   21.594772] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/6525346a1a48b2d67befcfe2
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:24:17.413726  /lava-384911/1/../bin/lava-test-case
    2023-10-10T11:24:17.443652  <8>[   24.435311] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 3          =


  Details:     https://kernelci.org/test/plan/id/652534686f96063721efcef3

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-kontron/baseline-n=
fs-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-kontron/baseline-n=
fs-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/652534686f96063721efcf3e
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:23:57.896148  /lava-384908/1/../bin/lava-test-case
    2023-10-10T11:23:57.899333  <8>[   16.678016] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/652534686f96063721efcf3f
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:23:58.906835  /lava-384908/1/../bin/lava-test-case
    2023-10-10T11:23:58.930845  <8>[   17.712402] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-10-10T11:23:59.938455  /lava-384908/1/../bin/lava-test-case
    2023-10-10T11:23:59.965423  <8>[   18.746967] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/652534686f96063721efcf54
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:24:02.789084  /lava-384908/1/../bin/lava-test-case
    2023-10-10T11:24:02.813127  <8>[   21.594381] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/652532be8316209164efcf02

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/652532be831620916=
4efcf03
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525339b1abe45ea3cefcf2d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6525339b1abe45ea3=
cefcf2e
        failing since 18 days (last pass: v5.10.194-cip39-500-gc5c4e5fc1681=
7, first fail: v6.1.54-cip6-101-gb060fea6ba099) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/652532b1eaf945657aefcfb4

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/652532b1eaf945657aefcfbe
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:16:53.174516  <8>[   97.216809] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-10-10T11:16:54.223568  /lava-11724205/1/../bin/lava-test-case

    2023-10-10T11:16:54.249456  <8>[   98.293482] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/652532b1eaf945657aefcfbf
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:16:53.141039  /lava-11724205/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525343b20ba227e2befcff8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-collabora/baseline=
-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-collabora/baseline=
-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6525343b20ba227e2befd001
        failing since 109 days (last pass: v5.10.182-cip35-8-g2391124f19a70=
, first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-10-10T11:23:10.163634  / # #

    2023-10-10T11:23:11.424821  export SHELL=3D/bin/sh

    2023-10-10T11:23:11.435820  #

    2023-10-10T11:23:11.436290  / # export SHELL=3D/bin/sh

    2023-10-10T11:23:13.180680  / # . /lava-11724276/environment

    2023-10-10T11:23:16.386494  /lava-11724276/bin/lava-test-runner /lava-1=
1724276/1

    2023-10-10T11:23:16.397835  . /lava-11724276/environment

    2023-10-10T11:23:16.398146  / # /lava-11724276/bin/lava-test-runner /la=
va-11724276/1

    2023-10-10T11:23:16.602649  + export TESTRUN_ID=3D1_bootrr

    2023-10-10T11:23:16.603037  + cd /lava-11724276/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 5          =


  Details:     https://kernelci.org/test/plan/id/65253506329df282e1efcf04

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-broonie/baseline-n=
fs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-broonie/baseline-n=
fs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.sound-card: https://kernelci.org/test/case/id/65253=
506329df282e1efcf1b
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:26:20.191478  /lava-160630/1/../bin/lava-test-case
    2023-10-10T11:26:22.883033  <8>[   69.578461] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Di2s-probed RESULT=3Dblocked>
    2023-10-10T11:26:23.998274  /lava-160630/1/../bin/lava-test-case
    2023-10-10T11:26:30.423361  <8>[   77.118593] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun4i-i2s-driver-present: https://kernelci.org/test=
/case/id/65253506329df282e1efcf1d
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:26:17.854754  /lava-160630/1/../bin/lava-test-case
    2023-10-10T11:26:17.859770  <6>[   64.557055] platform sound: deferred =
probe pending
    2023-10-10T11:26:18.094596  <8>[   64.790367] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-digital-probed RESULT=3Dblocked>
    2023-10-10T11:26:19.137829  /lava-160630/1/../bin/lava-test-case
    2023-10-10T11:26:19.163887  <8>[   65.859022] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun4i-i2s-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun8i-codec-driver-present: https://kernelci.org/te=
st/case/id/65253506329df282e1efcf1e
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:26:15.349553  /lava-160630/1/../bin/lava-test-case
    2023-10-10T11:26:15.379065  <8>[   62.075133] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-analog-probed RESULT=3Dblocked>
    2023-10-10T11:26:16.407222  /lava-160630/1/../bin/lava-test-case
    2023-10-10T11:26:16.818352  <8>[   63.513573] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun50i-codec-analog-driver-present: https://kernelc=
i.org/test/case/id/65253506329df282e1efcf1f
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:26:14.284436  /lava-160630/1/../bin/lava-test-case
    2023-10-10T11:26:14.318159  <8>[   61.011952] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun50i-codec-analog-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65253506329df282e1efcf32
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:25:55.696431  <8>[   42.393711] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 160630_1.6.2.4.1>
    2023-10-10T11:25:55.942618  / # #
    2023-10-10T11:25:56.045177  export SHELL=3D/bin/sh
    2023-10-10T11:25:56.045796  #
    2023-10-10T11:25:56.147470  / # export SHELL=3D/bin/sh. /lava-160630/en=
vironment
    2023-10-10T11:25:56.148182  =

    2023-10-10T11:25:56.250125  / # . /lava-160630/environment/lava-160630/=
bin/lava-test-runner /lava-160630/1
    2023-10-10T11:25:56.251467  =

    2023-10-10T11:25:56.255635  / # /lava-160630/bin/lava-test-runner /lava=
-160630/1
    2023-10-10T11:25:56.480102  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525343e29946b00e8efcefe

  Results:     40 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-broonie/baseline-n=
fs-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-broonie/baseline-n=
fs-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.sun8-codec-analog-driver-present: https://kernelci.=
org/test/case/id/6525343e29946b00e8efcf0d
        failing since 6 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:23:30.764748  /lava-160625/1/../bin/lava-test-case
    2023-10-10T11:23:30.799601  <8>[   46.327638] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8-codec-analog-driver-present RESULT=3Dfail>   =

 =20

