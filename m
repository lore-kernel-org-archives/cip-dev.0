Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52389C77B7D
	for <webhook@archiver.kernel.org>; Wed, 17 May 2023 14:38:40 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web11.51861.1684334315394269950
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 17 May 2023 07:38:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=wRQgtysP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-643a1fed360so592549b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 17 May 2023 07:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684334314; x=1686926314;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5/cQd1F4F3M1omZk3bt+LauxYBODvERIIV3ewvwomPA=;
        b=wRQgtysPRxlEHENfhbNsp2oTzsrOrLm0gvvZCvEkftD2YYIjVZQ4mQiW6IB6iRmug6
         l+y/OxivqzxyKn1IFtdi9kPJmf/rQjW651irYCwx5q0qkfWubECWk6KYiCN8yfBNhIo/
         Ci3BmAsfz8rq0N11GkdQvJkBkblGkP6I0E7iiJxxTgfUl0KC7GALU1XI+JSdX0CTbRxG
         KtPb5yMwADfXXj4W1Fb2MV6UDoQD1mU6tkgYkVZClLMU8r/xh0dX7mBHIKr7MplT5AyV
         x5AboXFMbYJq1oPNLVbx43DisPeDDb/LfCsnCp+REievJJWe4gPXWS8Dc4IPvRxHLFex
         b+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684334314; x=1686926314;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/cQd1F4F3M1omZk3bt+LauxYBODvERIIV3ewvwomPA=;
        b=Irl8u40evO9f+gL2MJlIC/+r37PC1Ar3iCZyOP3QuLcL+J9qrICEbb3FanUo2lQp9j
         ciEJhWOH/K3O43IK8ArscLsEiolKjjtYXL1C0GqOQdPfhX31fgZiaXy4nobXJwkBI1x1
         8X/UJeEoaRND9NzY145LVR18HYOLZcRgD8gBQn5JPfgDmoYoKRuDYJG0x3iPwoc9HHca
         ps/1PbwfQY2eHbcPMjR4WcKz+gioq2Nbd7gWRYGGXIvH9P2LqsOObAMdZLQzj+BuHVNu
         TJ+qHcPp2oWIcwV2Cv8C/kpAoJnNHYcj62fignmS7IAFKaHSAodA+jMXXHVHDy1jyYUt
         FwdQ==
X-Gm-Message-State: AC+VfDyRE4Y9//s5JKiVj2aPanI3Xndf9B3cvvcMvb9e5ci5v/49gORN
	opUb3GfSYY91sQCiHg4Xmfl0URd26TxT/w6Vh3glSw==
X-Google-Smtp-Source: ACHHUZ5sKwTv5BlbuOuf6c3IbRQ519k2mFhpHGwzyVIYe6hFnujdLaHWRlCNJLN3Bwi78of10wekDQ==
X-Received: by 2002:a05:6a00:2313:b0:646:3162:31a2 with SMTP id h19-20020a056a00231300b00646316231a2mr1337617pfh.17.1684334313130;
        Wed, 17 May 2023 07:38:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i2-20020aa78b42000000b006466d70a313sm15243550pfd.120.2023.05.17.07.38.32
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 07:38:32 -0700 (PDT)
Message-ID: <6464e6e8.a70a0220.46300.e288@mx.google.com>
Date: Wed, 17 May 2023 07:38:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.179-cip32-384-g291adc46abef0
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 149 runs,
 12 regressions (v5.10.179-cip32-384-g291adc46abef0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 May 2023 14:38:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11500

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 149 runs, 12 regressio=
ns (v5.10.179-cip32-384-g291adc46abef0)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

odroid-xu3                   | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.179-cip32-384-g291adc46abef0/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.179-cip32-384-g291adc46abef0
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      291adc46abef012487ba16bb07999af85de2d34d =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6464dea5dcc5fa4c802e862b

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464dea5dcc5fa4c802e8660
        failing since 133 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-05-17T14:03:02.269663  <8>[   20.438822] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 473779_1.5.2.4.1>
    2023-05-17T14:03:02.379620  / # #
    2023-05-17T14:03:02.482049  export SHELL=3D/bin/sh
    2023-05-17T14:03:02.482743  #
    2023-05-17T14:03:02.584489  / # export SHELL=3D/bin/sh. /lava-473779/en=
vironment
    2023-05-17T14:03:02.585081  =

    2023-05-17T14:03:02.686996  / # . /lava-473779/environment/lava-473779/=
bin/lava-test-runner /lava-473779/1
    2023-05-17T14:03:02.687902  =

    2023-05-17T14:03:02.691327  / # /lava-473779/bin/lava-test-runner /lava=
-473779/1
    2023-05-17T14:03:02.795836  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6464e0ca4fab0ffa482e860b

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464e0ca4fab0ffa482e860e
        failing since 133 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-05-17T14:12:09.841936  <8>[   13.017628] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 935124_1.5.2.4.1>
    2023-05-17T14:12:09.951518  / # #
    2023-05-17T14:12:10.053825  export SHELL=3D/bin/sh
    2023-05-17T14:12:10.054527  #
    2023-05-17T14:12:10.156288  / # export SHELL=3D/bin/sh. /lava-935124/en=
vironment
    2023-05-17T14:12:10.156997  =

    2023-05-17T14:12:10.258865  / # . /lava-935124/environment/lava-935124/=
bin/lava-test-runner /lava-935124/1
    2023-05-17T14:12:10.259911  =

    2023-05-17T14:12:10.266324  / # /lava-935124/bin/lava-test-runner /lava=
-935124/1
    2023-05-17T14:12:10.370065  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6464da383aa32e7d582e85e9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4=
020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4=
020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464da383aa32e7d582e85ee
        failing since 26 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-17T13:44:12.969539  + set +x

    2023-05-17T13:44:12.976004  <8>[   13.804955] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10354772_1.4.2.3.1>

    2023-05-17T13:44:13.080166  / # #

    2023-05-17T13:44:13.180847  export SHELL=3D/bin/sh

    2023-05-17T13:44:13.181044  #

    2023-05-17T13:44:13.281589  / # export SHELL=3D/bin/sh. /lava-10354772/=
environment

    2023-05-17T13:44:13.281781  =


    2023-05-17T13:44:13.382294  / # . /lava-10354772/environment/lava-10354=
772/bin/lava-test-runner /lava-10354772/1

    2023-05-17T13:44:13.382614  =


    2023-05-17T13:44:13.386914  / # /lava-10354772/bin/lava-test-runner /la=
va-10354772/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464db417f29e4e02d2e860b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopu=
s.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopu=
s.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464db417f29e4e02d2e8610
        failing since 26 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-17T13:48:34.419013  + <8>[   19.103330] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10354936_1.4.2.3.1>

    2023-05-17T13:48:34.419448  set +x

    2023-05-17T13:48:34.527241  =


    2023-05-17T13:48:34.629130  / # #export SHELL=3D/bin/sh

    2023-05-17T13:48:34.629795  =


    2023-05-17T13:48:34.731159  / # export SHELL=3D/bin/sh. /lava-10354936/=
environment

    2023-05-17T13:48:34.731905  =


    2023-05-17T13:48:34.833522  / # . /lava-10354936/environment/lava-10354=
936/bin/lava-test-runner /lava-10354936/1

    2023-05-17T13:48:34.835199  =


    2023-05-17T13:48:34.839328  / # /lava-10354936/bin/lava-test-runner /la=
va-10354936/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6464da202fe34da3772e8657

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464da202fe34da3772e865c
        failing since 26 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-17T13:43:47.467664  <8>[   15.914550] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10354796_1.4.2.3.1>

    2023-05-17T13:43:47.471253  + set +x

    2023-05-17T13:43:47.572516  #

    2023-05-17T13:43:47.673338  / # #export SHELL=3D/bin/sh

    2023-05-17T13:43:47.673552  =


    2023-05-17T13:43:47.774073  / # export SHELL=3D/bin/sh. /lava-10354796/=
environment

    2023-05-17T13:43:47.774315  =


    2023-05-17T13:43:47.874863  / # . /lava-10354796/environment/lava-10354=
796/bin/lava-test-runner /lava-10354796/1

    2023-05-17T13:43:47.875203  =


    2023-05-17T13:43:47.880692  / # /lava-10354796/bin/lava-test-runner /la=
va-10354796/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464db0b51054af4d62e860c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464db0b51054af4d62e8611
        failing since 26 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-17T13:47:40.959740  + set +x<8>[   11.996318] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10354943_1.4.2.3.1>

    2023-05-17T13:47:40.960172  =


    2023-05-17T13:47:41.067116  /#

    2023-05-17T13:47:41.169647   # #export SHELL=3D/bin/sh

    2023-05-17T13:47:41.170428  =


    2023-05-17T13:47:41.271843  / # export SHELL=3D/bin/sh. /lava-10354943/=
environment

    2023-05-17T13:47:41.272527  =


    2023-05-17T13:47:41.373896  / # . /lava-10354943/environment/lava-10354=
943/bin/lava-test-runner /lava-10354943/1

    2023-05-17T13:47:41.375165  =


    2023-05-17T13:47:41.379971  / # /lava-10354943/bin/lava-test-runner /la=
va-10354943/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
odroid-xu3                   | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6464db21bb3f95daec2e8623

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-odroid-xu3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-odroid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6464db21bb3f95daec2e8=
624
        new failure (last pass: v5.10.177-cip31-122-gfb6ca504156b4) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6464dd0a2133754a5e2e85f6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6464dd0a2133754a5e2e8=
5f7
        new failure (last pass: v5.10.177-cip31-122-gfb6ca504156b4) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6464dcdbc8029541062e85e6

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6464dcdbc8029541062e85ec
        failing since 26 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-17T13:55:26.238034  /lava-10355015/1/../bin/lava-test-case

    2023-05-17T13:55:26.249637  <8>[   62.103121] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6464dcdbc8029541062e85ed
        failing since 26 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-17T13:55:25.201814  /lava-10355015/1/../bin/lava-test-case

    2023-05-17T13:55:25.212477  <8>[   61.066583] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/6464ddcb0e1337c4ef2e85eb

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6464ddcb0e1337c4ef2e85f1
        failing since 26 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-17T13:59:31.295574  <8>[   42.937975] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-05-17T13:59:32.364972  /lava-10355296/1/../bin/lava-test-case

    2023-05-17T13:59:32.389436  <8>[   44.034014] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6464ddcb0e1337c4ef2e85f2
        failing since 26 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-17T13:59:31.269194  /lava-10355296/1/../bin/lava-test-case
   =

 =20

