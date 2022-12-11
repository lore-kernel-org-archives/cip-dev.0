Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EC8C4332F
	for <webhook@archiver.kernel.org>; Sun, 11 Dec 2022 18:34:14 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web10.23494.1670783645078482681
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 11 Dec 2022 10:34:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=zEfu8BpU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso13344801pjt.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 11 Dec 2022 10:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pzyVcOfrHAYLeYQbm69mTh3ULU7/yJ+TP7MbWf4f0xY=;
        b=zEfu8BpUF0pE8ZJF9g6QTLlRLFstvXZeBY94HJqK5QRpmpHlnSHAEdDWX9xHNm5rZD
         Qx4X5d3AwhrpPqVHb7GaZzmCBC5R7aMzFHqyBuqm0AKZyGi9YhNRTBvk9URZalg61mKs
         6vhIgQfKnZk9M6hhYLPFwodqn3IDtVTtrLwTcYrVqmDtOIam+VQh3GgndYdrM70bc+kl
         QpkLj5I3ga00klDQ7VSwxsLaj3C8junG3z/ldNaTzupCz+P2m+cDCv4oqrLgsSwMxHSK
         VEGNnqvkd+P4MidBQTDwGWrbkM0ijg+6TKrTwvprUpBGl4/ewZF47WIVaIWkiE2Nf//u
         I4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzyVcOfrHAYLeYQbm69mTh3ULU7/yJ+TP7MbWf4f0xY=;
        b=vm2cuIn5calgLSIBLdBJuOTjfNS6iIdFb7+p0OFhza/r6c3p9PcdtLsAKHmMbp0yCs
         mT8n5O6HHhEVYlovVwPnFBaHPSMeeKIwyATgamgNhtefj4twF8+c16OxuoJR5enKzkg5
         ZZ1shS9ljxher1bLihithRc8PPWYZMdNcPYIN48a7KC8vw46YwifOKV8ni8+Z367RG0q
         dPyI3kTVxu+ex+2MtCNycUpcvEwHlc4eG+JFhWLTTmRK2qD+M1TAh0LAW6NVREO/XvQG
         UWFn01Vf3musX730t5Mins7elTOMkzLiktnz6Y8WMChONnuhTbt+zBxdFN9PRxQNUajt
         elOQ==
X-Gm-Message-State: ANoB5pncKI49h8j6N7qcGJo16zA/3XR8nH/ZRvSYy5rdgxsMRY0/EFu9
	g6SSi2G6ZPXKTJLyiKXgYhLZePXvKi4YaC9W
X-Google-Smtp-Source: AA0mqf4v0SKA6PKRVgvWar6z8zrTGJuVkUVuZMAk8i4GB5Wi6OvomGULXlAhE2n63BDXXYTmETtAwQ==
X-Received: by 2002:a05:6a21:6d9d:b0:a5:6ec:dbc3 with SMTP id wl29-20020a056a216d9d00b000a506ecdbc3mr21953930pzb.19.1670783643516;
        Sun, 11 Dec 2022 10:34:03 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b0017f73caf588sm4654819plg.218.2022.12.11.10.34.02
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 10:34:02 -0800 (PST)
Message-ID: <6396229b.170a0220.dded2.7e3b@mx.google.com>
Date: Sun, 11 Dec 2022 10:34:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.158-cip22-435-g2c52868ae1cbc
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline: 157 runs,
 7 regressions (v5.10.158-cip22-435-g2c52868ae1cbc)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 11 Dec 2022 18:34:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10199

cip-gitlab/ci/pavel/linux-test baseline: 157 runs, 7 regressions (v5.10.158=
-cip22-435-g2c52868ae1cbc)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
bcm2836-rpi-2-b   | arm   | lab-collabora | gcc-10   | multi_v7_defconfig  =
       | 1          =

da850-lcdk        | arm   | lab-baylibre  | gcc-10   | davinci_all_defconfi=
g      | 1          =

odroid-xu3        | arm   | lab-collabora | gcc-10   | multi_v7_defconfig  =
       | 1          =

qemu_i386         | i386  | lab-collabora | gcc-10   | i386_defconfig      =
       | 1          =

rk3288-veyron-jaq | arm   | lab-collabora | gcc-10   | multi_v7_defconfig  =
       | 1          =

zynqmp-zcu102     | arm64 | lab-cip       | gcc-10   | defconfig           =
       | 1          =

zynqmp-zcu102     | arm64 | lab-cip       | gcc-10   | defconfig+arm64-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.158-cip22-435-g2c52868ae1cbc/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.158-cip22-435-g2c52868ae1cbc
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2c52868ae1cbccd8bfb24f6b41a5fd024c1ca7e8 =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
bcm2836-rpi-2-b   | arm   | lab-collabora | gcc-10   | multi_v7_defconfig  =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/63961c0934f6693adf2abe4d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221125.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63961c0934f6693adf2ab=
e4e
        new failure (last pass: v4.19.265-cip85-rt27) =

 =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
da850-lcdk        | arm   | lab-baylibre  | gcc-10   | davinci_all_defconfi=
g      | 1          =


  Details:     https://kernelci.org/test/plan/id/639619eac98e3439332abd43

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: davinci_all_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm/davinci_all_defconfig/gcc-10/lab-ba=
ylibre/baseline-da850-lcdk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm/davinci_all_defconfig/gcc-10/lab-ba=
ylibre/baseline-da850-lcdk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221125.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/639619eac98e343=
9332abd4a
        failing since 215 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a)
        4 lines

    2022-12-11T17:56:49.413169  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3000
    2022-12-11T17:56:49.413528  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3400
    2022-12-11T17:56:49.413762  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3800
    2022-12-11T17:56:49.416184  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3c00
    2022-12-11T17:56:49.458924  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dale=
rt RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D4>   =

 =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
odroid-xu3        | arm   | lab-collabora | gcc-10   | multi_v7_defconfig  =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/639619b14240e5e2542abd2f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-odroid-xu3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-odroid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221125.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/639619b14240e5e2542ab=
d30
        new failure (last pass: v4.4.302-cip70-236-g69445bc0d4209) =

 =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
qemu_i386         | i386  | lab-collabora | gcc-10   | i386_defconfig      =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/639618b80ce323a8d12abd26

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/i386/i386_defconfig/gcc-10/lab-collabor=
a/baseline-qemu_i386.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/i386/i386_defconfig/gcc-10/lab-collabor=
a/baseline-qemu_i386.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221125.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/639618b80ce323a8d12ab=
d27
        new failure (last pass: v5.10.145-cip17-421-g0d804ef4a611) =

 =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
rk3288-veyron-jaq | arm   | lab-collabora | gcc-10   | multi_v7_defconfig  =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/63961f5031e9c7ab962abcfc

  Results:     66 PASS, 4 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221125.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/63961f5031e9c7ab962abd28
        new failure (last pass: v4.4.302-cip70-236-g69445bc0d4209)

    2022-12-11T18:19:37.475317  <8>[   18.545108] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-driver-present RESULT=3Dpass>
    2022-12-11T18:19:37.799013  <6>[   18.918237] sbs-battery 20-000b: Disa=
bling PEC because of broken Cros-EC implementation
    2022-12-11T18:19:38.148884  <6>[   19.268741] sbs-battery 20-000b: Disa=
bling PEC because of broken Cros-EC implementation
    2022-12-11T18:19:38.160032  <6>[   19.270048] sbs-battery 20-000b: Disa=
bling PEC because of broken Cros-EC implementation
    2022-12-11T18:19:38.166408  <4>[   19.299678] sbs-battery 20-000b: Unkn=
own chemistry: POLY
    2022-12-11T18:19:38.166905  =

    2022-12-11T18:19:38.414141  /lava-8333309/1/../bin/lava-test-case
    2022-12-11T18:19:38.426205  <8>[   19.553344] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dfail>   =

 =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
zynqmp-zcu102     | arm64 | lab-cip       | gcc-10   | defconfig           =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/63961b688b252930df2abcfa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm64/defconfig/gcc-10/lab-cip/baseline=
-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm64/defconfig/gcc-10/lab-cip/baseline=
-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221125.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63961b688b252930df2ab=
cfb
        new failure (last pass: v4.19.265-cip85-rt27) =

 =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
zynqmp-zcu102     | arm64 | lab-cip       | gcc-10   | defconfig+arm64-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63961d20cb39d8590e2abd06

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.158-cip22-435-g2c52868ae1cbc/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221125.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63961d20cb39d8590e2ab=
d07
        new failure (last pass: v4.19.265-cip85-rt27) =

 =20

