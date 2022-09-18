Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB729C32771
	for <webhook@archiver.kernel.org>; Sun, 18 Sep 2022 15:17:01 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web08.9749.1663514212992365212
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 18 Sep 2022 08:16:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=qP0z4XhQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id t3so25810392ply.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 18 Sep 2022 08:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=GVO22kGDnBCywmYvsRbJnvLyQ/5MB/qa/G08O8DRFz8=;
        b=qP0z4XhQnk8elmxAuHdC38ilqZwGhXNZ6/aKw6Ciz0AxqfGC332fodpb8V7Uvz/F1n
         fkTPonO3hRG9uBwfnWWGQBvnFF2xUUcN1uCgdZulhv3FhMc+geNtOzDQKxh6vM6SkZ6x
         djJruITKnAjg2P1fD/HhA059UJJ7few8URACqi/gEmOMo135nnXFRWCoJ6s13UFMtxdo
         1MwzH0dJQxmQw+NkytGXL26GOTE1Xen3mkLZsLAdkW/skeZAjPqmTcUoaivVKW7ib8Uy
         XazimDGuos61ZDYbBpcUy1S/F4Om0Nj5ZMTtCcxXWFD/lZZbpSOad3bgPuKEuT0x4zmK
         oCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=GVO22kGDnBCywmYvsRbJnvLyQ/5MB/qa/G08O8DRFz8=;
        b=YI+6UQrK8B7Pr1X1DOmvTlSnEEBCnUU3jQ5gsZDB6OkMeUT5zRhtbMSrP7ItqgGPXG
         CfSq8GIkwpUZr6zxvcjY7raoo4mhpRjr/fauP69U/ghqDeBp6ezNOpkNd/oKZFccfdbL
         JYrixCXV2uGD15AHR5wo8sNPaC5TW52sMRpTWs8Ocip7hAof3QZ9TcnN8nt2gOBq8oBw
         L4kQ4eN1s/rdnT87vMJEIY6i76iYUDPKTTx0HPqpHQeNDQNuSZUqg6gcrZca1QsuK+bi
         9OSxhycE+koRBOJIl7POuzQGIeRFl9kGsxZgcU8EAcT2rXI72AEdsAyVXZZnPtREurDW
         PZ6w==
X-Gm-Message-State: ACrzQf1u5UKq+l7xbGZ95ALubar8I3YfKdnouFdhHO8EXfOAs7Rgx0mM
	xDt3vyWk7UIu58+XlermmAwhmIo8tUsZoXE/gVg=
X-Google-Smtp-Source: 
 AMsMyM4e8FEPNBQiUaO/Q9m+W+b/xVkRKYAY+8F9ojWXtYjugIBpMxLK051/NpkEfeZjPClVQ7bfmg==
X-Received: by 2002:a17:90b:3d04:b0:200:9d93:f6f with SMTP id
 pt4-20020a17090b3d0400b002009d930f6fmr25734359pjb.185.1663514212239;
        Sun, 18 Sep 2022 08:16:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 f3-20020a170902ce8300b00176b3c9693esm18712250plg.299.2022.09.18.08.16.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 08:16:51 -0700 (PDT)
Message-ID: <63273663.170a0220.d3ec7.0ddf@mx.google.com>
Date: Sun, 18 Sep 2022 08:16:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-231-g7349cef09ddd2
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 4 runs,
 4 regressions (v4.4-st20-231-g7349cef09ddd2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 18 Sep 2022 15:17:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9512

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 4 runs, 4 regressions (v4.=
4-st20-231-g7349cef09ddd2)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-231-g7349cef09ddd2/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-231-g7349cef09ddd2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7349cef09ddd27c4d55cc11d23fdf232c9184ccc =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63272f00b34dab6899355695

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-cip/baselin=
e-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-cip/baselin=
e-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/63272f00=
b34dab6899355698
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)
        1 lines

    2022-09-18T14:44:58.129168  / # =

    2022-09-18T14:44:58.136039  =

    2022-09-18T14:45:03.172284  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/744976/extract-nfsrootfs-xd4nmr7u'
    2022-09-18T14:45:03.183216  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/744976/extract-nfsrootfs-</lib/lava/dispatcher/tmp/744976/extract-nf=
srootfs-x                         d4nmr7u'
    2022-09-18T14:45:05.246440  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-09-18T14:45:05.257413  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-09-18T14:45:05.375681  / # #
    2022-09-18T14:45:05.382461  #
    2022-09-18T14:45:05.502655  / # export SHELL=3D/bin/sh
    2022-09-18T14:45:05.509223  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6327343c88037e58f5355645

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/6327343c=
88037e58f5355648
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)
        1 lines

    2022-09-18T15:07:11.841696  / # =

    2022-09-18T15:07:11.851719  =

    2022-09-18T15:07:16.883522  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/744994/extract-nfsrootfs-ji9ubl1q'
    2022-09-18T15:07:16.894414  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/744994/extract-nfsrootfs-</lib/lava/dispatcher/tmp/744994/extract-nf=
srootfs-j                         i9ubl1q'
    2022-09-18T15:07:18.969373  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-09-18T15:07:18.980290  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-09-18T15:07:19.111099  / # #
    2022-09-18T15:07:19.118774  #
    2022-09-18T15:07:19.249513  / # export SHELL=3D/bin/sh
    2022-09-18T15:07:19.257104  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63272f3a7ed5d5fb49355643

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/63272f3a7ed5d=
5fb49355644
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/632731570e783a6518355648

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-cip-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-cip-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/632731570e783=
a6518355649
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =20

