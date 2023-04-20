Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAEEC77B7C
	for <webhook@archiver.kernel.org>; Thu, 20 Apr 2023 14:53:38 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web11.10298.1682002415541088376
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Apr 2023 07:53:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=dhFHcifz;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-63b35789313so868544b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Apr 2023 07:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682002415; x=1684594415;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pGfZmoJa6Jjieg+bgZeWyHYdqCBBOZNfftLSBpBY2fY=;
        b=dhFHcifzt/lG3Bp0yHFex8VAOL8urFLwfJzkjXdb4ZuWQeRHOmUc7VJIk3Q2MXoUXK
         Fr5oudtT4tIqoWR68cI2AX3Mjmql0rNfXtj2/7Uv6xEeE3yG9IS2Rtn+zC/LTlzz8D/8
         CxecCUWtl5DthFtOZi6GzgapQbEcqycbVH4jguHhgvXpcNe+Lw2rz9aNWvfIqOL5f/PP
         Ndna4uL6HK3B515N/+VWIr6jeII21BR/v1OmMvtOeWNySRf/EnMCEpjSu7n/+S0JK2cM
         JsI1RtrrqlJ3pNCwrDmgeVibgp5A1BLVVY2lGRQ2l78zwBfksL73UCMTiLbYFsZifhRf
         Mq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682002415; x=1684594415;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pGfZmoJa6Jjieg+bgZeWyHYdqCBBOZNfftLSBpBY2fY=;
        b=JZu7udpHTSgbYHHimbeXcsS0XYiXdy4BsUxkYfxuX+Zn+aT8vVh90l9I0b/VHqVT/u
         TD63V4+L/qq0bfgLU7XJvBiRIRxqz4UVfoRKc1piu6Id1GvpzsIF+KpOzpmaGDHqT5Hb
         E8wDaDO7rzs8cI39PclfjgjdJmEMZ45n/HJ7V4spjZJGtfQpzoPsqoR01evyluLz7Yg4
         WtQLOdvZQIewF/0jGF0KxSUxy9fel/o6zkBSP4GZ8dwRWX9bwjhha2hM6AEBs8i5mm6Z
         Xgr8SdSv8daRS4p3fmjYTmjVAMp9CMnzdcmhZ2bHA3083Ryyb3athiytpcR0VGaWuCXh
         EKoQ==
X-Gm-Message-State: AAQBX9cA6p002k4LBioWaUJdcbZmthoQGy57COUYTXkSiRSsdywjee6C
	s63/+w+xFqLVmOj4OXFeRcs53q9WQVLEb4v4XdNWxlMq
X-Google-Smtp-Source: AKy350agjGNGmTV7sNP2MbjHQt9n1eMvPDL+qRSIPRliHo9mM63Hp9vOb6JdAlor2sJjTgHW8p7OKw==
X-Received: by 2002:a05:6a20:258d:b0:f0:916:e6d with SMTP id k13-20020a056a20258d00b000f009160e6dmr2574747pzd.39.1682002414569;
        Thu, 20 Apr 2023 07:53:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r16-20020a63ce50000000b0050a0227a4bcsm1250088pgi.57.2023.04.20.07.53.34
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 07:53:34 -0700 (PDT)
Message-ID: <644151ee.630a0220.7a190.238b@mx.google.com>
Date: Thu, 20 Apr 2023 07:53:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.177-cip31-122-gfb6ca504156b4
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 144 runs,
 10 regressions (v5.10.177-cip31-122-gfb6ca504156b4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Apr 2023 14:53:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11245

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 144 runs, 10 regressio=
ns (v5.10.177-cip31-122-gfb6ca504156b4)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.177-cip31-122-gfb6ca504156b4/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.177-cip31-122-gfb6ca504156b4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      fb6ca504156b4789acc2b019a0aaeae91c6d73dc =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64414816afcafc32d22e865c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64414816afcafc32d22e8691
        failing since 106 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-04-20T14:11:14.925228  <8>[   19.457186] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 361712_1.5.2.4.1>
    2023-04-20T14:11:15.035442  / # #
    2023-04-20T14:11:15.137805  export SHELL=3D/bin/sh
    2023-04-20T14:11:15.138536  #
    2023-04-20T14:11:15.240196  / # export SHELL=3D/bin/sh. /lava-361712/en=
vironment
    2023-04-20T14:11:15.240851  =

    2023-04-20T14:11:15.342792  / # . /lava-361712/environment/lava-361712/=
bin/lava-test-runner /lava-361712/1
    2023-04-20T14:11:15.343710  =

    2023-04-20T14:11:15.348189  / # /lava-361712/bin/lava-test-runner /lava=
-361712/1
    2023-04-20T14:11:15.453874  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64414ee332a63bccb02e8619

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64414ee332a63bccb02e861c
        failing since 106 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-04-20T14:40:21.175359  <8>[   13.181363] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 910636_1.5.2.4.1>
    2023-04-20T14:40:21.287917  / # #
    2023-04-20T14:40:21.390548  export SHELL=3D/bin/sh
    2023-04-20T14:40:21.391283  #
    2023-04-20T14:40:21.493102  / # export SHELL=3D/bin/sh. /lava-910636/en=
vironment
    2023-04-20T14:40:21.493836  =

    2023-04-20T14:40:21.595675  / # . /lava-910636/environment/lava-910636/=
bin/lava-test-runner /lava-910636/1
    2023-04-20T14:40:21.596854  =

    2023-04-20T14:40:21.603767  / # /lava-910636/bin/lava-test-runner /lava=
-910636/1
    2023-04-20T14:40:21.710539  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6441472054b66ecabf2e85fc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopu=
s.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopu=
s.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6441472154b66ecabf2e8601
        new failure (last pass: v5.10.168-cip27-638-g0d599cd2b6695)

    2023-04-20T14:07:22.322315  + set +x

    2023-04-20T14:07:22.328844  <8>[   14.941682] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10062499_1.4.2.3.1>

    2023-04-20T14:07:22.433623  / # #

    2023-04-20T14:07:22.534913  export SHELL=3D/bin/sh

    2023-04-20T14:07:22.535157  #

    2023-04-20T14:07:22.635926  / # export SHELL=3D/bin/sh. /lava-10062499/=
environment

    2023-04-20T14:07:22.636137  =


    2023-04-20T14:07:22.737018  / # . /lava-10062499/environment/lava-10062=
499/bin/lava-test-runner /lava-10062499/1

    2023-04-20T14:07:22.737320  =


    2023-04-20T14:07:22.742119  / # /lava-10062499/bin/lava-test-runner /la=
va-10062499/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6441484e8225efcde02e85f1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4=
020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4=
020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6441484e8225efcde02e85f6
        new failure (last pass: v5.10.168-cip27-638-g0d599cd2b6695)

    2023-04-20T14:12:20.155747  + set +x<8>[   12.846287] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10062628_1.4.2.3.1>

    2023-04-20T14:12:20.155876  =


    2023-04-20T14:12:20.261038  / # #

    2023-04-20T14:12:20.362334  export SHELL=3D/bin/sh

    2023-04-20T14:12:20.362549  #

    2023-04-20T14:12:20.463536  / # export SHELL=3D/bin/sh. /lava-10062628/=
environment

    2023-04-20T14:12:20.463823  =


    2023-04-20T14:12:20.564838  / # . /lava-10062628/environment/lava-10062=
628/bin/lava-test-runner /lava-10062628/1

    2023-04-20T14:12:20.565149  =


    2023-04-20T14:12:20.569606  / # /lava-10062628/bin/lava-test-runner /la=
va-10062628/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6441470f15675e780a2e85e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6441470f15675e780a2e85ed
        new failure (last pass: v5.10.168-cip27-638-g0d599cd2b6695)

    2023-04-20T14:06:57.433985  + set +x<8>[   12.856654] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10062555_1.4.2.3.1>

    2023-04-20T14:06:57.434076  =


    2023-04-20T14:06:57.536214  #

    2023-04-20T14:06:57.637539  / # #export SHELL=3D/bin/sh

    2023-04-20T14:06:57.637769  =


    2023-04-20T14:06:57.738699  / # export SHELL=3D/bin/sh. /lava-10062555/=
environment

    2023-04-20T14:06:57.738929  =


    2023-04-20T14:06:57.839921  / # . /lava-10062555/environment/lava-10062=
555/bin/lava-test-runner /lava-10062555/1

    2023-04-20T14:06:57.840308  =


    2023-04-20T14:06:57.844996  / # /lava-10062555/bin/lava-test-runner /la=
va-10062555/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64414813afcafc32d22e8638

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64414813afcafc32d22e863d
        new failure (last pass: v5.10.168-cip27-638-g0d599cd2b6695)

    2023-04-20T14:11:22.412554  + set +x

    2023-04-20T14:11:22.418920  <8>[   12.890106] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10062615_1.4.2.3.1>

    2023-04-20T14:11:22.523595  / # #

    2023-04-20T14:11:22.624598  export SHELL=3D/bin/sh

    2023-04-20T14:11:22.624804  #

    2023-04-20T14:11:22.725530  / # export SHELL=3D/bin/sh. /lava-10062615/=
environment

    2023-04-20T14:11:22.725744  =


    2023-04-20T14:11:22.826590  / # . /lava-10062615/environment/lava-10062=
615/bin/lava-test-runner /lava-10062615/1

    2023-04-20T14:11:22.826870  =


    2023-04-20T14:11:22.831942  / # /lava-10062615/bin/lava-test-runner /la=
va-10062615/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6441488cc67779fd382e8727

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6441488cc67779fd382e872d
        new failure (last pass: v5.10.168-cip27-638-g0d599cd2b6695)

    2023-04-20T14:13:07.939866  <8>[   34.112291] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-04-20T14:13:08.964685  /lava-10062659/1/../bin/lava-test-case

    2023-04-20T14:13:08.975649  <8>[   35.149340] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6441488cc67779fd382e872e
        new failure (last pass: v5.10.168-cip27-638-g0d599cd2b6695)

    2023-04-20T14:13:06.905567  <8>[   33.076644] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-04-20T14:13:07.928283  /lava-10062659/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/64414bf7d07229be5f2e86f1

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64414bf7d07229be5f2e86f7
        new failure (last pass: v5.10.168-cip27-638-g0d599cd2b6695)

    2023-04-20T14:27:48.999808  /lava-10062728/1/../bin/lava-test-case

    2023-04-20T14:27:49.025192  <8>[   70.458066] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64414bf7d07229be5f2e86f8
        new failure (last pass: v5.10.168-cip27-638-g0d599cd2b6695)

    2023-04-20T14:27:47.898248  /lava-10062728/1/../bin/lava-test-case

    2023-04-20T14:27:47.921794  <8>[   69.355412] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

