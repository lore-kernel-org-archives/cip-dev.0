Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76E0C48BF6
	for <webhook@archiver.kernel.org>; Sun,  3 Mar 2024 21:13:34 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web11.83171.1709500411877319793
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 03 Mar 2024 13:13:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=UPqz1cmh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e5a232fe80so2195306b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 03 Mar 2024 13:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709500411; x=1710105211; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RWYN+e1dUhx8gQqiv0f9KDgsR3aNbSDpa2EzKMluK0g=;
        b=UPqz1cmhdypDAgZBTSbCma1osNEbtaKaB/FHWZXw0U4QDD4OBxlcKt5zWnb6S00pxJ
         qSmOd1+WxY4FVzGNNu8Zd16SLr/LGItNe//i/AKBsGmaNzoVG/WzurxSod9xOkoXJMe6
         Thk7Hn4NPjUyPj9alsx1dsB1PbHmyPKa3T9EG26LPqb1bum/x4mWEF8RbrOXvyQAdlPt
         mk03AGg9esLyQ6epXeOtqRNdI2RECH8G8T2u4CNmxK2VESTUzlacWN/9+nDWX58Mk8PH
         IkppVrASq95GYdcYStdr5jC40GJUZ+x8eBHR94umzfBJ08dE1AC61flZDFCuUgFk4K6R
         lqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709500411; x=1710105211;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RWYN+e1dUhx8gQqiv0f9KDgsR3aNbSDpa2EzKMluK0g=;
        b=SezWpbLgpjeW5X8QAnoN+BDSjkuGZ4ilqsIhls3cwo2T9VRydGx1IknAXtbGK8s1FV
         +xaAPSL3a+ojD9r+vu74OVFBbQkknZECRIK9AIRZVlfay0PF1idA1Y+k0TceB2yFggHD
         r4kbNgNiS1ZsOWAsCD4aVgIJEXkfgpCImoeFGCt9n1TrdpZ2qfoeShZss5nVWWe0rlyP
         Mx9cYAe51YcRUwnKcXC2swQSgUNjP2BLXEX1jhbCWReYbtGNW9QaLCD1fWSkoWuYX1+o
         fW4xS1iKvRNL6E+JHSxcWaZWFACCjAViEZglWCsxzhJp3gEP6U6HQD+IvSxkToObNa1x
         bGfw==
X-Gm-Message-State: AOJu0Yxq+j7YWJTY2yGbDZtGqWcYxW/4eUBeIv5G/76JQInYUfWmj90j
	8dEucin9fSlVUuv4l1SnG55sqPm9WjYHrIkqYkKHQhyn4XuUxUrKCOUF9/CY/07N1zXragcnbtS
	CB0U=
X-Google-Smtp-Source: AGHT+IHQ0542NhLYwz2kHpaAx0ARCaigwNLBtpZrynyxtckIWfH4v3lCexC9OckodgoheZt1XfCBOQ==
X-Received: by 2002:a05:6a00:8f:b0:6e5:c0bd:d334 with SMTP id c15-20020a056a00008f00b006e5c0bdd334mr6705032pfj.0.1709500410488;
        Sun, 03 Mar 2024 13:13:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o6-20020a056a001b4600b006e56ff4f0bdsm6010528pfv.29.2024.03.03.13.13.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 13:13:29 -0800 (PST)
Message-ID: <65e4e7f9.050a0220.19f4c.7d14@mx.google.com>
Date: Sun, 03 Mar 2024 13:13:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.78-cip15-547-gb5450675e67c
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 120 runs,
 16 regressions (v6.1.78-cip15-547-gb5450675e67c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 03 Mar 2024 21:13:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15182

cip-gitlab/ci/pavel/linux-test baseline: 120 runs, 16 regressions (v6.1.78-=
cip15-547-gb5450675e67c)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig         | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig          | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig         | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig         | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                  | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.78-cip15-547-gb5450675e67c/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.78-cip15-547-gb5450675e67c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b5450675e67cda5a44ee81ea4d17ab5db9b7deff =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4dd5178b20b24ed637064

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e4dd5178b20b24ed637069
        failing since 0 day (last pass: v4.19.306-cip107-1142-gdcbd51e7744f=
, first fail: v6.1.78-cip15-404-gdddfc5d4f194)

    2024-03-03T20:28:24.042094  <8>[ #

    2024-03-03T20:28:24.042418    10.697590] <LAVA_SIGNAL_ENDRUN 0_dmesg 12=
928234_1.4.2.3.1>

    2024-03-03T20:28:24.143290  / # #export SHELL=3D/bin/sh

    2024-03-03T20:28:24.144092  =


    2024-03-03T20:28:24.245530  / # export SHELL=3D/bin/sh. /lava-12928234/=
environment

    2024-03-03T20:28:24.246368  =


    2024-03-03T20:28:24.348208  / # . /lava-12928234/environment/lava-12928=
234/bin/lava-test-runner /lava-12928234/1

    2024-03-03T20:28:24.349523  =


    2024-03-03T20:28:24.354492  / # /lava-12928234/bin/lava-test-runner /la=
va-12928234/1

    2024-03-03T20:28:24.364549  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4d545c86325794f63706c

  Results:     48 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm/multi_v5_defconfig/gcc-10/lab-broonie/=
baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm/multi_v5_defconfig/gcc-10/lab-broonie/=
baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e4d545c86325794f63709c
        failing since 0 day (last pass: v4.19.306-cip107-1142-gdcbd51e7744f=
, first fail: v6.1.78-cip15-404-gdddfc5d4f194)

    2024-03-03T19:52:33.423220  + set +x
    2024-03-03T19:52:33.539125  / # <8><LAVA_SIGNAL_ENDRUN 0_dmesg 6573#
    2024-03-03T19:52:33.642187  export SHELL=3D/bin/sh
    2024-03-03T19:52:33.642996  03_1.5.2.4.1>
    2024-03-03T19:52:33.643464  #
    2024-03-03T19:52:33.745525  / # export SHELL=3D/bin/sh. /lava-657303/en=
vironment
    2024-03-03T19:52:33.746320  =

    2024-03-03T19:52:33.848409  / # . /lava-657303/environment/lava-657303/=
bin/lava-test-runner /lava-657303/1
    2024-03-03T19:52:33.849756  =

    2024-03-03T19:52:33.853356  / # /lava-657303/bin/lava-test-runner /lava=
-657303/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4da02efc31eaa9563711c

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm/bcm2835_defconfig/gcc-10/lab-collabora=
/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm/bcm2835_defconfig/gcc-10/lab-collabora=
/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e4da02efc31eaa95637121
        failing since 0 day (last pass: v4.19.306-cip107-1142-gdcbd51e7744f=
, first fail: v6.1.78-cip15-404-gdddfc5d4f194)

    2024-03-03T20:23:35.441032  + set +x

    2024-03-03T20:23:35.441904  / # <8>[   10.130967] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2024-03-03T20:23:35.442190  <8>[   10.133144] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12928133_1.5.2.4.1>

    2024-03-03T20:23:35.546174  #

    2024-03-03T20:23:35.648301  export SHELL=3D/bin/sh

    2024-03-03T20:23:35.649004  #

    2024-03-03T20:23:35.750403  / # export SHELL=3D/bin/sh. /lava-12928133/=
environment

    2024-03-03T20:23:35.751111  =


    2024-03-03T20:23:35.852475  / # . /lava-12928133/environment/lava-12928=
133/bin/lava-test-runner /lava-12928133/1

    2024-03-03T20:23:35.853562  =

 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4db1a8368e287ac637020

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm/multi_v7_defconfig/gcc-10/lab-collabor=
a/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm/multi_v7_defconfig/gcc-10/lab-collabor=
a/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e4db1a8368e287ac637=
021
        failing since 0 day (last pass: v4.19.306-cip107-1142-gdcbd51e7744f=
, first fail: v6.1.78-cip15-404-gdddfc5d4f194) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4e1079e6f5b6c6b63705f

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm/omap2plus_defconfig/gcc-10/lab-broonie=
/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm/omap2plus_defconfig/gcc-10/lab-broonie=
/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e4e1079e6f5b6c6b63708f
        failing since 0 day (last pass: v4.19.306-cip107-1142-gdcbd51e7744f=
, first fail: v6.1.78-cip15-404-gdddfc5d4f194)

    2024-03-03T20:43:08.022668  + set +x
    2024-03-03T20:43:08.125609  / # <8>[   21.066426] <LAVA_S#
    2024-03-03T20:43:08.227117  export SHELL=3D/bin/sh
    2024-03-03T20:43:08.227577  IGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=
=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2024-03-03T20:43:08.227746  <8>[   21.068716] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 657573_1.5.2.4.1>
    2024-03-03T20:43:08.227874  #
    2024-03-03T20:43:08.329101  / # export SHELL=3D/bin/sh. /lava-657573/en=
vironment
    2024-03-03T20:43:08.329495  =

    2024-03-03T20:43:08.430652  / # . /lava-657573/environment/lava-657573/=
bin/lava-test-runner /lava-657573/1
    2024-03-03T20:43:08.431248   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4dd532cd99cfa2a63702b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e4dd532cd99cfa2a637030
        failing since 0 day (last pass: v4.19.306-cip107-1142-gdcbd51e7744f=
, first fail: v6.1.78-cip15-404-gdddfc5d4f194)

    2024-03-03T20:27:41.816306  <8>[    5.880334] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12928303_1.4.2.3.1>

    2024-03-03T20:27:41.918361  #

    2024-03-03T20:27:41.918653  =


    2024-03-03T20:27:42.019241  / # #export SHELL=3D/bin/sh

    2024-03-03T20:27:42.019447  =


    2024-03-03T20:27:42.119909  / # export SHELL=3D/bin/sh. /lava-12928303/=
environment

    2024-03-03T20:27:42.120194  =


    2024-03-03T20:27:42.220800  / # . /lava-12928303/environment/lava-12928=
303/bin/lava-test-runner /lava-12928303/1

    2024-03-03T20:27:42.221149  =


    2024-03-03T20:27:42.226135  / # /lava-12928303/bin/lava-test-runner /la=
va-12928303/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4dd3b1c8bdc6b0163701f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e4dd3b1c8bdc6b01637024
        failing since 0 day (last pass: v4.19.306-cip107-1142-gdcbd51e7744f=
, first fail: v6.1.78-cip15-404-gdddfc5d4f194)

    2024-03-03T20:28:05.794093  + set<8>[    7.336102] <LAVA_SIGNAL_ENDRUN =
0_dmesg 12928223_1.4.2.3.1>

    2024-03-03T20:28:05.794245   +x

    2024-03-03T20:28:05.898145  / # #

    2024-03-03T20:28:05.998742  export SHELL=3D/bin/sh

    2024-03-03T20:28:05.998935  #

    2024-03-03T20:28:06.099398  / # export SHELL=3D/bin/sh. /lava-12928223/=
environment

    2024-03-03T20:28:06.099620  =


    2024-03-03T20:28:06.200156  / # . /lava-12928223/environment/lava-12928=
223/bin/lava-test-runner /lava-12928223/1

    2024-03-03T20:28:06.200450  =


    2024-03-03T20:28:06.205620  / # /lava-12928223/bin/lava-test-runner /la=
va-12928223/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4dd5078b20b24ed63704e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e4dd5078b20b24ed637053
        failing since 0 day (last pass: v4.19.306-cip107-1142-gdcbd51e7744f=
, first fail: v6.1.78-cip15-404-gdddfc5d4f194)

    2024-03-03T20:28:20.241625  <8>[    8.221297] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2024-03-03T20:28:20.242246  set +x

    2024-03-03T20:28:20.347985  / ##

    2024-03-03T20:28:20.450339  export SHELL=3D/bin/sh

    2024-03-03T20:28:20.451130   <8>[    8.245477] <LAVA_SIGNAL_ENDRUN 0_dm=
esg 12928218_1.4.2.3.1>

    2024-03-03T20:28:20.451557  #

    2024-03-03T20:28:20.552985  / # export SHELL=3D/bin/sh. /lava-12928218/=
environment

    2024-03-03T20:28:20.553848  =


    2024-03-03T20:28:20.655517  / # . /lava-12928218/environment/lava-12928=
218/bin/lava-test-runner /lava-12928218/1

    2024-03-03T20:28:20.656942  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4dd5078b20b24ed637059

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e4dd5078b20b24ed63705e
        failing since 0 day (last pass: v4.19.306-cip107-1142-gdcbd51e7744f=
, first fail: v6.1.78-cip15-404-gdddfc5d4f194)

    2024-03-03T20:27:42.786397  <8>[    7.990182] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2024-03-03T20:27:42.786476  set +x

    2024-03-03T20:27:42.793043  <8>[    8.019202] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12928231_1.4.2.3.1>

    2024-03-03T20:27:42.894264  / # #

    2024-03-03T20:27:42.994979  export SHELL=3D/bin/sh

    2024-03-03T20:27:42.995168  #

    2024-03-03T20:27:43.095665  / # export SHELL=3D/bin/sh. /lava-12928231/=
environment

    2024-03-03T20:27:43.095877  =


    2024-03-03T20:27:43.196426  / # . /lava-12928231/environment/lava-12928=
231/bin/lava-test-runner /lava-12928231/1

    2024-03-03T20:27:43.196772  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4d9f8efc31eaa95637023

  Results:     50 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-broonie/baseline-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-broonie/baseline-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/65e4d=
9f8efc31eaa9563704f
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-03T20:12:29.582634  /lava-657390/1/../bin/lava-test-case
    2024-03-03T20:12:29.596888  <8>[   19.054193] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2024-03-03T20:12:29.597151  /lava-657390/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4dabf7af90739de637033

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/65e4d=
abf7af90739de63705f
        new failure (last pass: v6.1.78-cip15-404-gdddfc5d4f194)

    2024-03-03T20:15:43.104138  /lava-657440/1/../bin/lava-test-case
    2024-03-03T20:15:43.120588  <8>[   19.008057] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2024-03-03T20:15:43.120795  /lava-657440/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4d83a651661c30e63702e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm/shmobile_defconfig/gcc-10/lab-cip/base=
line-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm/shmobile_defconfig/gcc-10/lab-cip/base=
line-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e4d83a651661c30e637=
02f
        failing since 26 days (last pass: v5.10.209-cip44-rebase, first fai=
l: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4dd63725948375a637030

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm64/defconfig/gcc-10/lab-cip/baseline-r8=
a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm64/defconfig/gcc-10/lab-cip/baseline-r8=
a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e4dd63725948375a637035
        failing since 0 day (last pass: v4.19.306-cip107-1142-gdcbd51e7744f=
, first fail: v6.1.78-cip15-404-gdddfc5d4f194)

    2024-03-03T20:28:05.822779  / # #
    2024-03-03T20:28:07.283046  export SHELL=3D/bin/sh
    2024-03-03T20:28:07.304065  #
    2024-03-03T20:28:07.304603  / # export SHELL=3D/bin/sh
    2024-03-03T20:28:09.256750  / # . /lava-1102386/environment
    2024-03-03T20:28:12.847783  /lava-1102386/bin/lava-test-runner /lava-11=
02386/1
    2024-03-03T20:28:12.869350  . /lava-1102386/environment
    2024-03-03T20:28:12.869727  / # /lava-1102386/bin/lava-test-runner /lav=
a-1102386/1
    2024-03-03T20:28:12.954427  + export 'TESTRUN_ID=3D1_bootrr'
    2024-03-03T20:28:12.954964  + cd /lava-1102386/1/tests/1_bootrr =

    ... (26 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4db671bb6fd60e263703e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm64/defconfig/gcc-10/lab-collabora/basel=
ine-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm64/defconfig/gcc-10/lab-collabora/basel=
ine-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e4db671bb6fd60e2637=
03f
        new failure (last pass: v6.1.78-cip15-404-gdddfc5d4f194) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4dce3ca061a7ae363708e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e4dce3ca061a7ae3637=
08f
        new failure (last pass: v6.1.78-cip15-404-gdddfc5d4f194) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e4dbc018ce6e5faf637098

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e4dbc018ce6e5faf637=
099
        new failure (last pass: v6.1.78-cip15-404-gdddfc5d4f194) =

 =20

