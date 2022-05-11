X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web12.11515.1652276375537399600
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 11 May 2022 06:39:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Q4I/vzUr;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id a11so2039473pff.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 11 May 2022 06:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=PA3YXHIdnURTBj/8IOodjBM+s36hb/JJ73SLbEn70Mc=;
        b=Q4I/vzUrRpX76Aook550lCs1GSePwcbEEnJ2F2hRoNN2z2js/lT2EIpgFLQwbn7p8I
         xGfPwZaNkPGJiOipIlZRPI6UBcVKX+msgF//yT43m7hXAH5FGRXUfAUIHdFrbfViE2KG
         GOkSK7GskhaZCQA/hao4iRCGr7ws1mRPQXkVeU3zGca3bW4+07GUDh0B14i2zjunRAc4
         +yRr0ch10URrselaiaffpvCz2srtr8i5NnAWTttU7B1dObU2KjDDW9AFou5yFx10UzGS
         /sXs1amlPqaOAA9UzDHlpv4JqxPO+KxlMP8tvemsCctDn/dTHt3c2mFY9Qzw0b+V17KJ
         Mjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=PA3YXHIdnURTBj/8IOodjBM+s36hb/JJ73SLbEn70Mc=;
        b=SPYNT4DyJ6Xd9qpQ0qk8ajWMYYiTVncL8isDXHJXRU6WReLfOuuZRVrOg7fawFRZUf
         N1L7XagdY7AnbSvdGqKau1ZsOLyot6umVKQLd7PPFhPHcGdqXEQy9IIzS7rr/OyBvCJV
         Y2Xc3DOQ8tZ1IbueZesFqheNbiYufna20ifjaAUedcMCuZ4yIswyz2Bx+mB4Zn7gr7LL
         HrJJsqI8IP+TDtUHG1V+IAmy7xTBT08/qlC9twHuXEXRoqyektFc7D/BITNfQhqoSEq1
         Iy0qks6hzD5kuxlwfG4N9T5B/b2UJAztUSQTZChPLf+OLE4iPQIsJu8bys402e0SO8oB
         7cvQ==
X-Gm-Message-State: AOAM533yp5q6pd3SqKAuoZWBHq0WgVd2wa8kCHwphlpL1vEDaxXxKtZj
	pq0Z2HA0EqDWmrIkOrre8m1zGne209RuwJWMXAc=
X-Google-Smtp-Source: ABdhPJwF1CTHbjlUKbfTz2tR54NbMqzoc0f2BbJ5RFW5fuU7VIE2xjjsNGr8HZvCM6kOrgzsi+u7kQ==
X-Received: by 2002:a05:6a00:26cf:b0:4f6:fc52:7b6a with SMTP id p15-20020a056a0026cf00b004f6fc527b6amr25113291pfw.39.1652276374661;
        Wed, 11 May 2022 06:39:34 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id lk12-20020a17090b33cc00b001dc37aef4ffsm1886129pjb.48.2022.05.11.06.39.34
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 06:39:34 -0700 (PDT)
Message-ID: <627bbc96.1c69fb81.14de.3d33@mx.google.com>
Date: Wed, 11 May 2022 06:39:34 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-17-g04a3c17cb526f
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 3 runs, 3 regressions (v4.4-st5-17-g04a3c17cb526f) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 3 runs, 3 regressions (v4.=
4-st5-17-g04a3c17cb526f)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
beaglebone-black   | arm    | lab-cip       | gcc-10   | multi_v7_defconfig=
           | 1          =

beaglebone-black   | arm    | lab-cip       | gcc-10   | omap2plus_defconfi=
g          | 1          =

hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-17-g04a3c17cb526f/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-17-g04a3c17cb526f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      04a3c17cb526ff31d466407f119fa9692b4cee08 =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
beaglebone-black   | arm    | lab-cip       | gcc-10   | multi_v7_defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb6b19c2b1a1f438f57b7

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-=
cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-=
cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/627bb6b1=
9c2b1a1f438f57ba
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-11T13:14:01.111096  / # =

    2022-05-11T13:14:01.118469  =

    2022-05-11T13:14:06.145478  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/677775/extract-nfsrootfs-1rnvuaeo'
    2022-05-11T13:14:06.156629  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/677775/extract-nfsrootfs-</lib/lava/dispatcher/tmp/677775/extract-nf=
srootfs-1                         rnvuaeo'
    2022-05-11T13:14:08.214406  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-05-11T13:14:08.225335  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-05-11T13:14:08.338550  / # #
    2022-05-11T13:14:08.345155  #
    2022-05-11T13:14:08.461107  / # export SHELL=3D/bin/sh
    2022-05-11T13:14:08.467729  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
beaglebone-black   | arm    | lab-cip       | gcc-10   | omap2plus_defconfi=
g          | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb550b78ea0937c8f5721

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline=
-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline=
-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/627bb550=
b78ea0937c8f5724
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-11T13:08:18.416310  / # =

    2022-05-11T13:08:18.421861  =

    2022-05-11T13:08:23.451759  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/677771/extract-nfsrootfs-8zulsbv8'
    2022-05-11T13:08:23.462458  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/677771/extract-nfsrootfs-</lib/lava/dispatcher/tmp/677771/extract-nf=
srootfs-8                         zulsbv8'
    2022-05-11T13:08:25.651676  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-11T13:08:25.662373  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-11T13:08:25.787172  / # #
    2022-05-11T13:08:25.790415  #
    2022-05-11T13:08:25.920968  / # export SHELL=3D/bin/sh
    2022-05-11T13:08:25.924110  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb90f81803d507c8f571e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-17-g04a3c17cb526f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/627bb90f81803=
d507c8f571f
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

