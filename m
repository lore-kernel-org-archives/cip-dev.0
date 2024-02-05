Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67574C48292
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 17:51:28 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web10.480.1707155480136673686
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 09:51:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Mh+TF1XU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2967682b29aso1036546a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 09:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707155479; x=1707760279; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ndm6w+vQxCCEHszdpRUQCb3m9jtJC6Yxddl+0i7dmC8=;
        b=Mh+TF1XUNsph7xSt8oO0fGymT+qM6TYf2BYuIFJo9yHWxEd2h4WC8icC/sbQoN6Ksa
         Dql9lRrIYTbQCgyR5kjiPm1HgFV+hRlFvGguL+9E4MtVBo1XIZK6BcIyzX6ZDr2GJGHZ
         2f/5nfpHz4VGG5UzIaTfb6bRKou+QNNPRiuk0bDFT8ve24YvNpiv/YNwohYQd40lczoD
         b4eD6HBQ3qJJLFe3odUMwCxrUIwxOSPCznYN4lZlcuKw28vHAvjdMtmIMKcgGVdekRv7
         MpnaBB3+YS/geYublnlBgQXbOBxaenkKiNt74yr78ibogEhTXaPHuo9A1xPxuERH/FVI
         tFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707155479; x=1707760279;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ndm6w+vQxCCEHszdpRUQCb3m9jtJC6Yxddl+0i7dmC8=;
        b=jgjwtHO95i3iFUVMQbH+m8XdBBkaMwrBNqfSShdfi2+Q1E9A86E78a1ACZNE3WHaH7
         HG6zQwRajgq5Kzkz3E0wDBYBIF6UY/VvMBMqNisq6H4E5r236bsn8yqqWiyvT+ziddBP
         j9q1mYBPf7az/70/OjCSJZhYWq1HVrJ6ZtbdJJATm42GaHxkbzko2+oYNYvyCvBzLP9b
         8uJ6SEw0WvPCs74tk0OQwzN962l/2oUTpLRRitlRzQSq2M5CbE4SDaAqlq/EkfydoU7W
         Fq+UvZDZHI7OQtZyAMyVix3/6nj8nPZBFWiLqy58OKxx2rR2EP6FVdsFpLeW0L/Ubea7
         bkrQ==
X-Gm-Message-State: AOJu0YxhFDB2gveoWQ5YnoMWLYtScvUNhOzofA5Qd32t8lSfpHw0A82R
	YYqGf2lz+agHHkWCHLJq0v9FUnqCwPHjujjGzOvk2CkBzKc7bCzHC3BrE5smFtZ5dyhCHpCBWyR
	O
X-Google-Smtp-Source: AGHT+IGDTcc9E1xlBqqX69jmC/PpZEY9YXLlybNIAMyjs3xOCXGFlxmvoo8iZfYNm3qfLFUfTSvADA==
X-Received: by 2002:a17:90a:d518:b0:296:3ee4:c1ed with SMTP id t24-20020a17090ad51800b002963ee4c1edmr167097pju.5.1707155478627;
        Mon, 05 Feb 2024 09:51:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV38NPTbR6xwrVUFOURv0m8Onqv4ww2ySAuYOpfMjIZV/pclN/73MdIhgVg8C7tQBqcjzKSzBketgH8/6sBNpPzDl9RpPk+SNapHTLpMIGCAQjPeG9tAojevWBiJos45z6C0P1sZprzs6A0Y/LO35IaDg==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id db4-20020a17090ad64400b00296b517f366sm258914pjb.53.2024.02.05.09.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:51:18 -0800 (PST)
Message-ID: <65c12016.170a0220.7838c.1e90@mx.google.com>
Date: Mon, 05 Feb 2024 09:51:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline: 137 runs,
 28 regressions (v5.10.209-cip44)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 17:51:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14742

cip/linux-5.10.y-cip baseline: 137 runs, 28 regressions (v5.10.209-cip44)

Regressions Summary
-------------------

platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
at91sam9g20ek            | arm   | lab-broonie     | gcc-10   | at91_dt_def=
config            | 2          =

bcm2836-rpi-2-b          | arm   | lab-collabora   | gcc-10   | bcm2835_def=
config            | 1          =

beaglebone-black         | arm   | lab-broonie     | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black         | arm   | lab-cip         | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black         | arm   | lab-broonie     | gcc-10   | omap2plus_d=
efconfig          | 1          =

beaglebone-black         | arm   | lab-cip         | gcc-10   | omap2plus_d=
efconfig          | 1          =

imx6q-sabrelite          | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig           | 1          =

imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_d=
efconfig          | 1          =

imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | multi_v7_de=
fconfig           | 1          =

juno-uboot               | arm64 | lab-broonie     | gcc-10   | cip://5.10.=
y-...64_defconfig | 1          =

juno-uboot               | arm64 | lab-broonie     | gcc-10   | defconfig+k=
selftest          | 1          =

juno-uboot               | arm64 | lab-broonie     | gcc-10   | defconfig  =
                  | 1          =

mt8173-elm-hana          | arm64 | lab-collabora   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

r8a7743-iwg20d-q7        | arm   | lab-cip         | gcc-10   | shmobile_de=
fconfig           | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig  =
                  | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip         | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

r8a774c0-ek874           | arm64 | lab-cip         | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

r8a774c0-ek874           | arm64 | lab-cip         | gcc-10   | defconfig  =
                  | 1          =

r8a77960-ulcb            | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =

rk3288-veyron-jaq        | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig           | 4          =

rk3399-rock-pi-4b        | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =

sun50i-a64-pine64-plus   | arm64 | lab-broonie     | gcc-10   | defconfig  =
                  | 1          =

sun50i-h6-pine-h64       | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2fa4c25ee66abaa707e8d165c790bb96e883cca4 =



Test Regressions
---------------- =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
at91sam9g20ek            | arm   | lab-broonie     | gcc-10   | at91_dt_def=
config            | 2          =


  Details:     https://kernelci.org/test/plan/id/65c1112e78e83b173100a05d

  Results:     47 PASS, 6 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/at91_dt_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/at91_dt_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/65c1112e7=
8e83b173100a06c
        new failure (last pass: v5.10.208-cip43-4-g1c63c70fb18b8)

    2024-02-05T16:47:20.794352  /lava-546247/1/../bin/lava-test-case
    2024-02-05T16:47:20.832288  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dsou=
nd-card RESULT=3Dfail>   =


  * baseline.bootrr.audio-card-probed: https://kernelci.org/test/case/id/65=
c1112e78e83b173100a06d
        new failure (last pass: v5.10.208-cip43-4-g1c63c70fb18b8)

    2024-02-05T16:47:19.700710  /lava-546247/1/../bin/lava-test-case
    2024-02-05T16:47:19.739171  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Daud=
io-card-probed RESULT=3Dfail>   =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora   | gcc-10   | bcm2835_def=
config            | 1          =


  Details:     https://kernelci.org/test/plan/id/65c112c43cda3f6bf900a03a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c112c43cda3f6bf900a043
        failing since 194 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-05T17:01:46.205120  / # #

    2024-02-05T17:01:46.307142  export SHELL=3D/bin/sh

    2024-02-05T17:01:46.307852  #

    2024-02-05T17:01:46.409162  / # export SHELL=3D/bin/sh. /lava-12704407/=
environment

    2024-02-05T17:01:46.409976  =


    2024-02-05T17:01:46.511452  / # . /lava-12704407/environment/lava-12704=
407/bin/lava-test-runner /lava-12704407/1

    2024-02-05T17:01:46.512612  =


    2024-02-05T17:01:46.529506  / # /lava-12704407/bin/lava-test-runner /la=
va-12704407/1

    2024-02-05T17:01:46.593479  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-05T17:01:46.637383  + cd /lava-12704407/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
beaglebone-black         | arm   | lab-broonie     | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1151b31b401588100a039

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c1151b31b401588100a063
        failing since 387 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-05T17:03:54.234600  <8>[   21.469516] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 546332_1.5.2.4.1>
    2024-02-05T17:03:54.344695  / # #
    2024-02-05T17:03:54.447904  export SHELL=3D/bin/sh
    2024-02-05T17:03:54.448817  #
    2024-02-05T17:03:54.550853  / # export SHELL=3D/bin/sh. /lava-546332/en=
vironment
    2024-02-05T17:03:54.551814  =

    2024-02-05T17:03:54.653951  / # . /lava-546332/environment/lava-546332/=
bin/lava-test-runner /lava-546332/1
    2024-02-05T17:03:54.655433  =

    2024-02-05T17:03:54.659657  / # /lava-546332/bin/lava-test-runner /lava=
-546332/1
    2024-02-05T17:03:54.755918  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
beaglebone-black         | arm   | lab-cip         | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65c11516f98e96829e00a08b

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c11517f98e96829e00a0b3
        failing since 387 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-05T17:03:37.264459  <8>[   15.777501] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1088707_1.5.2.4.1>
    2024-02-05T17:03:37.373259  / # #
    2024-02-05T17:03:37.474126  export SHELL=3D/bin/sh
    2024-02-05T17:03:37.474425  #
    2024-02-05T17:03:37.575064  / # export SHELL=3D/bin/sh. /lava-1088707/e=
nvironment
    2024-02-05T17:03:37.575373  =

    2024-02-05T17:03:37.676019  / # . /lava-1088707/environment/lava-108870=
7/bin/lava-test-runner /lava-1088707/1
    2024-02-05T17:03:37.676459  =

    2024-02-05T17:03:37.682652  / # /lava-1088707/bin/lava-test-runner /lav=
a-1088707/1
    2024-02-05T17:03:37.773562  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
beaglebone-black         | arm   | lab-broonie     | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c11974f2453463f300a049

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c11974f2453463f300a081
        failing since 387 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-05T17:22:42.070730  <8>[   21.026532] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 546409_1.5.2.4.1>
    2024-02-05T17:22:42.179379  / # #
    2024-02-05T17:22:42.281466  export SHELL=3D/bin/sh
    2024-02-05T17:22:42.281950  #
    2024-02-05T17:22:42.383354  / # export SHELL=3D/bin/sh. /lava-546409/en=
vironment
    2024-02-05T17:22:42.384107  =

    2024-02-05T17:22:42.485466  / # . /lava-546409/environment/lava-546409/=
bin/lava-test-runner /lava-546409/1
    2024-02-05T17:22:42.486187  =

    2024-02-05T17:22:42.490732  / # /lava-546409/bin/lava-test-runner /lava=
-546409/1
    2024-02-05T17:22:42.599148  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
beaglebone-black         | arm   | lab-cip         | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1198af2453463f300a08f

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c1198bf2453463f300a0c4
        failing since 387 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-05T17:22:54.789213  <8>[   13.073936] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1088750_1.5.2.4.1>
    2024-02-05T17:22:54.899554  / # #
    2024-02-05T17:22:55.001228  export SHELL=3D/bin/sh
    2024-02-05T17:22:55.001831  #
    2024-02-05T17:22:55.103172  / # export SHELL=3D/bin/sh. /lava-1088750/e=
nvironment
    2024-02-05T17:22:55.103825  =

    2024-02-05T17:22:55.205155  / # . /lava-1088750/environment/lava-108875=
0/bin/lava-test-runner /lava-1088750/1
    2024-02-05T17:22:55.206204  =

    2024-02-05T17:22:55.212601  / # /lava-1088750/bin/lava-test-runner /lav=
a-1088750/1
    2024-02-05T17:22:55.319530  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
imx6q-sabrelite          | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65c114fbb01d5631ca00a063

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c114fbb01d5631ca00a06c
        failing since 387 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-05T17:03:31.560351  / # #

    2024-02-05T17:03:31.663046  export SHELL=3D/bin/sh

    2024-02-05T17:03:31.663833  #

    2024-02-05T17:03:31.765503  / # export SHELL=3D/bin/sh. /lava-12704438/=
environment

    2024-02-05T17:03:31.766320  =


    2024-02-05T17:03:31.867921  / # . /lava-12704438/environment/lava-12704=
438/bin/lava-test-runner /lava-12704438/1

    2024-02-05T17:03:31.869164  =


    2024-02-05T17:03:31.882085  / # /lava-12704438/bin/lava-test-runner /la=
va-12704438/1

    2024-02-05T17:03:31.994183  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-05T17:03:31.994758  + cd /lava-12704438/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c112ff3cda3f6bf900a0c9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c112ff3cda3f6bf900a0d2
        failing since 387 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-05T16:55:19.558566  + set +x
    2024-02-05T16:55:19.558697  [   10.306812] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1023788_1.5.2.3.1>
    2024-02-05T16:55:19.665903  / # #
    2024-02-05T16:55:19.766977  export SHELL=3D/bin/sh
    2024-02-05T16:55:19.767386  #
    2024-02-05T16:55:19.868098  / # export SHELL=3D/bin/sh. /lava-1023788/e=
nvironment
    2024-02-05T16:55:19.868518  =

    2024-02-05T16:55:19.969292  / # . /lava-1023788/environment/lava-102378=
8/bin/lava-test-runner /lava-1023788/1
    2024-02-05T16:55:19.969885  =

    2024-02-05T16:55:19.972866  / # /lava-1023788/bin/lava-test-runner /lav=
a-1023788/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65c114cb425a357ef900a055

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c114cb425a357ef900a05e
        failing since 387 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-05T17:02:59.351573  + set[    7.303714] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1023790_1.5.2.3.1>
    2024-02-05T17:02:59.351790   +x
    2024-02-05T17:02:59.457220  / # #
    2024-02-05T17:02:59.558477  export SHELL=3D/bin/sh
    2024-02-05T17:02:59.559015  #
    2024-02-05T17:02:59.659868  / # export SHELL=3D/bin/sh. /lava-1023790/e=
nvironment
    2024-02-05T17:02:59.660359  =

    2024-02-05T17:02:59.761249  / # . /lava-1023790/environment/lava-102379=
0/bin/lava-test-runner /lava-1023790/1
    2024-02-05T17:02:59.761961  =

    2024-02-05T17:02:59.764660  / # /lava-1023790/bin/lava-test-runner /lav=
a-1023790/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
juno-uboot               | arm64 | lab-broonie     | gcc-10   | cip://5.10.=
y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65c11759fc69b046d500a03c

  Results:     47 PASS, 13 FAIL, 1 SKIP
  Full config: cip://5.10.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie=
/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie=
/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c11759fc69b046d500a07b
        failing since 161 days (last pass: v5.10.186-cip37-27-gd6d928db0a62=
0, first fail: v5.10.191-cip38)

    2024-02-05T17:13:40.987478  / # #
    2024-02-05T17:13:41.090233  export SHELL=3D/bin/sh
    2024-02-05T17:13:41.091015  #
    2024-02-05T17:13:41.192908  / # export SHELL=3D/bin/sh. /lava-546351/en=
vironment
    2024-02-05T17:13:41.193688  =

    2024-02-05T17:13:41.295685  / # . /lava-546351/environment/lava-546351/=
bin/lava-test-runner /lava-546351/1
    2024-02-05T17:13:41.296957  =

    2024-02-05T17:13:41.311563  / # /lava-546351/bin/lava-test-runner /lava=
-546351/1
    2024-02-05T17:13:41.367431  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-05T17:13:41.367940  + cd /lava-546351/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
juno-uboot               | arm64 | lab-broonie     | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c11669d489e6b22400a073

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c11669d489e6b22400a0b3
        failing since 194 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-05T17:09:30.708498  <8>[   25.982372] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 546321_1.5.2.4.1>
    2024-02-05T17:09:30.816390  / # #
    2024-02-05T17:09:30.919151  export SHELL=3D/bin/sh
    2024-02-05T17:09:30.919912  #
    2024-02-05T17:09:31.021830  / # export SHELL=3D/bin/sh. /lava-546321/en=
vironment
    2024-02-05T17:09:31.022595  =

    2024-02-05T17:09:31.124563  / # . /lava-546321/environment/lava-546321/=
bin/lava-test-runner /lava-546321/1
    2024-02-05T17:09:31.125795  =

    2024-02-05T17:09:31.139815  / # /lava-546321/bin/lava-test-runner /lava=
-546321/1
    2024-02-05T17:09:31.317562  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
juno-uboot               | arm64 | lab-broonie     | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c118495d4255ed1100a17e

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c118495d4255ed1100a1be
        new failure (last pass: v5.10.208-cip43-4-g1c63c70fb18b8)

    2024-02-05T17:17:28.020056  / # #
    2024-02-05T17:17:28.122891  export SHELL=3D/bin/sh
    2024-02-05T17:17:28.123667  #
    2024-02-05T17:17:28.225575  / # export SHELL=3D/bin/sh. /lava-546378/en=
vironment
    2024-02-05T17:17:28.226424  =

    2024-02-05T17:17:28.328414  / # . /lava-546378/environment/lava-546378/=
bin/lava-test-runner /lava-546378/1
    2024-02-05T17:17:28.329659  =

    2024-02-05T17:17:28.344239  / # /lava-546378/bin/lava-test-runner /lava=
-546378/1
    2024-02-05T17:17:28.403007  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-05T17:17:28.403513  + cd /lava-546378/1/tests/1_bootrr =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
mt8173-elm-hana          | arm64 | lab-collabora   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1168bd2ad53832200a03f

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c1168bd2ad53832200a05f
        failing since 387 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-05T17:12:57.690211  + set +x

    2024-02-05T17:12:57.694733  <8>[   15.626174] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12704555_1.5.2.3.1>

    2024-02-05T17:12:57.804338  / # #

    2024-02-05T17:12:57.906547  export SHELL=3D/bin/sh

    2024-02-05T17:12:57.907396  #

    2024-02-05T17:12:58.008835  / # export SHELL=3D/bin/sh. /lava-12704555/=
environment

    2024-02-05T17:12:58.009033  =


    2024-02-05T17:12:58.109741  / # . /lava-12704555/environment/lava-12704=
555/bin/lava-test-runner /lava-12704555/1

    2024-02-05T17:12:58.110950  =


    2024-02-05T17:12:58.112381  / # /lava-12704555/bin/lava-test-runner /la=
va-12704555/1
 =

    ... (21 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a7743-iwg20d-q7        | arm   | lab-cip         | gcc-10   | shmobile_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1138690c262736600a077

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c1138690c262736600a=
078
        failing since 59 days (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d=
, first fail: v5.10.201-cip41-28-ga386bc478aa6b) =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65c117d2ac2880178300a093

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hi=
hope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hi=
hope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c117d2ac2880178300a09c
        failing since 194 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-05T17:15:41.672722  + set +x
    2024-02-05T17:15:41.676097  <8>[   84.030035] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1088727_1.5.2.4.1>
    2024-02-05T17:15:41.784655  / # #
    2024-02-05T17:15:43.249875  export SHELL=3D/bin/sh
    2024-02-05T17:15:43.270794  #
    2024-02-05T17:15:43.271245  / # export SHELL=3D/bin/sh
    2024-02-05T17:15:45.229249  / # . /lava-1088727/environment
    2024-02-05T17:15:48.832018  /lava-1088727/bin/lava-test-runner /lava-10=
88727/1
    2024-02-05T17:15:48.853182  . /lava-1088727/environment
    2024-02-05T17:15:48.853334  / # /lava-1088727/bin/lava-test-runner /lav=
a-1088727/1 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c119b31c0c47882b00a040

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c119b31c0c47882b00a049
        failing since 180 days (last pass: v5.10.182-cip35-1-g7cde3fba93966=
, first fail: v5.10.186-cip37-13-g260094841fe1a)

    2024-02-05T17:23:50.566075  + set +x
    2024-02-05T17:23:50.569293  <8>[   83.939634] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1088743_1.5.2.4.1>
    2024-02-05T17:23:50.675572  / # #
    2024-02-05T17:23:52.133846  export SHELL=3D/bin/sh
    2024-02-05T17:23:52.154587  #
    2024-02-05T17:23:52.154998  / # export SHELL=3D/bin/sh
    2024-02-05T17:23:54.104901  / # . /lava-1088743/environment
    2024-02-05T17:23:57.691206  /lava-1088743/bin/lava-test-runner /lava-10=
88743/1
    2024-02-05T17:23:57.712374  . /lava-1088743/environment
    2024-02-05T17:23:57.712743  / # /lava-1088743/bin/lava-test-runner /lav=
a-1088743/1 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip         | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65c118babb7713fe9000a170

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hi=
hope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hi=
hope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c118babb7713fe9000a179
        failing since 194 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-05T17:19:37.306014  + set +x
    2024-02-05T17:19:37.309121  <8>[   84.201526] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1088722_1.5.2.4.1>
    2024-02-05T17:19:37.417106  / # #
    2024-02-05T17:19:38.873506  export SHELL=3D/bin/sh
    2024-02-05T17:19:38.894350  #
    2024-02-05T17:19:38.894776  / # export SHELL=3D/bin/sh
    2024-02-05T17:19:40.844079  / # . /lava-1088722/environment
    2024-02-05T17:19:44.433238  /lava-1088722/bin/lava-test-runner /lava-10=
88722/1
    2024-02-05T17:19:44.454756  . /lava-1088722/environment
    2024-02-05T17:19:44.455125  / # /lava-1088722/bin/lava-test-runner /lav=
a-1088722/1 =

    ... (15 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a774c0-ek874           | arm64 | lab-cip         | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1172b8eb112cb8700a043

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek=
874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek=
874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c1172b8eb112cb8700a04c
        failing since 194 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-05T17:12:52.439201  / # #
    2024-02-05T17:12:53.897200  export SHELL=3D/bin/sh
    2024-02-05T17:12:53.918183  #
    2024-02-05T17:12:53.918603  / # export SHELL=3D/bin/sh
    2024-02-05T17:12:55.867175  / # . /lava-1088720/environment
    2024-02-05T17:12:59.446315  /lava-1088720/bin/lava-test-runner /lava-10=
88720/1
    2024-02-05T17:12:59.466885  . /lava-1088720/environment
    2024-02-05T17:12:59.466996  / # /lava-1088720/bin/lava-test-runner /lav=
a-1088720/1
    2024-02-05T17:12:59.504982  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-05T17:12:59.549666  + cd /lava-1088720/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a774c0-ek874           | arm64 | lab-cip         | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1196e6e9eae743a00a07b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c1196e6e9eae743a00a084
        failing since 194 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-05T17:22:38.059101  / # #
    2024-02-05T17:22:39.519561  export SHELL=3D/bin/sh
    2024-02-05T17:22:39.540496  #
    2024-02-05T17:22:39.541028  / # export SHELL=3D/bin/sh
    2024-02-05T17:22:41.493025  / # . /lava-1088731/environment
    2024-02-05T17:22:45.085287  /lava-1088731/bin/lava-test-runner /lava-10=
88731/1
    2024-02-05T17:22:45.106880  . /lava-1088731/environment
    2024-02-05T17:22:45.107255  / # /lava-1088731/bin/lava-test-runner /lav=
a-1088731/1
    2024-02-05T17:22:45.143360  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-05T17:22:45.188406  + cd /lava-1088731/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a77960-ulcb            | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c116d5ff7af1cba000a049

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c116d5ff7af1cba000a052
        failing since 194 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-05T17:19:15.978313  / # #

    2024-02-05T17:19:16.078799  export SHELL=3D/bin/sh

    2024-02-05T17:19:16.078907  #

    2024-02-05T17:19:16.179390  / # export SHELL=3D/bin/sh. /lava-12704579/=
environment

    2024-02-05T17:19:16.179495  =


    2024-02-05T17:19:16.279962  / # . /lava-12704579/environment/lava-12704=
579/bin/lava-test-runner /lava-12704579/1

    2024-02-05T17:19:16.280137  =


    2024-02-05T17:19:16.292249  / # /lava-12704579/bin/lava-test-runner /la=
va-12704579/1

    2024-02-05T17:19:16.345234  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-05T17:19:16.345334  + cd /lav<8>[   16.416248] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12704579_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
rk3288-veyron-jaq        | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/65c114e28e599fc6e600a061

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/65c114e28e599fc6e600a094
        failing since 385 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-05T17:10:38.086453   INC default to 1.

    2024-02-05T17:10:38.086674  =


    2024-02-05T17:10:38.090122  	-w	Pad to last with leading zeros

    2024-02-05T17:10:38.092663  	-s SEP	String separator

    2024-02-05T17:10:38.096670  /lava-12704430/1/../bin/lava-test-case

    2024-02-05T17:10:38.102818  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2024-02-05T17:10:38.102879  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/65c114e28e599fc6e600a095
        failing since 385 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-05T17:10:38.064097   multi-call binary.

    2024-02-05T17:10:38.064188  =


    2024-02-05T17:10:38.068756  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2024-02-05T17:10:38.068837  =


    2024-02-05T17:10:38.074236  Print numbers from FIRST to LAST, in steps =
of INC.

    2024-02-05T17:10:38.084682  FIRST,<8>[   18.714808] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/65c114e28e599fc6e600a096
        failing since 385 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-05T17:10:38.043307  <8>[   18.677896] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>

    2024-02-05T17:10:38.062377  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   18.695755] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c114e28e599fc6e600a0aa
        failing since 385 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-05T17:10:25.983286  <8>[    6.617827] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2024-02-05T17:10:25.992773  + <8>[    6.630139] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 12704430_1.5.2.3.1>

    2024-02-05T17:10:25.995379  set +x

    2024-02-05T17:10:26.099864  =


    2024-02-05T17:10:26.201508  / # #export SHELL=3D/bin/sh

    2024-02-05T17:10:26.202200  =


    2024-02-05T17:10:26.303542  / # export SHELL=3D/bin/sh. /lava-12704430/=
environment

    2024-02-05T17:10:26.304243  =


    2024-02-05T17:10:26.405736  / # . /lava-12704430/environment/lava-12704=
430/bin/lava-test-runner /lava-12704430/1

    2024-02-05T17:10:26.406821  =

 =

    ... (19 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1171c42d534f9d400a055

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c1171c42d534f9d400a05e
        failing since 139 days (last pass: v5.10.191-cip38-29-g9e1aa2001db8=
, first fail: v5.10.194-cip39)

    2024-02-05T17:13:42.582405  / # #

    2024-02-05T17:13:43.842270  export SHELL=3D/bin/sh

    2024-02-05T17:13:43.853145  #

    2024-02-05T17:13:43.853598  / # export SHELL=3D/bin/sh

    2024-02-05T17:13:45.596352  / # . /lava-12704589/environment

    2024-02-05T17:13:48.799511  /lava-12704589/bin/lava-test-runner /lava-1=
2704589/1

    2024-02-05T17:13:48.810906  . /lava-12704589/environment

    2024-02-05T17:13:48.816764  / # /lava-12704589/bin/lava-test-runner /la=
va-12704589/1

    2024-02-05T17:13:48.866650  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-05T17:13:48.867087  + cd /lava-12704589/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
sun50i-a64-pine64-plus   | arm64 | lab-broonie     | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c11746d85ef1be6200a044

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c11746d85ef1be6200a074
        failing since 387 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-05T17:13:20.418747  + set +x
    2024-02-05T17:13:20.422848  <8>[   17.031681] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 546396_1.5.2.4.1>
    2024-02-05T17:13:20.533713  / # #
    2024-02-05T17:13:20.635930  export SHELL=3D/bin/sh
    2024-02-05T17:13:20.636419  #
    2024-02-05T17:13:20.737927  / # . /lava-546396/environment
    2024-02-05T17:13:20.880058  export SHELL=3D/bin/sh
    2024-02-05T17:13:20.880409  / # . /lava-546396/environment
    2024-02-05T17:13:20.981965  / # /lava-546396/bin/lava-test-runner /lava=
-546396/1
    2024-02-05T17:13:20.987102  /lava-546396/bin/lava-test-runner /lava-546=
396/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64       | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c116eb539d06b21200a03b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c116eb539d06b21200a044
        failing since 194 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2024-02-05T17:19:36.760621  / # #

    2024-02-05T17:19:36.862777  export SHELL=3D/bin/sh

    2024-02-05T17:19:36.863506  #

    2024-02-05T17:19:36.964990  / # export SHELL=3D/bin/sh. /lava-12704578/=
environment

    2024-02-05T17:19:36.965735  =


    2024-02-05T17:19:37.067205  / # . /lava-12704578/environment/lava-12704=
578/bin/lava-test-runner /lava-12704578/1

    2024-02-05T17:19:37.068398  =


    2024-02-05T17:19:37.084908  / # /lava-12704578/bin/lava-test-runner /la=
va-12704578/1

    2024-02-05T17:19:37.128791  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-05T17:19:37.142777  + cd /lava-1270457<8>[   18.227591] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12704578_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

