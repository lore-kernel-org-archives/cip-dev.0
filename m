Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D6AC433F5
	for <webhook@archiver.kernel.org>; Fri, 30 Sep 2022 15:22:08 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web09.201.1664551323151726518
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 08:22:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=AbAVkkyx;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id d10so4518682pfh.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 08:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=z6JTK0oHlpej1MxaQfSgE49wnTXRvZJ+8cucLSkExBc=;
        b=AbAVkkyxgkzr4dKC6zefq2CO9RQRHdhZ3xjPrAZ3da8SQ2k9zC6hyK9fLQkr/c1z6v
         L9wns5RT11SbHpToL2BXRNKknESUqhxuW1Yl1vQwej/MjRkQmCpACeNYGagRf040fkxm
         DfPGBNJN60eeVWyglrUF3Wt8UlpGkKyFrC6I0vRmf6eFWIIqsTGO43Ni1TfP1JQWJ+MC
         uvnLxnZYhufgGffC+MnYYoqtAXE7sNyym+wuDIo63zP69epjV8IJo0QREMZsE8hqZ6OV
         np6xjDufUyoBlSnrcWEYkZQV4vgO6DXKF7gqRR/LEKUBc89Anp172lMZwv7juM0bwzRR
         3dNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=z6JTK0oHlpej1MxaQfSgE49wnTXRvZJ+8cucLSkExBc=;
        b=QEBe9STQnhPzC45TqcZ25+x237kSGBI/tZEwh2q2NXd90X7vhGuiqRdi3FDmbUsRfD
         senV1hLg24r6jeKPMWJ04hwSrNaeUh3rz7SGHCm6oBMUvDBvixc2PeT/M8jqYKiMzx81
         6FFeve5W0x3AolZoY9kWk27lOTET3AqqbuVTZL3h+QtdgjJfTKEUDmTTNC77n335vJnt
         vePDjGiZ2YWPeOyQvfIB04/Wb8HVsSFTJLq2Tfm2wlCRMcjyZUDHzoTOyPKmHcJYt19y
         i3BVqzdB2gpJctfBUkiKgq9pIPzX4irCt/CBxP92cOA8dixMBl9zOObG6hpVhQOHEa8V
         kfcg==
X-Gm-Message-State: ACrzQf2ppaIvRkJOl+ndiAfH4aOwctyuD4rRYZScmOUnzJiu2xtDoCij
	7rWt50XwufUL1r9gLDAtniCxqdHjjTF0AbRq+jE=
X-Google-Smtp-Source: 
 AMsMyM6aob1UPm6Oc9TPBiWr2z1GAAR6qdVRfOLu7Plzdz/n5+4iK2JyimY4pj/BUR7/ealbq1adfw==
X-Received: by 2002:a62:4c2:0:b0:52e:bd4d:50e1 with SMTP id
 185-20020a6204c2000000b0052ebd4d50e1mr9976600pfe.8.1664551321969;
        Fri, 30 Sep 2022 08:22:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 u5-20020a170902e80500b00177faf558b5sm1729892plg.250.2022.09.30.08.22.01
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 08:22:01 -0700 (PDT)
Message-ID: <63370999.170a0220.195c9.2f59@mx.google.com>
Date: Fri, 30 Sep 2022 08:22:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip70-98-gb2bfffe124dae
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 22 runs,
 15 regressions (v4.4.302-cip70-98-gb2bfffe124dae)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 30 Sep 2022 15:22:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9589

cip-gitlab/ci/pavel/linux-test baseline-nfs: 22 runs, 15 regressions (v4.4.=
302-cip70-98-gb2bfffe124dae)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

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

dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip70-98-gb2bfffe124dae/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip70-98-gb2bfffe124dae
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b2bfffe124dae9fd793da3a9d45f286a98412d6b =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/633702b54b953d47dcec4ec7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/633702b54b953d47d=
cec4ec8
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6337065eef83e0c30aec4eaf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6337065eef83e0c30=
aec4eb0
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/633705ca6fcd50ce71ec4ea6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/633705ca6fcd50ce7=
1ec4ea7
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/633706c104690c0e42ec4ea6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/633706c104690c0e4=
2ec4ea7
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/633702c6152e562d49ec4ea8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/633702c6152e562d4=
9ec4ea9
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/633702ec657240a77eec4f22

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/633702ec6572=
40a77eec4f27
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8)
        1 lines

    2022-09-30T14:53:03.252633  / # =

    2022-09-30T14:53:03.259395  =

    2022-09-30T14:53:08.281159  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/594420/extract-nfsrootfs-fq9u84dw'
    2022-09-30T14:53:08.291940  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/594420/extract-nfsrootfs-fq9u84dw'
    2022-09-30T14:53:10.588572  / # export NFS_SERVER_IP=3D'192.168.56.125'
    2022-09-30T14:53:10.599417  export NFS_SERVER_IP=3D'192.168.56.125'
    2022-09-30T14:53:10.702911  / # #
    2022-09-30T14:53:10.710273  #
    2022-09-30T14:53:10.812324  / # export SHELL=3D/bin/sh
    2022-09-30T14:53:10.819440  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/633704256c03b847e6ec4eff

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/arm/multi_v7_defconfig/gcc-10/lab-cip/bas=
eline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/arm/multi_v7_defconfig/gcc-10/lab-cip/bas=
eline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/633704256c03=
b847e6ec4f02
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8)
        1 lines

    2022-09-30T14:58:15.649103  / # =

    2022-09-30T14:58:15.656960  =

    2022-09-30T14:58:20.673051  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/751933/extract-nfsrootfs-u0w87up9'
    2022-09-30T14:58:20.683970  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/751933/extract-nfsrootfs-u0w87up9'
    2022-09-30T14:58:22.731456  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-09-30T14:58:22.742367  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-09-30T14:58:22.847488  / # #
    2022-09-30T14:58:22.855208  #
    2022-09-30T14:58:22.956965  / # export SHELL=3D/bin/sh
    2022-09-30T14:58:22.965934  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/633703b4234bf4cd6cec4eb3

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/arm/omap2plus_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/arm/omap2plus_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/633703b4234b=
f4cd6cec4eb8
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8)
        1 lines

    2022-09-30T14:56:28.623615  / # =

    2022-09-30T14:56:28.629054  =

    2022-09-30T14:56:33.664695  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/594445/extract-nfsrootfs-s19_h19_'
    2022-09-30T14:56:33.675451  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/594445/extract-nfsrootfs-s19_h19_'
    2022-09-30T14:56:35.979668  / # export NFS_SERVER_IP=3D'192.168.56.125'
    2022-09-30T14:56:35.990512  export NFS_SERVER_IP=3D'192.168.56.125'
    2022-09-30T14:56:36.099950  / # #
    2022-09-30T14:56:36.104920  #
    2022-09-30T14:56:36.218773  / # export SHELL=3D/bin/sh
    2022-09-30T14:56:36.223612  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63370682880909469eec4ece

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/arm/omap2plus_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/arm/omap2plus_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/633706828809=
09469eec4ed1
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8)
        1 lines

    2022-09-30T15:08:22.655524  / # =

    2022-09-30T15:08:22.658402  =

    2022-09-30T15:08:27.671448  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/751943/extract-nfsrootfs-lieal7qi'
    2022-09-30T15:08:27.682141  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/751943/extract-nfsrootfs-lieal7qi'
    2022-09-30T15:08:29.854302  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-09-30T15:08:29.865022  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-09-30T15:08:29.971679  / # #
    2022-09-30T15:08:29.974392  #
    2022-09-30T15:08:30.086831  / # export SHELL=3D/bin/sh
    2022-09-30T15:08:30.089468  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/633702b44b953d47dcec4ec4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/633702b44b953d47d=
cec4ec5
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/633702b24b953d47dcec4ec1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/633702b24b953d47d=
cec4ec2
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6337055a3c7c34147eec4f42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6337055a3c7c34147=
eec4f43
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/633704366c03b847e6ec4f16

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/633704366c03b847e=
6ec4f17
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6337087b2fc6d79080ec4ed6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6337087b2fc6d7908=
0ec4ed7
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/633701c40e4733addaec4eb6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-98-gb2bfffe124dae/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/633701c40e4733add=
aec4eb7
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =20

