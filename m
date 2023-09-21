Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA602E71089
	for <webhook@archiver.kernel.org>; Thu, 21 Sep 2023 15:15:43 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web10.20756.1695309339460318499
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Sep 2023 08:15:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=qW8MJ/Fj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-690fa0eea3cso920223b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 21 Sep 2023 08:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695309338; x=1695914138; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i+EmRwixB0z8KB2Eo2cmY78ItmJtfI/O0izT3Q8T08k=;
        b=qW8MJ/FjgjoU1he+8NOmn7lUrY142ghtSUkTmPCnx9Ujg3hHGvL2he9Sw6Mt0mWYfY
         GzoCg54br9nRWZMKcpjwmjVwvqywBtjTYlWMF582SxbVBl88Rskwt60GySgVCmFzGwSC
         fB4z6mOhkbLsdrpdDkJyX9/KEckyC+cDOhjkDa2FhK+OJzy1CX5TRikAdQGgZT+4BEKv
         2DMxkqnIO8eaoOdadvgtSEeopvocjXicGxK4AjT6zAqW29tnN356pTgTNJ/Gi9UZcex4
         8WZ+tJM6gUSP3gMihxRqrjGvL0HnHFW19qiWfDSiO8ZBrMKs/Gyp0DF8acH4IeN0FeDR
         rl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695309338; x=1695914138;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+EmRwixB0z8KB2Eo2cmY78ItmJtfI/O0izT3Q8T08k=;
        b=rwD7In3UVWEzwbvdu05VmvxvESl//UTsneR7hmM8Bj4+fENQg2txceJK8D17GiAuyS
         0tbBcmIjI8G3UsNNnjh86x7z7CNBOXdEBJLk0tndNREt2bk6TWijkGKmon7pmu26ruza
         EcjN95mBZNVbowsxhZxbVWdjzjJyoNJaNgi7T3z8UMI9TLLpZIZ+lyahACvuM+z3MVbm
         cOkF1ig9GNmbkFL5q7OOeWdZrnbK6Anzsl+o6uBmW9+MW9C/HStx73SgSCZDY1vdCXQd
         jg+idrtH7F/uYh0LfaL0Kyn8CFeROSeHXIRdpGc1jt+Ni70vZTL8940BooazNj5/d8Xl
         Dqsg==
X-Gm-Message-State: AOJu0YzaXjoGFLGXGeMk1S1n3+XDICgy57gWnHw2cfKQ1LZZNw10JMuE
	PgnJWbp1+q9PjOO3DZiRSan4MDdotFoCFFs7Nbih/A==
X-Google-Smtp-Source: AGHT+IEfVSR30IfGUrhz1W6tdMW3SZjwisPSWsmNEFJnMh5tCG4WO2NKnnIWECCqyX/8kzHD5nvwFA==
X-Received: by 2002:a05:6a20:8e09:b0:136:faec:a7dc with SMTP id y9-20020a056a208e0900b00136faeca7dcmr6581763pzj.11.1695309337629;
        Thu, 21 Sep 2023 08:15:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x26-20020a63171a000000b0057405fc20c3sm1412048pgl.72.2023.09.21.08.15.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 08:15:36 -0700 (PDT)
Message-ID: <650c5e18.630a0220.97679.3c38@mx.google.com>
Date: Thu, 21 Sep 2023 08:15:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v6.1.54-cip6-101-gb060fea6ba099
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 124 runs,
 23 regressions (v6.1.54-cip6-101-gb060fea6ba099)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Sep 2023 15:15:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13203

cip-gitlab/ci/pavel/linux-test baseline: 124 runs, 23 regressions (v6.1.54-=
cip6-101-gb060fea6ba099)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6ul-14x14-evk             | arm    | lab-nxp       | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx8mp-evk                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3288-rock2-square          | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 2          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.54-cip6-101-gb060fea6ba099/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.54-cip6-101-gb060fea6ba099
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b060fea6ba09908b06e60cc84cbf201d2a71a711 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650c4d6e5ce37a95998a0a53

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c4d6e5ce37a95998a0a5c
        new failure (last pass: v5.10.194-cip39-500-gc5c4e5fc16817)

    2023-09-21T14:05:40.312414  + cat uuid

    2023-09-21T14:05:40.312496  + UUID=3D11588112_1.4.2.3.1

    2023-09-21T14:05:40.315261  + set +x

    2023-09-21T14:05:40.321722  + KERNELCI_<8>[    7.404231] <LAVA_SIGNAL_E=
NDRUN 0_dmesg 11588112_1.4.2.3.1>

    2023-09-21T14:05:40.325196  LAVA=3Dy /bin/sh /opt/kernelci/dmesg.sh

    2023-09-21T14:05:40.325302  + set +x

    2023-09-21T14:05:40.429906  / #

    2023-09-21T14:05:40.530735  # #export SHELL=3D/bin/sh

    2023-09-21T14:05:40.530943  =


    2023-09-21T14:05:40.631511  / # export SHELL=3D/bin/sh. /lava-11588112/=
environment
 =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650c4d83dff04a0df28a0a69

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c4d83dff04a0df28a0a72
        new failure (last pass: v5.10.194-cip39-500-gc5c4e5fc16817)

    2023-09-21T14:04:54.784215  set +x

    2023-09-21T14:04:54.787023  <8>[    8.887461] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11588121_1.4.2.3.1>

    2023-09-21T14:04:54.891456  / # #

    2023-09-21T14:04:54.992069  export SHELL=3D/bin/sh

    2023-09-21T14:04:54.992242  #

    2023-09-21T14:04:55.092802  / # export SHELL=3D/bin/sh. /lava-11588121/=
environment

    2023-09-21T14:04:55.092974  =


    2023-09-21T14:04:55.193588  / # . /lava-11588121/environment/lava-11588=
121/bin/lava-test-runner /lava-11588121/1

    2023-09-21T14:04:55.193864  =


    2023-09-21T14:04:55.198697  / # /lava-11588121/bin/lava-test-runner /la=
va-11588121/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650c4d865ce37a95998a0a95

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c4d865ce37a95998a0a9e
        new failure (last pass: v5.10.194-cip39-500-gc5c4e5fc16817)

    2023-09-21T14:04:53.026693  LAVA=3Dy /bin/sh /opt/kernelci/dmesg.sh

    2023-09-21T14:04:53.026773  + set +x

    2023-09-21T14:04:53.033480  <8>[    6.045454] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11588156_1.4.2.3.1>

    2023-09-21T14:04:53.137692  / # #

    2023-09-21T14:04:53.238285  export SHELL=3D/bin/sh

    2023-09-21T14:04:53.238444  #

    2023-09-21T14:04:53.338980  / # export SHELL=3D/bin/sh. /lava-11588156/=
environment

    2023-09-21T14:04:53.339134  =


    2023-09-21T14:04:53.439659  / # . /lava-11588156/environment/lava-11588=
156/bin/lava-test-runner /lava-11588156/1

    2023-09-21T14:04:53.439884  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650c4a216d0d17cab28a0a5a

  Results:     48 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm/multi_v5_defconfig/gcc-10/lab-broonie/=
baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm/multi_v5_defconfig/gcc-10/lab-broonie/=
baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c4a216d0d17cab28a0a91
        new failure (last pass: v5.10.194-cip39-500-gc5c4e5fc16817)

    2023-09-21T13:49:54.602716  + set +x
    2023-09-21T13:49:54.718990  / # <8><LAVA_SIGNAL_ENDRUN 0_dmesg 1229#
    2023-09-21T13:49:54.822043  export SHELL=3D/bin/sh
    2023-09-21T13:49:54.822876  51_1.5.2.4.1>
    2023-09-21T13:49:54.823389  #
    2023-09-21T13:49:54.925484  / # export SHELL=3D/bin/sh. /lava-122951/en=
vironment
    2023-09-21T13:49:54.926325  =

    2023-09-21T13:49:55.028328  / # . /lava-122951/environment/lava-122951/=
bin/lava-test-runner /lava-122951/1
    2023-09-21T13:49:55.029688  =

    2023-09-21T13:49:55.033292  / # /lava-122951/bin/lava-test-runner /lava=
-122951/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/650c4fa3f80fe753108a0a55

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm/bcm2835_defconfig/gcc-10/lab-collabora=
/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm/bcm2835_defconfig/gcc-10/lab-collabora=
/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c4fa3f80fe753108a0a5d
        failing since 36 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-09-21T14:17:58.278340  + set +x

    2023-09-21T14:17:58.279127  <8>[   10.755291] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-09-21T14:17:58.279380  <8>[   10.757459] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11588172_1.5.2.4.1>

    2023-09-21T14:17:58.383407  / # #

    2023-09-21T14:17:58.485634  export SHELL=3D/bin/sh

    2023-09-21T14:17:58.486340  #

    2023-09-21T14:17:58.587827  / # export SHELL=3D/bin/sh. /lava-11588172/=
environment

    2023-09-21T14:17:58.588528  =


    2023-09-21T14:17:58.690099  / # . /lava-11588172/environment/lava-11588=
172/bin/lava-test-runner /lava-11588172/1

    2023-09-21T14:17:58.691225  =

 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650c5057e6ced0b4d48a0acc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm/multi_v7_defconfig/gcc-10/lab-collabor=
a/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm/multi_v7_defconfig/gcc-10/lab-collabor=
a/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650c5057e6ced0b4d48a0=
acd
        failing since 36 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650c4d6a5ce37a95998a0a42

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c4d6a5ce37a95998a0a4b
        failing since 36 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-09-21T14:04:09.519364  + set +x

    2023-09-21T14:04:09.528383  + KERNELCI_LAVA=3Dy /bin/sh /opt/kernelci/d=
m<8>[    7.099197] <LAVA_SIGNAL_ENDRUN 0_dmesg 11588130_1.4.2.3.1>

    2023-09-21T14:04:09.528471  esg.sh

    2023-09-21T14:04:09.532370  + set +x

    2023-09-21T14:04:09.633480  / # #

    2023-09-21T14:04:09.734086  export SHELL=3D/bin/sh

    2023-09-21T14:04:09.734278  #

    2023-09-21T14:04:09.834744  / # export SHELL=3D/bin/sh. /lava-11588130/=
environment

    2023-09-21T14:04:09.834930  =


    2023-09-21T14:04:09.935436  / # . /lava-11588130/environment/lava-11588=
130/bin/lava-test-runner /lava-11588130/1
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650c4d6a381ccc797b8a0a61

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c4d6a381ccc797b8a0a6a
        new failure (last pass: v5.10.194-cip39-500-gc5c4e5fc16817)

    2023-09-21T14:04:19.903835  set +x

    2023-09-21T14:04:20.005172  / # <#

    2023-09-21T14:04:20.105839  export SHELL=3D/bin/sh

    2023-09-21T14:04:20.106008  8>[    9.890814] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 11588135_1.4.2.3.1>

    2023-09-21T14:04:20.106084  #

    2023-09-21T14:04:20.206684  / # export SHELL=3D/bin/sh. /lava-11588135/=
environment

    2023-09-21T14:04:20.207014  =


    2023-09-21T14:04:20.307955  / # . /lava-11588135/environment/lava-11588=
135/bin/lava-test-runner /lava-11588135/1

    2023-09-21T14:04:20.309149  =


    2023-09-21T14:04:20.314474  / # /lava-11588135/bin/lava-test-runner /la=
va-11588135/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/650c5386cb7ff019458a0a6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650c5386cb7ff019458a0=
a6e
        failing since 29 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, fir=
st fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/650c4f31340b9ea85b8a0a59

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650c4f31340b9ea85b8a0=
a5a
        failing since 29 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, fir=
st fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6ul-14x14-evk             | arm    | lab-nxp       | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/650c4f4fb298260e848a0a6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/bas=
eline-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/bas=
eline-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650c4f4fb298260e848a0=
a6e
        new failure (last pass: v5.10.194-cip39-500-gc5c4e5fc16817) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx8mp-evk                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650c5d014158d78e1b8a0a44

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c5d014158d78e1b8a0a4c
        new failure (last pass: v5.10.194-cip39-500-gc5c4e5fc16817)

    2023-09-21T15:10:28.761101  <8>[   23.711891] <LAVA_SIGNAL_TESTCASE #
    2023-09-21T15:10:28.762404  TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3D=
lines MEASUREMENT=3D0>
    2023-09-21T15:10:28.762794  / # <8>[   23.712616] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 123087_1.5.2.4.1>
    2023-09-21T15:10:29.928228  #export SHELL=3D/bin/sh
    2023-09-21T15:10:29.934410  =

    2023-09-21T15:10:31.433695  / # export SHELL=3D/bin/sh. /lava-123087/en=
vironment
    2023-09-21T15:10:31.439834  =

    2023-09-21T15:10:34.163358  / # . /lava-123087/environment/lava-123087/=
bin/lava-test-runner /lava-123087/1
    2023-09-21T15:10:34.170005  =

    2023-09-21T15:10:34.176707  / # /lava-123087/bin/lava-test-runner /lava=
-123087/1 =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650c4d7848d78742cb8a0a45

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c4d7848d78742cb8a0a4e
        new failure (last pass: v5.10.194-cip39-500-gc5c4e5fc16817)

    2023-09-21T14:04:46.682420  set +x

    2023-09-21T14:04:46.685715  <8>[    8.146810] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11588139_1.4.2.3.1>

    2023-09-21T14:04:46.790282  / # #

    2023-09-21T14:04:46.890960  export SHELL=3D/bin/sh

    2023-09-21T14:04:46.891160  #

    2023-09-21T14:04:46.991690  / # export SHELL=3D/bin/sh. /lava-11588139/=
environment

    2023-09-21T14:04:46.991928  =


    2023-09-21T14:04:47.092557  / # . /lava-11588139/environment/lava-11588=
139/bin/lava-test-runner /lava-11588139/1

    2023-09-21T14:04:47.092922  =


    2023-09-21T14:04:47.097940  / # /lava-11588139/bin/lava-test-runner /la=
va-11588139/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650c4c496b13c81f728a0a4a

  Results:     50 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-broonie/baseline-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-broonie/baseline-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/650c4=
c496b13c81f728a0a79
        failing since 1 day (last pass: v6.1.46-cip4-14-gb994de8f45440, fir=
st fail: v5.10.194-cip39-500-gc5c4e5fc16817)

    2023-09-21T13:59:25.126092  /lava-122995/1/../bin/lava-test-case
    2023-09-21T13:59:25.139898  <8>[   19.043030] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2023-09-21T13:59:25.140440  /lava-122995/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650c539b597135851e8a0a42

  Results:     50 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/650c5=
39b597135851e8a0a71
        failing since 1 day (last pass: v5.10.191-cip38-29-g9e1aa2001db86, =
first fail: v5.10.194-cip39-500-gc5c4e5fc16817)

    2023-09-21T14:29:39.216952  /lava-123084/1/../bin/lava-test-case
    2023-09-21T14:29:39.230410  <8>[   19.266993] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2023-09-21T14:29:39.230663  /lava-123084/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650c51502a3118b8808a0a6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm/shmobile_defconfig/gcc-10/lab-cip/base=
line-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm/shmobile_defconfig/gcc-10/lab-cip/base=
line-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650c51502a3118b8808a0=
a6e
        failing since 1 day (last pass: v6.1.52-cip5-29-g9fee06894d496, fir=
st fail: v5.10.194-cip39-500-gc5c4e5fc16817) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650c4cb4d89351e3a78a0a42

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c4cb4d89351e3a78a0a49
        new failure (last pass: v5.10.194-cip39-500-gc5c4e5fc16817)

    2023-09-21T14:01:12.595863  / # #
    2023-09-21T14:01:14.057634  export SHELL=3D/bin/sh
    2023-09-21T14:01:14.078304  #
    2023-09-21T14:01:14.078513  / # export SHELL=3D/bin/sh
    2023-09-21T14:01:16.034362  / # . /lava-1011399/environment
    2023-09-21T14:01:19.633090  /lava-1011399/bin/lava-test-runner /lava-10=
11399/1
    2023-09-21T14:01:19.653844  . /lava-1011399/environment
    2023-09-21T14:01:19.653954  / # /lava-1011399/bin/lava-test-runner /lav=
a-1011399/1
    2023-09-21T14:01:19.734943  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-21T14:01:19.735161  + cd /lava-1011399/1/tests/1_bootrr =

    ... (26 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650c53bcb8759fa3698a0a42

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm64/defconfig/gcc-10/lab-cip/baseline-r8=
a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm64/defconfig/gcc-10/lab-cip/baseline-r8=
a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c53bcb8759fa3698a0a49
        new failure (last pass: v5.10.194-cip39-500-gc5c4e5fc16817)

    2023-09-21T14:31:00.554432  / # #
    2023-09-21T14:31:02.016699  export SHELL=3D/bin/sh
    2023-09-21T14:31:02.037290  #
    2023-09-21T14:31:02.037499  / # export SHELL=3D/bin/sh
    2023-09-21T14:31:03.993178  / # . /lava-1011414/environment
    2023-09-21T14:31:07.591871  /lava-1011414/bin/lava-test-runner /lava-10=
11414/1
    2023-09-21T14:31:07.612648  . /lava-1011414/environment
    2023-09-21T14:31:07.612756  / # /lava-1011414/bin/lava-test-runner /lav=
a-1011414/1
    2023-09-21T14:31:07.695666  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-21T14:31:07.695890  + cd /lava-1011414/1/tests/1_bootrr =

    ... (26 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650c533c17417b4f1c8a0a4f

  Results:     3 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm64/defconfig/gcc-10/lab-collabora/basel=
ine-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm64/defconfig/gcc-10/lab-collabora/basel=
ine-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c533c17417b4f1c8a0a57
        failing since 64 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-09-21T14:33:22.715932  <8>[   18.088154] <LAVA_SIGNA#

    2023-09-21T14:33:22.716243  L_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dpa=
ss UNITS=3Dlines MEASUREMENT=3D0>

    2023-09-21T14:33:22.716306  =


    2023-09-21T14:33:22.716357  / # <8>[   18.088925] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 11588230_1.5.2.4.1>

    2023-09-21T14:33:22.816933  #export SHELL=3D/bin/sh

    2023-09-21T14:33:22.817123  =


    2023-09-21T14:33:22.917629  / # export SHELL=3D/bin/sh. /lava-11588230/=
environment

    2023-09-21T14:33:22.917786  =


    2023-09-21T14:33:23.018407  / # . /lava-11588230/environment/lava-11588=
230/bin/lava-test-runner /lava-11588230/1

    2023-09-21T14:33:23.018699  =

 =

    ... (31 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3288-rock2-square          | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650c50598742a92f0d8a0a54

  Results:     11 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm/multi_v7_defconfig/gcc-10/lab-collabor=
a/baseline-rk3288-rock2-square.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm/multi_v7_defconfig/gcc-10/lab-collabor=
a/baseline-rk3288-rock2-square.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c50598742a92f0d8a0a63
        new failure (last pass: v5.10.194-cip39-500-gc5c4e5fc16817)

    2023-09-21T14:20:57.061597  / # #

    2023-09-21T14:20:57.163549  export SHELL=3D/bin/sh

    2023-09-21T14:20:57.164264  #

    2023-09-21T14:20:57.265455  / # export SHELL=3D/bin/sh. /lava-11588179/=
environment

    2023-09-21T14:20:57.266113  =


    2023-09-21T14:20:57.367474  / # . /lava-11588179/environment/lava-11588=
179/bin/lava-test-runner /lava-11588179/1

    2023-09-21T14:20:57.368484  =


    2023-09-21T14:20:57.371246  / # /lava-11588179/bin/lava-test-runner /la=
va-11588179/1

    2023-09-21T14:20:57.469824  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-21T14:20:57.470336  + cd /lava-11588179/1/tests/1_bootrr
 =

    ... (20 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/650c50440aeabc819f8a0a58

  Results:     64 PASS, 4 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm/multi_v7_defconfig/gcc-10/lab-collabor=
a/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm/multi_v7_defconfig/gcc-10/lab-collabor=
a/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/650c50440aeabc819f8a0a8a
        failing since 244 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-09-21T14:20:46.031490  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   54.471888] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-09-21T14:20:46.031951  ST

    2023-09-21T14:20:46.032002  =


    2023-09-21T14:20:46.036996  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-09-21T14:20:46.039665  FIRST, INC default to 1.

    2023-09-21T14:20:46.039889  =


    2023-09-21T14:20:46.043309  	-w	Pad to last with leading zeros
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/650c50440aeabc819f8a0a8b
        failing since 244 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-09-21T14:20:46.015203  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   54.462119] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed=
 RESULT=3Dpass>

    2023-09-21T14:20:46.017046   multi-call binary.

    2023-09-21T14:20:46.017349  =

   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650c5368cb7ff019458a0a44

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm64/defconfig/gcc-10/lab-collabora/basel=
ine-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm64/defconfig/gcc-10/lab-collabora/basel=
ine-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c5368cb7ff019458a0a4d
        failing since 1 day (last pass: v5.10.191-cip38-29-g9e1aa2001db86, =
first fail: v5.10.194-cip39-500-gc5c4e5fc16817)

    2023-09-21T14:29:49.738302  #

    2023-09-21T14:29:50.992701  export SHELL=3D/bin/sh

    2023-09-21T14:29:51.003441  #

    2023-09-21T14:29:51.003812  / # export SHELL=3D/bin/sh

    2023-09-21T14:29:52.746612  / # . /lava-11588227/environment

    2023-09-21T14:29:55.950061  /lava-11588227/bin/lava-test-runner /lava-1=
1588227/1

    2023-09-21T14:29:55.961558  . /lava-11588227/environment

    2023-09-21T14:29:55.965531  / # /lava-11588227/bin/lava-test-runner /la=
va-11588227/1

    2023-09-21T14:29:56.022673  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-21T14:29:56.023174  + cd /lava-11588227/1/tests/1_bootrr
 =

    ... (17 line(s) more)  =

 =20

