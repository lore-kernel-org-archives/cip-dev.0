Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3569C001B0
	for <webhook@archiver.kernel.org>; Wed, 19 Jul 2023 13:21:56 +0000 (UTC)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
 by mx.groups.io with SMTP id smtpd.web11.13532.1689772914563119868
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 19 Jul 2023 06:21:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Y5P37UTY;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.174, mailfrom: bot@kernelci.org)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-34884a8f285so20595795ab.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 19 Jul 2023 06:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689772913; x=1692364913;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sBq99QCMbccsJsJc/OZ7LdnibG2ft8GxOffaSK7+Z4I=;
        b=Y5P37UTYQggV/aSbx++lGhKOAPa6ucFzDUqZJPyj2wzrBEChO/8yZnz7sojzGhb9i5
         uow5SoR13LzucdO6uHn1wfDh1ADC8TQTfo7qSsoJ7ZVXD/jHotxI8WGPn3kh3cRlekcd
         TY4EP1jKJgoDn+3Tm5HDk4lPpTTZ+B0BXbQ85NZxBaj2w3oerUJw5pFD/e9VYskiLEyP
         9IqSGX1J6AH2gyEullqxjcp6joJcCTRkcg/KiPm9qTdZQ5iEAVNCMsZmOY5cL3HZI5da
         NNzPOw1umZoAnPL80YHHry/q9DStfH4nlDwVYZc2CSZGVjjZ8M6+AfCC/AhIUpes4gsu
         166g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689772913; x=1692364913;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sBq99QCMbccsJsJc/OZ7LdnibG2ft8GxOffaSK7+Z4I=;
        b=Pa42G3v0qPS+YLUvQHqNa8m1G+0hV+orZNwM4SU5eBD2MCuQvenRteKxFevViH5Byd
         4KrYzplo2ZA4ovC2ZxZwobzYrdFjJAuixB1ooepYvQmvmgi9gKXS2JTlcpN73/mTT+8R
         BBuNm5sGnDNmXWefUeQL4ON8HLppBE6qw+Y52saWiOTb6orHKFnnqn4jwjl+9FYgjnZ0
         0Ygl+ocj/IxEV+j6m7VotiSZB0HRddzbK/WGEwU5V1YT2t/s7S/CQIrfRWJnzZwnmpby
         5mr+BQ/Uv72dJOZzUUgiUQHt91Pak2deZFoXpkAEj5Nwh7i6QPuUji6/18ERAYUap5gI
         ZjNw==
X-Gm-Message-State: ABy/qLYLa+yIb7jPwp3seXH2VelvrTVgEmVGdB1L5AjyFahZ70d9Uqf0
	y6Uasezs6EBPZSADaqe22/s8/8U8tjhEYEunAAgw4A==
X-Google-Smtp-Source: APBJJlFcSVIf1ANU4SNY/GVyyGqA4iDeUcnZztKniWYrHuqGGZ0tUGOAAKfbeJqOEdqvz88bRnCmCw==
X-Received: by 2002:a05:6e02:1d9d:b0:346:11d8:b862 with SMTP id h29-20020a056e021d9d00b0034611d8b862mr6926223ila.9.1689772913127;
        Wed, 19 Jul 2023 06:21:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a16-20020a1709027d9000b001b8c3c7b102sm3943508plm.127.2023.07.19.06.21.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 06:21:52 -0700 (PDT)
Message-ID: <64b7e370.170a0220.b5332.82ad@mx.google.com>
Date: Wed, 19 Jul 2023 06:21:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.38-cip1-10-g02aa22be941dd
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 15 runs,
 7 regressions (v6.1.38-cip1-10-g02aa22be941dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jul 2023 13:21:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12428

cip-gitlab/ci/pavel/linux-test baseline-nfs: 15 runs, 7 regressions (v6.1.3=
8-cip1-10-g02aa22be941dd)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.38-cip1-10-g02aa22be941dd/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.38-cip1-10-g02aa22be941dd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      02aa22be941dd7a72690f834f897a77275f9f6a5 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7d00ba1213fa4808ace49

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b7d00ba1213fa4808ace4e
        new failure (last pass: v5.10.184-cip36-13-g8201543bbc8b6)

    2023-07-19T11:59:29.086671  + set +x

    2023-07-19T11:59:29.092871  [   17.980134] <LAVA_SIGNAL_ENDRUN 0_dmesg =
11111622_1.5.2.3.1>

    2023-07-19T11:59:29.198409  #

    2023-07-19T11:59:29.299101  / # #export SHELL=3D/bin/sh

    2023-07-19T11:59:29.299248  =


    2023-07-19T11:59:29.399749  / # export SHELL=3D/bin/sh. /lava-11111622/=
environment

    2023-07-19T11:59:29.399924  =


    2023-07-19T11:59:29.500387  / # . /lava-11111622/environment/lava-11111=
622/bin/lava-test-runner /lava-11111622/1

    2023-07-19T11:59:29.500626  =


    2023-07-19T11:59:29.506587  / # /lava-11111622/bin/lava-test-runner /la=
va-11111622/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7d013a1213fa4808ace8f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b7d013a1213fa4808ace94
        new failure (last pass: v5.10.184-cip36-13-g8201543bbc8b6)

    2023-07-19T11:59:05.526929  [   16.972133] <LAVA_SIGNAL_ENDRUN 0_dmesg =
11111632_1.5.2.3.1>

    2023-07-19T11:59:05.530693  + set +x

    2023-07-19T11:59:05.642849  / # #

    2023-07-19T11:59:05.745160  export SHELL=3D/bin/sh

    2023-07-19T11:59:05.745902  #

    2023-07-19T11:59:05.847353  / # export SHELL=3D/bin/sh. /lava-11111632/=
environment

    2023-07-19T11:59:05.848106  =


    2023-07-19T11:59:05.949542  / # . /lava-11111632/environment/lava-11111=
632/bin/lava-test-runner /lava-11111632/1

    2023-07-19T11:59:05.950668  =


    2023-07-19T11:59:05.955963  / # /lava-11111632/bin/lava-test-runner /la=
va-11111632/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7da224023a146e78ace2b

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/omap2plus_defconfig/gcc-10/lab-broonie/=
baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/omap2plus_defconfig/gcc-10/lab-broonie/=
baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b7da224023a146e78ace61
        failing since 35 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-19T12:41:47.146298  [   44.999521] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1180_1.6.2.4.1>
    2023-07-19T12:41:47.273458  / # #
    2023-07-19T12:41:47.376522  export SHELL=3D/bin/sh
    2023-07-19T12:41:47.377429  #
    2023-07-19T12:41:47.479312  / # export SHELL=3D/bin/sh. /lava-1180/envi=
ronment
    2023-07-19T12:41:47.480178  =

    2023-07-19T12:41:47.582241  / # . /lava-1180/environment/lava-1180/bin/=
lava-test-runner /lava-1180/1
    2023-07-19T12:41:47.583769  =

    2023-07-19T12:41:47.588168  / # /lava-1180/bin/lava-test-runner /lava-1=
180/1
    2023-07-19T12:41:47.885424  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7da696e74181c958ace26

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/omap2plus_defconfig/gcc-10/lab-cip/base=
line-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/omap2plus_defconfig/gcc-10/lab-cip/base=
line-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b7da696e74181c958ace29
        failing since 35 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-19T12:43:00.299835  + set +x
    2023-07-19T12:43:00.301525  [   40.780439] <LAVA_SIGNAL_ENDRUN 0_dmesg =
987424_1.6.2.4.1>
    2023-07-19T12:43:00.420330  #
    2023-07-19T12:43:00.522464  / # #export SHELL=3D/bin/sh
    2023-07-19T12:43:00.522917  =

    2023-07-19T12:43:00.624339  / # export SHELL=3D/bin/sh. /lava-987424/en=
vironment
    2023-07-19T12:43:00.624805  =

    2023-07-19T12:43:00.726267  / # . /lava-987424/environment/lava-987424/=
bin/lava-test-runner /lava-987424/1
    2023-07-19T12:43:00.727178  =

    2023-07-19T12:43:00.729290  / # /lava-987424/bin/lava-test-runner /lava=
-987424/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7d004aa6392161f8ace44

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b7d004aa6392161f8ace49
        failing since 34 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-19T11:58:40.366197  + [   18.059866] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 11111617_1.5.2.3.1>

    2023-07-19T11:58:40.369528  set +x

    2023-07-19T11:58:40.474419  / # #

    2023-07-19T11:58:40.575018  export SHELL=3D/bin/sh

    2023-07-19T11:58:40.575192  #

    2023-07-19T11:58:40.675757  / # export SHELL=3D/bin/sh. /lava-11111617/=
environment

    2023-07-19T11:58:40.675919  =


    2023-07-19T11:58:40.776412  / # . /lava-11111617/environment/lava-11111=
617/bin/lava-test-runner /lava-11111617/1

    2023-07-19T11:58:40.776737  =


    2023-07-19T11:58:40.781059  / # /lava-11111617/bin/lava-test-runner /la=
va-11111617/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7cff6d171af63e58ace4a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b7cff6d171af63e58ace4f
        failing since 34 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-19T11:58:38.252003  + set +x

    2023-07-19T11:58:38.258968  [   16.941270] <LAVA_SIGNAL_ENDRUN 0_dmesg =
11111588_1.5.2.3.1>

    2023-07-19T11:58:38.362933  / # #

    2023-07-19T11:58:38.463696  export SHELL=3D/bin/sh

    2023-07-19T11:58:38.463889  #

    2023-07-19T11:58:38.564411  / # export SHELL=3D/bin/sh. /lava-11111588/=
environment

    2023-07-19T11:58:38.564618  =


    2023-07-19T11:58:38.665146  / # . /lava-11111588/environment/lava-11111=
588/bin/lava-test-runner /lava-11111588/1

    2023-07-19T11:58:38.665441  =


    2023-07-19T11:58:38.670225  / # /lava-11111588/bin/lava-test-runner /la=
va-11111588/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64b7d28f08faf33a0c8ace1c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-10-g02aa22be941dd/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64b7d28f08faf33a0=
c8ace1d
        failing since 7 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.184-cip36-13-g8201543bbc8b6) =

 =20

