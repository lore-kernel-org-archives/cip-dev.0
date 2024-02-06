Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC17C48297
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 02:40:12 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web11.13345.1707187207577132739
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 18:40:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=fxt1cqKn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso4619482a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 18:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707187206; x=1707792006; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r5kSGAksRlBfUjYjdJQPMRTM+dyyy0xcKSunDMd7AB8=;
        b=fxt1cqKnESB6VSogNqSKeJQ8Cy74XzP/77LbpOKzqoS++pPPcUnQO5xG/I72GsviP1
         6Ldp4GFa1l0OJE8v3ByIqwYH2g6VOjg9JxBmxoRAry9IfEsJYMhM+CENFPSty/Uku7Yi
         IzzsaxDPNr1U+/qLVT1aWkpKz7u0L9ugVX6konYOAE0uuMjgA4k37f1+2S2kHcX9BgFY
         0S05nxEuRc9Ce0QKMbXF/PXKepyJcrmxzE8wuxIlUkQo7gdC9XWBqecjeOc58pWPUecv
         0M7eK/b3zU0FsDtDceIYhoHk3pcZdTrR9CMlortwsio1CrGBL+3edZye5jwVe9yAgRkE
         p0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707187206; x=1707792006;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5kSGAksRlBfUjYjdJQPMRTM+dyyy0xcKSunDMd7AB8=;
        b=YrmPl0tYnecGEw9twHk7+M5yMv66fpCMBOtTo7UoPzRp/JM0au5JgMbkeeyweZZEbj
         Z/+jqBtaSkT2dBsESAoJDsci9evm6bkdnzwpZbRRoG8Sdle5tS9csfSZusTAz26E/cdi
         YezgJfDVN//IZe5F7uIAWtvgXDIqFqVCg2/z4SuIarV+i6Rbuo8n3BD6kSJZ1Jz+uAQ7
         +akb64H5cezG2mSDuVC+bRaHqAMYeMOZBLFQ0PsHCz43c2zqf5Co8Mn41hquhARdJqVh
         I50JmieJ22pqeGvjcP3d3FEskrsUPjBGjNdmJAGMSyTqEbgRDM48KhoO11qWcMvNGuZ1
         w7TA==
X-Gm-Message-State: AOJu0YxV+ZZ88XUbGwcpUWjRghZhYyrDtQ8X+N6rAC3F3ctGJhaGy4+2
	nFqqVusSKwQq9JTmF8TzXH+I6Dg7NP9bVGFeD75JG7dp+xnrgrfCJlcjTC2LkxHdsVjb7bHXqFN
	k
X-Google-Smtp-Source: AGHT+IGq162BRFDoT9iht20SBjI31RLVE1umk/t4TCxk4j+TnBorozFiQFMh9xhZcik/AW+Os9PiQA==
X-Received: by 2002:a05:6a20:70d3:b0:19e:9959:361 with SMTP id v19-20020a056a2070d300b0019e99590361mr324585pza.11.1707187206238;
        Mon, 05 Feb 2024 18:40:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWYXQfXW7cy7Xq8aRrR6XfhA1/CHxvA4wXeqrNa2XkI8Vu+MREMXRSbbZ1wlVUO+1QUTrivu+5o0diF3nZDnVZGN0a9gJcPPKRcKe4wyWlUcg2SyiF2kZVPPkUNH1H0KcqTd6acv9b4rzbX0IcgNyaYzA==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id cm17-20020a17090afa1100b00296885dcef7sm213404pjb.16.2024.02.05.18.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 18:40:05 -0800 (PST)
Message-ID: <65c19c05.170a0220.dca32.0a7a@mx.google.com>
Date: Mon, 05 Feb 2024 18:40:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.209-cip44-rt18
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt baseline-nfs: 84 runs,
 12 regressions (v5.10.209-cip44-rt18)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 02:40:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14766

cip/linux-5.10.y-cip-rt baseline-nfs: 84 runs, 12 regressions (v5.10.209-ci=
p44-rt18)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig   | 1          =

beaglebone-black             | arm   | lab-cip       | gcc-10   | multi_v7_=
defconfig   | 1          =

beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig  | 1          =

beaglebone-black             | arm   | lab-cip       | gcc-10   | omap2plus=
_defconfig  | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
+preempt_rt | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
            | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
            | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+preempt_rt | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
            | 1          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
+preempt_rt | 1          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
            | 1          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
+preempt_rt | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.209-cip44-rt18/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.209-cip44-rt18
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d814befd12dcf6c81b483cb36f507d70112c1097 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig   | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1939978d2c0f8ec00a03c

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beagl=
ebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beagl=
ebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c1939978d2c0f8ec00a06d
        failing since 375 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2024-02-06T02:03:17.438199  <8>[   56.552559] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 547244_1.6.2.4.1>
    2024-02-06T02:03:17.562343  / # #
    2024-02-06T02:03:17.664900  export SHELL=3D/bin/sh
    2024-02-06T02:03:17.665533  #
    2024-02-06T02:03:17.767137  / # export SHELL=3D/bin/sh. /lava-547244/en=
vironment
    2024-02-06T02:03:17.767632  =

    2024-02-06T02:03:17.869287  / # . /lava-547244/environment/lava-547244/=
bin/lava-test-runner /lava-547244/1
    2024-02-06T02:03:17.870173  =

    2024-02-06T02:03:17.875000  / # /lava-547244/bin/lava-test-runner /lava=
-547244/1
    2024-02-06T02:03:18.115424  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
beaglebone-black             | arm   | lab-cip       | gcc-10   | multi_v7_=
defconfig   | 1          =


  Details:     https://kernelci.org/test/plan/id/65c19629732c46286200a193

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebon=
e-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebon=
e-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c19629732c46286200a1bf
        failing since 375 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2024-02-06T02:14:13.362960  <8>[   48.188732] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1089070_1.6.2.4.1>
    2024-02-06T02:14:13.598509  #
    2024-02-06T02:14:13.700288  / # #export SHELL=3D/bin/sh
    2024-02-06T02:14:13.700722  =

    2024-02-06T02:14:13.801640  / # export SHELL=3D/bin/sh. /lava-1089070/e=
nvironment
    2024-02-06T02:14:13.802108  =

    2024-02-06T02:14:13.902896  / # . /lava-1089070/environment/lava-108907=
0/bin/lava-test-runner /lava-1089070/1
    2024-02-06T02:14:13.903679  =

    2024-02-06T02:14:13.910476  / # /lava-1089070/bin/lava-test-runner /lav=
a-1089070/1
    2024-02-06T02:14:14.250421  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c192beb70a64156e00a090

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c192beb70a64156e00a0ca
        failing since 320 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.175-cip29-rt12)

    2024-02-06T02:00:09.874054  <8>[   46.244181] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 547231_1.6.2.4.1>
    2024-02-06T02:00:09.991753  / # #
    2024-02-06T02:00:10.094130  export SHELL=3D/bin/sh
    2024-02-06T02:00:10.094753  #
    2024-02-06T02:00:10.196586  / # export SHELL=3D/bin/sh. /lava-547231/en=
vironment
    2024-02-06T02:00:10.197198  =

    2024-02-06T02:00:10.299093  / # . /lava-547231/environment/lava-547231/=
bin/lava-test-runner /lava-547231/1
    2024-02-06T02:00:10.299927  =

    2024-02-06T02:00:10.304809  / # /lava-547231/bin/lava-test-runner /lava=
-547231/1
    2024-02-06T02:00:10.597529  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
beaglebone-black             | arm   | lab-cip       | gcc-10   | omap2plus=
_defconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c192f5a0e2bb537100a067

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebo=
ne-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebo=
ne-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c192f5a0e2bb537100a098
        failing since 320 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.175-cip29-rt12)

    2024-02-06T02:00:54.502018  + set +x
    2024-02-06T02:00:54.513676  <8>[   45.351928] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1089061_1.6.2.4.1>
    2024-02-06T02:00:54.667248  #
    2024-02-06T02:00:54.769559  / # #export SHELL=3D/bin/sh
    2024-02-06T02:00:54.770207  =

    2024-02-06T02:00:54.871485  / # export SHELL=3D/bin/sh. /lava-1089061/e=
nvironment
    2024-02-06T02:00:54.872135  =

    2024-02-06T02:00:54.973439  / # . /lava-1089061/environment/lava-108906=
1/bin/lava-test-runner /lava-1089061/1
    2024-02-06T02:00:54.974478  =

    2024-02-06T02:00:54.980502  / # /lava-1089061/bin/lava-test-runner /lav=
a-1089061/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1958519d6c20f0100a039

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-j=
uno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-j=
uno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c1958519d6c20f0100a079
        failing since 74 days (last pass: v5.10.184-cip36-rt14, first fail:=
 v5.10.201-cip41-rt17)

    2024-02-06T02:11:46.881042  <8>[   41.135026] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 547268_1.6.2.4.1>
    2024-02-06T02:11:47.000007  / # #
    2024-02-06T02:11:47.102849  export SHELL=3D/bin/sh
    2024-02-06T02:11:47.103613  #
    2024-02-06T02:11:47.205495  / # export SHELL=3D/bin/sh. /lava-547268/en=
vironment
    2024-02-06T02:11:47.206273  =

    2024-02-06T02:11:47.308466  / # . /lava-547268/environment/lava-547268/=
bin/lava-test-runner /lava-547268/1
    2024-02-06T02:11:47.309786  =

    2024-02-06T02:11:47.328764  / # /lava-547268/bin/lava-test-runner /lava=
-547268/1
    2024-02-06T02:11:47.501514  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65c197b53746e67b5c00a03f

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-juno-uboot.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-juno-uboot.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c197b53746e67b5c00a07f
        failing since 74 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v5.10.201-cip41-rt17)

    2024-02-06T02:21:03.240939  <8>[   56.402157] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 547325_1.6.2.4.1>
    2024-02-06T02:21:03.345595  / # #
    2024-02-06T02:21:03.448485  export SHELL=3D/bin/sh
    2024-02-06T02:21:03.449286  #
    2024-02-06T02:21:03.551232  / # export SHELL=3D/bin/sh. /lava-547325/en=
vironment
    2024-02-06T02:21:03.552209  =

    2024-02-06T02:21:03.654135  / # . /lava-547325/environment/lava-547325/=
bin/lava-test-runner /lava-547325/1
    2024-02-06T02:21:03.655458  =

    2024-02-06T02:21:03.674635  / # /lava-547325/bin/lava-test-runner /lava=
-547325/1
    2024-02-06T02:21:03.840248  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1968a7a395d62af00a04e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s9=
05x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s9=
05x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c1968a7a395d62a=
f00a04f
        failing since 139 days (last pass: v5.10.179-cip32-rt13, first fail=
: v5.10.194-cip39-rt16) =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1963c6e967f1aed00a04e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-nfs-r8a77=
4a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-nfs-r8a77=
4a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c1963c6e967f1ae=
d00a04f
        failing since 139 days (last pass: v5.10.186-cip37-rt15, first fail=
: v5.10.194-cip39-rt16) =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1992c561c57426900a05f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-=
rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-=
rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c1992c561c57426=
900a060
        failing since 139 days (last pass: v5.10.186-cip37-rt15, first fail=
: v5.10.194-cip39-rt16) =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65c194051786c179eb00a04a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-nfs=
-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-nfs=
-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c194051786c179eb00a053
        failing since 74 days (last pass: v5.10.184-cip36-rt14, first fail:=
 v5.10.201-cip41-rt17)

    2024-02-06T02:05:39.402945  / # #

    2024-02-06T02:05:40.663583  export SHELL=3D/bin/sh

    2024-02-06T02:05:40.673832  #

    2024-02-06T02:05:40.673900  / # export SHELL=3D/bin/sh

    2024-02-06T02:05:42.411321  / # . /lava-12705523/environment

    2024-02-06T02:05:45.611379  /lava-12705523/bin/lava-test-runner /lava-1=
2705523/1

    2024-02-06T02:05:45.622920  . /lava-12705523/environment

    2024-02-06T02:05:45.623401  / # /lava-12705523/bin/lava-test-runner /la=
va-12705523/1

    2024-02-06T02:05:45.795419  + export TESTRUN_ID=3D1_bootrr

    2024-02-06T02:05:45.795888  + cd /lava-12705523/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65c19581fc39ce055400a044

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-rk3399-roc=
k-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-rk3399-roc=
k-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c19581fc39ce055400a04d
        failing since 74 days (last pass: v5.10.179-cip32-rt13, first fail:=
 v5.10.201-cip41-rt17)

    2024-02-06T02:12:01.655369  / # #

    2024-02-06T02:12:02.916705  export SHELL=3D/bin/sh

    2024-02-06T02:12:02.927687  #

    2024-02-06T02:12:02.928204  / # export SHELL=3D/bin/sh

    2024-02-06T02:12:04.671100  / # . /lava-12705544/environment

    2024-02-06T02:12:07.874362  /lava-12705544/bin/lava-test-runner /lava-1=
2705544/1

    2024-02-06T02:12:07.885768  . /lava-12705544/environment

    2024-02-06T02:12:07.890212  / # /lava-12705544/bin/lava-test-runner /la=
va-12705544/1

    2024-02-06T02:12:08.065030  + export TESTRUN_ID=3D1_bootrr

    2024-02-06T02:12:08.065450  + cd /lava-12705544/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65c195fecd035e9a6500a0ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-s=
un50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-s=
un50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c195fecd035e9a6=
500a0ed
        new failure (last pass: v5.10.201-cip41-rt17) =

 =20

