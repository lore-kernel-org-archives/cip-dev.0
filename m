Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CE8EB64DC
	for <webhook@archiver.kernel.org>; Tue, 11 Jul 2023 15:29:29 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web11.2739.1689089363410672837
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Jul 2023 08:29:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=w1Qft1QX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-666e3b15370so3380582b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 11 Jul 2023 08:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689089362; x=1691681362;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AMLB6aJGtKzgKaNPmhAjDjekZ16f3grsLvnrU8nXI7Q=;
        b=w1Qft1QX+MPNog7HtbAp8uRtetVcUFL905/AYTHXsHW807bmLDDw16DfWluoEOtSCd
         n9wv9JKF02ZZ0kEmmyulT8x5l+UMfONpFWo5TZ2i/C2MNb+WRf+foynLdKayM1Om/td8
         cNwPvTkk5sLZVXlMEL15F3BJv8JC2Z7YLSxLHqD6DYmm5tISe/WRp2OysB2x4ep65YP4
         Aj6mVSppmv5N9Amgy/chSr+MFlJMe/9/viooPinMkQdP8GqOslY15w1Wjzhb8jPF619z
         DhsUzlOHblIgCjY8hUzeYKOX9g2yk9oIJwek7sdunQu7aTMLg1YoA8hYK+p41zR7y27M
         wNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689089362; x=1691681362;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AMLB6aJGtKzgKaNPmhAjDjekZ16f3grsLvnrU8nXI7Q=;
        b=ZGWYL8mnWMr8fw52vZpT0wGCFs4kG3Re3Z2q6IfcwYFv+CEEtMUk+skXjvp8FuP8Lk
         lhir+vK4AJyXcrNIf6ESZCLh4794XEXbk2NcTGgsaKrUBdCDzUc+ZeUOzAWpXNPFnHAa
         sBRVGqNRABfX1ToC61WPVLJiYQZqFeuMPVYFa5WKF+rTSN6nmK5YZqzzAWAdC4VOjo8f
         bFLmBH59FQMSqslQ7F+MW7MDP94XcG7pVfqzRo50OIk3KxFIs2tPT0/5SreztwDCenf7
         mRkPTwyYVD3B3B+cMs9QiQKUcTYKqFsFmE1T9Ww6SG63taBUaiuY/4ff5OK6fGoX+jGK
         pEZQ==
X-Gm-Message-State: ABy/qLYVVhv0v55mxHOQaZ41sYZqNxIcAV6nrEZ0+Cc85O3QORE9IAIq
	b7jq6i6GkV6Lj+dg7BuGGNi4rxtBVQ3FH2ed+0Vvvw==
X-Google-Smtp-Source: APBJJlEDu8zEOpnI96l0eNi2M20LY4K1hpoVXkMskS75Y2HV42VmJK25vCeeD258+GRKizCmQUvpYA==
X-Received: by 2002:a05:6a20:7485:b0:130:d5a:e413 with SMTP id p5-20020a056a20748500b001300d5ae413mr16181683pzd.6.1689089362441;
        Tue, 11 Jul 2023 08:29:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i15-20020aa78d8f000000b0068277318e6asm1789358pfr.209.2023.07.11.08.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:29:21 -0700 (PDT)
Message-ID: <64ad7551.a70a0220.1b1a3.36c5@mx.google.com>
Date: Tue, 11 Jul 2023 08:29:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4.302-cip72-620-g8dfbbc901d03
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.4.y-cip
Subject: cip/linux-4.4.y-cip baseline: 40 runs,
 3 regressions (v4.4.302-cip72-620-g8dfbbc901d03)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jul 2023 15:29:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12317

cip/linux-4.4.y-cip baseline: 40 runs, 3 regressions (v4.4.302-cip72-620-g8=
dfbbc901d03)

Regressions Summary
-------------------

platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
r8a7743-iwg20d-q7 | arm  | lab-cip       | gcc-10   | shmobile_defconfig | =
1          =

rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig | =
2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-620-g8dfbbc901d03/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-620-g8dfbbc901d03
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8dfbbc901d030767282dd3cef0254499fc5d108c =



Test Regressions
---------------- =



platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
r8a7743-iwg20d-q7 | arm  | lab-cip       | gcc-10   | shmobile_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/64ad6f4c65ed50efa4bb2a7c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-620-g8dfbbc901d03/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a77=
43-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-620-g8dfbbc901d03/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a77=
43-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ad6f4c65ed50efa4bb2=
a7d
        failing since 69 days (last pass: v4.4.302-cip72, first fail: v4.4.=
302-cip72-372-ga3bc58e64f55) =

 =



platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig | =
2          =


  Details:     https://kernelci.org/test/plan/id/64ad6ea2818ec70e70bb2a89

  Results:     37 PASS, 22 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-620-g8dfbbc901d03/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-620-g8dfbbc901d03/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64ad6ea2818ec70e70bb2aa7
        failing since 166 days (last pass: v4.4.302-cip71-1-g61333eee4869, =
first fail: v4.4.302-cip71-590-g22fc523bf881)

    2023-07-11T15:01:59.816754  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA[ =
  24.297592] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-au=
dio-present RESULT=3Dfail>

    2023-07-11T15:01:59.816982  ST

    2023-07-11T15:01:59.817201  =


    2023-07-11T15:01:59.821605  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-07-11T15:01:59.823935  FIRST, INC default to 1.

    2023-07-11T15:01:59.824154  =


    2023-07-11T15:01:59.827147  	-w	Pad to last with leading zeros

    2023-07-11T15:01:59.829491  	-s SEP	String separator

    2023-07-11T15:01:59.832987  /lava-11062019/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64ad6ea2818ec70e70bb2aa8
        failing since 166 days (last pass: v4.4.302-cip71-1-g61333eee4869, =
first fail: v4.4.302-cip71-590-g22fc523bf881)

    2023-07-11T15:01:59.762718  [   24.246861] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dfail>

    2023-07-11T15:01:59.804244  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-07-11T15:01:59.804679  =

   =

 =20

