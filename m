Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA81C32793
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 20:50:46 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web10.28454.1674075045063093315
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 12:50:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=XGPUKQGD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id s3so24687156pfd.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 12:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QhvNf4x70bQ820wRbnVXRGk3hN5tHGJcd9/NfYwm494=;
        b=XGPUKQGD9DaTlflnyC7kPiq4KAiRlhXJo+yu7gikQwqbEPFXkF9a/ygT9zaSgLXEtH
         r0kqvh7OD0wGUO3GcbvCEYUhKPUCs4SpmSSRQMYdOioyyKC+Q295HKdt8T2zGZQoAadj
         HZt5Ae0R+8G4tcFGF/kvYFregU3+0l08PdxuGpG2oFXkhHHKRaaiLKRrp8e/JOG+4csf
         rSyiaip7IItcXHhLjhyisiROtgHH9VfTyv+K3vWDJuLrmQlff33vaQWE1O/vpLVPT9As
         k5kGljgAFJwqqTdGw8UKJLhZ384VW5DmTMmw/bz1tNgap1dnnZIjAbz4U5w8vkxghZEw
         TyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QhvNf4x70bQ820wRbnVXRGk3hN5tHGJcd9/NfYwm494=;
        b=7rED2y2dl34oiNKBDGbnOOM3BZSzGNTmImNG+KQnSGpJW8G4+kFLzPAYtX6j7vy+KF
         TQOCuSoNTpWnOTNTyq7LPkft1TJ2H46NGSz9KpER+9u/02Mf8p1Nxmbn8JYdoeeSrPtz
         4rXaW8JH7oazxLE8B3mH3WdysYfsU3yTqQ/iINq29HrYARTSZNJ3O0B5oV/E/iI27Ga/
         8OEnIqn6pceaZQiqxP87lwxqrIxieRolnpqp6jcmvDz6yXCXIAU/X/cR7JeP5dCrsGLg
         VfY4M9m9o0GlNE1c2toj1XGLkhh80LpFoI3FijeiM2mnGaVY+HeIFkgHp7usM0zrEOfH
         iUfA==
X-Gm-Message-State: AFqh2krvP+fQPXQ9Y8qHuENkLNXaayf7RrIcT/9bfs/I6W9Q7Ctmh+V0
	IiUzvQs9L5k79OOnIM7M5mzbXJvzka6Yz/bSFzzFlQ==
X-Google-Smtp-Source: AMrXdXtR2Xp1G1qIPj+BEMUnoIKJpnSMon/W7IXDqe1NucyXV3uWqsJpaZ/8NJoqWjOvb4VbjCq34Q==
X-Received: by 2002:a05:6a00:180d:b0:58d:c694:9a9e with SMTP id y13-20020a056a00180d00b0058dc6949a9emr10562028pfa.18.1674075043155;
        Wed, 18 Jan 2023 12:50:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d191-20020a621dc8000000b0058193135f6bsm22519640pfd.84.2023.01.18.12.50.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 12:50:42 -0800 (PST)
Message-ID: <63c85ba2.620a0220.e70b7.49f9@mx.google.com>
Date: Wed, 18 Jan 2023 12:50:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.269-rt119-1495-gc851fb1e222f
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 64 runs,
 34 regressions (v4.19.269-rt119-1495-gc851fb1e222f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 20:50:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10400

cip-gitlab/ci/pavel/linux-test baseline: 64 runs, 34 regressions (v4.19.269=
-rt119-1495-gc851fb1e222f)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 2          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 2          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

da850-lcdk                   | arm    | lab-baylibre    | gcc-10   | davinc=
i_all_defconfig        | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6sx-sdb                   | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

r8a7796-m3ulcb               | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 7          =

sun50i-h6-pine-h64           | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.269-rt119-1495-gc851fb1e222f/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.269-rt119-1495-gc851fb1e222f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c851fb1e222f4acf955da1ad9b020f3fc8a51c4b =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c853f22e739d6462915ee7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c853f22e739d6462915=
ee8
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c856fdd02bfbe4ff915eb9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c856fdd02bfbe4ff915ebe
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:30:31.047858  + set +x
    2023-01-18T20:30:31.054280  <8>[   10.997057] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8784772_1.4.2.3.1>
    2023-01-18T20:30:31.163294  / # #
    2023-01-18T20:30:31.266197  export SHELL=3D/bin/sh
    2023-01-18T20:30:31.267056  #
    2023-01-18T20:30:31.368943  / # export SHELL=3D/bin/sh. /lava-8784772/e=
nvironment
    2023-01-18T20:30:31.369890  =

    2023-01-18T20:30:31.471982  / # . /lava-8784772/environment/lava-878477=
2/bin/lava-test-runner /lava-8784772/1
    2023-01-18T20:30:31.473289  =

    2023-01-18T20:30:31.478374  / # /lava-8784772/bin/lava-test-runner /lav=
a-8784772/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8555a92ffbaaed7915f31

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8555a92ffbaaed7915=
f32
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8540644b15a4b70915ebd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8540644b15a4b70915=
ebe
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85184756022bf4f915ecc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/multi_v5_defconfig/gcc-10/lab-broon=
ie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/multi_v5_defconfig/gcc-10/lab-broon=
ie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85184756022bf4f915ed1
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:07:13.385627  + set +x
    2023-01-18T20:07:13.390160  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 138147_1.5.2=
.4.1>
    2023-01-18T20:07:13.503466  / # #
    2023-01-18T20:07:13.606315  export SHELL=3D/bin/sh
    2023-01-18T20:07:13.607059  #
    2023-01-18T20:07:13.708939  / # export SHELL=3D/bin/sh. /lava-138147/en=
vironment
    2023-01-18T20:07:13.709727  =

    2023-01-18T20:07:13.811764  / # . /lava-138147/environment/lava-138147/=
bin/lava-test-runner /lava-138147/1
    2023-01-18T20:07:13.813224  =

    2023-01-18T20:07:13.819524  / # /lava-138147/bin/lava-test-runner /lava=
-138147/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/63c8543ada0417d8ea915fbf

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c8543ada0417d8ea915fc4
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:18:50.717319  <8>[   15.101388] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 138361_1.5.2.4.1>
    2023-01-18T20:18:50.884611  / # #
    2023-01-18T20:18:51.003202  export SHELL=3D/bin/sh
    2023-01-18T20:18:51.009427  <6>[   15.165583] usb 1-1: new low-speed US=
B device number 3 using musb-hdrc
    2023-01-18T20:18:51.013436  #
    2023-01-18T20:18:51.016968  / # <3>[   15.315584] usb 1-1: device descr=
iptor read/64, error -71
    2023-01-18T20:18:51.020469  export SHELL=3D/bin/sh
    2023-01-18T20:18:51.131089  / # . /lava-138361/environment
    2023-01-18T20:18:51.241469  /lava-138361/bin/lava-test-runner /lava-138=
361/1
    2023-01-18T20:18:51.250812  . /lava-138361/environment =

    ... (17 line(s) more)  =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/63c8543ada0417d8=
ea915fc8
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)
        1 lines

    2023-01-18T20:18:49.912851  / # =

    2023-01-18T20:18:49.925119  =

    2023-01-18T20:18:50.068017  / # #
    2023-01-18T20:18:50.079994  #<6>[   14.475563] usb 1-1: new low-speed U=
SB device number 2 using musb-hdrc
    2023-01-18T20:18:50.084339  =

    2023-01-18T20:18:50.198862  / # export SHELL=3D/bin/sh
    2023-01-18T20:18:50.212712  export SHELL=3D/bin/sh
    2023-01-18T20:18:50.321727  / # . /lava-138361/environment
    2023-01-18T20:18:50.326675  <3>[   14.625611] usb 1-1: device descripto=
r read/64, error -71
    2023-01-18T20:18:50.334134  . /lava-138361/environment =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/63c856bd5e6399d9c9915ec3

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c856bd5e6399d9c9915ec6
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:29:29.575803  <8>[    8.840011] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 827982_1.5.2.4.1>
    2023-01-18T20:29:29.685937  / # #
    2023-01-18T20:29:29.788718  export SHELL=3D/bin/sh
    2023-01-18T20:29:29.789574  #
    2023-01-18T20:29:29.891510  / # export SHELL=3D/bin/sh. /lava-827982/en=
vironment
    2023-01-18T20:29:29.892346  =

    2023-01-18T20:29:29.994271  / # . /lava-827982/environment/lava-827982/=
bin/lava-test-runner /lava-827982/1
    2023-01-18T20:29:29.994875  =

    2023-01-18T20:29:30.000624  / # /lava-827982/bin/lava-test-runner /lava=
-827982/1
    2023-01-18T20:29:30.067465  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/63c856bd5e6399d9=
c9915eca
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)
        1 lines

    2023-01-18T20:29:28.887955  / # =

    2023-01-18T20:29:28.895272  =

    2023-01-18T20:29:29.001568  / # #
    2023-01-18T20:29:29.008455  #
    2023-01-18T20:29:29.109849  / # export SHELL=3D/bin/sh
    2023-01-18T20:29:29.116422  export SHELL=3D/bin/sh
    2023-01-18T20:29:29.217627  / # . /lava-827982/environment
    2023-01-18T20:29:29.224897  . /lava-827982/environment
    2023-01-18T20:29:29.326423  / # /lava-827982/bin/lava-test-runner /lava=
-827982/0
    2023-01-18T20:29:29.334066  /lava-827982/bin/lava-test-runner /lava-827=
982/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85150130035ecb6915f24

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/63c85150130035ec=
b6915f2d
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)
        1 lines

    2023-01-18T20:06:22.812135  / # =

    2023-01-18T20:06:22.821667  =

    2023-01-18T20:06:22.932854  / # #
    2023-01-18T20:06:22.938297  #
    2023-01-18T20:06:23.040608  / # export SHELL=3D/bin/sh
    2023-01-18T20:06:23.047154  export SHELL=3D/bin/sh
    2023-01-18T20:06:23.149175  / # . /lava-138113/environment
    2023-01-18T20:06:23.156068  . /lava-138113/environment
    2023-01-18T20:06:23.258073  / # /lava-138113/bin/lava-test-runner /lava=
-138113/0
    2023-01-18T20:06:23.263165  /lava-138113/bin/lava-test-runner /lava-138=
113/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8510cf2a9c7f409915ed4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/omap2plus_defconfig/gcc-10/lab-cip/=
baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/omap2plus_defconfig/gcc-10/lab-cip/=
baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/63c8510cf2a9c7f4=
09915edb
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)
        1 lines

    2023-01-18T20:05:14.175260  / # =

    2023-01-18T20:05:14.182374  =

    2023-01-18T20:05:14.286760  / # #
    2023-01-18T20:05:14.289883  #
    2023-01-18T20:05:14.392676  / # export SHELL=3D/bin/sh
    2023-01-18T20:05:14.397024  export SHELL=3D/bin/sh
    2023-01-18T20:05:14.498446  / # . /lava-827933/environment
    2023-01-18T20:05:14.501570  . /lava-827933/environment
    2023-01-18T20:05:14.604701  / # /lava-827933/bin/lava-test-runner /lava=
-827933/0
    2023-01-18T20:05:14.607615  /lava-827933/bin/lava-test-runner /lava-827=
933/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
da850-lcdk                   | arm    | lab-baylibre    | gcc-10   | davinc=
i_all_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/63c851919834c106d2915ebd

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: davinci_all_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/davinci_all_defconfig/gcc-10/lab-ba=
ylibre/baseline-da850-lcdk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/davinci_all_defconfig/gcc-10/lab-ba=
ylibre/baseline-da850-lcdk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/63c851919834c10=
6d2915ec5
        failing since 253 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a)
        6 lines

    2023-01-18T20:07:23.652004  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3400
    2023-01-18T20:07:23.652351  kern  :alert : raw: 00000000 00000100 00000=
200 00000000 00000004 0000000a ffffff7f 00000000
    2023-01-18T20:07:23.652578  kern  :alert : page dumped because: nonzero=
 mapcount
    2023-01-18T20:07:23.652788  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3800
    2023-01-18T20:07:23.652977  kern  :alert : raw: 00000000 00000100 00000=
200 00000000 00000004 0000000a ffffff7f 00000000
    2023-01-18T20:07:23.653150  kern  :alert : page dumped because: nonzero=
 mapcount
    2023-01-18T20:07:23.683328  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dale=
rt RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D6>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8555b92ffbaaed7915f34

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8555b92ffbaaed7915=
f35
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85392bf9bece532915ed7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85392bf9bece532915edc
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:16:00.300094  / # #
    2023-01-18T20:16:00.401225  export SHELL=3D/bin/sh
    2023-01-18T20:16:00.401474  #
    2023-01-18T20:16:00.502423  / # export SHELL=3D/bin/sh. /lava-8784859/e=
nvironment
    2023-01-18T20:16:00.502694  =

    2023-01-18T20:16:00.604131  / # . /lava-8784859/environment/lava-878485=
9/bin/lava-test-runner /lava-8784859/1
    2023-01-18T20:16:00.605486  =

    2023-01-18T20:16:00.613267  / # /lava-8784859/bin/lava-test-runner /lav=
a-8784859/1
    2023-01-18T20:16:00.704239  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T20:16:00.704862  + cd /lava-8784859/1/tests/1_bootrr =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85320b4d5997aeb915f02

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/imx_v6_v7_defconfig/gcc-10/lab-peng=
utronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/imx_v6_v7_defconfig/gcc-10/lab-peng=
utronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85320b4d5997aeb915f07
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:14:16.626626  + set +x[    7.080960] <LAVA_SIGNAL_ENDRUN =
0_dmesg 882586_1.5.2.3.1>
    2023-01-18T20:14:16.626977  =

    2023-01-18T20:14:16.734625  / # #
    2023-01-18T20:14:16.836786  export SHELL=3D/bin/sh
    2023-01-18T20:14:16.837569  #
    2023-01-18T20:14:16.938956  / # export SHELL=3D/bin/sh. /lava-882586/en=
vironment
    2023-01-18T20:14:16.939715  =

    2023-01-18T20:14:17.041146  / # . /lava-882586/environment/lava-882586/=
bin/lava-test-runner /lava-882586/1
    2023-01-18T20:14:17.046677  =

    2023-01-18T20:14:17.054249  / # /lava-882586/bin/lava-test-runner /lava=
-882586/1 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c853700af41db35a915ec7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/multi_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/multi_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c853700af41db35a915ecc
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:15:37.612072  + set +x
    2023-01-18T20:15:37.612309  [    4.876030] <LAVA_SIGNAL_ENDRUN 0_dmesg =
882590_1.5.2.3.1>
    2023-01-18T20:15:37.718238  / # #
    2023-01-18T20:15:37.819986  export SHELL=3D/bin/sh
    2023-01-18T20:15:37.820530  #
    2023-01-18T20:15:37.921760  / # export SHELL=3D/bin/sh. /lava-882590/en=
vironment
    2023-01-18T20:15:37.922454  =

    2023-01-18T20:15:38.023775  / # . /lava-882590/environment/lava-882590/=
bin/lava-test-runner /lava-882590/1
    2023-01-18T20:15:38.024736  =

    2023-01-18T20:15:38.026929  / # /lava-882590/bin/lava-test-runner /lava=
-882590/1 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6sx-sdb                   | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8555192ffbaaed7915ec7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/multi_v7_defconfig/gcc-10/lab-nxp/b=
aseline-imx6sx-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/multi_v7_defconfig/gcc-10/lab-nxp/b=
aseline-imx6sx-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c8555192ffbaaed7915eca
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6)

    2023-01-18T20:23:22.645738  / # #
    2023-01-18T20:23:23.805525  export SHELL=3D/bin/sh
    2023-01-18T20:23:23.811205  #
    2023-01-18T20:23:25.358017  / # export SHELL=3D/bin/sh. /lava-1140198/e=
nvironment
    2023-01-18T20:23:25.363482  =

    2023-01-18T20:23:25.363689  / # . /lava-1140198/environment
    2023-01-18T20:23:28.182253  //lava-1140198/bin/lava-test-runner /lava-1=
140198/1
    2023-01-18T20:23:28.202656   # /lava-1140198/bin/lava-test-runner /lava=
-1140198/1
    2023-01-18T20:23:28.294680  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T20:23:28.294908  + cd /lava-1140198/1/tests/1_bootrr =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c857d9e162576061915ec9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm64/defconfig/gcc-10/lab-broonie/base=
line-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm64/defconfig/gcc-10/lab-broonie/base=
line-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c857d9e162576061915=
eca
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c855c471d7affcde915f13

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm64/defconfig/gcc-10/lab-broonie/base=
line-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm64/defconfig/gcc-10/lab-broonie/base=
line-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c855c471d7affcde915=
f14
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c853f791aadfc7b2915eb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c853f791aadfc7b2915=
eba
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7796-m3ulcb               | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85369f19105e976915ec7

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm64/defconfig/gcc-10/lab-collabora/ba=
seline-r8a7796-m3ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm64/defconfig/gcc-10/lab-collabora/ba=
seline-r8a7796-m3ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85369f19105e976915ecc
        new failure (last pass: v4.19.265-cip85-rt27)

    2023-01-18T20:15:12.824890  / # #
    2023-01-18T20:15:12.926924  export SHELL=3D/bin/sh
    2023-01-18T20:15:12.927591  #
    2023-01-18T20:15:13.028991  / # export SHELL=3D/bin/sh. /lava-8784827/e=
nvironment
    2023-01-18T20:15:13.029606  =

    2023-01-18T20:15:13.130929  / # . /lava-8784827/environment/lava-878482=
7/bin/lava-test-runner /lava-8784827/1
    2023-01-18T20:15:13.131747  =

    2023-01-18T20:15:13.132708  / # /lava-8784827/bin/lava-test-runner /lav=
a-8784827/1
    2023-01-18T20:15:13.191505  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T20:15:13.191793  +<8>[   19.625668] <LAVA_SIGNAL_STARTRUN 1_=
bootrr 8784827_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 7          =


  Details:     https://kernelci.org/test/plan/id/63c851adf6569234d2915ed6

  Results:     79 PASS, 9 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rk3399-gru-sound-driver-rt5514-present: https://kernelc=
i.org/test/case/id/63c851adf6569234d2915f0d
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:08:03.603777  =

    2023-01-18T20:08:03.604747  RST [INC]] LAST
    2023-01-18T20:08:03.604829  =

    2023-01-18T20:08:03.609467  Print numbers from FIRST to LAST, in steps =
of INC.
    2023-01-18T20:08:03.612796  FIRST, INC default to 1.
    2023-01-18T20:08:03.612880  =

    2023-01-18T20:08:03.615791  	-w	Pad to last with leading zeros
    2023-01-18T20:08:03.619005  	-s SEP	String separator
    2023-01-18T20:08:03.631486  /lava-8784560/1/../bin/lava-tes<8>[   34.72=
6863] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-driver-rt5514-p=
resent RESULT=3Dfail>   =


  * baseline.bootrr.rk3399-gru-sound-driver-max98357A-present: https://kern=
elci.org/test/case/id/63c851adf6569234d2915f0e
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:08:03.572701  =

    2023-01-18T20:08:03.583165  va-8784560/1/../bin/lava-test-case
    2023-01-18T20:08:03.589377  BusyBox v1.31.1 (2023-01-15 00:20:44 UTC) m=
ulti-call binary.
    2023-01-18T20:08:03.589466  =

    2023-01-18T20:08:03.603257  Usage: seq [-w] [-s SEP] [FI<8>[   34.69681=
5] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-driver-max98357A-p=
resent RESULT=3Dfail>   =


  * baseline.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelci.or=
g/test/case/id/63c851adf6569234d2915f0f
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:08:03.548544  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST
    2023-01-18T20:08:03.548818  =

    2023-01-18T20:08:03.548893  =

    2023-01-18T20:08:03.553516  Print numbers from FIRST to LAST, in steps =
of INC.
    2023-01-18T20:08:03.556688  FIRST, INC default to 1.
    2023-01-18T20:08:03.556776  =

    2023-01-18T20:08:03.559488  	-w	Pad to last with leading zeros
    2023-01-18T20:08:03.562609  	-s SEP	String separator
    2023-01-18T20:08:03.572177  /la<8>[   34.668174] <LAVA_SIGNAL_TESTCASE =
TEST_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>   =


  * baseline.bootrr.rk3399-gru-sound-driver-da7219-present: https://kernelc=
i.org/test/case/id/63c851adf6569234d2915f10
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:08:03.516907  <8>[   34.616404] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-present RESULT=3Dpass>
    2023-01-18T20:08:03.533087  BusyBox v1.31.1 (2023-01-15 00:20:44 UTC) m=
ulti-call binary.
    2023-01-18T20:08:03.533357  =

    2023-01-18T20:08:03.543900  <8>[   34.640724] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-sysfs-driver-present: https://kernelci.org/test=
/case/id/63c851adf6569234d2915f17
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:08:02.342764  /lava-8784560/1/../bin/lava-test-case
    2023-01-18T20:08:02.343487  =

    2023-01-18T20:08:02.352688  <8>[   33.452620] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sysfs-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-lightbar-driver-present: https://kernelci.org/t=
est/case/id/63c851adf6569234d2915f20
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:08:01.130670  /lava-8784560/1/../bin/lava-test-case
    2023-01-18T20:08:01.140526  <8>[   32.239799] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-lightbar-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-debugfs-driver-present: https://kernelci.org/te=
st/case/id/63c851adf6569234d2915f29
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:07:58.924143  /lava-8784560/1/../bin/lava-test-case
    2023-01-18T20:07:58.924623  =

    2023-01-18T20:07:58.934000  <8>[   30.033646] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-debugfs-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8542cda0417d8ea915eb9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm64/defconfig/gcc-10/lab-baylibre/bas=
eline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm64/defconfig/gcc-10/lab-baylibre/bas=
eline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c8542cda0417d8ea915ebe
        new failure (last pass: v5.10.145-cip17-rt7)

    2023-01-18T20:18:19.488047  / # #
    2023-01-18T20:18:19.589903  export SHELL=3D/bin/sh
    2023-01-18T20:18:19.590519  #
    2023-01-18T20:18:19.691886  / # export SHELL=3D/bin/sh. /lava-3163040/e=
nvironment
    2023-01-18T20:18:19.692244  =

    2023-01-18T20:18:19.793483  / # . /lava-3163040/environment/lava-316304=
0/bin/lava-test-runner /lava-3163040/1
    2023-01-18T20:18:19.794108  =

    2023-01-18T20:18:19.799156  / # /lava-3163040/bin/lava-test-runner /lav=
a-3163040/1
    2023-01-18T20:18:19.868997  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T20:18:19.869486  + cd /lava-3163040<8>[   15.603874] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 3163040_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85383d2fc334523915ec7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm64/defconfig/gcc-10/lab-collabora/ba=
seline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm64/defconfig/gcc-10/lab-collabora/ba=
seline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85383d2fc334523915ecc
        new failure (last pass: v5.10.145-cip17-rt7)

    2023-01-18T20:15:51.468580  / # #
    2023-01-18T20:15:51.570662  export SHELL=3D/bin/sh
    2023-01-18T20:15:51.571182  #
    2023-01-18T20:15:51.672563  / # export SHELL=3D/bin/sh. /lava-8784830/e=
nvironment
    2023-01-18T20:15:51.673271  =

    2023-01-18T20:15:51.774627  / # . /lava-8784830/environment/lava-878483=
0/bin/lava-test-runner /lava-8784830/1
    2023-01-18T20:15:51.775461  =

    2023-01-18T20:15:51.777775  / # /lava-8784830/bin/lava-test-runner /lav=
a-8784830/1
    2023-01-18T20:15:51.849525  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T20:15:51.849881  + cd /lava-8784830<8>[   15.616108] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 8784830_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85390bf9bece532915ec7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/multi_v7_defconfig/gcc-10/lab-bayli=
bre/baseline-sun8i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/multi_v7_defconfig/gcc-10/lab-bayli=
bre/baseline-sun8i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85390bf9bece532915ecc
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:15:48.387142  / # #
    2023-01-18T20:15:48.489366  export SHELL=3D/bin/sh
    2023-01-18T20:15:48.489953  #
    2023-01-18T20:15:48.591401  / # export SHELL=3D/bin/sh. /lava-3163077/e=
nvironment
    2023-01-18T20:15:48.592082  =

    2023-01-18T20:15:48.693678  / # . /lava-3163077/environment/lava-316307=
7/bin/lava-test-runner /lava-3163077/1
    2023-01-18T20:15:48.694622  =

    2023-01-18T20:15:48.709958  / # /lava-3163077/bin/lava-test-runner /lav=
a-3163077/1
    2023-01-18T20:15:48.785011  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T20:15:48.785677  + cd /lava-3163077/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85190d88c141dc5915ed4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/sunxi_defconfig/gcc-10/lab-baylibre=
/baseline-sun8i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/sunxi_defconfig/gcc-10/lab-baylibre=
/baseline-sun8i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c85190d88c141dc5915ed9
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:07:18.788016  + set +x
    2023-01-18T20:07:18.789994  <8>[    7.979099] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3162807_1.5.2.4.1>
    2023-01-18T20:07:18.895036  / # #
    2023-01-18T20:07:18.996712  export SHELL=3D/bin/sh
    2023-01-18T20:07:18.997130  #
    2023-01-18T20:07:19.098447  / # export SHELL=3D/bin/sh. /lava-3162807/e=
nvironment
    2023-01-18T20:07:19.098814  =

    2023-01-18T20:07:19.200161  / # . /lava-3162807/environment/lava-316280=
7/bin/lava-test-runner /lava-3162807/1
    2023-01-18T20:07:19.200830  =

    2023-01-18T20:07:19.205801  / # /lava-3162807/bin/lava-test-runner /lav=
a-3162807/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8538cc5a2ba2737915f3e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/multi_v7_defconfig/gcc-10/lab-bayli=
bre/baseline-sun8i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/multi_v7_defconfig/gcc-10/lab-bayli=
bre/baseline-sun8i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c8538cc5a2ba2737915f43
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:15:46.296255  / # #
    2023-01-18T20:15:46.398454  export SHELL=3D/bin/sh
    2023-01-18T20:15:46.399130  #
    2023-01-18T20:15:46.500567  / # export SHELL=3D/bin/sh. /lava-3163062/e=
nvironment
    2023-01-18T20:15:46.501208  =

    2023-01-18T20:15:46.602688  / # . /lava-3163062/environment/lava-316306=
2/bin/lava-test-runner /lava-3163062/1
    2023-01-18T20:15:46.603672  =

    2023-01-18T20:15:46.622253  / # /lava-3163062/bin/lava-test-runner /lav=
a-3163062/1
    2023-01-18T20:15:46.704095  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T20:15:46.704777  + cd /lava-3163062/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/63c851766fff2a09e8915ebb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/sunxi_defconfig/gcc-10/lab-baylibre=
/baseline-sun8i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm/sunxi_defconfig/gcc-10/lab-baylibre=
/baseline-sun8i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c851766fff2a09e8915ec0
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc)

    2023-01-18T20:06:56.722105  / # #
    2023-01-18T20:06:56.823897  export SHELL=3D/bin/sh
    2023-01-18T20:06:56.824383  #
    2023-01-18T20:06:56.925730  / # export SHELL=3D/bin/sh. /lava-3162810/e=
nvironment
    2023-01-18T20:06:56.926190  =

    2023-01-18T20:06:57.027543  / # . /lava-3162810/environment/lava-316281=
0/bin/lava-test-runner /lava-3162810/1
    2023-01-18T20:06:57.028165  =

    2023-01-18T20:06:57.049515  / # /lava-3162810/bin/lava-test-runner /lav=
a-3162810/1
    2023-01-18T20:06:57.121183  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T20:06:57.121456  + cd /lava-3162810/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

