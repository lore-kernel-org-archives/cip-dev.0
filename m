Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EABC38142
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 04:30:58 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web10.38193.1674102657450255727
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 20:30:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Wij0jm7u;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id z3so593524pfb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 20:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F1Ld0AeXE1GAXOYLTRamDzfZdSkkmu5rUwNyFPmUyJg=;
        b=Wij0jm7ugw/lmPZaxbNakJ9Durk9mRky+Rw2f+o4m/UqPZNQsvlVVqQ+e/ysaZOnHh
         1nBA3bGejqbZ62rzo+uoDNO2Wpv1ILmYyS/2ZuBWW9wxMfXv5Bpivhr211NRo8pz1H73
         ZIsDaG/3HHhUEc78llKfa+op5t8AyWb5uf6F+uYjoJib5/T6xdLw4g8oWyyF3IuBqtzY
         hC5JKUXHq6iBYywZizBqt1x2Yofs1LLbfCrGgPCTGZoA3a4jpN3CFJUGqKBWQXR4bX1Y
         ZirwgDSTuLmBqvJzpp7Bioic+Ffbkx3kYolsrql4xWKm1S7u21lW3tHtjv304n5QrcCO
         b37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1Ld0AeXE1GAXOYLTRamDzfZdSkkmu5rUwNyFPmUyJg=;
        b=Suac7EUf052IvUiMp2ezQB1sTB5joqWNd3CJVm+GaSGImZqn8wgumRCLW8FWpVM7yx
         POzDbmwRhIhmqbJKiAeZRShnqHu0KjjPemCiWtJPexwZeyTaaRUb5tBzylOeoJw/g2ry
         hkdKuMnaDRSApwLBXQ2E764gR72PZjMlk66Wc2zP/ovtfQBflAm7m8ua/XnrHdik190N
         /4RCKSIb99cwvfqSHeq4jdImDmhdKvbaKKtoRO75MmxET5n6Om9g4O3KR85Owng2Znj+
         VE9x56ScpUeekxAnkIgy+FzDfsXN04I/KJB5GhAho690i4QJ4arPRVuIXQl/nzMpwtfr
         jibQ==
X-Gm-Message-State: AFqh2kpcHrZdTQ40K8vn7JJTHUnGXbjFbVqTDdMuIJyPD2+htiNmSZM2
	3N+J6L+Fq1Uq0KaumUlSZENYtsUVmQBSQ7c30TrRlQ==
X-Google-Smtp-Source: AMrXdXvn66ZTd54Om45arTkrw2COjtS+BkF2e/w7XthFdLdQu4FOYnUZ5dNDOSmhdGN+ZlWf0s5p6Q==
X-Received: by 2002:a05:6a00:1585:b0:578:8864:b25c with SMTP id u5-20020a056a00158500b005788864b25cmr12637983pfk.25.1674102656024;
        Wed, 18 Jan 2023 20:30:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f127-20020a623885000000b00588cb819473sm18556543pfa.39.2023.01.18.20.30.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 20:30:55 -0800 (PST)
Message-ID: <63c8c77f.620a0220.d6ea5.eefa@mx.google.com>
Date: Wed, 18 Jan 2023 20:30:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.269-cip88-rt28-rebase
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 31 runs,
 22 regressions (v4.19.269-cip88-rt28-rebase)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 04:30:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10423

cip-gitlab/ci/pavel/linux-test baseline-nfs: 31 runs, 22 regressions (v4.19=
.269-cip88-rt28-rebase)

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
nux-test/kernel/v4.19.269-cip88-rt28-rebase/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.269-cip88-rt28-rebase
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      09932a66d6b63564f8b94b34721b1f2d38ea9575 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b74fe2ad0be7f0915ecf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63c8b74fe2ad0be7f=
0915ed0
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b7b057e0a0b0f7915f3a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c8b7b057e0a0b0f7915f3f
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:23:16.320077  + set +x
    2023-01-19T03:23:16.326435  <8>[   14.190812] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8789745_1.5.2.3.1>
    2023-01-19T03:23:16.435127  / # #
    2023-01-19T03:23:16.537964  export SHELL=3D/bin/sh
    2023-01-19T03:23:16.538919  #
    2023-01-19T03:23:16.640788  / # export SHELL=3D/bin/sh. /lava-8789745/e=
nvironment
    2023-01-19T03:23:16.641665  =

    2023-01-19T03:23:16.743390  / # . /lava-8789745/environment/lava-878974=
5/bin/lava-test-runner /lava-8789745/1
    2023-01-19T03:23:16.744601  =

    2023-01-19T03:23:16.749309  / # /lava-8789745/bin/lava-test-runner /lav=
a-8789745/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b8b0db7519e05f915ed9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63c8b8b0db7519e05=
f915eda
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b7c1b10dfab01d915eba

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c8b7c1b10dfab01d915ebf
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:23:34.057302  + <8>[   21.580589] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 8789674_1.5.2.3.1>
    2023-01-19T03:23:34.057400  set +x
    2023-01-19T03:23:34.162345  / # #
    2023-01-19T03:23:34.263413  export SHELL=3D/bin/sh
    2023-01-19T03:23:34.263659  #
    2023-01-19T03:23:34.364626  / # export SHELL=3D/bin/sh. /lava-8789674/e=
nvironment
    2023-01-19T03:23:34.364881  =

    2023-01-19T03:23:34.465856  / # . /lava-8789674/environment/lava-878967=
4/bin/lava-test-runner /lava-8789674/1
    2023-01-19T03:23:34.466201  =

    2023-01-19T03:23:34.471818  / # /lava-8789674/bin/lava-test-runner /lav=
a-8789674/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b73a69ec0d20bb915ebf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63c8b73a69ec0d20b=
b915ec0
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/63c8b952f6c23919b8915eb9

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c8b952f6c23919b8915ebe
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:29:42.242951  <8>[   56.767502] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 140262_1.6.2.4.1>
    2023-01-19T03:29:42.541942  / # #
    2023-01-19T03:29:42.675993  export SHELL=3D/bin/sh
    2023-01-19T03:29:42.687758  #
    2023-01-19T03:29:42.797320  / # export SHELL=3D/bin/sh. /lava-140262/en=
vironment
    2023-01-19T03:29:42.802331  =

    2023-01-19T03:29:42.912617  / # . /lava-140262/environment/lava-140262/=
bin/lava-test-runner /lava-140262/1
    2023-01-19T03:29:42.922524  =

    2023-01-19T03:29:42.926934  / # /lava-140262/bin/lava-test-runner /lava=
-140262/1
    2023-01-19T03:29:43.365709  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/63c8b952f6c2=
3919b8915ec2
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)
        1 lines

    2023-01-19T03:29:31.490130  / # =

    2023-01-19T03:29:31.504196  =

    2023-01-19T03:29:36.659260  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/140262/extract-nfsrootfs-lauef85k'
    2023-01-19T03:29:36.677149  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/140262/extract-nfsrootfs-lauef85k'
    2023-01-19T03:29:39.028754  / # export NFS_SERVER_IP=3D'192.168.56.123'
    2023-01-19T03:29:39.044778  export NFS_SERVER_IP=3D'192.168.56.123'
    2023-01-19T03:29:39.185290  / # #
    2023-01-19T03:29:39.197703  #
    2023-01-19T03:29:39.310106  / # export SHELL=3D/bin/sh
    2023-01-19T03:29:39.322295  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/63c8b856d31a869c03915eb9

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c8b856d31a869c03915ebc
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:25:52.851769  + set +x
    2023-01-19T03:25:52.853828  <8>[   40.711600] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 828353_1.6.2.4.1>
    2023-01-19T03:25:52.966597  / # #
    2023-01-19T03:25:53.067886  export SHELL=3D/bin/sh
    2023-01-19T03:25:53.068181  #
    2023-01-19T03:25:53.169217  / # export SHELL=3D/bin/sh. /lava-828353/en=
vironment
    2023-01-19T03:25:53.169620  =

    2023-01-19T03:25:53.270615  / # . /lava-828353/environment/lava-828353/=
bin/lava-test-runner /lava-828353/1
    2023-01-19T03:25:53.271073  =

    2023-01-19T03:25:53.272530  / # /lava-828353/bin/lava-test-runner /lava=
-828353/1 =

    ... (12 line(s) more)  =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/63c8b856d31a=
869c03915ec0
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)
        1 lines

    2023-01-19T03:25:44.423614  / # =

    2023-01-19T03:25:44.440358  =

    2023-01-19T03:25:49.464540  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/828353/extract-nfsrootfs-stvouwri'
    2023-01-19T03:25:49.475255  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/828353/extract-nfsrootfs-stvouwri'
    2023-01-19T03:25:51.641464  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2023-01-19T03:25:51.651967  export NFS_SERVER_IP=3D'192.168.11.5'
    2023-01-19T03:25:51.754504  / # #
    2023-01-19T03:25:51.756471  #
    2023-01-19T03:25:51.859536  / # export SHELL=3D/bin/sh
    2023-01-19T03:25:51.861621  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b7f83c27a7eca2915eba

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/63c8b7f83c27=
a7eca2915ec3
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)
        1 lines

    2023-01-19T03:24:09.072603  / # =

    2023-01-19T03:24:09.079581  =

    2023-01-19T03:24:14.106011  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/140298/extract-nfsrootfs-c8pmfsz0'
    2023-01-19T03:24:14.116833  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/140298/extract-nfsrootfs-c8pmfsz0'
    2023-01-19T03:24:16.359533  / # export NFS_SERVER_IP=3D'192.168.56.75'
    2023-01-19T03:24:16.370143  export NFS_SERVER_IP=3D'192.168.56.75'
    2023-01-19T03:24:16.483995  / # #
    2023-01-19T03:24:16.488425  #
    2023-01-19T03:24:16.612080  / # export SHELL=3D/bin/sh
    2023-01-19T03:24:16.616697  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8bb9f26e052a25e915ec8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/63c8bb9f26e0=
52a25e915ecf
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)
        1 lines

    2023-01-19T03:39:44.831020  / # =

    2023-01-19T03:39:44.836374  =

    2023-01-19T03:39:49.852382  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/828365/extract-nfsrootfs-gev0vw9h'
    2023-01-19T03:39:49.863165  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/828365/extract-nfsrootfs-gev0vw9h'
    2023-01-19T03:39:52.036674  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2023-01-19T03:39:52.047365  export NFS_SERVER_IP=3D'192.168.11.5'
    2023-01-19T03:39:52.157535  / # #
    2023-01-19T03:39:52.160421  #
    2023-01-19T03:39:52.269811  / # export SHELL=3D/bin/sh
    2023-01-19T03:39:52.272639  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b66289c0edfca5915eef

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c8b66289c0edfca5915ef4
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:17:46.440537  / # #
    2023-01-19T03:17:46.543509  export SHELL=3D/bin/sh
    2023-01-19T03:17:46.544327  #
    2023-01-19T03:17:46.646635  / # export SHELL=3D/bin/sh. /lava-8789715/e=
nvironment
    2023-01-19T03:17:46.647460  =

    2023-01-19T03:17:46.749526  / # . /lava-8789715/environment/lava-878971=
5/bin/lava-test-runner /lava-8789715/1
    2023-01-19T03:17:46.750760  =

    2023-01-19T03:17:46.762784  / # /lava-8789715/bin/lava-test-runner /lav=
a-8789715/1
    2023-01-19T03:17:46.915014  + export TESTRUN_ID=3D1_bootrr
    2023-01-19T03:17:46.915195  + cd /lava-8789715/1/tests/1_bootrr =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b9d45906947e42915efa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-nf=
s-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-nf=
s-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63c8b9d45906947e4=
2915efb
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxm-khadas-vim2        | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b7359d9ea83669915eb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-baylibre/baseline-n=
fs-meson-gxm-khadas-vim2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-baylibre/baseline-n=
fs-meson-gxm-khadas-vim2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63c8b7359d9ea8366=
9915eba
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 7          =


  Details:     https://kernelci.org/test/plan/id/63c8b79857e0a0b0f7915ecf

  Results:     79 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rk3399-gru-sound-driver-rt5514-present: https://ker=
nelci.org/test/case/id/63c8b79857e0a0b0f7915f06
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:22:48.850378  seq: invalid floating point argument: =E2=
=80=98sound/RT5514=E2=80=99
    2023-01-19T03:22:48.853600  Try 'seq --help' for more information.
    2023-01-19T03:22:48.857725  /lava-8789812/1/../bin/lava-test-case
    2023-01-19T03:22:48.871167  [   36.746879] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3399-gru-sound-driver-rt5514-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-max98357A-present: https://=
kernelci.org/test/case/id/63c8b79857e0a0b0f7915f07
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:22:48.797567  [   36.674057] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>
    2023-01-19T03:22:48.797833  =

    2023-01-19T03:22:48.815497  seq: invalid floating point argument: =E2=
=80=98sound/MAX98357A=E2=80=99
    2023-01-19T03:22:48.818681  Try 'seq --help' for more information.
    2023-01-19T03:22:48.822259  /lava-8789812/1/../bin/lava-test-case
    2023-01-19T03:22:48.833275  [   36.709502] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3399-gru-sound-driver-max98357A-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelc=
i.org/test/case/id/63c8b79857e0a0b0f7915f08
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:22:48.778930  seq: invalid floating point argument: =E2=
=80=98sound/DP=E2=80=99
    2023-01-19T03:22:48.782356  Try 'seq --help' for more information.
    2023-01-19T03:22:48.786157  /lava-8789812/1/../bin/lava-test-case
    2023-01-19T03:22:48.786439     =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-da7219-present: https://ker=
nelci.org/test/case/id/63c8b79857e0a0b0f7915f09
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:22:48.736900  seq: invalid floating point argument: =E2=
=80=98sound/DA7219=E2=80=99
    2023-01-19T03:22:48.740334  Try 'seq --help' for more information.
    2023-01-19T03:22:48.744580  /lava-8789812/1/../bin/lava-test-case
    2023-01-19T03:22:48.755517  [   36.631428] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-sysfs-driver-present: https://kernelci.org/=
test/case/id/63c8b79857e0a0b0f7915f10
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:22:47.437919  /lava-8789812/1/../bin/lava-test-case
    2023-01-19T03:22:47.457340  [   35.334373] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-sysfs-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-lightbar-driver-present: https://kernelci.o=
rg/test/case/id/63c8b79857e0a0b0f7915f19
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:22:46.046845  /lava-8789812/1/../bin/lava-test-case   =


  * baseline-nfs.bootrr.cros-ec-debugfs-driver-present: https://kernelci.or=
g/test/case/id/63c8b79857e0a0b0f7915f22
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:22:43.320903  [   31.197157] cdn-dp fec00000.dp: Direct f=
irmware load for rockchip/dptx.bin failed with error -2
    2023-01-19T03:22:43.628603  /lava-8789812/1/../bin/lava-test-case
    2023-01-19T03:22:43.651224  [   31.527744] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-debugfs-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b88221cd82dbfa915ed5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-nf=
s-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-nf=
s-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230114.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c8b88221cd82dbfa915eda
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:26:47.648242  <8>[   26.222326] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 140308_1.6.2.4.1>
    2023-01-19T03:26:47.757634  / # #
    2023-01-19T03:26:47.859757  export SHELL=3D/bin/sh
    2023-01-19T03:26:47.860226  #
    2023-01-19T03:26:47.961782  / # export SHELL=3D/bin/sh. /lava-140308/en=
vironment
    2023-01-19T03:26:47.962239  =

    2023-01-19T03:26:48.063753  / # . /lava-140308/environment/lava-140308/=
bin/lava-test-runner /lava-140308/1
    2023-01-19T03:26:48.064631  =

    2023-01-19T03:26:48.067466  / # /lava-140308/bin/lava-test-runner /lava=
-140308/1
    2023-01-19T03:26:48.139831  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

