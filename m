X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web11.313.1652304085659898508
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 11 May 2022 14:21:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=6PWNKf00;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id y41so3020440pfw.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 11 May 2022 14:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=rZIjtCldzh0XLQzm2sqGPwmdBtxvX8XHRGpuWuIojBs=;
        b=6PWNKf001zrgtWYuu+jkxwRMxUcpy9yGJED1ZHZo1+gnhpzsMPiVNOnSO5OTkCUb8a
         J0+DT4QQ4xDeNwxcRr2CUdKtxxt5z0nGGbUy2J8mfjsSsFN7USPK1UPM20QgbAu672Nc
         v9HHhaGSyiF4ppwxeStjViYxchAJwvJPYzfIWTRuWq1afh9i5GsPf2pgAwlHN48xhhz/
         eBfQN7JmfohvJ8j7Ax/QPMfP3KKrfCUtM2EsUqG3A8eZfoWkk1EeBuLTxSJF1nv8+Xfz
         AeELE6sEHgwhm7ql7ZznaFiNPZpnlTKpfW/W2mUS92GcG/ZO4VgYXBh8zK1hnT618T4X
         Fhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=rZIjtCldzh0XLQzm2sqGPwmdBtxvX8XHRGpuWuIojBs=;
        b=k2E2yeqi9uTKYmu7iM+ewHXtK7mgq+zA2SmAf3xXA6M/Th7O6zUqjUvB2gZqhDnHQR
         rgLZIBX5JF2tirraEjdB2X0vkJAyf5BT3vulm5e5+VgLPxCud1oXjiDrup8y7+Geckp2
         9vQg3OXrcDH5eeQalc94EA+TUQOOfHGaKb3LjmMnnTCeamEDa9na6X3NS12/i8Ern36R
         kvKUshVyJFh7AJcRErkiKYqdqLjM50S16nbtzqwep/dUqGpg8jF7flfycAbWB2JdigM4
         zyYxJzyP1hqZsZYv3DKEcsHVMIxbm0fo0Ivjc3YNp/P2hsm84Rt+LoVsFagM1ea39PKQ
         Etvg==
X-Gm-Message-State: AOAM531rDojsqLdqQVo3JWAOt8Anm99JAjJ7O7ruyEAShrixLvD4fJ4d
	pWhvVZuHxMvAL9QYZOGhNRSIUsSdRggjoxUoYp4=
X-Google-Smtp-Source: ABdhPJwJJEYYWGAhN4I0Lnp6V8V9P9YeWEjQgkQFJHAonObv75UPdpjTHYEzO9AI7XUsKCy0xln6WQ==
X-Received: by 2002:a05:6a00:2985:b0:510:66a4:375d with SMTP id cj5-20020a056a00298500b0051066a4375dmr27250001pfb.18.1652304084989;
        Wed, 11 May 2022 14:21:24 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s37-20020a63ff65000000b003c60b1f0dbasm339518pgk.35.2022.05.11.14.21.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 14:21:24 -0700 (PDT)
Message-ID: <627c28d4.1c69fb81.4b727.12c7@mx.google.com>
Date: Wed, 11 May 2022 14:21:24 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-261-g4f0b5ddda6cf
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 4 runs, 4 regressions (v4.4-st5-261-g4f0b5ddda6cf) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 4 runs, 4 regressions (v4.=
4-st5-261-g4f0b5ddda6cf)

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
nux-test/kernel/v4.4-st5-261-g4f0b5ddda6cf/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-261-g4f0b5ddda6cf
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4f0b5ddda6cf91123ba71e05f9b8c6d129f6cc14 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/627bdb3ab60be8f9848f5725

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-261-g4f0b5ddda6cf/arm/multi_v7_defconfig/gcc-10/lab-broonie/basel=
ine-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-261-g4f0b5ddda6cf/arm/multi_v7_defconfig/gcc-10/lab-broonie/basel=
ine-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/627bdb3ab60be=
8f9848f5726
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/627b880c30062d469d8f5720

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-261-g4f0b5ddda6cf/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-=
cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-261-g4f0b5ddda6cf/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-=
cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/627b880c=
30062d469d8f5723
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-11T09:54:57.934112  / # =

    2022-05-11T09:54:57.940957  =

    2022-05-11T09:55:02.972735  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/677601/extract-nfsrootfs-wn6er0mr'
    2022-05-11T09:55:02.983780  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/677601/extract-nfsrootfs-</lib/lava/dispatcher/tmp/677601/extract-nf=
srootfs-w                         n6er0mr'
    2022-05-11T09:55:05.040715  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-05-11T09:55:05.051619  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-05-11T09:55:05.165659  / # #
    2022-05-11T09:55:05.172423  #
    2022-05-11T09:55:05.287211  / # export SHELL=3D/bin/sh
    2022-05-11T09:55:05.292592  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/627bd91e2bf137025a8f5718

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-261-g4f0b5ddda6cf/arm/omap2plus_defconfig/gcc-10/lab-broonie/base=
line-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-261-g4f0b5ddda6cf/arm/omap2plus_defconfig/gcc-10/lab-broonie/base=
line-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/627bd91e=
2bf137025a8f571d
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-11T15:40:47.533671  / # =

    2022-05-11T15:40:47.541160  =

    2022-05-11T15:40:52.567343  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/132258/extract-nfsrootfs-lveyxhfp'
    2022-05-11T15:40:52.578308  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/132258/extract-nfsrootfs-</lib/lava/dispatcher/tmp/132258/extract-nf=
srootfs-l                         veyxhfp'
    2022-05-11T15:40:54.893312  / # export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-11T15:40:54.904273  export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-11T15:40:55.033896  / # #
    2022-05-11T15:40:55.039931  #
    2022-05-11T15:40:55.170596  / # export SHELL=3D/bin/sh
    2022-05-11T15:40:55.176594  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/627b87581af38f44f48f571b

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-261-g4f0b5ddda6cf/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline=
-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-261-g4f0b5ddda6cf/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline=
-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/627b8758=
1af38f44f48f571e
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-11T09:52:05.558269  / # =

    2022-05-11T09:52:05.569450  =

    2022-05-11T09:52:10.614195  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/677599/extract-nfsrootfs-2lpyipzt'
    2022-05-11T09:52:10.625268  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/677599/extract-nfsrootfs-</lib/lava/dispatcher/tmp/677599/extract-nf=
srootfs-2                         lpyipzt'
    2022-05-11T09:52:12.700613  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-05-11T09:52:12.711601  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-05-11T09:52:12.843058  / # #
    2022-05-11T09:52:12.849620  #
    2022-05-11T09:52:12.981277  / # export SHELL=3D/bin/sh
    2022-05-11T09:52:12.988820  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =20

