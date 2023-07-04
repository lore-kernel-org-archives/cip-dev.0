Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E65EB64D9
	for <webhook@archiver.kernel.org>; Tue,  4 Jul 2023 06:56:07 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.53129.1688453759669718985
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 03 Jul 2023 23:55:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=g8TmRQFW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1b80b343178so29328375ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 03 Jul 2023 23:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688453758; x=1691045758;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NyscJe/zPI9KddUyzLFuwj1CzfEWsKzPQWWTyaWIYoU=;
        b=g8TmRQFWiRjWmWS9OyP75kwSfpAwZuiCrSjCkcoSAF6M+EzLRzjoc6WKOBxiSnwOSW
         tgJ7IQSVXykAVEZ2b3Smt8J8lNnF0NDDF0Oq9WIy8bDkW3AV/UcnYSsBCHJAAHIccLBj
         zPxu9NBEw9rkyLTApcYkjshpQg7TgVJLLGIJjshRERjg6NX2UPyV5JAoSHYEDXaDFnQ8
         q6JHJbOIkqPrdU9P1XTimEZqZuwUnObuWaXIuV2Doijq7Lbe6Q9Ex19GepFp25Jm8S6o
         ru4ZBfLhaHjcFTRSq3/H1kTC1DHbHBLBKi4nlXBXPcL1FH3+2DtQC0lQYJwdD8ns3719
         7dPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688453758; x=1691045758;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NyscJe/zPI9KddUyzLFuwj1CzfEWsKzPQWWTyaWIYoU=;
        b=cH27GdMVq1QN+F2HDqKTqs2/Mskt/94oGrGEQRXqB6utbgWBNa55SVxnIAOamRvdse
         ST4FqCJoq4Whfap1TWkT0NblOvYKypNnv7RjuYUHkk5XrndSODSvGGSxVzCCGchf2AzC
         BmDCOm364icLyt3JhPWzpTYWVYkGUg9r2/Ne37Yv75X4XSwiZQ4QX0jAkj8Ybhk4SjhX
         XdOaNv4PNE2m/Oy/TK1Hx3JKSDhuOdn6OAH1OsiT2l/Eup/iRcRzWNyMGe08kQCo/hGg
         gWkDJybxC1dDNPovL4pPbsrGMZzqnMmrPbU1ifyrZPkOCaWN6hf4PAMHMcm4EwplUkcq
         pkPw==
X-Gm-Message-State: ABy/qLZv/yo6SuyFTf5SkvUguO11IBzP4DUfIu712pj7sCEkBA7X19Fc
	5yKIY3L4+ZRuQpOXCnVAuZpCVl6/Bn/7IhPI5tZe5w==
X-Google-Smtp-Source: APBJJlHh4Hi1rqGRCfLrTgmETw5I2l2VID4RvxdRnmidieTl+HpwU95yDS/WA04e6rFassgK/v0lqw==
X-Received: by 2002:a17:903:2281:b0:1b8:6e2e:78cd with SMTP id b1-20020a170903228100b001b86e2e78cdmr12419795plh.40.1688453758313;
        Mon, 03 Jul 2023 23:55:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y13-20020a170902ed4d00b001b8932d77d7sm3375407plb.279.2023.07.03.23.55.57
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 23:55:57 -0700 (PDT)
Message-ID: <64a3c27d.170a0220.da5d0.6bb5@mx.google.com>
Date: Mon, 03 Jul 2023 23:55:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.184-cip36-10-ga711f789c23e1
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 152 runs,
 10 regressions (v5.10.184-cip36-10-ga711f789c23e1)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jul 2023 06:56:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12204

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 152 runs, 10 regressio=
ns (v5.10.184-cip36-10-ga711f789c23e1)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.184-cip36-10-ga711f789c23e1/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.184-cip36-10-ga711f789c23e1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a711f789c23e157efd79724aec812ad47941364b =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3b7b078874f1768bb2a81

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3b7b078874f1768bb2ab7
        failing since 180 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-07-04T06:09:36.982730  <8>[   19.958205] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 694502_1.5.2.4.1>
    2023-07-04T06:09:37.091206  / # #
    2023-07-04T06:09:37.193111  export SHELL=3D/bin/sh
    2023-07-04T06:09:37.193655  #
    2023-07-04T06:09:37.295455  / # export SHELL=3D/bin/sh. /lava-694502/en=
vironment
    2023-07-04T06:09:37.296018  =

    2023-07-04T06:09:37.397596  / # . /lava-694502/environment/lava-694502/=
bin/lava-test-runner /lava-694502/1
    2023-07-04T06:09:37.398381  =

    2023-07-04T06:09:37.402471  / # /lava-694502/bin/lava-test-runner /lava=
-694502/1
    2023-07-04T06:09:37.501326  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3c056ce644f7a31bb2b2a

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3c056ce644f7a31bb2b2d
        failing since 180 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-07-04T06:46:34.150720  <8>[   12.991744] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 981277_1.5.2.4.1>
    2023-07-04T06:46:34.260334  / # #
    2023-07-04T06:46:34.362361  export SHELL=3D/bin/sh
    2023-07-04T06:46:34.363002  #
    2023-07-04T06:46:34.464440  / # export SHELL=3D/bin/sh. /lava-981277/en=
vironment
    2023-07-04T06:46:34.465241  =

    2023-07-04T06:46:34.566693  / # . /lava-981277/environment/lava-981277/=
bin/lava-test-runner /lava-981277/1
    2023-07-04T06:46:34.567603  =

    2023-07-04T06:46:34.573699  / # /lava-981277/bin/lava-test-runner /lava=
-981277/1
    2023-07-04T06:46:34.681380  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3b79948b7a11c23bb2a9e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus=
.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3b79948b7a11c23bb2aa3
        failing since 74 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-04T06:09:20.352267  + set +x

    2023-07-04T06:09:20.359374  <8>[   10.328292] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11005065_1.4.2.3.1>

    2023-07-04T06:09:20.466468  / # #

    2023-07-04T06:09:20.568641  export SHELL=3D/bin/sh

    2023-07-04T06:09:20.569327  #

    2023-07-04T06:09:20.670766  / # export SHELL=3D/bin/sh. /lava-11005065/=
environment

    2023-07-04T06:09:20.671457  =


    2023-07-04T06:09:20.772894  / # . /lava-11005065/environment/lava-11005=
065/bin/lava-test-runner /lava-11005065/1

    2023-07-04T06:09:20.774087  =


    2023-07-04T06:09:20.779481  / # /lava-11005065/bin/lava-test-runner /la=
va-11005065/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3b98d328e706bd8bb2aaf

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n40=
20-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n40=
20-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3b98d328e706bd8bb2ab4
        failing since 74 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-04T06:17:49.968365  + set<8>[   16.154428] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11005233_1.4.2.3.1>

    2023-07-04T06:17:49.968460   +x

    2023-07-04T06:17:50.072781  / # #

    2023-07-04T06:17:50.173445  export SHELL=3D/bin/sh

    2023-07-04T06:17:50.173638  #

    2023-07-04T06:17:50.274156  / # export SHELL=3D/bin/sh. /lava-11005233/=
environment

    2023-07-04T06:17:50.274365  =


    2023-07-04T06:17:50.374937  / # . /lava-11005233/environment/lava-11005=
233/bin/lava-test-runner /lava-11005233/1

    2023-07-04T06:17:50.375237  =


    2023-07-04T06:17:50.380091  / # /lava-11005233/bin/lava-test-runner /la=
va-11005233/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3b764a4fec6e2d4bb2a91

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3b764a4fec6e2d4bb2a96
        failing since 74 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-04T06:08:21.241282  <8>[   13.019745] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11005119_1.4.2.3.1>

    2023-07-04T06:08:21.244735  + set +x

    2023-07-04T06:08:21.349578  / # #

    2023-07-04T06:08:21.450263  export SHELL=3D/bin/sh

    2023-07-04T06:08:21.450466  #

    2023-07-04T06:08:21.551017  / # export SHELL=3D/bin/sh. /lava-11005119/=
environment

    2023-07-04T06:08:21.551221  =


    2023-07-04T06:08:21.651758  / # . /lava-11005119/environment/lava-11005=
119/bin/lava-test-runner /lava-11005119/1

    2023-07-04T06:08:21.652061  =


    2023-07-04T06:08:21.657119  / # /lava-11005119/bin/lava-test-runner /la=
va-11005119/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3b974b04a77de3dbb2ae2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64a3b974b04a77de3dbb2ae7
        failing since 74 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-04T06:17:28.193791  + <8>[   14.129259] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11005204_1.4.2.3.1>

    2023-07-04T06:17:28.193872  set +x

    2023-07-04T06:17:28.294953  #

    2023-07-04T06:17:28.395856  / # #export SHELL=3D/bin/sh

    2023-07-04T06:17:28.396082  =


    2023-07-04T06:17:28.496539  / # export SHELL=3D/bin/sh. /lava-11005204/=
environment

    2023-07-04T06:17:28.496739  =


    2023-07-04T06:17:28.597340  / # . /lava-11005204/environment/lava-11005=
204/bin/lava-test-runner /lava-11005204/1

    2023-07-04T06:17:28.597671  =


    2023-07-04T06:17:28.602613  / # /lava-11005204/bin/lava-test-runner /la=
va-11005204/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64a3ba06605bf26aa8bb2aad

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64a3ba06605bf26aa8bb2ab3
        failing since 74 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-04T06:19:31.006943  /lava-11005264/1/../bin/lava-test-case

    2023-07-04T06:19:31.018000  <8>[   62.139988] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64a3ba06605bf26aa8bb2ab4
        failing since 74 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-04T06:19:29.969742  /lava-11005264/1/../bin/lava-test-case

    2023-07-04T06:19:29.980957  <8>[   61.102894] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/64a3ba7ad2b87dd5acbb2a7b

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64a3ba7ad2b87dd5acbb2a81
        failing since 74 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-04T06:21:40.135715  /lava-11005296/1/../bin/lava-test-case

    2023-07-04T06:21:40.160594  <8>[   42.635656] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64a3ba7ad2b87dd5acbb2a82
        failing since 74 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-04T06:21:37.972103  <8>[   40.445807] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-07-04T06:21:39.048481  /lava-11005296/1/../bin/lava-test-case

    2023-07-04T06:21:39.074005  <8>[   41.549935] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

