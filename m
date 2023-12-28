Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B06C46CD4
	for <webhook@archiver.kernel.org>; Thu, 28 Dec 2023 00:07:34 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.114040.1703722051068415934
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 27 Dec 2023 16:07:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ZUi71XMP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d408d0bb87so40227585ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 27 Dec 2023 16:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703722050; x=1704326850; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j+0t/bxixoRqI64QSl25vJ6mvsyuhuc78xE0A0iHzWA=;
        b=ZUi71XMPSLynP4H+xLXvx945m51rGbIMOq00K9T1E1TGh2jibNPpu4OV85FokKhT37
         4bzYJSvF42vO8JMR69v9Bs4WoqVMPSFl0bzDStxaWM6HppXYwO1Hv+iF1eaUa9O+rAw0
         V1t+rH4UiGOmAbamxI3zsM0axtdI1iXM9Pl9AYFNNwqNFYMTfM7pWF5nJS6hOCw3S0DD
         029AoI3dAc8AAwxB+CMkGKvucH8dn0w3R9zgSzvJ6vwZfADBMyqrmc72YJJVu0IsYs1V
         957uabYu9hNPC6JICshbOqOOvrpjOTZWbH6oJCtDW8SVHM81s3qWbzjdP3yMJ0czcS5n
         f/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703722050; x=1704326850;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+0t/bxixoRqI64QSl25vJ6mvsyuhuc78xE0A0iHzWA=;
        b=TBCHIVgxX5y811tDbMHJzylC9y36WrdUJXs+tFpvcLmLzaUcIXqCJ4HFcVS8XlHEv5
         X0Wcd6Jowam5z2d9EFlNK71SEaKVEFamlN8LTVvzwm5gbrS2x/J3xCsXP6fsqD6Ec2j2
         /KGgDE/11O042y2nqtq1FTor9mdzj7YVARSy5d6ILogKxNbVE++LdC4RpS68Na0hjRim
         ZK33Fs4xFJFao/TV7ZPmhuzMdDbYaRSYnwFg+wo+wE3p5W/tglKxtcX9ChBOqW/jiUtZ
         9p5Bsgrtaz6KC/zIkc2f+sfGbZ/fNt0hVWBBYzMKiZ6BFs/UUB1oVXj240UhvyR1/VrJ
         ossw==
X-Gm-Message-State: AOJu0YxD/DEc+TxCFFlZU/EOhN+El4n4/vW0OEDEEFSpVEG7F7CMM6yk
	DwIU8xirvcqaH9ouea9MNCBw97r1USPfUEQmQeIEyGJZFfk=
X-Google-Smtp-Source: AGHT+IEsv0J4528YRbdD5gFvuAQRGTyBR8JPQiH6PaveAgzVFTVMukKdu2vfkvx/TF/j2NEUcmcx+g==
X-Received: by 2002:a17:902:bd94:b0:1d3:f285:816c with SMTP id q20-20020a170902bd9400b001d3f285816cmr9855858pls.25.1703722049611;
        Wed, 27 Dec 2023 16:07:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o23-20020a17090aac1700b0028c361b5c7csm8713946pjq.23.2023.12.27.16.07.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 16:07:29 -0800 (PST)
Message-ID: <658cbc41.170a0220.c3ac6.fec1@mx.google.com>
Date: Wed, 27 Dec 2023 16:07:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.66-cip11-rt6-10-g38253b8903b4
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 53 runs,
 14 regressions (v6.1.66-cip11-rt6-10-g38253b8903b4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Dec 2023 00:07:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14209

cip-gitlab/ci/pavel/linux-test baseline-nfs: 53 runs, 14 regressions (v6.1.=
66-cip11-rt6-10-g38253b8903b4)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig         | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig         | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

imx8mp-evk                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.66-cip11-rt6-10-g38253b8903b4/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.66-cip11-rt6-10-g38253b8903b4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      38253b8903b46da162814048c6f555bba4399ca8 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb34520a1ce928fe134e4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/658cb34520a1ce928fe134ed
        new failure (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6)

    2023-12-27T23:28:48.868483  set +x

    2023-12-27T23:28:48.876105  <8>[   18.139945] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12395566_1.5.2.3.1>

    2023-12-27T23:28:48.984419  / # #

    2023-12-27T23:28:49.086884  export SHELL=3D/bin/sh

    2023-12-27T23:28:49.087714  #

    2023-12-27T23:28:49.189341  / # export SHELL=3D/bin/sh. /lava-12395566/=
environment

    2023-12-27T23:28:49.190153  =


    2023-12-27T23:28:49.291895  / # . /lava-12395566/environment/lava-12395=
566/bin/lava-test-runner /lava-12395566/1

    2023-12-27T23:28:49.293222  =


    2023-12-27T23:28:49.299717  / # /lava-12395566/bin/lava-test-runner /la=
va-12395566/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb2dd7bc742a729e134d0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/658cb2dd7bc742a729e134d9
        new failure (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6)

    2023-12-27T23:27:08.516575  <8>[   17.948000] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12395528_1.5.2.3.1>

    2023-12-27T23:27:08.621740  / # #

    2023-12-27T23:27:08.722663  export SHELL=3D/bin/sh

    2023-12-27T23:27:08.722991  #

    2023-12-27T23:27:08.823642  / # export SHELL=3D/bin/sh. /lava-12395528/=
environment

    2023-12-27T23:27:08.823862  =


    2023-12-27T23:27:08.924427  / # . /lava-12395528/environment/lava-12395=
528/bin/lava-test-runner /lava-12395528/1

    2023-12-27T23:27:08.924706  =


    2023-12-27T23:27:08.929690  / # /lava-12395528/bin/lava-test-runner /la=
va-12395528/1

    2023-12-27T23:27:09.064408  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb2cd853ec4b076e13483

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/658cb2cd853ec4b076e1348c
        new failure (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6)

    2023-12-27T23:26:59.635535  + set +x

    2023-12-27T23:26:59.642047  <8>[   14.335819] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12395490_1.5.2.3.1>

    2023-12-27T23:26:59.746504  / # #

    2023-12-27T23:26:59.847072  export SHELL=3D/bin/sh

    2023-12-27T23:26:59.847231  #

    2023-12-27T23:26:59.947923  / # export SHELL=3D/bin/sh. /lava-12395490/=
environment

    2023-12-27T23:26:59.948740  =


    2023-12-27T23:27:00.050257  / # . /lava-12395490/environment/lava-12395=
490/bin/lava-test-runner /lava-12395490/1

    2023-12-27T23:27:00.051520  =


    2023-12-27T23:27:00.056230  / # /lava-12395490/bin/lava-test-runner /la=
va-12395490/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb1c36506b9c76ae13591

  Results:     48 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/multi_v5_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/multi_v5_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/658cb1c36506b9c76ae135ca
        new failure (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6)

    2023-12-27T23:22:12.911898  <8><LAV<LAVA_TEST_RUNNER EXIT>
    2023-12-27T23:22:13.015494  A_SIGNAL_ENDRUN 0_dmesg 395291_1#
    2023-12-27T23:22:13.016820  .6.2.4.1>
    2023-12-27T23:22:13.119216  / # #export SHELL=3D/bin/sh
    2023-12-27T23:22:13.119994  =

    2023-12-27T23:22:13.221884  / # export SHELL=3D/bin/sh. /lava-395291/en=
vironment
    2023-12-27T23:22:13.222708  =

    2023-12-27T23:22:13.324439  / # . /lava-395291/environment/lava-395291/=
bin/lava-test-runner /lava-395291/1
    2023-12-27T23:22:13.325134  =

    2023-12-27T23:22:13.329115  / # /lava-395291/bin/lava-test-runner /lava=
-395291/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb09c82e58348f2e1348b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/658cb09c82e58348f=
2e1348c
        new failure (last pass: v5.10.201-cip41-77-g545d45774209f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb08582e58348f2e13480

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/658cb08582e58348f=
2e13481
        new failure (last pass: v5.10.201-cip41-77-g545d45774209f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb68c3d9ba6902de13483

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/658cb68c3d9ba6902=
de13484
        new failure (last pass: v5.10.201-cip41-77-g545d45774209f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb2ed5b1974f9b0e13478

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/658cb2ed5b1974f9b0e13481
        new failure (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6)

    2023-12-27T23:27:14.380832  <8>[   17.458235] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12395503_1.5.2.3.1>

    2023-12-27T23:27:14.485925  / # #

    2023-12-27T23:27:14.588578  export SHELL=3D/bin/sh

    2023-12-27T23:27:14.589384  #

    2023-12-27T23:27:14.691117  / # export SHELL=3D/bin/sh. /lava-12395503/=
environment

    2023-12-27T23:27:14.691905  =


    2023-12-27T23:27:14.793521  / # . /lava-12395503/environment/lava-12395=
503/bin/lava-test-runner /lava-12395503/1

    2023-12-27T23:27:14.794851  =


    2023-12-27T23:27:14.799711  / # /lava-12395503/bin/lava-test-runner /la=
va-12395503/1

    2023-12-27T23:27:14.896373  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx8mp-evk                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb290c257688887e134d7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/658cb290c257688887e134e0
        new failure (last pass: v5.10.201-cip41-77-g545d45774209f)

    2023-12-27T23:25:51.637087  <8>[   32.620845] <#
    2023-12-27T23:25:51.638547  LAVA_SIGNAL_ENDRUN 0_dmesg 395323_1.6.2.4.1>
    2023-12-27T23:25:52.804005  / # #export SHELL=3D/bin/sh
    2023-12-27T23:25:52.810129  =

    2023-12-27T23:25:54.309197  / # export SHELL=3D/bin/sh. /lava-395323/en=
vironment
    2023-12-27T23:25:54.315318  =

    2023-12-27T23:25:57.038951  / # . /lava-395323/environment/lava-395323/=
bin/lava-test-runner /lava-395323/1
    2023-12-27T23:25:57.045726  =

    2023-12-27T23:25:57.048866  / # /lava-395323/bin/lava-test-runner /lava=
-395323/1
    2023-12-27T23:25:57.305356  + export TESTRUN_ID=3D1_bootrr =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb2ca44098dd5f9e134bb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/658cb2ca44098dd5f9e134c4
        new failure (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6)

    2023-12-27T23:27:19.246474  <8>[   17.740705] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12395525_1.5.2.3.1>

    2023-12-27T23:27:19.350767  / # #

    2023-12-27T23:27:19.451348  export SHELL=3D/bin/sh

    2023-12-27T23:27:19.451584  #

    2023-12-27T23:27:19.552140  / # export SHELL=3D/bin/sh. /lava-12395525/=
environment

    2023-12-27T23:27:19.552376  =


    2023-12-27T23:27:19.652944  / # . /lava-12395525/environment/lava-12395=
525/bin/lava-test-runner /lava-12395525/1

    2023-12-27T23:27:19.653240  =


    2023-12-27T23:27:19.658521  / # /lava-12395525/bin/lava-test-runner /la=
va-12395525/1

    2023-12-27T23:27:19.700319  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/658cae7c8d85ddd4c3e13585

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/6=
58cae7c8d85ddd4c3e135b4
        failing since 24 days (last pass: v6.1.62-cip9-12-g3a5321f469b07, f=
irst fail: v6.1.64-cip10-rt5)

    2023-12-27T23:08:18.700207  /lava-395249/1/../bin/lava-test-case
    2023-12-27T23:08:18.754560  <8>[   34.598877] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb274c257688887e13481

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/6=
58cb274c257688887e134ad
        new failure (last pass: v5.10.201-cip41-77-g545d45774209f)

    2023-12-27T23:25:16.290957  /lava-395327/1/../bin/lava-test-case
    2023-12-27T23:25:16.337175  <8>[   34.586325] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2023-12-27T23:25:16.337452  /lava-395327/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb2550cb8634044e134ae

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig/gcc-10/lab-collabora/ba=
seline-nfs-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig/gcc-10/lab-collabora/ba=
seline-nfs-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/658cb2550cb863404=
4e134af
        failing since 24 days (last pass: v6.1.62-cip9-12-g3a5321f469b07, f=
irst fail: v6.1.64-cip10-rt5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb2ec5b1974f9b0e13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig/gcc-10/lab-broonie/base=
line-nfs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/658cb2ec5b1974f9b=
0e13476
        new failure (last pass: v5.10.201-cip41-77-g545d45774209f) =

 =20

