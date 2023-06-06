Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94114C77B7A
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 11:00:30 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.6033.1686049221795597475
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Jun 2023 04:00:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=2CuoBVdP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1b04706c85fso55749735ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Jun 2023 04:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686049221; x=1688641221;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WwvCBtPXn6GI+p5RI2do0J2jQEzJdCewqZmLDfrSMrc=;
        b=2CuoBVdPVVsIhYS0bnIOKVHeftQJ7uMtUH1GXGXEKZy/WyKNFYqMQYAg5W/i7wRbVc
         OYDu0DWirw4iQEpAdjMakaNEr0G9PN46EpFd7En7XHf0NJdn7cfe6rEhFuc5pCZA5o9t
         OEKN+tWZ3QOlYph3dCeZioxem6kBhRadKCayqF8CBiw5MtaDwv/c8sT0YvNZ+uhZrAhf
         Ofy5Rhnq0lLv7sHDbENHre2srKFCx3Kv+wIyDuE46Nlx9YfgFviOy1bJv2DMf+9Q+1v1
         /bG2ujlw/+vAdTYy6NKcrooT7z5BF1dnM8GuX7U+UbP0rBSaS9INtv1q4avh9aITPT2y
         kVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686049221; x=1688641221;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwvCBtPXn6GI+p5RI2do0J2jQEzJdCewqZmLDfrSMrc=;
        b=bj334Aue0XWZmLzkpdWVSTRX+Gh/BGJinShzhJQm1XLFSe8+Bm06KxiGSzjWA0C3UR
         tXB+2VxSMscptoA+/uHqZYq0jY8qquFLgAqxfdSLZicrqfWKDZtC5v2s9+GEZ58T/xep
         ohcoto6IuOdGIEmv1n9LcirgNID/TZlJXAPZ9cjXtc4hQdIw3vM0z+xStmPkXFVHucII
         8vay6PhDhsZm6uLtBODKOjwXPuzCQn5U3csSrsXISNO4qh59kCwGmIod+5KpuLztTEJL
         tsBlq4+XR21oyXMJCiPBF1YviIY1wwVVxk3jlXEyV1x609HbHa30fvLN0CExQ1jLb9P7
         x37g==
X-Gm-Message-State: AC+VfDxgE78RNuhWy4AK6SC8D6gJkDqS/NewUj3cv5OC5sn++Cov9lQS
	qBo23HtYkZO6bRYk2rUa/DrAn3bSUFjrgZelIj3RfQ==
X-Google-Smtp-Source: ACHHUZ542BgWEn3k6PUguCTP1xW4+SUTiuiOO8OHBtmnW9CH/EocxsWLiTedOpUVHIKRU3ynSJLQ7g==
X-Received: by 2002:a17:902:e841:b0:1b1:b82c:2b0a with SMTP id t1-20020a170902e84100b001b1b82c2b0amr2022192plg.30.1686049219632;
        Tue, 06 Jun 2023 04:00:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902a38400b001b0457705e8sm8343937pla.140.2023.06.06.04.00.18
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 04:00:19 -0700 (PDT)
Message-ID: <647f11c3.170a0220.f8d9f.fa26@mx.google.com>
Date: Tue, 06 Jun 2023 04:00:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1321-g3152fb7c8d2d6
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 33 runs,
 8 regressions (v6.1.26-1321-g3152fb7c8d2d6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 11:00:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11870

cip-gitlab/ci/pavel/linux-test baseline-nfs: 33 runs, 8 regressions (v6.1.2=
6-1321-g3152fb7c8d2d6)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

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


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1321-g3152fb7c8d2d6/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1321-g3152fb7c8d2d6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3152fb7c8d2d6c6a2c22edfc334cb69a5428ccad =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f0733a618bcb906f5de25

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647f0733a618bcb906f5de2e
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-06T10:15:02.271108  + set +x

    2023-06-06T10:15:02.277289  <8>[   19.528557] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10604328_1.5.2.3.1>

    2023-06-06T10:15:02.382184  / # #

    2023-06-06T10:15:02.482788  export SHELL=3D/bin/sh

    2023-06-06T10:15:02.483029  #

    2023-06-06T10:15:02.583515  / # export SHELL=3D/bin/sh. /lava-10604328/=
environment

    2023-06-06T10:15:02.583707  =


    2023-06-06T10:15:02.684262  / # . /lava-10604328/environment/lava-10604=
328/bin/lava-test-runner /lava-10604328/1

    2023-06-06T10:15:02.684526  =


    2023-06-06T10:15:02.690723  / # /lava-10604328/bin/lava-test-runner /la=
va-10604328/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f08882b20c01f51f5de60

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647f08882b20c01f51f5de69
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-06T10:20:46.495059  <8>[   18.102670] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10604307_1.5.2.3.1>

    2023-06-06T10:20:46.599896  / # #

    2023-06-06T10:20:46.700481  export SHELL=3D/bin/sh

    2023-06-06T10:20:46.700628  #

    2023-06-06T10:20:46.801172  / # export SHELL=3D/bin/sh. /lava-10604307/=
environment

    2023-06-06T10:20:46.801315  =


    2023-06-06T10:20:46.901817  / # . /lava-10604307/environment/lava-10604=
307/bin/lava-test-runner /lava-10604307/1

    2023-06-06T10:20:46.902045  =


    2023-06-06T10:20:46.907213  / # /lava-10604307/bin/lava-test-runner /la=
va-10604307/1

    2023-06-06T10:20:46.988396  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f073015e751b7d9f5ded9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647f073015e751b7d9f5dee2
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-06T10:14:48.364233  <8>[   17.875122] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10604297_1.5.2.3.1>

    2023-06-06T10:14:48.367365  + set +x

    2023-06-06T10:14:48.471583  / # #

    2023-06-06T10:14:48.572300  export SHELL=3D/bin/sh

    2023-06-06T10:14:48.572502  #

    2023-06-06T10:14:48.673054  / # export SHELL=3D/bin/sh. /lava-10604297/=
environment

    2023-06-06T10:14:48.673313  =


    2023-06-06T10:14:48.773957  / # . /lava-10604297/environment/lava-10604=
297/bin/lava-test-runner /lava-10604297/1

    2023-06-06T10:14:48.774236  =


    2023-06-06T10:14:48.779145  / # /lava-10604297/bin/lava-test-runner /la=
va-10604297/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647f09f19ddcb66f63f5de28

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647f09f19ddcb66f6=
3f5de29
        failing since 0 day (last pass: v5.10.180-cip34-26-gc198172c84b6a, =
first fail: v6.1.26-1314-g1ab0ac1d7e2e3) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f093b36167a5edcf5de69

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647f093b36167a5edcf5de72
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31)

    2023-06-06T10:23:35.631450  + set<8>[   19.572930] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10604308_1.5.2.3.1>

    2023-06-06T10:23:35.631546   +x

    2023-06-06T10:23:35.735926  / # #

    2023-06-06T10:23:35.836526  export SHELL=3D/bin/sh

    2023-06-06T10:23:35.836735  #

    2023-06-06T10:23:35.937268  / # export SHELL=3D/bin/sh. /lava-10604308/=
environment

    2023-06-06T10:23:35.937482  =


    2023-06-06T10:23:36.037994  / # . /lava-10604308/environment/lava-10604=
308/bin/lava-test-runner /lava-10604308/1

    2023-06-06T10:23:36.038278  =


    2023-06-06T10:23:36.043254  / # /lava-10604308/bin/lava-test-runner /la=
va-10604308/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f071c63e3027f9ff5de6e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647f071c63e3027f9ff5de77
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-06T10:14:46.383962  + [   18.089833] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 10604269_1.5.2.3.1>

    2023-06-06T10:14:46.384045  set +x

    2023-06-06T10:14:46.488334  / # #

    2023-06-06T10:14:46.588954  export SHELL=3D/bin/sh

    2023-06-06T10:14:46.589166  #

    2023-06-06T10:14:46.689705  / # export SHELL=3D/bin/sh. /lava-10604269/=
environment

    2023-06-06T10:14:46.689914  =


    2023-06-06T10:14:46.790478  / # . /lava-10604269/environment/lava-10604=
269/bin/lava-test-runner /lava-10604269/1

    2023-06-06T10:14:46.790798  =


    2023-06-06T10:14:46.795780  / # /lava-10604269/bin/lava-test-runner /la=
va-10604269/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647f0a76ab4db50382f5de73

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix=
/baseline-nfs-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix=
/baseline-nfs-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647f0a76ab4db5038=
2f5de74
        failing since 0 day (last pass: v5.10.180-cip34-26-gc198172c84b6a, =
first fail: v6.1.26-1314-g1ab0ac1d7e2e3) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f07863704b16e67f5de34

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647f07863704b16e67f5de3d
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-06T10:16:14.933922  <8>[   17.855540] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10604278_1.5.2.3.1>

    2023-06-06T10:16:15.038726  / # #

    2023-06-06T10:16:15.139315  export SHELL=3D/bin/sh

    2023-06-06T10:16:15.139587  #

    2023-06-06T10:16:15.240118  / # export SHELL=3D/bin/sh. /lava-10604278/=
environment

    2023-06-06T10:16:15.240376  =


    2023-06-06T10:16:15.340933  / # . /lava-10604278/environment/lava-10604=
278/bin/lava-test-runner /lava-10604278/1

    2023-06-06T10:16:15.341237  =


    2023-06-06T10:16:15.346154  / # /lava-10604278/bin/lava-test-runner /la=
va-10604278/1

    2023-06-06T10:16:15.391657  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =20

