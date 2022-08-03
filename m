Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F13C19F2C
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 17:25:29 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web11.569.1659547527022933714
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 10:25:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=cGJHvrnx;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.179,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f179.google.com with SMTP id bf13so15691604pgb.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 10:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=/k/Jc2s9glxGdUn1NLh8TEQM3xzCmDso1eattwSGMq4=;
        b=cGJHvrnxFEqCio9O+9dc1AFJS/zvS850OuFn6zBPxakQD1pfncQ8nkf2FkLB2Otv0B
         7cy9Nd7VZG7Qy+ogCMLO4GIlyJ/0BtNKf9l0nkrQN9eM1lWHVCNP9D0M+FBI/BYF96Bm
         hC6v88DZM9szI2bSHlF+4uFWe7SttqsOY9Haghvirq19EwAyGYR6gDVDKKNfQrEqKeJi
         doPJ/MH/P9SwLCFYHUSwlHvmsRq+arboDt+UYDbgoaP/lU5JVKtClya7NIgMk4NRbrqH
         XEC9T4w87vty1oBUJxYCi2OqQhror83HXMbNj1SaM6vUn2PCd3JDiLaEV1ioDHD6xQ1F
         4Yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=/k/Jc2s9glxGdUn1NLh8TEQM3xzCmDso1eattwSGMq4=;
        b=BOn5XFK811rVqfd0fif04t0xoM9NwanYwdfBMRbMgN8HTQGANrbt/fQg4CiXZjnUlj
         AFygfNP8A6RMFcOdfAM/vbqqw3OUUx9Kk2iEspHYW/70WQ+eHgwDotU+kPcFtAfAz7sj
         NNCJZe0rgYkXDqQP5oLbvfUqa76CsqTDHcfzvYlgrrAu1eWF2JwwGfQhZ4obnPcuAzys
         d2GbEQujmKR40DX4MKRK/mWpxATi/UvcVEgAhS1MDxXGEUF58ydiSX2foutPuDazZuoR
         JZJDSFM2kToT68Dz6rJAR8LWKqutGQ3NluXf7xHaKmoadPtmM4T3A9I4kEwVL0oYN3fB
         TQwA==
X-Gm-Message-State: ACgBeo3JSMjb1TKSrDvdNCyK+4WBLfQNWWBPzoBs+8i/44tlQ3GTRrKX
	GAx/X8ipxRvvtkae8jIHLqEhwdqRUvx9lgxYgj0=
X-Google-Smtp-Source: 
 AA6agR5VeSVYwhZ2vxIupTza6gtnbUeeSCtdpfNHbzremRI+VLhR1ora6ii149+sLDZYlzHr1h6asA==
X-Received: by 2002:a65:5383:0:b0:41c:1148:5d6b with SMTP id
 x3-20020a655383000000b0041c11485d6bmr12355233pgq.24.1659547526064;
        Wed, 03 Aug 2022 10:25:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 p9-20020a170902e74900b0016bcc35000asm2206077plf.302.2022.08.03.10.25.25
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:25:25 -0700 (PDT)
Message-ID: <62eaaf85.170a0220.1ede.3982@mx.google.com>
Date: Wed, 03 Aug 2022 10:25:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-74-gc99f2b257bde3
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 17 runs,
 7 regressions (v4.4-st20-74-gc99f2b257bde3)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 17:25:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9088

cip-gitlab/ci/pavel/linux-test baseline-nfs: 17 runs, 7 regressions (v4.4-s=
t20-74-gc99f2b257bde3)

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

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-74-gc99f2b257bde3/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-74-gc99f2b257bde3
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c99f2b257bde3cd60a833056aab624ad5fab3812 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62eaa30eb0643174eedaf184

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62eaa30eb0643174e=
edaf185
        failing since 0 day (last pass: v5.10.131-cip13-24-ga6f4ea41fe167, =
first fail: v4.4.302-cip70-rt40) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62eaa9388848cd77bbdaf48c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62eaa9388848cd77b=
bdaf48d
        failing since 0 day (last pass: v5.10.131-cip13-24-ga6f4ea41fe167, =
first fail: v4.4.302-cip70-rt40) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62eaa28044e690a60edaf069

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62eaa28044e690a60=
edaf06a
        failing since 0 day (last pass: v5.10.131-cip13-24-ga6f4ea41fe167, =
first fail: v4.4.302-cip70-rt40) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62eaa52bd9e020a812daf07e

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/62eaa52bd9e0=
20a812daf085
        failing since 0 day (last pass: v5.10.131-cip13-24-ga6f4ea41fe167, =
first fail: v4.4.302-cip70-rt40)
        1 lines

    2022-08-03T16:40:51.998990  / # =

    2022-08-03T16:40:52.005617  =

    2022-08-03T16:40:57.029920  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/382137/extract-nfsrootfs-x46bcfki'
    2022-08-03T16:40:57.040943  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/382137/extract-nfsrootfs-x46bcfki'
    2022-08-03T16:40:59.330941  / # export NFS_SERVER_IP=3D'192.168.56.123'
    2022-08-03T16:40:59.341948  export NFS_SERVER_IP=3D'192.168.56.123'
    2022-08-03T16:40:59.447195  / # #
    2022-08-03T16:40:59.453513  #
    2022-08-03T16:40:59.556733  / # export SHELL=3D/bin/sh
    2022-08-03T16:40:59.562818  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62eaa6c902418fb9c6daf085

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/62eaa6c90241=
8fb9c6daf08a
        failing since 0 day (last pass: v5.10.131-cip13-24-ga6f4ea41fe167, =
first fail: v4.4.302-cip70-rt40)
        1 lines

    2022-08-03T16:47:48.627520  / # =

    2022-08-03T16:47:48.629874  =

    2022-08-03T16:47:53.639262  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/720593/extract-nfsrootfs-vcetbc6c'
    2022-08-03T16:47:53.649947  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/720593/extract-nfsrootfs-vcetbc6c'
    2022-08-03T16:47:55.816492  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-08-03T16:47:55.827162  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-08-03T16:47:55.930483  / # #
    2022-08-03T16:47:55.932802  #
    2022-08-03T16:47:56.035995  / # export SHELL=3D/bin/sh
    2022-08-03T16:47:56.038290  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/62eaa283534ed79436daf056

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/62eaa283534e=
d79436daf05d
        failing since 0 day (last pass: v5.10.131-cip13, first fail: v4.4.3=
02-cip70-rt40)
        1 lines

    2022-08-03T16:29:27.666449  / # =

    2022-08-03T16:29:27.670988  =

    2022-08-03T16:29:32.684053  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/382102/extract-nfsrootfs-7qgn4__x'
    2022-08-03T16:29:32.695260  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/382102/extract-nfsrootfs-7qgn4__x'
    2022-08-03T16:29:34.999894  / # export NFS_SERVER_IP=3D'192.168.56.123'
    2022-08-03T16:29:35.011100  export NFS_SERVER_IP=3D'192.168.56.123'
    2022-08-03T16:29:35.122850  / # #
    2022-08-03T16:29:35.127580  #
    2022-08-03T16:29:35.243230  / # export SHELL=3D/bin/sh
    2022-08-03T16:29:35.247901  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/62eaa18dcd17c149f1daf05d

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/62eaa18dcd17=
c149f1daf062
        failing since 0 day (last pass: v5.10.131-cip13, first fail: v4.4.3=
02-cip70-rt40)
        1 lines

    2022-08-03T16:25:33.224055  / # =

    2022-08-03T16:25:33.227251  =

    2022-08-03T16:25:38.240661  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/720575/extract-nfsrootfs-4n19eyj1'
    2022-08-03T16:25:38.251387  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/720575/extract-nfsrootfs-4n19eyj1'
    2022-08-03T16:25:40.425524  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-08-03T16:25:40.436213  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-08-03T16:25:40.544082  / # #
    2022-08-03T16:25:40.546709  #
    2022-08-03T16:25:40.660927  / # export SHELL=3D/bin/sh
    2022-08-03T16:25:40.663512  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =20

