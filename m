Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E631C47DDF
	for <webhook@archiver.kernel.org>; Wed, 31 Jan 2024 12:51:07 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web11.13059.1706705466335732011
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Jan 2024 04:51:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ebtFfy+Q;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.172, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso2713550a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 31 Jan 2024 04:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706705465; x=1707310265; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+1Rz0e7zV9ZGPi/hCSnUIxxLv2wO/w0vQ/HAe2UDbpY=;
        b=ebtFfy+QJwkvsDfj/Azn74fjwNxlS7EIKWBgsvksL13dtu+Vea3zU7auJO++OOfL+7
         HSHDuaC9ma86KHlB2vicBKUILUdWxW/ZLNge6ns9ksBeHozADtRBqc5f942v5v6FCAPy
         Q9l/26vHMEsqnoHYNb6BLqvkOlPbJoIqBQUiDNfPHA1puBEs3/lF1B1ZJ7Yu7l4qUzap
         llzWAXWmwW1w/gHj1jTzssNKKWsPepU99a8HpMBzR3WUU5lZmPqAJrcW5Y67q3GASMmE
         4DMhtJRMwB5BDkKiW6QW7NN8isZLjmSNJPIvGlcCUQA0xG3J1sC8DMC2yzHV6BOf5RwX
         YzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706705465; x=1707310265;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+1Rz0e7zV9ZGPi/hCSnUIxxLv2wO/w0vQ/HAe2UDbpY=;
        b=tPMsJ2yxAnj3AqWKhjKvizOxg//vczwPpwTKAe6jKBEupcBYtJeJpwrHxX0pNTYy2k
         rJ8XKKmwFwUiEUy7jQbUf/45VWuJfaaNITwGNnBdYgoeviqMNFkyCNLIetlJKJg4sF02
         4boLG1UuRs/OB3nE9urZ4Dr3L4GlJ/iYIdsRRFbZG/t+2U/+6nQ17+wSNdnowSJxsp4Q
         ZecazLGcHQvyuWL04umTjZl6tcXX0rkaaT8wzpiSlK0NGYUSYc9BJGAn6Ipqt++V7eym
         NzGLD7Zcq8+UvvSn5BjPaIi+EfEJnD8s0KsvzJArp0ckW+vaKyiJbmV3qAdYMWUyETqr
         cHDg==
X-Gm-Message-State: AOJu0Yz4Tpb0MEvooRESp9MxVbKstuRAqRvVbd9Hn1X35EVBocqx4ueM
	rh+2l/ZsFtqwVhC9JMvS//ut0QwGW53a+5/suPtXA1N5IGJxBCN6jJHQPYPvW1TzEVA/k5tB6DW
	v
X-Google-Smtp-Source: AGHT+IFPQT+gAswMFU2ZIxUJYq4+dvPMpLtwXRSOlNKnbw0ANwcz2WBn8t7c092LxbHR5+xHtbKn4Q==
X-Received: by 2002:a17:90a:7281:b0:293:b22f:8b72 with SMTP id e1-20020a17090a728100b00293b22f8b72mr1452058pjg.6.1706705464730;
        Wed, 31 Jan 2024 04:51:04 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id so10-20020a17090b1f8a00b00290701c8623sm1354091pjb.28.2024.01.31.04.51.04
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 04:51:04 -0800 (PST)
Message-ID: <65ba4238.170a0220.f03c1.2e27@mx.google.com>
Date: Wed, 31 Jan 2024 04:51:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.72-cip13-32-gf60d2e8cb51c
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 50 runs,
 9 regressions (v6.1.72-cip13-32-gf60d2e8cb51c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jan 2024 12:51:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14561

cip-gitlab/ci/pavel/linux-test baseline-nfs: 50 runs, 9 regressions (v6.1.7=
2-cip13-32-gf60d2e8cb51c)

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

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

imx8mp-evk                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.72-cip13-32-gf60d2e8cb51c/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.72-cip13-32-gf60d2e8cb51c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f60d2e8cb51c9da65ffcfe73144286c27725ceea =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65ba32ba76e92aa2b800a0ac

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-nfs-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-nfs-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65ba32ba76e92aa2b800a0b5
        failing since 12 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-01-31T11:44:45.488968  + set<8>[   17.563700] <LAVA_SIGNAL_ENDRUN =
0_dmesg 12669219_1.5.2.3.1>

    2024-01-31T11:44:45.489053   +x

    2024-01-31T11:44:45.593954  / # #

    2024-01-31T11:44:45.694643  export SHELL=3D/bin/sh

    2024-01-31T11:44:45.694945  #

    2024-01-31T11:44:45.795589  / # export SHELL=3D/bin/sh. /lava-12669219/=
environment

    2024-01-31T11:44:45.795861  =


    2024-01-31T11:44:45.896680  / # . /lava-12669219/environment/lava-12669=
219/bin/lava-test-runner /lava-12669219/1

    2024-01-31T11:44:45.897628  =


    2024-01-31T11:44:45.902805  / # /lava-12669219/bin/lava-test-runner /la=
va-12669219/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65ba2f6a014f777d0c00a04d

  Results:     48 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm/multi_v5_defconfig/gcc-10/lab-broonie/b=
aseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm/multi_v5_defconfig/gcc-10/lab-broonie/b=
aseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65ba2f6a014f777d0c00a086
        failing since 34 days (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6=
, first fail: v6.1.66-cip11-rt6-10-g38253b8903b4)

    2024-01-31T11:30:18.841193  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 526546_1.6.2=
.4.1>
    2024-01-31T11:30:18.974810  #
    2024-01-31T11:30:19.078046  / # #export SHELL=3D/bin/sh
    2024-01-31T11:30:19.078850  =

    2024-01-31T11:30:19.180795  / # export SHELL=3D/bin/sh. /lava-526546/en=
vironment
    2024-01-31T11:30:19.181263  =

    2024-01-31T11:30:19.282824  / # . /lava-526546/environment/lava-526546/=
bin/lava-test-runner /lava-526546/1
    2024-01-31T11:30:19.284126  =

    2024-01-31T11:30:19.288045  / # /lava-526546/bin/lava-test-runner /lava=
-526546/1
    2024-01-31T11:30:19.720466  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65ba3400db8a87de4300a09d

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm/omap2plus_defconfig/gcc-10/lab-broonie/=
baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm/omap2plus_defconfig/gcc-10/lab-broonie/=
baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65ba3400db8a87de4300a0d7
        failing since 12 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-01-31T11:50:04.259673  <8>[   43.356355] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 526652_1.6.2.4.1>
    2024-01-31T11:50:04.383033  #
    2024-01-31T11:50:04.485775  / # #export SHELL=3D/bin/sh
    2024-01-31T11:50:04.486459  =

    2024-01-31T11:50:04.588413  / # export SHELL=3D/bin/sh. /lava-526652/en=
vironment
    2024-01-31T11:50:04.589058  =

    2024-01-31T11:50:04.690807  / # . /lava-526652/environment/lava-526652/=
bin/lava-test-runner /lava-526652/1
    2024-01-31T11:50:04.691663  =

    2024-01-31T11:50:04.696347  / # /lava-526652/bin/lava-test-runner /lava=
-526652/1
    2024-01-31T11:50:05.008493  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65ba32a376e92aa2b800a06c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65ba32a476e92aa2b800a075
        failing since 12 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-01-31T11:44:27.710382  + <8>[   18.045140] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 12669171_1.5.2.3.1>

    2024-01-31T11:44:27.710467  set +x

    2024-01-31T11:44:27.814730  <6>[   18.053598] lava-#

    2024-01-31T11:44:27.815006  test-runne (251) used greatest stack depth:=
 13024 bytes left

    2024-01-31T11:44:27.915585  / # #export SHELL=3D/bin/sh

    2024-01-31T11:44:27.915802  =


    2024-01-31T11:44:28.016351  / # export SHELL=3D/bin/sh. /lava-12669171/=
environment

    2024-01-31T11:44:28.016525  =


    2024-01-31T11:44:28.117009  / # . /lava-12669171/environment/lava-12669=
171/bin/lava-test-runner /lava-12669171/1

    2024-01-31T11:44:28.117255  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65ba32a4729a8295aa00a03e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65ba32a4729a8295aa00a047
        failing since 12 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-01-31T11:44:31.158713  + set +x

    2024-01-31T11:44:31.165114  <8>[   17.333682] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12669184_1.5.2.3.1>

    2024-01-31T11:44:31.269483  / # #

    2024-01-31T11:44:31.370120  export SHELL=3D/bin/sh

    2024-01-31T11:44:31.370306  #

    2024-01-31T11:44:31.470851  / # export SHELL=3D/bin/sh. /lava-12669184/=
environment

    2024-01-31T11:44:31.471013  =


    2024-01-31T11:44:31.571566  / # . /lava-12669184/environment/lava-12669=
184/bin/lava-test-runner /lava-12669184/1

    2024-01-31T11:44:31.571915  =


    2024-01-31T11:44:31.576747  / # /lava-12669184/bin/lava-test-runner /la=
va-12669184/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65ba32bb213832889f00a09a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65ba32bb213832889f00a0a3
        failing since 12 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-01-31T11:44:34.767471  <8>[   17.931359] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12669172_1.5.2.3.1>

    2024-01-31T11:44:34.872797  / # #

    2024-01-31T11:44:34.973404  export SHELL=3D/bin/sh

    2024-01-31T11:44:34.973611  #

    2024-01-31T11:44:35.074193  / # export SHELL=3D/bin/sh. /lava-12669172/=
environment

    2024-01-31T11:44:35.074408  =


    2024-01-31T11:44:35.174934  / # . /lava-12669172/environment/lava-12669=
172/bin/lava-test-runner /lava-12669172/1

    2024-01-31T11:44:35.175229  =


    2024-01-31T11:44:35.180330  / # /lava-12669172/bin/lava-test-runner /la=
va-12669172/1

    2024-01-31T11:44:35.256963  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx8mp-evk                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65ba328686e907387600a047

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm64/defconfig/gcc-10/lab-broonie/baseline=
-nfs-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm64/defconfig/gcc-10/lab-broonie/baseline=
-nfs-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65ba328686e907387600a050
        failing since 34 days (last pass: v5.10.201-cip41-77-g545d45774209f=
, first fail: v6.1.66-cip11-rt6-10-g38253b8903b4)

    2024-01-31T11:43:37.996724  + set<8>[   29.785993] <LAVA_SIGNAL_ENDRUN =
0_dmesg 526601_1.6.2.4.1>
    2024-01-31T11:43:37.997234   +x
    2024-01-31T11:43:38.117389  / # #
    2024-01-31T11:43:39.283290  export SHELL=3D/bin/sh
    2024-01-31T11:43:39.289570  #
    2024-01-31T11:43:40.788731  / # export SHELL=3D/bin/sh. /lava-526601/en=
vironment
    2024-01-31T11:43:40.794848  =

    2024-01-31T11:43:43.517964  / # . /lava-526601/environment/lava-526601/=
bin/lava-test-runner /lava-526601/1
    2024-01-31T11:43:43.524880  =

    2024-01-31T11:43:43.530076  / # /lava-526601/bin/lava-test-runner /lava=
-526601/1 =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65ba32a976e92aa2b800a08e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65ba32a976e92aa2b800a097
        failing since 12 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-01-31T11:44:23.641888  <8>[   18.072920] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12669174_1.5.2.3.1>

    2024-01-31T11:44:23.745833  / # #

    2024-01-31T11:44:23.846447  export SHELL=3D/bin/sh

    2024-01-31T11:44:23.846652  #

    2024-01-31T11:44:23.947129  / # export SHELL=3D/bin/sh. /lava-12669174/=
environment

    2024-01-31T11:44:23.947307  =


    2024-01-31T11:44:24.047783  / # . /lava-12669174/environment/lava-12669=
174/bin/lava-test-runner /lava-12669174/1

    2024-01-31T11:44:24.048046  =


    2024-01-31T11:44:24.053049  / # /lava-12669174/bin/lava-test-runner /la=
va-12669174/1

    2024-01-31T11:44:24.097382  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65ba31c0c1344752cc00a039

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm64/defconfig/gcc-10/lab-cip/baseline-nfs=
-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm64/defconfig/gcc-10/lab-cip/baseline-nfs=
-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65ba31c0c1344752c=
c00a03a
        new failure (last pass: v4.19.299-cip105-1134-gc868d5e4adaa) =

 =20

