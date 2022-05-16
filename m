X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.web09.30558.1652715311936575367
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 16 May 2022 08:35:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=3nudWNaM;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.181, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f181.google.com with SMTP id 202so14400734pgc.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 16 May 2022 08:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=m+GtoGLHC6X3JSZQiRtEhA7g4MbsLg00La8x3vC0Cvs=;
        b=3nudWNaMfnk1NXA96bY+QJGbnibATWiN1GdSxPGMDumSukIB5uJ56fTPaic4fD/GCZ
         TVa2cB73o4A2n9UW+9xOHJwC9x28aV7w10Atq3map7KLm1yUAtfyPqGwiTCneiOXVhYr
         Exd7V403BJVmEjCgxIOU1QTUdpKTDsgEBaKur6r6REYXdv//cWmzvzAbc7FRkZ+RTxyg
         mXYGzjMPy4zWDAe8a0XajU/F56nX1QVK6bIl9i5iX9kJug0V+F3jkRDKZ9eQEp/Ubjnq
         JP0M5sGeRK48rMHhUmHswuROhtjuXt20dVnsjxAn8h/WkIlpwvu7nNXnDBAwLTAoZ6+y
         OoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=m+GtoGLHC6X3JSZQiRtEhA7g4MbsLg00La8x3vC0Cvs=;
        b=Y4hbIWAjtykeJ5U21MOdLknCPXHkK7X5sNBVtwjhdkOXpclHfdIjGfPEx79jeL8+Xu
         RRF9OYoJwbdGfkiD3QrBXIcCIc0dMKAAihNFmlpVIUdkWSiEeubAIHW6WHwHcdCAu65d
         c2kdydD2dZtF9dBueZALJFQ4cpIs8NJ5CKxYb+NsenItpa1rGSirNdP6ODBMqPLgqoSc
         qB8HJ3cPOWj9xWqDJRmK9wPUqUajd62f+4Ln4vFAQB+GABSf9eW2JkB7cB6e1WHJ+oRU
         KsR1LblemdC1obZXmS8+/DP48elhqusgsvVScGSt/HKtfBP8ooXBHZVOQI/zNL0Wd3A1
         zysg==
X-Gm-Message-State: AOAM533IUbn351DKQhqAKgSFhVzOejeipMGbm+HuI9RKtxgHXw3hxtMc
	tjCyLU0Diqmx9sqPiX2W0MVzRWrZ5FJrEIk9dHk=
X-Google-Smtp-Source: ABdhPJycysBrYyNAQiCiRJW6mHFQxTBj/wck2gQCCnie/DowsePNBmXUYEiXfuLabIviM/PXcBSU0Q==
X-Received: by 2002:a63:80c8:0:b0:3c2:88f0:7616 with SMTP id j191-20020a6380c8000000b003c288f07616mr16025248pgd.260.1652715311137;
        Mon, 16 May 2022 08:35:11 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u24-20020a62d458000000b0050dc7628148sm7061521pfl.34.2022.05.16.08.35.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 08:35:10 -0700 (PDT)
Message-ID: <62826f2e.1c69fb81.fb062.100a@mx.google.com>
Date: Mon, 16 May 2022 08:35:10 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-208-g5e70bc68d09e
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 5 runs, 5 regressions (v4.4-st5-208-g5e70bc68d09e) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 5 runs, 5 regressions (v4.=
4-st5-208-g5e70bc68d09e)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-208-g5e70bc68d09e/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-208-g5e70bc68d09e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      5e70bc68d09e77ff437512cfdec26dcf5710d90e =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62826f081dc212c7728f571b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/multi_v7_defconfig/gcc-10/lab-broonie/basel=
ine-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/multi_v7_defconfig/gcc-10/lab-broonie/basel=
ine-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62826f081dc21=
2c7728f571c
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/628269bf2b5f6b297a8f574b

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-=
cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-=
cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/628269bf=
2b5f6b297a8f574e
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-16T15:11:25.952146  / # =

    2022-05-16T15:11:25.959326  =

    2022-05-16T15:11:30.983285  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/680998/extract-nfsrootfs-bp85okw7'
    2022-05-16T15:11:30.994275  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/680998/extract-nfsrootfs-</lib/lava/dispatcher/tmp/680998/extract-nf=
srootfs-b                         p85okw7'
    2022-05-16T15:11:33.052792  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-05-16T15:11:33.063743  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-05-16T15:11:33.179531  / # #
    2022-05-16T15:11:33.187075  #
    2022-05-16T15:11:33.300971  / # export SHELL=3D/bin/sh
    2022-05-16T15:11:33.308568  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/62826ab150925fbaa88f574b

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline=
-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline=
-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/62826ab1=
50925fbaa88f574e
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-16T15:15:34.211723  / # =

    2022-05-16T15:15:34.216454  =

    2022-05-16T15:15:39.229706  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/681002/extract-nfsrootfs-hm9abmlk'
    2022-05-16T15:15:39.240097  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/681002/extract-nfsrootfs-</lib/lava/dispatcher/tmp/681002/extract-nf=
srootfs-h                         m9abmlk'
    2022-05-16T15:15:41.426535  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-16T15:15:41.437007  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-16T15:15:41.560707  / # #
    2022-05-16T15:15:41.563570  #
    2022-05-16T15:15:41.692946  / # export SHELL=3D/bin/sh
    2022-05-16T15:15:41.695908  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62826eab557b59dedb8f5719

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62826eab557b5=
9dedb8f571a
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6282698bc9d99c81d48f576f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-cip-nfs-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-cip-nfs-hp-x360-12b-n4000-octopus.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/6282698bc9d99=
c81d48f5770
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

