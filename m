Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01005C10F05
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 17:42:06 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web11.42247.1702057320439030782
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Dec 2023 09:42:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=LOst7jqX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d2f1cecf89so4806785ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 08 Dec 2023 09:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702057319; x=1702662119; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6oFIr7iQlaiiJi6fUBeIgzXqkEDExGG0NfdliMY3nXo=;
        b=LOst7jqX8vPsBbKbTzRGkj0rYFg0JhInkPweN+wlrbnBPwurhDizkL/nFnr/r/yG5n
         4a03INqeW6CV/GFifGHJlIgQlX5h/5lj52j0MS9pjmOScpxWTuXkxyk44iyN54qsR75x
         kD+VwRfmHq18CcwQWJYElSUb6xY4dx5id/cWyB60WowC1X+93tum/IAaqg+N51irEIUO
         HJwc7/Z3VW/S71TLCkaGhOcu+i1pM2g9/ZjQK9EGXBtjS8HbyosVWRp5OTOC3jWkjzxs
         f8YqyzFPXNtF5piSR4sh6bACSEDlJgN22QumJOj921umRHMLREkJR0ID28QbxZJZ72B6
         Tskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057319; x=1702662119;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6oFIr7iQlaiiJi6fUBeIgzXqkEDExGG0NfdliMY3nXo=;
        b=pudviq/AuW4EScJbHYcbHGvCBY8eJR7DEuGx0T7en263GKWsAL13wyDp44pxDXUQFp
         rZZfVzdKADkpxWoaEYJ0IxNDWGo+gyXDyKyFMOFY4uiSI7a+xh7npP1/oGGPimy0SKIV
         vV2SadicNhDHFiNWkn2NstP9qwYNv2MiCeibM/E9uSeAaVXD8UF2Oa6XiTkMZ8xg+4ll
         BYWU3NhgL3PHqeI6uzTF5Yfydj2GdY6OtDjORQpGc/kmHSOSgQBO68ON35Sed0JryMgV
         4pvJDIkkjypi596ptj5KUKXo5yVIl1XntoN44P6ksO3IjRS3q0PTndH1i9ImVli0qIDJ
         Wawg==
X-Gm-Message-State: AOJu0Yz/iFIUwwx2Oam0nydE1XJDtKPZbv6zGVQb153DcRZYBjuuH1JW
	dWWbPtWEP3QLem3RIUVILpvdbljSXbJowilKhsRH5A==
X-Google-Smtp-Source: AGHT+IF9NaGVQ3Fnce2rHtwtwkLjhO7tSiFm8J6l083Zn2ifqr2xEYAptoJp6KZL9lCZR0kB9a0jTQ==
X-Received: by 2002:a17:902:d4d2:b0:1ce:5dd8:2f31 with SMTP id o18-20020a170902d4d200b001ce5dd82f31mr399598plg.39.1702057318731;
        Fri, 08 Dec 2023 09:41:58 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z14-20020a170903018e00b001cfc15993efsm1967875plg.163.2023.12.08.09.41.58
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:41:58 -0800 (PST)
Message-ID: <65735566.170a0220.11533.6cb9@mx.google.com>
Date: Fri, 08 Dec 2023 09:41:58 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-63-gfdfe1fbf93bc6
Subject: cip-gitlab/ci/pavel/linux-test baseline: 91 runs,
 31 regressions (v5.10.201-cip41-63-gfdfe1fbf93bc6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 17:42:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13977

cip-gitlab/ci/pavel/linux-test baseline: 91 runs, 31 regressions (v5.10.201=
-cip41-63-gfdfe1fbf93bc6)

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
efconfig          | 3          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig        | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig         | 1          =

juno-uboot                | arm64  | lab-broonie     | gcc-10   | defconfig=
                  | 11         =

kontron-kbox-a-230-ls     | arm64  | lab-kontron     | gcc-10   | defconfig=
                  | 3          =

kontron-sl28-var3-ads2    | arm64  | lab-kontron     | gcc-10   | defconfig=
                  | 3          =

qemu_mips-malta           | mips   | lab-broonie     | gcc-10   | malta_def=
config            | 1          =

qemu_mips-malta           | mips   | lab-collabora   | gcc-10   | malta_def=
config            | 1          =

r8a7743-iwg20d-q7         | arm    | lab-cip         | gcc-10   | shmobile_=
defconfig         | 1          =

rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig         | 3          =

zynqmp-zcu102             | arm64  | lab-cip         | gcc-10   | defconfig=
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-cip41-63-gfdfe1fbf93bc6/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-cip41-63-gfdfe1fbf93bc6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      fdfe1fbf93bc6fe6ed2708f11c2613bef556fdeb =



Test Regressions
---------------- =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
acer-cbv514-1h-34uz-brya  | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65734ce1f419d9bfe8e13476

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65734ce1f419d9bfe8e13=
477
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
acer-chromebox-cxi5-brask | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65734cce2158df55c2e13487

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-chromebox-cxi5-brask.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-chromebox-cxi5-brask.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65734cce2158df55c2e13=
488
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
at91sam9g20ek             | arm    | lab-broonie     | gcc-10   | at91_dt_d=
efconfig          | 3          =


  Details:     https://kernelci.org/test/plan/id/65734840530729218de13486

  Results:     49 PASS, 4 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/657=
34840530729218de1348f
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T16:45:30.437841  /lava-326660/1/../bin/lava-test-case
    2023-12-08T16:45:30.475867  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =


  * baseline.bootrr.wm8731-driver-present: https://kernelci.org/test/case/i=
d/65734840530729218de1349a
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T16:45:26.234933  /lava-326660/1/../bin/lava-test-case
    2023-12-08T16:45:26.273486  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Deep=
rom-probed RESULT=3Dblocked>
    2023-12-08T16:45:26.315258  sh: /sys/bus/spi/drivers/wm8731: unknown op=
erand
    2023-12-08T16:45:27.336374  /lava-326660/1/../bin/lava-test-case
    2023-12-08T16:45:27.374882  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dwm8=
731-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
65734840530729218de1349b
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T16:45:25.133344  /lava-326660/1/../bin/lava-test-case
    2023-12-08T16:45:25.172308  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dat2=
4-driver-present RESULT=3Dfail>   =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65734eb218750d04aae134a5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm/imx_v6_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65734eb218750d04aae134ae
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:12:54.769623  + set +x
    2023-12-08T17:12:54.769925  [   10.406052] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1015876_1.5.2.3.1>
    2023-12-08T17:12:54.876541  / # #
    2023-12-08T17:12:54.977812  export SHELL=3D/bin/sh
    2023-12-08T17:12:54.978400  #
    2023-12-08T17:12:55.079175  / # export SHELL=3D/bin/sh. /lava-1015876/e=
nvironment
    2023-12-08T17:12:55.079628  =

    2023-12-08T17:12:55.180395  / # . /lava-1015876/environment/lava-101587=
6/bin/lava-test-runner /lava-1015876/1
    2023-12-08T17:12:55.181062  =

    2023-12-08T17:12:55.183704  / # /lava-1015876/bin/lava-test-runner /lav=
a-1015876/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65734e4cb8268f276be13489

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm/multi_v7_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65734e4cb8268f276be13492
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:11:31.991798  + set[    7.276684] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1015871_1.5.2.3.1>
    2023-12-08T17:11:31.992067   +x
    2023-12-08T17:11:32.097828  / # #
    2023-12-08T17:11:32.201390  export SHELL=3D/bin/sh
    2023-12-08T17:11:32.201913  #
    2023-12-08T17:11:32.303036  / # export SHELL=3D/bin/sh. /lava-1015871/e=
nvironment
    2023-12-08T17:11:32.303546  =

    2023-12-08T17:11:32.404447  / # . /lava-1015871/environment/lava-101587=
1/bin/lava-test-runner /lava-1015871/1
    2023-12-08T17:11:32.405072  =

    2023-12-08T17:11:32.407802  / # /lava-1015871/bin/lava-test-runner /lav=
a-1015871/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
juno-uboot                | arm64  | lab-broonie     | gcc-10   | defconfig=
                  | 11         =


  Details:     https://kernelci.org/test/plan/id/65734cb4925c94e470e1348e

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.led7-probed: https://kernelci.org/test/case/id/65734cb4=
925c94e470e1349f
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:04:37.607422  /lava-326773/1/../bin/lava-test-case
    2023-12-08T17:04:37.629435  <8>[   27.402011] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>
    2023-12-08T17:04:37.629931  /lava-326773/1/../bin/lava-test-case   =


  * baseline.bootrr.led6-probed: https://kernelci.org/test/case/id/65734cb4=
925c94e470e134a0
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:04:36.578304  /lava-326773/1/../bin/lava-test-case
    2023-12-08T17:04:36.600367  <8>[   26.372507] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline.bootrr.led5-probed: https://kernelci.org/test/case/id/65734cb4=
925c94e470e134a1
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:04:35.548272  /lava-326773/1/../bin/lava-test-case
    2023-12-08T17:04:35.571368  <8>[   25.342925] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline.bootrr.led4-probed: https://kernelci.org/test/case/id/65734cb4=
925c94e470e134a2
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:04:34.519202  /lava-326773/1/../bin/lava-test-case
    2023-12-08T17:04:34.541201  <8>[   24.313759] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline.bootrr.led3-probed: https://kernelci.org/test/case/id/65734cb4=
925c94e470e134a3
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:04:33.490308  /lava-326773/1/../bin/lava-test-case
    2023-12-08T17:04:33.512297  <8>[   23.284276] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline.bootrr.led2-probed: https://kernelci.org/test/case/id/65734cb4=
925c94e470e134a4
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:04:32.461194  /lava-326773/1/../bin/lava-test-case
    2023-12-08T17:04:32.483252  <8>[   22.255547] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline.bootrr.led1-probed: https://kernelci.org/test/case/id/65734cb4=
925c94e470e134a5
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:04:31.432165  /lava-326773/1/../bin/lava-test-case
    2023-12-08T17:04:31.454114  <8>[   21.226435] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline.bootrr.led0-probed: https://kernelci.org/test/case/id/65734cb4=
925c94e470e134a6
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:04:30.403039  /lava-326773/1/../bin/lava-test-case
    2023-12-08T17:04:30.425149  <8>[   20.197088] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =


  * baseline.bootrr.iommu1-probed: https://kernelci.org/test/case/id/65734c=
b4925c94e470e134b9
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:04:28.274118  <6>[   18.036050] input: PS/2 Generic Mouse=
 as /devices/platform/bus@8000000/bus@8000000:motherboard-bus/bus@8000000:m=
otherboard-bus:iofpga-bus@300000000/1c070000.kmi/serio1/input/input4
    2023-12-08T17:04:28.390849  <4>[   18.162162] psmouse serio1: Failed to=
 enable mouse on 1c070000.kmi
    2023-12-08T17:04:28.944253  /lava-326773/1/../bin/lava-test-case
    2023-12-08T17:04:28.947565  <8>[   18.722606] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>   =


  * baseline.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case/id/=
65734cb4925c94e470e134c5
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:04:27.591724  /lava-326773/1/../bin/lava-test-case
    2023-12-08T17:04:27.612647  <8>[   17.384996] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65734cb4925c94e470e134cd
        new failure (last pass: v5.10.201-cip41-63-g2bc5a8583f4a8)

    2023-12-08T17:04:24.998400  / # #
    2023-12-08T17:04:25.101309  export SHELL=3D/bin/sh
    2023-12-08T17:04:25.102142  #
    2023-12-08T17:04:25.204591  / # export SHELL=3D/bin/sh. /lava-326773/en=
vironment
    2023-12-08T17:04:25.205375  =

    2023-12-08T17:04:25.307396  / # . /lava-326773/environment/lava-326773/=
bin/lava-test-runner /lava-326773/1
    2023-12-08T17:04:25.308729  =

    2023-12-08T17:04:25.321719  / # /lava-326773/bin/lava-test-runner /lava=
-326773/1
    2023-12-08T17:04:25.381555  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-08T17:04:25.382074  + cd /lava-326773/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
kontron-kbox-a-230-ls     | arm64  | lab-kontron     | gcc-10   | defconfig=
                  | 3          =


  Details:     https://kernelci.org/test/plan/id/65734c294223ec4dd9e134a3

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
65734c294223ec4dd9e134e3
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:02:22.513746  /lava-403470/1/../bin/lava-test-case
    2023-12-08T17:02:22.517052  <8>[   14.969642] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/65734c294223ec4dd9e134e4
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:02:23.531216  /lava-403470/1/../bin/lava-test-case
    2023-12-08T17:02:23.534523  <8>[   15.987709] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-12-08T17:02:24.553268  /lava-403470/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/65734c294223ec4dd9e134fb
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:02:26.983110  /lava-403470/1/../bin/lava-test-case
    2023-12-08T17:02:26.986488  <8>[   19.434393] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
kontron-sl28-var3-ads2    | arm64  | lab-kontron     | gcc-10   | defconfig=
                  | 3          =


  Details:     https://kernelci.org/test/plan/id/65734c2c85920bf254e134ed

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
65734c2c85920bf254e13534
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:02:16.327160  /lava-403471/1/../bin/lava-test-case
    2023-12-08T17:02:16.330378  <8>[   11.049453] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/65734c2c85920bf254e13535
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:02:17.340732  /lava-403471/1/../bin/lava-test-case
    2023-12-08T17:02:17.344003  <8>[   12.068295] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-12-08T17:02:18.363236  /lava-403471/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/65734c2c85920bf254e1354a
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:02:20.780162  /lava-403471/1/../bin/lava-test-case
    2023-12-08T17:02:20.783382  <8>[   15.501889] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
qemu_mips-malta           | mips   | lab-broonie     | gcc-10   | malta_def=
config            | 1          =


  Details:     https://kernelci.org/test/plan/id/65734cb3925c94e470e13489

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/mips/malta_defconfig/gcc-10/lab-broonie/=
baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/mips/malta_defconfig/gcc-10/lab-broonie/=
baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65734cb3925c94e470e13=
48a
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
qemu_mips-malta           | mips   | lab-collabora   | gcc-10   | malta_def=
config            | 1          =


  Details:     https://kernelci.org/test/plan/id/65734c5f7b1c13e7d4e13486

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/mips/malta_defconfig/gcc-10/lab-collabor=
a/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/mips/malta_defconfig/gcc-10/lab-collabor=
a/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65734c5f7b1c13e7d4e13=
487
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
r8a7743-iwg20d-q7         | arm    | lab-cip         | gcc-10   | shmobile_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/657346dd6d6aa9f27ce13496

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657346dd6d6aa9f27ce13=
497
        failing since 4 days (last pass: v6.1.62-cip9-12-g3a5321f469b07, fi=
rst fail: v6.1.64-cip10-rt5) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig         | 3          =


  Details:     https://kernelci.org/test/plan/id/65734e66865f85766fe13476

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/test=
/case/id/65734e66865f85766fe13490
        failing since 2 days (last pass: v6.1.62-cip9-12-g3a5321f469b07, fi=
rst fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:19:30.089075  /lava-12221561/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/65734e66865f85766fe134a6
        failing since 2 days (last pass: v6.1.62-cip9-12-g3a5321f469b07, fi=
rst fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:19:27.664472  <8>[   19.528191] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dfail>

    2023-12-08T17:19:28.675904  /lava-12221561/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/65734e66865f85766fe134a7
        failing since 2 days (last pass: v6.1.62-cip9-12-g3a5321f469b07, fi=
rst fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:19:26.643396  	-w	P<8>[   18.503510] <LAVA_SIGNAL_TESTCAS=
E TEST_CASE_ID=3Ddwmmc_rockchip-driver-present RESULT=3Dpass>

    2023-12-08T17:19:26.648042  ad to last with leading zeros

    2023-12-08T17:19:26.650610  	-s SEP	String separator

    2023-12-08T17:19:26.654331  /lava-12221561/1/../bin/lava-test-case

    2023-12-08T17:19:26.660448  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-12-08T17:19:26.660665  =


    2023-12-08T17:19:26.664967  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-12-08T17:19:26.665355  =


    2023-12-08T17:19:26.670396  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-12-08T17:19:26.672831  FIRST, INC default to 1.
 =

    ... (6 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
zynqmp-zcu102             | arm64  | lab-cip         | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65734d36f756482450e13499

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65734d36f756482450e13=
49a
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d) =

 =20

