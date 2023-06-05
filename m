Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CA4C7EE24
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 11:30:12 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.5083.1685964603882033867
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 04:30:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=RKE8cj2B;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1b011cffe7fso20371965ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 04:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685964603; x=1688556603;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9MG/MYJCFCoqGqgia+JKAJY2J83WMVSwmHqNmsGpGnQ=;
        b=RKE8cj2BP30oPW97hN984q8i1GsV9+49C5PIZkQrqP5JvNJlY42dV/uSj6UFh7mcyk
         qq5l0Uhr1MCVu3KvokmH0jlvwNewMwPfFSBHa/VTZ1tYGVZXZIHrlbJVAwOladgHUTHt
         OGvNYlAaifzRIDc+sVl+OHR+CW9gBLHdX8edpvw21uVIU9CN44oe4pEP9aY36d0m9dTA
         iwKQ/80+4HwWWeMY+Fl+zl63lmcMIMgXaVAqY3VgixlL3oDe10hxlv1Lcx7ngdKiAXiG
         Gt/7b+8ON8EAGqklzf94Ek1VTQuE9LNVtvCvGebuJSgFa2znwcBDsvwtby6vBGpDM8sc
         apYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685964603; x=1688556603;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MG/MYJCFCoqGqgia+JKAJY2J83WMVSwmHqNmsGpGnQ=;
        b=IJ3TPZ0KDKXL5mHlX541jsDeLkxRjk5aLy2Lm60qFhQt4oXPv2UymyNZgLHadNUbD/
         bRn4Prm4pc/m2Jmpd4WpZ0B6vjfn/yBaWjwcLC1qxmsw50yx8UOwFPsI17aGq5tZHx3F
         YZAuG3a4w8GPEX9lW7jw/pwnXMf81DqYHUyv7TA1oKNUH+z6RUcyyb9EwrnaLEpfBtHN
         7WVOHvpKDNhE2xGBb0AtfX/nD3N6vpjZULB/PdZAi9fBQ/YjEW0kcsTYk/S/GSPefQpN
         IPCh7GK1+kv/355bYJvL07kNIQZsOMzEfojvk8GsmN918lz8cETZBOrpwJXrvY7TG43B
         Wt+g==
X-Gm-Message-State: AC+VfDysCbLMcUTBTjlXZGTcvJEKlYp9/xo/M65WChR5UDeUAMx69oKX
	woFcDvE/vHhMsUjIt17GcuaGXL2nEthFqOdmU4TQDA==
X-Google-Smtp-Source: ACHHUZ765Yl/ZJCvhv5Ts+/8at1CdPbY+nWezVdrZVBA6lERJlLxyDW5XIyU2nMBbSv7hRU7iyCDSA==
X-Received: by 2002:a17:902:d502:b0:1b0:2f03:8581 with SMTP id b2-20020a170902d50200b001b02f038581mr2770832plg.44.1685964602711;
        Mon, 05 Jun 2023 04:30:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jj11-20020a170903048b00b001ac4e316b51sm6389623plb.109.2023.06.05.04.30.02
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 04:30:02 -0700 (PDT)
Message-ID: <647dc73a.170a0220.354de.af17@mx.google.com>
Date: Mon, 05 Jun 2023 04:30:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1298-g61395b9756bd5
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 46 runs,
 10 regressions (v6.1.26-1298-g61395b9756bd5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 11:30:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11804

cip-gitlab/ci/pavel/linux-test baseline-nfs: 46 runs, 10 regressions (v6.1.=
26-1298-g61395b9756bd5)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig            | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1298-g61395b9756bd5/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1298-g61395b9756bd5
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      61395b9756bd5614e204ba22b9c75fd47c24a999 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647dbb477531f413f8f5de26

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647dbb477531f413f8f5de2f
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-05T10:38:36.115799  + [   17.553672] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 10590821_1.5.2.3.1>

    2023-06-05T10:38:36.115885  set +x

    2023-06-05T10:38:36.220409  / # #

    2023-06-05T10:38:36.320950  export SHELL=3D/bin/sh

    2023-06-05T10:38:36.321088  #

    2023-06-05T10:38:36.421579  / # export SHELL=3D/bin/sh. /lava-10590821/=
environment

    2023-06-05T10:38:36.421959  =


    2023-06-05T10:38:36.522518  / # . /lava-10590821/environment/lava-10590=
821/bin/lava-test-runner /lava-10590821/1

    2023-06-05T10:38:36.522784  =


    2023-06-05T10:38:36.527921  / # /lava-10590821/bin/lava-test-runner /la=
va-10590821/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/647dbadf9e362f65b1f5de59

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm/at91_dt_defconfig/gcc-10/lab-broonie/basel=
ine-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm/at91_dt_defconfig/gcc-10/lab-broonie/basel=
ine-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647dbadf9e362f65b=
1f5de5a
        failing since 0 day (last pass: v6.1.26-1281-g84d5372e0f31, first f=
ail: v6.1.26-1301-g6369cf0363211) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647dbd4bf5730eb18cf5de3f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm/multi_v5_defconfig/gcc-10/lab-broonie/base=
line-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm/multi_v5_defconfig/gcc-10/lab-broonie/base=
line-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647dbd4bf5730eb18=
cf5de40
        failing since 0 day (last pass: v6.1.26-1301-g6369cf0363211, first =
fail: v6.1.26-1302-g2631206dd75c2) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647dbc98bb8829b2eef5dea7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647dbc98bb8829b2e=
ef5dea8
        new failure (last pass: v6.1.26-1302-g2631206dd75c2) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647dbf7d15edf9140af5df85

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647dbf7d15edf9140=
af5df86
        new failure (last pass: v6.1.26-1302-g2631206dd75c2) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647dbba82dee232a26f5de25

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647dbba82dee232a26f5de2e
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-05T10:40:21.007704  + set +x

    2023-06-05T10:40:21.013621  [   21.323673] <LAVA_SIGNAL_ENDRUN 0_dmesg =
10590858_1.5.2.3.1>

    2023-06-05T10:40:21.118022  / # #

    2023-06-05T10:40:21.218648  export SHELL=3D/bin/sh

    2023-06-05T10:40:21.218847  #

    2023-06-05T10:40:21.319364  / # export SHELL=3D/bin/sh. /lava-10590858/=
environment

    2023-06-05T10:40:21.319572  =


    2023-06-05T10:40:21.420143  / # . /lava-10590858/environment/lava-10590=
858/bin/lava-test-runner /lava-10590858/1

    2023-06-05T10:40:21.420437  =


    2023-06-05T10:40:21.425112  / # /lava-10590858/bin/lava-test-runner /la=
va-10590858/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647dbb525c26b85cedf5de8b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647dbb525c26b85cedf5de94
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-05T10:38:57.764221  [   17.895126] <LAVA_SIGNAL_ENDRUN 0_dmesg =
10590827_1.5.2.3.1>

    2023-06-05T10:38:57.868410  / # #

    2023-06-05T10:38:57.970236  export SHELL=3D/bin/sh

    2023-06-05T10:38:57.971167  #

    2023-06-05T10:38:58.072549  / # export SHELL=3D/bin/sh. /lava-10590827/=
environment

    2023-06-05T10:38:58.072742  =


    2023-06-05T10:38:58.173317  / # . /lava-10590827/environment/lava-10590=
827/bin/lava-test-runner /lava-10590827/1

    2023-06-05T10:38:58.174555  =


    2023-06-05T10:38:58.179499  / # /lava-10590827/bin/lava-test-runner /la=
va-10590827/1

    2023-06-05T10:38:58.273483  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647dbd77f5730eb18cf5de80

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix=
/baseline-nfs-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix=
/baseline-nfs-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647dbd77f5730eb18=
cf5de81
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647dbb5a0f054801b9f5de35

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647dbb5a0f054801b9f5de3e
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-05T10:38:56.807247  [   18.748604] <LAVA_SIGNAL_ENDRUN 0_dmesg =
10590866_1.5.2.3.1>

    2023-06-05T10:38:56.912293  / # #

    2023-06-05T10:38:57.014662  export SHELL=3D/bin/sh

    2023-06-05T10:38:57.015385  #

    2023-06-05T10:38:57.116844  / # export SHELL=3D/bin/sh. /lava-10590866/=
environment

    2023-06-05T10:38:57.117633  =


    2023-06-05T10:38:57.219322  / # . /lava-10590866/environment/lava-10590=
866/bin/lava-test-runner /lava-10590866/1

    2023-06-05T10:38:57.220352  =


    2023-06-05T10:38:57.224992  / # /lava-10590866/bin/lava-test-runner /la=
va-10590866/1

    2023-06-05T10:38:57.280943  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647dbdd8e217768eacf5de67

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm64/defconfig/gcc-10/lab-collabora/baseline-=
nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm64/defconfig/gcc-10/lab-collabora/baseline-=
nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647dbdd8e217768eacf5de70
        failing since 1 day (last pass: v5.10.180-cip33-11-gfea7994097935, =
first fail: v6.1.26-1281-g84d5372e0f31)

    2023-06-05T10:49:36.583429  / # #

    2023-06-05T10:49:37.849160  export SHELL=3D/bin/sh

    2023-06-05T10:49:37.860145  #

    2023-06-05T10:49:39.612733  / # export SHELL=3D/bin/sh. /lava-10590956/=
environment

    2023-06-05T10:49:39.623788  =


    2023-06-05T10:49:39.624299  / # . /lava-10590956/environment

    2023-06-05T10:49:42.834229  / # /lava-10590956/bin/lava-test-runner /la=
va-10590956/1

    2023-06-05T10:49:42.849379  /lava-10590956/bin/lava-test-runner /lava-1=
0590956/1

    2023-06-05T10:49:43.069025  + export TESTRUN_ID=3D1_bootrr

    2023-06-05T10:49:43.069553  + cd /lava-10590956/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =20

