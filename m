X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web11.9056.1650636152297424476
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 22 Apr 2022 07:02:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=WwqQgQ2z;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id u15so7672536ple.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 22 Apr 2022 07:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=z57Rxr10kLXmiQ5rQnkzW2VAPjvn0Kox6RrCDqZ2Nek=;
        b=WwqQgQ2z82kZ5lizpixjW8OoCvGHYmbfzPUr+nsaHS8yazqIgTbK5xhygB/4ulIy4a
         /4H+724pYfY8NAoEWJNDZhV4djWVud7bxTh3sKpnGNXcqIf8bw5FU523Yl8T5OTeUyE8
         gJvn/heIDxwnmW7mC+UYV3doqUg7+nLmgMHN0rOKuPi8vSd6uDqFzthQb/IqnnLLRIzb
         EBoffUDQD7ofWeSAwKBah9xXdSLLMUT9w3qPDPc1gcP+FLKIrgT/5q2Qyu8dfvA6Cu/1
         vNIjfT2T9bBCStEmhPP15HtJ462vcH8uAhhmVv6vYCwR/DGV6hSF1L9s/AhZrbYJtWFD
         bSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=z57Rxr10kLXmiQ5rQnkzW2VAPjvn0Kox6RrCDqZ2Nek=;
        b=S2xBoGsGQEJ92oSBLKIs7kOCp7PjfIbh0yyqjMQXoP1VM2lCcxYU16QsSce5VchurY
         IS9y12YqHyyvAuRtPlFbDEgm2PjxdM248g0axWI8FQzvd2JE/lk8JThOfn8D0r9+6Z6W
         wnt7sdcbl3TZqKLe3zOOAFs6WTe1cH2oNTKcbY2wGQ67nyqAYSvNxoWHhGrYQaM7v3PJ
         CD4qUHf0FWg8u0xehCqJMSZtJgftSCYHsfMOgGcNSnFAx+qTqn5rNpBAaS/rJOAlwNm0
         43tSvtaU5olA06qZYT43HO6PQhTHDp4H5InCrFHg4BU4BPBaKxN9ir5JG1mZFgtPwJIr
         Ienw==
X-Gm-Message-State: AOAM533AntVThq9Yy8vEN43me3i/WCrCqetKOJSPcCragsQHy/zXN+yW
	ZR+qwCxdhfO+MLYREZw+QmFRdM4qkP44J/vXs60=
X-Google-Smtp-Source: ABdhPJxcxZSfvXrKPqhoqt3MHjWB+vdgypU7XCJtJ5HIntaBLNg3T7Qjakn2aQLGQCG87BDnIhtnKA==
X-Received: by 2002:a17:902:bd0c:b0:158:f864:4d9d with SMTP id p12-20020a170902bd0c00b00158f8644d9dmr4507529pls.13.1650636151454;
        Fri, 22 Apr 2022 07:02:31 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t18-20020a17090ae51200b001cd4989fec6sm6232038pjy.18.2022.04.22.07.01.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 07:01:40 -0700 (PDT)
Message-ID: <6262b544.1c69fb81.65521.fa48@mx.google.com>
Date: Fri, 22 Apr 2022 07:01:40 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v4.19.233-516-ge5e741fbfc87
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 2 runs, 2 regressions (v4.19.233-516-ge5e741fbfc87) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 2 runs, 2 regressions (v4.=
19.233-516-ge5e741fbfc87)

Regressions Summary
-------------------

platform         | arch | lab     | compiler | defconfig           | regres=
sions
-----------------+------+---------+----------+---------------------+-------=
-----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig  | 1     =
     =

beaglebone-black | arm  | lab-cip | gcc-10   | omap2plus_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.233-516-ge5e741fbfc87/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.233-516-ge5e741fbfc87
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e5e741fbfc87d414037c91102d2523f655726811 =



Test Regressions
---------------- =



platform         | arch | lab     | compiler | defconfig           | regres=
sions
-----------------+------+---------+----------+---------------------+-------=
-----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig  | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/6262a84110c83cf440ff9469

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-516-ge5e741fbfc87/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-516-ge5e741fbfc87/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/6262a841=
10c83cf440ff946c
        failing since 10 days (last pass: v5.10.106-cip4-69-g05f5682c2c593,=
 first fail: v4.4-st5-2498-g49524d978f8eb)
        1 lines

    2022-04-22T13:05:51.545730  / # =

    2022-04-22T13:05:51.553162  =

    2022-04-22T13:05:56.596656  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/667293/extract-nfsrootfs-7rsyyg9g'
    2022-04-22T13:05:56.607656  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/667293/extract-nfsrootfs-</lib/lava/dispatcher/tmp/667293/extract-nf=
srootfs-7                         rsyyg9g'
    2022-04-22T13:05:58.681680  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-04-22T13:05:58.692634  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-04-22T13:05:58.818064  / # #
    2022-04-22T13:05:58.825526  #
    2022-04-22T13:05:58.955866  / # export SHELL=3D/bin/sh
    2022-04-22T13:05:58.962701  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform         | arch | lab     | compiler | defconfig           | regres=
sions
-----------------+------+---------+----------+---------------------+-------=
-----
beaglebone-black | arm  | lab-cip | gcc-10   | omap2plus_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/6262a6dda4c537caf4ff9470

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-516-ge5e741fbfc87/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-516-ge5e741fbfc87/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/6262a6dd=
a4c537caf4ff9473
        failing since 10 days (last pass: v5.10.106-cip4-69-g05f5682c2c593,=
 first fail: v4.4-st5-2498-g49524d978f8eb)
        1 lines

    2022-04-22T12:59:44.603000  / # =

    2022-04-22T12:59:44.609941  =

    2022-04-22T12:59:49.660987  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/667284/extract-nfsrootfs-0zaknf06'
    2022-04-22T12:59:49.671703  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/667284/extract-nfsrootfs-</lib/lava/dispatcher/tmp/667284/extract-nf=
srootfs-0                         zaknf06'
    2022-04-22T12:59:51.875475  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-04-22T12:59:51.886180  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-04-22T12:59:52.018090  / # #
    2022-04-22T12:59:52.021616  #
    2022-04-22T12:59:52.163328  / # export SHELL=3D/bin/sh
    2022-04-22T12:59:52.166368  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =20

