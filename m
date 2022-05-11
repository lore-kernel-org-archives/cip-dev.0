X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web08.8566.1652254722260972548
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 11 May 2022 00:38:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=K1nTXpX1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id d17so1129057plg.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 11 May 2022 00:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=KZ5MPlIuSOhh882NcfW6Hf041XUHGrXJnvr265Lcyi8=;
        b=K1nTXpX1XDtZxScnywHXD6Bc0jNz0zf2M1cThGUpXc4JBy/PQhN1yAGrt8W+0fhr2Z
         kkAX5JDShvunduAl8cHIu77e2S6scKG9/WHCjKCstvNFk0C6pQce5E0Z1A1kltDsN6l4
         6y/kDP7lHCGDrH2PqVg6qf/IwfnV2GafUZdN/6ZeiJt+eXLPXGl0xN8kHjRRP/vEXwLl
         gFMOU6ASqkcKvvcVo4CGyZf2AnVwCSubnKIHUhQ6dzHTmWXnk50Ttsr+9fN7yUbA0zYQ
         szV9ORljR+tNVx03Xh8k32Ao8oJFLasrP0VZ0GNJ8ej2QSgltXYogqMIZW+uUmbr6Qoz
         m1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=KZ5MPlIuSOhh882NcfW6Hf041XUHGrXJnvr265Lcyi8=;
        b=0EnnO5epW/xWuY8jKHiQpv4rrvj7D+cNC1ppgYOpvFQP7I8S35mXcojfszimTKyc42
         K/F3hVsShiLvo32MWHqR4AFmUCVcQfubHBvo2D3lakjdsk1K2zPo1/b3Ee45MrwjCfAB
         Jf2T9IfcmsRqwQHEWr/B3bJXoaRY5H3TiOgQ8ryBf4lOtDu1fL9enxCUOjuUF3IDS2y8
         bGSy0gBh5JLuX0tC0PsapidHUdsnVrzOa8JniQz2CJp1r7EZ/8KacnQbPt3GsHg7b4GP
         /0Ah/Xfe+zNAc1x3igTnOGMfOe5Hh739rQATWLSDZQiIVB0PeoW+cWUClGigriofXbDt
         V7GA==
X-Gm-Message-State: AOAM530c9TwLhlVrjGyV9+wO2A0qNiXIuyc2sTdnflNSzLSzYb69YV9v
	5VNjZvmVGbjZzVN+9zqb9bDwj5dV0gZ2FDnaVl4=
X-Google-Smtp-Source: ABdhPJxM/4Rozu9Dg3wLjWNp0f6jqhS4l801nRg80/ly24mGHvVjD6i5DDgC9DgE06iqRMQVjY+ZBg==
X-Received: by 2002:a17:902:dcca:b0:15e:eb8a:e8d7 with SMTP id t10-20020a170902dcca00b0015eeb8ae8d7mr23535040pll.148.1652254721424;
        Wed, 11 May 2022 00:38:41 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bj16-20020a17090b089000b001deb92de665sm1700400pjb.46.2022.05.11.00.38.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 00:38:40 -0700 (PDT)
Message-ID: <627b6800.1c69fb81.af933.450c@mx.google.com>
Date: Wed, 11 May 2022 00:38:40 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-260-gb0fe64f485ff
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 4 runs, 4 regressions (v4.4-st5-260-gb0fe64f485ff) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 4 runs, 4 regressions (v4.=
4-st5-260-gb0fe64f485ff)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =

beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig  | 1 =
         =

beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =

beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-260-gb0fe64f485ff/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-260-gb0fe64f485ff
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b0fe64f485ff31f848b40c0d6a9ac286d5b2f5df =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/627b4e34c6dcd2481d8f5761

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-broonie/basel=
ine-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-broonie/basel=
ine-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/627b4e34c6dcd=
2481d8f5762
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/627a8cbb690f97e7138f5758

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-=
cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-=
cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/627a8cbb=
690f97e7138f575b
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a)
        1 lines

    2022-05-10T16:02:55.746738  / # =

    2022-05-10T16:02:55.749307  =

    2022-05-10T16:03:00.767632  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/677162/extract-nfsrootfs-q7gvcv_y'
    2022-05-10T16:03:00.778337  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/677162/extract-nfsrootfs-</lib/lava/dispatcher/tmp/677162/extract-nf=
srootfs-q                         7gvcv_y'
    2022-05-10T16:03:02.946909  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-10T16:03:02.957613  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-10T16:03:03.063417  / # #
    2022-05-10T16:03:03.065796  #
    2022-05-10T16:03:03.181552  / # export SHELL=3D/bin/sh
    2022-05-10T16:03:03.184056  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/627b4c2ca237d643448f5751

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/omap2plus_defconfig/gcc-10/lab-broonie/base=
line-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/omap2plus_defconfig/gcc-10/lab-broonie/base=
line-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/627b4c2c=
a237d643448f5756
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a)
        1 lines

    2022-05-11T05:39:27.238149  / # =

    2022-05-11T05:39:27.245569  =

    2022-05-11T05:39:32.312778  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/129706/extract-nfsrootfs-w3puk5ap'
    2022-05-11T05:39:32.323700  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/129706/extract-nfsrootfs-</lib/lava/dispatcher/tmp/129706/extract-nf=
srootfs-w                         3puk5ap'
    2022-05-11T05:39:34.683202  / # export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-11T05:39:34.694113  export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-11T05:39:34.864772  / # #
    2022-05-11T05:39:34.870545  #
    2022-05-11T05:39:35.027975  / # export SHELL=3D/bin/sh
    2022-05-11T05:39:35.033805  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/627a8c64fd89a7ea608f57a9

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline=
-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline=
-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/627a8c64=
fd89a7ea608f57ac
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a)
        1 lines

    2022-05-10T16:01:08.835586  / # =

    2022-05-10T16:01:08.845986  =

    2022-05-10T16:01:13.900014  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/677159/extract-nfsrootfs-kxkex62_'
    2022-05-10T16:01:13.910866  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/677159/extract-nfsrootfs-</lib/lava/dispatcher/tmp/677159/extract-nf=
srootfs-k                         xkex62_'
    2022-05-10T16:01:16.031768  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-05-10T16:01:16.042732  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-05-10T16:01:16.175786  / # #
    2022-05-10T16:01:16.183815  #
    2022-05-10T16:01:16.313479  / # export SHELL=3D/bin/sh
    2022-05-10T16:01:16.321054  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =20

