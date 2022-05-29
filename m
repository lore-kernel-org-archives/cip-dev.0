X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web09.25710.1653835801315332877
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 29 May 2022 07:50:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=t1DzsloX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id i1so8182687plg.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 29 May 2022 07:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=BOwr9y7FDgQbE715V/5V00tXzJX0RpDz+f2PFwX8vdg=;
        b=t1DzsloXi0G3otrymJ/LMHv/kvVv3NTRxJjFVjslS0ghhmpOpiZJ6gTYzLEfNe2Od8
         W8WTBkkswxCSDxCwR1DbcAE8J3fClQxHFAtSKQ951ceXekzWnlb0ZCADKHv80NVzBIk1
         dm4qdqq/C5kfixfnWY82dInFUlY6EKy9uznHo11pfVyjNgqnoZeuh2OslUSB9CpJwRAX
         bLYPKfuszb4KORdXN/tbhWtFu6ZLLCEYVBTAko2xX4fFium76FdAIVA93oGZPEa2oBc8
         mtZltiYemFXoUxn37Qbd6p3VKV2n0q5jSfyrnZc5yCrEH157JSNrCqrP2tBqxVEluLPU
         sPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=BOwr9y7FDgQbE715V/5V00tXzJX0RpDz+f2PFwX8vdg=;
        b=7nyUgtlaJCKfEOswlZtywi4y5OhPjIRenaRr9Lz9d1EQ/Wk3Ec+L3QvHxhoIqsOZPA
         iq451nEmO6WE1oeCbeay1Zapf7nVI3ExjkoaUH0pdHcMXuwtzTK68Y90j7qaaDFWJlzY
         xHbt7do9LRr7AvKo5fhuJ3+ZP6yGZ5rrCUfJ6dQum8QbLPDCSCR5wqrLaW5/FPeVg3nQ
         dABWYApxbkUQvnLQeoZkCkfd22A0YbACt9IUJxZ1hjEPcwopFNXrPzE6EwCOcCFuJf9Q
         UiryYLnBDqYlALkG/XYQfjdr16IAsdFfwWdG25qIZCEwqahdvv8yrBYcWvExT3vDQhBS
         bDpA==
X-Gm-Message-State: AOAM532SlQIe9mieLjxFCJL7WlkfGvlY9/jDXJGr07gnsoYFsDC23Y4M
	m9Cbyg4mBGk0yd0i5cEKM0Z9UD2tQBqntWBb838=
X-Google-Smtp-Source: ABdhPJx2MZDXvGHlYOnESoUTayKRMCtPJ4lGriaT83o4nrhPHAuW/tADqnqnNBK2VzD2sWoOcn4lwg==
X-Received: by 2002:a17:902:8bca:b0:15f:28b6:ad46 with SMTP id r10-20020a1709028bca00b0015f28b6ad46mr52017903plo.69.1653835800313;
        Sun, 29 May 2022 07:50:00 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902988100b0016353696f46sm7202177plp.269.2022.05.29.07.49.59
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 07:49:59 -0700 (PDT)
Message-ID: <62938817.1c69fb81.2fd9c.fc27@mx.google.com>
Date: Sun, 29 May 2022 07:49:59 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-297-gc0d53c2a5c03d
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 27 runs, 13 regressions (v4.4-st5-297-gc0d53c2a5c03d) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-nfs: 27 runs, 13 regressions (v4.4-=
st5-297-gc0d53c2a5c03d)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
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

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

juno-uboot                | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =

rk3288-veyron-jaq         | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-297-gc0d53c2a5c03d/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-297-gc0d53c2a5c03d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c0d53c2a5c03d0b2672a56140f211b51b3e047c1 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6293797c903f0eaf0aa39bd3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6293797c903f0eaf0=
aa39bd4
        new failure (last pass: v5.10.112-cip6) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62937d6b5c0cf339f0a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62937d6b5c0cf339f=
0a39bce
        new failure (last pass: v5.10.112-cip6) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/629379e8ef01d07f1ca39bde

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/629379e8ef01d07f1=
ca39bdf
        new failure (last pass: v5.10.112-cip6) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62937a80c2cbec76d8a39bf3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62937a80c2cbec76d=
8a39bf4
        new failure (last pass: v5.10.112-cip6) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/629379492b9c305145a39be7

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/629379492b9c=
305145a39bee
        new failure (last pass: v5.10.112-cip6)
        1 lines

    2022-05-29T13:46:34.703246  / # =

    2022-05-29T13:46:34.710390  =

    2022-05-29T13:46:39.725789  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/182639/extract-nfsrootfs-c_mff3e7'
    2022-05-29T13:46:39.736397  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/182639/extract-nfsrootfs-c_mff3e7'
    2022-05-29T13:46:42.026332  / # export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-29T13:46:42.037276  export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-29T13:46:42.142181  / # #
    2022-05-29T13:46:42.149041  #
    2022-05-29T13:46:42.251199  / # export SHELL=3D/bin/sh
    2022-05-29T13:46:42.258078  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/629378e2d86a063ffea39be5

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/629378e2d86a=
063ffea39bea
        new failure (last pass: v5.10.112-cip6)
        1 lines

    2022-05-29T13:44:47.405177  / # =

    2022-05-29T13:44:47.407468  =

    2022-05-29T13:44:52.417160  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/688593/extract-nfsrootfs-g01xp3va'
    2022-05-29T13:44:52.427857  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/688593/extract-nfsrootfs-g01xp3va'
    2022-05-29T13:44:54.594255  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-29T13:44:54.604936  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-29T13:44:54.708264  / # #
    2022-05-29T13:44:54.710625  #
    2022-05-29T13:44:54.813811  / # export SHELL=3D/bin/sh
    2022-05-29T13:44:54.816049  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/62937d1e2060e2625fa39bcd

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/62937d1e2060=
e2625fa39bd4
        new failure (last pass: v5.10.112-cip6)
        1 lines

    2022-05-29T14:02:52.385739  / # =

    2022-05-29T14:02:52.419009  =

    2022-05-29T14:02:57.496547  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/182662/extract-nfsrootfs-fwbhjhbg'
    2022-05-29T14:02:57.507523  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/182662/extract-nfsrootfs-fwbhjhbg'
    2022-05-29T14:02:59.805834  / # export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-29T14:02:59.816825  export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-29T14:02:59.928271  / # #
    2022-05-29T14:02:59.933893  #
    2022-05-29T14:03:00.047716  / # export SHELL=3D/bin/sh
    2022-05-29T14:03:00.053307  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/62937a533e2a6da913a39be4

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/62937a533e2a=
6da913a39be9
        new failure (last pass: v5.10.112-cip6)
        1 lines

    2022-05-29T13:50:39.922671  / # =

    2022-05-29T13:50:39.930544  =

    2022-05-29T13:50:44.945880  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/688599/extract-nfsrootfs-1_7zvemm'
    2022-05-29T13:50:44.958351  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/688599/extract-nfsrootfs-1_7zvemm'
    2022-05-29T13:50:47.013890  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-05-29T13:50:47.024718  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-05-29T13:50:47.137102  / # #
    2022-05-29T13:50:47.144057  #
    2022-05-29T13:50:47.257736  / # export SHELL=3D/bin/sh
    2022-05-29T13:50:47.264455  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/629379e70c87d0b49ea39beb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/629379e70c87d0b49=
ea39bec
        new failure (last pass: v5.10.112-cip6) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62937c157eb080f440a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62937c157eb080f44=
0a39bce
        new failure (last pass: v5.10.112-cip6) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62938070369ced05e9a39bd2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62938070369ced05e=
9a39bd3
        new failure (last pass: v5.10.112-cip6) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
juno-uboot                | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62937cba146415c04ca39bce

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm64/defconfig/gcc-10/lab-broonie/baseline-nf=
s-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm64/defconfig/gcc-10/lab-broonie/baseline-nf=
s-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62937cba146415c04=
ca39bcf
        new failure (last pass: v5.10.112-cip6) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/629379512b9c305145a39bf9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-nfs-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-nfs-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/629379512b9c30514=
5a39bfa
        new failure (last pass: v5.10.112-cip6) =

 =20

