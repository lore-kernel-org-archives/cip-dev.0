Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64AFE7B5FB
	for <webhook@archiver.kernel.org>; Wed,  4 Oct 2023 11:53:00 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web11.16288.1696420378590666839
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 04 Oct 2023 04:52:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=0VF5Q+Vd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-690bccb0d8aso1548933b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 04 Oct 2023 04:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696420377; x=1697025177; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xPhjD1cOCbNXJtVM8FHDpPvxkj+6WYG3+BRKM2EnHvc=;
        b=0VF5Q+Vd0N1/Ne1ftPsHfpA9JL/qwVfflNAqEokZ4Z7I/hVYb7O/Ya3oHr8+UvOjiF
         cORMPJCZv80sq1bFSor5Xfp8BU9bCGSYsPPZa/SgWIe/N7s0jokgdcZ/ZuDaxd2zWXl5
         M6rFSP+K96P9PBi1mF9jsyao8/NP5tGJAFogUCrEOoWmeJRGN0Z+EE24M7ITP1OpXs3L
         D/2jEgT58LkJzatB73normFnYQvO7/VmjOP8x/mqQY0QuWjtftK79QJqElG+Tql+oq7x
         hTX4YPS9cyLS/CSNgr3toeDZRi27JsSwY2wZLTOeyWzdxd8ZlbdduljyAdyJhTT2Nj0j
         VQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696420377; x=1697025177;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xPhjD1cOCbNXJtVM8FHDpPvxkj+6WYG3+BRKM2EnHvc=;
        b=QNwK57gnazFsBusEXsAGDZYNEndwK2SrxCHalYiQbygGCK+XDg0eDPPgVk8E/wBED4
         QAbWsIQRWt18+aSwCeR80TAJe87vv3I9caHQO8KQszJ5RIj/UaozryI/+/Ra/tUDho47
         UtSSFn0eGGVBSiZCBupABYZ0ylQqX+b3jNLvFUqjFMUW3hM+tBDRtWjQ5ZgdIV2nOKsC
         5IZtkKf7oUBsz0q7HDRQqbzJ3XzzroH2SNBWZ5y3bw56JaERXw1bmaWLbCQDrO1o4kpL
         lfLgY+W/xf/V5UnmV9jKHYtqpsp4RrAq3gYhLZxPEZKDDXtGq+5FJoZmvASwxEu2YOyM
         NQsg==
X-Gm-Message-State: AOJu0YzUaLROJjJ6XAqnxfRCnlH53r9j39Ybl3xf3BLEZqs8i5nKSWuj
	4NvnPYeyH28vP/RZWQEpvIhEMajhL+Q2PMsJbN9bCg==
X-Google-Smtp-Source: AGHT+IHqBCh0g2o7oG7Jy9WKW3/Vdewy1jPb9KIVDjanoQrZdPntzgww/Ha12aTsDDzF4l75D9v5lw==
X-Received: by 2002:a05:6a21:4847:b0:153:d71f:cd23 with SMTP id au7-20020a056a21484700b00153d71fcd23mr1679888pzc.26.1696420377081;
        Wed, 04 Oct 2023 04:52:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902788300b001ae0a4b1d3fsm3500513pll.153.2023.10.04.04.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 04:52:56 -0700 (PDT)
Message-ID: <651d5218.170a0220.ca8fb.8da4@mx.google.com>
Date: Wed, 04 Oct 2023 04:52:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.194-cip39-1-g53e59f50ca3ff
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-nfs: 56 runs,
 19 regressions (v5.10.194-cip39-1-g53e59f50ca3ff)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Oct 2023 11:53:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13277

cip/linux-5.10.y-cip baseline-nfs: 56 runs, 19 regressions (v5.10.194-cip39=
-1-g53e59f50ca3ff)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | cip://5.=
10.y-...64_defconfig | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g+kselftest          | 1          =

kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g+kselftest          | 1          =

meson-g12b-a311d-khadas-vim3 | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.194-cip39-1-g53e59f50ca3ff/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.194-cip39-1-g53e59f50ca3ff
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      53e59f50ca3ff023b612a48397ad7e057a9fd408 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4ae17a35402b538a0a50

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/651d4ae17a35402b538a0a59
        failing since 263 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-10-04T11:21:47.909847  <8>[   18.777020] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11676168_1.5.2.3.1>

    2023-10-04T11:21:47.913048  + set +x

    2023-10-04T11:21:48.017000  / # #

    2023-10-04T11:21:48.117635  export SHELL=3D/bin/sh

    2023-10-04T11:21:48.117828  #

    2023-10-04T11:21:48.218357  / # export SHELL=3D/bin/sh. /lava-11676168/=
environment

    2023-10-04T11:21:48.218543  =


    2023-10-04T11:21:48.319057  / # . /lava-11676168/environment/lava-11676=
168/bin/lava-test-runner /lava-11676168/1

    2023-10-04T11:21:48.319414  =


    2023-10-04T11:21:48.324464  / # /lava-11676168/bin/lava-test-runner /la=
va-11676168/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4b04d9897b5a2b8a0a43

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/651d4b04d9897b5a2b8a0a4c
        failing since 173 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-10-04T11:23:54.236213  + <8>[   19.897015] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11676237_1.5.2.3.1>

    2023-10-04T11:23:54.236299  set +x

    2023-10-04T11:23:54.340825  / # #

    2023-10-04T11:23:54.441398  export SHELL=3D/bin/sh

    2023-10-04T11:23:54.441607  #

    2023-10-04T11:23:54.542142  / # export SHELL=3D/bin/sh. /lava-11676237/=
environment

    2023-10-04T11:23:54.542369  =


    2023-10-04T11:23:54.642909  / # . /lava-11676237/environment/lava-11676=
237/bin/lava-test-runner /lava-11676237/1

    2023-10-04T11:23:54.643181  =


    2023-10-04T11:23:54.647562  / # /lava-11676237/bin/lava-test-runner /la=
va-11676237/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4b00e916551ad18a0a7d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/651d4b00e916551ad18a0a86
        failing since 173 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-10-04T11:22:20.145537  + set +x

    2023-10-04T11:22:20.152443  <8>[   16.203778] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11676210_1.5.2.3.1>

    2023-10-04T11:22:20.257191  / # #

    2023-10-04T11:22:20.357899  export SHELL=3D/bin/sh

    2023-10-04T11:22:20.358096  #

    2023-10-04T11:22:20.458586  / # export SHELL=3D/bin/sh. /lava-11676210/=
environment

    2023-10-04T11:22:20.458775  =


    2023-10-04T11:22:20.559363  / # . /lava-11676210/environment/lava-11676=
210/bin/lava-test-runner /lava-11676210/1

    2023-10-04T11:22:20.559695  =


    2023-10-04T11:22:20.564899  / # /lava-11676210/bin/lava-test-runner /la=
va-11676210/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/651d48e3d0ffcb37ba8a0a48

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/651d48e3d0ffcb37ba8a0a51
        failing since 263 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-10-04T11:15:47.366314  / # #

    2023-10-04T11:15:47.468326  export SHELL=3D/bin/sh

    2023-10-04T11:15:47.469002  #

    2023-10-04T11:15:47.570454  / # export SHELL=3D/bin/sh. /lava-11676070/=
environment

    2023-10-04T11:15:47.571098  =


    2023-10-04T11:15:47.672670  / # . /lava-11676070/environment/lava-11676=
070/bin/lava-test-runner /lava-11676070/1

    2023-10-04T11:15:47.673827  =


    2023-10-04T11:15:47.674677  / # /lava-11676070/bin/lava-test-runner /la=
va-11676070/1

    2023-10-04T11:15:47.828509  + export TESTRUN_ID=3D1_bootrr

    2023-10-04T11:15:47.828930  + cd /lava-11676070/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | cip://5.=
10.y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/651d51bf7cdad3e0188a0a42

  Results:     47 PASS, 13 FAIL, 1 SKIP
  Full config: cip://5.10.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/g=
cc-10/lab-broonie/baseline-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/g=
cc-10/lab-broonie/baseline-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/651d51bf7cdad3e0188a0a78
        new failure (last pass: v5.10.184-cip36-8-gb192df20e8c9)

    2023-10-04T11:51:00.870497  <8>[   44.293849] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 152346_1.6.2.4.1>
    2023-10-04T11:51:00.989136  / # #
    2023-10-04T11:51:01.091584  export SHELL=3D/bin/sh
    2023-10-04T11:51:01.092385  #
    2023-10-04T11:51:01.194176  / # export SHELL=3D/bin/sh. /lava-152346/en=
vironment
    2023-10-04T11:51:01.194986  =

    2023-10-04T11:51:01.296902  / # . /lava-152346/environment/lava-152346/=
bin/lava-test-runner /lava-152346/1
    2023-10-04T11:51:01.298245  =

    2023-10-04T11:51:01.302281  / # /lava-152346/bin/lava-test-runner /lava=
-152346/1
    2023-10-04T11:51:01.458045  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4e3a4fdcdea3378a0a44

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-jun=
o-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-jun=
o-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/651d4e3a4fdcdea3378a0a83
        new failure (last pass: v5.10.184-cip36)

    2023-10-04T11:35:51.802903  <8>[   43.944529] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 152217_1.6.2.4.1>
    2023-10-04T11:35:51.921592  / # #
    2023-10-04T11:35:52.024332  export SHELL=3D/bin/sh
    2023-10-04T11:35:52.025080  #
    2023-10-04T11:35:52.126716  / # export SHELL=3D/bin/sh. /lava-152217/en=
vironment
    2023-10-04T11:35:52.127503  =

    2023-10-04T11:35:52.229601  / # . /lava-152217/environment/lava-152217/=
bin/lava-test-runner /lava-152217/1
    2023-10-04T11:35:52.230944  =

    2023-10-04T11:35:52.250721  / # /lava-152217/bin/lava-test-runner /lava=
-152217/1
    2023-10-04T11:35:52.421429  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d5057f748c5e3068a0a4a

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/651d5057f748c5e3068a0a89
        new failure (last pass: v5.10.184-cip36)

    2023-10-04T11:44:49.213369  <8>[   52.034732] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 152305_1.6.2.4.1>
    2023-10-04T11:44:49.332205  / # #
    2023-10-04T11:44:49.435037  export SHELL=3D/bin/sh
    2023-10-04T11:44:49.435811  #
    2023-10-04T11:44:49.537709  / # export SHELL=3D/bin/sh. /lava-152305/en=
vironment
    2023-10-04T11:44:49.538562  =

    2023-10-04T11:44:49.640551  / # . /lava-152305/environment/lava-152305/=
bin/lava-test-runner /lava-152305/1
    2023-10-04T11:44:49.641912  =

    2023-10-04T11:44:49.661099  / # /lava-152305/bin/lava-test-runner /lava=
-152305/1
    2023-10-04T11:44:50.066642  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4c379c859b9c328a0bbd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-kontron/baseli=
ne-nfs-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-kontron/baseli=
ne-nfs-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/651d4c379c859b9c3=
28a0bbe
        new failure (last pass: v5.10.184-cip36) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4be71bceca742d8a0a87

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-kontron/baseli=
ne-nfs-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-kontron/baseli=
ne-nfs-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/651d4be71bceca742=
d8a0a88
        new failure (last pass: v5.10.184-cip36) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4a492ee74bcd538a0ad8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-collabora/base=
line-nfs-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-collabora/base=
line-nfs-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/651d4a492ee74bcd5=
38a0ad9
        new failure (last pass: v5.10.194-cip39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4b0fdef6e450b48a0a54

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/651d4b0fdef6e450b=
48a0a55
        failing since 20 days (last pass: v5.10.191-cip38-17-g8dad6b499cfe5=
, first fail: v5.10.191-cip38-29-g9e1aa2001db8) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4946336ceb7b7f8a0a66

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a=
1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a=
1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/651d4946336ceb7b7=
f8a0a67
        new failure (last pass: v5.10.194-cip39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/651d4a6d54dadb954c8a0bcc

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/651d4a6d54dadb954c8a0bd6
        failing since 196 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-10-04T11:19:51.075532  /lava-11676132/1/../bin/lava-test-case

    2023-10-04T11:19:51.106477  <8>[   97.241665] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/651d4a6d54dadb954c8a0bd7
        failing since 196 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-10-04T11:19:49.992869  /lava-11676132/1/../bin/lava-test-case

    2023-10-04T11:19:50.025079  <8>[   96.160112] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651d48121c22e57ae48a0a4e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-r=
k3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-r=
k3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/651d48121c22e57ae48a0a57
        new failure (last pass: v5.10.184-cip36)

    2023-10-04T11:09:44.389463  / # #

    2023-10-04T11:09:45.650292  export SHELL=3D/bin/sh

    2023-10-04T11:09:45.661241  #

    2023-10-04T11:09:45.661704  / # export SHELL=3D/bin/sh

    2023-10-04T11:09:47.405547  / # . /lava-11676042/environment

    2023-10-04T11:09:50.606873  /lava-11676042/bin/lava-test-runner /lava-1=
1676042/1

    2023-10-04T11:09:50.618280  . /lava-11676042/environment

    2023-10-04T11:09:50.618636  / # /lava-11676042/bin/lava-test-runner /la=
va-11676042/1

    2023-10-04T11:09:50.790495  + export TESTRUN_ID=3D1_bootrr

    2023-10-04T11:09:50.790591  + cd /lava-11676042/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d499ca0d702a07a8a0a5e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-collabora/base=
line-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-collabora/base=
line-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/651d499ca0d702a07a8a0a67
        new failure (last pass: v5.10.184-cip36)

    2023-10-04T11:16:33.430417  / # #

    2023-10-04T11:16:34.691157  export SHELL=3D/bin/sh

    2023-10-04T11:16:34.702086  #

    2023-10-04T11:16:34.702539  / # export SHELL=3D/bin/sh

    2023-10-04T11:16:36.445861  . /lava-11676088/environment

    2023-10-04T11:16:36.456754  / # . /lava-11676088/environment

    2023-10-04T11:16:39.650504  /lava-11676088/bin/lava-test-runner /lava-1=
1676088/1

    2023-10-04T11:16:39.663026  / # /lava-11676088/bin/lava-test-runner /la=
va-11676088/1

    2023-10-04T11:16:39.949468  + export TESTRUN_ID=3D1_bootrr

    2023-10-04T11:16:39.949874  + cd /lava-11676088/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/651d48934418a886528a0a51

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun=
50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun=
50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/651d48934418a886528a0a81
        failing since 263 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-10-04T11:11:52.368803  + set +x
    2023-10-04T11:11:52.372824  <8>[   37.970459] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 152203_1.6.2.4.1>
    2023-10-04T11:11:52.506034  / # #
    2023-10-04T11:11:52.609279  export SHELL=3D/bin/sh
    2023-10-04T11:11:52.609998  #
    2023-10-04T11:11:52.712072  / # export SHELL=3D/bin/sh. /lava-152203/en=
vironment
    2023-10-04T11:11:52.712827  =

    2023-10-04T11:11:52.814831  / # . /lava-152203/environment/lava-152203/=
bin/lava-test-runner /lava-152203/1
    2023-10-04T11:11:52.816084  =

    2023-10-04T11:11:52.819982  / # /lava-152203/bin/lava-test-runner /lava=
-152203/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4d2f15226347c98a0a72

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-nfs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-nfs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/651d4d2f15226347c=
98a0a73
        new failure (last pass: v5.10.184-cip36) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4afe089338f7318a0ab1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-nfs-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-nfs-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/651d4afe089338f73=
18a0ab2
        new failure (last pass: v5.10.184-cip36) =

 =20

