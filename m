Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A852DEB64DA
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 16:15:19 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web10.1284.1689869713355252163
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Jul 2023 09:15:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=vDSrkjxK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-666e916b880so620738b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Jul 2023 09:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689869712; x=1690474512;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=weWW255+FKuC4JP4NZJdPbh2Rz3H/vhsMjXg553owvs=;
        b=vDSrkjxKhRfJrSrdCAllpqsDjHygcvrl4MWLgs8kbqYU4gTSDfZOwLE5i8v/Vat3d7
         U7TPYICo04LRk7JdGadX/FMMyVOYamtN1oqQQLepLLNBkXXcAlUkZQkNnGlfJAgvjQRl
         Zj2Iu/cJ2R4Jg4AwH/zEWQE9A/vpwrQ0UWm50DE8rzdDqr1muHfKbcljoMQijAbVQkJG
         95m0FI72Uoop1BSYSfrZGWrbPOKr9HBPJbPlLtxD0iB/THXOLbLqslg+0MOzE4IHBRvJ
         249jyHzhHTAjYLSgA29zPGy5UibV0ZEJ476oKzf7rylvvx9VCUEPzZ/71nlkEnLC03qA
         8INg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689869712; x=1690474512;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=weWW255+FKuC4JP4NZJdPbh2Rz3H/vhsMjXg553owvs=;
        b=PN+S7uuEOL3eqo2buxUDHgxff5cT4rZcL2qT+UKYYe14rGopRhRkwsr2teeLFAuBMm
         HgM7fTijVEFvNbedJIJsBmQIXWefXbdJFDr2ztHefncu8DNQ55fmAFvl7rznHhq0OvV4
         rmx9K3v2U07g0E5jpK3YJNjkdja8q+g4qXqOc3H4TRjgCgjYFj1OhhTRfx8Xm7HeheqW
         BxPxsb9lUmGzv4crhuqw+nnjussM/hBRe6O3Y5fuUSjv7Jct9mVGagzdwCOu0aMwqw5/
         Ozd1+oz3b7fE4eBn++6OwMkjzOlmBhIOqXfYpvsHzfiqBgabH6aF5/YyVxI8y9NfXLvq
         U0bA==
X-Gm-Message-State: ABy/qLZ4EGB6XeLy3NEvazHAa3lSutCcx8zxrmJnrzV6T/klcedS7ytx
	h+HXxTLDlb00qILFgteXml0DNyZLFweGGmBTDGWHuw==
X-Google-Smtp-Source: APBJJlESkWVV4oswarMKQrH7dRrVY5zpawSgdzHY9asvReU1MLLbnpa0LwUI+/FA7Mox/dkYSJGJ1g==
X-Received: by 2002:a05:6a00:22d5:b0:682:a6bd:e952 with SMTP id f21-20020a056a0022d500b00682a6bde952mr22736636pfj.6.1689869711846;
        Thu, 20 Jul 2023 09:15:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t14-20020aa7938e000000b00659b8313d08sm1391621pfe.78.2023.07.20.09.15.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 09:15:11 -0700 (PDT)
Message-ID: <64b95d8f.a70a0220.e7bc8.2930@mx.google.com>
Date: Thu, 20 Jul 2023 09:15:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.186-cip37-12-gf8c9ce666de7b
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 7 runs,
 20 regressions (v5.10.186-cip37-12-gf8c9ce666de7b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 16:15:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12478

cip-gitlab/ci/pavel/linux-test baseline-nfs: 7 runs, 20 regressions (v5.10.=
186-cip37-12-gf8c9ce666de7b)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 7 =
         =

beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig  | 7 =
         =

beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 2 =
         =

beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 2 =
         =

imx6q-udoo       | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1 =
         =

imx6q-udoo       | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.186-cip37-12-gf8c9ce666de7b/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.186-cip37-12-gf8c9ce666de7b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f8c9ce666de7b69f842e25063054c803ff45d06d =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 7 =
         =


  Details:     https://kernelci.org/test/plan/id/64b944b639325553468ace2d

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64b94=
4b639325553468ace30
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T14:28:58.043042  /lava-3432/1/../bin/lava-test-case
    2023-07-20T14:28:58.124867  [   98.382113] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/64b944b639325553468ace31
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T14:28:56.915615  /lava-3432/1/../bin/lava-test-case
    2023-07-20T14:28:56.983363  [   97.239883] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/64b944b639325553468ace33
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T14:28:53.372926  /lava-3432/1/../bin/lava-test-case
    2023-07-20T14:28:54.613785  [   94.870208] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-07-20T14:28:55.674584  /lava-3432/1/../bin/lava-test-case
    2023-07-20T14:28:55.744101  [   95.999818] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/64b944b639325553468ace34
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T14:28:51.099884  /lava-3432/1/../bin/lava-test-case
    2023-07-20T14:28:51.182991  [   91.439087] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-07-20T14:28:52.244544  /lava-3432/1/../bin/lava-test-case
    2023-07-20T14:28:52.311539  [   92.567711] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/64b944b639325553468ace35
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T14:28:48.832364  /lava-3432/1/../bin/lava-test-case
    2023-07-20T14:28:48.897168  [   89.153633] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-07-20T14:28:49.954158  /lava-3432/1/../bin/lava-test-case
    2023-07-20T14:28:50.038228  [   90.293630] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/64b944b639325553468ace41
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T14:28:21.989799  /lava-3432/1/../bin/lava-test-case
    2023-07-20T14:28:22.070875  [   62.324940] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b944b639325553468ace58
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T14:28:12.403341  [   52.659211] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3432_1.6.2.4.1>
    2023-07-20T14:28:12.570273  #
    2023-07-20T14:28:12.671962  / # #export SHELL=3D/bin/sh
    2023-07-20T14:28:12.672292  =

    2023-07-20T14:28:12.773435  / # export SHELL=3D/bin/sh. /lava-3432/envi=
ronment
    2023-07-20T14:28:12.773795  =

    2023-07-20T14:28:12.874934  / # . /lava-3432/environment/lava-3432/bin/=
lava-test-runner /lava-3432/1
    2023-07-20T14:28:12.875457  =

    2023-07-20T14:28:12.890163  / # /lava-3432/bin/lava-test-runner /lava-3=
432/1
    2023-07-20T14:28:13.302530  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig  | 7 =
         =


  Details:     https://kernelci.org/test/plan/id/64b93d7033b27a3ffb8ace23

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b93d7033b27a3ffb8ace26
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T13:57:17.412377  + set +x
    2023-07-20T13:57:17.414193  [   47.020785] <LAVA_SIGNAL_ENDRUN 0_dmesg =
987976_1.6.2.4.1>
    2023-07-20T13:57:17.531592  / # #
    2023-07-20T13:57:17.633538  export SHELL=3D/bin/sh
    2023-07-20T13:57:17.634001  #
    2023-07-20T13:57:17.735461  / # export SHELL=3D/bin/sh. /lava-987976/en=
vironment
    2023-07-20T13:57:17.736028  =

    2023-07-20T13:57:17.837418  / # . /lava-987976/environment/lava-987976/=
bin/lava-test-runner /lava-987976/1
    2023-07-20T13:57:17.838204  =

    2023-07-20T13:57:17.840260  / # /lava-987976/bin/lava-test-runner /lava=
-987976/1 =

    ... (12 line(s) more)  =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/64b93d7033b27a3ffb8ace3f
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T13:57:24.789506  /lava-987976/1/../bin/lava-test-case
    2023-07-20T13:57:24.853862  [   54.458618] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/64b93d7033b27a3ffb8ace4b
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T13:57:37.604229  /lava-987976/1/../bin/lava-test-case
    2023-07-20T13:57:37.667258  [   67.273535] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-07-20T13:57:38.718463  /lava-987976/1/../bin/lava-test-case
    2023-07-20T13:57:38.778255  [   68.383867] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/64b93d7033b27a3ffb8ace4c
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T13:57:39.830992  /lava-987976/1/../bin/lava-test-case
    2023-07-20T13:57:39.893893  [   69.499978] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-07-20T13:57:40.945220  /lava-987976/1/../bin/lava-test-case
    2023-07-20T13:57:41.008245  [   70.614301] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/64b93d7033b27a3ffb8ace4d
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T13:57:42.058279  /lava-987976/1/../bin/lava-test-case
    2023-07-20T13:57:42.123270  [   71.729652] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-07-20T13:57:43.176504  /lava-987976/1/../bin/lava-test-case
    2023-07-20T13:57:43.234481  [   72.840150] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/64b93d7033b27a3ffb8ace4f
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T13:57:44.385779  /lava-987976/1/../bin/lava-test-case
    2023-07-20T13:57:44.450267  [   74.056572] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64b93=
d7033b27a3ffb8ace50
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T13:57:45.503953  /lava-987976/1/../bin/lava-test-case
    2023-07-20T13:57:45.564466  [   75.171505] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 2 =
         =


  Details:     https://kernelci.org/test/plan/id/64b950cfe1745ca7ce8ace20

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/64b950cfe1745ca7ce8ace36
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T15:20:31.982399  /lava-3700/1/../bin/lava-test-case
    2023-07-20T15:20:32.062994  [   52.570596] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b950cfe1745ca7ce8ace51
        failing since 36 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-20T15:20:25.801799  [   46.310622] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3700_1.6.2.4.1>
    2023-07-20T15:20:25.921987  / # #
    2023-07-20T15:20:26.024741  export SHELL=3D/bin/sh
    2023-07-20T15:20:26.025446  #
    2023-07-20T15:20:26.127885  / # export SHELL=3D/bin/sh. /lava-3700/envi=
ronment
    2023-07-20T15:20:26.128861  =

    2023-07-20T15:20:26.231276  / # . /lava-3700/environment/lava-3700/bin/=
lava-test-runner /lava-3700/1
    2023-07-20T15:20:26.232622  =

    2023-07-20T15:20:26.235923  / # /lava-3700/bin/lava-test-runner /lava-3=
700/1
    2023-07-20T15:20:26.514218  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 2 =
         =


  Details:     https://kernelci.org/test/plan/id/64b950d09f1b0e1d118ace9f

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b950d09f1b0e1d118acea2
        failing since 36 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-20T15:20:25.842336  + set +x
    2023-07-20T15:20:25.844136  [   39.293309] <LAVA_SIGNAL_ENDRUN 0_dmesg =
987983_1.6.2.4.1>
    2023-07-20T15:20:25.961517  #
    2023-07-20T15:20:26.063885  / # #export SHELL=3D/bin/sh
    2023-07-20T15:20:26.064343  =

    2023-07-20T15:20:26.165754  / # export SHELL=3D/bin/sh. /lava-987983/en=
vironment
    2023-07-20T15:20:26.166231  =

    2023-07-20T15:20:26.267669  / # . /lava-987983/environment/lava-987983/=
bin/lava-test-runner /lava-987983/1
    2023-07-20T15:20:26.268552  =

    2023-07-20T15:20:26.270601  / # /lava-987983/bin/lava-test-runner /lava=
-987983/1 =

    ... (12 line(s) more)  =


  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/64b950d09f1b0e1d118acebd
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc)

    2023-07-20T15:20:31.615071  /lava-987983/1/../bin/lava-test-case
    2023-07-20T15:20:31.686066  [   45.134209] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
imx6q-udoo       | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/64b94e44d74f15c2358ace2c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64b94e44d74f15c23=
58ace2d
        failing since 9 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.184-cip36-13-g8201543bbc8b6) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
imx6q-udoo       | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/64b9478b23e021b6f78ace20

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64b9478b23e021b6f=
78ace21
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc) =

 =20

