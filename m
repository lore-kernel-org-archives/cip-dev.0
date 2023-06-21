Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E963EB64D7
	for <webhook@archiver.kernel.org>; Wed, 21 Jun 2023 19:33:35 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web10.7776.1687376009512377069
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 21 Jun 2023 12:33:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=yyGzHMj8;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1b51414b080so37153355ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 21 Jun 2023 12:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687376008; x=1689968008;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8cHhxG70dTdonPsbzQvSDRf9kTBLTVO0dVvWlFRTSZY=;
        b=yyGzHMj8yrJhVB9yBbXEdn37bapI3YTMIw3DBm1OzWK5NMMWDOMFYlorNxB+p03CU1
         0DDw+JDTD5U9AQ4uEeM59xUIbm//B8oNyFv0dv0UtcLXwqvungskq1pv5Wu3CJgYZ9pr
         uZRlmb7I+JbfKHdWY30Ix7yN/jI5NU5DQAdCXnWhZxCoVcDIi6fRCgGxbMZTvI/Ym2BW
         HMgFbPv+v/EVff0/pvXmrVFRO5YpO/gjkfzErQIiNcxq1Dl0o1HTAGScdRNS5yoN224y
         G5o8vNqIhAIus0OYzNJkmE7BR8d2FXIx5XE3mlXp5dVbDXC9Isc2VWhywerD81ACsq29
         nSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376008; x=1689968008;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8cHhxG70dTdonPsbzQvSDRf9kTBLTVO0dVvWlFRTSZY=;
        b=NsieypKd6zGHmsIeZaBqbn69tpUU/nGaQaKrM9UaDPXaaH/dFZt5I0eEoJXLzqWq60
         fQCuxtU0GuQfHNawCZcDviiZHg9FWROiBhHEr/pIrrn7ZVciu4mu0i/3Ojssq6R1Vmje
         FDrAJtp06EuNkusJdiq/0AM/ymKlO/XnO+zvx/YXbcWN8WoK6y0WiGmhN+cm2Ny5D0xd
         FOClP09oVT6jCgi777y1rqOIFXil1qCbdAoyShoAcedIgv2ogfbnRbnS5w//ZvAbUpgC
         bMQlvsaj5gmG2PNn5cPU94pQgAHC+Llf9Zm0VJ5JqxxdLxBab1BSnAm6wK+CdpVeF1mO
         lDZw==
X-Gm-Message-State: AC+VfDyV73Bc5EpJ++WncFc7tuy8Ccm79hmBf6S28YWQg8kLTf/QZ+c2
	1s1NkO8eyV32Y9uCG+HHpNo9YisQl/Sy5DoKwmiseg==
X-Google-Smtp-Source: ACHHUZ4dDcammwxXJbVDUfD39PsJ5i02csD+OQXNkNTTDIr2o5FzZB+JTHP5zlKDST7Gx0qOoSj8VQ==
X-Received: by 2002:a17:902:cec9:b0:1af:f751:1be4 with SMTP id d9-20020a170902cec900b001aff7511be4mr15695896plg.63.1687376008093;
        Wed, 21 Jun 2023 12:33:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f20-20020a170902ab9400b001b027221393sm3887794plr.43.2023.06.21.12.33.27
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:33:27 -0700 (PDT)
Message-ID: <64935087.170a0220.83cc8.8c88@mx.google.com>
Date: Wed, 21 Jun 2023 12:33:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-289-g3c0549540706
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 140 runs,
 9 regressions (v5.10.182-cip35-289-g3c0549540706)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Jun 2023 19:33:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12095

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 140 runs, 9 regression=
s (v5.10.182-cip35-289-g3c0549540706)

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

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.182-cip35-289-g3c0549540706/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.182-cip35-289-g3c0549540706
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3c0549540706be602c1cc58f7ebdcae39509baa7 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6493412162b46d359a30616a

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6493412162b46d359a3061a2
        failing since 168 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-06-21T18:27:21.651104  <8>[   19.625002] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 647408_1.5.2.4.1>
    2023-06-21T18:27:21.761311  / # #
    2023-06-21T18:27:21.864981  export SHELL=3D/bin/sh
    2023-06-21T18:27:21.865859  #
    2023-06-21T18:27:21.968384  / # export SHELL=3D/bin/sh. /lava-647408/en=
vironment
    2023-06-21T18:27:21.969307  =

    2023-06-21T18:27:22.071949  / # . /lava-647408/environment/lava-647408/=
bin/lava-test-runner /lava-647408/1
    2023-06-21T18:27:22.073607  =

    2023-06-21T18:27:22.078264  / # /lava-647408/bin/lava-test-runner /lava=
-647408/1
    2023-06-21T18:27:22.175381  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/649346e5c8bacc0df7306131

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649346e5c8bacc0df7306138
        failing since 168 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-06-21T18:52:12.182132  <8>[   13.036391] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 970010_1.5.2.4.1>
    2023-06-21T18:52:12.291383  / # #
    2023-06-21T18:52:12.392667  export SHELL=3D/bin/sh
    2023-06-21T18:52:12.392953  #
    2023-06-21T18:52:12.494039  / # export SHELL=3D/bin/sh. /lava-970010/en=
vironment
    2023-06-21T18:52:12.494321  =

    2023-06-21T18:52:12.595409  / # . /lava-970010/environment/lava-970010/=
bin/lava-test-runner /lava-970010/1
    2023-06-21T18:52:12.595867  =

    2023-06-21T18:52:12.602156  / # /lava-970010/bin/lava-test-runner /lava=
-970010/1
    2023-06-21T18:52:12.706722  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6493416c7761a81b703061c5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n40=
20-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n40=
20-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6493416c7761a81b703061ce
        failing since 62 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-21T18:28:38.056537  + set<8>[   16.607907] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10848597_1.4.2.3.1>

    2023-06-21T18:28:38.056621   +x

    2023-06-21T18:28:38.160520  / # #

    2023-06-21T18:28:38.261072  export SHELL=3D/bin/sh

    2023-06-21T18:28:38.261241  #

    2023-06-21T18:28:38.361762  / # export SHELL=3D/bin/sh. /lava-10848597/=
environment

    2023-06-21T18:28:38.361928  =


    2023-06-21T18:28:38.462455  / # . /lava-10848597/environment/lava-10848=
597/bin/lava-test-runner /lava-10848597/1

    2023-06-21T18:28:38.462704  =


    2023-06-21T18:28:38.467316  / # /lava-10848597/bin/lava-test-runner /la=
va-10848597/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649342d6f22384c0d4306177

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus=
.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649342d6f22384c0d4306180
        failing since 62 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-21T18:34:49.276143  + set +x

    2023-06-21T18:34:49.282751  <8>[   10.315489] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10848758_1.4.2.3.1>

    2023-06-21T18:34:49.387626  / # #

    2023-06-21T18:34:49.488392  export SHELL=3D/bin/sh

    2023-06-21T18:34:49.488620  #

    2023-06-21T18:34:49.589127  / # export SHELL=3D/bin/sh. /lava-10848758/=
environment

    2023-06-21T18:34:49.589390  =


    2023-06-21T18:34:49.689966  / # . /lava-10848758/environment/lava-10848=
758/bin/lava-test-runner /lava-10848758/1

    2023-06-21T18:34:49.690351  =


    2023-06-21T18:34:49.694834  / # /lava-10848758/bin/lava-test-runner /la=
va-10848758/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6493415d5846d9bf3c306154

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6493415d5846d9bf3c30615d
        failing since 62 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-21T18:28:37.906156  <8>[   13.998205] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10848608_1.4.2.3.1>

    2023-06-21T18:28:37.909612  + set +x

    2023-06-21T18:28:38.013922  / # #

    2023-06-21T18:28:38.114609  export SHELL=3D/bin/sh

    2023-06-21T18:28:38.114788  #

    2023-06-21T18:28:38.215442  / # export SHELL=3D/bin/sh. /lava-10848608/=
environment

    2023-06-21T18:28:38.215619  =


    2023-06-21T18:28:38.316239  / # . /lava-10848608/environment/lava-10848=
608/bin/lava-test-runner /lava-10848608/1

    2023-06-21T18:28:38.316482  =


    2023-06-21T18:28:38.321420  / # /lava-10848608/bin/lava-test-runner /la=
va-10848608/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649342b214cb39894e30612e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649342b214cb39894e306137
        failing since 62 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-21T18:34:16.890595  <8>[   12.485531] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10848768_1.4.2.3.1>

    2023-06-21T18:34:16.893906  + set +x

    2023-06-21T18:34:16.995079  /#

    2023-06-21T18:34:17.095934   # #export SHELL=3D/bin/sh

    2023-06-21T18:34:17.096156  =


    2023-06-21T18:34:17.196796  / # export SHELL=3D/bin/sh. /lava-10848768/=
environment

    2023-06-21T18:34:17.197081  =


    2023-06-21T18:34:17.297665  / # . /lava-10848768/environment/lava-10848=
768/bin/lava-test-runner /lava-10848768/1

    2023-06-21T18:34:17.297965  =


    2023-06-21T18:34:17.303058  / # /lava-10848768/bin/lava-test-runner /la=
va-10848768/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6493419388e255107f306164

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6493419388e255107f306=
165
        failing since 26 days (last pass: v5.10.179-cip32-384-g291adc46abef=
0, first fail: v5.10.180-cip33-21-g090289427e8b2) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/649347fcba41835c39306167

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/649347fcba41835c39306171
        failing since 62 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-21T18:56:56.332402  /lava-10849130/1/../bin/lava-test-case

    2023-06-21T18:56:56.343147  <8>[   62.109604] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/649347fcba41835c39306172
        failing since 62 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4) =

 =20

