Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27446C677F1
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 23:58:57 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.33270.1674086326542054731
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 15:58:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=UvZVt2sq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id z13so709837plg.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 15:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qn4nLR8vJDNmdqNElEYTPTH5HgL7Wb4iaslrlci1BYo=;
        b=UvZVt2sqHFmbTjEiQ0eHAq+AYV6ikdGeTXmusIHxI+NUhUseRFJPWk+NAAKirZxdR3
         KShhBG0t5k5F53KxuRzZxnWwXI3awmSOH7eKx5TUjElT6dqyACDciMiEJ9EidYoc/+p8
         dIx5r7g7wgVe6eUODviTCXC2KNeysHrJ3zAVluh07gyzPjV0N3os0A8sitKpoZUBc674
         ERUw4bTZEkZZKhHffM0G1KYUx7yrWcuadDv9UGTDk/gxAlywCPl1+lIR0LU0sI5kwh71
         /h74bZpgHg4yqQaHHaNJYzvk5Wqqau7/f1pVNwoFJT+izZj/x2k7UIIyUkAM53Jg7lt8
         IeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qn4nLR8vJDNmdqNElEYTPTH5HgL7Wb4iaslrlci1BYo=;
        b=6dD1d91Tl/qRMVdGJGFxj9VmRp4H0r+S2i8S5QM9GgGtS+WJ82sccpKwaXzwdGLggT
         rtUx4OKS8pmbTsTWHd0EL9loRQlnty4zwG0QidODBduhVV+siyBEJ4jAo3He10Sq7euc
         ut3hXOLO3LHY71ionkMFG9gdouf1SAH750yIqcve1nmtV+5T/7ffZWp0cu0Ra8z/9nc6
         wQBo8jdcyQjM6HjI56mDS0kPChe0mFs/iUb3Mq8/8SY7e2lNBhDaYV4Bbqv5kEduLo9L
         08LKmHwtZeL6fA4vfXlerzWPWzv3zwOyRrfynsBR7fSbYxe8jbJzMuXHfTYRXLIk2qo6
         hH0Q==
X-Gm-Message-State: AFqh2koLaJW+PjCjbUUE+aE5+me6OiKhbt/tUd8N7XW5nygyw/d0jBIp
	NPhO3bm14HNUCWxahj10GTZSrXtIf2kwVf8itFAa6A==
X-Google-Smtp-Source: AMrXdXseJuRZEkY1RJ0bpPJOjGuu6KzO3d/rma32MRg8uS487SnIJPDnq0kufk471zI5g4Go8nFntQ==
X-Received: by 2002:a17:90b:30cb:b0:219:65b0:9932 with SMTP id hi11-20020a17090b30cb00b0021965b09932mr9056368pjb.1.1674086325240;
        Wed, 18 Jan 2023 15:58:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090ad39200b002191e769546sm1889626pju.4.2023.01.18.15.58.44
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 15:58:44 -0800 (PST)
Message-ID: <63c887b4.170a0220.380cb.3a31@mx.google.com>
Date: Wed, 18 Jan 2023 15:58:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.269-rt119-858-g4aae57dbf650
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 31 runs,
 21 regressions (v4.19.269-rt119-858-g4aae57dbf650)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 23:58:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10413

cip-gitlab/ci/pavel/linux-test baseline-nfs: 31 runs, 21 regressions (v4.19=
.269-rt119-858-g4aae57dbf650)

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

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 2          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 2          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

meson-gxm-khadas-vim2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 7          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.269-rt119-858-g4aae57dbf650/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.269-rt119-858-g4aae57dbf650
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4aae57dbf650bb88d187f251ebdbd3984020b619 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87a91c87f8b907c915eda

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63c87a91c87f8b907=
c915edb
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c879c695a9197a7e915ed4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c879c695a9197a7e915ed9
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T22:59:07.141490  + set<8>[   14.786915] <LAVA_SIGNAL_ENDRUN =
0_dmesg 8786545_1.5.2.3.1>
    2023-01-18T22:59:07.141579   +x
    2023-01-18T22:59:07.246266  / # #
    2023-01-18T22:59:07.347302  export SHELL=3D/bin/sh
    2023-01-18T22:59:07.347574  #
    2023-01-18T22:59:07.448511  / # export SHELL=3D/bin/sh. /lava-8786545/e=
nvironment
    2023-01-18T22:59:07.448760  =

    2023-01-18T22:59:07.549445  / # . /lava-8786545/environment/lava-878654=
5/bin/lava-test-runner /lava-8786545/1
    2023-01-18T22:59:07.549757  =

    2023-01-18T22:59:07.554738  / # /lava-8786545/bin/lava-test-runner /lav=
a-8786545/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87a90943618118a915ec4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63c87a90943618118=
a915ec5
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87a90ce49e1718f915ed5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63c87a90ce49e1718=
f915ed6
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/63c87d52669b7eb3de915ebd

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c87d52669b7eb3de915ec2
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:14:08.947165  <8>[   60.011352] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 139070_1.6.2.4.1>
    2023-01-18T23:14:09.059572  / # #
    2023-01-18T23:14:09.161390  export SHELL=3D/bin/sh
    2023-01-18T23:14:09.161904  #
    2023-01-18T23:14:09.263346  / # export SHELL=3D/bin/sh. /lava-139070/en=
vironment
    2023-01-18T23:14:09.263835  =

    2023-01-18T23:14:09.365281  / # . /lava-139070/environment/lava-139070/=
bin/lava-test-runner /lava-139070/1
    2023-01-18T23:14:09.366107  =

    2023-01-18T23:14:09.369945  / # /lava-139070/bin/lava-test-runner /lava=
-139070/1
    2023-01-18T23:14:09.518488  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/63c87d52669b=
7eb3de915ec6
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)
        1 lines

    2023-01-18T23:14:00.250233  / # =

    2023-01-18T23:14:00.256916  =

    2023-01-18T23:14:05.272307  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/139070/extract-nfsrootfs-cdz68euo'
    2023-01-18T23:14:05.283254  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/139070/extract-nfsrootfs-cdz68euo'
    2023-01-18T23:14:07.512993  / # export NFS_SERVER_IP=3D'192.168.56.75'
    2023-01-18T23:14:07.523920  export NFS_SERVER_IP=3D'192.168.56.75'
    2023-01-18T23:14:07.628680  / # #
    2023-01-18T23:14:07.636191  #
    2023-01-18T23:14:07.738872  / # export SHELL=3D/bin/sh
    2023-01-18T23:14:07.746095  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/63c87c695d8b2e59b2915ec7

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c87c695d8b2e59b2915eca
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:10:19.217920  + set +x
    2023-01-18T23:10:19.219970  <8>[   40.587434] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 828154_1.6.2.4.1>
    2023-01-18T23:10:19.334994  / # #
    2023-01-18T23:10:19.436913  export SHELL=3D/bin/sh
    2023-01-18T23:10:19.437358  #
    2023-01-18T23:10:19.538783  / # export SHELL=3D/bin/sh. /lava-828154/en=
vironment
    2023-01-18T23:10:19.539260  =

    2023-01-18T23:10:19.640700  / # . /lava-828154/environment/lava-828154/=
bin/lava-test-runner /lava-828154/1
    2023-01-18T23:10:19.641464  =

    2023-01-18T23:10:19.643027  / # /lava-828154/bin/lava-test-runner /lava=
-828154/1 =

    ... (12 line(s) more)  =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/63c87c695d8b=
2e59b2915ece
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)
        1 lines

    2023-01-18T23:10:10.922089  / # =

    2023-01-18T23:10:10.924429  =

    2023-01-18T23:10:15.933937  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/828154/extract-nfsrootfs-hoc6lctu'
    2023-01-18T23:10:15.944653  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/828154/extract-nfsrootfs-hoc6lctu'
    2023-01-18T23:10:18.111205  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2023-01-18T23:10:18.121901  export NFS_SERVER_IP=3D'192.168.11.5'
    2023-01-18T23:10:18.225302  / # #
    2023-01-18T23:10:18.227559  #
    2023-01-18T23:10:18.331013  / # export SHELL=3D/bin/sh
    2023-01-18T23:10:18.333386  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87b06e2965e0cc5915edd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/63c87b07e296=
5e0cc5915ee6
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)
        1 lines

    2023-01-18T23:04:01.798505  / # =

    2023-01-18T23:04:01.805452  =

    2023-01-18T23:04:06.830493  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/139059/extract-nfsrootfs-4bs8uy22'
    2023-01-18T23:04:06.840969  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/139059/extract-nfsrootfs-4bs8uy22'
    2023-01-18T23:04:09.090650  / # export NFS_SERVER_IP=3D'192.168.56.75'
    2023-01-18T23:04:09.101371  export NFS_SERVER_IP=3D'192.168.56.75'
    2023-01-18T23:04:09.212860  / # #
    2023-01-18T23:04:09.218348  #
    2023-01-18T23:04:09.328129  / # export SHELL=3D/bin/sh
    2023-01-18T23:04:09.333963  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87b12d610798c7c915ed8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/63c87b12d610=
798c7c915edf
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)
        1 lines

    2023-01-18T23:04:28.154142  / # =

    2023-01-18T23:04:28.164270  =

    2023-01-18T23:04:33.189034  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/828146/extract-nfsrootfs-yo_wsxh2'
    2023-01-18T23:04:33.200214  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/828146/extract-nfsrootfs-yo_wsxh2'
    2023-01-18T23:04:35.259254  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2023-01-18T23:04:35.270386  export NFS_SERVER_IP=3D'172.16.3.3'
    2023-01-18T23:04:35.387219  / # #
    2023-01-18T23:04:35.395509  #
    2023-01-18T23:04:35.517085  / # export SHELL=3D/bin/sh
    2023-01-18T23:04:35.525347  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87c4c51c6e8c305915eba

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c87c4c51c6e8c305915ebf
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:09:56.251498  / # #
    2023-01-18T23:09:56.354705  export SHELL=3D/bin/sh
    2023-01-18T23:09:56.355568  #
    2023-01-18T23:09:56.457953  / # export SHELL=3D/bin/sh. /lava-8786671/e=
nvironment
    2023-01-18T23:09:56.458806  =

    2023-01-18T23:09:56.560869  / # . /lava-8786671/environment/lava-878667=
1/bin/lava-test-runner /lava-8786671/1
    2023-01-18T23:09:56.562111  =

    2023-01-18T23:09:56.563057  / # /lava-8786671/bin/lava-test-runner /lav=
a-8786671/1
    2023-01-18T23:09:56.721017  + export TESTRUN_ID=3D1_bootrr
    2023-01-18T23:09:56.721535  + cd /lava-8786671/1/tests/1_bootrr =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87d82808eee57f8915eda

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63c87d82808eee57f=
8915edb
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxm-khadas-vim2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87a0fd52b8fae5c915eb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-baylibre/base=
line-nfs-meson-gxm-khadas-vim2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-baylibre/base=
line-nfs-meson-gxm-khadas-vim2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63c87a0fd52b8fae5=
c915eba
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 7          =


  Details:     https://kernelci.org/test/plan/id/63c87a26d52b8fae5c915f01

  Results:     79 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rk3399-gru-sound-driver-rt5514-present: https://ker=
nelci.org/test/case/id/63c87a26d52b8fae5c915f38
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:00:43.388132  =

    2023-01-18T23:00:43.404314  seq: invalid floating point argument: =E2=
=80=98sound/RT5514=E2=80=99
    2023-01-18T23:00:43.408022  Try 'seq --help' for more information.
    2023-01-18T23:00:43.411402  /lava-8786583/1/../bin/lava-test-case
    2023-01-18T23:00:43.425716  <8>[   36.478703] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-rt5514-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-max98357A-present: https://=
kernelci.org/test/case/id/63c87a26d52b8fae5c915f39
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:00:43.367158  seq: invalid floating point argument: =E2=
=80=98sound/MAX98357A=E2=80=99
    2023-01-18T23:00:43.370487  Try 'seq --help' for more information.
    2023-01-18T23:00:43.374295  /lava-8786583/1/../bin/lava-test-case
    2023-01-18T23:00:43.387366  <8>[   36.439712] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-max98357A-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelc=
i.org/test/case/id/63c87a26d52b8fae5c915f3a
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:00:43.327231  seq: invalid floating point argument: =E2=
=80=98sound/DP=E2=80=99
    2023-01-18T23:00:43.330972  Try 'seq --help' for more information.
    2023-01-18T23:00:43.334518  /lava-8786583/1/../bin/lava-test-case
    2023-01-18T23:00:43.349199  <8>[   36.402328] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-da7219-present: https://ker=
nelci.org/test/case/id/63c87a26d52b8fae5c915f3b
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:00:43.289346  seq: invalid floating point argument: =E2=
=80=98sound/DA7219=E2=80=99
    2023-01-18T23:00:43.293724  Try 'seq --help' for more information.
    2023-01-18T23:00:43.297316  /lava-8786583/1/../bin/lava-test-case
    2023-01-18T23:00:43.310221  <8>[   36.362393] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-sysfs-driver-present: https://kernelci.org/=
test/case/id/63c87a26d52b8fae5c915f42
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:00:41.933670  /lava-8786583/1/../bin/lava-test-case
    2023-01-18T23:00:41.961931  <8>[   35.015393] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sysfs-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-lightbar-driver-present: https://kernelci.o=
rg/test/case/id/63c87a26d52b8fae5c915f4b
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:00:40.444746  /lava-8786583/1/../bin/lava-test-case
    2023-01-18T23:00:40.470384  <8>[   33.524077] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-lightbar-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-debugfs-driver-present: https://kernelci.or=
g/test/case/id/63c87a26d52b8fae5c915f54
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:00:37.973798  /lava-8786583/1/../bin/lava-test-case
    2023-01-18T23:00:37.999562  <8>[   31.053208] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-debugfs-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87b05d610798c7c915eb9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c87b05d610798c7c915ebe
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-18T23:04:13.972576  <8>[   25.875483] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 139046_1.6.2.4.1>
    2023-01-18T23:04:14.081588  / # #
    2023-01-18T23:04:14.183329  export SHELL=3D/bin/sh
    2023-01-18T23:04:14.183789  #
    2023-01-18T23:04:14.285276  / # export SHELL=3D/bin/sh. /lava-139046/en=
vironment
    2023-01-18T23:04:14.285709  =

    2023-01-18T23:04:14.387040  / # . /lava-139046/environment/lava-139046/=
bin/lava-test-runner /lava-139046/1
    2023-01-18T23:04:14.387909  =

    2023-01-18T23:04:14.392244  / # /lava-139046/bin/lava-test-runner /lava=
-139046/1
    2023-01-18T23:04:14.559544  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

