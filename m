Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAD2C7EE23
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 00:27:00 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web10.40085.1685320018446604111
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 28 May 2023 17:26:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=ITWBCV3f;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-256797b5664so305534a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 28 May 2023 17:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685320017; x=1687912017;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9PRNdwuD9L0xo/BMGG5RJCr05febCBJAITD61My2+4Q=;
        b=ITWBCV3f47tGFw0n5A0ISx2nKt9q5gEIYzxduSceWC8N96Igxpeb7lIMeWcuKYiyRC
         Qm56qappwjGC2ShZ4wmXeK/dNTLoGgPxsk+1xQRJYYBKLkosb/2q4z/BnsRYQwGcu5w+
         oMOH27onWWH2U+bVHDlhyEXRF+o8z9Y+DGMe5NTTeYBPwQbCP17ImO1OMvSPnaZOWwKt
         duQDZ/D54F4vunwvwUNRcCiN14hZm0h8sspCb70FiZBYCXUW2y+uQIfoPeet9n+mgiTZ
         cGQMKq2yM+W00YMUJsOYuOJOI3U9CFmTNVQbJo7lx19JPGd6uA1bQdZERrMGjhUDg7a0
         I5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685320017; x=1687912017;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PRNdwuD9L0xo/BMGG5RJCr05febCBJAITD61My2+4Q=;
        b=GH2FHUOmCDXO8SUaJdIE+itMHmhKtL4qwJIQz8i4HpUwlk3pkzcevDYSOLQe/wcAID
         PxLY8I1ov38heaiCMXnFIC09YwQXYKq3Exnca11Px61C4mVuUShTSJV1LMDZ4Gok4imB
         F/hiauC9BgzZRqOPBKhvVyDUfqy6IFQiipsdZ3HDfylHqWPOqWpZOPrx8CyqEvN+KNmN
         joEbXq4HbBp7GE0L653ZtJZPBYpRDYhzd/QfAPUB9XBiOv0daaAMo7PHNQuGGWICK/uH
         Ek0eBIGuKy7DWgAWCzVTOowM+coA6xd46fQGc1cTEOKA9I/gtEZ/ogMxbjqV49wkLKXc
         N3UA==
X-Gm-Message-State: AC+VfDwavp993dh4Qtunt5N+Of/PsksFvqy8MnbgJ8NzUkI+NE/IkozD
	ViipussIxdfNaFbSXWSdsVCt5fFvng5UlK3iAAaizg==
X-Google-Smtp-Source: ACHHUZ4Dv0wIURpDpwvFFOxj4kZejTAZ7RcDlp0jf5S5HB0trLtKpJDe6XZXlZ0hwxkO2Mb/SvPxvw==
X-Received: by 2002:a17:90a:65c4:b0:24e:29ed:af07 with SMTP id i4-20020a17090a65c400b0024e29edaf07mr9106407pjs.31.1685320016918;
        Sun, 28 May 2023 17:26:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id gz18-20020a17090b0ed200b0025352448ba9sm7855032pjb.0.2023.05.28.17.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 17:26:56 -0700 (PDT)
Message-ID: <6473f150.170a0220.d8e2.f97f@mx.google.com>
Date: Sun, 28 May 2023 17:26:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip33-21-g8eb0cdf459a2
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline: 135 runs,
 23 regressions (v5.10.180-cip33-21-g8eb0cdf459a2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 May 2023 00:27:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11672

cip/linux-5.10.y-cip baseline: 135 runs, 23 regressions (v5.10.180-cip33-21=
-g8eb0cdf459a2)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip33-21-g8eb0cdf459a2/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip33-21-g8eb0cdf459a2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8eb0cdf459a2bb2971bbf3eecc4f894d2717cff9 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e4ce71b0c9a4b42e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473e4ce71b0c9a4b42e85ec
        failing since 134 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-28T23:33:10.708860  + set +x

    2023-05-28T23:33:10.715305  <8>[   12.330625] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10500410_1.4.2.3.1>

    2023-05-28T23:33:10.823532  / # #

    2023-05-28T23:33:10.926119  export SHELL=3D/bin/sh

    2023-05-28T23:33:10.926435  #

    2023-05-28T23:33:11.027513  / # export SHELL=3D/bin/sh. /lava-10500410/=
environment

    2023-05-28T23:33:11.028492  =


    2023-05-28T23:33:11.130217  / # . /lava-10500410/environment/lava-10500=
410/bin/lava-test-runner /lava-10500410/1

    2023-05-28T23:33:11.131440  =


    2023-05-28T23:33:11.136925  / # /lava-10500410/bin/lava-test-runner /la=
va-10500410/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e4bc98bc75b4742e85f8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473e4bc98bc75b4742e85fd
        failing since 134 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-28T23:33:07.355209  + set +x

    2023-05-28T23:33:07.361695  <8>[   12.383065] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10500382_1.4.2.3.1>

    2023-05-28T23:33:07.466058  #

    2023-05-28T23:33:07.566724  / # #export SHELL=3D/bin/sh

    2023-05-28T23:33:07.566870  =


    2023-05-28T23:33:07.667325  / # export SHELL=3D/bin/sh. /lava-10500382/=
environment

    2023-05-28T23:33:07.667473  =


    2023-05-28T23:33:07.667547  / # <4>[   12.616625] i2c_designware i2c_de=
signware.5: timeout in disabling adapter

    2023-05-28T23:33:07.767989  . /lava-10500382/environment/lava-10500382/=
bin/lava-test-runner /lava-10500382/1

    2023-05-28T23:33:07.768218  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e56fda7608b49b2e8601

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-=
at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-=
at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473e56fda7608b49b2e862f
        failing since 134 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-28T23:35:40.028444  + set +x
    2023-05-28T23:35:40.033653  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 528447_1.5.2=
.4.1>
    2023-05-28T23:35:40.148549  / # #
    2023-05-28T23:35:40.251308  export SHELL=3D/bin/sh
    2023-05-28T23:35:40.252112  #
    2023-05-28T23:35:40.354044  / # export SHELL=3D/bin/sh. /lava-528447/en=
vironment
    2023-05-28T23:35:40.354825  =

    2023-05-28T23:35:40.456870  / # . /lava-528447/environment/lava-528447/=
bin/lava-test-runner /lava-528447/1
    2023-05-28T23:35:40.458218  =

    2023-05-28T23:35:40.464692  / # /lava-528447/bin/lava-test-runner /lava=
-528447/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e60fdb760efdb32e862f

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473e60fdb760efdb32e865c
        failing since 134 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-28T23:38:18.601417  <8>[   21.493780] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 528469_1.5.2.4.1>
    2023-05-28T23:38:18.710722  / # #
    2023-05-28T23:38:18.813905  export SHELL=3D/bin/sh
    2023-05-28T23:38:18.814821  #
    2023-05-28T23:38:18.916960  / # export SHELL=3D/bin/sh. /lava-528469/en=
vironment
    2023-05-28T23:38:18.917869  =

    2023-05-28T23:38:19.020021  / # . /lava-528469/environment/lava-528469/=
bin/lava-test-runner /lava-528469/1
    2023-05-28T23:38:19.021524  =

    2023-05-28T23:38:19.026136  / # /lava-528469/bin/lava-test-runner /lava=
-528469/1
    2023-05-28T23:38:19.113638  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e602fb8eed57ca2e8615

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473e602fb8eed57ca2e8618
        failing since 134 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-28T23:38:00.860617  / # #
    2023-05-28T23:38:00.963537  export SHELL=3D/bin/sh
    2023-05-28T23:38:00.964371  #
    2023-05-28T23:38:01.066294  / # export SHELL=3D/bin/sh. /lava-945890/en=
vironment
    2023-05-28T23:38:01.067093  =

    2023-05-28T23:38:01.168984  / # . /lava-945890/environment/lava-945890/=
bin/lava-test-runner /lava-945890/1
    2023-05-28T23:38:01.170298  =

    2023-05-28T23:38:01.183899  / # /lava-945890/bin/lava-test-runner /lava=
-945890/1
    2023-05-28T23:38:01.306754  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-28T23:38:01.307325  + cd /lava-945890/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6473eac60e40991ebf2e8c2f

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473eac60e40991ebf2e8c61
        failing since 134 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-28T23:58:43.615270  <8>[   20.232511] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 528619_1.5.2.4.1>
    2023-05-28T23:58:43.723982  / # #
    2023-05-28T23:58:43.827022  export SHELL=3D/bin/sh
    2023-05-28T23:58:43.827765  #
    2023-05-28T23:58:43.930154  / # export SHELL=3D/bin/sh. /lava-528619/en=
vironment
    2023-05-28T23:58:43.930892  =

    2023-05-28T23:58:44.033319  / # . /lava-528619/environment/lava-528619/=
bin/lava-test-runner /lava-528619/1
    2023-05-28T23:58:44.034515  =

    2023-05-28T23:58:44.039438  / # /lava-528619/bin/lava-test-runner /lava=
-528619/1
    2023-05-28T23:58:44.140066  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6473ed5f3ea6cf28a62e85f8

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473ed5f3ea6cf28a62e85fb
        failing since 134 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-29T00:09:52.405919  <8>[   13.114156] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 945966_1.5.2.4.1>
    2023-05-29T00:09:52.518348  / # #
    2023-05-29T00:09:52.620765  export SHELL=3D/bin/sh
    2023-05-29T00:09:52.621458  #
    2023-05-29T00:09:52.723267  / # export SHELL=3D/bin/sh. /lava-945966/en=
vironment
    2023-05-29T00:09:52.723963  =

    2023-05-29T00:09:52.825817  / # . /lava-945966/environment/lava-945966/=
bin/lava-test-runner /lava-945966/1
    2023-05-29T00:09:52.826986  =

    2023-05-29T00:09:52.833456  / # /lava-945966/bin/lava-test-runner /lava=
-945966/1
    2023-05-29T00:09:52.937183  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e8ec0ed5d982b32e85eb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a=
-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a=
-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473e8ec0ed5d982b32e85ee
        failing since 134 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-05-28T23:50:39.839576  [   10.535631] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1230204_1.5.2.4.1>
    2023-05-28T23:50:39.946106  / # #
    2023-05-28T23:50:40.047393  export SHELL=3D/bin/sh
    2023-05-28T23:50:40.047717  #
    2023-05-28T23:50:40.148796  / # export SHELL=3D/bin/sh. /lava-1230204/e=
nvironment
    2023-05-28T23:50:40.149066  =

    2023-05-28T23:50:40.250201  / # . /lava-1230204/environment/lava-123020=
4/bin/lava-test-runner /lava-1230204/1
    2023-05-28T23:50:40.250628  =

    2023-05-28T23:50:40.252538  / # /lava-1230204/bin/lava-test-runner /lav=
a-1230204/1
    2023-05-28T23:50:40.270653  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e4c598bc75b4742e8654

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473e4c598bc75b4742e8659
        failing since 44 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-05-28T23:33:08.916187  + <8>[   15.130814] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10500402_1.4.2.3.1>

    2023-05-28T23:33:08.916264  set +x

    2023-05-28T23:33:09.017551  =


    2023-05-28T23:33:09.118079  / # #export SHELL=3D/bin/sh

    2023-05-28T23:33:09.118249  =


    2023-05-28T23:33:09.218741  / # export SHELL=3D/bin/sh. /lava-10500402/=
environment

    2023-05-28T23:33:09.218916  =


    2023-05-28T23:33:09.319426  / # . /lava-10500402/environment/lava-10500=
402/bin/lava-test-runner /lava-10500402/1

    2023-05-28T23:33:09.319751  =


    2023-05-28T23:33:09.324239  / # /lava-10500402/bin/lava-test-runner /la=
va-10500402/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e4c298bc75b4742e8633

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473e4c298bc75b4742e8638
        failing since 44 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-05-28T23:33:01.384070  <8>[   13.805083] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10500350_1.4.2.3.1>

    2023-05-28T23:33:01.387522  + set +x

    2023-05-28T23:33:01.488784  #

    2023-05-28T23:33:01.489089  =


    2023-05-28T23:33:01.589642  / # #export SHELL=3D/bin/sh

    2023-05-28T23:33:01.589817  =


    2023-05-28T23:33:01.690269  / # export SHELL=3D/bin/sh. /lava-10500350/=
environment

    2023-05-28T23:33:01.690482  =


    2023-05-28T23:33:01.791091  / # . /lava-10500350/environment/lava-10500=
350/bin/lava-test-runner /lava-10500350/1

    2023-05-28T23:33:01.791452  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e5ddf720d94df22e8607

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473e5ddf720d94df22e860c
        failing since 134 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-28T23:37:56.037474  / # #

    2023-05-28T23:37:56.140089  export SHELL=3D/bin/sh

    2023-05-28T23:37:56.140842  #

    2023-05-28T23:37:56.242718  / # export SHELL=3D/bin/sh. /lava-10500438/=
environment

    2023-05-28T23:37:56.243470  =


    2023-05-28T23:37:56.345386  / # . /lava-10500438/environment/lava-10500=
438/bin/lava-test-runner /lava-10500438/1

    2023-05-28T23:37:56.346562  =


    2023-05-28T23:37:56.360093  / # /lava-10500438/bin/lava-test-runner /la=
va-10500438/1

    2023-05-28T23:37:56.444053  + export 'TESTRUN_ID=3D1_bootrr'

    2023-05-28T23:37:56.444603  + cd /lava-10500438/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e5e9e3ec25cf762e8626

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473e5e9e3ec25cf762e862b
        failing since 134 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-28T23:38:10.382031  + set +x
    2023-05-28T23:38:10.382180  [   10.235297] <LAVA_SIGNAL_ENDRUN 0_dmesg =
961877_1.5.2.3.1>
    2023-05-28T23:38:10.489742  / # #
    2023-05-28T23:38:10.591354  export SHELL=3D/bin/sh
    2023-05-28T23:38:10.591828  #
    2023-05-28T23:38:10.693039  / # export SHELL=3D/bin/sh. /lava-961877/en=
vironment
    2023-05-28T23:38:10.693551  =

    2023-05-28T23:38:10.794916  / # . /lava-961877/environment/lava-961877/=
bin/lava-test-runner /lava-961877/1
    2023-05-28T23:38:10.795671  =

    2023-05-28T23:38:10.798355  / # /lava-961877/bin/lava-test-runner /lava=
-961877/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e5aeace58e16df2e85ff

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/basel=
ine-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/basel=
ine-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473e5aeace58e16df2e8604
        failing since 134 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-28T23:37:10.038565  + set[    7.190598] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 961875_1.5.2.3.1>
    2023-05-28T23:37:10.038893   +x
    2023-05-28T23:37:10.144384  / # #
    2023-05-28T23:37:10.246014  export SHELL=3D/bin/sh
    2023-05-28T23:37:10.246508  #
    2023-05-28T23:37:10.347733  / # export SHELL=3D/bin/sh. /lava-961875/en=
vironment
    2023-05-28T23:37:10.348132  =

    2023-05-28T23:37:10.449376  / # . /lava-961875/environment/lava-961875/=
bin/lava-test-runner /lava-961875/1
    2023-05-28T23:37:10.450274  =

    2023-05-28T23:37:10.452765  / # /lava-961875/bin/lava-test-runner /lava=
-961875/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e65925a05bce292e85e8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7=
ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7=
ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473e65925a05bce292e85eb
        failing since 76 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.173-cip28)

    2023-05-28T23:38:55.582371  + set +x<8>[   28.957338] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1230200_1.5.2.4.1>
    2023-05-28T23:38:55.582700  =

    2023-05-28T23:38:55.691629  / # #
    2023-05-28T23:38:56.851817  export SHELL=3D/bin/sh
    2023-05-28T23:38:56.857504  #
    2023-05-28T23:38:56.857798  / # export SHELL=3D/bin/sh
    2023-05-28T23:38:58.405384  / # . /lava-1230200/environment
    2023-05-28T23:39:01.230620  /lava-1230200/bin/lava-test-runner /lava-12=
30200/1
    2023-05-28T23:39:01.236473  . /lava-1230200/environment
    2023-05-28T23:39:01.236585  / # /lava-1230200/bin/lava-test-runner /lav=
a-1230200/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e6e796f538d0a02e85f1

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473e6e796f538d0a02e860d
        failing since 134 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-28T23:42:21.887588  <8>[   15.611401] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-05-28T23:42:21.888696  + set +x

    2023-05-28T23:42:21.895015  <8>[   15.621074] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10500553_1.5.2.3.1>

    2023-05-28T23:42:22.000954  / # #

    2023-05-28T23:42:22.103749  export SHELL=3D/bin/sh

    2023-05-28T23:42:22.104647  #

    2023-05-28T23:42:22.206135  / # export SHELL=3D/bin/sh. /lava-10500553/=
environment

    2023-05-28T23:42:22.206926  =


    2023-05-28T23:42:22.308585  / # . /lava-10500553/environment/lava-10500=
553/bin/lava-test-runner /lava-10500553/1

    2023-05-28T23:42:22.309837  =

 =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e543e5134d1f072e861a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7=
743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7=
743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6473e543e5134d1f072e8=
61b
        failing since 5 days (last pass: v5.10.180-cip33, first fail: v5.10=
.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/6473e5e8afd9624c172e8603

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/6473e5e8afd9624c172e8632
        failing since 132 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-28T23:37:51.475866  FIRST,<8>[   18.736226] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-05-28T23:37:51.478028   INC default to 1.

    2023-05-28T23:37:51.478248  =


    2023-05-28T23:37:51.481476  	-w	Pad to last with leading zeros

    2023-05-28T23:37:51.483886  	-s SEP	String separator

    2023-05-28T23:37:51.487982  /lava-10500437/1/../bin/lava-test-case

    2023-05-28T23:37:51.493893  BusyBox v1.31.1 (2023-05-19 20:50:34 UTC) m=
ulti-call binary.

    2023-05-28T23:37:51.494112  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6473e5e8afd9624c172e8633
        failing since 132 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-28T23:37:51.453788  BusyBox v1.31.1 (2023-05-19 20:50:34 UTC)<8=
>[   18.717126] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-05-28T23:37:51.455656   multi-call binary.

    2023-05-28T23:37:51.455877  =


    2023-05-28T23:37:51.459934  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-05-28T23:37:51.460491  =


    2023-05-28T23:37:51.465436  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6473e5e8afd9624c172e8634
        failing since 132 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-28T23:37:51.434545  <8>[   18.699190] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473e5e8afd9624c172e8648
        failing since 132 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-28T23:37:39.383082  + <8>[    6.650303] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10500437_1.5.2.3.1>

    2023-05-28T23:37:39.383302  set +x

    2023-05-28T23:37:39.488735  #

    2023-05-28T23:37:39.590877  / # #export SHELL=3D/bin/sh

    2023-05-28T23:37:39.591491  =


    2023-05-28T23:37:39.692556  / # export SHELL=3D/bin/sh. /lava-10500437/=
environment

    2023-05-28T23:37:39.693221  =


    2023-05-28T23:37:39.794484  / # . /lava-10500437/environment/lava-10500=
437/bin/lava-test-runner /lava-10500437/1

    2023-05-28T23:37:39.795418  =


    2023-05-28T23:37:39.796361  / # /lava-10500437/bin/lava-test-runner /la=
va-10500437/1
 =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6473e70f30f300f10e2e85e9

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6473e70f30f300f10e2e85ef
        failing since 67 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-05-28T23:42:49.907480  <8>[   33.937057] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-05-28T23:42:50.932378  /lava-10500565/1/../bin/lava-test-case

    2023-05-28T23:42:50.943716  <8>[   34.973842] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6473e70f30f300f10e2e85f0
        failing since 67 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-05-28T23:42:49.896116  /lava-10500565/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e7e2649f0251542e864d

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-=
a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-=
a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473e7e3649f0251542e8679
        failing since 134 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-28T23:46:12.921036  + set +x
    2023-05-28T23:46:12.925101  <8>[   16.988470] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 528540_1.5.2.4.1>
    2023-05-28T23:46:13.036933  / # #
    2023-05-28T23:46:13.139159  export SHELL=3D/bin/sh
    2023-05-28T23:46:13.139799  #
    2023-05-28T23:46:13.241734  / # export SHELL=3D/bin/sh. /lava-528540/en=
vironment
    2023-05-28T23:46:13.242407  =

    2023-05-28T23:46:13.344642  / # . /lava-528540/environment/lava-528540/=
bin/lava-test-runner /lava-528540/1
    2023-05-28T23:46:13.346293  =

    2023-05-28T23:46:13.350442  / # /lava-528540/bin/lava-test-runner /lava=
-528540/1 =

    ... (12 line(s) more)  =

 =20

