Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CE7CE79A8
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 21:56:34 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web10.22864.1695160589075950038
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 19 Sep 2023 14:56:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=VStggnKZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-690d8c05784so282652b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 19 Sep 2023 14:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695160588; x=1695765388; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tuuaSWj4JBao6MyHdoLERN+cvomdY5dMFwXlGUtLedQ=;
        b=VStggnKZdrbfpTOoBOCeNnsR1x6uBSIIvUtlVIEgIpGdhv4DFV2iM+cCkk+Ai64SrL
         r1Iu1ycpaSpOD75bSKjpp85NRgwnL2ae3M9Z6VvcQ740Dk0gqBktHgkDRAR+pSvdAgFP
         vrAvC53lFbDXmlhseH6S2MvlVmJwrujQ4slZA9plKlrLqT0oaUlFQ8fc0jFmgSttb1rB
         MwcFJlgdThyaVsFWA1i6wOeSUQRV5QSo08TBR/QZm5iW11sTtJkclDmh5BvimYIwfWUO
         yov5yCh9bTgic4r2QyXmXpQsgI+JI77eU7C+qJZexbSGRQyBpiWjJNVFEERCUM1Y7ZTC
         fzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695160588; x=1695765388;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tuuaSWj4JBao6MyHdoLERN+cvomdY5dMFwXlGUtLedQ=;
        b=pLfK8yK9ria66dihI/vm/WJeV5e3PFlrXq3D44+M0Obso1bC7Lbjf2jMtojpAIzXGR
         4IA/V8Y2KH8czDFLB2hqZI63EwHVnfNgZYu4FBSml/6MsrlWEPF2KEaY+AupGs6qLF5g
         ojuk8M7EGo3cJ5pnwAqaAJYQEUeG1YPxGHLAP8thLMhWr7ZYnR81xtgBxnR5pb5NzZHH
         RgLJxzdzFHxY2SYs5GZ8PNt+JlcY/2U1h5d1y+D5oAbIkE9x2w1s0HHtgN1lFdFmHo5O
         ijTt37xpufEDiztHmMSA+Y3RmbtDykf5ny97sUywGzx/2gmQKgWdoiO5E5c7MgkINwFC
         xzMQ==
X-Gm-Message-State: AOJu0YxMzSRCPawrEKDNk5E29Hp5oTM85AeFbRMsycf6pbrqUgG/C4B0
	d4o2QNHYKrSxiud3z2EjgC3GjLLj4sM+WMcQThXycg==
X-Google-Smtp-Source: AGHT+IG+0xXFCa25JwS0KeSIbd93mb4E5H/txDj6vNa/S641MkgH+j0w3O+Eafkrv2ex0ndy1XFZYA==
X-Received: by 2002:a05:6a21:6d96:b0:137:2d73:707f with SMTP id wl22-20020a056a216d9600b001372d73707fmr948731pzb.5.1695160587610;
        Tue, 19 Sep 2023 14:56:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c6-20020a62e806000000b00653fe2d527esm1385562pfi.32.2023.09.19.14.56.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 14:56:26 -0700 (PDT)
Message-ID: <650a190a.620a0220.1aab2.4b1a@mx.google.com>
Date: Tue, 19 Sep 2023 14:56:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.194-cip39-500-gc5c4e5fc16817
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 23 runs,
 25 regressions (v5.10.194-cip39-500-gc5c4e5fc16817)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 21:56:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13163

cip-gitlab/ci/pavel/linux-test baseline-nfs: 23 runs, 25 regressions (v5.10=
.194-cip39-500-gc5c4e5fc16817)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig         | 7          =

beaglebone-black             | arm   | lab-cip       | gcc-10   | multi_v7_=
defconfig         | 7          =

beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =

beaglebone-black             | arm   | lab-cip       | gcc-10   | omap2plus=
_defconfig        | 1          =

imx6q-udoo                   | arm   | lab-broonie   | gcc-10   | imx_v6_v7=
_defconfig        | 1          =

imx6q-udoo                   | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig         | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook | 2          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-cip39-500-gc5c4e5fc16817/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-cip39-500-gc5c4e5fc16817
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c5c4e5fc16817fa66c225fdaa51cf126889d5c5b =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig         | 7          =


  Details:     https://kernelci.org/test/plan/id/650a0eb43c0e057f278a0a88

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/650a0=
eb43c0e057f278a0a8f
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:12:02.993107  /lava-118868/1/../bin/lava-test-case
    2023-09-19T21:12:03.073765  <8>[   79.272442] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/650a0eb43c0e057f278a0a90
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:12:01.850347  /lava-118868/1/../bin/lava-test-case
    2023-09-19T21:12:01.935399  <8>[   78.130436] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/650a0eb43c0e057f278a0a92
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:11:59.432362  /lava-118868/1/../bin/lava-test-case
    2023-09-19T21:11:59.513340  <8>[   75.711176] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-09-19T21:12:00.572557  /lava-118868/1/../bin/lava-test-case
    2023-09-19T21:12:00.654180  <8>[   76.854342] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/650a0eb43c0e057f278a0a93
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:11:57.146379  /lava-118868/1/../bin/lava-test-case
    2023-09-19T21:11:57.223631  <8>[   73.425943] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-09-19T21:11:58.287841  /lava-118868/1/../bin/lava-test-case
    2023-09-19T21:11:58.375571  <8>[   74.568879] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/650a0eb43c0e057f278a0a94
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:11:54.856681  /lava-118868/1/../bin/lava-test-case
    2023-09-19T21:11:54.943198  <8>[   71.141026] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-09-19T21:11:56.003580  /lava-118868/1/../bin/lava-test-case
    2023-09-19T21:11:56.084032  <8>[   72.284706] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/650a0eb53c0e057f278a0aa0
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:11:41.618220  /lava-118868/1/../bin/lava-test-case
    2023-09-19T21:11:41.694124  <8>[   57.896362] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/650a0eb53c0e057f278a0ab9
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:11:33.540642  <8>[   49.730641] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 118868_1.6.2.4.1>
    2023-09-19T21:11:33.654954  / # #
    2023-09-19T21:11:33.758005  export SHELL=3D/bin/sh
    2023-09-19T21:11:33.758868  #
    2023-09-19T21:11:33.860877  / # export SHELL=3D/bin/sh. /lava-118868/en=
vironment
    2023-09-19T21:11:33.861744  =

    2023-09-19T21:11:33.963808  / # . /lava-118868/environment/lava-118868/=
bin/lava-test-runner /lava-118868/1
    2023-09-19T21:11:33.965191  =

    2023-09-19T21:11:33.969688  / # /lava-118868/bin/lava-test-runner /lava=
-118868/1
    2023-09-19T21:11:34.252487  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-cip       | gcc-10   | multi_v7_=
defconfig         | 7          =


  Details:     https://kernelci.org/test/plan/id/650a0eb7bc9e71a58c8a0a46

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/650a0eb7bc9e71a58c8a0a4d
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:11:38.198536  + set +x
    2023-09-19T21:11:38.214739  <8>[   45.859188] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1010557_1.6.2.4.1>
    2023-09-19T21:11:38.442098  #
    2023-09-19T21:11:38.545124  / # #export SHELL=3D/bin/sh
    2023-09-19T21:11:38.545832  =

    2023-09-19T21:11:38.647652  / # export SHELL=3D/bin/sh. /lava-1010557/e=
nvironment
    2023-09-19T21:11:38.648356  =

    2023-09-19T21:11:38.750318  / # . /lava-1010557/environment/lava-101055=
7/bin/lava-test-runner /lava-1010557/1
    2023-09-19T21:11:38.751468  =

    2023-09-19T21:11:38.758153  / # /lava-1010557/bin/lava-test-runner /lav=
a-1010557/1 =

    ... (12 line(s) more)  =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/650a0eb7bc9e71a58c8a0a66
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:11:48.345593  /lava-1010557/1/../bin/lava-test-case
    2023-09-19T21:11:48.524281  <8>[   56.171560] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/650a0eb7bc9e71a58c8a0a72
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:12:01.990363  <6>[   69.643242] platform sound: deferred =
probe pending
    2023-09-19T21:12:03.019355  /lava-1010557/1/../bin/lava-test-case
    2023-09-19T21:12:03.186243  <8>[   70.834287] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-09-19T21:12:04.238319  /lava-1010557/1/../bin/lava-test-case
    2023-09-19T21:12:04.404218  <8>[   72.056625] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/650a0eb7bc9e71a58c8a0a73
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:12:05.466622  /lava-1010557/1/../bin/lava-test-case
    2023-09-19T21:12:05.653946  <8>[   73.306654] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-09-19T21:12:06.716380  /lava-1010557/1/../bin/lava-test-case
    2023-09-19T21:12:06.923403  <8>[   74.568073] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/650a0eb7bc9e71a58c8a0a74
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:12:07.984744  /lava-1010557/1/../bin/lava-test-case
    2023-09-19T21:12:08.153995  <8>[   75.806759] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-09-19T21:12:09.215508  /lava-1010557/1/../bin/lava-test-case
    2023-09-19T21:12:09.404789  <8>[   77.048651] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/650a0eb7bc9e71a58c8a0a76
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:12:10.668284  /lava-1010557/1/../bin/lava-test-case
    2023-09-19T21:12:10.854344  <8>[   78.507172] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/650a0=
eb7bc9e71a58c8a0a77
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:12:11.916780  /lava-1010557/1/../bin/lava-test-case
    2023-09-19T21:12:12.076413  <8>[   79.723162] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/650a0d0a5a2596ab368a0a4f

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/650a0d0a5a2596ab368a0a75
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:04:48.351370  /lava-118844/1/../bin/lava-test-case
    2023-09-19T21:04:48.441854  <8>[   52.926322] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beaglebone-black             | arm   | lab-cip       | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/650a0d195a2596ab368a0a95

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/omap2plus_defconfig/gcc-10/lab-cip/=
baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/omap2plus_defconfig/gcc-10/lab-cip/=
baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/650a0d195a2596ab368a0ab7
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496)

    2023-09-19T21:05:14.771745  /lava-1010525/1/../bin/lava-test-case
    2023-09-19T21:05:14.848794  <8>[   45.789636] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
imx6q-udoo                   | arm   | lab-broonie   | gcc-10   | imx_v6_v7=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/650a10ae974d5cd79c8a0a52

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/imx_v6_v7_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/imx_v6_v7_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/650a10ae974d5cd79=
c8a0a53
        failing since 28 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, fir=
st fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
imx6q-udoo                   | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/650a1217719075c8838a0a43

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/650a1217719075c88=
38a0a44
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d496) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/650a0d9c0b561c251a8a0a64

  Results:     50 PASS, 4 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.sound-card: https://kernelci.org/test/case/id/650a0=
d9c0b561c251a8a0a6b
        failing since 20 days (last pass: v6.1.46-cip4-rt2, first fail: v5.=
10.191-cip38-2-g05fb42f86d06a)

    2023-09-19T21:07:26.260979  /lava-118860/1/../bin/lava-test-case
    2023-09-19T21:07:26.317802  <8>[   39.753889] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>
    2023-09-19T21:07:26.318382  + set +x   =


  * baseline-nfs.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/6=
50a0d9c0b561c251a8a0a8f
        new failure (last pass: v5.10.191-cip38-2-g05fb42f86d06a)

    2023-09-19T21:07:21.775404  /lava-118860/1/../bin/lava-test-case
    2023-09-19T21:07:21.842075  <8>[   35.271439] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2023-09-19T21:07:21.842738  /lava-118860/1/../bin/lava-test-case   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/650a136bedbb4d842c8a0a55

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/650a136bedbb4d842=
c8a0a56
        new failure (last pass: v5.10.191-cip38-29-g9e1aa2001db86) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650a0d6864922c21ea8a0b97

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-nfs-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-nfs-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/650a0d6864922c21e=
a8a0b98
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/650a17c95c5d3280338a0a4f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig/gcc-10/lab-cip/baseline=
-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig/gcc-10/lab-cip/baseline=
-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/650a17c95c5d32803=
38a0a50
        failing since 34 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/650a0d37742cac6de88a0acc

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/650a0d37742cac6de88a0ad6
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-19T21:06:07.094170  <8>[   37.528760] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-09-19T21:06:08.158252  /lava-11574475/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/650a0d37742cac6de88a0ad7
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440)

    2023-09-19T21:06:07.049953  /lava-11574475/1/../bin/lava-test-case
   =

 =20

