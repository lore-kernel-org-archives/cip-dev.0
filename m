X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web11.2053.1652347150388283451
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 12 May 2022 02:19:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Sgu3SecB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id a11so4275870pff.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 12 May 2022 02:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=NrADTNah+IUiA77fiSe51Sl4xHhSqqi7vBTHXRFnKk8=;
        b=Sgu3SecBLNVeMIFVV/YZnSe7G7lNpuBCm+keYq/LhRcLlLPn+jr8EZGol3UaGwlzv3
         T50bluHnaNt35tO1nr4PHKr4KwpLNLb6+t3hvnbQp9FV/9zrxDT4DkK4cXkGmzgq3MJH
         hCRXnGfExfLkMaQh7l83QAh+46cVp5Tx6pC++FYaIREvoJAL10oVYe+0tk616XYai/BD
         KNzwNh/PDoEyf4O5pIAip8W6O/yw/wyGlibC4xL/zn77C0+sKwz1yDngy8L8NxOFoRj/
         vnqUpTICTOND3GEqRPT/J2oozVU4pr8AyYs1fN7g5lhMTVfXTmDUbnjj2IN0X13tQksA
         KHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=NrADTNah+IUiA77fiSe51Sl4xHhSqqi7vBTHXRFnKk8=;
        b=ZhgKIBzmQibsKIuqA1o9Uhz8lTAMNr+wtnXLRODQetDKBByLh4liN3HJkaXQU7yQ13
         N54ETUvVDuS7T6XtVhUBVYvDJW9bmqp+DJy/9PzGJ4drvQJrcuVXKb2aZ3U6XqT1w8dV
         lxW6c9CuStGniTlpw0CPRn4hBwd7afUF3NBhWKCvGKZ4dHj+k1gznfy3K2vj4o7nk1Xa
         CdewHvLNBsIi8xkn5opUQwTDATDw2KJT6nDW5WrB+TA96MSdn3hPtIgiEeDh1vNXq37r
         iXZ6G0rzVTY++4RXJWw7o1rphxkH2t76vtuCOMZ4OlFA5/kta+wXql4iNK8XXWb61muT
         SwEg==
X-Gm-Message-State: AOAM531//CbWkp/GX8OAFttaYpLAieXk8zHMxB4JBszcKoIfuugdhyDx
	6HZXmd+QprNreKGXK5pR+Q7QSujo2BSpVHuoKv4=
X-Google-Smtp-Source: ABdhPJwzd6DfaZvEQg5LtozC9yNacXHdyhaZVoH08TJcdQSNTW9Z9pyOkbz+3Z7Cur0xBDrwGbC+bw==
X-Received: by 2002:a63:8848:0:b0:3ab:2967:df83 with SMTP id l69-20020a638848000000b003ab2967df83mr24385837pgd.77.1652347149575;
        Thu, 12 May 2022 02:19:09 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m10-20020aa7900a000000b0050dc7628170sm3250160pfo.74.2022.05.12.02.19.09
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 02:19:09 -0700 (PDT)
Message-ID: <627cd10d.1c69fb81.a6e6a.787a@mx.google.com>
Date: Thu, 12 May 2022 02:19:09 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-49-g02cbcd6511d4
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 12 runs, 7 regressions (v4.4-st5-49-g02cbcd6511d4) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-nfs: 12 runs, 7 regressions (v4.4-s=
t5-49-g02cbcd6511d4)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
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

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-49-g02cbcd6511d4/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-49-g02cbcd6511d4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      02cbcd6511d490bde09277489d0cd57e67cd1d77 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627ccedd1f2876db738f5731

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220506.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/627ccedd1f2876db7=
38f5732
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627ccb4298dc862f9e8f573d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220506.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/627ccb4298dc862f9=
e8f573e
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/627ccf357d6cea40c58f5718

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseli=
ne-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseli=
ne-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220506.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/627ccf357d6c=
ea40c58f571f
        failing since 1 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-12T09:10:44.701819  / # =

    2022-05-12T09:10:44.709271  =

    2022-05-12T09:10:49.713957  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/135758/extract-nfsrootfs-65ev3top'
    2022-05-12T09:10:49.724409  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/135758/extract-nfsrootfs-65ev3top'
    2022-05-12T09:10:52.013244  / # export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-12T09:10:52.024274  export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-12T09:10:52.130095  / # #
    2022-05-12T09:10:52.136814  #
    2022-05-12T09:10:52.239731  / # export SHELL=3D/bin/sh
    2022-05-12T09:10:52.246585  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/627cca35675a45b99c8f572e

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-n=
fs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-n=
fs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220506.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/627cca35675a=
45b99c8f5733
        failing since 1 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-12T08:49:36.995047  / # =

    2022-05-12T08:49:36.997450  =

    2022-05-12T08:49:42.006747  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/678033/extract-nfsrootfs-wb124772'
    2022-05-12T08:49:42.017430  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/678033/extract-nfsrootfs-wb124772'
    2022-05-12T08:49:44.184067  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-12T08:49:44.194768  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-12T08:49:44.298096  / # #
    2022-05-12T08:49:44.300558  #
    2022-05-12T08:49:44.403664  / # export SHELL=3D/bin/sh
    2022-05-12T08:49:44.405989  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/627ccb8820b15b3e1c8f571e

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/arm/omap2plus_defconfig/gcc-10/lab-broonie/basel=
ine-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/arm/omap2plus_defconfig/gcc-10/lab-broonie/basel=
ine-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220506.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/627ccb8820b1=
5b3e1c8f5725
        failing since 1 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-12T08:55:19.745840  / # =

    2022-05-12T08:55:19.751838  =

    2022-05-12T08:55:24.772389  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/135741/extract-nfsrootfs-8bl9_33u'
    2022-05-12T08:55:24.783406  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/135741/extract-nfsrootfs-8bl9_33u'
    2022-05-12T08:55:27.084272  / # export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-12T08:55:27.095287  export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-12T08:55:27.207780  / # #
    2022-05-12T08:55:27.213410  #
    2022-05-12T08:55:27.327772  / # export SHELL=3D/bin/sh
    2022-05-12T08:55:27.333254  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/627cc9523729b0c9f58f5718

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-=
nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-=
nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220506.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/627cc9523729=
b0c9f58f571d
        failing since 1 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-12T08:45:49.528306  / # =

    2022-05-12T08:45:49.536342  =

    2022-05-12T08:45:54.554590  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/678028/extract-nfsrootfs-03udstax'
    2022-05-12T08:45:54.565404  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/678028/extract-nfsrootfs-03udstax'
    2022-05-12T08:45:56.622558  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-05-12T08:45:56.633290  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-05-12T08:45:56.743888  / # #
    2022-05-12T08:45:56.750434  #
    2022-05-12T08:45:56.863531  / # export SHELL=3D/bin/sh
    2022-05-12T08:45:56.869772  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627ccf387d6cea40c58f5722

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/baseline-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/baseline-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220506.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/627ccf387d6cea40c=
58f5723
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

