Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A61AC4167B
	for <webhook@archiver.kernel.org>; Tue, 28 Nov 2023 23:47:08 +0000 (UTC)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
 by mx.groups.io with SMTP id smtpd.web10.14349.1701215218914860797
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 28 Nov 2023 15:46:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=fXc2pbd4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.177, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3b83398cfc7so3733459b6e.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 28 Nov 2023 15:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701215218; x=1701820018; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UNE2s3oLHAS6ZjGHa5N3Fe+2F+MwIBSxPr2kyAiwHaY=;
        b=fXc2pbd4Id0pVat3oWX3mW/JaqIEbLzSijIibje6/edDjMODIur+AnqnMbAjspO+ak
         qasvrfLmWRkPOrTbttOqp03miYtUmqtsh2sri2lbyoWQXnO4ZcgIOHdpcU3mkKkA6qSs
         2AD5UA/QQxvf4DS5vLatjXSLN6YVIZnrmqeXFjk9w1dJxJLY57/Fg/gFT4NuXeXGiNvG
         UjRvAFpybb3YBMt7zRdy7FJxTuYWytsoi1NbVuURWNorS/qyDM8CpCgDU37lKiWoPrfx
         Mk36Nbv1WA+cGd0mUVa2dxzD9kbJw7dcogeu1DEfa4nPAUHWd+Fsf6rwqCPLHT9qC+v5
         gLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701215218; x=1701820018;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UNE2s3oLHAS6ZjGHa5N3Fe+2F+MwIBSxPr2kyAiwHaY=;
        b=HuwAFTtDNCCmjDrB5tLlzWA8DE3cRIIwymxZxxw7bvC/Z+SZ/shyPfuBk1/IDxG7Rf
         SxKAGMruHGUTHp4VO+einngi3zh0pgJ3P2D/IAl93qQnbewhLDOozNXz75RSF5ckcKxf
         5TMvzbmSFlH4J36/KXMTnNBiJvHN38BgN9CLp2NES4kmNDh/yXqkRh8K2IGOgKgoo0hs
         HapzZpeHAOQfx11Lrut7U34sNOkG1EBCnmKJ3c71950MtVNzGOq8jT9hhXJidb6dcsTa
         3Fu1jUMwCa8n5hvn4oQoQFaGkv/s3R/rYQgbNRTyM8IkZyO4XpZkapd3d0YqQQiTEroF
         8RuA==
X-Gm-Message-State: AOJu0YxBjjdo5BKGoeiyoBaDpOGZmZZ1zcc3y5tlJ+iIsbip9+/nCgQa
	0PNP259HCcBH6Fdszt1yNukwmQzmOdQTfgG24jc=
X-Google-Smtp-Source: AGHT+IE6FnlZ5eob7kbvxI4dZa0SrRxGvVUV0k88mu92pyJvoPovUhKK0zsLZWGJDywebVrIzil9JA==
X-Received: by 2002:a05:6808:2a6e:b0:3b8:604e:48d3 with SMTP id fu14-20020a0568082a6e00b003b8604e48d3mr10944606oib.0.1701215217576;
        Tue, 28 Nov 2023 15:46:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d10-20020aa7814a000000b006cb94e20014sm9582527pfn.41.2023.11.28.15.46.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 15:46:57 -0800 (PST)
Message-ID: <65667bf1.a70a0220.474e1.9217@mx.google.com>
Date: Tue, 28 Nov 2023 15:46:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.201-cip41-197-g2d08925b44e52
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 90 runs,
 9 regressions (v5.10.201-cip41-197-g2d08925b44e52)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Nov 2023 23:47:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13752

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 90 runs, 9 regress=
ions (v5.10.201-cip41-197-g2d08925b44e52)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
                | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
...ok+kselftest | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
...ok+kselftest | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook   | 2          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest          | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-197-g2d08925b44e52/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-197-g2d08925b44e52
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2d08925b44e52ce450bf165f843637412f9c979b =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65667575060c3545ae7e4a8a

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
broonie/baseline-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
broonie/baseline-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65667575060c3545ae7e4ac7
        failing since 26 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02)

    2023-11-28T23:18:45.729360  <8>[   40.607735] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 284385_1.6.2.4.1>
    2023-11-28T23:18:45.848104  / # #
    2023-11-28T23:18:45.950935  export SHELL=3D/bin/sh
    2023-11-28T23:18:45.951693  #
    2023-11-28T23:18:46.053579  / # export SHELL=3D/bin/sh. /lava-284385/en=
vironment
    2023-11-28T23:18:46.054387  =

    2023-11-28T23:18:46.156363  / # . /lava-284385/environment/lava-284385/=
bin/lava-test-runner /lava-284385/1
    2023-11-28T23:18:46.157668  =

    2023-11-28T23:18:46.177047  / # /lava-284385/bin/lava-test-runner /lava=
-284385/1
    2023-11-28T23:18:46.341878  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65666fe559141b96bf7e4ad5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65666fe559141b96b=
f7e4ad6
        failing since 124 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65667228329092ca667e4a7b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65667228329092ca6=
67e4a7c
        failing since 109 days (last pass: v5.10.186-cip37-566-g36076316ef0=
49, first fail: v5.10.186-cip37-770-gddd36cfc4c4c8) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/656673893b77bb3bdd7e4a6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/656673893b77bb3bd=
d7e4a6e
        failing since 124 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6566706036bce2a35a7e4a6f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6566706036bce2a35=
a7e4a70
        new failure (last pass: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/656670958282134b867e4a6d

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/656670958282134b867e4a77
        failing since 222 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-11-28T22:58:10.184149  /lava-12110174/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/656670958282134b867e4ac5
        failing since 222 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-11-28T22:58:10.223289  <8>[   96.651105] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-11-28T22:58:11.279098  /lava-12110174/1/../bin/lava-test-case
   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65666d7b3af8f60a827e4a8e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+kselftest/g=
cc-10/lab-collabora/baseline-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+kselftest/g=
cc-10/lab-collabora/baseline-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65666d7b3af8f60a827e4a97
        failing since 26 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02)

    2023-11-28T22:44:55.714418  #

    2023-11-28T22:44:56.975047  / # #export SHELL=3D/bin/sh

    2023-11-28T22:44:56.986042  =


    2023-11-28T22:44:56.986520  / # export SHELL=3D/bin/sh

    2023-11-28T22:44:58.730609  . /lava-12110079/environment

    2023-11-28T22:44:58.741571  / # . /lava-12110079/environment

    2023-11-28T22:45:01.936452  /lava-12110079/bin/lava-test-runner /lava-1=
2110079/1

    2023-11-28T22:45:01.951964  / # /lava-12110079/bin/lava-test-runner /la=
va-12110079/1

    2023-11-28T22:45:02.388448  + export TESTRUN_ID=3D1_bootrr

    2023-11-28T22:45:02.388960  + cd /lava-12110079/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6566730213236b031e7e4acc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
collabora/baseline-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
collabora/baseline-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6566730213236b031e7e4ad5
        failing since 26 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02)

    2023-11-28T23:08:59.517138  / # #

    2023-11-28T23:09:00.777803  export SHELL=3D/bin/sh

    2023-11-28T23:09:00.788739  #

    2023-11-28T23:09:00.789170  / # export SHELL=3D/bin/sh

    2023-11-28T23:09:02.530398  / # . /lava-12110245/environment

    2023-11-28T23:09:05.728872  /lava-12110245/bin/lava-test-runner /lava-1=
2110245/1

    2023-11-28T23:09:05.740281  . /lava-12110245/environment

    2023-11-28T23:09:05.740614  / # /lava-12110245/bin/lava-test-runner /la=
va-12110245/1

    2023-11-28T23:09:05.909503  + export TESTRUN_ID=3D1_bootrr

    2023-11-28T23:09:05.909933  + cd /lava-12110245/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =20

