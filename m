Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB3BC7EE24
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 03:56:22 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
 by mx.groups.io with SMTP id smtpd.web10.49.1685937379690738666
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 04 Jun 2023 20:56:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=bhNHNHDj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.181, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-39a3f26688bso3675636b6e.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 04 Jun 2023 20:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685937378; x=1688529378;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xHRjJeJ+mNTZH4hR5eBzAwFfVeTmDRF0NMjtPkldEvs=;
        b=bhNHNHDjiNM8kr9g3U8Kz5ODwBWHQ58A24haMtchW4CJob6SaACRF3TFGVoCFj8vnv
         3TS6C3BD+weCDyzlnaBFElDdqKiBFm/n9UVIgc+6B+gaEXrKyTcPwngdMV0VHxhVSuYF
         cFtRCHqct1sKLcA9p0drb067DJl836qaMhCu8Tj5SsJCGNY3OUhe3XjFiiyLzqiZWm/i
         2COKi4ake+4KvP8nUfve+g2/v4xiBwWqlfzBRXtINubAOjDDX6tlpDy/tKt/sbtrqomo
         9mw0P4wgpNKR6i2nsSqtPsKdhoca5jC08BbkjzZsocvpoxeBELkLs5m5jNXLRT4lFCfe
         QxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685937378; x=1688529378;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xHRjJeJ+mNTZH4hR5eBzAwFfVeTmDRF0NMjtPkldEvs=;
        b=bSrMwcVUwwIEPMhenE95Tzi/1j8DAbdxGuTyOykaQ49n7ZKF0WVf60tQft3tK9EBmU
         omc10V034XAIOaBrMym987sJLn6oNh8RzNxq95f0+AN5KpPvhlZnHzfSBLOVIJgkZcn0
         jYG4B7bhPv9QqjQmPFGk4s+Gy392vEtDbRyiSYiCo2GUsypmoURgMGTtiTEkUYKI1QZS
         ZlbzqGLVCmpjwAiiMntcr1meJfZg4K4L3ceD80H9H+IQpMFhRkiKrG4+3xTdRoIut7PF
         6uKPpcxddLfLqNen0YpbDBnAtf1bwVwdt04sPl1hzPJdoVqdjHKbiN6kNE8iw5SE52WV
         J7YA==
X-Gm-Message-State: AC+VfDw6b0jgHYzoa6gUClQGDFxqqfkL9nh413CGqDLZGRCkHgi+X0BE
	jBY89LVWzqBKeBsi9WeVjdCrOYnr9uwrqxL16G4ktA==
X-Google-Smtp-Source: ACHHUZ6NpDwOHVh76/ZblyO+kES2mFznLjuvx/cBNppLSJgcEaGHEiugebN4z3HLRY3qRaznJG8IUA==
X-Received: by 2002:aca:100f:0:b0:398:2b18:9aa8 with SMTP id 15-20020aca100f000000b003982b189aa8mr7202908oiq.20.1685937378210;
        Sun, 04 Jun 2023 20:56:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x10-20020a170902ea8a00b001ab01598f40sm5391738plb.173.2023.06.04.20.56.17
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 20:56:17 -0700 (PDT)
Message-ID: <647d5ce1.170a0220.ea1c0.8e7d@mx.google.com>
Date: Sun, 04 Jun 2023 20:56:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-19-gae79bc689058c
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 161 runs,
 9 regressions (v5.10.180-cip34-19-gae79bc689058c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 03:56:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11770

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 161 runs, 9 regression=
s (v5.10.180-cip34-19-gae79bc689058c)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
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

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.180-cip34-19-gae79bc689058c/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.180-cip34-19-gae79bc689058c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ae79bc689058cc27e73e1cde11fdc558c96a2889 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647d50026ef09f25a2f5de3b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n40=
20-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n40=
20-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d50026ef09f25a2f5de44
        failing since 45 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-05T03:01:01.956373  + set +x

    2023-06-05T03:01:01.963051  <8>[   15.644385] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10586063_1.4.2.3.1>

    2023-06-05T03:01:02.067215  / # #

    2023-06-05T03:01:02.167864  export SHELL=3D/bin/sh

    2023-06-05T03:01:02.168076  #

    2023-06-05T03:01:02.268587  / # export SHELL=3D/bin/sh. /lava-10586063/=
environment

    2023-06-05T03:01:02.268787  =


    2023-06-05T03:01:02.369283  / # . /lava-10586063/environment/lava-10586=
063/bin/lava-test-runner /lava-10586063/1

    2023-06-05T03:01:02.369644  =


    2023-06-05T03:01:02.373831  / # /lava-10586063/bin/lava-test-runner /la=
va-10586063/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647d530fef0ccfc78af5de62

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus=
.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d530fef0ccfc78af5de6b
        failing since 45 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-05T03:14:10.033004  + set +x

    2023-06-05T03:14:10.039758  <8>[   14.151741] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10586285_1.4.2.3.1>

    2023-06-05T03:14:10.144260  / # #

    2023-06-05T03:14:10.244981  export SHELL=3D/bin/sh

    2023-06-05T03:14:10.245176  #

    2023-06-05T03:14:10.345671  / # export SHELL=3D/bin/sh. /lava-10586285/=
environment

    2023-06-05T03:14:10.345907  =


    2023-06-05T03:14:10.446557  / # . /lava-10586285/environment/lava-10586=
285/bin/lava-test-runner /lava-10586285/1

    2023-06-05T03:14:10.446833  =


    2023-06-05T03:14:10.451277  / # /lava-10586285/bin/lava-test-runner /la=
va-10586285/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647d50016ef09f25a2f5de25

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d50016ef09f25a2f5de2e
        failing since 45 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-05T03:01:06.059940  + <8>[   11.689507] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10586074_1.4.2.3.1>

    2023-06-05T03:01:06.060049  set +x

    2023-06-05T03:01:06.161292  #

    2023-06-05T03:01:06.262189  / # #export SHELL=3D/bin/sh

    2023-06-05T03:01:06.262426  =


    2023-06-05T03:01:06.363006  / # export SHELL=3D/bin/sh. /lava-10586074/=
environment

    2023-06-05T03:01:06.363292  =


    2023-06-05T03:01:06.463889  / # . /lava-10586074/environment/lava-10586=
074/bin/lava-test-runner /lava-10586074/1

    2023-06-05T03:01:06.464253  =


    2023-06-05T03:01:06.469092  / # /lava-10586074/bin/lava-test-runner /la=
va-10586074/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647d52c0ff0e3ae5b2f5de32

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d52c0ff0e3ae5b2f5de3b
        failing since 45 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-05T03:12:54.833289  + set +x

    2023-06-05T03:12:54.839934  <8>[   13.780929] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10586295_1.4.2.3.1>

    2023-06-05T03:12:54.941601  #

    2023-06-05T03:12:54.941896  =


    2023-06-05T03:12:55.042458  / # #export SHELL=3D/bin/sh

    2023-06-05T03:12:55.042643  =


    2023-06-05T03:12:55.143116  / # export SHELL=3D/bin/sh. /lava-10586295/=
environment

    2023-06-05T03:12:55.143297  =


    2023-06-05T03:12:55.243801  / # . /lava-10586295/environment/lava-10586=
295/bin/lava-test-runner /lava-10586295/1

    2023-06-05T03:12:55.244074  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647d51da79208fd60ff5de44

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647d51da79208fd60ff5d=
e45
        failing since 9 days (last pass: v5.10.179-cip32-384-g291adc46abef0=
, first fail: v5.10.180-cip33-21-g090289427e8b2) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/647d530fa3dd0bada5f5de7e

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/647d530fa3dd0bada5f5de88
        failing since 45 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-05T03:14:04.527862  /lava-10586206/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/647d530fa3dd0bada5f5de89
        failing since 45 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-05T03:14:02.468327  <8>[   60.051198] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-06-05T03:14:03.492161  /lava-10586206/1/../bin/lava-test-case

    2023-06-05T03:14:03.503059  <8>[   61.086930] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/647d56568d587ef225f5de68

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/647d56568d587ef225f5de72
        failing since 45 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-05T03:27:59.228107  <8>[   40.934373] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-06-05T03:28:00.301484  /lava-10586514/1/../bin/lava-test-case

    2023-06-05T03:28:00.326519  <8>[   42.033944] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/647d56568d587ef225f5de73
        failing since 45 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-05T03:27:59.202626  /lava-10586514/1/../bin/lava-test-case
   =

 =20

