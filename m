Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D866C6FD1F
	for <webhook@archiver.kernel.org>; Tue, 14 Mar 2023 03:59:09 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web10.1374.1678766341235249914
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 13 Mar 2023 20:59:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Gonsfiq+;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id bd34so8926258pfb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 13 Mar 2023 20:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678766340;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xB/FmwlfS9lvE0kokiiVGksF0vIIAjAeOBrsN3AlF7c=;
        b=Gonsfiq+BJMj5nZ5QUI3IbIYbYPI7Q7FGaZZoFu4nt6uYRpE3LFHA4FBZcysCVIlmo
         J2xDBciq939Yg6LS1i1K4yHLFJkgb4+gKQH0S4sTz8TUqVCPfLPx9V8mtB275bqfIavC
         EIYOHPQBTVBrQNOyeBL33e6FOtElk1VdCYbAcZFNon3bNJHJ3yXlFnRfGUjyOx63ysp3
         JR6WPKo243MS6R7jEYR0C4JNwxQVCnWzWmVUPSSqq7iRBPrSt7QlZF8n+OBvKx5hEYOx
         wk2zq4HcEmQ5szyuye84L6KwXmyYlq976uzmAcw1yhEbMpQRrahmdz/bZkKvauZDk46p
         MhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678766340;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xB/FmwlfS9lvE0kokiiVGksF0vIIAjAeOBrsN3AlF7c=;
        b=24R2qxjglMiocwZojw9l6W1/5DBb3aUtbiwZWAi7pJN/2JA19vLaA3y+Q2vCOXE13U
         kNaszzKrk2wskYI1HFB2TVIkyw3OTGulhhh5uCnVQPFpaA7t7dn/NjXz6sZ3sJoXVMU2
         1renkPt1hKbo6vWa5J1seySNenSswkvKb5FH4KMKGBE6yuEZQrvZZWM0VUYhQrGU33um
         pgyLjm6nwZFWcL1gvQKHT2BE1CqU/kOuHa3ms7pV3RqKY9p7FvUZNxCW89LSAW/d2lKV
         Ca/ooe0hMjk4S0hIwu2kY/EgoRXVGvtZ2SwXuxybjWZCk/fOl/da/82jK2dncxGqWRTX
         5/2w==
X-Gm-Message-State: AO0yUKWbwC1t4fKKI/z3bmFcdcetHSNWjmdrad77vlOxKpafiv4o8WwG
	pz2RA94MdCgdkTUmjG8L4LAttzyP4T4sZg+hNaQofzvP
X-Google-Smtp-Source: AK7set9nNbUoTzO9Cdkb42QCQsMl5dVMSlOtUHWMlW36CPSRv/VmP1T998EC9zxKA7KMoRG8twMunQ==
X-Received: by 2002:a62:7bc4:0:b0:622:86eb:f191 with SMTP id w187-20020a627bc4000000b0062286ebf191mr6148928pfc.10.1678766339465;
        Mon, 13 Mar 2023 20:58:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z13-20020aa785cd000000b005a852875590sm455302pfn.113.2023.03.13.20.58.58
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 20:58:59 -0700 (PDT)
Message-ID: <640ff103.a70a0220.d1eab.1aad@mx.google.com>
Date: Mon, 13 Mar 2023 20:58:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.276-cip93-5-g2eb2a953ab59
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 90 runs,
 35 regressions (v4.19.276-cip93-5-g2eb2a953ab59)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Mar 2023 03:59:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11021

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 90 runs, 35 regression=
s (v4.19.276-cip93-5-g2eb2a953ab59)

Regressions Summary
-------------------

platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral   | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beaglebone-black           | arm    | lab-broonie     | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black           | arm    | lab-cip         | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black           | arm    | lab-broonie     | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black           | arm    | lab-cip         | gcc-10   | omap2plu=
s_defconfig          | 1          =

imx6q-sabrelite            | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6q-udoo                 | arm    | lab-broonie     | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =

imx7d-sdb                  | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

r8a7796-m3ulcb             | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 3          =

rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus     | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64         | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

tegra124-nyan-big          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =

tegra124-nyan-big          | arm    | lab-collabora   | gcc-10   | tegra_de=
fconfig              | 1          =

zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.276-cip93-5-g2eb2a953ab59/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.276-cip93-5-g2eb2a953ab59
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2eb2a953ab592a2d48310bb70c4377b7a42b89d1 =



Test Regressions
---------------- =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus  | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640fe708c692c60ce38c86dc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640fe708c692c60ce38c86e5
        failing since 53 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-14T03:16:05.565004  + set<8>[   10.120994] <LAVA_SIGNAL_ENDRUN =
0_dmesg 9597727_1.4.2.3.1>

    2023-03-14T03:16:05.565095   +x

    2023-03-14T03:16:05.667297  #

    2023-03-14T03:16:05.768465  / # #export SHELL=3D/bin/sh

    2023-03-14T03:16:05.768676  =


    2023-03-14T03:16:05.869568  / # export SHELL=3D/bin/sh. /lava-9597727/e=
nvironment

    2023-03-14T03:16:05.869794  =


    2023-03-14T03:16:05.970682  / # . /lava-9597727/environment/lava-959772=
7/bin/lava-test-runner /lava-9597727/1

    2023-03-14T03:16:05.970989  =


    2023-03-14T03:16:05.976139  / # /lava-9597727/bin/lava-test-runner /lav=
a-9597727/1
 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral   | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640fe71701e44c48828c8666

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640fe71701e44c48828c866f
        failing since 53 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-14T03:16:31.875699  + <8>[   11.924866] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 9597735_1.4.2.3.1>

    2023-03-14T03:16:31.875805  set +x

    2023-03-14T03:16:31.977321  #

    2023-03-14T03:16:31.977618  =


    2023-03-14T03:16:32.078598  / # #export SHELL=3D/bin/sh

    2023-03-14T03:16:32.078832  =


    2023-03-14T03:16:32.179751  / # export SHELL=3D/bin/sh. /lava-9597735/e=
nvironment

    2023-03-14T03:16:32.179970  =


    2023-03-14T03:16:32.280870  / # . /lava-9597735/environment/lava-959773=
5/bin/lava-test-runner /lava-9597735/1

    2023-03-14T03:16:32.281183  =

 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-broonie     | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640fe8f59c2bededb28c8632

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm/multi_v7_defconfig/gcc-10/=
lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm/multi_v7_defconfig/gcc-10/=
lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640fe8f59c2bededb28c8661
        failing since 53 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-14T03:23:51.462506  <8>[   17.046377] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 156357_1.5.2.4.1>
    2023-03-14T03:23:51.571461  / # #
    2023-03-14T03:23:51.674154  export SHELL=3D/bin/sh
    2023-03-14T03:23:51.674788  #
    2023-03-14T03:23:51.776517  / # export SHELL=3D/bin/sh. /lava-156357/en=
vironment
    2023-03-14T03:23:51.777211  =

    2023-03-14T03:23:51.879076  / # . /lava-156357/environment/lava-156357/=
bin/lava-test-runner /lava-156357/1
    2023-03-14T03:23:51.879973  =

    2023-03-14T03:23:51.884224  / # /lava-156357/bin/lava-test-runner /lava=
-156357/1
    2023-03-14T03:23:51.951719  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-cip         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640fef7f8ed4a193918c864d

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm/multi_v7_defconfig/gcc-10/=
lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm/multi_v7_defconfig/gcc-10/=
lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640fef7f8ed4a193918c8654
        failing since 53 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-14T03:51:52.875117  + set +x
    2023-03-14T03:51:52.877152  <8>[    9.841279] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 874801_1.5.2.4.1>
    2023-03-14T03:51:52.985922  / # #
    2023-03-14T03:51:53.087751  export SHELL=3D/bin/sh
    2023-03-14T03:51:53.088213  #
    2023-03-14T03:51:53.189629  / # export SHELL=3D/bin/sh. /lava-874801/en=
vironment
    2023-03-14T03:51:53.190164  =

    2023-03-14T03:51:53.291578  / # . /lava-874801/environment/lava-874801/=
bin/lava-test-runner /lava-874801/1
    2023-03-14T03:51:53.292318  =

    2023-03-14T03:51:53.293826  / # /lava-874801/bin/lava-test-runner /lava=
-874801/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-broonie     | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/640fe7c9f3150e93ae8c8687

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm/omap2plus_defconfig/gcc-10=
/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm/omap2plus_defconfig/gcc-10=
/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640fe7c9f3150e93ae8c86bd
        failing since 1 day (last pass: v4.19.273-cip92-24-g2070ce514972, f=
irst fail: v4.19.273-cip92-277-g507c8d80b9e20)

    2023-03-14T03:19:17.122574  + set +x<8>[   22.460713] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 156302_1.5.2.4.1>
    2023-03-14T03:19:17.122961  =

    2023-03-14T03:19:17.233141  / # #
    2023-03-14T03:19:17.335997  export SHELL=3D/bin/sh
    2023-03-14T03:19:17.336720  #
    2023-03-14T03:19:17.438874  / # export SHELL=3D/bin/sh. /lava-156302/en=
vironment
    2023-03-14T03:19:17.439366  =

    2023-03-14T03:19:17.541131  / # . /lava-156302/environment/lava-156302/=
bin/lava-test-runner /lava-156302/1
    2023-03-14T03:19:17.542070  =

    2023-03-14T03:19:17.546725  / # /lava-156302/bin/lava-test-runner /lava=
-156302/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-cip         | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/640fe88a532d9722cd8c8633

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm/omap2plus_defconfig/gcc-10=
/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm/omap2plus_defconfig/gcc-10=
/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640fe88a532d9722cd8c8=
634
        new failure (last pass: v4.19.273-cip92-277-g507c8d80b9e20) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6q-sabrelite            | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640fe86ec9a97619728c8665

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm/multi_v7_defconfig/gcc-10/=
lab-collabora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm/multi_v7_defconfig/gcc-10/=
lab-collabora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640fe86ec9a97619728c866e
        failing since 53 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-14T03:22:07.233088  / # #

    2023-03-14T03:22:07.336250  export SHELL=3D/bin/sh

    2023-03-14T03:22:07.337084  #

    2023-03-14T03:22:07.439137  / # export SHELL=3D/bin/sh. /lava-9597922/e=
nvironment

    2023-03-14T03:22:07.439971  =


    2023-03-14T03:22:07.541947  / # . /lava-9597922/environment/lava-959792=
2/bin/lava-test-runner /lava-9597922/1

    2023-03-14T03:22:07.543207  =


    2023-03-14T03:22:07.555304  / # /lava-9597922/bin/lava-test-runner /lav=
a-9597922/1

    2023-03-14T03:22:07.659375  + export 'TESTRUN_ID=3D1_bootrr'

    2023-03-14T03:22:07.659933  + cd /lava-9597922/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6q-udoo                 | arm    | lab-broonie     | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/640fece171e03dbb8f8c8633

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm/imx_v6_v7_defconfig/gcc-10=
/lab-broonie/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm/imx_v6_v7_defconfig/gcc-10=
/lab-broonie/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640fece171e03dbb8f8c8=
634
        new failure (last pass: v4.19.273-cip92-277-g507c8d80b9e20) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/640fea6cc8aafc63508c86a2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm/imx_v6_v7_defconfig/gcc-10=
/lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm/imx_v6_v7_defconfig/gcc-10=
/lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640fea6cc8aafc63508c86ab
        failing since 53 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-14T03:30:42.476913  + set +x[    7.025991] <LAVA_SIGNAL_ENDRUN =
0_dmesg 919890_1.5.2.3.1>
    2023-03-14T03:30:42.477083  =

    2023-03-14T03:30:42.584299  / # #
    2023-03-14T03:30:42.685927  export SHELL=3D/bin/sh
    2023-03-14T03:30:42.686404  #
    2023-03-14T03:30:42.787678  / # export SHELL=3D/bin/sh. /lava-919890/en=
vironment
    2023-03-14T03:30:42.788151  =

    2023-03-14T03:30:42.889450  / # . /lava-919890/environment/lava-919890/=
bin/lava-test-runner /lava-919890/1
    2023-03-14T03:30:42.890105  =

    2023-03-14T03:30:42.892990  / # /lava-919890/bin/lava-test-runner /lava=
-919890/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640fe9f4b890f3ac2e8c86d4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm/multi_v7_defconfig/gcc-10/=
lab-pengutronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm/multi_v7_defconfig/gcc-10/=
lab-pengutronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640fe9f4b890f3ac2e8c86dd
        failing since 53 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-14T03:28:41.639598  + set +x
    2023-03-14T03:28:41.639765  [    4.956649] <LAVA_SIGNAL_ENDRUN 0_dmesg =
919886_1.5.2.3.1>
    2023-03-14T03:28:41.745749  / # #
    2023-03-14T03:28:41.847417  export SHELL=3D/bin/sh
    2023-03-14T03:28:41.847901  #
    2023-03-14T03:28:41.949247  / # export SHELL=3D/bin/sh. /lava-919886/en=
vironment
    2023-03-14T03:28:41.949697  =

    2023-03-14T03:28:42.050953  / # . /lava-919886/environment/lava-919886/=
bin/lava-test-runner /lava-919886/1
    2023-03-14T03:28:42.051554  =

    2023-03-14T03:28:42.054087  / # /lava-919886/bin/lava-test-runner /lava=
-919886/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx7d-sdb                  | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640fe947a18d0d65df8c863f

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm/multi_v7_defconfig/gcc-10/=
lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm/multi_v7_defconfig/gcc-10/=
lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640fe947a18d0d65df8c8646
        failing since 48 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.270-cip89-39-g43ce130174aa)

    2023-03-14T03:25:39.541543  / # #
    2023-03-14T03:25:40.699718  export SHELL=3D/bin/sh
    2023-03-14T03:25:40.705090  #
    2023-03-14T03:25:42.250175  / # export SHELL=3D/bin/sh. /lava-1171758/e=
nvironment
    2023-03-14T03:25:42.255563  =

    2023-03-14T03:25:42.255721  / # . /lava-1171758/environment
    2023-03-14T03:25:45.073838  / #/lava-1171758/bin/lava-test-runner /lava=
-1171758/1
    2023-03-14T03:25:45.083344   /lava-1171758/bin/lava-test-runner /lava-1=
171758/1
    2023-03-14T03:25:45.131432  + export 'TESTRUN_ID=3D1_bootrr'
    2023-03-14T03:25:45.185393  + cd /lava-1171758/1/tests/1_bootrr =

    ... (15 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/640fecd7eb0ca4651b8c8733

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640fecd7eb0ca4651b8c8=
734
        failing since 299 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640fee3ebb385606a88c8634

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig/gcc-10/lab-bro=
onie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig/gcc-10/lab-bro=
onie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640fee3ebb385606a88c8=
635
        failing since 299 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640feb3ec54ed76f1a8c869f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig/gcc-10/lab-col=
labora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig/gcc-10/lab-col=
labora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640feb3ec54ed76f1a8c8=
6a0
        failing since 299 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/640fecea754a065a4b8c86ad

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640fecea754a065a4b8c8=
6ae
        failing since 299 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640fed260cdea3dd4b8c865b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig/gcc-10/lab-bro=
onie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig/gcc-10/lab-bro=
onie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640fed260cdea3dd4b8c8=
65c
        failing since 299 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/640fecd6eb0ca4651b8c8730

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640fecd6eb0ca4651b8c8=
731
        failing since 299 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640fed130cdea3dd4b8c863b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig/gcc-10/lab-bro=
onie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig/gcc-10/lab-bro=
onie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640fed130cdea3dd4b8c8=
63c
        failing since 299 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/640feb00f3d0bab07d8c865a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640feb00f3d0bab07d8c8=
65b
        failing since 299 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640feb3dc54ed76f1a8c869c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig/gcc-10/lab-col=
labora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig/gcc-10/lab-col=
labora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640feb3dc54ed76f1a8c8=
69d
        failing since 299 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/640fecff0cdea3dd4b8c8633

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640fecff0cdea3dd4b8c8=
634
        failing since 299 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640fee3fbbd7995ec18c8657

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig/gcc-10/lab-bro=
onie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig/gcc-10/lab-bro=
onie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640fee3fbbd7995ec18c8=
658
        failing since 299 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640feb3fc54ed76f1a8c86a2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig/gcc-10/lab-col=
labora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig/gcc-10/lab-col=
labora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640feb3fc54ed76f1a8c8=
6a3
        failing since 299 days (last pass: v4.19.239-cip72-68-g407458469172=
, first fail: v4.19.242-cip73-50-gd57bc44cb340) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
r8a7796-m3ulcb             | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640fea4973129c763e8c862f

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig/gcc-10/lab-col=
labora/baseline-r8a7796-m3ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig/gcc-10/lab-col=
labora/baseline-r8a7796-m3ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640fea4973129c763e8c8638
        failing since 53 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-14T03:29:55.754742  / # #

    2023-03-14T03:29:55.858020  export SHELL=3D/bin/sh

    2023-03-14T03:29:55.859161  #

    2023-03-14T03:29:55.962454  / # export SHELL=3D/bin/sh. /lava-9598142/e=
nvironment

    2023-03-14T03:29:55.963545  =


    2023-03-14T03:29:56.065783  / # . /lava-9598142/environment/lava-959814=
2/bin/lava-test-runner /lava-9598142/1

    2023-03-14T03:29:56.067394  =


    2023-03-14T03:29:56.074829  / # /lava-9598142/bin/lava-test-runner /lav=
a-9598142/1

    2023-03-14T03:29:56.090804  + export 'TESTRUN_ID=3D1_bootrr'

    2023-03-14T03:29:56.133669  + cd /lav<8>[   18.920213] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 9598142_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/640fe86b8b0900b7fa8c863c

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm/multi_v7_defconfig/gcc-10/=
lab-collabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm/multi_v7_defconfig/gcc-10/=
lab-collabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/640fe86b8b0900b7fa8c8670
        failing since 52 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-14T03:21:49.422038   multi-call binary.

    2023-03-14T03:21:49.422516  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/640fe86b8b0900b7fa8c8671
        failing since 52 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-14T03:21:49.400925  =


    2023-03-14T03:21:49.418410  BusyBox v1.31.1 (2023-03-10 17:51:43 UTC)<8=
>[   12.445493] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640fe86b8b0900b7fa8c8684
        failing since 52 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-14T03:21:45.565573  <8>[    8.593198] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-03-14T03:21:45.573880  + <8>[    8.605444] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 9597917_1.5.2.3.1>

    2023-03-14T03:21:45.575924  set +x

    2023-03-14T03:21:45.683208  =


    2023-03-14T03:21:45.785597  / # #export SHELL=3D/bin/sh

    2023-03-14T03:21:45.786468  =


    2023-03-14T03:21:45.888534  / # export SHELL=3D/bin/sh. /lava-9597917/e=
nvironment

    2023-03-14T03:21:45.889432  =


    2023-03-14T03:21:45.991447  / # . /lava-9597917/environment/lava-959791=
7/bin/lava-test-runner /lava-9597917/1

    2023-03-14T03:21:45.992735  =

 =

    ... (17 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/640febdaf13195a9128c8678

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/640febdaf13195a9128c8682
        new failure (last pass: v4.19.273-cip92-277-g507c8d80b9e20)

    2023-03-14T03:36:46.257475  <8>[   36.578888] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-03-14T03:36:47.278315  /lava-9598120/1/../bin/lava-test-case<8>[  =
 37.600654] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drockchip-usb2phy1-probed R=
ESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/640febdaf13195a9128c8683
        new failure (last pass: v4.19.273-cip92-277-g507c8d80b9e20)

    2023-03-14T03:36:46.248336  /lava-9598120/1/../bin/lava-test-case
   =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus     | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640feadb91846126738c8672

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig/gcc-10/lab-bro=
onie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig/gcc-10/lab-bro=
onie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640feadb91846126738c869b
        failing since 53 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-14T03:32:02.118953  <8>[   15.994168] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 156457_1.5.2.4.1>
    2023-03-14T03:32:02.225872  / # #
    2023-03-14T03:32:02.328686  export SHELL=3D/bin/sh
    2023-03-14T03:32:02.329416  #
    2023-03-14T03:32:02.431758  / # export SHELL=3D/bin/sh. /lava-156457/en=
vironment
    2023-03-14T03:32:02.432640  =

    2023-03-14T03:32:02.535040  / # . /lava-156457/environment/lava-156457/=
bin/lava-test-runner /lava-156457/1
    2023-03-14T03:32:02.536113  =

    2023-03-14T03:32:02.540966  / # /lava-156457/bin/lava-test-runner /lava=
-156457/1
    2023-03-14T03:32:02.572548  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64         | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640fea9713df44ac3e8c864f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig/gcc-10/lab-col=
labora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig/gcc-10/lab-col=
labora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640fea9713df44ac3e8c8658
        failing since 53 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-14T03:31:16.661067  / # #

    2023-03-14T03:31:16.764094  export SHELL=3D/bin/sh

    2023-03-14T03:31:16.764974  #

    2023-03-14T03:31:16.867019  / # export SHELL=3D/bin/sh. /lava-9598135/e=
nvironment

    2023-03-14T03:31:16.867860  =


    2023-03-14T03:31:16.970006  / # . /lava-9598135/environment/lava-959813=
5/bin/lava-test-runner /lava-9598135/1

    2023-03-14T03:31:16.971404  =


    2023-03-14T03:31:16.982532  / # /lava-9598135/bin/lava-test-runner /lav=
a-9598135/1

    2023-03-14T03:31:17.046418  + export 'TESTRUN_ID=3D1_bootrr'

    2023-03-14T03:31:17.047024  + cd /lava-9598135<8>[   15.659175] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 9598135_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
tegra124-nyan-big          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640fe9a86c3259a2aa8c862f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm/multi_v7_defconfig/gcc-10/=
lab-collabora/baseline-tegra124-nyan-big.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm/multi_v7_defconfig/gcc-10/=
lab-collabora/baseline-tegra124-nyan-big.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640fe9a86c3259a2aa8c8638
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-14T03:27:19.855213  + set +x

    2023-03-14T03:27:19.862333  <8>[   17.944172] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9597915_1.5.2.3.1>

    2023-03-14T03:27:19.971143  =


    2023-03-14T03:27:20.072574  / # #export SHELL=3D/bin/sh

    2023-03-14T03:27:20.072923  =


    2023-03-14T03:27:20.174173  / # export SHELL=3D/bin/sh. /lava-9597915/e=
nvironment

    2023-03-14T03:27:20.174529  =


    2023-03-14T03:27:20.275825  / # . /lava-9597915/environment/lava-959791=
5/bin/lava-test-runner /lava-9597915/1

    2023-03-14T03:27:20.276404  =


    2023-03-14T03:27:20.278970  / # /lava-9597915/bin/lava-test-runner /lav=
a-9597915/1
 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
tegra124-nyan-big          | arm    | lab-collabora   | gcc-10   | tegra_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/640fe8d1bc6caa948d8c868a

  Results:     3 PASS, 3 FAIL, 1 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm/tegra_defconfig/gcc-10/lab=
-collabora/baseline-tegra124-nyan-big.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm/tegra_defconfig/gcc-10/lab=
-collabora/baseline-tegra124-nyan-big.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640fe8d1bc6caa948d8c8693
        failing since 51 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-14T03:23:34.053363  kern  :emerg : Process udevadm (pid<8>[   1=
8.476121] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dfail UNITS=3D=
lines MEASUREMENT=3D11>

    2023-03-14T03:23:34.055389  : 140, stack limit =3D 0x(ptrval))

    2023-03-14T03:23:34.064502  kern  :emerg : Stack: <8>[   18.489709] <LA=
VA_SIGNAL_ENDRUN 0_dmesg 9597884_1.5.2.3.1>

    2023-03-14T03:23:34.066953  (0xc2c5ff2c to 0xc2c60000)

    2023-03-14T03:23:34.075085  kern  :emerg : ff20:                       =
     c02e8180 00000000 00000000 c026d82c 00000003

    2023-03-14T03:23:34.083122  kern  :emerg : ff40: ee356b40 bebf2f74 c2c5=
ff80 00000000 c2c5e000 00000004 00000003 c02706e0

    2023-03-14T03:23:34.091224  kern  :emerg : ff60: edfe2dd0 c026d82c ee35=
6b40 ee356b40 bebf2f74 00000003 c0101264 c0270944

    2023-03-14T03:23:34.099323  kern  :emerg : ff80: 00000000 00000000 c2c5=
ffb0 5f9f552a b6f857c0 00000003 b6f857c0 bebf2468

    2023-03-14T03:23:34.107519  kern  :emerg : ffa0: 00000004 c0101000 0000=
0003 b6f857c0 00000003 bebf2f74 00000003 00000000

    2023-03-14T03:23:34.115861  kern  :emerg : ffc0: 00000003 b6f857c0 bebf=
2468 00000004 00000003 0003c90c bebf2e58 00000003
 =

    ... (23 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/640fea06eeae00b4a28c862f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640fea06eeae00b4a28c8636
        failing since 53 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-14T03:29:00.754085  + set +x
    2023-03-14T03:29:00.755228  <8>[    3.739330] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 874810_1.5.2.4.1>
    2023-03-14T03:29:00.862325  / # #
    2023-03-14T03:29:00.964186  export SHELL=3D/bin/sh
    2023-03-14T03:29:00.964631  #
    2023-03-14T03:29:01.066014  / # export SHELL=3D/bin/sh. /lava-874810/en=
vironment
    2023-03-14T03:29:01.066458  =

    2023-03-14T03:29:01.167859  / # . /lava-874810/environment/lava-874810/=
bin/lava-test-runner /lava-874810/1
    2023-03-14T03:29:01.168613  =

    2023-03-14T03:29:01.171035  / # /lava-874810/bin/lava-test-runner /lava=
-874810/1 =

    ... (13 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
zynqmp-zcu102              | arm64  | lab-cip         | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/640fea56c8aafc63508c863f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig/gcc-10/lab-cip=
/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig/gcc-10/lab-cip=
/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640fea56c8aafc63508c8646
        failing since 53 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-14T03:30:09.603707  + set +x
    2023-03-14T03:30:09.604868  <8>[    3.782208] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 874832_1.5.2.4.1>
    2023-03-14T03:30:09.710392  / # #
    2023-03-14T03:30:09.812331  export SHELL=3D/bin/sh
    2023-03-14T03:30:09.812797  #
    2023-03-14T03:30:09.914219  / # export SHELL=3D/bin/sh. /lava-874832/en=
vironment
    2023-03-14T03:30:09.914682  =

    2023-03-14T03:30:10.016166  / # . /lava-874832/environment/lava-874832/=
bin/lava-test-runner /lava-874832/1
    2023-03-14T03:30:10.016929  =

    2023-03-14T03:30:10.019672  / # /lava-874832/bin/lava-test-runner /lava=
-874832/1 =

    ... (13 line(s) more)  =

 =20

