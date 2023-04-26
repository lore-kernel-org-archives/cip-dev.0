Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F1CC77B60
	for <webhook@archiver.kernel.org>; Wed, 26 Apr 2023 13:54:09 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web10.8594.1682517246935465145
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 26 Apr 2023 06:54:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=LJbGWTPa;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-24781e23c27so6379977a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 26 Apr 2023 06:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682517246; x=1685109246;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=olCt33n+Cgobl0i0GIN8258lmsycgyvZ+ab3Ihtuc1o=;
        b=LJbGWTPaqtOIKFJq2///CBI7AVhz5bx9qm1dgqkClTgJ46GdVEWyIys+LgUOcZ0ZVS
         1tRmcQqR+2KNXTxU1jlcXJovu0DwdjijCjYIl0tYAB0kli0wqthtfrPgxHC6t4dN0jBU
         XqB1CKA3+ndp+evs9lvUMqFvMLkvJzeJFLQWtASunmOk+IgpzH5pqZvCb6FbF1wZ3csC
         HRvIsL7OOmLLYjex2JHH5E5mshguoKkfY1CrEMke1ojiaO/FlqlJQCcihMTiJwIumzID
         qx0IJYG5xg0YipKaPGOwZCfJquXymLT8itvOSO+7zR4TUkYqZ/3R2W+5gNAibMOAvH95
         ll9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682517246; x=1685109246;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=olCt33n+Cgobl0i0GIN8258lmsycgyvZ+ab3Ihtuc1o=;
        b=N+sz3gmV4cRYJTKdBfuC02a3sTG08u0+yMF4RoHO5I5Yy4PwtF2VxPQkmWpU9vAkTU
         bo6hfHE59XsPYhVAEUZTfQdNDAsvENejghEFEvqTpDdAXwXMcX0R4GlHCTfMrVk6SO7p
         BwB+57yCYSdGktlIICYqb6lu7ydXOUipI1Y9xbP7KZdiHcLfDUrXSvKzXxrQk3sMkzId
         0vQaQ28EN89sX3hXQQnfbBBYrIlSMAUXGuIusEwBqAX7WfFuJwPq0B3yEZuT01Uwl2w6
         qVRDYUhAnAYHSrYjIyH6ihVO1Pj12WFXPpV4g1irMYEQgVf+EmGS2bA8egj+NkBlQ1Pk
         PgVA==
X-Gm-Message-State: AAQBX9cUML8qFmHdQsp4tAV6W4+oKtitKPpN4OKhFwEyP1AaZsDrEucV
	saxgv9AL2aIIMcUBQW1cxqMT2l07KtzXigI2kOKXdw==
X-Google-Smtp-Source: AKy350aLB9RvMdP+9q5UYJ2o+h7W9DgsVYFXgh+LbevhJ3rtS1hQtFyn3LM0XGF/biqwTwVuLmCLsg==
X-Received: by 2002:a17:90b:3d8:b0:249:87f0:604b with SMTP id go24-20020a17090b03d800b0024987f0604bmr21211791pjb.30.1682517245705;
        Wed, 26 Apr 2023 06:54:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ay6-20020a17090b030600b0023fbb21214bsm11551561pjb.17.2023.04.26.06.54.05
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 06:54:05 -0700 (PDT)
Message-ID: <64492cfd.170a0220.531bd.89e6@mx.google.com>
Date: Wed, 26 Apr 2023 06:54:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.280-cip96-89-g355dfa824cb4
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 34 runs,
 7 regressions (v4.19.280-cip96-89-g355dfa824cb4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Apr 2023 13:54:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11355

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 34 runs, 7 regress=
ions (v4.19.280-cip96-89-g355dfa824cb4)

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

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.280-cip96-89-g355dfa824cb4/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.280-cip96-89-g355dfa824cb4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      355dfa824cb4c11c1525b77bd5e76e4c0733b7c9 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64491fa1a87ef1a8d22e8623

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64491fa1a87ef1a8d22e8628
        failing since 97 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-26T12:56:42.296470  + set +x[   17.535123] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10130698_1.5.2.3.1>

    2023-04-26T12:56:42.296562  =


    2023-04-26T12:56:42.400823  / # #

    2023-04-26T12:56:42.502687  export SHELL=3D/bin/sh

    2023-04-26T12:56:42.503301  #

    2023-04-26T12:56:42.604489  / # export SHELL=3D/bin/sh. /lava-10130698/=
environment

    2023-04-26T12:56:42.605161  =


    2023-04-26T12:56:42.706424  / # . /lava-10130698/environment/lava-10130=
698/bin/lava-test-runner /lava-10130698/1

    2023-04-26T12:56:42.707646  =


    2023-04-26T12:56:42.712692  / # /lava-10130698/bin/lava-test-runner /la=
va-10130698/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64491f99d1516ca6672e8654

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64491f99d1516ca6672e8659
        failing since 97 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-26T12:56:40.791656  + set +x

    2023-04-26T12:56:40.800309  <8>[   21.290051] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10130732_1.5.2.3.1>

    2023-04-26T12:56:40.907456  #

    2023-04-26T12:56:40.908688  =


    2023-04-26T12:56:41.010524  / # #export SHELL=3D/bin/sh

    2023-04-26T12:56:41.011399  =


    2023-04-26T12:56:41.112928  / # export SHELL=3D/bin/sh. /lava-10130732/=
environment

    2023-04-26T12:56:41.113787  =


    2023-04-26T12:56:41.215391  / # . /lava-10130732/environment/lava-10130=
732/bin/lava-test-runner /lava-10130732/1

    2023-04-26T12:56:41.216658  =

 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6449275609134c529e2e8603

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6449275609134c529e2e862e
        failing since 97 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-26T13:29:09.006125  <8>[   94.913415] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 390171_1.6.2.4.1>
    2023-04-26T13:29:09.173164  / # #
    2023-04-26T13:29:09.274532  export SHELL=3D/bin/sh
    2023-04-26T13:29:09.274881  #
    2023-04-26T13:29:09.376092  / # export SHELL=3D/bin/sh. /lava-390171/en=
vironment
    2023-04-26T13:29:09.376429  =

    2023-04-26T13:29:09.477917  / # . /lava-390171/environment/lava-390171/=
bin/lava-test-runner /lava-390171/1
    2023-04-26T13:29:09.478469  =

    2023-04-26T13:29:09.482818  / # /lava-390171/bin/lava-test-runner /lava=
-390171/1
    2023-04-26T13:29:11.230852  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64492a892c2aa563fd2e86f5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64492a892c2aa563fd2e86f8
        failing since 97 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-26T13:43:24.303639  / # #

    2023-04-26T13:43:24.404231  export SHELL=3D/bin/sh

    2023-04-26T13:43:24.404463  #

    2023-04-26T13:43:24.505061  / # export SHELL=3D/bin/sh. /lava-10130931/=
environment

    2023-04-26T13:43:24.505273  =


    2023-04-26T13:43:24.605834  / # . /lava-10130931/environment/lava-10130=
931/bin/lava-test-runner /lava-10130931/1

    2023-04-26T13:43:24.606301  =


    2023-04-26T13:43:24.616851  / # /lava-10130931/bin/lava-test-runner /la=
va-10130931/1

    2023-04-26T13:43:24.728738  + export TESTRUN_ID=3D1_bootrr

    2023-04-26T13:43:24.773690  + cd /lava-10130931/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6449257682b6f4bf022e8607

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/6449257682b6f4bf022e863b
        failing since 43 days (last pass: v4.19.273-cip92-277-g507c8d80b9e2=
0, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-04-26T13:21:47.097213  <8>[   38.828290] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-04-26T13:21:48.129692  /lava-10130875/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/6449257682b6f4bf022e863c
        failing since 43 days (last pass: v4.19.273-cip92-277-g507c8d80b9e2=
0, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-04-26T13:21:47.073329  /lava-10130875/1/../bin/lava-test-case
   =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/644924afefe51d9d0d2e85eb

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-nfs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-nfs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/644924afefe51d9d0d2e8611
        failing since 97 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-04-26T13:18:02.109913  [   22.460813] <LAVA_SIGNAL_ENDRUN 0_dmesg =
390125_1.6.2.4.1>
    2023-04-26T13:18:02.218768  / # #
    2023-04-26T13:18:02.321040  export SHELL=3D/bin/sh
    2023-04-26T13:18:02.321867  #
    2023-04-26T13:18:02.423800  / # export SHELL=3D/bin/sh. /lava-390125/en=
vironment
    2023-04-26T13:18:02.424146  =

    2023-04-26T13:18:02.525726  / # . /lava-390125/environment/lava-390125/=
bin/lava-test-runner /lava-390125/1
    2023-04-26T13:18:02.526707  =

    2023-04-26T13:18:02.530262  / # /lava-390125/bin/lava-test-runner /lava=
-390125/1
    2023-04-26T13:18:02.604416  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

