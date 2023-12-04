Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD227C46CA0
	for <webhook@archiver.kernel.org>; Mon,  4 Dec 2023 00:04:37 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
 by mx.groups.io with SMTP id smtpd.web10.52445.1701648272847426699
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 03 Dec 2023 16:04:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=WSM2rN6N;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.48, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-58dd3528497so2751662eaf.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 03 Dec 2023 16:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701648272; x=1702253072; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2a0lGhH/fXaODTfLPC4l8iQse+XnLwT8CuuQS1CnBQM=;
        b=WSM2rN6NTfPwZ7wQ4JwSyWZAwhjSWxjDeQ6nVFpVZnOUHbLsXwrzNYJrYUpQUdx7TE
         nxd/wYk3LBmdRxK9TLjQR/C2OPxMPHajSp1aq3VMpb0CQzvW24cRmklBShY1JbfdzPEq
         Q+hv6p7Mw1gf4CU8Vgl8Emgtp8R1yxr/dYWyju+uYgXhKguiPjzpAxU48Ns91BQTw36h
         f2iMBre5ORCZJva5b4vEtNmT2TZ2fwNvvw1JpO6QFuKx8RdwaRNCKwrgkw5it60h0cxA
         mrlBwT/hhafcCxqQ+/+BeqTzLJMGkrw9HNd2nKk3gwKNbNluV3orpIaDrmfPhloSxqtd
         xGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701648272; x=1702253072;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2a0lGhH/fXaODTfLPC4l8iQse+XnLwT8CuuQS1CnBQM=;
        b=gJfRbm25XUVTbPOT+s4RTrcB0TsVkW0reLEUPmVhmogKtmQLVxIkPnx9aCuIVZzT10
         co/+S5h77OZdDAdbDE67lhm3IZzl4ilB35QpYB6Zjm5thz00UVsXPvPkVIZmbQVATEdj
         xVCWOOiNNNwl9CH56CulHpxXTrCR7vH5CwFSf2lGsrANsbUnaF7J9skTSIxPKsX26OSh
         yU0IL8tLGWNW2Mi4A6qdDaFZrYzfzBq4yFVpO0f9O+L4ebtsjedTjpByDDEptBPCAVRp
         yDf0kB0GWK2vU/bnDo0B1aIQwjZ/Tny/eZfIkfxyiEiF5B2dQbem2tUg8NWdKjYIX2nO
         rC4g==
X-Gm-Message-State: AOJu0Yy2xCcAzZZ8JyoV99gtSrQT9q1ZqfKaV32YD/yoxOzJLScxFNTv
	Q0kOJV6rF90hNgg4cXACgdoAK2NAUDq6DoIlch5D7A==
X-Google-Smtp-Source: AGHT+IFGqO1Cpmh81GbpwRBK6+LZrnJRA1fTLtNOcqufU8kbY/znUjW+uRy2NR9rjjuhbu0/kbt1og==
X-Received: by 2002:a05:6358:7e0b:b0:16b:f91b:3cef with SMTP id o11-20020a0563587e0b00b0016bf91b3cefmr3861565rwm.31.1701648271345;
        Sun, 03 Dec 2023 16:04:31 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a11-20020a17090ad80b00b0028649b84907sm5799508pjv.16.2023.12.03.16.04.30
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 16:04:30 -0800 (PST)
Message-ID: <656d178e.170a0220.32d87.0189@mx.google.com>
Date: Sun, 03 Dec 2023 16:04:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.64-cip10-rt5
Subject: cip-gitlab/ci/pavel/linux-test baseline: 126 runs,
 12 regressions (v6.1.64-cip10-rt5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Dec 2023 00:04:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13780

cip-gitlab/ci/pavel/linux-test baseline: 126 runs, 12 regressions (v6.1.64-=
cip10-rt5)

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

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig         | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

imx6ul-14x14-evk             | arm    | lab-nxp       | gcc-10   | imx_v6_v=
7_defconfig        | 1          =

imx8mp-evk                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig         | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.64-cip10-rt5/plan/baseline/

  Test:     baseline
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


  Details:     https://kernelci.org/test/plan/id/656d08cc8a5a49a2e2e13490

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656d08cc8a5a49a2e2e13499
        failing since 9 days (last pass: v5.10.201-rt98-828-g27523c64bc5dd,=
 first fail: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-03T23:03:38.044691  + cat uuid

    2023-12-03T23:03:38.044765  + UUID=3D12172543_1.4.2.3.1

    2023-12-03T23:03:38.047598  + set +x

    2023-12-03T23:03:38.054531  + KERNELCI_<8>[    5.906295] <LAVA_SIGNAL_E=
NDRUN 0_dmesg 12172543_1.4.2.3.1>

    2023-12-03T23:03:38.057502  LAVA=3Dy /bin/sh /opt/kernelci/dmesg.sh

    2023-12-03T23:03:38.057637  + set +x

    2023-12-03T23:03:38.162575  / # #

    2023-12-03T23:03:38.263201  export SHELL=3D/bin/sh

    2023-12-03T23:03:38.263423  #

    2023-12-03T23:03:38.363977  / # export SHELL=3D/bin/sh. /lava-12172543/=
environment
 =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/656d08bcdf97e5f0d3e134b2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656d08bcdf97e5f0d3e134bb
        failing since 9 days (last pass: v5.10.201-rt98-828-g27523c64bc5dd,=
 first fail: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-03T23:01:02.407180  set +x

    2023-12-03T23:01:02.508502  / # <8>[  #

    2023-12-03T23:01:02.609124  export SHELL=3D/bin/sh

    2023-12-03T23:01:02.609329    5.951415] <LAVA_SIGNAL_ENDRUN 0_dmesg 121=
72517_1.4.2.3.1>

    2023-12-03T23:01:02.609409  #

    2023-12-03T23:01:02.709945  / # export SHELL=3D/bin/sh. /lava-12172517/=
environment

    2023-12-03T23:01:02.710180  =


    2023-12-03T23:01:02.810795  / # . /lava-12172517/environment/lava-12172=
517/bin/lava-test-runner /lava-12172517/1

    2023-12-03T23:01:02.811157  =


    2023-12-03T23:01:02.815757  / # /lava-12172517/bin/lava-test-runner /la=
va-12172517/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/656d1267c4d8a2fdbee134b4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebon=
e-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebon=
e-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656d1267c4d8a2fdbee13=
4b5
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/656d08d30607736ad1e134d8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656d08d30607736ad1e134e1
        failing since 9 days (last pass: v5.10.201-rt98-828-g27523c64bc5dd,=
 first fail: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-03T23:01:23.993087  set<8>[    6.867656] <LAVA_SIGNAL_ENDRUN 0_=
dmesg 12172509_1.4.2.3.1>

    2023-12-03T23:01:23.993523   +x

    2023-12-03T23:01:24.100568  / # #

    2023-12-03T23:01:24.202713  export SHELL=3D/bin/sh

    2023-12-03T23:01:24.203355  #

    2023-12-03T23:01:24.304699  / # export SHELL=3D/bin/sh. /lava-12172509/=
environment

    2023-12-03T23:01:24.305363  =


    2023-12-03T23:01:24.406829  / # . /lava-12172509/environment/lava-12172=
509/bin/lava-test-runner /lava-12172509/1

    2023-12-03T23:01:24.407917  =


    2023-12-03T23:01:24.412422  / # /lava-12172509/bin/lava-test-runner /la=
va-12172509/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx6ul-14x14-evk             | arm    | lab-nxp       | gcc-10   | imx_v6_v=
7_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/656d0781f7963568cce134ee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-1=
4x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-1=
4x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656d0781f7963568cce13=
4ef
        failing since 9 days (last pass: v5.10.201-rt98-828-g27523c64bc5dd,=
 first fail: v6.1.62-cip9-12-g3a5321f469b07) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx8mp-evk                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656d0b84f10ffeacf3e1347a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.t=
xt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656d0b84f10ffeacf3e13483
        failing since 9 days (last pass: v5.10.201-rt98-828-g27523c64bc5dd,=
 first fail: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-03T23:12:47.677203  <8>[   20.610231] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 303410_1.5.2.4.1>
    2023-12-03T23:12:47.782612  / # #
    2023-12-03T23:12:48.943990  export SHELL=3D/bin/sh
    2023-12-03T23:12:48.950257  #
    2023-12-03T23:12:50.445338  / # export SHELL=3D/bin/sh. /lava-303410/en=
vironment
    2023-12-03T23:12:50.451311  =

    2023-12-03T23:12:53.170930  / # . /lava-303410/environment/lava-303410/=
bin/lava-test-runner /lava-303410/1
    2023-12-03T23:12:53.177559  =

    2023-12-03T23:12:53.180638  / # /lava-303410/bin/lava-test-runner /lava=
-303410/1
    2023-12-03T23:12:53.210261  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/656d08bc882972eb25e134c5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656d08bc882972eb25e134ce
        failing since 9 days (last pass: v5.10.201-rt98-828-g27523c64bc5dd,=
 first fail: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-03T23:01:28.913090  + <8>[   12.570515] <LAVA_SIGNAL_TESTCASE T=
EST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-12-03T23:01:28.913520  set +x

    2023-12-03T23:01:29.019100  / # <#

    2023-12-03T23:01:29.121239  export SHELL=3D/bin/sh

    2023-12-03T23:01:29.121910  8>[   12.602520] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 12172553_1.4.2.3.1>

    2023-12-03T23:01:29.122273  #

    2023-12-03T23:01:29.223614  / # export SHELL=3D/bin/sh. /lava-12172553/=
environment

    2023-12-03T23:01:29.224397  =


    2023-12-03T23:01:29.325838  / # . /lava-12172553/environment/lava-12172=
553/bin/lava-test-runner /lava-12172553/1

    2023-12-03T23:01:29.326884  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/656d08b8c9a4a079d3e134ba

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/base=
line-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/base=
line-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/656d0=
8b8c9a4a079d3e134ea
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-03T23:00:05.010297  /lava-303350/1/../bin/lava-test-case
    2023-12-03T23:00:05.026263  <8>[   20.548036] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2023-12-03T23:00:05.026595  /lava-303350/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656d0bf1a43f6fca8ae13476

  Results:     50 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig/gcc-10/lab-broonie/baseline-meson-gxl-s9=
05x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig/gcc-10/lab-broonie/baseline-meson-gxl-s9=
05x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/656d0=
bf2a43f6fca8ae134a5
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07)

    2023-12-03T23:14:23.868156  /lava-303440/1/../bin/lava-test-case
    2023-12-03T23:14:23.882572  <8>[   19.413703] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2023-12-03T23:14:23.882954  /lava-303440/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/656d09770cf3e655f0e13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-i=
wg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-i=
wg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656d09770cf3e655f0e13=
476
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656d0cf99012dd7c06e13536

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-li=
bretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-li=
bretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656d0cf99012dd7c06e13=
537
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656d0c6219c17c48ade13487

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656d0c6219c17c48ade13=
488
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07) =

 =20

