X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web08.8878.1650636132967761589
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 22 Apr 2022 07:02:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=lKjh84lv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.178, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f178.google.com with SMTP id k14so7452662pga.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 22 Apr 2022 07:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=+7Yf7X8p/kdbUD7g4Ft/DmK9BTeug4AAlNd3VpI2R94=;
        b=lKjh84lv+gEZzQnsO6dMVip2TFGZ6IgK5HAZ8CRUEvPa8Nih1Gp1xC1Xhv8sOrjGHu
         7779jeRLnYGdbrB9bSiwJSljLnOkbO2Zi0WZNZtKB/bLe8lQA1PqpjTKI/NbMUltwk5P
         7YxQJBNygiatJq3FDv4a5mnDfx0uyLYQCD23YchucsbLYDJ97fUb6SSK3cZLQwBWugNi
         xLuLER8AWuOACqzMmOTX4AizXrZgR50sAb9gOAfvP2B7LYB+BWlCvrhOVRvMj7JhIAp8
         Tr44ejMyCcmPp3S5UvjE8MPrjZ1H6hlMCb5qLuJoKmMXGAWk1QMaX9vIiC4wtFNWenmz
         7c8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=+7Yf7X8p/kdbUD7g4Ft/DmK9BTeug4AAlNd3VpI2R94=;
        b=4UcJP6cuygbqjS4iKjdgBVlMGB4Cxe3w/Rc2zy+ol9QT4/EMe/kQ5UE+s4y9ZLjm71
         9xZckn0ock2mwqYlUInOjs7msvEnz17diR9PK2pI4nYmtPB9I6hAtOCQVq9thRqIU5bt
         Ez4XVjnK91icSTlAxwOFWrBHDUBMJ1XS3sx4/dxUVaFp+EePSGWABpS1oBUkKt7q/Y26
         Om8I2RNOzC10aqFQpsuTsW1TVS+2avGLhV6UEkfkf0RXqYlDIstlYZsmfyXe057xVsFQ
         pLvq5UhFmZQ45jMbbti7OPRgu9CGLLqILov7/Xj3+w3ir794jebK4C3jvEjSvqmJwmX7
         5GiA==
X-Gm-Message-State: AOAM530UuHmTL0ZGMN9eQ6G54D9zpF8KbIChlEhr/6N9Shq5dfJuttVY
	e3O3d9OVYHfF4POaIUFmGDvF/clzQL/BLWgdkyw=
X-Google-Smtp-Source: ABdhPJxctuSmU6Nvh3jpbJNE76boOEKAgG6p+PwHBa1xpGZpSryVOitKxx4x1B/oD+CUsViw3ExLZA==
X-Received: by 2002:a63:185f:0:b0:386:1838:8d0 with SMTP id 31-20020a63185f000000b00386183808d0mr4069660pgy.161.1650636132169;
        Fri, 22 Apr 2022 07:02:12 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f187-20020a6251c4000000b005058e59604csm2764476pfb.217.2022.04.22.07.01.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 07:01:40 -0700 (PDT)
Message-ID: <6262b544.1c69fb81.d13ba.676f@mx.google.com>
Date: Fri, 22 Apr 2022 07:01:40 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v4.19.233-516-ge5e741fbfc87
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 5 runs, 2 regressions (v4.19.233-516-ge5e741fbfc87) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-nfs: 5 runs, 2 regressions (v4.19.2=
33-516-ge5e741fbfc87)

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
nux-test/kernel/v4.19.233-516-ge5e741fbfc87/plan/baseline-nfs/

  Test:     baseline-nfs
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


  Details:     https://kernelci.org/test/plan/id/6262a8688c22b7a71eff94dd

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-516-ge5e741fbfc87/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-516-ge5e741fbfc87/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220411.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/6262a8688c22=
b7a71eff94e0
        failing since 10 days (last pass: v5.10.106-cip4-69-g05f5682c2c593,=
 first fail: v4.4-st5-2498-g49524d978f8eb)
        1 lines

    2022-04-22T13:06:19.675803  / # =

    2022-04-22T13:06:19.683952  =

    2022-04-22T13:06:24.696632  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/667291/extract-nfsrootfs-uftzfv92'
    2022-04-22T13:06:24.707639  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/667291/extract-nfsrootfs-uftzfv92'
    2022-04-22T13:06:26.754424  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-04-22T13:06:26.764934  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-04-22T13:06:26.867392  / # #
    2022-04-22T13:06:26.875032  #
    2022-04-22T13:06:26.976665  / # export SHELL=3D/bin/sh
    2022-04-22T13:06:26.983634  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform         | arch | lab     | compiler | defconfig           | regres=
sions
-----------------+------+---------+----------+---------------------+-------=
-----
beaglebone-black | arm  | lab-cip | gcc-10   | omap2plus_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/6262a78b0ec7eb18f1ff946d

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-516-ge5e741fbfc87/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-516-ge5e741fbfc87/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220411.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/6262a78b0ec7=
eb18f1ff9470
        failing since 10 days (last pass: v5.10.106-cip4-69-g05f5682c2c593,=
 first fail: v4.4-st5-2498-g49524d978f8eb)
        1 lines

    2022-04-22T13:02:36.969645  / # =

    2022-04-22T13:02:36.980464  =

    2022-04-22T13:02:42.012124  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/667287/extract-nfsrootfs-rz6ve7jl'
    2022-04-22T13:02:42.023164  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/667287/extract-nfsrootfs-rz6ve7jl'
    2022-04-22T13:02:44.082458  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-04-22T13:02:44.093359  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-04-22T13:02:44.209381  / # #
    2022-04-22T13:02:44.216896  #
    2022-04-22T13:02:44.338119  / # export SHELL=3D/bin/sh
    2022-04-22T13:02:44.345692  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =20

