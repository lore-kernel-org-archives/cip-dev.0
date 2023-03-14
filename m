Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C38C74A44
	for <webhook@archiver.kernel.org>; Tue, 14 Mar 2023 03:59:09 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.1373.1678766340338061283
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 13 Mar 2023 20:59:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=YGLFcChT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id a9so15229686plh.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 13 Mar 2023 20:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678766339;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SYh/To2PCzfQrJg1cS7Tbx4ZIFIwgHrl8180QU+eSlw=;
        b=YGLFcChTEZb/+5/HKsUpYitbuWjnhLMBEwnlRk8VmXkTkyy7dfFSPSx/xySt+fMn4b
         uZeRarQEw7IUB2Cv/QN+iGYr0UDMmq4IZzhVrd2iP+FeUBd0A0M6rhnATpoyrpqwRk7U
         nXBQnews4vo5m7YvyesbO306viG4Neb1IPFKBKrgIyDeyd6sNbTdpDoHFy5H6WR5qWh7
         eua4LdLCZTzzF2Xxm9Og0YqANZvwTBUhNx64IhegH6pRp0YXlAxhYf+PjPLVx0iWznzM
         78eLJAE+VVhLVnoutz8CCv72fVsMOmYkdgxQG4e3LynHQ1X7TQXnuLpviXaG9DDFCmti
         auPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678766339;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYh/To2PCzfQrJg1cS7Tbx4ZIFIwgHrl8180QU+eSlw=;
        b=RMaGyXdzkW8wRnGvEfiugSLhz1NN/4Lb3gp0+e7rz/+16dK38vP1F1ff5wSIa6cCMC
         zF3Mrn+ZswT9Aq/68Jlw6pXnZzaw7tNwYD6gBddYYedfOyBGSsj6sxIHbupJcl3AzitT
         6V4nAwI95cZR+K5S52ZBS9BjbVMSnWcBvNhzhKq8+3rZBrnWzKsiTaj6DppG08qVcb5v
         R9lB9FwCE5+4P82OyKQsqSm2WaXKOCCQwECvsexMxl8OjjjxPinA+1rkqqFvQ6mE92FI
         U4g1CAY9mO1skjpYbolWI1JjCIxgxayk7QUNbbYI07DbLG46rTSUNEiF9/wVEnLClagn
         6n4A==
X-Gm-Message-State: AO0yUKXoKBnnb7wtwGSpCyH1q69o2YST9JWWUbjWlPZ6bo3JkpuTI2ag
	6yS0UI9Vm2QYSvCWBBTsVkYxyryuJucBJXnCrxeD4wui
X-Google-Smtp-Source: AK7set99RI1QF02dwztd4Yp5iwCSz0T3RazEknyGBm+nZfOs5KAxX+NhtrFBKW4gM2Ny+yfu3rHzXA==
X-Received: by 2002:a05:6a20:3d8e:b0:bc:e785:5ad3 with SMTP id s14-20020a056a203d8e00b000bce7855ad3mr13044988pzi.29.1678766339307;
        Mon, 13 Mar 2023 20:58:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a11-20020aa780cb000000b005ac419804d3sm435358pfn.186.2023.03.13.20.58.58
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 20:58:59 -0700 (PDT)
Message-ID: <640ff103.a70a0220.76d32.1ad0@mx.google.com>
Date: Mon, 13 Mar 2023 20:58:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.276-cip93-5-g2eb2a953ab59
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 27 runs,
 5 regressions (v4.19.276-cip93-5-g2eb2a953ab59)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Mar 2023 03:59:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11020

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 27 runs, 5 regress=
ions (v4.19.276-cip93-5-g2eb2a953ab59)

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

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.276-cip93-5-g2eb2a953ab59/plan/baseline-n=
fs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.276-cip93-5-g2eb2a953ab59
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2eb2a953ab592a2d48310bb70c4377b7a42b89d1 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640fe7071a4ac919e88c8648

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230310.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/640fe7071a4ac919e88c8651
        failing since 53 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-14T03:16:16.753126  + set<8>[   18.297159] <LAVA_SIGNAL_ENDRUN =
0_dmesg 9597685_1.5.2.3.1>

    2023-03-14T03:16:16.753643   +x

    2023-03-14T03:16:16.866524  / # #

    2023-03-14T03:16:16.969655  export SHELL=3D/bin/sh

    2023-03-14T03:16:16.970617  #

    2023-03-14T03:16:17.072795  / # export SHELL=3D/bin/sh. /lava-9597685/e=
nvironment

    2023-03-14T03:16:17.073672  =


    2023-03-14T03:16:17.175724  / # . /lava-9597685/environment/lava-959768=
5/bin/lava-test-runner /lava-9597685/1

    2023-03-14T03:16:17.177104  =


    2023-03-14T03:16:17.182390  / # /lava-9597685/bin/lava-test-runner /lav=
a-9597685/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640fe7a129443a75e08c864d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230310.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/640fe7a129443a75e08c8656
        failing since 53 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-14T03:18:35.359950  + <8>[   20.524855] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 9597682_1.5.2.3.1>

    2023-03-14T03:18:35.363160  set +x

    2023-03-14T03:18:35.468080  / # #

    2023-03-14T03:18:35.569104  export SHELL=3D/bin/sh

    2023-03-14T03:18:35.569303  #

    2023-03-14T03:18:35.670243  / # export SHELL=3D/bin/sh. /lava-9597682/e=
nvironment

    2023-03-14T03:18:35.670443  =


    2023-03-14T03:18:35.771396  / # . /lava-9597682/environment/lava-959768=
2/bin/lava-test-runner /lava-9597682/1

    2023-03-14T03:18:35.771692  =


    2023-03-14T03:18:35.776507  / # /lava-9597682/bin/lava-test-runner /lav=
a-9597682/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640fe8828b0900b7fa8c87dc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm/multi_v7_defconfig/gcc-10/=
lab-collabora/baseline-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm/multi_v7_defconfig/gcc-10/=
lab-collabora/baseline-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230310.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/640fe8828b0900b7fa8c87e5
        failing since 53 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-03-14T03:22:33.774997  / # #

    2023-03-14T03:22:33.877866  export SHELL=3D/bin/sh

    2023-03-14T03:22:33.878717  #

    2023-03-14T03:22:33.980806  / # export SHELL=3D/bin/sh. /lava-9597911/e=
nvironment

    2023-03-14T03:22:33.981741  =


    2023-03-14T03:22:34.083953  / # . /lava-9597911/environment/lava-959791=
1/bin/lava-test-runner /lava-9597911/1

    2023-03-14T03:22:34.085257  =


    2023-03-14T03:22:34.099347  / # /lava-9597911/bin/lava-test-runner /lav=
a-9597911/1

    2023-03-14T03:22:34.253547  + export TESTRUN_ID=3D1_bootrr

    2023-03-14T03:22:34.253817  + cd /lava-9597911/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/640fec52f3477411dc8c8631

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.276-cip93-5-g2eb2a953ab59/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230310.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/640fec52f3477411dc8c863b
        new failure (last pass: v4.19.273-cip92-277-g507c8d80b9e20)

    2023-03-14T03:38:35.924679  [   39.254678] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-03-14T03:38:36.954846  /lava-9598104/1/../bin/lava-test-case

    2023-03-14T03:38:36.974737  [   40.305053] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/640fec52f3477411dc8c863c
        new failure (last pass: v4.19.273-cip92-277-g507c8d80b9e20)

    2023-03-14T03:38:34.875730  [   38.204987] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-03-14T03:38:35.905042  /lava-9598104/1/../bin/lava-test-case
   =

 =20

