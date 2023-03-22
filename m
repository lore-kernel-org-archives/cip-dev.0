Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165E4C7619A
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 10:08:33 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web10.38956.1679479707639564817
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 03:08:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=rnTjVMTE;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id iw3so18792153plb.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 03:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679479707;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcMdXLdbsQARduhKOA/7LaD0LoHyPlfnhDapcJiwER8=;
        b=rnTjVMTEclTv8BTIYtFHe2ubaNTQZuYgOqdIuNW71Nx2v7TqY1Iujb0PEF9CjVvQS5
         ixykGzYC3QzpGIaKAT5oda9E3w2RkKmnuECiW8r8D+DJ1ZoonpMsPPbDaUbENUU/9CW7
         IDXHcPXBGlocFtuxV32bqPfMSoWef17KJXXLGWZlQCUUd1+jJIL821Pbi1oSve+YHNao
         gO2ckL7WH4xrl38PAfTA1Hu7dsxeC+2ueHlis9Iz9oW2k+xqrM08dqSNTOLexITL6MAv
         KOujPy3BsVjE7DaNd5STv2Mm4auddbGjeRitfrTbBKcfGOL1Nzs9KxhQKhsHu39elzDb
         HX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679479707;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZcMdXLdbsQARduhKOA/7LaD0LoHyPlfnhDapcJiwER8=;
        b=6dn6eqJpF/5RWnP/IryEZZKUA9Z0223KiRQfq/QwdR38tx0K9GZQy4u5yhXk7JDjmO
         +O9TE45xE3pNfazBCw32gOjuWNCbTmTj10WDjbpdtFdJ4QRlob3Tpi8J1g61Cnq0wbds
         hKI+LoaGgSBOsZgBUHhFzZooVhUAsxYhyLd+77Sv6KZOt6apQuNMsOwUMbnDMGmInqd0
         TugEZURwAyOiez7Uqwf0avZl52aquC6fQh7ObBOVRi1JmNUUjE2M05NjdTG7JlRABCPf
         LTVJLe2I4VK8y2SiA6M+Gnri9GVKao02NXAIdortFLMpNaXDrbPFsyeVeh3LgC7qF6J0
         ZSQQ==
X-Gm-Message-State: AO0yUKVgm+0OevRzBjSZvbhvMHyqVg4u0r+ojYRdz9TuA92XvNLCwZVe
	vCP5MXY+bcaY7EWYYYHFHBnDP72QleNDg9kfTgNlEw==
X-Google-Smtp-Source: AK7set/+Y/oOxJqJ2GzhNNkBJVwbJdHEdx1wBfczvhNCW6/yU0M21ztbRyhLEOYLjmj8MbJNUkOxUA==
X-Received: by 2002:a17:90b:2250:b0:23f:1159:c0db with SMTP id hk16-20020a17090b225000b0023f1159c0dbmr2978706pjb.26.1679479706411;
        Wed, 22 Mar 2023 03:08:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j12-20020a17090a840c00b0023371cb020csm8394212pjn.34.2023.03.22.03.08.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 03:08:26 -0700 (PDT)
Message-ID: <641ad39a.170a0220.2ec78.f053@mx.google.com>
Date: Wed, 22 Mar 2023 03:08:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.277-cip94-1098-g26d9f86d942d
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 32 runs,
 14 regressions (v4.19.277-cip94-1098-g26d9f86d942d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 10:08:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11064

cip-gitlab/ci/pavel/linux-test baseline-nfs: 32 runs, 14 regressions (v4.19=
.277-cip94-1098-g26d9f86d942d)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
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

juno-uboot                | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 5          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.277-cip94-1098-g26d9f86d942d/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.277-cip94-1098-g26d9f86d942d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      26d9f86d942d1c22bb7542618e47ea5c0e6b4026 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641ac9ae943c6ff70a9c950d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641ac9ae943c6ff70=
a9c950e
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641acbdae37a5dad7b9c956a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641acbdae37a5dad7=
b9c956b
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641ac9c1943c6ff70a9c9540

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641ac9c1943c6ff70=
a9c9541
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641ac988286d25adac9c951b

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/641ac988286d=
25adac9c9520
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329)
        1 lines

    2023-03-22T09:24:20.012536  / # =

    2023-03-22T09:24:20.019350  =

    2023-03-22T09:24:25.027990  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/205862/extract-nfsrootfs-1ac46b47'
    2023-03-22T09:24:25.038632  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/205862/extract-nfsrootfs-1ac46b47'
    2023-03-22T09:24:27.267459  / # export NFS_SERVER_IP=3D'192.168.56.75'
    2023-03-22T09:24:27.277866  export NFS_SERVER_IP=3D'192.168.56.75'
    2023-03-22T09:24:27.379881  / # #
    2023-03-22T09:24:27.386359  #
    2023-03-22T09:24:27.487639  / # export SHELL=3D/bin/sh
    2023-03-22T09:24:27.494203  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641acda5535729e7e99c9507

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641acda5535729e7e=
99c9508
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/641acb7e635785ca679c9584

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/641acb7e6357=
85ca679c9589
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329)
        1 lines

    2023-03-22T09:32:24.960275  / # =

    2023-03-22T09:32:24.974714  =

    2023-03-22T09:32:30.108313  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/205879/extract-nfsrootfs-x12d0zcu'
    2023-03-22T09:32:30.124080  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/205879/extract-nfsrootfs-x12d0zcu'
    2023-03-22T09:32:32.474766  / # export NFS_SERVER_IP=3D'192.168.56.123'
    2023-03-22T09:32:32.490386  export NFS_SERVER_IP=3D'192.168.56.123'
    2023-03-22T09:32:32.632350  / # #
    2023-03-22T09:32:32.644057  #
    2023-03-22T09:32:32.760658  / # export SHELL=3D/bin/sh
    2023-03-22T09:32:32.771306  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/641acffe47d4c255269c9508

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm/omap2plus_defconfig/gcc-10/lab-cip/=
baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm/omap2plus_defconfig/gcc-10/lab-cip/=
baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/641acffe47d4=
c255269c950b
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329)
        1 lines

    2023-03-22T09:52:29.401160  / # =

    2023-03-22T09:52:29.406073  =

    2023-03-22T09:52:34.421856  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/883361/extract-nfsrootfs-aqn8c00z'
    2023-03-22T09:52:34.432568  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/883361/extract-nfsrootfs-aqn8c00z'
    2023-03-22T09:52:36.605178  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2023-03-22T09:52:36.615865  export NFS_SERVER_IP=3D'192.168.11.5'
    2023-03-22T09:52:36.725827  / # #
    2023-03-22T09:52:36.728966  #
    2023-03-22T09:52:36.853419  / # export SHELL=3D/bin/sh
    2023-03-22T09:52:36.856286  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
juno-uboot                | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/641ad0fec5fe064d3d9c9528

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641ad0fec5fe064d3=
d9c9529
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/641acc905b1b0a17649c9542

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/641acc905b1b0a17649c954c
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329)

    2023-03-22T09:38:09.673115  /lava-9728055/1/../bin/lava-test-case

    2023-03-22T09:38:09.698488  [   40.360860] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/641acc905b1b0a17649c954d
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329)

    2023-03-22T09:38:08.615206  /lava-9728055/1/../bin/lava-test-case

    2023-03-22T09:38:08.639176  [   39.301866] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.cros-ec-sysfs-driver-present: https://kernelci.org/=
test/case/id/641acc905b1b0a17649c9582
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329)

    2023-03-22T09:38:04.302115  /lava-9728055/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.cros-ec-lightbar-driver-present: https://kernelci.o=
rg/test/case/id/641acc905b1b0a17649c958b
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329)

    2023-03-22T09:38:01.866786  [   32.529687] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-keyb-probed RESULT=3Dpass>

    2023-03-22T09:38:02.890003  /lava-9728055/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.cros-ec-debugfs-driver-present: https://kernelci.or=
g/test/case/id/641acc905b1b0a17649c9594
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329)

    2023-03-22T09:37:59.431156  [   30.093939] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtpm-chip-is-online RESULT=3Dskip>

    2023-03-22T09:38:00.492839  /lava-9728055/1/../bin/lava-test-case
   =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/641acea2845aa419269c9521

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641acea2845aa419269c954b
        failing since 62 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-03-22T09:46:19.831772  [   74.984065] <LAVA_SIGNAL_ENDRUN 0_dmesg =
205976_1.6.2.4.1>
    2023-03-22T09:46:19.942096  / # #
    2023-03-22T09:46:20.044498  export SHELL=3D/bin/sh
    2023-03-22T09:46:20.045097  #
    2023-03-22T09:46:20.146633  / # export SHELL=3D/bin/sh. /lava-205976/en=
vironment
    2023-03-22T09:46:20.147099  =

    2023-03-22T09:46:20.248568  / # . /lava-205976/environment/lava-205976/=
bin/lava-test-runner /lava-205976/1
    2023-03-22T09:46:20.249499  =

    2023-03-22T09:46:20.253432  /lava-205976/bin/lava-test-runner /lava-205=
976/1
    2023-03-22T09:46:20.439565  / # + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

