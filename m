Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769F0C4332F
	for <webhook@archiver.kernel.org>; Wed, 13 Dec 2023 09:52:31 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
 by mx.groups.io with SMTP id smtpd.web11.32436.1702461141456334548
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Dec 2023 01:52:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=YdFoNOS5;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.47, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5910b21896eso1806998eaf.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Dec 2023 01:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702461140; x=1703065940; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rKnZAh1Ud4vXMzUxhpxi8WcdTDmEC0IphUFV39CCQJk=;
        b=YdFoNOS5goF4FDWC9VSBbVLrY68AUNOCGd4XMiBYt526Fl2k1fSyiPoFSQvknn9JA4
         zmQyKtnj+/2fcL9hq/m3i7VS1CN+KBfo3lTtdBLyZcDeCWtMSQsdG5QoZuCYzSCsSWyL
         ilCdgo7xgSWwbjgYv/ezFKaiUhmV3USFZG3yTaCQtsmp8YL3amEJKGN6koM5aUHBU21S
         fvF07IUti3Bnz7vh6sibWY8cjPGwbxyzNQhmanHliSlidkKNpNAHDzDbqFYLnb/2g5WU
         tVsHhzY/ddLPypuymVNG/oBe5wuXh3F9idWpp2wxoqS8msiXb1F6UOXwNOcrEOazVaRp
         Z/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702461140; x=1703065940;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rKnZAh1Ud4vXMzUxhpxi8WcdTDmEC0IphUFV39CCQJk=;
        b=c7RkRNv622wFdHkC+/src8sCyygtL6L99KZxj79U+8puejOYBmq/GllMugGeE977KP
         05ZagxNHh1yJiBWdkNZhVenX7K5p7xAyl0R9EbLdIAxft1Qa7FN18plKt6Rn6j6OufEQ
         JlfwFLE+mF5ycVPq5bYVRkFHu7h7Edqy3G5LWIJh3OyZVm+Jn45bSvq6O42D7GnBbaCu
         5JkY4lkux3H/TlV385e4+Un/jAknMxiFTSgCUrHhP6uKBrhbjX2RzhQ/ceu15EvfVVJY
         IRDdI31Rp7X2toQSBsJdkToLUmq/oKRecyKkRV5Hsn1wMXtays0jSzm3ZceD7pr0wKeh
         SNUg==
X-Gm-Message-State: AOJu0YxNTF1JvGfjo/eW0MzB+VeRCymGb6lQEGKea7hvG3370XW52cap
	PgnIzb3zFhpzjOIOEEpoUkn+D3MbKX5Iffw2E6UJcw==
X-Google-Smtp-Source: AGHT+IHoTX1R7wiXHqY0WCyJsrHuKN9+ZgQB7SKGJfX3v64G5U+vc+UyAwRJjgBWO0uiBUGIFPynWQ==
X-Received: by 2002:a05:6358:5289:b0:171:4aa4:4d with SMTP id g9-20020a056358528900b001714aa4004dmr1014753rwa.43.1702461139658;
        Wed, 13 Dec 2023 01:52:19 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id me17-20020a17090b17d100b0028a01156d24sm10381054pjb.49.2023.12.13.01.52.18
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 01:52:19 -0800 (PST)
Message-ID: <65797ed3.170a0220.b1ae.e9c4@mx.google.com>
Date: Wed, 13 Dec 2023 01:52:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-77-g545d45774209f
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 23 runs,
 35 regressions (v5.10.201-cip41-77-g545d45774209f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Dec 2023 09:52:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14064

cip-gitlab/ci/pavel/linux-test baseline-nfs: 23 runs, 35 regressions (v5.10=
.201-cip41-77-g545d45774209f)

Regressions Summary
-------------------

platform               | arch  | lab         | compiler | defconfig        =
   | regressions
-----------------------+-------+-------------+----------+------------------=
---+------------
at91sam9g20ek          | arm   | lab-broonie | gcc-10   | at91_dt_defconfig=
   | 1          =

beaglebone-black       | arm   | lab-broonie | gcc-10   | multi_v7_defconfi=
g  | 7          =

beaglebone-black       | arm   | lab-cip     | gcc-10   | multi_v7_defconfi=
g  | 7          =

beaglebone-black       | arm   | lab-broonie | gcc-10   | omap2plus_defconf=
ig | 1          =

beaglebone-black       | arm   | lab-cip     | gcc-10   | omap2plus_defconf=
ig | 1          =

imx6dl-udoo            | arm   | lab-broonie | gcc-10   | multi_v7_defconfi=
g  | 1          =

imx6q-udoo             | arm   | lab-broonie | gcc-10   | multi_v7_defconfi=
g  | 1          =

juno-uboot             | arm64 | lab-broonie | gcc-10   | defconfig        =
   | 10         =

kontron-kbox-a-230-ls  | arm64 | lab-kontron | gcc-10   | defconfig        =
   | 3          =

kontron-sl28-var3-ads2 | arm64 | lab-kontron | gcc-10   | defconfig        =
   | 3          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-cip41-77-g545d45774209f/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-cip41-77-g545d45774209f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      545d45774209f8cd48179f8431020b19faaeef38 =



Test Regressions
---------------- =



platform               | arch  | lab         | compiler | defconfig        =
   | regressions
-----------------------+-------+-------------+----------+------------------=
---+------------
at91sam9g20ek          | arm   | lab-broonie | gcc-10   | at91_dt_defconfig=
   | 1          =


  Details:     https://kernelci.org/test/plan/id/657977afefba1d8521e13476

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/657977afefba1d852=
1e13477
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d) =

 =



platform               | arch  | lab         | compiler | defconfig        =
   | regressions
-----------------------+-------+-------------+----------+------------------=
---+------------
beaglebone-black       | arm   | lab-broonie | gcc-10   | multi_v7_defconfi=
g  | 7          =


  Details:     https://kernelci.org/test/plan/id/657978ec4f9cef7681e13475

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/657978ec4f9cef7681e1347c
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:27:02.401060  /lava-348443/1/../bin/lava-test-case
    2023-12-13T09:27:02.482133  <8>[  142.811180] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/657978ec4f9cef7681e1347e
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:26:59.975773  /lava-348443/1/../bin/lava-test-case
    2023-12-13T09:27:00.051036  <8>[  140.380064] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-12-13T09:27:01.117086  /lava-348443/1/../bin/lava-test-case
    2023-12-13T09:27:01.201174  <8>[  141.529587] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/657978ec4f9cef7681e1347f
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:26:57.665158  /lava-348443/1/../bin/lava-test-case
    2023-12-13T09:26:57.748351  <8>[  138.077015] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-12-13T09:26:58.812125  /lava-348443/1/../bin/lava-test-case
    2023-12-13T09:26:58.908254  <8>[  139.236898] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/657978ec4f9cef7681e13480
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:26:55.378268  /lava-348443/1/../bin/lava-test-case
    2023-12-13T09:26:55.452942  <8>[  135.781902] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-12-13T09:26:56.514692  /lava-348443/1/../bin/lava-test-case
    2023-12-13T09:26:56.596361  <8>[  136.924570] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/657978ec4f9cef7681e1348b
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:26:41.980944  /lava-348443/1/../bin/lava-test-case
    2023-12-13T09:26:42.064411  <8>[  122.391606] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/657978ec4f9cef7681e134a5
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:26:33.600008  + set +x
    2023-12-13T09:26:33.604084  <8>[  113.932903] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 348443_1.6.2.4.1>
    2023-12-13T09:26:33.732343  / # #
    2023-12-13T09:26:33.835428  export SHELL=3D/bin/sh
    2023-12-13T09:26:33.836332  #
    2023-12-13T09:26:33.938446  / # export SHELL=3D/bin/sh. /lava-348443/en=
vironment
    2023-12-13T09:26:33.939353  =

    2023-12-13T09:26:34.041351  / # . /lava-348443/environment/lava-348443/=
bin/lava-test-runner /lava-348443/1
    2023-12-13T09:26:34.042888  =

    2023-12-13T09:26:34.047466  / # /lava-348443/bin/lava-test-runner /lava=
-348443/1 =

    ... (12 line(s) more)  =


  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65797=
8ec4f9cef7681e134a6
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:27:03.545313  /lava-348443/1/../bin/lava-test-case
    2023-12-13T09:27:03.622193  <8>[  143.952053] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =

 =



platform               | arch  | lab         | compiler | defconfig        =
   | regressions
-----------------------+-------+-------------+----------+------------------=
---+------------
beaglebone-black       | arm   | lab-cip     | gcc-10   | multi_v7_defconfi=
g  | 7          =


  Details:     https://kernelci.org/test/plan/id/65797c3f4b251a4a0fe13476

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65797=
c3f4b251a4a0fe1347d
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:40:56.532005  /lava-1058133/1/../bin/lava-test-case
    2023-12-13T09:40:57.863292  <8>[  106.017626] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/65797c3f4b251a4a0fe1347e
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:40:55.185280  /lava-1058133/1/../bin/lava-test-case
    2023-12-13T09:40:55.476775  <8>[  103.630207] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/65797c3f4b251a4a0fe13480
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:40:51.557589  /lava-1058133/1/../bin/lava-test-case
    2023-12-13T09:40:52.335841  <8>[  100.488604] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-12-13T09:40:53.391352  /lava-1058133/1/../bin/lava-test-case
    2023-12-13T09:40:53.648053  <8>[  101.800913] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/65797c3f4b251a4a0fe13481
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:40:48.738664  /lava-1058133/1/../bin/lava-test-case
    2023-12-13T09:40:49.103108  <8>[   97.255531] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-12-13T09:40:50.160350  /lava-1058133/1/../bin/lava-test-case
    2023-12-13T09:40:50.497210  <8>[   98.650890] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/65797c3f4b251a4a0fe13482
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:40:44.184053  /lava-1058133/1/../bin/lava-test-case
    2023-12-13T09:40:44.477569  <8>[   92.630772] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-12-13T09:40:45.538000  /lava-1058133/1/../bin/lava-test-case
    2023-12-13T09:40:47.677351  <8>[   95.830144] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65797c3f4b251a4a0fe134a2
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:40:11.840414  + set +x
    2023-12-13T09:40:11.844623  <8>[   59.997792] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1058133_1.6.2.4.1>
    2023-12-13T09:40:12.068684  / # #
    2023-12-13T09:40:12.170222  export SHELL=3D/bin/sh
    2023-12-13T09:40:12.170799  #
    2023-12-13T09:40:12.271708  / # export SHELL=3D/bin/sh. /lava-1058133/e=
nvironment
    2023-12-13T09:40:12.272390  =

    2023-12-13T09:40:12.373453  / # . /lava-1058133/environment/lava-105813=
3/bin/lava-test-runner /lava-1058133/1
    2023-12-13T09:40:12.374457  =

    2023-12-13T09:40:12.379261  / # /lava-1058133/bin/lava-test-runner /lav=
a-1058133/1 =

    ... (12 line(s) more)  =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/65797c3f4b251a4a0fe134a3
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:40:26.301063  /lava-1058133/1/../bin/lava-test-case
    2023-12-13T09:40:26.498738  <8>[   74.649860] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =

 =



platform               | arch  | lab         | compiler | defconfig        =
   | regressions
-----------------------+-------+-------------+----------+------------------=
---+------------
beaglebone-black       | arm   | lab-broonie | gcc-10   | omap2plus_defconf=
ig | 1          =


  Details:     https://kernelci.org/test/plan/id/6579759dbc3368fd1be13475

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/6579759dbc3368fd1be13494
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:12:39.277649  /lava-348309/1/../bin/lava-test-case
    2023-12-13T09:12:39.389487  <8>[  124.514292] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform               | arch  | lab         | compiler | defconfig        =
   | regressions
-----------------------+-------+-------------+----------+------------------=
---+------------
beaglebone-black       | arm   | lab-cip     | gcc-10   | omap2plus_defconf=
ig | 1          =


  Details:     https://kernelci.org/test/plan/id/657978cb30d357d0f0e13523

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/657978cb30d357d0f0e13542
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:26:12.331929  /lava-1058102/1/../bin/lava-test-case
    2023-12-13T09:26:12.393851  <8>[   44.815370] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform               | arch  | lab         | compiler | defconfig        =
   | regressions
-----------------------+-------+-------------+----------+------------------=
---+------------
imx6dl-udoo            | arm   | lab-broonie | gcc-10   | multi_v7_defconfi=
g  | 1          =


  Details:     https://kernelci.org/test/plan/id/65797c87ac7c4b2fdfe13480

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65797c87ac7c4b2fd=
fe13481
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d) =

 =



platform               | arch  | lab         | compiler | defconfig        =
   | regressions
-----------------------+-------+-------------+----------+------------------=
---+------------
imx6q-udoo             | arm   | lab-broonie | gcc-10   | multi_v7_defconfi=
g  | 1          =


  Details:     https://kernelci.org/test/plan/id/65797bd37a538017d6e13483

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65797bd37a538017d=
6e13484
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d) =

 =



platform               | arch  | lab         | compiler | defconfig        =
   | regressions
-----------------------+-------+-------------+----------+------------------=
---+------------
juno-uboot             | arm64 | lab-broonie | gcc-10   | defconfig        =
   | 10         =


  Details:     https://kernelci.org/test/plan/id/65797c1099c8ed69dde1347a

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.led7-probed: https://kernelci.org/test/case/id/6579=
7c1099c8ed69dde1348b
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:40:12.081278  /lava-348378/1/../bin/lava-test-case
    2023-12-13T09:40:12.128229  <8>[   58.530449] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led6-probed: https://kernelci.org/test/case/id/6579=
7c1099c8ed69dde1348c
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:40:10.998291  /lava-348378/1/../bin/lava-test-case
    2023-12-13T09:40:11.042304  <8>[   57.444517] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led5-probed: https://kernelci.org/test/case/id/6579=
7c1099c8ed69dde1348d
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:40:09.913148  /lava-348378/1/../bin/lava-test-case
    2023-12-13T09:40:09.958887  <8>[   56.361152] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led4-probed: https://kernelci.org/test/case/id/6579=
7c1099c8ed69dde1348e
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:40:08.835152  /lava-348378/1/../bin/lava-test-case
    2023-12-13T09:40:08.873911  <8>[   55.276255] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led3-probed: https://kernelci.org/test/case/id/6579=
7c1099c8ed69dde1348f
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:40:07.732105  /lava-348378/1/../bin/lava-test-case
    2023-12-13T09:40:07.779927  <8>[   54.185293] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led2-probed: https://kernelci.org/test/case/id/6579=
7c1099c8ed69dde13490
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:40:06.651246  /lava-348378/1/../bin/lava-test-case
    2023-12-13T09:40:06.692826  <8>[   53.094723] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led1-probed: https://kernelci.org/test/case/id/6579=
7c1099c8ed69dde13491
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:40:05.567199  /lava-348378/1/../bin/lava-test-case
    2023-12-13T09:40:05.613111  <8>[   52.015446] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led0-probed: https://kernelci.org/test/case/id/6579=
7c1099c8ed69dde13492
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:40:04.488044  /lava-348378/1/../bin/lava-test-case
    2023-12-13T09:40:04.527956  <8>[   50.930582] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.iommu1-probed: https://kernelci.org/test/case/id/65=
797c1099c8ed69dde134a5
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:40:01.291595  <8>[   47.692455] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu0-probed RESULT=3Dpass>
    2023-12-13T09:40:02.330923  /lava-348378/1/../bin/lava-test-case
    2023-12-13T09:40:02.370017  <8>[   48.772135] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case=
/id/65797c1099c8ed69dde134b2
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:40:00.336653  /lava-348378/1/../bin/lava-test-case
    2023-12-13T09:40:00.380769  <8>[   46.782811] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =

 =



platform               | arch  | lab         | compiler | defconfig        =
   | regressions
-----------------------+-------+-------------+----------+------------------=
---+------------
kontron-kbox-a-230-ls  | arm64 | lab-kontron | gcc-10   | defconfig        =
   | 3          =


  Details:     https://kernelci.org/test/plan/id/65797780cd1db961cce13475

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/65797781cd1db961cce134b9
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:20:53.735785  /lava-405334/1/../bin/lava-test-case
    2023-12-13T09:20:53.756852  <8>[   20.831690] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/65797781cd1db961cce134ba
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:20:54.780118  /lava-405334/1/../bin/lava-test-case
    2023-12-13T09:20:54.800988  <8>[   21.874392] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-12-13T09:20:55.808804  /lava-405334/1/../bin/lava-test-case
    2023-12-13T09:20:55.837665  <8>[   22.912408] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/65797781cd1db961cce134d1
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:20:58.704128  /lava-405334/1/../bin/lava-test-case
    2023-12-13T09:20:58.732004  <8>[   25.806555] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform               | arch  | lab         | compiler | defconfig        =
   | regressions
-----------------------+-------+-------------+----------+------------------=
---+------------
kontron-sl28-var3-ads2 | arm64 | lab-kontron | gcc-10   | defconfig        =
   | 3          =


  Details:     https://kernelci.org/test/plan/id/6579777f16502e9368e13491

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/6579777f16502e9368e134dc
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:20:45.867039  /lava-405333/1/../bin/lava-test-case
    2023-12-13T09:20:45.894942  <8>[   16.658239] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/6579777f16502e9368e134dd
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:20:46.902586  /lava-405333/1/../bin/lava-test-case
    2023-12-13T09:20:46.929531  <8>[   17.692826] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-12-13T09:20:47.937193  /lava-405333/1/../bin/lava-test-case
    2023-12-13T09:20:47.969015  <8>[   18.732481] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/6579777f16502e9368e134f2
        failing since 7 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-13T09:20:50.760012  /lava-405333/1/../bin/lava-test-case
    2023-12-13T09:20:50.785941  <8>[   21.548873] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =20

