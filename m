Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE942C19F21
	for <webhook@archiver.kernel.org>; Thu, 28 Jul 2022 10:10:26 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web09.30883.1659003020722221786
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 28 Jul 2022 03:10:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=A1K227/Z;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.54,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f54.google.com with SMTP id
 o5-20020a17090a3d4500b001ef76490983so1677331pjf.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 28 Jul 2022 03:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=5rbX2TJp/D42CotFSNaKHakrYU5KK3OtKRZ/D1oC5ug=;
        b=A1K227/ZTdt13I+INA0djVrxFL9OfvgPSR0A+G/eiZ7Bb76thhRsz1lrFF8f6HVmmA
         p+upiq1pZmOlaePJyWBQha8ConhOetMppSRfpx9JiSlOKebTl7hPhjl/3N8yO4nzIBbv
         cJAmCiG8rvuLk8pklpLP4MAtLAaLLk/pbFwLY+8tePnxG0P7Fv4TK53sAnONra7QSEqc
         I5kQofahHeT/XZvkGTrto0aX7LUNH9j0ocuzF4T7T6Nk76cWiRdzoDn+S6HQit266Cpv
         zGoIKp6lDRLkqeskRRzS22qFj/gI2LN+JruT/jzQ+cshL2Imz9kvsqWd4FTTOMLT3YPQ
         62Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=5rbX2TJp/D42CotFSNaKHakrYU5KK3OtKRZ/D1oC5ug=;
        b=MiuqmyjxEJwF+yz4Q+68a7/W9sAk4LLvkia96kHKf8ds6mjtFrwEjxT1ZIpfT/oJXu
         LKTc6wBi6cKiGn/BUUAIGPvmwhz0DRwWukI1nErj+zufk+1mz4ZrR6DSCwIBrJ3Vd5HF
         A1I2NXOX5mqlvn03/I0jxPpoanzjWdNoeGu06knNeuvcwJ3WJ5mvA5S3Dyhcx2SpEJgr
         uYBVRGEmVtVcVLjRFcUJJ0HCEIObIZVLrNIBu6miUyDjEC09All09JfftyK1P2GIhRgn
         xcOHkjnpb5hGUEkKXmcu9EOr8KHuwfCULfENsaAwtuH8QQLcK9euxPVxA/7b/2krq8IU
         e7tQ==
X-Gm-Message-State: AJIora8As4UmjGBitDOXsDBpcPnczY+DfDbyBsJt+2yu9v0G3NVXWWGq
	HVMGIx1O1B+eupytolVXcKfmbMhSqR6XjDAXu6U=
X-Google-Smtp-Source: 
 AGRyM1slBHsQHkpkF4s8G6wTZfHGlMavENGpOLcy+C6PXklCxIz3vB2nNfmY5wR69qcIsfN10BKkDg==
X-Received: by 2002:a17:90a:62ca:b0:1f2:ef43:72a1 with SMTP id
 k10-20020a17090a62ca00b001f2ef4372a1mr9357444pjs.217.1659003019487;
        Thu, 28 Jul 2022 03:10:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 t2-20020a17090a4e4200b001f22647cb56sm3406398pjl.27.2022.07.28.03.10.17
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 03:10:18 -0700 (PDT)
Message-ID: <62e2608a.170a0220.f9edd.5653@mx.google.com>
Date: Thu, 28 Jul 2022 03:10:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-585-gc99f2b257bde
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 4 runs,
 4 regressions (v4.4-st5-585-gc99f2b257bde)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Jul 2022 10:10:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8959

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 4 runs, 4 regressions (v4.=
4-st5-585-gc99f2b257bde)

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

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-585-gc99f2b257bde/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-585-gc99f2b257bde
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c99f2b257bde3cd60a833056aab624ad5fab3812 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b25643d1bb1072daf074

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm/multi_v7_defconfig/gcc-10/lab-broonie/basel=
ine-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm/multi_v7_defconfig/gcc-10/lab-broonie/basel=
ine-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62e0b25643d1b=
b1072daf075
        failing since 76 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b6112eb9b911dcdaf066

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-=
cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-=
cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/62e0b611=
2eb9b911dcdaf069
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c)
        1 lines

    2022-07-27T03:50:17.495994  / # =

    2022-07-27T03:50:17.502867  =

    2022-07-27T03:50:22.530568  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/716784/extract-nfsrootfs-crnll4d3'
    2022-07-27T03:50:22.541542  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/716784/extract-nfsrootfs-</lib/lava/dispatcher/tmp/716784/extract-nf=
srootfs-c                         rnll4d3'
    2022-07-27T03:50:24.598452  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-07-27T03:50:24.609330  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-07-27T03:50:24.723698  / # #
    2022-07-27T03:50:24.730330  #
    2022-07-27T03:50:24.845279  / # export SHELL=3D/bin/sh
    2022-07-27T03:50:24.851841  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b782df106222eddaf056

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62e0b782df106=
222eddaf057
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b48c8fd25dce30daf07d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-cip-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-cip-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62e0b48c8fd25=
dce30daf07e
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =20

