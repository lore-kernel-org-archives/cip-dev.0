Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E280CC77B73
	for <webhook@archiver.kernel.org>; Thu, 20 Apr 2023 14:23:28 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.9384.1682000606500296882
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Apr 2023 07:23:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=QxNUkqVi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-63b70f0b320so1455556b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Apr 2023 07:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682000605; x=1684592605;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X0wIsCf8alQ9/qJmUgHNJfub6fBkZ9wv9MXe+7ARNpA=;
        b=QxNUkqViYQIwddtZfLlqIYg/2EGrfM4CB0koILddVfeanirowGFR190M72i5FNBzyf
         hDcv7bKm1WDsojnVPFjCGz7ImBADrLgpeRyI4lRmfcHWgOzYEWX1cNGVzBX6gmFvzAjK
         sJGR0y3AvUUuR3lkUMrb8CNTeBl0BaHlhVJ/LPUOghJXKRSaBrY2griWLzss0ZJEkY1V
         wC9GJdmV3rnuL0d7UcEIE97mSdI9ws3YI920QkBwAGmCFykxACJRU2e36PWZEX6Glxdg
         /mV/YrHAZD6DhVD1RQDc3oo0HtcJQ6yV6CREolBooKYv5lv/yAWag8epgMBkU0K5piro
         qMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682000605; x=1684592605;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0wIsCf8alQ9/qJmUgHNJfub6fBkZ9wv9MXe+7ARNpA=;
        b=fXW0PPKrw4vwlryTVCyFLHa7q4hVublgrRtJH3rM5Jnj05noejW7oPm5r5EdW5ShWh
         8dAdk2/jFDlLGGjhIAYeQO9BL97uCKgdj6VAm/mgJVR5RQOngseRtjzoULFyDrygL+nb
         iJWQtJD4EBqZKZ8iQTvRymL1D3/KDNO9Tc42K0UMsdaGsWVlcrWm7YnJNYtCoHrRisPA
         wxzgHbuBcvPD8SKOVE7dlN+TJZkE4c4q2e97sYjyBCEI3uGAC/zOK0r1XSpZlG6FnphA
         wl3rrrgQhsDeUg2Epp7/gc4H9yv4izC/4BuIlKxTGVsE3JJCk3tYJrMdbYNxnLY5Pcfa
         OWdA==
X-Gm-Message-State: AAQBX9f6LhnP/+ZZOYPfEuvmHcjGzFYHdfU3bs+TpXNWiyHvcYp8yT4r
	uXUgMijcr5kkOFwOevzH+5PTlZ7+HWUTCW1WKXSJAAKy
X-Google-Smtp-Source: AKy350YTAuk4F33EsXmbpJoVLouX0H8ghdLz8AdAiiaztRng3Jv2vyEuavKaRNnMMW/pvb5Twg2wXg==
X-Received: by 2002:a05:6a00:23d1:b0:63e:fb6d:a1c0 with SMTP id g17-20020a056a0023d100b0063efb6da1c0mr1674143pfc.33.1682000605395;
        Thu, 20 Apr 2023 07:23:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p15-20020aa7860f000000b0063f0068cf6csm1297844pfn.198.2023.04.20.07.23.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 07:23:25 -0700 (PDT)
Message-ID: <64414add.a70a0220.373a6.20dc@mx.google.com>
Date: Thu, 20 Apr 2023 07:23:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.280-cip96-59-g4b02e7efb967d
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 33 runs,
 7 regressions (v4.19.280-cip96-59-g4b02e7efb967d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Apr 2023 14:23:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11240

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 33 runs, 7 regress=
ions (v4.19.280-cip96-59-g4b02e7efb967d)

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
Flinux-4.19.y-cip-rc/kernel/v4.19.280-cip96-59-g4b02e7efb967d/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.280-cip96-59-g4b02e7efb967d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4b02e7efb967d05ce70d86cf0c7bdfaba7678818 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644143a28c6120fdfe2e8605

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/644143a28c6120fdfe2e860a
        failing since 91 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-20T13:52:21.578786  + set<8>[   15.178579] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10062418_1.5.2.3.1>

    2023-04-20T13:52:21.578978   +x

    2023-04-20T13:52:21.784466  / # #

    2023-04-20T13:52:21.885327  export SHELL=3D/bin/sh

    2023-04-20T13:52:21.885577  #

    2023-04-20T13:52:21.986553  / # export SHELL=3D/bin/sh. /lava-10062418/=
environment

    2023-04-20T13:52:21.986805  =


    2023-04-20T13:52:22.087826  / # . /lava-10062418/environment/lava-10062=
418/bin/lava-test-runner /lava-10062418/1

    2023-04-20T13:52:22.088216  =


    2023-04-20T13:52:22.092998  / # /lava-10062418/bin/lava-test-runner /la=
va-10062418/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6441439a8c6120fdfe2e85e9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6441439a8c6120fdfe2e85ee
        failing since 91 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-20T13:52:11.028053  <8>[   20.277926] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10062366_1.5.2.3.1>

    2023-04-20T13:52:11.029314  + set +x

    2023-04-20T13:52:11.141722  / #

    2023-04-20T13:52:11.242664  # #export SHELL=3D/bin/sh

    2023-04-20T13:52:11.242882  =


    2023-04-20T13:52:11.343802  / # export SHELL=3D/bin/sh. /lava-10062366/=
environment

    2023-04-20T13:52:11.344015  =


    2023-04-20T13:52:11.444952  / # . /lava-10062366/environment/lava-10062=
366/bin/lava-test-runner /lava-10062366/1

    2023-04-20T13:52:11.445262  =


    2023-04-20T13:52:11.446840  / # /lava-10062366/bin/lava-test-runner /la=
va-10062366/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644143ba8c6120fdfe2e8677

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm/multi_v7_defconfig/gcc-1=
0/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm/multi_v7_defconfig/gcc-1=
0/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/644143ba8c6120fdfe2e86a2
        failing since 91 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-20T13:52:06.243026  [   47.379219] <LAVA_SIGNAL_ENDRUN 0_dmesg =
361623_1.6.2.4.1>
    2023-04-20T13:52:06.356690  / # #
    2023-04-20T13:52:06.459168  export SHELL=3D/bin/sh
    2023-04-20T13:52:06.459849  #
    2023-04-20T13:52:06.561992  / # export SHELL=3D/bin/sh. /lava-361623/en=
vironment
    2023-04-20T13:52:06.562715  =

    2023-04-20T13:52:06.664981  / # . /lava-361623/environment/lava-361623/=
bin/lava-test-runner /lava-361623/1
    2023-04-20T13:52:06.665915  =

    2023-04-20T13:52:06.669623  / # /lava-361623/bin/lava-test-runner /lava=
-361623/1
    2023-04-20T13:52:06.840280  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6441482b08ad6c3c6d2e85f6

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6441482b08ad6c3c6d2e85f9
        failing since 91 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-20T14:10:56.625531  [   43.064412] <LAVA_SIGNAL_ENDRUN 0_dmesg =
910587_1.6.2.4.1>
    2023-04-20T14:10:56.891931  / # #
    2023-04-20T14:10:56.993495  export SHELL=3D/bin/sh
    2023-04-20T14:10:56.994111  #
    2023-04-20T14:10:57.095303  / # export SHELL=3D/bin/sh. /lava-910587/en=
vironment
    2023-04-20T14:10:57.095838  =

    2023-04-20T14:10:57.197245  / # . /lava-910587/environment/lava-910587/=
bin/lava-test-runner /lava-910587/1
    2023-04-20T14:10:57.198460  =

    2023-04-20T14:10:57.204118  / # /lava-910587/bin/lava-test-runner /lava=
-910587/1
    2023-04-20T14:10:57.821864  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6441436816e07c9e992e861c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm/multi_v7_defconfig/gcc-1=
0/lab-collabora/baseline-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm/multi_v7_defconfig/gcc-1=
0/lab-collabora/baseline-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6441436816e07c9e992e8621
        failing since 91 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-20T13:51:14.550607  + set +x

    2023-04-20T13:51:14.553694  [   31.013644] <LAVA_SIGNAL_ENDRUN 0_dmesg =
10062259_1.6.2.4.1>

    2023-04-20T13:51:14.665666  #

    2023-04-20T13:51:14.769163  / # #export SHELL=3D/bin/sh

    2023-04-20T13:51:14.770014  =


    2023-04-20T13:51:14.872130  / # export SHELL=3D/bin/sh. /lava-10062259/=
environment

    2023-04-20T13:51:14.872984  =


    2023-04-20T13:51:14.975253  / # . /lava-10062259/environment/lava-10062=
259/bin/lava-test-runner /lava-10062259/1

    2023-04-20T13:51:14.976603  =


    2023-04-20T13:51:14.978513  / # /lava-10062259/bin/lava-test-runner /la=
va-10062259/1
 =

    ... (15 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64414590a6fa5582612e85fe

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-59-g4b02e7efb967d/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64414590a6fa5582612e8604
        failing since 37 days (last pass: v4.19.273-cip92-277-g507c8d80b9e2=
0, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-04-20T14:00:35.813789  /lava-10062449/1/../bin/lava-test-case

    2023-04-20T14:00:35.835102  [   39.768382] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64414590a6fa5582612e8605
        failing since 37 days (last pass: v4.19.273-cip92-277-g507c8d80b9e2=
0, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-04-20T14:00:34.765370  /lava-10062449/1/../bin/lava-test-case

    2023-04-20T14:00:34.786310  [   38.719141] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

