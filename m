Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D246C46467
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 20:50:46 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web10.28453.1674075044937482736
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 12:50:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=GPhOldln;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id i1so12166266pfk.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 12:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ovBrR171dJHxU6SXFqL4CCyv42dyuN9iUqZSpfbYYNo=;
        b=GPhOldlnNa4bbmIcK1ahXKJCPA39OG5CDn9gjgs1aWhgQFcvcDTvT99Au/7ZsIbSm7
         PKJOgGPTTUFWsdTcUeYpunuTmmjyFJOdNvaTyckYZWOHP+FvQgLaJyN/4eXAXqtS7gix
         omZp4R4GiEMua7tKgwPUznXz/1wQo0/iJWd32tCfDZFyoY461gZI2bllMMCmwANX1Sx6
         0ytv3DrmdhJ5qpS3afvac6arkajPhBCnttxxvjZZ4CGWlquhluefdu9dChhnWINjDCG1
         tk2s3VvjgVEOaQGbLj+IuqQD0xfhim+wCLemhZEoUJiZgJXJpgJn2E3XgJd0MJAz8HR1
         sXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovBrR171dJHxU6SXFqL4CCyv42dyuN9iUqZSpfbYYNo=;
        b=dRMPikyS3bIuRkERDNrAnzuz4h7IltKyQanzuQ3Hz9Jxzjgp9twRHOea3GY/u6aErs
         ZSyJYWVqMbvFOlfjDRr4PfYgryjvlPOXWQg4/cIh2NZhjWk3QnWFpWB8QEHIoNwVSrVA
         SCAI4MeLNts+PRJoJ/RXxUGtsfdiRPCUTaBV3Ri36XAUohp87H4SXM6ZNmixDG9nR4k6
         i37IkBSb4/AJZELlXstq7z0mPHyHrlsFVH1ixHcxRvNNOwuidxbgSDMgLgosxG6ByXTw
         4LW7vIV3FZtkKvCZRG+mrh+OEcwAL7d2P/luMKCbqNBrifRn3cYiIHgJ4IuG6rpS/WUl
         QCpA==
X-Gm-Message-State: AFqh2koL/W7lG9OHCFnNOkXHaD5cdbTu6RDYUsAToS1OXU+2yvDc62YX
	Mb8p2LTsWdrM5kHfFqg5FyMvkp1tG5EMCfGKgnP27Q==
X-Google-Smtp-Source: AMrXdXubV9nO/5r/QytwAc73JpQzVbRD+L9KKprwBoRaIAWoWn8gzup+egPu70noa4r5Pwvk4Cgk7Q==
X-Received: by 2002:aa7:8c51:0:b0:58d:8d88:447b with SMTP id e17-20020aa78c51000000b0058d8d88447bmr7341523pfd.2.1674075043477;
        Wed, 18 Jan 2023 12:50:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z5-20020aa79f85000000b0058bbdaaa5e4sm8079175pfr.162.2023.01.18.12.50.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 12:50:43 -0800 (PST)
Message-ID: <63c85ba3.a70a0220.5dce8.d3ae@mx.google.com>
Date: Wed, 18 Jan 2023 12:50:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.269-rt119-1495-gc851fb1e222f
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 21 runs,
 19 regressions (v4.19.269-rt119-1495-gc851fb1e222f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 20:50:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10399

cip-gitlab/ci/pavel/linux-test baseline-nfs: 21 runs, 19 regressions (v4.19=
.269-rt119-1495-gc851fb1e222f)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 2          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 2          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =

meson-gxm-khadas-vim2     | arm64  | lab-baylibre  | gcc-10   | defconfig  =
                  | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 7          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.269-rt119-1495-gc851fb1e222f/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.269-rt119-1495-gc851fb1e222f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c851fb1e222f4acf955da1ad9b020f3fc8a51c4b =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c855456f1bb253e3915f2f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63c855456f1bb253e=
3915f30
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c856fd418912f210915eb9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c856fd418912f210915ebe
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:30:46.871043  + set<8>[   17.759837] <LAVA_SIGNAL_ENDRUN =
0_dmesg 8784765_1.5.2.3.1>
    2023-01-18T20:30:46.871144   +x
    2023-01-18T20:30:46.975552  / # #
    2023-01-18T20:30:47.076597  export SHELL=3D/bin/sh
    2023-01-18T20:30:47.076842  #
    2023-01-18T20:30:47.177794  / # export SHELL=3D/bin/sh. /lava-8784765/e=
nvironment
    2023-01-18T20:30:47.178040  =

    2023-01-18T20:30:47.279026  / # . /lava-8784765/environment/lava-878476=
5/bin/lava-test-runner /lava-8784765/1
    2023-01-18T20:30:47.279375  =

    2023-01-18T20:30:47.284536  / # /lava-8784765/bin/lava-test-runner /lav=
a-8784765/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8556c39318b5bd0915f6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63c8556c39318b5bd=
0915f6e
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c853f2e927188750915ed1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63c853f2e92718875=
0915ed2
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/63c85461cc643d81c8915ec7

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c85461cc643d81c8915ecc
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:19:33.735068  <8>[   53.073475] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 138359_1.6.2.4.1>
    2023-01-18T20:19:33.873314  / # #
    2023-01-18T20:19:33.974949  export SHELL=3D/bin/sh
    2023-01-18T20:19:33.975302  #
    2023-01-18T20:19:34.076609  / # export SHELL=3D/bin/sh. /lava-138359/en=
vironment
    2023-01-18T20:19:34.077052  =

    2023-01-18T20:19:34.178445  / # . /lava-138359/environment/lava-138359/=
bin/lava-test-runner /lava-138359/1
    2023-01-18T20:19:34.179214  =

    2023-01-18T20:19:34.182930  / # /lava-138359/bin/lava-test-runner /lava=
-138359/1
    2023-01-18T20:19:34.394990  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/63c85461cc64=
3d81c8915ed0
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)
        1 lines

    2023-01-18T20:19:24.731301  / # =

    2023-01-18T20:19:24.737471  =

    2023-01-18T20:19:29.749191  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/138359/extract-nfsrootfs-g0s00zcd'
    2023-01-18T20:19:29.759794  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/138359/extract-nfsrootfs-g0s00zcd'
    2023-01-18T20:19:31.987935  / # export NFS_SERVER_IP=3D'192.168.56.75'
    2023-01-18T20:19:31.998483  export NFS_SERVER_IP=3D'192.168.56.75'
    2023-01-18T20:19:32.100290  / # #
    2023-01-18T20:19:32.106513  #
    2023-01-18T20:19:32.208281  / # export SHELL=3D/bin/sh
    2023-01-18T20:19:32.214795  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/63c856d2c6a5613df5915f36

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c856d2c6a5613df5915f39
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:29:43.573132  <8>[   61.721958] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 827981_1.6.2.4.1>
    2023-01-18T20:29:43.842000  / # #
    2023-01-18T20:29:43.944651  export SHELL=3D/bin/sh
    2023-01-18T20:29:43.945430  #
    2023-01-18T20:29:44.047296  / # export SHELL=3D/bin/sh. /lava-827981/en=
vironment
    2023-01-18T20:29:44.048145  =

    2023-01-18T20:29:44.150029  / # . /lava-827981/environment/lava-827981/=
bin/lava-test-runner /lava-827981/1
    2023-01-18T20:29:44.151281  =

    2023-01-18T20:29:44.157265  / # /lava-827981/bin/lava-test-runner /lava=
-827981/1
    2023-01-18T20:29:44.487563  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/63c856d2c6a5=
613df5915f3d
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)
        1 lines

    2023-01-18T20:29:32.990121  / # =

    2023-01-18T20:29:32.998849  =

    2023-01-18T20:29:38.030191  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/827981/extract-nfsrootfs-k5ws0ayt'
    2023-01-18T20:29:38.041321  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/827981/extract-nfsrootfs-k5ws0ayt'
    2023-01-18T20:29:40.090124  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2023-01-18T20:29:40.101192  export NFS_SERVER_IP=3D'172.16.3.3'
    2023-01-18T20:29:40.206484  / # #
    2023-01-18T20:29:40.214261  #
    2023-01-18T20:29:40.315940  / # export SHELL=3D/bin/sh
    2023-01-18T20:29:40.323958  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63c851f2a89b535671915eca

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/63c851f2a89b=
535671915ed2
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)
        1 lines

    2023-01-18T20:09:04.709204  / # =

    2023-01-18T20:09:04.717162  =

    2023-01-18T20:09:09.741506  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/138114/extract-nfsrootfs-d8kse1hd'
    2023-01-18T20:09:09.752145  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/138114/extract-nfsrootfs-d8kse1hd'
    2023-01-18T20:09:11.990678  / # export NFS_SERVER_IP=3D'192.168.56.75'
    2023-01-18T20:09:12.001373  export NFS_SERVER_IP=3D'192.168.56.75'
    2023-01-18T20:09:12.107868  / # #
    2023-01-18T20:09:12.112199  #
    2023-01-18T20:09:12.222418  / # export SHELL=3D/bin/sh
    2023-01-18T20:09:12.227763  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63c851f9a89b535671915eda

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/omap2plus_defconfig/gcc-10/lab-cip/=
baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/omap2plus_defconfig/gcc-10/lab-cip/=
baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/63c851f9a89b=
535671915ee1
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)
        1 lines

    2023-01-18T20:08:52.584228  / # =

    2023-01-18T20:08:52.594963  =

    2023-01-18T20:08:57.627916  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/827934/extract-nfsrootfs-rkzh45hs'
    2023-01-18T20:08:57.638726  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/827934/extract-nfsrootfs-rkzh45hs'
    2023-01-18T20:08:59.695723  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2023-01-18T20:08:59.706567  export NFS_SERVER_IP=3D'172.16.3.3'
    2023-01-18T20:08:59.819919  / # #
    2023-01-18T20:08:59.827006  #
    2023-01-18T20:08:59.936318  / # export SHELL=3D/bin/sh
    2023-01-18T20:08:59.943175  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c853a5d21377a55b915ef5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c853a5d21377a55b915efa
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:16:29.831082  / # #
    2023-01-18T20:16:29.934203  export SHELL=3D/bin/sh
    2023-01-18T20:16:29.935031  #
    2023-01-18T20:16:30.037265  / # export SHELL=3D/bin/sh. /lava-8784835/e=
nvironment
    2023-01-18T20:16:30.038094  =

    2023-01-18T20:16:30.140437  / # . /lava-8784835/environment/lava-878483=
5/bin/lava-test-runner /lava-8784835/1
    2023-01-18T20:16:30.141693  =

    2023-01-18T20:16:30.152250  / # /lava-8784835/bin/lava-test-runner /lav=
a-8784835/1
    2023-01-18T20:16:30.288093  + export TESTRUN_ID=3D1_bootrr
    2023-01-18T20:16:30.288627  + cd /lava-8784835/1/tests/1_bootrr =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
meson-gxm-khadas-vim2     | arm64  | lab-baylibre  | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/63c856027d5675b9ce915f77

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm64/defconfig/gcc-10/lab-baylibre/bas=
eline-nfs-meson-gxm-khadas-vim2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm64/defconfig/gcc-10/lab-baylibre/bas=
eline-nfs-meson-gxm-khadas-vim2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63c856027d5675b9c=
e915f78
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 7          =


  Details:     https://kernelci.org/test/plan/id/63c852c5a32d0df156915ece

  Results:     79 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rk3399-gru-sound-driver-rt5514-present: https://ker=
nelci.org/test/case/id/63c852c5a32d0df156915f05
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:12:33.120730  seq: invalid floating point argument: =E2=
=80=98sound/RT5514=E2=80=99
    2023-01-18T20:12:33.121026  =

    2023-01-18T20:12:33.124935  Try 'seq --help' for more information.
    2023-01-18T20:12:33.128653  /lava-8784561/1/../bin/lava-test-case
    2023-01-18T20:12:33.129044  =

    2023-01-18T20:12:33.141715  <8>[   35.523073] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-rt5514-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-max98357A-present: https://=
kernelci.org/test/case/id/63c852c5a32d0df156915f06
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:12:33.069846  =

    2023-01-18T20:12:33.085283  seq: invalid floating point argument: =E2=
=80=98sound/MAX98357A=E2=80=99
    2023-01-18T20:12:33.088865  Try 'seq --help' for more information.
    2023-01-18T20:12:33.092985  /lava-8784561/1/../bin/lava-test-case
    2023-01-18T20:12:33.104885  <8>[   35.486075] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-max98357A-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelc=
i.org/test/case/id/63c852c5a32d0df156915f07
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:12:33.024813  <8>[   35.405951] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>
    2023-01-18T20:12:33.048326  seq: invalid floating point argument: =E2=
=80=98sound/DP=E2=80=99
    2023-01-18T20:12:33.052301  Try 'seq --help' for more information.
    2023-01-18T20:12:33.052741  =

    2023-01-18T20:12:33.056032  /lava-8784561/1/../bin/lava-test-case
    2023-01-18T20:12:33.069213  <8>[   35.451013] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-da7219-present: https://ker=
nelci.org/test/case/id/63c852c5a32d0df156915f08
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:12:32.989549  <8>[   35.371265] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-present RESULT=3Dpass>
    2023-01-18T20:12:33.004703  seq: invalid floating point argument: =E2=
=80=98sound/DA7219=E2=80=99
    2023-01-18T20:12:33.005081  =

    2023-01-18T20:12:33.008700  Try 'seq --help' for more information.
    2023-01-18T20:12:33.009065  =

    2023-01-18T20:12:33.012333  /lava-8784561/1/../bin/lava-test-case   =


  * baseline-nfs.bootrr.cros-ec-sysfs-driver-present: https://kernelci.org/=
test/case/id/63c852c5a32d0df156915f0f
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:12:31.693621  /lava-8784561/1/../bin/lava-test-case
    2023-01-18T20:12:31.715776  <8>[   34.098071] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sysfs-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-lightbar-driver-present: https://kernelci.o=
rg/test/case/id/63c852c5a32d0df156915f18
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:12:30.257863  /lava-8784561/1/../bin/lava-test-case
    2023-01-18T20:12:30.280238  <8>[   32.662261] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-lightbar-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-debugfs-driver-present: https://kernelci.or=
g/test/case/id/63c852c5a32d0df156915f21
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:12:26.771544  <8>[   29.154448] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtpm-chip-is-online RESULT=3Dskip>
    2023-01-18T20:12:27.826943  /lava-8784561/1/../bin/lava-test-case
    2023-01-18T20:12:27.848367  <8>[   30.230460] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-debugfs-driver-present RESULT=3Dfail>   =

 =20

