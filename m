Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E597CC47DB7
	for <webhook@archiver.kernel.org>; Fri, 19 Jan 2024 01:02:43 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web11.10915.1705626160031897962
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 18 Jan 2024 17:02:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=fho/+Um4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28e82c39e69so233291a91.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 18 Jan 2024 17:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705626159; x=1706230959; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yo9zOD0EzhV2E7fU3t/IhDAMc/fW+7llac6QHYnWNCM=;
        b=fho/+Um4tGR2Rw9hgrXNVQZJthBMwHq6OzPeYZ26Raa00gMdETRXBadiWl7ckSD8Oc
         zKBrzLu5He+MewMYlBJOuzo3iXOXYTRO+tFZDv/PF9jBU2tVSSk2WmPG4Pp7f66Sby38
         WBMe7DHyPxce1KxPzkZMWVeAbo+RlSR9NeYWmtYrMj7G1NyBJ3VZpo+8m/eFk5i4Kdn8
         gHDb8RHBizHtuJoGStON6iAEak7RWG3u4G+oGUeZ4WA4kropED/04WNePet5LVWPLY5J
         YvN6BDhMYvxeGdKJS1Udis3gcpvTWBAmMIK6XvoiPY/uqs4kkdYYKkEZbEW53NH9nbMm
         XJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705626159; x=1706230959;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yo9zOD0EzhV2E7fU3t/IhDAMc/fW+7llac6QHYnWNCM=;
        b=hbcPKbD97qy0sNS2B3dMXkWQ5nSsskQBh042qGH4vIKJt6xLnGDVAaoFArEbAe6nnk
         MZi9i3Yxc07B/UjwqR3CcW3KDlG9sq+aN/o2ZQVNjSBz6/RLb8F5SjSqpVBldM06ZMmB
         2icrHZUE9NCBvD0TnvEMTlgqkRlxkRzsP6wp6ifuAMifWOvBaID0pYd3M90ch8+nA+wB
         LNhyDKVFvo6sW1AYTOVV4QR3hsaNbxL26cPELgTKmp+Qnns3YpZgXpCiAKOHfqtAIPuH
         J1DEhHqvP7Gg4eM/fSwUrrSn3PZkzL9XVRLiptaxiXoRdWaaRo44aCaE/5BVsekv756A
         pmUg==
X-Gm-Message-State: AOJu0Ywapw5Egs4n/BgmEzBj2OgNHZs9qY8mparvz17GdTTxIhEMnzGn
	U2Lt97/E6jXmaonlsKcCj6lqly7sRg5RzoBIgfyoqWSk9Us0QD5m72rBOaYM+DKVSjPsIEqc14j
	bvM0=
X-Google-Smtp-Source: AGHT+IHml2QUrX+emaP26/Pg+FEJp880ObYuHf2Gu4APh20ee/LD/Jf3BPmCyAlu2nyVViTH/npPYw==
X-Received: by 2002:a17:90a:8a10:b0:28e:6f44:46d5 with SMTP id w16-20020a17090a8a1000b0028e6f4446d5mr1492706pjn.52.1705626158733;
        Thu, 18 Jan 2024 17:02:38 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b001d414a00fd9sm1933698plr.29.2024.01.18.17.02.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 17:02:37 -0800 (PST)
Message-ID: <65a9ca2d.170a0220.8a05d.9777@mx.google.com>
Date: Thu, 18 Jan 2024 17:02:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v6.1.72-cip13-30-g79e2886a5da69
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 35 runs,
 8 regressions (v6.1.72-cip13-30-g79e2886a5da69)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jan 2024 01:02:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14414

cip-gitlab/ci/pavel/linux-test baseline-nfs: 35 runs, 8 regressions (v6.1.7=
2-cip13-30-g79e2886a5da69)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig         | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig        | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.72-cip13-30-g79e2886a5da69/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.72-cip13-30-g79e2886a5da69
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      79e2886a5da69a8a86ec82215b5e9e0748943546 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65a9bba05a32cd122752a405

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65a9bba05a32cd122752a40e
        new failure (last pass: v4.19.299-cip105-1134-gc868d5e4adaa)

    2024-01-19T00:00:24.062292  <8>[   18.210703] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12570830_1.5.2.3.1>

    2024-01-19T00:00:24.166823  / # #

    2024-01-19T00:00:24.267513  export SHELL=3D/bin/sh

    2024-01-19T00:00:24.267715  #

    2024-01-19T00:00:24.368231  / # export SHELL=3D/bin/sh. /lava-12570830/=
environment

    2024-01-19T00:00:24.368406  =


    2024-01-19T00:00:24.468937  / # . /lava-12570830/environment/lava-12570=
830/bin/lava-test-runner /lava-12570830/1

    2024-01-19T00:00:24.469196  =


    2024-01-19T00:00:24.511502  / # /lava-12570830/bin/lava-test-runner /la=
va-12570830/1

    2024-01-19T00:00:24.551098  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65a9bc74b7e5b87a4752a447

  Results:     48 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/arm/multi_v5_defconfig/gcc-10/lab-broonie/=
baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/arm/multi_v5_defconfig/gcc-10/lab-broonie/=
baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65a9bc74b7e5b87a4752a480
        failing since 22 days (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6=
, first fail: v6.1.66-cip11-rt6-10-g38253b8903b4)

    2024-01-19T00:03:31.710560  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 473049_1.6.2=
.4.1>
    2024-01-19T00:03:31.828950  #
    2024-01-19T00:03:31.932174  / # #export SHELL=3D/bin/sh
    2024-01-19T00:03:31.932964  =

    2024-01-19T00:03:32.034916  / # export SHELL=3D/bin/sh. /lava-473049/en=
vironment
    2024-01-19T00:03:32.035682  =

    2024-01-19T00:03:32.137702  / # . /lava-473049/environment/lava-473049/=
bin/lava-test-runner /lava-473049/1
    2024-01-19T00:03:32.138926  =

    2024-01-19T00:03:32.142899  / # /lava-473049/bin/lava-test-runner /lava=
-473049/1
    2024-01-19T00:03:32.568948  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65a9be0896899e83a152a421

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/arm/omap2plus_defconfig/gcc-10/lab-broonie=
/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/arm/omap2plus_defconfig/gcc-10/lab-broonie=
/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65a9be0896899e83a152a458
        new failure (last pass: v4.19.299-cip105-1134-gc868d5e4adaa)

    2024-01-19T00:10:35.883901  <8>[   45.869927] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 473065_1.6.2.4.1>
    2024-01-19T00:10:36.001807  / # #
    2024-01-19T00:10:36.103268  export SHELL=3D/bin/sh
    2024-01-19T00:10:36.103649  #
    2024-01-19T00:10:36.204773  / # export SHELL=3D/bin/sh. /lava-473065/en=
vironment
    2024-01-19T00:10:36.205157  =

    2024-01-19T00:10:36.306399  / # . /lava-473065/environment/lava-473065/=
bin/lava-test-runner /lava-473065/1
    2024-01-19T00:10:36.306960  =

    2024-01-19T00:10:36.311264  / # /lava-473065/bin/lava-test-runner /lava=
-473065/1
    2024-01-19T00:10:36.600746  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65a9be79c09cd287ab52a428

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/arm/omap2plus_defconfig/gcc-10/lab-cip/bas=
eline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/arm/omap2plus_defconfig/gcc-10/lab-cip/bas=
eline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65a9be79c09cd287ab52a45e
        new failure (last pass: v4.19.299-cip105-1134-gc868d5e4adaa)

    2024-01-19T00:12:24.037042  <8>[   40.261158] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1078584_1.6.2.4.1>
    2024-01-19T00:12:24.155074  #
    2024-01-19T00:12:24.256764  / # #export SHELL=3D/bin/sh
    2024-01-19T00:12:24.257196  =

    2024-01-19T00:12:24.358120  / # export SHELL=3D/bin/sh. /lava-1078584/e=
nvironment
    2024-01-19T00:12:24.358557  =

    2024-01-19T00:12:24.459521  / # . /lava-1078584/environment/lava-107858=
4/bin/lava-test-runner /lava-1078584/1
    2024-01-19T00:12:24.460229  =

    2024-01-19T00:12:24.464254  / # /lava-1078584/bin/lava-test-runner /lav=
a-1078584/1
    2024-01-19T00:12:24.751143  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65a9bbf3bbb72c18f252a41d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65a9bbf3bbb72c18f252a426
        new failure (last pass: v4.19.299-cip105-1134-gc868d5e4adaa)

    2024-01-19T00:01:36.280670  + set +x

    2024-01-19T00:01:36.287284  <8>[   17.925047] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12570835_1.5.2.3.1>

    2024-01-19T00:01:36.391471  / # #

    2024-01-19T00:01:36.492176  export SHELL=3D/bin/sh

    2024-01-19T00:01:36.492357  #

    2024-01-19T00:01:36.592871  / # export SHELL=3D/bin/sh. /lava-12570835/=
environment

    2024-01-19T00:01:36.593093  =


    2024-01-19T00:01:36.693635  / # . /lava-12570835/environment/lava-12570=
835/bin/lava-test-runner /lava-12570835/1

    2024-01-19T00:01:36.693937  =


    2024-01-19T00:01:36.698603  / # /lava-12570835/bin/lava-test-runner /la=
va-12570835/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65a9bb9c068c4713a952a3f1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65a9bb9c068c4713a952a3fa
        new failure (last pass: v4.19.299-cip105-1134-gc868d5e4adaa)

    2024-01-19T00:00:07.550424  + set +x

    2024-01-19T00:00:07.556581  <8>[   17.533578] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12570820_1.5.2.3.1>

    2024-01-19T00:00:07.670311  / # #

    2024-01-19T00:00:07.772574  export SHELL=3D/bin/sh

    2024-01-19T00:00:07.773307  #

    2024-01-19T00:00:07.874809  / # export SHELL=3D/bin/sh. /lava-12570820/=
environment

    2024-01-19T00:00:07.875542  =


    2024-01-19T00:00:07.977109  / # . /lava-12570820/environment/lava-12570=
820/bin/lava-test-runner /lava-12570820/1

    2024-01-19T00:00:07.978353  =


    2024-01-19T00:00:07.983354  / # /lava-12570820/bin/lava-test-runner /la=
va-12570820/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65a9bb96df85ea880052a41d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65a9bb96df85ea880052a426
        new failure (last pass: v4.19.299-cip105-1134-gc868d5e4adaa)

    2024-01-19T00:00:53.844420  <8>[   17.569989] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12570823_1.5.2.3.1>

    2024-01-19T00:00:53.948948  / # #

    2024-01-19T00:00:54.049598  export SHELL=3D/bin/sh

    2024-01-19T00:00:54.049801  #

    2024-01-19T00:00:54.150361  / # export SHELL=3D/bin/sh. /lava-12570823/=
environment

    2024-01-19T00:00:54.150562  =


    2024-01-19T00:00:54.251100  / # . /lava-12570823/environment/lava-12570=
823/bin/lava-test-runner /lava-12570823/1

    2024-01-19T00:00:54.251391  =


    2024-01-19T00:00:54.256358  / # /lava-12570823/bin/lava-test-runner /la=
va-12570823/1

    2024-01-19T00:00:54.337020  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65a9bb994616e23ae452a426

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65a9bb994616e23ae452a42f
        new failure (last pass: v4.19.299-cip105-1134-gc868d5e4adaa)

    2024-01-19T00:00:16.112120  + <8>[   18.156327] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 12570784_1.5.2.3.1>

    2024-01-19T00:00:16.112224  set +x

    2024-01-19T00:00:16.216564  / # #

    2024-01-19T00:00:16.317244  export SHELL=3D/bin/sh

    2024-01-19T00:00:16.317427  #

    2024-01-19T00:00:16.417903  / # export SHELL=3D/bin/sh. /lava-12570784/=
environment

    2024-01-19T00:00:16.418090  =


    2024-01-19T00:00:16.518663  / # . /lava-12570784/environment/lava-12570=
784/bin/lava-test-runner /lava-12570784/1

    2024-01-19T00:00:16.518980  =


    2024-01-19T00:00:16.524247  / # /lava-12570784/bin/lava-test-runner /la=
va-12570784/1
 =

    ... (12 line(s) more)  =

 =20

