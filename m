Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046F4C54E55
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 14:52:15 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web10.24808.1709304726664315117
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 06:52:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=UkTqAP1m;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e5a50d91b4so1604724b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 06:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709304725; x=1709909525; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3nxn027dELg+MOuaS2G6HbK+sJ3f0x9Ej0TwRklA+xU=;
        b=UkTqAP1mkqNFOFVLAFoDQF2LtqvJS0S2Fa5zchIqXUxtnS11m45e9e/UPwZ/0OxDU0
         4Fi6r0866xj3yV3zLdj1BG6MSLbsWo7uG7nMDiKX60Tgf/BpuSQ8H4dl5DY9ApLuyNfV
         Zb3u7ZXvZo8c07SZJitJFRejrG7tX1AlYNLnUbg7VEkJAGoigLjUMgN8tIHd5OCYGcU5
         6dtw4D3zHawORgarXbLLNzEP6W0Q3q5BOV0sHnyXuq9BRJGny3B8rVDth58mm9H5gwlH
         Do+23F/u0+pCBikkBkPGueTw4cMdBD8/VMkvqgEf7glSUKOzOtBFLD7F+X5jSus+n3SN
         fT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709304725; x=1709909525;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nxn027dELg+MOuaS2G6HbK+sJ3f0x9Ej0TwRklA+xU=;
        b=coaO6HPdzzQqoll3UQLEMfDj/KCRwJLQKGJYenrA/zOerTByja3QbsePY7I4BFSrsf
         BoLI8ZPuvNSIIegB1VT6ZGXhG3UZ65OhUYjgIe3HeNcTrHZKK58TLapf1gcNVzcFseiM
         oVAb2zD90EeRNI3qkBitxoWkMbc93+oEY5RT64eTwuG6viMiULimmzcxAyxy/Ld9tfsf
         Hza3TvL0wYuNIQ5iVjLLdsMmjVV8+vBWPpv5ZqXMTz9w8TW7tVEP8toZ8fyEFXz9Ntdz
         L9UJTTvAeNL8u+wGVx18bX65NY75JrqtOUlehYD4p9M5bSpk4xdPtr8u2jW+N9hNWYh5
         t40w==
X-Gm-Message-State: AOJu0YxBWUK7Bo9JNXolYSFv7ePjXy3TZhOrkYyGowj3Hu6BuAd9bMS5
	0Aou7vrUmZneE0MssaEM6QYda0PjP6eveG2I+SlL6qwMJZhSiMadSPzTpaHpe+gfaoJXp4mP0Cx
	w2FQ=
X-Google-Smtp-Source: AGHT+IHbWxl9pGk5hkaho6CStZkZk64QyAmB0BuR03cybR+5jraRzoVaSlm3Qnk9k+bLexzfJ9DLCg==
X-Received: by 2002:a05:6a20:160d:b0:1a0:dbf2:fd8f with SMTP id l13-20020a056a20160d00b001a0dbf2fd8fmr1865822pzj.21.1709304725252;
        Fri, 01 Mar 2024 06:52:05 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x18-20020aa79a52000000b006e543d6ffb5sm3056119pfj.27.2024.03.01.06.52.03
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 06:52:03 -0800 (PST)
Message-ID: <65e1eb93.a70a0220.8d06c.dd16@mx.google.com>
Date: Fri, 01 Mar 2024 06:52:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.209-cip44-56-gdc749db3de7d1
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 79 runs,
 26 regressions (v5.10.209-cip44-56-gdc749db3de7d1)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 14:52:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15121

cip-gitlab/ci/pavel/linux-test baseline: 79 runs, 26 regressions (v5.10.209=
-cip44-56-gdc749db3de7d1)

Regressions Summary
-------------------

platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
acer-cbv514-1h-34uz-brya  | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig+x86-board | 1          =

acer-chromebox-cxi5-brask | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig+x86-board | 1          =

at91sam9g20ek             | arm    | lab-broonie     | gcc-10   | at91_dt_d=
efconfig          | 5          =

at91sam9g20ek             | arm    | lab-broonie     | gcc-10   | multi_v5_=
defconfig         | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig         | 5          =

beaglebone-black          | arm    | lab-cip         | gcc-10   | multi_v7_=
defconfig         | 5          =

imx6dl-udoo               | arm    | lab-broonie     | gcc-10   | imx_v6_v7=
_defconfig        | 1          =

imx6dl-udoo               | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig         | 1          =

imx6q-udoo                | arm    | lab-broonie     | gcc-10   | imx_v6_v7=
_defconfig        | 1          =

imx6q-udoo                | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig         | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig        | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig         | 1          =

qemu_mips-malta           | mips   | lab-broonie     | gcc-10   | malta_def=
config            | 1          =

qemu_mips-malta           | mips   | lab-collabora   | gcc-10   | malta_def=
config            | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.209-cip44-56-gdc749db3de7d1/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.209-cip44-56-gdc749db3de7d1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      dc749db3de7d1c1c07950e25062de70fd66057ae =



Test Regressions
---------------- =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
acer-cbv514-1h-34uz-brya  | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1daea701d3cc2f0637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e1daea701d3cc2f0637=
013
        failing since 24 days (last pass: v6.1.75-cip14-132-g6e54756fbd6c2,=
 first fail: v5.10.209-cip44-rebase) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
acer-chromebox-cxi5-brask | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1dae135861a1c3e637035

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-chromebox-cxi5-brask.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-chromebox-cxi5-brask.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e1dae135861a1c3e637=
036
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
at91sam9g20ek             | arm    | lab-broonie     | gcc-10   | at91_dt_d=
efconfig          | 5          =


  Details:     https://kernelci.org/test/plan/id/65e1ddbb7f731bbd96637022

  Results:     47 PASS, 6 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/65e=
1ddbb7f731bbd96637027
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T13:52:46.002875  /lava-649839/1/../bin/lava-test-case
    2024-03-01T13:52:46.040923  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =


  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/65e1ddbb7=
f731bbd9663702d
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T13:52:44.448189  /lava-649839/1/../bin/lava-test-case
    2024-03-01T13:52:44.486168  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dsou=
nd-card RESULT=3Dfail>   =


  * baseline.bootrr.audio-card-probed: https://kernelci.org/test/case/id/65=
e1ddbb7f731bbd9663702e
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T13:52:43.354419  /lava-649839/1/../bin/lava-test-case
    2024-03-01T13:52:43.392656  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Daud=
io-card-probed RESULT=3Dfail>   =


  * baseline.bootrr.wm8731-driver-present: https://kernelci.org/test/case/i=
d/65e1ddbb7f731bbd96637032
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T13:52:39.768580  /lava-649839/1/../bin/lava-test-case
    2024-03-01T13:52:39.807432  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Deep=
rom-probed RESULT=3Dblocked>
    2024-03-01T13:52:39.853942  sh: /sys/bus/spi/drivers/wm8731: unknown op=
erand
    2024-03-01T13:52:40.870237  /lava-649839/1/../bin/lava-test-case
    2024-03-01T13:52:40.909050  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dwm8=
731-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
65e1ddbb7f731bbd96637033
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T13:52:38.667077  /lava-649839/1/../bin/lava-test-case
    2024-03-01T13:52:38.705973  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dat2=
4-driver-present RESULT=3Dfail>   =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
at91sam9g20ek             | arm    | lab-broonie     | gcc-10   | multi_v5_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1e117d130007a5c637023

  Results:     48 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/65e=
1e117d130007a5c637028
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T14:07:13.807924  /lava-649844/1/../bin/lava-test-case
    2024-03-01T14:07:13.845704  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig         | 5          =


  Details:     https://kernelci.org/test/plan/id/65e1e11ddf595de1be637012

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65e1e11dd=
f595de1be637015
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T14:07:18.020196  /lava-649846/1/../bin/lava-test-case
    2024-03-01T14:07:18.054865  <8>[   47.579978] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/65e1e11ddf595de1be637018
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T14:07:14.792879  /lava-649846/1/../bin/lava-test-case
    2024-03-01T14:07:14.826811  <8>[   44.351227] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-03-01T14:07:15.853429  /lava-649846/1/../bin/lava-test-case
    2024-03-01T14:07:15.889430  <8>[   45.411237] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
65e1e11ddf595de1be637019
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T14:07:12.670204  /lava-649846/1/../bin/lava-test-case
    2024-03-01T14:07:12.705036  <8>[   42.229253] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-03-01T14:07:13.731536  /lava-649846/1/../bin/lava-test-case
    2024-03-01T14:07:13.765997  <8>[   43.290081] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/65e1e11ddf595de1be63701a
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T14:07:10.542570  /lava-649846/1/../bin/lava-test-case
    2024-03-01T14:07:10.576866  <8>[   40.101308] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-03-01T14:07:11.602791  /lava-649846/1/../bin/lava-test-case
    2024-03-01T14:07:11.643635  <8>[   41.167396] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/65e1e11ddf595de1be637026
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T14:06:58.605780  /lava-649846/1/../bin/lava-test-case
    2024-03-01T14:06:58.636259  <8>[   28.159419] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
beaglebone-black          | arm    | lab-cip         | gcc-10   | multi_v7_=
defconfig         | 5          =


  Details:     https://kernelci.org/test/plan/id/65e1eaf5222a3e5db0637025

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65e1eaf52=
22a3e5db0637028
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T14:49:04.354407  /lava-1101217/1/../bin/lava-test-case
    2024-03-01T14:49:04.388632  <8>[   41.860660] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/65e1eaf5222a3e5db063702b
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T14:49:01.125800  /lava-1101217/1/../bin/lava-test-case
    2024-03-01T14:49:01.158985  <8>[   38.630529] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-03-01T14:49:02.185930  /lava-1101217/1/../bin/lava-test-case
    2024-03-01T14:49:02.222240  <8>[   39.691073] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
65e1eaf5222a3e5db063702c
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T14:48:58.996896  /lava-1101217/1/../bin/lava-test-case
    2024-03-01T14:48:59.035465  <8>[   36.506695] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-03-01T14:49:00.062247  /lava-1101217/1/../bin/lava-test-case
    2024-03-01T14:49:00.098448  <8>[   37.569695] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/65e1eaf5222a3e5db063702d
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T14:48:56.876627  /lava-1101217/1/../bin/lava-test-case
    2024-03-01T14:48:56.909767  <8>[   34.381364] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-03-01T14:48:57.936362  /lava-1101217/1/../bin/lava-test-case
    2024-03-01T14:48:57.970560  <8>[   35.441259] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/65e1eaf5222a3e5db0637038
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T14:48:44.938982  /lava-1101217/1/../bin/lava-test-case
    2024-03-01T14:48:44.977011  <8>[   22.446875] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
imx6dl-udoo               | arm    | lab-broonie     | gcc-10   | imx_v6_v7=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1e5e819a1b99b44637031

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e1e5e819a1b99b44637=
032
        failing since 16 days (last pass: v4.4.302-cip72-1251-g57b839f01594=
4, first fail: v5.10.209-cip44-51-gdb99ac443b0da) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
imx6dl-udoo               | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1e1d67f786ccd55637013

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e1e1d77f786ccd55637=
014
        failing since 16 days (last pass: v4.4.302-cip72-1251-g57b839f01594=
4, first fail: v5.10.209-cip44-51-gdb99ac443b0da) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
imx6q-udoo                | arm    | lab-broonie     | gcc-10   | imx_v6_v7=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1e5d33212545cc8637058

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e1e5d33212545cc8637=
059
        failing since 16 days (last pass: v4.4.302-cip72-1251-g57b839f01594=
4, first fail: v5.10.209-cip44-51-gdb99ac443b0da) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
imx6q-udoo                | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1e1eb7f786ccd5563704c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e1e1eb7f786ccd55637=
04d
        failing since 16 days (last pass: v4.4.302-cip72-1251-g57b839f01594=
4, first fail: v5.10.209-cip44-51-gdb99ac443b0da) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1e4e4a8e64000cd637012

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e1e4e4a8e64000cd637017
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T14:23:10.878569  + set +x
    2024-03-01T14:23:10.878743  [   10.301698] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1031034_1.5.2.3.1>
    2024-03-01T14:23:10.985876  / # #
    2024-03-01T14:23:11.087435  export SHELL=3D/bin/sh
    2024-03-01T14:23:11.087837  #
    2024-03-01T14:23:11.188569  / # export SHELL=3D/bin/sh. /lava-1031034/e=
nvironment
    2024-03-01T14:23:11.189039  =

    2024-03-01T14:23:11.289826  / # . /lava-1031034/environment/lava-103103=
4/bin/lava-test-runner /lava-1031034/1
    2024-03-01T14:23:11.290453  =

    2024-03-01T14:23:11.292911  / # /lava-1031034/bin/lava-test-runner /lav=
a-1031034/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1e0e73c96026a2d63704d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e1e0e73c96026a2d637052
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase)

    2024-03-01T14:06:06.536775  + set[    7.270266] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1031026_1.5.2.3.1>
    2024-03-01T14:06:06.537019   +x
    2024-03-01T14:06:06.642099  / # #
    2024-03-01T14:06:06.743258  export SHELL=3D/bin/sh
    2024-03-01T14:06:06.743752  #
    2024-03-01T14:06:06.844491  / # export SHELL=3D/bin/sh. /lava-1031026/e=
nvironment
    2024-03-01T14:06:06.844988  =

    2024-03-01T14:06:06.945780  / # . /lava-1031026/environment/lava-103102=
6/bin/lava-test-runner /lava-1031026/1
    2024-03-01T14:06:06.946432  =

    2024-03-01T14:06:06.948645  / # /lava-1031026/bin/lava-test-runner /lav=
a-1031026/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
qemu_mips-malta           | mips   | lab-broonie     | gcc-10   | malta_def=
config            | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1de3f4d451af1d363701a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/mips/malta_defconfig/gcc-10/lab-broonie/=
baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/mips/malta_defconfig/gcc-10/lab-broonie/=
baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e1de3f4d451af1d3637=
01b
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
qemu_mips-malta           | mips   | lab-collabora   | gcc-10   | malta_def=
config            | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1dd4666f03463bf637021

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/mips/malta_defconfig/gcc-10/lab-collabor=
a/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/mips/malta_defconfig/gcc-10/lab-collabor=
a/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e1dd4666f03463bf637=
022
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase) =

 =20

