Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA59C7EE37
	for <webhook@archiver.kernel.org>; Fri,  9 Jun 2023 18:09:34 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web11.1750.1686334171090105849
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Jun 2023 11:09:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=2AjicUWg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1b04706c974so10137275ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Jun 2023 11:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686334170; x=1688926170;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MZ+BohYrXJOoQskqvcfSBhEwEOhESyS8k0G+V+Y+wMQ=;
        b=2AjicUWgn8t0EQfWvuII6lUFULvL/MabYh/YTe7gJri8e3wHe9g1D8PBRNURgWEdnn
         8b4aEQPNglRPIvRGBq2QbcmaudRFBzlC46gKtQR95ep/qhsKSludKm7mX39GluZgaux9
         IGsUGImNRt3EYggeQXksKsr20bsEmGbQvx8HOWxm8wcf6fHVoNUyPF2mciK8EWoxmXhc
         UivHiVqreH8rA+ds53auKf9iqR2Ma4MMG8MPf3VZN8pyoNXMmQ/1UHgJH4XvxCOQlrSc
         mHQNhFeKLQ7EXzchlv+ucWupYYdIaObQJxh6q+Y9BqUVJL3GvpvWvCIdHo4IR+78Y5/w
         TcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686334170; x=1688926170;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZ+BohYrXJOoQskqvcfSBhEwEOhESyS8k0G+V+Y+wMQ=;
        b=fjtRJmMw33KYr9LN/TT720UlR0KecDO0Fz9EKhx5v9mfkQ+ET+X8Q/veiG495SSl8R
         hR4eEQnJQRk7lXfLfZrOzz8s6MSCr3lw8pgR406iQJH0BsxnB49UxosFyaqmVk3WQj8v
         yTf4459jJiyx+DMjLcGlx5toLhjTYC+YA9UK5XdRAjxRTOB7s/NXorcCOPJARuFtuLoW
         BS8s0rCkNMJkFHN6ytV5Zvye47aBYC1GADs0BrFnBADtsRgiehBNYQuy84rhMOrNPKOK
         O+2hLUccQX7pDRyCHsuwawBtV9miy4UHMhCTixQQ6f5HHj1eX2U83idYlsxRbxWfybcb
         llqQ==
X-Gm-Message-State: AC+VfDwVYsCuk5RYqJ29HKy0D3yoRvfj8PcAw+lwUtHlxVE0oOn+TFYF
	QO9c/ILOnm61fKwCBru5mW7tAUyDCVEgI3tHgx8AIQ==
X-Google-Smtp-Source: ACHHUZ7PH2hAbUj+FknSq+SfuMw/DIcDqaZzFsbNp0y16aS82tLWvfSVgLieInWdsFeQYTyniL78BA==
X-Received: by 2002:a17:903:32cb:b0:1b0:3742:e732 with SMTP id i11-20020a17090332cb00b001b03742e732mr2531624plr.23.1686334168940;
        Fri, 09 Jun 2023 11:09:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902ba8900b001a5260a6e6csm3540554pls.206.2023.06.09.11.09.27
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:09:28 -0700 (PDT)
Message-ID: <64836ad8.170a0220.5250d.7d79@mx.google.com>
Date: Fri, 09 Jun 2023 11:09:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.283-cip98-1248-gcaf6e8ee921e9
Subject: cip-gitlab/ci/pavel/linux-test baseline: 65 runs,
 43 regressions (v4.19.283-cip98-1248-gcaf6e8ee921e9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jun 2023 18:09:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11953

cip-gitlab/ci/pavel/linux-test baseline: 65 runs, 43 regressions (v4.19.283=
-cip98-1248-gcaf6e8ee921e9)

Regressions Summary
-------------------

platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

asus-cx9400-volteer       | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig           | 8          =

beaglebone-black          | arm    | lab-cip         | gcc-10   | multi_v7_=
defconfig           | 8          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | omap2plus=
_defconfig          | 5          =

beaglebone-black          | arm    | lab-cip         | gcc-10   | omap2plus=
_defconfig          | 5          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig          | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig           | 1          =

qemu_mips-malta           | mips   | lab-broonie     | gcc-10   | malta_def=
config              | 1          =

qemu_mips-malta           | mips   | lab-collabora   | gcc-10   | malta_def=
config              | 1          =

qemu_x86_64-uefi-mixed    | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fconfig             | 1          =

qemu_x86_64-uefi-mixed    | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

qemu_x86_64-uefi-mixed    | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig             | 1          =

qemu_x86_64-uefi-mixed    | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 6          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.283-cip98-1248-gcaf6e8ee921e9/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.283-cip98-1248-gcaf6e8ee921e9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      caf6e8ee921e9e7714b8669fc9187fcd56d5a5e6 =



Test Regressions
---------------- =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6483603fac53c5c07530612f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6483603fac53c5c075306=
130
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64835fdbeef132ccba306134

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64835fdbeef132ccba306=
135
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64835f678d61119798306132

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64835f678d61119798306=
133
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig           | 8          =


  Details:     https://kernelci.org/test/plan/id/6483623857bf59f5d330615d

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/arm/multi_v7_defconfig/gcc-10/lab-broo=
nie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/arm/multi_v7_defconfig/gcc-10/lab-broo=
nie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/648362385=
7bf59f5d3306160
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:32:36.239963  /lava-590078/1/../bin/lava-test-case
    2023-06-09T17:32:36.256588  <8>[   45.511593] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/6483623857bf59f5d3306163
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:32:33.067842  /lava-590078/1/../bin/lava-test-case
    2023-06-09T17:32:33.085471  <8>[   42.340038] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-06-09T17:32:34.109590  /lava-590078/1/../bin/lava-test-case
    2023-06-09T17:32:34.127319  <8>[   43.381547] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/6483623857bf59f5d3306167
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:32:16.232112  /lava-590078/1/../bin/lava-test-case
    2023-06-09T17:32:16.250105  <8>[   25.503338] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-06-09T17:32:17.274916  /lava-590078/1/../bin/lava-test-case
    2023-06-09T17:32:17.293036  <8>[   26.545798] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/6483623857bf59f5d3306170
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:32:08.251531  /lava-590078/1/../bin/lava-test-case
    2023-06-09T17:32:08.269574  <8>[   17.522307] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
6483623857bf59f5d3306174
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:32:29.960312  <8>[   39.213409] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>
    2023-06-09T17:32:30.985061  /lava-590078/1/../bin/lava-test-case
    2023-06-09T17:32:31.002149  <8>[   40.255973] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-06-09T17:32:32.026087  /lava-590078/1/../bin/lava-test-case
    2023-06-09T17:32:32.043569  <8>[   41.298167] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/6483623857bf59f5d3306175
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:32:28.900557  /lava-590078/1/../bin/lava-test-case
    2023-06-09T17:32:28.917720  <8>[   38.171758] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-06-09T17:32:29.951598  /lava-590078/1/../bin/lava-test-case   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/6483623857bf59f5d330617a
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:32:15.188959  /lava-590078/1/../bin/lava-test-case
    2023-06-09T17:32:15.207318  <8>[   24.460219] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/6483623857bf59f5=
d330618c
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)
        1 lines

    2023-06-09T17:32:04.876979  / # =

    2023-06-09T17:32:04.882514  =

    2023-06-09T17:32:04.987256  / # #
    2023-06-09T17:32:04.992474  #
    2023-06-09T17:32:05.094894  / # export SHELL=3D/bin/sh
    2023-06-09T17:32:05.100338  export SHELL=3D/bin/sh
    2023-06-09T17:32:05.202162  / # . /lava-590078/environment
    2023-06-09T17:32:05.207540  . /lava-590078/environment
    2023-06-09T17:32:05.309576  / # /lava-590078/bin/lava-test-runner /lava=
-590078/0
    2023-06-09T17:32:05.314683  /lava-590078/bin/lava-test-runner /lava-590=
078/0 =

    ... (9 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-cip         | gcc-10   | multi_v7_=
defconfig           | 8          =


  Details:     https://kernelci.org/test/plan/id/6483645378b69684a4306138

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/arm/multi_v7_defconfig/gcc-10/lab-cip/=
baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/arm/multi_v7_defconfig/gcc-10/lab-cip/=
baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/6483645378b69684a430613e
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:41:03.659757  /lava-958344/1/../bin/lava-test-case
    2023-06-09T17:41:03.677720  <8>[   12.511880] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/6483645378b69684a4306153
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:41:10.596574  /lava-958344/1/../bin/lava-test-case
    2023-06-09T17:41:10.614883  <8>[   19.448935] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/6483645378b69684a4306154
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:41:11.639833  /lava-958344/1/../bin/lava-test-case
    2023-06-09T17:41:11.657632  <8>[   20.492225] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-06-09T17:41:12.682531  /lava-958344/1/../bin/lava-test-case
    2023-06-09T17:41:12.700855  <8>[   21.534999] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/6483645378b69684a430615e
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:41:24.309383  /lava-958344/1/../bin/lava-test-case
    2023-06-09T17:41:24.319964  <6>[   33.157820] platform sound: deferred =
probe pending
    2023-06-09T17:41:24.335955  <8>[   33.171657] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-06-09T17:41:25.360476  /lava-958344/1/../bin/lava-test-case
    2023-06-09T17:41:25.378538  <8>[   34.213499] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
6483645378b69684a430615f
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:41:26.402994  /lava-958344/1/../bin/lava-test-case
    2023-06-09T17:41:26.420860  <8>[   35.256218] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-06-09T17:41:27.445182  /lava-958344/1/../bin/lava-test-case
    2023-06-09T17:41:27.462556  <8>[   36.297977] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/6483645378b69684a4306160
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:41:28.487197  /lava-958344/1/../bin/lava-test-case
    2023-06-09T17:41:28.504456  <8>[   37.340170] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-06-09T17:41:29.529076  /lava-958344/1/../bin/lava-test-case
    2023-06-09T17:41:29.547223  <8>[   38.382243] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/648364537=
8b69684a4306163
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:41:31.659095  /lava-958344/1/../bin/lava-test-case
    2023-06-09T17:41:31.675698  <8>[   40.512122] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/6483645378b69684=
a4306165
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)
        1 lines

    2023-06-09T17:41:00.303829  / # =

    2023-06-09T17:41:00.306803  =

    2023-06-09T17:41:00.411227  / # #
    2023-06-09T17:41:00.414198  #
    2023-06-09T17:41:00.515934  / # export SHELL=3D/bin/sh
    2023-06-09T17:41:00.518991  export SHELL=3D/bin/sh
    2023-06-09T17:41:00.620399  / # . /lava-958344/environment
    2023-06-09T17:41:00.623540  . /lava-958344/environment
    2023-06-09T17:41:00.725705  / # /lava-958344/bin/lava-test-runner /lava=
-958344/0
    2023-06-09T17:41:00.728082  /lava-958344/bin/lava-test-runner /lava-958=
344/0 =

    ... (9 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | omap2plus=
_defconfig          | 5          =


  Details:     https://kernelci.org/test/plan/id/64835df2086342b364306220

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/arm/omap2plus_defconfig/gcc-10/lab-bro=
onie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/arm/omap2plus_defconfig/gcc-10/lab-bro=
onie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.omap-sham-driver-present: https://kernelci.org/test/cas=
e/id/64835df2086342b364306231
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:14:14.807361  /lava-589865/1/../bin/lava-test-case
    2023-06-09T17:14:14.865197  <8>[   27.509791] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap-aes-driver-present: https://kernelci.org/test/case=
/id/64835df2086342b364306234
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:14:12.430709  /lava-589865/1/../bin/lava-test-case
    2023-06-09T17:14:12.486519  <8>[   25.131128] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/64835df2086342b364306237
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:14:08.951571  /lava-589865/1/../bin/lava-test-case
    2023-06-09T17:14:09.012108  <8>[   21.656237] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-06-09T17:14:10.065472  /lava-589865/1/../bin/lava-test-case
    2023-06-09T17:14:10.118220  <8>[   22.762233] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/64835df2086342b364306238
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:14:07.844749  /lava-589865/1/../bin/lava-test-case
    2023-06-09T17:14:07.897861  <8>[   20.541486] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/64835df2086342b3=
64306256
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)
        1 lines

    2023-06-09T17:13:59.912280  / # =

    2023-06-09T17:13:59.922321  =

    2023-06-09T17:14:00.028599  / # #
    2023-06-09T17:14:00.037138  #
    2023-06-09T17:14:00.139765  / # export SHELL=3D/bin/sh
    2023-06-09T17:14:00.148057  export SHELL=3D/bin/sh
    2023-06-09T17:14:00.250285  / # . /lava-589865/environment
    2023-06-09T17:14:00.255636  . /lava-589865/environment
    2023-06-09T17:14:00.361821  / # /lava-589865/bin/lava-test-runner /lava=
-589865/0
    2023-06-09T17:14:00.368236  /lava-589865/bin/lava-test-runner /lava-589=
865/0 =

    ... (9 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-cip         | gcc-10   | omap2plus=
_defconfig          | 5          =


  Details:     https://kernelci.org/test/plan/id/64835f153de434489f30615d

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/arm/omap2plus_defconfig/gcc-10/lab-cip=
/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/arm/omap2plus_defconfig/gcc-10/lab-cip=
/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/64835f153de434489f30617a
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:18:47.936286  /lava-958328/1/../bin/lava-test-case
    2023-06-09T17:18:47.993625  <8>[   16.548721] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/64835f153de434489f30617b
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:18:49.049053  /lava-958328/1/../bin/lava-test-case
    2023-06-09T17:18:49.106938  <8>[   17.662774] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-06-09T17:18:50.161199  /lava-958328/1/../bin/lava-test-case
    2023-06-09T17:18:50.216072  <8>[   18.771206] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap-aes-driver-present: https://kernelci.org/test/case=
/id/64835f153de434489f30617e
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:18:52.533957  /lava-958328/1/../bin/lava-test-case
    2023-06-09T17:18:52.587662  <8>[   21.142903] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap-sham-driver-present: https://kernelci.org/test/cas=
e/id/64835f153de434489f306181
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:18:54.906660  /lava-958328/1/../bin/lava-test-case
    2023-06-09T17:18:54.963828  <8>[   23.519633] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/64835f153de43448=
9f306191
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)
        1 lines

    2023-06-09T17:18:41.025602  / # =

    2023-06-09T17:18:41.039085  =

    2023-06-09T17:18:41.145760  / # #
    2023-06-09T17:18:41.153301  #
    2023-06-09T17:18:41.255661  / # export SHELL=3D/bin/sh
    2023-06-09T17:18:41.264305  export SHELL=3D/bin/sh
    2023-06-09T17:18:41.366216  / # . /lava-958328/environment
    2023-06-09T17:18:41.374637  . /lava-958328/environment
    2023-06-09T17:18:41.476541  / # /lava-958328/bin/lava-test-runner /lava=
-958328/0
    2023-06-09T17:18:41.483427  /lava-958328/bin/lava-test-runner /lava-958=
328/0 =

    ... (9 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64835cca3c1abe6e7030616a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/arm/imx_v6_v7_defconfig/gcc-10/lab-pen=
gutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/arm/imx_v6_v7_defconfig/gcc-10/lab-pen=
gutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64835cca3c1abe6e7030616f
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-09T17:09:18.920887  + set +x
    2023-06-09T17:09:18.921061  [    7.375767] <LAVA_SIGNAL_ENDRUN 0_dmesg =
972847_1.5.2.3.1>
    2023-06-09T17:09:19.027976  / # #
    2023-06-09T17:09:19.129590  export SHELL=3D/bin/sh
    2023-06-09T17:09:19.130029  #
    2023-06-09T17:09:19.231162  / # export SHELL=3D/bin/sh. /lava-972847/en=
vironment
    2023-06-09T17:09:19.231541  =

    2023-06-09T17:09:19.332728  / # . /lava-972847/environment/lava-972847/=
bin/lava-test-runner /lava-972847/1
    2023-06-09T17:09:19.333287  =

    2023-06-09T17:09:19.336144  / # /lava-972847/bin/lava-test-runner /lava=
-972847/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6483613e07266b093730612e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/arm/multi_v7_defconfig/gcc-10/lab-peng=
utronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/arm/multi_v7_defconfig/gcc-10/lab-peng=
utronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6483613e07266b0937306133
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-09T17:28:18.353855  + set +x
    2023-06-09T17:28:18.354023  [    4.917104] <LAVA_SIGNAL_ENDRUN 0_dmesg =
972888_1.5.2.3.1>
    2023-06-09T17:28:18.460095  / # #
    2023-06-09T17:28:18.561811  export SHELL=3D/bin/sh
    2023-06-09T17:28:18.562322  #
    2023-06-09T17:28:18.663615  / # export SHELL=3D/bin/sh. /lava-972888/en=
vironment
    2023-06-09T17:28:18.664086  =

    2023-06-09T17:28:18.765328  / # . /lava-972888/environment/lava-972888/=
bin/lava-test-runner /lava-972888/1
    2023-06-09T17:28:18.765966  =

    2023-06-09T17:28:18.768149  / # /lava-972888/bin/lava-test-runner /lava=
-972888/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_mips-malta           | mips   | lab-broonie     | gcc-10   | malta_def=
config              | 1          =


  Details:     https://kernelci.org/test/plan/id/64835d690039f8c726306130

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/mips/malta_defconfig/gcc-10/lab-brooni=
e/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/mips/malta_defconfig/gcc-10/lab-brooni=
e/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64835d690039f8c726306=
131
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_mips-malta           | mips   | lab-collabora   | gcc-10   | malta_def=
config              | 1          =


  Details:     https://kernelci.org/test/plan/id/64835c643f3cfc0ed8306133

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/mips/malta_defconfig/gcc-10/lab-collab=
ora/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/mips/malta_defconfig/gcc-10/lab-collab=
ora/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64835c643f3cfc0ed8306=
134
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_x86_64-uefi-mixed    | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/648360da68476e1a27306143

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig/gcc-10/lab-bro=
onie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig/gcc-10/lab-bro=
onie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648360da68476e1a27306=
144
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_x86_64-uefi-mixed    | x86_64 | lab-broonie     | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64836166cb29c68407306152

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64836166cb29c68407306=
153
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_x86_64-uefi-mixed    | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/64835f9969ba109bb5306144

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig/gcc-10/lab-col=
labora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig/gcc-10/lab-col=
labora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64835f9969ba109bb5306=
145
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
qemu_x86_64-uefi-mixed    | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64835fe8059c908e02306136

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64835fe8059c908e02306=
137
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 6          =


  Details:     https://kernelci.org/test/plan/id/6483614807266b093730617f

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/arm/multi_v7_defconfig/gcc-10/lab-coll=
abora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/arm/multi_v7_defconfig/gcc-10/lab-coll=
abora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rk_iommu-vpu_mmu-probed: https://kernelci.org/test/case=
/id/6483614807266b093730619d
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:28:54.004385  /lava-10664521/1/../bin/lava-test-case<8>[ =
  13.057723] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk_iommu-vopl_mmu-probed =
RESULT=3Dpass>

    2023-06-09T17:28:54.004602  =


    2023-06-09T17:28:55.015472  /lava-10664521/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/6483614807266b09373061ac
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:28:52.721805  <8>[   11.774667] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/6483614807266b09373061ad
        new failure (last pass: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:28:51.701059  Usag<8>[   10.750483] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Ddwmmc_rockchip-driver-present RESULT=3Dpass>

    2023-06-09T17:28:51.705073  e: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-06-09T17:28:51.705401  =


    2023-06-09T17:28:51.710127  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-06-09T17:28:51.712801  FIRST, INC default to 1.

    2023-06-09T17:28:51.713017  =


    2023-06-09T17:28:51.716511  	-w	Pad to last with leading zeros

    2023-06-09T17:28:51.719044  	-s SEP	String separator

    2023-06-09T17:28:51.722620  /lava-10664521/1/../bin/lava-test-case

    2023-06-09T17:28:51.726902  /lava-10664521/1/../bin/lava-test-case
 =

    ... (1 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6483614807266b09373061af
        failing since 140 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-06-09T17:28:51.652611   multi-call binary.

    2023-06-09T17:28:51.652681  =


    2023-06-09T17:28:51.657202  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-06-09T17:28:51.657421  =


    2023-06-09T17:28:51.662278  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-06-09T17:28:51.672787  FIRST,<8>[   10.721593] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6483614807266b09373061b0
        failing since 140 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-06-09T17:28:51.631876  <8>[   10.685123] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>

    2023-06-09T17:28:51.650992  BusyBox v1.31.1 (2023-05-27 14:14:16 UTC)<8=
>[   10.702719] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>
   =


  * baseline.bootrr.cros-ec-dev-driver-present: https://kernelci.org/test/c=
ase/id/6483614807266b09373061c0
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77)

    2023-06-09T17:28:49.309824  <8>[    8.363359] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtpm-chip-is-online RESULT=3Dskip>

    2023-06-09T17:28:50.326207  /lava-10664521/1/../bin/lava-test-case
   =

 =20

