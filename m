Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884EEC7EE29
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 01:30:56 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web10.10304.1684805454003605953
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 May 2023 18:30:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=u90ry5CB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-64d2a87b9daso3433399b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 22 May 2023 18:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684805453; x=1687397453;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fRrAu+4m2f47uACQL5lEvru7AopmPgaVCD8U5GF1XSE=;
        b=u90ry5CBcAD2ERL42o04riaxgIBQ0KZ7ddw9wV5qpQ/NT2y8CUveiyTSdcYCVze8ov
         O587uKUPuY4XITY97c3MVvD53RrXn//1j1syU1cjmpPfqZZYvq3roDVUjvYr2IJiVnUr
         MszCWd/zNjqawzfyErPBELZIcw4g5Pp/hU892ATMOvm+Ld6ClYJh8Lj4z9Ev8UOtsl61
         o5k/kb0PjdGAHtBMFTqbakZtgwyT9kGT20hx9ipvvm4UrS/JRLat3Yu91+s4anHIdWco
         Ex3W5oKdzfIDJmlQdN9/Z3GktmntUo1gBppAMPRwpIsFsvAE0kOBjkcDARRuruEt+IfR
         l4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684805453; x=1687397453;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fRrAu+4m2f47uACQL5lEvru7AopmPgaVCD8U5GF1XSE=;
        b=I7gDniMYz+BUeOlpnoyby+b9nl/QjaaIXKxnI5fvTJYmE3JGwa4EvEex1fzdEuo81d
         9U5xIE55Ak5iYKzPLdJAF8ZEvNkNE9z6+bcWvJgA4Vo5YVG5vSHIrLABWOvaPGq0cjx2
         detV/bT1APSV7sqK9++rVKq3M5ZwHh2Ais2PFo1qG1ukQQODa90QWl1nZPYLkE1r9sRL
         Q6H4kji4K7SmCFbC6RB8ADhEeQhzXyXEapgeJGA47V7Z3FBRKRmtCb2O0ZD1GmyaPAuT
         z7mnUUY4bPvEjOukTfwc6VXLnwTTVauQXrKWRUOZnkpQcEuQCmTgoZJ8tHkvl5ubuUFk
         1PWw==
X-Gm-Message-State: AC+VfDygeT+p8mSWBRKkN8kh+NQuu6uAR5bCjGugQY2WZ2BgJau9TJEn
	dmzO0n0ysOU3ds/CxIrnvESyizkqey14zp3aIF3lYA==
X-Google-Smtp-Source: ACHHUZ5m/gSG/4vCEwpdmCcOABl3aDGrOBXxSqetaw+bHJkk6Qsku6OlLl6YHeixObrtfmk6xFe1Dw==
X-Received: by 2002:a17:903:446:b0:1af:bb88:343f with SMTP id iw6-20020a170903044600b001afbb88343fmr2671216plb.24.1684805452507;
        Mon, 22 May 2023 18:30:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d19-20020a170902c19300b001ab39cd885esm5408568pld.212.2023.05.22.18.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 18:30:51 -0700 (PDT)
Message-ID: <646c174b.170a0220.855b7.97ed@mx.google.com>
Date: Mon, 22 May 2023 18:30:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip33-11-gfea7994097935
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-nfs: 46 runs,
 9 regressions (v5.10.180-cip33-11-gfea7994097935)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 01:30:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11594

cip/linux-5.10.y-cip baseline-nfs: 46 runs, 9 regressions (v5.10.180-cip33-=
11-gfea7994097935)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip33-11-gfea7994097935/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip33-11-gfea7994097935
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      fea799409793527f9b9b2d2c53f0dc4e3ac7ac6a =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0dc6be84a2f8ea2e85ec

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/646c0dc6be84a2f8ea2e8621
        failing since 128 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-23T00:49:32.813669  + set +x
    2023-05-23T00:49:32.937851  #
    2023-05-23T00:49:33.040990  / # #export SHELL=3D/bin/sh
    2023-05-23T00:49:33.041822  =

    2023-05-23T00:49:33.143683  / # export SHELL=3D/bin/sh. /lava-498803/en=
vironment
    2023-05-23T00:49:33.144483  =

    2023-05-23T00:49:33.246485  / # . /lava-498803/environment/lava-498803/=
bin/lava-test-runner /lava-498803/1
    2023-05-23T00:49:33.247928  =

    2023-05-23T00:49:33.254714  / # /lava-498803/bin/lava-test-runner /lava=
-498803/1
    2023-05-23T00:49:33.652104  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0de3be84a2f8ea2e8634

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/646c0de3be84a2f8ea2e866a
        failing since 111 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.165-cip25)

    2023-05-23T00:50:25.784974  <8>[   45.435093] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 498828_1.6.2.4.1>
    2023-05-23T00:50:25.903192  / # #
    2023-05-23T00:50:26.004774  export SHELL=3D/bin/sh
    2023-05-23T00:50:26.005378  #
    2023-05-23T00:50:26.107068  / # export SHELL=3D/bin/sh. /lava-498828/en=
vironment
    2023-05-23T00:50:26.107702  =

    2023-05-23T00:50:26.209622  / # . /lava-498828/environment/lava-498828/=
bin/lava-test-runner /lava-498828/1
    2023-05-23T00:50:26.210495  =

    2023-05-23T00:50:26.214721  / # /lava-498828/bin/lava-test-runner /lava=
-498828/1
    2023-05-23T00:50:26.433556  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0feabb4fab9d872e8642

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/646c0feabb4fab9d872e8647
        failing since 38 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-05-23T00:59:02.584707  + set[   21.916690] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10419698_1.5.2.3.1>

    2023-05-23T00:59:02.584785   +x

    2023-05-23T00:59:02.688815  / # #

    2023-05-23T00:59:02.789398  export SHELL=3D/bin/sh

    2023-05-23T00:59:02.789620  #

    2023-05-23T00:59:02.890136  / # export SHELL=3D/bin/sh. /lava-10419698/=
environment

    2023-05-23T00:59:02.890361  =


    2023-05-23T00:59:02.990916  / # . /lava-10419698/environment/lava-10419=
698/bin/lava-test-runner /lava-10419698/1

    2023-05-23T00:59:02.991266  =


    2023-05-23T00:59:02.995708  / # /lava-10419698/bin/lava-test-runner /la=
va-10419698/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0fd863f6f5616f2e866c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/646c0fd863f6f5616f2e8671
        failing since 38 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-05-23T00:58:44.958126  + set +x

    2023-05-23T00:58:44.964272  <8>[   19.475990] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10419703_1.5.2.3.1>

    2023-05-23T00:58:45.069026  / # #

    2023-05-23T00:58:45.169848  export SHELL=3D/bin/sh

    2023-05-23T00:58:45.170067  #

    2023-05-23T00:58:45.270603  / # export SHELL=3D/bin/sh. /lava-10419703/=
environment

    2023-05-23T00:58:45.270807  =


    2023-05-23T00:58:45.371336  / # . /lava-10419703/environment/lava-10419=
703/bin/lava-test-runner /lava-10419703/1

    2023-05-23T00:58:45.371606  =


    2023-05-23T00:58:45.376644  / # /lava-10419703/bin/lava-test-runner /la=
va-10419703/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0ebfc31ef496d62e8610

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/646c0ebfc31ef496d62e8613
        failing since 128 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-23T00:54:04.172582  / # #

    2023-05-23T00:54:04.274974  export SHELL=3D/bin/sh

    2023-05-23T00:54:04.275258  #

    2023-05-23T00:54:04.376114  / # export SHELL=3D/bin/sh. /lava-10419619/=
environment

    2023-05-23T00:54:04.376517  =


    2023-05-23T00:54:04.477683  / # . /lava-10419619/environment/lava-10419=
619/bin/lava-test-runner /lava-10419619/1

    2023-05-23T00:54:04.478840  =


    2023-05-23T00:54:04.495280  / # /lava-10419619/bin/lava-test-runner /la=
va-10419619/1

    2023-05-23T00:54:04.621218  + export TESTRUN_ID=3D1_bootrr

    2023-05-23T00:54:04.621790  + cd /lava-10419619/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0e0b3238281fa92e8614

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/646c0e0b3238281fa=
92e8615
        new failure (last pass: v5.10.180-cip33) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/646c0d566f6740ad3b2e8613

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/646c0d566f6740ad3b2e8619
        failing since 61 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-05-23T00:48:15.468066  /lava-10419418/1/../bin/lava-test-case

    2023-05-23T00:48:15.494029  [   98.211313] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/646c0d566f6740ad3b2e861a
        failing since 61 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-05-23T00:48:13.314121  [   96.030241] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-05-23T00:48:14.371680  /lava-10419418/1/../bin/lava-test-case

    2023-05-23T00:48:14.407683  [   97.124278] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646c118e76d8cb42232e8623

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-su=
n50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-su=
n50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/646c118e76d8cb42232e864f
        failing since 128 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-23T01:06:03.028222  + set +x
    2023-05-23T01:06:03.032331  <8>[   32.035924] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 498920_1.6.2.4.1>
    2023-05-23T01:06:03.151084  / # #
    2023-05-23T01:06:03.253010  export SHELL=3D/bin/sh
    2023-05-23T01:06:03.253579  #
    2023-05-23T01:06:03.355181  / # export SHELL=3D/bin/sh. /lava-498920/en=
vironment
    2023-05-23T01:06:03.355610  =

    2023-05-23T01:06:03.457122  / # . /lava-498920/environment/lava-498920/=
bin/lava-test-runner /lava-498920/1
    2023-05-23T01:06:03.458490  =

    2023-05-23T01:06:03.462525  / # /lava-498920/bin/lava-test-runner /lava=
-498920/1 =

    ... (12 line(s) more)  =

 =20

