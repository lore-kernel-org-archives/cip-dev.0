Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F2CC4332F
	for <webhook@archiver.kernel.org>; Wed, 16 Nov 2022 03:46:11 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web11.2857.1668570369797997989
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 15 Nov 2022 19:46:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=6lCfC0sN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id l6so15421751pjj.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 15 Nov 2022 19:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wJnPFcm3Y5A3WnWwusFlSFcFmrcehshWABnulKwGNSQ=;
        b=6lCfC0sNWHZXfic4Ak+bgtew4L9OnQyUqHE32Ur3Kcd5wNidq/PsRBgVg5zKwweMIg
         xE5VE56r7aJ/Bm4uPpUp579a0ABtg0doMLsmaBbqInVEj7pvvysFlvBERa0QfEkN1E4U
         ZYbGu/4LaqcUA8YMvN9NeQzzIB38F5ICPfqcPF6/kzne8FQOYydFm6SghkmERXrvVCNE
         D23prFCSIUThW3DXUmFVQXYRgYPeZbDJTalCCxkrFLixn5JfLGgK8m8FzZdbgAuthPzO
         nVWYSVltiQRh3tlfnuFUJd5T2bVah2sj+DfNhXkHnXkz1Prw6nb2euSEvWqU1MxvuVRh
         4TZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJnPFcm3Y5A3WnWwusFlSFcFmrcehshWABnulKwGNSQ=;
        b=4G8+A3I3KHJEzJMQNIbXuVMEFUiA0UVBzbEgY38BCBpKgGk6JrWT3RXRVwe7OprESO
         e9xFE4eu6XvcGnkn3ZJOJDwrrXK0yBycGXKvwTMEvjm3ojkyUWx9ELtGtEy0XWcoY4/I
         6hEcgPFi79idBlobW3RjpjnOXfARSnXLMe8KPYqBGvu1lCJm5VvXuK22A9dGFnVfjYsc
         z7uW5mtviZzj/1dadFr2rPeygxNSLv3UrIdLpOWoBraWiCYruYiQZSRlN5i14cjjCwnF
         HubKOmMM5kd0WOr4vFHeutsseWB5rE1DPNGQ+BeVOVV+T44zTBxczAJ47AvcDNIMnM9o
         mX4w==
X-Gm-Message-State: ANoB5pnDy7JS/z3t6JCiSxOKgWwhUX5WVY/18drMgLAVns/iIdY3TeBE
	4B4TCyRqoZjY1VY9o3wWKOK3MB30iqV1+1x2
X-Google-Smtp-Source: AA0mqf5fTFJfuaiV4nuXE/8d7BhV1sZSyUtZv//eypXTdNZJBkjg+EK3bjypp1q9s3BWxct+AnDVuA==
X-Received: by 2002:a17:90a:df12:b0:214:1440:8d8b with SMTP id gp18-20020a17090adf1200b0021414408d8bmr1731633pjb.4.1668570368757;
        Tue, 15 Nov 2022 19:46:08 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q19-20020aa78433000000b0056bcfe015c9sm9557851pfn.204.2022.11.15.19.46.08
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 19:46:08 -0800 (PST)
Message-ID: <63745d00.a70a0220.40c1d.eae9@mx.google.com>
Date: Tue, 15 Nov 2022 19:46:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.265-cip85-rt27
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 22 runs,
 11 regressions (v4.19.265-cip85-rt27)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Nov 2022 03:46:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10039

cip-gitlab/ci/pavel/linux-test baseline-nfs: 22 runs, 11 regressions (v4.19=
.265-cip85-rt27)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 5          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.265-cip85-rt27/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.265-cip85-rt27
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7b2b3defe99e6a33cd295c5120b96288f81f8bd7 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637452101d455530872abd14

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221107.1/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/637452101d4555308=
72abd15
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63745135780c03144e2abcfa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221107.1/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63745135780c03144=
e2abcfb
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63745499ce2fbf66e52abda9

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-be=
aglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-be=
aglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221107.1/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/63745499ce2f=
bf66e52abdae
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6)
        1 lines

    2022-11-16T03:10:03.496095  / # =

    2022-11-16T03:10:03.498365  =

    2022-11-16T03:10:08.507937  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/784922/extract-nfsrootfs-bl54e71z'
    2022-11-16T03:10:08.518633  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/784922/extract-nfsrootfs-bl54e71z'
    2022-11-16T03:10:10.685165  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-11-16T03:10:10.695843  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-11-16T03:10:10.799210  / # #
    2022-11-16T03:10:10.801622  #
    2022-11-16T03:10:10.904875  / # export SHELL=3D/bin/sh
    2022-11-16T03:10:10.907148  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63745caf426cadcc9a2abd00

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-n=
fs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-n=
fs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221107.1/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/63745caf426c=
adcc9a2abd07
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6)
        1 lines

    2022-11-16T03:44:21.574800  / # =

    2022-11-16T03:44:21.583997  =

    2022-11-16T03:44:26.607547  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/141025/extract-nfsrootfs-2x37zjhd'
    2022-11-16T03:44:26.618210  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/141025/extract-nfsrootfs-2x37zjhd'
    2022-11-16T03:44:28.913312  / # export NFS_SERVER_IP=3D'192.168.56.123'
    2022-11-16T03:44:28.923938  export NFS_SERVER_IP=3D'192.168.56.123'
    2022-11-16T03:44:29.035294  / # #
    2022-11-16T03:44:29.039681  #
    2022-11-16T03:44:29.161019  / # export SHELL=3D/bin/sh
    2022-11-16T03:44:29.166115  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63744fd55f653133ff2abd0d

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-b=
eaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-b=
eaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221107.1/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/63744fd55f65=
3133ff2abd12
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6)
        1 lines

    2022-11-16T02:49:31.132210  / # =

    2022-11-16T02:49:31.139137  =

    2022-11-16T02:49:36.168226  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/784906/extract-nfsrootfs-4e7z79mc'
    2022-11-16T02:49:36.178894  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/784906/extract-nfsrootfs-4e7z79mc'
    2022-11-16T02:49:38.352345  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-11-16T02:49:38.363040  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-11-16T02:49:38.473137  / # #
    2022-11-16T02:49:38.476044  #
    2022-11-16T02:49:38.585127  / # export SHELL=3D/bin/sh
    2022-11-16T02:49:38.588002  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63745b32b2aa5fd18f2abd22

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meson=
-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meson=
-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221107.1/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63745b32b2aa5fd18=
f2abd23
        failing since 6 days (last pass: v5.10.147-cip18-15-gef247a3cd0ad, =
first fail: v5.10.145-rt74-1329-ga59fc50f38f6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/637458662f9993273f2abda4

  Results:     82 PASS, 6 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221107.1/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.cros-ec-sysfs-probed: https://kernelci.org/test/cas=
e/id/637458662f9993273f2abde4
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6)

    2022-11-16T03:26:14.602043  /lava-7991861/1/../bin/lava-test-case
    2022-11-16T03:26:14.628376  <8>[   36.129872] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sysfs-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-sysfs-driver-present: https://kernelci.org/=
test/case/id/637458662f9993273f2abde6
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6)

    2022-11-16T03:26:12.530157  =

    2022-11-16T03:26:13.551012  /lava-7991861/1/../bin/lava-test-case
    2022-11-16T03:26:13.551937  =

    2022-11-16T03:26:13.576485  <8>[   35.077306] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sysfs-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-debugfs-probed: https://kernelci.org/test/c=
ase/id/637458662f9993273f2abdf2
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6)

    2022-11-16T03:26:10.852159  /lava-7991861/1/../bin/lava-test-case   =


  * baseline-nfs.bootrr.cros-ec-debugfs-driver-present: https://kernelci.or=
g/test/case/id/637458662f9993273f2abdf3
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6)

    2022-11-16T03:26:08.759079  <8>[   30.260754] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddeferred-probe-empty RESULT=3Dpass>
    2022-11-16T03:26:08.759333  =

    2022-11-16T03:26:09.607013  <4>[   31.107132] cdn-dp fec00000.dp: Direc=
t firmware load for rockchip/dptx.bin failed with error -2
    2022-11-16T03:26:09.806066  /lava-7991861/1/../bin/lava-test-case
    2022-11-16T03:26:09.827565  <8>[   31.328495] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-debugfs-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-lightbar-driver-present: https://kernelci.o=
rg/test/case/id/637458662f9993273f2abdf5
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6)

    2022-11-16T03:26:12.159169  /lava-7991861/1/../bin/lava-test-case   =

 =20

