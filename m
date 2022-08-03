Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3DCC19F28
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 15:09:54 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web08.9892.1659539392098783305
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 08:09:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=TVqlvLZS;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id v18so16641664plo.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 08:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=034T/jonIh2qR7rmoYW47DYDzkIazek1qZ8+GPmp9n8=;
        b=TVqlvLZSdzzKa0o+rv2v6P/FaBC5ZQpl/5Ytyau5QFcLKn8Gf4cGhQZ/shMQpf4IJ9
         L4kq7eIuY05ui/rxzJtKjV+NimUwoi7rCPSzccpWtQJaU1D7IydZ9WjNycO30E/Fg3jN
         nVbSXOsgHNw/R5Wemi1pjJ1Juap/6csziyj5t5hvQ8qWRsHwTyeS8toMPWW3u40ZdcUu
         8eF9cSb/NoJ+HUdMzek5zZ+sU9GeLYh+0Dvm7gNdiWNA+HYUC8c3NlfrWsBgEh3t8/xI
         byjFwx9d68s9z53w2MeyzY9VsdbR8o9w8dLGf73M/dz0TgeX21PDIUFJm3OJ8WoE35KX
         dE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=034T/jonIh2qR7rmoYW47DYDzkIazek1qZ8+GPmp9n8=;
        b=bhO4xJSlPqq8ID+KB1XAOxnANG793Jni6xz454YPUP8QOYLrpj94dVEnJvX24Ygb8V
         P4brIpNGN4DuCl7vXzPhEteCx75kR4okMtp/zzT400JvdsIRhnqhMQYWigzzKhoXhVc/
         YLbzRxT6e7exT6o+d4rWOWYhiGGYpBiU0ZlaVFpJxhLoDy0RU+Bhg39Kws+1warGcEXK
         IBcBAXsWdNikInIqVSQaLGec8NM9SfwnnLIWWUymvhT/HEJx/wOwKN3TL+aWAVDiK3vr
         FvXhO8gcK0dfM2Lcqq0OyD20lzGJpvwCPzbJIHbMcy9dVPW97pQLbPFsAlLk8U/zGAfs
         PGVw==
X-Gm-Message-State: ACgBeo2qtbale+cU/ceAEi8O8tdMJfJD2gqbGKWQdajrmV741vWuZkuz
	3FhKVRlFjiQ+KfMXKtc/ooC8nCQP08q08YKTjWs=
X-Google-Smtp-Source: 
 AA6agR4LW2BlIUmyTrXnzlQ4twLj2qvWgk8A8u5KhXkSJPTDyPWbkU4Hol3fB7e9HgygGvXI8P2y5w==
X-Received: by 2002:a17:902:ef47:b0:16c:60df:3a7c with SMTP id
 e7-20020a170902ef4700b0016c60df3a7cmr26234282plx.9.1659539390993;
        Wed, 03 Aug 2022 08:09:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 q15-20020a17090311cf00b0016bffc59718sm2118296plh.58.2022.08.03.08.09.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 08:09:35 -0700 (PDT)
Message-ID: <62ea8faf.170a0220.b1229.36dd@mx.google.com>
Date: Wed, 03 Aug 2022 08:09:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip70-rt40
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 19 runs,
 12 regressions (v4.4.302-cip70-rt40)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 15:09:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9051

cip-gitlab/ci/pavel/linux-test baseline-nfs: 19 runs, 12 regressions (v4.4.=
302-cip70-rt40)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip70-rt40/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip70-rt40
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6b137ed6ca3666fa2abde3e184426bbb203b5bfb =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea802ef818d4a18ddaf05f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62ea802ef818d4a18=
ddaf060
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea825f96eb57f96edaf0df

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62ea825f96eb57f96=
edaf0e0
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea8055290494ecb9daf059

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62ea8055290494ecb=
9daf05a
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea80e09dca09c52fdaf061

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62ea80e09dca09c52=
fdaf062
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea83b86a39e21270daf08a

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/62ea83b86a39=
e21270daf091
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167)
        1 lines

    2022-08-03T14:18:03.690701  / # =

    2022-08-03T14:18:03.697229  =

    2022-08-03T14:18:08.700695  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/381696/extract-nfsrootfs-y2fdyb_p'
    2022-08-03T14:18:08.711156  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/381696/extract-nfsrootfs-y2fdyb_p'
    2022-08-03T14:18:10.996922  / # export NFS_SERVER_IP=3D'192.168.56.123'
    2022-08-03T14:18:11.007386  export NFS_SERVER_IP=3D'192.168.56.123'
    2022-08-03T14:18:11.109808  / # #
    2022-08-03T14:18:11.115673  #
    2022-08-03T14:18:11.217073  / # export SHELL=3D/bin/sh
    2022-08-03T14:18:11.223080  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea80f83acdd4a40fdaf06c

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/62ea80f83acd=
d4a40fdaf071
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167)
        1 lines

    2022-08-03T14:06:32.973980  / # =

    2022-08-03T14:06:32.976308  =

    2022-08-03T14:06:37.985883  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/720461/extract-nfsrootfs-gcb1es3z'
    2022-08-03T14:06:37.996572  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/720461/extract-nfsrootfs-gcb1es3z'
    2022-08-03T14:06:40.163003  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-08-03T14:06:40.173701  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-08-03T14:06:40.277069  / # #
    2022-08-03T14:06:40.279409  #
    2022-08-03T14:06:40.382689  / # export SHELL=3D/bin/sh
    2022-08-03T14:06:40.384959  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea83165760104da6daf059

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nf=
s-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nf=
s-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/62ea83165760=
104da6daf060
        new failure (last pass: v5.10.131-cip13)
        1 lines

    2022-08-03T14:15:15.960497  / # =

    2022-08-03T14:15:15.964889  =

    2022-08-03T14:15:20.988053  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/381687/extract-nfsrootfs-altr867c'
    2022-08-03T14:15:20.999102  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/381687/extract-nfsrootfs-altr867c'
    2022-08-03T14:15:23.299218  / # export NFS_SERVER_IP=3D'192.168.56.123'
    2022-08-03T14:15:23.543860  export NFS_SERVER_IP=3D'192.168.56.123'
    2022-08-03T14:15:23.657298  / # #
    2022-08-03T14:15:23.661193  #
    2022-08-03T14:15:23.774515  / # export SHELL=3D/bin/sh
    2022-08-03T14:15:23.778506  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea806b7bb1f7a9d7daf056

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-be=
aglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-be=
aglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/62ea806b7bb1=
f7a9d7daf05b
        new failure (last pass: v5.10.131-cip13)
        1 lines

    2022-08-03T14:04:08.731161  / # =

    2022-08-03T14:04:08.737652  =

    2022-08-03T14:04:13.756650  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/720458/extract-nfsrootfs-e9rx7udp'
    2022-08-03T14:04:13.767733  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/720458/extract-nfsrootfs-e9rx7udp'
    2022-08-03T14:04:15.825766  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-08-03T14:04:15.836815  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-08-03T14:04:15.948498  / # #
    2022-08-03T14:04:15.956021  #
    2022-08-03T14:04:16.067963  / # export SHELL=3D/bin/sh
    2022-08-03T14:04:16.075490  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea8049dbeb0da351daf073

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62ea8049dbeb0da35=
1daf074
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea83b1d8cdf2f82bdaf079

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62ea83b1d8cdf2f82=
bdaf07a
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea86aa3d447b8699daf090

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62ea86aa3d447b869=
9daf091
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea81914ee479e20fdaf080

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-juno-u=
boot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-juno-u=
boot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62ea81914ee479e20=
fdaf081
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =20

