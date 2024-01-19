Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DF8C47422
	for <webhook@archiver.kernel.org>; Fri, 19 Jan 2024 01:02:43 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web10.10986.1705626158505897241
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 18 Jan 2024 17:02:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=WXz1p8E6;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6dbbcb1aff8so58374b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 18 Jan 2024 17:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705626157; x=1706230957; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ACGFxAYpxnMfp+KxWdC1MIFZQ9bKhAomjEMKcbCFcYc=;
        b=WXz1p8E6Vj+ywF/aMReFtndLcSB+nUoeaR3Ad2T1CCPdcPrHfjh0QA+4rGd54cDFRv
         yvIX1vvI9NQT233SDQgNEA0WNGID0ooxbX7mTrapTFm5AOgBkgDFXKzFl/FC7OVtj4w9
         WvvXFo8EnYpeynEkMiTnJ39XWCfqbCGHS2qs0QaoUnVRXb9AvdS2FfkNOie58zaaBTCI
         /zG7e17fcA0YiuvrR7m6cQk83UoPuxAwt4hT/zopuu4kqU2/jujEo/2va03wtkrc3eMj
         EgmxarXbVjkfflxKBScED6H/6QGHk/5HA7qkznDyqDkjaC9iOubrMLMK1EC065IljQo/
         o9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705626157; x=1706230957;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACGFxAYpxnMfp+KxWdC1MIFZQ9bKhAomjEMKcbCFcYc=;
        b=LT0xipx3jWYxm3lwiCcwBKMo7P6irPLuJiO/Q9ZZFAhnTMPlpWVM0lr/MglUkYF82N
         golJyDo3Eyx1CWyjz/A9rWm8pHh7R+Zkngih5wtIhfIRvoAZzuGI/YBTyMBbnA40Gtub
         TueRlnlTA5QEfU/vqqO7zQfXfNinp75SChYoNMTYZaSnsqBms1m4/4Zcsl4eDc2V6RKq
         kGK9vQedJkjKb5JeVTwu9yHWaEeblj94IzZxVCX7RHXNIRHm2QvR+8aBfEblAHYqDy0/
         oGYDRZdee+TQUqwjLDRYc59Of3dgyz/+eBukhs0K/E9oDclLOh8nREPQ8SMLzsleVLVw
         uqUQ==
X-Gm-Message-State: AOJu0Yzy5IeLf/HCQn1aXDPMcjJOnMwXLd22oRtF/JGTQpY2RyI27LAF
	qinVJXY0q3ygdy7Oh8Sy/p+tNJh+4o/OlbXZwdJk2hpOAiUgjXm6IfjY6hNq1DHVQx8N/6AEpgW
	vB2o=
X-Google-Smtp-Source: AGHT+IFc7C92Ic7GudIXkWWvrNY95wzPGF8iY0OMTh8rgrSJ9Ahp1BLCn32B4Z5v1uV9aj3yg/bjaA==
X-Received: by 2002:a05:6a00:1f08:b0:6d9:e3b1:b0fd with SMTP id be8-20020a056a001f0800b006d9e3b1b0fdmr1497488pfb.8.1705626157247;
        Thu, 18 Jan 2024 17:02:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fb10-20020a056a002d8a00b006da5f797249sm3889717pfb.130.2024.01.18.17.02.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 17:02:36 -0800 (PST)
Message-ID: <65a9ca2c.050a0220.76e11.1a23@mx.google.com>
Date: Thu, 18 Jan 2024 17:02:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v6.1.72-cip13-30-g79e2886a5da69
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 79 runs,
 6 regressions (v6.1.72-cip13-30-g79e2886a5da69)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jan 2024 01:02:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14413

cip-gitlab/ci/pavel/linux-test baseline: 79 runs, 6 regressions (v6.1.72-ci=
p13-30-g79e2886a5da69)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig         | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.72-cip13-30-g79e2886a5da69/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.72-cip13-30-g79e2886a5da69
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      79e2886a5da69a8a86ec82215b5e9e0748943546 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65a9bb9ae031a99d0a52a441

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65a9bb9ae031a99d0a52a44a
        new failure (last pass: v4.19.299-cip105-1134-gc868d5e4adaa)

    2024-01-19T00:00:10.520824  + set +x<8>[   11.550398] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 12570798_1.4.2.3.1>

    2024-01-19T00:00:10.520934  =


    2024-01-19T00:00:10.625311  / # #

    2024-01-19T00:00:10.727624  export SHELL=3D/bin/sh

    2024-01-19T00:00:10.728344  #

    2024-01-19T00:00:10.829738  / # export SHELL=3D/bin/sh. /lava-12570798/=
environment

    2024-01-19T00:00:10.830492  =


    2024-01-19T00:00:10.931709  / # . /lava-12570798/environment/lava-12570=
798/bin/lava-test-runner /lava-12570798/1

    2024-01-19T00:00:10.932043  =


    2024-01-19T00:00:10.937235  / # /lava-12570798/bin/lava-test-runner /la=
va-12570798/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65a9bb7b93dd38fb4d52a3f9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65a9bb7c93dd38fb4d52a402
        new failure (last pass: v4.19.299-cip105-1134-gc868d5e4adaa)

    2024-01-18T23:59:46.104872  + set +x

    2024-01-18T23:59:46.111218  <8>[    9.987432] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12570821_1.4.2.3.1>

    2024-01-18T23:59:46.215602  / # #

    2024-01-18T23:59:46.316252  export SHELL=3D/bin/sh

    2024-01-18T23:59:46.316416  #

    2024-01-18T23:59:46.416950  / # export SHELL=3D/bin/sh. /lava-12570821/=
environment

    2024-01-18T23:59:46.417189  =


    2024-01-18T23:59:46.517691  / # . /lava-12570821/environment/lava-12570=
821/bin/lava-test-runner /lava-12570821/1

    2024-01-18T23:59:46.517945  =


    2024-01-18T23:59:46.522839  / # /lava-12570821/bin/lava-test-runner /la=
va-12570821/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65a9bb7edf85ea880052a3f6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65a9bb7edf85ea880052a3ff
        new failure (last pass: v4.19.299-cip105-1134-gc868d5e4adaa)

    2024-01-19T00:02:22.772112  + set +x

    2024-01-19T00:02:22.778089  <8>[   10.048231] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12570789_1.4.2.3.1>

    2024-01-19T00:02:22.879924  #

    2024-01-19T00:02:22.880196  =


    2024-01-19T00:02:22.980919  / # #export SHELL=3D/bin/sh

    2024-01-19T00:02:22.981112  =


    2024-01-19T00:02:23.081612  / # export SHELL=3D/bin/sh. /lava-12570789/=
environment

    2024-01-19T00:02:23.081827  =


    2024-01-19T00:02:23.182416  / # . /lava-12570789/environment/lava-12570=
789/bin/lava-test-runner /lava-12570789/1

    2024-01-19T00:02:23.182685  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65a9bb9ce031a99d0a52a44c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65a9bb9ce031a99d0a52a455
        new failure (last pass: v4.19.299-cip105-1134-gc868d5e4adaa)

    2024-01-19T00:00:10.425928  + set +x<8>[   11.329650] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 12570767_1.4.2.3.1>

    2024-01-19T00:00:10.426215  =


    2024-01-19T00:00:10.532585  / # #

    2024-01-19T00:00:10.634070  export SHELL=3D/bin/sh

    2024-01-19T00:00:10.634495  #

    2024-01-19T00:00:10.735575  / # export SHELL=3D/bin/sh. /lava-12570767/=
environment

    2024-01-19T00:00:10.736058  =


    2024-01-19T00:00:10.837197  / # . /lava-12570767/environment/lava-12570=
767/bin/lava-test-runner /lava-12570767/1

    2024-01-19T00:00:10.837944  =


    2024-01-19T00:00:10.843233  / # /lava-12570767/bin/lava-test-runner /la=
va-12570767/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65a9bb784616e23ae452a405

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65a9bb784616e23ae452a40e
        new failure (last pass: v4.19.299-cip105-1134-gc868d5e4adaa)

    2024-01-19T00:00:15.795515  + set<8>[   11.653382] <LAVA_SIGNAL_ENDRUN =
0_dmesg 12570804_1.4.2.3.1>

    2024-01-19T00:00:15.795639   +x

    2024-01-19T00:00:15.899938  / # #

    2024-01-19T00:00:16.000550  export SHELL=3D/bin/sh

    2024-01-19T00:00:16.000758  #

    2024-01-19T00:00:16.101271  / # export SHELL=3D/bin/sh. /lava-12570804/=
environment

    2024-01-19T00:00:16.101460  =


    2024-01-19T00:00:16.201981  / # . /lava-12570804/environment/lava-12570=
804/bin/lava-test-runner /lava-12570804/1

    2024-01-19T00:00:16.202338  =


    2024-01-19T00:00:16.207648  / # /lava-12570804/bin/lava-test-runner /la=
va-12570804/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65a9b774194e8c932c52a3f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/arm/shmobile_defconfig/gcc-10/lab-cip/base=
line-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/arm/shmobile_defconfig/gcc-10/lab-cip/base=
line-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65a9b774194e8c932c52a=
3f2
        failing since 22 days (last pass: v5.10.201-cip41-77-g545d45774209f=
, first fail: v6.1.66-cip11-rt6-10-g38253b8903b4) =

 =20

