Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F39C00140
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 10:52:05 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.9190.1660301520318280943
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Aug 2022 03:52:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=LIfP63FQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id m2so457831pls.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Aug 2022 03:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=+sDy/nqDmdII6BrbbDB7rskk3C6xjR4bk+APH+0GaDE=;
        b=LIfP63FQ2cstKf13ZsH3cjZAwR4nU1PIfoENP9g4HQJ/4S6nveczU3Ck5BVzJBZBAW
         YX7/o1n/Ufo0bL+NOWDLiK+Y6bOPe9lva3I51mALBSKa1UZQ1hTQuqoUyQQzTeWK2w3z
         BU5orSN8foC4yhYLg4psU4TDc/G6pMhWf26vzjK53YebHQZcMlniQzI2zGrqEXzr4FoT
         S5ag46P8GM2VfIGwsKiZ5iJbDRbP2grzexIEBFfO83+qp616pqaOXZSrwPmOawR9kb3S
         ygtgt80qrAyVGS0As2PSUxZ8u0GYRDRo8MDn6gYV00+HiKmjg6aPvsqpzU7Tj+AtUmaV
         D9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=+sDy/nqDmdII6BrbbDB7rskk3C6xjR4bk+APH+0GaDE=;
        b=vD1FDf/9PM3Q1YMGgymD5W+Czk2ou0LWQkWlftOvP6G57nGqOBWwYFhdInpcqmRc+p
         Tox+8zNH26PYgPVuJPVHk1YfTHVw/Mdq8G0w7KoaFwfEqUAK+QTOmZscbHLkYPUHqhHu
         oYIhEBUu6y/+mIFBttvWunR3suIeEYGIdrWoHJNhBGdUiAQc+YANqkPTGFihVCMp8fLz
         lfLLGJbdGY1v6Tnllrn1Y4iKgmNf2lo6mUjTg0CVyI+GR7RumUoNdHegnkvd4deJA8cL
         +lyQ90tnBL6OtiaKWgu0RT9lJzhTKmwkO7almxVJX5sj9+jLupA5R9iArvUz2RsBjsU5
         fnBg==
X-Gm-Message-State: ACgBeo2qbis1An3NqSntIjZiab4midBUx5fCYY5/+FDzWE+mHAMXYr3A
	V4kyPxj7wD/cr85k/uXsxFTt485ZEYeYVZx9
X-Google-Smtp-Source: 
 AA6agR4ChlerDfnVdUavYQM2H/gyFgh7NZ+5xHWcqv3gunYIB/VY4odSqW0HVNIb0AH2q7SbAClCGw==
X-Received: by 2002:a17:90a:1c02:b0:1e0:df7:31f2 with SMTP id
 s2-20020a17090a1c0200b001e00df731f2mr12884351pjs.222.1660301519101;
        Fri, 12 Aug 2022 03:51:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 129-20020a620587000000b0052ad6d627a6sm1286347pff.166.2022.08.12.03.51.58
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 03:51:58 -0700 (PDT)
Message-ID: <62f630ce.620a0220.cf245.227e@mx.google.com>
Date: Fri, 12 Aug 2022 03:51:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-96-g74ff989472f09
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 6 runs,
 5 regressions (v4.4-st20-96-g74ff989472f09)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Aug 2022 10:52:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9185

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 6 runs, 5 regressions (v4.=
4-st20-96-g74ff989472f09)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-96-g74ff989472f09/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-96-g74ff989472f09
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      74ff989472f092eb06514e780a28645e8310d183 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62f622fd427b3c9c18daf056

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62f622fd427b3=
c9c18daf057
        new failure (last pass: v4.4-st20-74-gc99f2b257bde3) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62f6252ddb6de29eb8daf08b

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/62f6252d=
db6de29eb8daf08e
        failing since 8 days (last pass: v5.10.131-cip13-24-ga6f4ea41fe167,=
 first fail: v4.4.302-cip70-rt40)
        1 lines

    2022-08-12T10:01:58.902598  / # =

    2022-08-12T10:01:58.910195  =

    2022-08-12T10:02:03.941379  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/728061/extract-nfsrootfs-r_66nui7'
    2022-08-12T10:02:03.952586  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/728061/extract-nfsrootfs-</lib/lava/dispatcher/tmp/728061/extract-nf=
srootfs-r                         _66nui7'
    2022-08-12T10:02:06.009947  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-08-12T10:02:06.020845  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-08-12T10:02:06.133971  / # #
    2022-08-12T10:02:06.140572  #
    2022-08-12T10:02:06.256540  / # export SHELL=3D/bin/sh
    2022-08-12T10:02:06.264062  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/62f6266935ab83e922daf085

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/62f62669=
35ab83e922daf088
        failing since 8 days (last pass: v5.10.131-cip13, first fail: v4.4.=
302-cip70-rt40)
        1 lines

    2022-08-12T10:07:16.716345  / # =

    2022-08-12T10:07:16.720916  =

    2022-08-12T10:07:21.746821  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/728068/extract-nfsrootfs-ec918tls'
    2022-08-12T10:07:21.757539  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/728068/extract-nfsrootfs-</lib/lava/dispatcher/tmp/728068/extract-nf=
srootfs-e                         c918tls'
    2022-08-12T10:07:23.945716  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-08-12T10:07:23.956389  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-08-12T10:07:24.081555  / # #
    2022-08-12T10:07:24.084851  #
    2022-08-12T10:07:24.214689  / # export SHELL=3D/bin/sh
    2022-08-12T10:07:24.217971  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62f628de3266b84766daf080

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62f628de3266b=
84766daf081
        failing since 8 days (last pass: v5.10.131-cip13-24-ga6f4ea41fe167,=
 first fail: v4.4.302-cip70-rt40) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62f622c653d9cd9a0bdaf05a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-cip-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-cip-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62f622c653d9c=
d9a0bdaf05b
        failing since 8 days (last pass: v5.10.131-cip13-24-ga6f4ea41fe167,=
 first fail: v4.4.302-cip70-rt40) =

 =20

