Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3758C7619A
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 13:39:48 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.130390.1680701982930631992
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 05 Apr 2023 06:39:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=JzSVtO0B;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so37307259pjt.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 05 Apr 2023 06:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680701982;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yzOamAzAihbDR+ux1JMO/HDSG/cJ+NdDC93NFWUW09U=;
        b=JzSVtO0BXnMWebtL8Fr+EMBxNzJhTWUWEVJfZO9fyMev35XnLiGkCG8JoHCrILJXaF
         oZEx/I/7BAIqXUr0wYYWRr+d+sf3RjyWpscksuAHFisfOwU5IoCKfZcxZOSTSWknI4nt
         O3MqTGta7x232Rt/Wjp7MEqZ/qXOve19jDB7ROFo0kfOS0zx7fXSACrpbHDy8jgUmXSa
         deRxMfzhqmVZe6gRBkhe4MYWgQBFsn8WswDVtox0dQu5Y/L5h1D3Rp1PGrGpUnZpw6RH
         HBsEWQxfpXxof668l4I9oQipYsEmy22A84dRF4Y2HhbgcUdyhMA8e4fDiTduuHTGbcHO
         TbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680701982;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yzOamAzAihbDR+ux1JMO/HDSG/cJ+NdDC93NFWUW09U=;
        b=QBtBNJe2ZVXx5O5IEECRdIbHbUOxUomYtLUs+WpfHvN5F9nxDTT7v38qet7riaNEQC
         8O08Pf+GnWrP/h4TcHUyru9DvteE27EaCSjS6wHLPv93VJHNScRfDluMwPUIKtJ2H0bF
         MOAUSMFGcx2M8kVuWpybi69H73a/WyIz0WqZy+2pm2G8xHqZY7Fa7k9ZeLmOV21DMNEO
         oc4B/BcDxGncY1AofWhh4Ttm8NvyhxENfUx/aSu/d+PVLEnP9r9QCAylcx3rD438fPPL
         bW68vcNo70cJFPRMvywoAYrxu6VUH+/BiLdzO1El0vKzuVDMgYF6wCSGY8PwJFgradHT
         v4AA==
X-Gm-Message-State: AAQBX9ezq9AHBKhbtkSqtNC5DX+UuoqtLpRc2xYL6VPq+fI3cvjEsBbS
	o/3wwju/ZHB6NRYF8PLP3y+CyJ9FvGofKpnt49qWGA==
X-Google-Smtp-Source: AKy350Y2tljleLCj4neXPU3Fjag6uRyMkQMgL7rUij8DVHntzpN5LD7RFsu3tf33+JNAhf3XuUfZmg==
X-Received: by 2002:a17:902:f685:b0:1a0:7156:f8d1 with SMTP id l5-20020a170902f68500b001a07156f8d1mr7379469plg.19.1680701981898;
        Wed, 05 Apr 2023 06:39:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d1-20020a170902b70100b001a051eb014bsm10118189pls.219.2023.04.05.06.39.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 06:39:41 -0700 (PDT)
Message-ID: <642d7a1d.170a0220.f474f.4d19@mx.google.com>
Date: Wed, 05 Apr 2023 06:39:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.279-cip95-86-g16c082d0be46
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 27 runs,
 7 regressions (v4.19.279-cip95-86-g16c082d0be46)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Apr 2023 13:39:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11182

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 27 runs, 7 regress=
ions (v4.19.279-cip95-86-g16c082d0be46)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.279-cip95-86-g16c082d0be46/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.279-cip95-86-g16c082d0be46
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      16c082d0be46e1e0049aa4aa2c022b53c67690ad =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642d712cb719bde01d79e946

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.279-cip95-86-g16c082d0be46/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.279-cip95-86-g16c082d0be46/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230331.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/642d712cb719bde01d79e94b
        failing since 76 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-05T13:01:25.986718  + set +x<8>[   18.166230] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 9879113_1.5.2.3.1>

    2023-04-05T13:01:25.986790  =


    2023-04-05T13:01:26.093368  /#

    2023-04-05T13:01:26.196343   # #export SHELL=3D/bin/sh

    2023-04-05T13:01:26.197116  =


    2023-04-05T13:01:26.298989  / # export SHELL=3D/bin/sh. /lava-9879113/e=
nvironment

    2023-04-05T13:01:26.299841  =


    2023-04-05T13:01:26.401638  / # . /lava-9879113/environment/lava-987911=
3/bin/lava-test-runner /lava-9879113/1

    2023-04-05T13:01:26.402905  =


    2023-04-05T13:01:26.405158  / # /lava-9879113/bin/lava-test-runner /lav=
a-9879113/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642d70b61b70d48f7679e93f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.279-cip95-86-g16c082d0be46/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.279-cip95-86-g16c082d0be46/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230331.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/642d70b61b70d48f7679e944
        failing since 76 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-05T12:59:11.609745  + <8>[   21.106186] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 9879139_1.5.2.3.1>

    2023-04-05T12:59:11.612459  set +x

    2023-04-05T12:59:11.717352  / # #

    2023-04-05T12:59:11.818452  export SHELL=3D/bin/sh

    2023-04-05T12:59:11.818673  #

    2023-04-05T12:59:11.919598  / # export SHELL=3D/bin/sh. /lava-9879139/e=
nvironment

    2023-04-05T12:59:11.919787  =


    2023-04-05T12:59:12.020665  / # . /lava-9879139/environment/lava-987913=
9/bin/lava-test-runner /lava-9879139/1

    2023-04-05T12:59:12.020940  =


    2023-04-05T12:59:12.025888  / # /lava-9879139/bin/lava-test-runner /lav=
a-9879139/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/642d7260a714d1fcc079e940

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.279-cip95-86-g16c082d0be46/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.279-cip95-86-g16c082d0be46/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230331.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/642d7260a714d1fcc079e969
        failing since 76 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-05T13:05:52.221649  <8>[   51.619450] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 283219_1.6.2.4.1>
    2023-04-05T13:05:52.340701  / # #
    2023-04-05T13:05:52.442973  export SHELL=3D/bin/sh
    2023-04-05T13:05:52.443505  #
    2023-04-05T13:05:52.545098  / # export SHELL=3D/bin/sh. /lava-283219/en=
vironment
    2023-04-05T13:05:52.545675  =

    2023-04-05T13:05:52.647385  / # . /lava-283219/environment/lava-283219/=
bin/lava-test-runner /lava-283219/1
    2023-04-05T13:05:52.648292  =

    2023-04-05T13:05:52.650875  / # /lava-283219/bin/lava-test-runner /lava=
-283219/1
    2023-04-05T13:05:52.818631  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/642d7735361ff71cbf79e922

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.279-cip95-86-g16c082d0be46/arm/multi_v7_defconfig/gcc-10=
/lab-cip/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.279-cip95-86-g16c082d0be46/arm/multi_v7_defconfig/gcc-10=
/lab-cip/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230331.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/642d7735361ff71cbf79e929
        failing since 76 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-05T13:26:31.921088  + set +x
    2023-04-05T13:26:31.923015  [   40.357243] <LAVA_SIGNAL_ENDRUN 0_dmesg =
898217_1.6.2.4.1>
    2023-04-05T13:26:32.037954  / # #
    2023-04-05T13:26:32.139802  export SHELL=3D/bin/sh
    2023-04-05T13:26:32.140297  #
    2023-04-05T13:26:32.241681  / # export SHELL=3D/bin/sh. /lava-898217/en=
vironment
    2023-04-05T13:26:32.242176  =

    2023-04-05T13:26:32.343676  / # . /lava-898217/environment/lava-898217/=
bin/lava-test-runner /lava-898217/1
    2023-04-05T13:26:32.344513  =

    2023-04-05T13:26:32.346139  / # /lava-898217/bin/lava-test-runner /lava=
-898217/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/642d71b16a0c70929d79e922

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.279-cip95-86-g16c082d0be46/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.279-cip95-86-g16c082d0be46/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230331.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/642d71b16a0c70929d79e927
        failing since 76 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-05T13:03:40.057361  / # #

    2023-04-05T13:03:40.160492  export SHELL=3D/bin/sh

    2023-04-05T13:03:40.161304  #

    2023-04-05T13:03:40.263680  / # export SHELL=3D/bin/sh. /lava-9879418/e=
nvironment

    2023-04-05T13:03:40.264497  =


    2023-04-05T13:03:40.366573  / # . /lava-9879418/environment/lava-987941=
8/bin/lava-test-runner /lava-9879418/1

    2023-04-05T13:03:40.367827  =


    2023-04-05T13:03:40.379803  / # /lava-9879418/bin/lava-test-runner /lav=
a-9879418/1

    2023-04-05T13:03:40.557340  + export TESTRUN_ID=3D1_bootrr

    2023-04-05T13:03:40.557852  + cd /lava-9879418/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/642d71c26a0c70929d79e936

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.279-cip95-86-g16c082d0be46/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.279-cip95-86-g16c082d0be46/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230331.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/642d71c26a0c70929d79e93c
        failing since 22 days (last pass: v4.19.273-cip92-277-g507c8d80b9e2=
0, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-04-05T13:03:42.517694  <8>[   37.948481] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-04-05T13:03:43.547129  /lava-9878948/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/642d71c26a0c70929d79e93d
        failing since 22 days (last pass: v4.19.273-cip92-277-g507c8d80b9e2=
0, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-04-05T13:03:41.470907  <8>[   36.900908] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-04-05T13:03:42.498521  /lava-9878948/1/../bin/lava-test-case
   =

 =20

