Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9EAC4167B
	for <webhook@archiver.kernel.org>; Mon,  4 Dec 2023 00:04:37 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web11.52073.1701648273219963823
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 03 Dec 2023 16:04:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=w0Li/B0+;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5c66bbb3d77so184447a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 03 Dec 2023 16:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701648272; x=1702253072; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SHbRD/PlYgj73n01kRC9U4lP1gePqUdOPcNV14zKO4Q=;
        b=w0Li/B0+PCbtGHdFVj15u51W61PKFTdMyPDnQixyMxEzGpgLmuIaWE7FhCl3mMqj6J
         1+Wwb4L0EFoF4fpOWkNe3n5BWSKl1ph6oPbP/4pQUm6OMzTIbRTfd0WWtE0GrN/WeJGr
         ku1Fv/RVnPX8ZbSArvGwPof85RHl0ftTQ490adzF9vfB+/G9em8gceeN8B1CE9NOsTBi
         vvI924JoLMstaKK9gzPnVAg+Gs0Dpzk/iyzZ7robBLoiuHsjl03KHpPHKN3yELAW7PtU
         be6iPCamDaR7VSF9Cx95rQjqsJ4qAKBtsMgSsN8+/AuyNDWU5vLcjX7KgMhERS+7/Bvn
         PT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701648272; x=1702253072;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHbRD/PlYgj73n01kRC9U4lP1gePqUdOPcNV14zKO4Q=;
        b=L4FD8DRXpFVYSuyDdKQm1w+HjK+lYeWp6ZwrSCfldNqbc7iZZEx6Wl8vr5eRhNEgDz
         zbA+HU3gH8oy6GwZSu6BCCXC+LYti7T01eAMoNRATUnu8GSM5ELZPZ1toO47P/TWfrvM
         qo3R/eDqQBHdnMZleYx8V6eQV9aWQLHs8sv8zb6RVWvVj+LJd00ucBpd00u1BnoUF1cD
         6HFY3rgu/D6kf+bZHab6Wfiw/BQm/ZoF00aZW+D2+T8z9UJkyhvOnkKe6SuC3RMAQtCU
         RhVQqNg7foe4sJG09J/FJTUzc/hIO6HlweU49Ps/I8rWVGXH97dwnQZDpSBl0I1ZoRTs
         rQ8A==
X-Gm-Message-State: AOJu0Yxt+3YDkfhLMwvltFJS+uNKAeuRppGBmdbWfGTCn7sScTiNDzDC
	AhSq8HXhm7YcC4DmuueVRBYdyi7lzKojmqXznIaJAw==
X-Google-Smtp-Source: AGHT+IHNLsHrSDFimVUWRBMi+a0NJCGJ0oDHg39qhXW7wBnEyn8PCYrC+IJ8M6ltVfQc1ssHNzjLXw==
X-Received: by 2002:a17:902:e845:b0:1d0:af63:23f0 with SMTP id t5-20020a170902e84500b001d0af6323f0mr35525plg.101.1701648271901;
        Sun, 03 Dec 2023 16:04:31 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090341cd00b001cfcc10491fsm7099847ple.161.2023.12.03.16.04.31
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 16:04:31 -0800 (PST)
Message-ID: <656d178f.170a0220.c9e6e.3644@mx.google.com>
Date: Sun, 03 Dec 2023 16:04:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.64-cip10-rt5
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 57 runs,
 12 regressions (v6.1.64-cip10-rt5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Dec 2023 00:04:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13781

cip-gitlab/ci/pavel/linux-test baseline-nfs: 57 runs, 12 regressions (v6.1.=
64-cip10-rt5)

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

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 1          =

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

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.64-cip10-rt5/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.64-cip10-rt5
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b0295fc12bdaf65b61b93e18a316c8e20c1f2507 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/656d08d18a5a49a2e2e1349d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/656d08d18a5a49a2e2e134a6
        failing since 9 days (last pass: v5.10.201-rt98-828-g27523c64bc5dd,=
 first fail: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-03T23:01:43.920001  + set +x

    2023-12-03T23:01:43.926686  <8>[   16.429382] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12172487_1.5.2.3.1>

    2023-12-03T23:01:44.028619  / #

    2023-12-03T23:01:44.129424  # #export SHELL=3D/bin/sh

    2023-12-03T23:01:44.129608  =


    2023-12-03T23:01:44.230117  / # export SHELL=3D/bin/sh. /lava-12172487/=
environment

    2023-12-03T23:01:44.230290  =


    2023-12-03T23:01:44.330808  / # . /lava-12172487/environment/lava-12172=
487/bin/lava-test-runner /lava-12172487/1

    2023-12-03T23:01:44.331097  =


    2023-12-03T23:01:44.336782  / # /lava-12172487/bin/lava-test-runner /la=
va-12172487/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/656d08d28a5a49a2e2e134a8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-nfs-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-nfs-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/656d08d28a5a49a2e2e134b1
        failing since 9 days (last pass: v5.10.201-rt98-828-g27523c64bc5dd,=
 first fail: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-03T23:01:24.389738  <8>[   17.040516] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12172563_1.5.2.3.1>

    2023-12-03T23:01:24.494579  / # #

    2023-12-03T23:01:24.595720  export SHELL=3D/bin/sh

    2023-12-03T23:01:24.596072  #

    2023-12-03T23:01:24.696922  / # export SHELL=3D/bin/sh. /lava-12172563/=
environment

    2023-12-03T23:01:24.697247  =


    2023-12-03T23:01:24.798102  / # . /lava-12172563/environment/lava-12172=
563/bin/lava-test-runner /lava-12172563/1

    2023-12-03T23:01:24.798655  =


    2023-12-03T23:01:24.803553  / # /lava-12172563/bin/lava-test-runner /la=
va-12172563/1

    2023-12-03T23:01:24.916602  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/656d08bc882972eb25e134a6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/656d08bc882972eb25e134af
        failing since 9 days (last pass: v5.10.201-rt98-828-g27523c64bc5dd,=
 first fail: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-03T23:00:53.569947  <8>[   12.974591] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12172493_1.5.2.3.1>

    2023-12-03T23:00:53.671526  #

    2023-12-03T23:00:53.671811  =


    2023-12-03T23:00:53.772347  / # #export SHELL=3D/bin/sh

    2023-12-03T23:00:53.772507  =


    2023-12-03T23:00:53.872969  / # export SHELL=3D/bin/sh. /lava-12172493/=
environment

    2023-12-03T23:00:53.873125  =


    2023-12-03T23:00:53.973622  / # . /lava-12172493/environment/lava-12172=
493/bin/lava-test-runner /lava-12172493/1

    2023-12-03T23:00:53.973864  =


    2023-12-03T23:00:53.978551  / # /lava-12172493/bin/lava-test-runner /la=
va-12172493/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/656d0cd09012dd7c06e13494

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-b=
eaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-b=
eaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/656d0cd09012dd7c0=
6e13495
        failing since 9 days (last pass: v5.10.201-rt98-828-g27523c64bc5dd,=
 first fail: v6.1.62-cip9-12-g3a5321f469b07) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/656d08bb689e241cf2e13479

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-nfs-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-nfs-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/656d08bb689e241cf2e13482
        failing since 9 days (last pass: v5.10.201-rt98-828-g27523c64bc5dd,=
 first fail: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-03T23:01:06.196643  <8>[   14.927336] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12172501_1.5.2.3.1>

    2023-12-03T23:01:06.301153  / # #

    2023-12-03T23:01:06.403434  export SHELL=3D/bin/sh

    2023-12-03T23:01:06.404235  #

    2023-12-03T23:01:06.505755  / # export SHELL=3D/bin/sh. /lava-12172501/=
environment

    2023-12-03T23:01:06.506519  =


    2023-12-03T23:01:06.608104  / # . /lava-12172501/environment/lava-12172=
501/bin/lava-test-runner /lava-12172501/1

    2023-12-03T23:01:06.609206  =


    2023-12-03T23:01:06.614175  / # /lava-12172501/bin/lava-test-runner /la=
va-12172501/1

    2023-12-03T23:01:06.725844  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx8mp-evk                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656d0c87bfc17d4a94e13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-imx8mp-e=
vk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-imx8mp-e=
vk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/656d0c87bfc17d4a9=
4e13476
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/656d08d8807d9d8d86e134c5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/656d08d8807d9d8d86e134ce
        failing since 9 days (last pass: v5.10.201-rt98-828-g27523c64bc5dd,=
 first fail: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-03T23:01:22.150701  AVA_SIGNAL_ENDRUN 0_dmesg 12172500_1.5.2.3.=
1>

    2023-12-03T23:01:22.150770  =


    2023-12-03T23:01:22.251284  / # #export SHELL=3D/bin/sh

    2023-12-03T23:01:22.251448  =


    2023-12-03T23:01:22.352002  / # export SHELL=3D/bin/sh. /lava-12172500/=
environment

    2023-12-03T23:01:22.352194  =


    2023-12-03T23:01:22.452692  / # . /lava-12172500/environment/lava-12172=
500/bin/lava-test-runner /lava-12172500/1

    2023-12-03T23:01:22.452948  =


    2023-12-03T23:01:22.457986  / # /lava-12172500/bin/lava-test-runner /la=
va-12172500/1

    2023-12-03T23:01:22.536539  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/656d08c80607736ad1e13479

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/base=
line-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/base=
line-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/6=
56d08c80607736ad1e134a6
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-03T23:00:58.102552  /lava-303360/1/../bin/lava-test-case
    2023-12-03T23:00:58.184994  <8>[   39.391496] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2023-12-03T23:00:58.185331  /lava-303360/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656d0c9c2b4e3dabbfe13475

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meson-gx=
l-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meson-gx=
l-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/6=
56d0c9c2b4e3dabbfe13495
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-03T23:17:34.194115  /lava-303447/1/../bin/lava-test-case
    2023-12-03T23:17:34.257857  <8>[   55.717026] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2023-12-03T23:17:34.258425  /lava-303447/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656d0c0ba43f6fca8ae134c7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-r8a779=
m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-r8a779=
m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/656d0c0ba43f6fca8=
ae134c8
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656d0dd777d0f0be78e1348b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a=
64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a=
64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/656d0dd777d0f0be7=
8e1348c
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656d0d402ea7fb8392e134a9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-h=
5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-h=
5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/656d0d402ea7fb839=
2e134aa
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07) =

 =20

