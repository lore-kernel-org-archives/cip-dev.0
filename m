Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B29C41513
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 11:46:13 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web10.105626.1692013566078721293
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Aug 2023 04:46:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=39X+aW2Q;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1bbc64f9a91so36451045ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Aug 2023 04:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692013565; x=1692618365;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sc8HSsA7TFvB7TpVfWWgSQryLIHOY34LLo6tFRrvA5U=;
        b=39X+aW2Q9S/Gh7cB+N3GmApuH2L57XbeY3qlqQs4BSQnN2rAvwELSR6wQsRtALJYqm
         /w36l3HXMTbHiblAZviH71PqMAGAfNLrCUcTgw4Ol+xcw8HAhJfEdGdCm6GLEdz6/coh
         pPiQtTUs8KJnVWnJcRDi+q5FJDkGPPZhZ54MHgirl/b/56eMUEe3r5p4mY1pXG/jXWS+
         QrSD6IVE2qY8kAHRCeYCor8QMIVEDK4iecIVky01Mr5JVV9eKLVt1IWHve0oLkUsuO7G
         XYnJ60Ajnt6DDIgDA3S3RLFPOAEScEiRsR7L9Nj00FISTCoJz7vkmFqDcXxQqxp6+VoD
         LsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692013565; x=1692618365;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sc8HSsA7TFvB7TpVfWWgSQryLIHOY34LLo6tFRrvA5U=;
        b=AyOoJt8mceRld0fY/JWsiAds/rrG2IY3JdrsHbEPpDgrLGsZazDG4TwUd50enDcy2j
         2I0JmXfq71dNnDVk2bgJd1o8z8eBrWrnkjkYQqb8430ym1a1SvkG2WKPP6oAVOHshuj7
         BbB1dGIzzXiEpjh+IXEu6bkPBTt7iVJTj10BaSqX4dh/8OlYQ109GYq6tqTk2hsEH6Pi
         SC1Y2FBJ2zWaRzGK7OWp/wM+rEffZW6xc/rFMPtgl3L4b2bt7+hk6eRp2vQBbXnWRvCL
         +pBzlfcls49RdF2eetZTn6h6kZR+njHoKeKazfdVC2atedgmWJwwdNNgj6N/Z5jsY04l
         icsQ==
X-Gm-Message-State: AOJu0Yx4LaDgs2cMI3Qoem3VefYm2tghNQSkQ6uDQ7UK4g8g6HlRT4yX
	kA6XpObmsj5PWKMZqsjRfgr6fOAu72/0MRwMdbAp7HN3
X-Google-Smtp-Source: AGHT+IE3SoKJ8lCipgc8JVdzoZ5MnMBgQ1YC0D4BFOxJbQ6d1hdCE9gd4ZIhsmS25v2ThEyHW7c1zA==
X-Received: by 2002:a17:902:9a8d:b0:1bc:667b:63c6 with SMTP id w13-20020a1709029a8d00b001bc667b63c6mr8746758plp.41.1692013564004;
        Mon, 14 Aug 2023 04:46:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jf7-20020a170903268700b001b9f032bb3dsm9291829plb.3.2023.08.14.04.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 04:46:03 -0700 (PDT)
Message-ID: <64da13fb.170a0220.54c37.05d9@mx.google.com>
Date: Mon, 14 Aug 2023 04:46:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.288-cip101-rt32
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip-rt
Subject: cip/linux-4.19.y-cip-rt baseline: 191 runs,
 42 regressions (v4.19.288-cip101-rt32)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 11:46:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12643

cip/linux-4.19.y-cip-rt baseline: 191 runs, 42 regressions (v4.19.288-cip10=
1-rt32)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | defconfi=
g+preempt_rt         | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | defconfi=
g+preempt_rt         | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defc...g+preempt_rt | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defc...g+preempt_rt | 1          =

dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | defconfi=
g+preempt_rt         | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defc...g+preempt_rt | 1          =

imx6ul-14x14-evk             | arm    | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

imx6ul-14x14-evk             | arm    | lab-nxp       | gcc-10   | defconfi=
g+preempt_rt         | 1          =

imx6ul-14x14-evk             | arm    | lab-nxp       | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6ul-14x14-evk             | arm    | lab-nxp       | gcc-10   | multi_v7=
_defc...g+preempt_rt | 1          =

imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | defconfi=
g+preempt_rt         | 1          =

imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | multi_v7=
_defconfig           | 1          =

imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | multi_v7=
_defc...g+preempt_rt | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+preempt_rt         | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | defconfi=
g                    | 3          =

rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | defconfi=
g+preempt_rt         | 3          =

rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 3          =

rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defc...g+preempt_rt | 3          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g+preempt_rt         | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g+preempt_rt         | 1          =

zynqmp-zcu102                | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

zynqmp-zcu102                | arm64  | lab-cip       | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.288-cip101-rt32/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.288-cip101-rt32
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1f3468542aa9e444da3a41472888366e97d515e2 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0ce2a214e1b90a35b1f8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baseli=
ne-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baseli=
ne-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0ce2a214e1b90a35b1fd
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:15:29.304847  + <8>[   11.940040] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11283506_1.4.2.3.1>

    2023-08-14T11:15:29.304916  set +x

    2023-08-14T11:15:29.408399  #

    2023-08-14T11:15:29.509186  / # #export SHELL=3D/bin/sh

    2023-08-14T11:15:29.509387  =


    2023-08-14T11:15:29.609889  / # export SHELL=3D/bin/sh. /lava-11283506/=
environment

    2023-08-14T11:15:29.610095  =


    2023-08-14T11:15:29.710633  / # . /lava-11283506/environment/lava-11283=
506/bin/lava-test-runner /lava-11283506/1

    2023-08-14T11:15:29.710921  =


    2023-08-14T11:15:29.713058  / # /lava-11283506/bin/lava-test-runner /la=
va-11283506/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0cd35a184b7aca35b1e7

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9=
g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9=
g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0cd45a184b7aca35b218
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:14:50.859715  + set +x
    2023-08-14T11:14:50.864742  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 50965_1.5.2.=
4.1>
    2023-08-14T11:14:50.977723  / # #
    2023-08-14T11:14:51.080585  export SHELL=3D/bin/sh
    2023-08-14T11:14:51.081351  #
    2023-08-14T11:14:51.183275  / # export SHELL=3D/bin/sh. /lava-50965/env=
ironment
    2023-08-14T11:14:51.184053  =

    2023-08-14T11:14:51.286025  / # . /lava-50965/environment/lava-50965/bi=
n/lava-test-runner /lava-50965/1
    2023-08-14T11:14:51.287331  =

    2023-08-14T11:14:51.293774  / # /lava-50965/bin/lava-test-runner /lava-=
50965/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0cf0a214e1b90a35b2a5

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0cf0a214e1b90a35b2d0
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:15:16.137297  <8>[   16.248420] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 50995_1.5.2.4.1>
    2023-08-14T11:15:16.246698  / # #
    2023-08-14T11:15:16.349899  export SHELL=3D/bin/sh
    2023-08-14T11:15:16.350594  #
    2023-08-14T11:15:16.452866  / # export SHELL=3D/bin/sh. /lava-50995/env=
ironment
    2023-08-14T11:15:16.453720  =

    2023-08-14T11:15:16.556457  / # . /lava-50995/environment/lava-50995/bi=
n/lava-test-runner /lava-50995/1
    2023-08-14T11:15:16.557925  =

    2023-08-14T11:15:16.561911  / # /lava-50995/bin/lava-test-runner /lava-=
50995/1
    2023-08-14T11:15:16.627995  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0d5e0b00e0039635b256

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-beagle=
bone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-beagle=
bone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0d5e0b00e0039635b281
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:17:06.077234  <8>[   16.220163] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 51007_1.5.2.4.1>
    2023-08-14T11:17:06.188371  / # #
    2023-08-14T11:17:06.291617  export SHELL=3D/bin/sh
    2023-08-14T11:17:06.292461  #
    2023-08-14T11:17:06.394942  / # export SHELL=3D/bin/sh. /lava-51007/env=
ironment
    2023-08-14T11:17:06.395719  =

    2023-08-14T11:17:06.498303  / # . /lava-51007/environment/lava-51007/bi=
n/lava-test-runner /lava-51007/1
    2023-08-14T11:17:06.499666  =

    2023-08-14T11:17:06.503871  / # /lava-51007/bin/lava-test-runner /lava-=
51007/1
    2023-08-14T11:17:06.586142  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0ee6034126dccc35b212

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0ee6034126dccc35b215
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:23:43.523906  <8>[    8.933821] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 997277_1.5.2.4.1>
    2023-08-14T11:23:43.632829  / # #
    2023-08-14T11:23:43.734925  export SHELL=3D/bin/sh
    2023-08-14T11:23:43.735628  #
    2023-08-14T11:23:43.837518  / # export SHELL=3D/bin/sh. /lava-997277/en=
vironment
    2023-08-14T11:23:43.838224  =

    2023-08-14T11:23:43.940074  / # . /lava-997277/environment/lava-997277/=
bin/lava-test-runner /lava-997277/1
    2023-08-14T11:23:43.941264  =

    2023-08-14T11:23:43.947004  / # /lava-997277/bin/lava-test-runner /lava=
-997277/1
    2023-08-14T11:23:44.013618  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/64da1063afc124fe8a35b1dd

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig+preempt_rt/gcc-10/lab-cip/baseline-beaglebone=
-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig+preempt_rt/gcc-10/lab-cip/baseline-beaglebone=
-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da1063afc124fe8a35b1e0
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:30:04.041794  <8>[   10.317807] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 997284_1.5.2.4.1>
    2023-08-14T11:30:04.153560  / # #
    2023-08-14T11:30:04.255945  export SHELL=3D/bin/sh
    2023-08-14T11:30:04.256671  #
    2023-08-14T11:30:04.358521  / # export SHELL=3D/bin/sh. /lava-997284/en=
vironment
    2023-08-14T11:30:04.359218  =

    2023-08-14T11:30:04.461083  / # . /lava-997284/environment/lava-997284/=
bin/lava-test-runner /lava-997284/1
    2023-08-14T11:30:04.462231  =

    2023-08-14T11:30:04.468614  / # /lava-997284/bin/lava-test-runner /lava=
-997284/1
    2023-08-14T11:30:04.550967  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0caa045d5c583735b253

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebo=
ne-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebo=
ne-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0caa045d5c583735b27e
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:14:07.762150  <8>[   16.988153] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 50953_1.5.2.4.1>
    2023-08-14T11:14:07.870319  / # #
    2023-08-14T11:14:07.973177  export SHELL=3D/bin/sh
    2023-08-14T11:14:07.973928  #
    2023-08-14T11:14:08.076293  / # export SHELL=3D/bin/sh. /lava-50953/env=
ironment
    2023-08-14T11:14:08.077050  =

    2023-08-14T11:14:08.179455  / # . /lava-50953/environment/lava-50953/bi=
n/lava-test-runner /lava-50953/1
    2023-08-14T11:14:08.180713  =

    2023-08-14T11:14:08.184797  / # /lava-50953/bin/lava-test-runner /lava-=
50953/1
    2023-08-14T11:14:08.251121  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0cd9330ae6005a35b1df

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-broonie/baseli=
ne-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-broonie/baseli=
ne-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0cda330ae6005a35b20a
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:14:57.324209  <8>[   15.780376] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 50972_1.5.2.4.1>
    2023-08-14T11:14:57.435758  / # #
    2023-08-14T11:14:57.539093  export SHELL=3D/bin/sh
    2023-08-14T11:14:57.540035  #<6>[   15.864768] usb 1-1: new low-speed U=
SB device number 3 using musb-hdrc
    2023-08-14T11:14:57.540478  =

    2023-08-14T11:14:57.642672  / # export SHELL=3D/bin/sh. /lava-50972/env=
ironment
    2023-08-14T11:14:57.643623  =

    2023-08-14T11:14:57.644063  / # <3>[   16.014849] usb 1-1: device descr=
iptor read/64, error -71
    2023-08-14T11:14:57.746278  . /lava-50972/environment/lava-50972/bin/la=
va-test-runner /lava-50972/1
    2023-08-14T11:14:57.747783   =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0daaa4e5e2668235b224

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-b=
lack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-b=
lack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0daaa4e5e2668235b227
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:18:14.097271  / # #
    2023-08-14T11:18:14.200841  export SHELL=3D/bin/sh
    2023-08-14T11:18:14.201863  #
    2023-08-14T11:18:14.304081  / # export SHELL=3D/bin/sh. /lava-997260/en=
vironment
    2023-08-14T11:18:14.305071  =

    2023-08-14T11:18:14.407525  / # . /lava-997260/environment/lava-997260/=
bin/lava-test-runner /lava-997260/1
    2023-08-14T11:18:14.409186  =

    2023-08-14T11:18:14.419942  / # /lava-997260/bin/lava-test-runner /lava=
-997260/1
    2023-08-14T11:18:14.517893  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-14T11:18:14.518466  + cd /lava-997260/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0df623cb97281e35b26f

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-cip/baseline-b=
eaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-cip/baseline-b=
eaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0df623cb97281e35b272
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:19:47.024127  + set +x
    2023-08-14T11:19:47.026796  <8>[   11.217303] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 997263_1.5.2.4.1>
    2023-08-14T11:19:47.135551  / # #
    2023-08-14T11:19:47.237511  export SHELL=3D/bin/sh
    2023-08-14T11:19:47.238107  #
    2023-08-14T11:19:47.339522  / # export SHELL=3D/bin/sh. /lava-997263/en=
vironment
    2023-08-14T11:19:47.339975  =

    2023-08-14T11:19:47.441426  / # . /lava-997263/environment/lava-997263/=
bin/lava-test-runner /lava-997263/1
    2023-08-14T11:19:47.442386  =

    2023-08-14T11:19:47.444096  / # /lava-997263/bin/lava-test-runner /lava=
-997263/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0cfb48f69bb96135b1e3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baseli=
ne-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baseli=
ne-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64da0cfb48f69bb96135b=
1e4
        new failure (last pass: v4.19.280-cip95-rt30) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0cc8ed0f6edd0a35b1f4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0cc8ed0f6edd0a35b1f9
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:15:06.946580  / # #

    2023-08-14T11:15:07.049221  export SHELL=3D/bin/sh

    2023-08-14T11:15:07.049955  #

    2023-08-14T11:15:07.151778  / # export SHELL=3D/bin/sh. /lava-11283608/=
environment

    2023-08-14T11:15:07.152554  =


    2023-08-14T11:15:07.254301  / # . /lava-11283608/environment/lava-11283=
608/bin/lava-test-runner /lava-11283608/1

    2023-08-14T11:15:07.255432  =


    2023-08-14T11:15:07.270328  / # /lava-11283608/bin/lava-test-runner /la=
va-11283608/1

    2023-08-14T11:15:07.381299  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-14T11:15:07.381834  + cd /lava-11283608/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0d2cd5bf4f14c935b214

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-imx6=
q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-imx6=
q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0d2cd5bf4f14c935b219
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:16:50.794535  / # #

    2023-08-14T11:16:50.896805  export SHELL=3D/bin/sh

    2023-08-14T11:16:50.897498  #

    2023-08-14T11:16:50.999173  / # export SHELL=3D/bin/sh. /lava-11283648/=
environment

    2023-08-14T11:16:50.999952  =


    2023-08-14T11:16:51.101632  / # . /lava-11283648/environment/lava-11283=
648/bin/lava-test-runner /lava-11283648/1

    2023-08-14T11:16:51.102795  =


    2023-08-14T11:16:51.117940  / # /lava-11283648/bin/lava-test-runner /la=
va-11283648/1

    2023-08-14T11:16:51.215950  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-14T11:16:51.216445  + cd /lava-11283648/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0c92ed0f6edd0a35b1db

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-=
sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-=
sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0c92ed0f6edd0a35b1e0
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:14:07.471465  / # #

    2023-08-14T11:14:07.573514  export SHELL=3D/bin/sh

    2023-08-14T11:14:07.574199  #

    2023-08-14T11:14:07.675586  / # export SHELL=3D/bin/sh. /lava-11283581/=
environment

    2023-08-14T11:14:07.676263  =


    2023-08-14T11:14:07.777666  / # . /lava-11283581/environment/lava-11283=
581/bin/lava-test-runner /lava-11283581/1

    2023-08-14T11:14:07.778650  =


    2023-08-14T11:14:07.779520  / # /lava-11283581/bin/lava-test-runner /la=
va-11283581/1

    2023-08-14T11:14:07.843805  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-14T11:14:07.899447  + cd /lava-11283581/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0cc05a184b7aca35b1d9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/base=
line-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/base=
line-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0cc05a184b7aca35b1de
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:15:47.929418  / # #

    2023-08-14T11:15:48.031639  export SHELL=3D/bin/sh

    2023-08-14T11:15:48.032360  #

    2023-08-14T11:15:48.133859  / # export SHELL=3D/bin/sh. /lava-11283594/=
environment

    2023-08-14T11:15:48.134555  =


    2023-08-14T11:15:48.236037  / # . /lava-11283594/environment/lava-11283=
594/bin/lava-test-runner /lava-11283594/1

    2023-08-14T11:15:48.237149  =


    2023-08-14T11:15:48.253464  / # /lava-11283594/bin/lava-test-runner /la=
va-11283594/1

    2023-08-14T11:15:48.364340  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-14T11:15:48.364834  + cd /lava-11283594/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6ul-14x14-evk             | arm    | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0dc423cb97281e35b1de

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0dc423cb97281e35b1e1
        failing since 144 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.277-cip94-rt29)

    2023-08-14T11:19:05.041254  + set +x
    2023-08-14T11:19:05.044434  <8>[   22.846210] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1243529_1.5.2.4.1>
    2023-08-14T11:19:05.152538  / # #
    2023-08-14T11:19:06.308464  export SHELL=3D/bin/sh
    2023-08-14T11:19:06.314063  #
    2023-08-14T11:19:07.856205  / # export SHELL=3D/bin/sh. /lava-1243529/e=
nvironment
    2023-08-14T11:19:07.861892  =

    2023-08-14T11:19:10.674209  / # . /lava-1243529/environment/lava-124352=
9/bin/lava-test-runner /lava-1243529/1
    2023-08-14T11:19:10.680250  =

    2023-08-14T11:19:10.681930  / # /lava-1243529/bin/lava-test-runner /lav=
a-1243529/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6ul-14x14-evk             | arm    | lab-nxp       | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0eb309bf20d4a735b24f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-imx6ul-14x=
14-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-imx6ul-14x=
14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0eb309bf20d4a735b252
        failing since 144 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.277-cip94-rt29)

    2023-08-14T11:23:16.339426  + set +x
    2023-08-14T11:23:16.342588  <8>[   24.887923] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1243534_1.5.2.4.1>
    2023-08-14T11:23:16.452141  / # #
    2023-08-14T11:23:17.608221  export SHELL=3D/bin/sh
    2023-08-14T11:23:17.613888  #
    2023-08-14T11:23:19.155919  / # export SHELL=3D/bin/sh. /lava-1243534/e=
nvironment
    2023-08-14T11:23:19.161587  =

    2023-08-14T11:23:21.973538  / # . /lava-1243534/environment/lava-124353=
4/bin/lava-test-runner /lava-1243534/1
    2023-08-14T11:23:21.979576  =

    2023-08-14T11:23:21.981822  / # /lava-1243534/bin/lava-test-runner /lav=
a-1243534/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6ul-14x14-evk             | arm    | lab-nxp       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0cae045d5c583735b28f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14=
-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14=
-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0cae045d5c583735b292
        failing since 144 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.277-cip94-rt29)

    2023-08-14T11:14:24.928946  + set +x
    2023-08-14T11:14:24.932101  <8>[   22.569265] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1243524_1.5.2.4.1>
    2023-08-14T11:14:25.043275  / # #
    2023-08-14T11:14:26.199066  export SHELL=3D/bin/sh
    2023-08-14T11:14:26.204730  #
    2023-08-14T11:14:27.746850  / # export SHELL=3D/bin/sh. /lava-1243524/e=
nvironment
    2023-08-14T11:14:27.752540  =

    2023-08-14T11:14:30.564428  / # . /lava-1243524/environment/lava-124352=
4/bin/lava-test-runner /lava-1243524/1
    2023-08-14T11:14:30.570353  =

    2023-08-14T11:14:30.572134  / # /lava-1243524/bin/lava-test-runner /lav=
a-1243524/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6ul-14x14-evk             | arm    | lab-nxp       | gcc-10   | multi_v7=
_defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0d3714c738667d35b1e7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-nxp/baseline-i=
mx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-nxp/baseline-i=
mx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0d3714c738667d35b1ea
        failing since 144 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.277-cip94-rt29)

    2023-08-14T11:16:41.703378  + set +x
    2023-08-14T11:16:41.706562  <8>[   25.669767] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1243526_1.5.2.4.1>
    2023-08-14T11:16:41.818203  / # #
    2023-08-14T11:16:42.974155  export SHELL=3D/bin/sh
    2023-08-14T11:16:42.979788  #
    2023-08-14T11:16:44.521739  / # export SHELL=3D/bin/sh. /lava-1243526/e=
nvironment
    2023-08-14T11:16:44.527323  =

    2023-08-14T11:16:47.339469  / # . /lava-1243526/environment/lava-124352=
6/bin/lava-test-runner /lava-1243526/1
    2023-08-14T11:16:47.345495  =

    2023-08-14T11:16:47.346741  / # /lava-1243526/bin/lava-test-runner /lav=
a-1243526/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0d3a14c738667d35b1f5

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0d3a14c738667d35b1f8
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:16:50.293192  / # #
    2023-08-14T11:16:51.449218  export SHELL=3D/bin/sh
    2023-08-14T11:16:51.454870  #
    2023-08-14T11:16:52.997105  / # export SHELL=3D/bin/sh. /lava-1243530/e=
nvironment
    2023-08-14T11:16:53.002765  =

    2023-08-14T11:16:55.815302  / # . /lava-1243530/environment/lava-124353=
0/bin/lava-test-runner /lava-1243530/1
    2023-08-14T11:16:55.821274  =

    2023-08-14T11:16:55.833916  / # /lava-1243530/bin/lava-test-runner /lav=
a-1243530/1
    2023-08-14T11:16:55.927875  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-14T11:16:55.928255  + cd /lava-1243530/1/tests/1_bootrr =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0dc64721515ccb35b1f5

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-imx7d-sdb.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-imx7d-sdb.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0dc64721515ccb35b1f8
        failing since 207 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:18:59.719051  / # #
    2023-08-14T11:19:00.875307  export SHELL=3D/bin/sh
    2023-08-14T11:19:00.880999  #
    2023-08-14T11:19:02.423353  / # export SHELL=3D/bin/sh. /lava-1243535/e=
nvironment
    2023-08-14T11:19:02.429033  =

    2023-08-14T11:19:05.241676  / # . /lava-1243535/environment/lava-124353=
5/bin/lava-test-runner /lava-1243535/1
    2023-08-14T11:19:05.247710  =

    2023-08-14T11:19:05.257399  / # /lava-1243535/bin/lava-test-runner /lav=
a-1243535/1
    2023-08-14T11:19:05.355243  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-14T11:19:05.355561  + cd /lava-1243535/1/tests/1_bootrr =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0cab045d5c583735b284

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0cab045d5c583735b287
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:14:22.145346  / # #
    2023-08-14T11:14:23.300984  export SHELL=3D/bin/sh
    2023-08-14T11:14:23.306614  #
    2023-08-14T11:14:23.306945  / # export SHELL=3D/bin/sh
    2023-08-14T11:14:24.848759  / # . /lava-1243523/environment
    2023-08-14T11:14:27.665788  /lava-1243523/bin/lava-test-runner /lava-12=
43523/1
    2023-08-14T11:14:27.671815  . /lava-1243523/environment
    2023-08-14T11:14:27.672083  / # /lava-1243523/bin/lava-test-runner /lav=
a-1243523/1
    2023-08-14T11:14:27.777818  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-14T11:14:27.778182  + cd /lava-1243523/1/tests/1_bootrr =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | multi_v7=
_defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0cd3a214e1b90a35b1d9

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-nxp/baseline-i=
mx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-nxp/baseline-i=
mx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0cd3a214e1b90a35b1dc
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:15:07.939609  / # #
    2023-08-14T11:15:09.095313  export SHELL=3D/bin/sh
    2023-08-14T11:15:09.100934  #
    2023-08-14T11:15:10.642088  / # export SHELL=3D/bin/sh. /lava-1243525/e=
nvironment
    2023-08-14T11:15:10.647663  =

    2023-08-14T11:15:13.459289  / # . /lava-1243525/environment/lava-124352=
5/bin/lava-test-runner /lava-1243525/1
    2023-08-14T11:15:13.465203  =

    2023-08-14T11:15:13.465446  / # /lava-1243525/bin/lava-test-runner /lav=
a-1243525/1
    2023-08-14T11:15:13.572594  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-14T11:15:13.572883  + cd /lava-1243525/1/tests/1_bootrr =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0e05925ab7ebbf35b1db

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-r8a774b1=
-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-r8a774b1=
-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64da0e05925ab7ebbf35b=
1dc
        failing since 83 days (last pass: v4.19.277-cip94-rt29, first fail:=
 v4.19.280-cip95-rt30) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | defconfi=
g                    | 3          =


  Details:     https://kernelci.org/test/plan/id/64da0f50396cc661e035b21f

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64da0f50396cc661e035b24f
        failing since 205 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:27:21.671024  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   10.897056] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-08-14T11:27:21.673023   multi-call binary.

    2023-08-14T11:27:21.673249  =


    2023-08-14T11:27:21.678257  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-08-14T11:27:21.678312  =


    2023-08-14T11:27:21.682837  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64da0f50396cc661e035b250
        failing since 205 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:27:21.652366  <8>[   10.879701] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0f50396cc661e035b257
        failing since 205 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:27:17.822460  <8>[    7.049913] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-08-14T11:27:17.831870  + <8>[    7.062113] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11283613_1.5.2.3.1>

    2023-08-14T11:27:17.834358  set +x

    2023-08-14T11:27:17.939102  =


    2023-08-14T11:27:18.040515  / # #export SHELL=3D/bin/sh

    2023-08-14T11:27:18.041314  =


    2023-08-14T11:27:18.142558  / # export SHELL=3D/bin/sh. /lava-11283613/=
environment

    2023-08-14T11:27:18.143162  =


    2023-08-14T11:27:18.243992  / # . /lava-11283613/environment/lava-11283=
613/bin/lava-test-runner /lava-11283613/1

    2023-08-14T11:27:18.244900  =

 =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | defconfi=
g+preempt_rt         | 3          =


  Details:     https://kernelci.org/test/plan/id/64da0fa06346988a1535b1d9

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-rk32=
88-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-rk32=
88-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64da0fa06346988a1535b209
        failing since 205 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:28:42.939024  <8>[   10.495697] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-driver-audio-present RESULT=3Dfail>

    2023-08-14T11:28:42.939097  =


    2023-08-14T11:28:42.943311  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-08-14T11:28:42.943536  =


    2023-08-14T11:28:42.948722  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-08-14T11:28:42.951173  FIRST, INC default to 1.

    2023-08-14T11:28:42.951393  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64da0fa06346988a1535b20a
        failing since 205 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:28:42.916889  <8>[   10.476888] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>

    2023-08-14T11:28:42.928712  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0fa06346988a1535b21d
        failing since 205 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:28:39.050176  <8>[    6.609664] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-08-14T11:28:39.059602  + <8>[    6.621928] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11283644_1.5.2.3.1>

    2023-08-14T11:28:39.060169  set +x

    2023-08-14T11:28:39.166093  =


    2023-08-14T11:28:39.267627  / # #export SHELL=3D/bin/sh

    2023-08-14T11:28:39.268380  =


    2023-08-14T11:28:39.369815  / # export SHELL=3D/bin/sh. /lava-11283644/=
environment

    2023-08-14T11:28:39.370508  =


    2023-08-14T11:28:39.471948  / # . /lava-11283644/environment/lava-11283=
644/bin/lava-test-runner /lava-11283644/1

    2023-08-14T11:28:39.473085  =

 =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/64da0eb109bf20d4a735b205

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288=
-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288=
-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64da0eb209bf20d4a735b235
        failing since 205 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:24:46.128665   multi-call binary.

    2023-08-14T11:24:46.128895  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64da0eb209bf20d4a735b236
        failing since 205 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:24:46.106504  <8>[   11.011133] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>

    2023-08-14T11:24:46.125042  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   11.028732] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0eb209bf20d4a735b249
        failing since 205 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:24:42.277453  <8>[    7.182232] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-08-14T11:24:42.286237  + <8>[    7.194190] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11283577_1.5.2.3.1>

    2023-08-14T11:24:42.287041  set +x

    2023-08-14T11:24:42.393138  =


    2023-08-14T11:24:42.494823  / # #export SHELL=3D/bin/sh

    2023-08-14T11:24:42.495557  =


    2023-08-14T11:24:42.596982  / # export SHELL=3D/bin/sh. /lava-11283577/=
environment

    2023-08-14T11:24:42.597709  =


    2023-08-14T11:24:42.699053  / # . /lava-11283577/environment/lava-11283=
577/bin/lava-test-runner /lava-11283577/1

    2023-08-14T11:24:42.700130  =

 =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defc...g+preempt_rt | 3          =


  Details:     https://kernelci.org/test/plan/id/64da0f00fa4c935cb235b1e6

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/base=
line-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/base=
line-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64da0f00fa4c935cb235b216
        failing since 205 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:26:01.685433  <8>[   10.439116] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-driver-audio-present RESULT=3Dfail>

    2023-08-14T11:26:01.685487  =


    2023-08-14T11:26:01.689992  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-08-14T11:26:01.690049  =


    2023-08-14T11:26:01.695210  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-08-14T11:26:01.697504  FIRST, INC default to 1.

    2023-08-14T11:26:01.697886  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64da0f00fa4c935cb235b217
        failing since 205 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:26:01.663785  /lava-11283586/1/../bin/lava-test-case<8>[ =
  10.420643] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed RE=
SULT=3Dpass>

    2023-08-14T11:26:01.663850  =


    2023-08-14T11:26:01.675271  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0f00fa4c935cb235b22a
        failing since 205 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:25:57.798388  <8>[    6.554435] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-08-14T11:25:57.807979  + <8>[    6.566912] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11283586_1.5.2.3.1>

    2023-08-14T11:25:57.808376  set +x

    2023-08-14T11:25:57.914712  =


    2023-08-14T11:25:58.016292  / # #export SHELL=3D/bin/sh

    2023-08-14T11:25:58.017034  =


    2023-08-14T11:25:58.118434  / # export SHELL=3D/bin/sh. /lava-11283586/=
environment

    2023-08-14T11:25:58.119127  =


    2023-08-14T11:25:58.220460  / # . /lava-11283586/environment/lava-11283=
586/bin/lava-test-runner /lava-11283586/1

    2023-08-14T11:25:58.221628  =

 =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0c260e04e60a8035b1e0

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine=
64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine=
64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0c260e04e60a8035b203
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:11:59.249834  <8>[   15.979115] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 50936_1.5.2.4.1>
    2023-08-14T11:11:59.359326  / # #
    2023-08-14T11:11:59.462918  export SHELL=3D/bin/sh
    2023-08-14T11:11:59.463841  #
    2023-08-14T11:11:59.566498  / # export SHELL=3D/bin/sh. /lava-50936/env=
ironment
    2023-08-14T11:11:59.567396  =

    2023-08-14T11:11:59.669947  / # . /lava-50936/environment/lava-50936/bi=
n/lava-test-runner /lava-50936/1
    2023-08-14T11:11:59.671473  =

    2023-08-14T11:11:59.675684  / # /lava-50936/bin/lava-test-runner /lava-=
50936/1
    2023-08-14T11:11:59.706244  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0d2b273d74a31f35b1e5

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-sun5=
0i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-sun5=
0i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0d2b273d74a31f35b20b
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:16:22.693447  <8>[   16.893592] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 50986_1.5.2.4.1>
    2023-08-14T11:16:22.800779  / # #
    2023-08-14T11:16:22.902747  export SHELL=3D/bin/sh
    2023-08-14T11:16:22.903394  #
    2023-08-14T11:16:23.004970  / # export SHELL=3D/bin/sh. /lava-50986/env=
ironment
    2023-08-14T11:16:23.005449  =

    2023-08-14T11:16:23.106843  / # . /lava-50986/environment/lava-50986/bi=
n/lava-test-runner /lava-50986/1
    2023-08-14T11:16:23.107749  =

    2023-08-14T11:16:23.111586  / # /lava-50986/bin/lava-test-runner /lava-=
50986/1
    2023-08-14T11:16:23.153597  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0c071cfea66cfe35b209

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0c071cfea66cfe35b20e
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:13:29.398475  / # #

    2023-08-14T11:13:29.500650  export SHELL=3D/bin/sh

    2023-08-14T11:13:29.501395  #

    2023-08-14T11:13:29.602852  / # export SHELL=3D/bin/sh. /lava-11283526/=
environment

    2023-08-14T11:13:29.603573  =


    2023-08-14T11:13:29.705104  / # . /lava-11283526/environment/lava-11283=
526/bin/lava-test-runner /lava-11283526/1

    2023-08-14T11:13:29.706303  =


    2023-08-14T11:13:29.722383  / # /lava-11283526/bin/lava-test-runner /la=
va-11283526/1

    2023-08-14T11:13:29.780439  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-14T11:13:29.780983  + cd /lava-1128352<8>[   15.595906] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11283526_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0ca9045d5c583735b248

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-su=
n50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-su=
n50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0ca9045d5c583735b24d
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:16:06.910357  / # #

    2023-08-14T11:16:07.011088  export SHELL=3D/bin/sh

    2023-08-14T11:16:07.011667  #

    2023-08-14T11:16:07.112603  / # export SHELL=3D/bin/sh. /lava-11283597/=
environment

    2023-08-14T11:16:07.112836  =


    2023-08-14T11:16:07.213555  / # . /lava-11283597/environment/lava-11283=
597/bin/lava-test-runner /lava-11283597/1

    2023-08-14T11:16:07.213864  =


    2023-08-14T11:16:07.223628  / # /lava-11283597/bin/lava-test-runner /la=
va-11283597/1

    2023-08-14T11:16:07.296483  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-14T11:16:07.296660  + cd /lava-1128359<8>[   16.429597] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11283597_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
zynqmp-zcu102                | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0bee448037da0b35b1f1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0bee448037da0b35b1f4
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:11:22.590606  + set +x
    2023-08-14T11:11:22.591611  <8>[    3.750262] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 997251_1.5.2.4.1>
    2023-08-14T11:11:22.696483  / # #
    2023-08-14T11:11:22.797643  export SHELL=3D/bin/sh
    2023-08-14T11:11:22.797868  #
    2023-08-14T11:11:22.898929  / # export SHELL=3D/bin/sh. /lava-997251/en=
vironment
    2023-08-14T11:11:22.899298  =

    2023-08-14T11:11:23.000315  / # . /lava-997251/environment/lava-997251/=
bin/lava-test-runner /lava-997251/1
    2023-08-14T11:11:23.000694  =

    2023-08-14T11:11:23.003554  / # /lava-997251/bin/lava-test-runner /lava=
-997251/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
zynqmp-zcu102                | arm64  | lab-cip       | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0c8f11c7598bd535b1fd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-zynqmp-z=
cu102.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-zynqmp-z=
cu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64da0c8f11c7598bd535b200
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:14:01.921092  + set +x
    2023-08-14T11:14:01.922130  <8>[    4.472792] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 997267_1.5.2.4.1>
    2023-08-14T11:14:02.029851  / # #
    2023-08-14T11:14:02.131993  export SHELL=3D/bin/sh
    2023-08-14T11:14:02.132458  #
    2023-08-14T11:14:02.233852  / # export SHELL=3D/bin/sh. /lava-997267/en=
vironment
    2023-08-14T11:14:02.234334  =

    2023-08-14T11:14:02.335726  / # . /lava-997267/environment/lava-997267/=
bin/lava-test-runner /lava-997267/1
    2023-08-14T11:14:02.336461  =

    2023-08-14T11:14:02.339394  / # /lava-997267/bin/lava-test-runner /lava=
-997267/1 =

    ... (13 line(s) more)  =

 =20

