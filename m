Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A99EC4707C
	for <webhook@archiver.kernel.org>; Fri,  5 Jan 2024 20:38:58 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web11.34177.1704487133440431057
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 05 Jan 2024 12:38:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ydkkaSL/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d3f8af8297so12138865ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 05 Jan 2024 12:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704487132; x=1705091932; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G8UUtzvZJHz6hLoyztOSJZm+92vkXhaBx3Cu7tCV44A=;
        b=ydkkaSL/UP5bs610E/ewCp4qAwReD8UWiFqNApEswdkn8ecYdqAHWPLDk+ygK31jsZ
         XHvMJKaUxJXwAUbAiBf9LN7AhdHIsCnLeOzuajq0dnuDsznmo3SumO9aPyzfFovttNTe
         3h6V5ynZw+lp2L5qPMOa9aFb32p/jFxH53dzLQSh1qCpP+gKI/uehT1CVRr7t7/+m4eK
         cZ0OFN2N+rsETIbrs+dEJG5Nv6zb9fmVxhNSiGYYq3ENhdycx+iTstLsuD+qNAj5K3+n
         eXuf4zmAr91r7jZ7VoCyJNakK8Y9ydfxbJOWjiTsO2qnw1WTJ+sXNJ/Bpjjc+akgHgeD
         4GbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704487132; x=1705091932;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8UUtzvZJHz6hLoyztOSJZm+92vkXhaBx3Cu7tCV44A=;
        b=p8RVKhogrr0rix5F3BmviNkyrB5YRqCbEgkGzrpxMZfDkn9AOvH6b2oGxlfCLJiFk4
         jE4wzCgocHiywWyqJ3Pvy33MpMNo/pYFB1WFd7hziw3pnizUbLg3m4+e353/3CXz9Mat
         qiPfuEE5fy9UW91QHxoD7C+Z7Rk7l39dJiYV9422tT6Wsx8Ii9Cl6SzgerBhiRHJ/+ao
         rwxDotBm2YmT5PnxMCnTQoCn1dtkZ/iIYRw3EGMe1N5MlIXwfbCUlZYrnybESh2SL+W4
         JQP1LqTPJUH7on6T7+ZJkT/67PiXl7NRBrFyK3sLwf/PWHB2yIsh0NNI2GBUGZu58SyQ
         nx5g==
X-Gm-Message-State: AOJu0YyBKtShPefuaNR1gZ/hnlaLYx0gQMV/aNIG4PARgR7rfO2M0DNc
	ij1b25gBvhFcWYJyVYGyxigdtzdzL4ckvZQxOr30YeGNFpo=
X-Google-Smtp-Source: AGHT+IGzk3hTGtt+GsKn0FDgpAT4yYBvYIB4jg3zRtALM8IZR7caa8jr/ViDeeOt1yCcLOHvS2s+EA==
X-Received: by 2002:a17:902:8f8b:b0:1d4:814a:1cf5 with SMTP id z11-20020a1709028f8b00b001d4814a1cf5mr13282plo.133.1704487132013;
        Fri, 05 Jan 2024 12:38:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902d90500b001d3b258e036sm1806779plz.176.2024.01.05.12.38.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 12:38:51 -0800 (PST)
Message-ID: <659868db.170a0220.22edd.41a1@mx.google.com>
Date: Fri, 05 Jan 2024 12:38:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.205-897-gcc9858ae2881
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 156 runs,
 18 regressions (v5.10.205-897-gcc9858ae2881)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jan 2024 20:38:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14258

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 156 runs, 18 regressio=
ns (v5.10.205-897-gcc9858ae2881)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora | gcc-10   | bcm2835_defco=
nfig            | 1          =

beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config          | 1          =

beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config          | 1          =

juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig+kse=
lftest          | 1          =

r8a7743-iwg20d-q7        | arm   | lab-cip       | gcc-10   | shmobile_defc=
onfig           | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest          | 1          =

r8a77960-ulcb            | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook   | 2          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
...ok+kselftest | 2          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest          | 1          =

sun50i-h6-pine-h64       | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.205-897-gcc9858ae2881/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.205-897-gcc9858ae2881
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      cc9858ae2881ce2dd7cb1eab9e7038ce843f1bfe =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora | gcc-10   | bcm2835_defco=
nfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/65985b9c449d1013fb52a3f8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm/bcm2835_defconfig/gcc-10/lab-c=
ollabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm/bcm2835_defconfig/gcc-10/lab-c=
ollabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65985b9d449d1013fb52a401
        failing since 162 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-01-05T19:49:38.388686  / # #

    2024-01-05T19:49:38.490696  export SHELL=3D/bin/sh

    2024-01-05T19:49:38.491364  #

    2024-01-05T19:49:38.592618  / # export SHELL=3D/bin/sh. /lava-12460558/=
environment

    2024-01-05T19:49:38.593325  =


    2024-01-05T19:49:38.694745  / # . /lava-12460558/environment/lava-12460=
558/bin/lava-test-runner /lava-12460558/1

    2024-01-05T19:49:38.695843  =


    2024-01-05T19:49:38.712915  / # /lava-12460558/bin/lava-test-runner /la=
va-12460558/1

    2024-01-05T19:49:38.776728  + export 'TESTRUN_ID=3D1_bootrr'

    2024-01-05T19:49:38.814813  + cd /lava-12460558/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/65985bb2024a99abef52a41c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm/omap2plus_defconfig/gcc-10/lab=
-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm/omap2plus_defconfig/gcc-10/lab=
-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65985bb2024a99abef52a453
        failing since 366 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2024-01-05T19:42:25.495796  <8>[   21.513037] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 422110_1.5.2.4.1>
    2024-01-05T19:42:25.605102  / # #
    2024-01-05T19:42:25.707595  export SHELL=3D/bin/sh
    2024-01-05T19:42:25.708222  #
    2024-01-05T19:42:25.810022  / # export SHELL=3D/bin/sh. /lava-422110/en=
vironment
    2024-01-05T19:42:25.810648  =

    2024-01-05T19:42:25.912495  / # . /lava-422110/environment/lava-422110/=
bin/lava-test-runner /lava-422110/1
    2024-01-05T19:42:25.913334  =

    2024-01-05T19:42:25.918128  / # /lava-422110/bin/lava-test-runner /lava=
-422110/1
    2024-01-05T19:42:26.017020  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/65985b7a57f793f1db52a40b

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm/omap2plus_defconfig/gcc-10/lab=
-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm/omap2plus_defconfig/gcc-10/lab=
-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65985b7a57f793f1db52a444
        failing since 366 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2024-01-05T19:41:34.699114  / # #
    2024-01-05T19:41:34.800072  export SHELL=3D/bin/sh
    2024-01-05T19:41:34.800436  #
    2024-01-05T19:41:34.901151  / # export SHELL=3D/bin/sh. /lava-1070208/e=
nvironment
    2024-01-05T19:41:34.901533  =

    2024-01-05T19:41:35.002333  / # . /lava-1070208/environment/lava-107020=
8/bin/lava-test-runner /lava-1070208/1
    2024-01-05T19:41:35.002833  =

    2024-01-05T19:41:35.013032  / # /lava-1070208/bin/lava-test-runner /lav=
a-1070208/1
    2024-01-05T19:41:35.151950  + export 'TESTRUN_ID=3D1_bootrr'
    2024-01-05T19:41:35.152139  + cd /lava-1070208/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6598621143ff6a8d6452a405

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+kselftest/gcc-10/l=
ab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+kselftest/gcc-10/l=
ab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6598621243ff6a8d6452a443
        failing since 106 days (last pass: v5.10.191-cip38-661-g112a3073ff2=
6, first fail: v5.10.194-cip39-407-g664623343843d)

    2024-01-05T20:09:14.680278  <8>[   19.042213] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 422307_1.5.2.4.1>
    2024-01-05T20:09:14.788067  / # #
    2024-01-05T20:09:14.890935  export SHELL=3D/bin/sh
    2024-01-05T20:09:14.891706  #
    2024-01-05T20:09:14.993642  / # export SHELL=3D/bin/sh. /lava-422307/en=
vironment
    2024-01-05T20:09:14.994468  =

    2024-01-05T20:09:15.096465  / # . /lava-422307/environment/lava-422307/=
bin/lava-test-runner /lava-422307/1
    2024-01-05T20:09:15.097713  =

    2024-01-05T20:09:15.111677  / # /lava-422307/bin/lava-test-runner /lava=
-422307/1
    2024-01-05T20:09:15.288407  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a7743-iwg20d-q7        | arm   | lab-cip       | gcc-10   | shmobile_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65985cb0aba7efccc452a421

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm/shmobile_defconfig/gcc-10/lab-=
cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm/shmobile_defconfig/gcc-10/lab-=
cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65985cb0aba7efccc452a=
422
        failing since 22 days (last pass: v5.10.201-cip41-473-gc43d7b7bbe83=
a, first fail: v5.10.201-cip41-69-g8f7b450fc28ed) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65985f6aca63fae0a452a412

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65985f6aca63fae0a452a41b
        failing since 162 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-01-05T19:58:08.212786  + set +x
    2024-01-05T19:58:08.216055  <8>[   83.960289] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1070252_1.5.2.4.1>
    2024-01-05T19:58:08.323226  / # #
    2024-01-05T19:58:09.780798  export SHELL=3D/bin/sh
    2024-01-05T19:58:09.801719  #
    2024-01-05T19:58:09.802146  / # export SHELL=3D/bin/sh
    2024-01-05T19:58:11.751430  / # . /lava-1070252/environment
    2024-01-05T19:58:15.336814  /lava-1070252/bin/lava-test-runner /lava-10=
70252/1
    2024-01-05T19:58:15.358080  . /lava-1070252/environment
    2024-01-05T19:58:15.358431  / # /lava-1070252/bin/lava-test-runner /lav=
a-1070252/1 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65985e7cc717e4dab352a3f3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65985e7cc717e4dab352a3fc
        failing since 162 days (last pass: v5.10.182-cip35-289-g3c054954070=
6, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-01-05T19:54:09.354773  + set +x
    2024-01-05T19:54:09.357859  <8>[   84.184617] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1070245_1.5.2.4.1>
    2024-01-05T19:54:09.466294  / # #
    2024-01-05T19:54:10.924199  export SHELL=3D/bin/sh
    2024-01-05T19:54:10.944541  #
    2024-01-05T19:54:10.944653  / # export SHELL=3D/bin/sh
    2024-01-05T19:54:12.893611  / # . /lava-1070245/environment
    2024-01-05T19:54:16.480263  /lava-1070245/bin/lava-test-runner /lava-10=
70245/1
    2024-01-05T19:54:16.501553  . /lava-1070245/environment
    2024-01-05T19:54:16.501907  / # /lava-1070245/bin/lava-test-runner /lav=
a-1070245/1 =

    ... (15 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65986021a03488691852a3ff

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65986021a03488691852a408
        failing since 162 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-01-05T20:01:09.781045  / # #
    2024-01-05T20:01:11.237770  export SHELL=3D/bin/sh
    2024-01-05T20:01:11.258673  #
    2024-01-05T20:01:11.259172  / # export SHELL=3D/bin/sh
    2024-01-05T20:01:13.207245  / # . /lava-1070249/environment
    2024-01-05T20:01:16.792254  /lava-1070249/bin/lava-test-runner /lava-10=
70249/1
    2024-01-05T20:01:16.813545  . /lava-1070249/environment
    2024-01-05T20:01:16.813838  / # /lava-1070249/bin/lava-test-runner /lav=
a-1070249/1
    2024-01-05T20:01:16.894071  + export 'TESTRUN_ID=3D1_bootrr'
    2024-01-05T20:01:16.894481  + cd /lava-1070249/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6598623c317c1491f952a3f6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig/gcc-10/lab-cip/bas=
eline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig/gcc-10/lab-cip/bas=
eline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6598623c317c1491f952a3ff
        failing since 162 days (last pass: v5.10.182-cip35-289-g3c054954070=
6, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-01-05T20:10:10.621068  / # #
    2024-01-05T20:10:12.079550  export SHELL=3D/bin/sh
    2024-01-05T20:10:12.099996  #
    2024-01-05T20:10:12.100182  / # export SHELL=3D/bin/sh
    2024-01-05T20:10:14.047851  / # . /lava-1070273/environment
    2024-01-05T20:10:17.633245  /lava-1070273/bin/lava-test-runner /lava-10=
70273/1
    2024-01-05T20:10:17.654757  . /lava-1070273/environment
    2024-01-05T20:10:17.655153  / # /lava-1070273/bin/lava-test-runner /lav=
a-1070273/1
    2024-01-05T20:10:17.733390  + export 'TESTRUN_ID=3D1_bootrr'
    2024-01-05T20:10:17.733924  + cd /lava-1070273/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65986342d61ad331f852a3fc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+kselftest/gcc-10/l=
ab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+kselftest/gcc-10/l=
ab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65986342d61ad331f852a405
        failing since 162 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-01-05T20:14:29.610650  / #
    2024-01-05T20:14:31.071218  # #export SHELL=3D/bin/sh
    2024-01-05T20:14:31.092253  =

    2024-01-05T20:14:31.092798  / # export SHELL=3D/bin/sh
    2024-01-05T20:14:33.045076  / # . /lava-1070287/environment
    2024-01-05T20:14:36.635641  /lava-1070287/bin/lava-test-runner /lava-10=
70287/1
    2024-01-05T20:14:36.656347  . /lava-1070287/environment
    2024-01-05T20:14:36.656465  / # /lava-1070287/bin/lava-test-runner /lav=
a-1070287/1
    2024-01-05T20:14:36.837976  + export 'TESTRUN_ID=3D1_bootrr'
    2024-01-05T20:14:36.838512  + cd /lava-1070287/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a77960-ulcb            | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65986026a6243e7f8352a49b

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig/gcc-10/lab-collabo=
ra/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig/gcc-10/lab-collabo=
ra/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65986026a6243e7f8352a4a4
        failing since 162 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-01-05T20:08:52.964857  / # #

    2024-01-05T20:08:53.066807  export SHELL=3D/bin/sh

    2024-01-05T20:08:53.067519  #

    2024-01-05T20:08:53.168991  / # export SHELL=3D/bin/sh. /lava-12460784/=
environment

    2024-01-05T20:08:53.169704  =


    2024-01-05T20:08:53.271203  / # . /lava-12460784/environment/lava-12460=
784/bin/lava-test-runner /lava-12460784/1

    2024-01-05T20:08:53.272376  =


    2024-01-05T20:08:53.289199  / # /lava-12460784/bin/lava-test-runner /la=
va-12460784/1

    2024-01-05T20:08:53.337920  + export 'TESTRUN_ID=3D1_bootrr'

    2024-01-05T20:08:53.338427  + cd /lav<8>[   16.435574] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12460784_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/65985dea8d9459b42552a571

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/65985dea8d9459b42552a57b
        failing since 260 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2024-01-05T19:52:38.183595  /lava-12460613/1/../bin/lava-test-case

    2024-01-05T19:52:38.194732  <8>[   35.031289] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/65985dea8d9459b42552a57c
        failing since 260 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2024-01-05T19:52:37.148146  /lava-12460613/1/../bin/lava-test-case

    2024-01-05T19:52:37.159752  <8>[   33.995376] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
...ok+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/6598629a5edb7403a852a48a

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+arm64-chromebook+k=
selftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+arm64-chromebook+k=
selftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6598629a5edb7403a852a494
        failing since 260 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2024-01-05T20:12:25.060769  /lava-12460834/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6598629a5edb7403a852a495
        failing since 260 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2024-01-05T20:12:23.962833  /lava-12460834/1/../bin/lava-test-case

    2024-01-05T20:12:23.986735  <8>[   42.858148] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6598605c1b400a63ef52a3f7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig/gcc-10/lab-collabo=
ra/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig/gcc-10/lab-collabo=
ra/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6598605c1b400a63ef52a400
        failing since 132 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4=
c8, first fail: v5.10.186-cip37-982-g80a0585c0aa62)

    2024-01-05T20:07:18.789541  / # #

    2024-01-05T20:07:20.050667  export SHELL=3D/bin/sh

    2024-01-05T20:07:20.061656  #

    2024-01-05T20:07:20.062129  / # export SHELL=3D/bin/sh

    2024-01-05T20:07:21.806090  / # . /lava-12460776/environment

    2024-01-05T20:07:25.009402  /lava-12460776/bin/lava-test-runner /lava-1=
2460776/1

    2024-01-05T20:07:25.020849  . /lava-12460776/environment

    2024-01-05T20:07:25.026762  / # /lava-12460776/bin/lava-test-runner /la=
va-12460776/1

    2024-01-05T20:07:25.076824  + export 'TESTRUN_ID=3D1_bootrr'

    2024-01-05T20:07:25.077282  + cd /lava-12460776/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/659860bc1b0c128f0652a40d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+kselftest/gcc-10/l=
ab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+kselftest/gcc-10/l=
ab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/659860bc1b0c128f0652a416
        failing since 132 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4=
c8, first fail: v5.10.186-cip37-982-g80a0585c0aa62)

    2024-01-05T20:03:55.329347  / # #

    2024-01-05T20:03:56.589810  export SHELL=3D/bin/sh

    2024-01-05T20:03:56.600770  #

    2024-01-05T20:03:56.601238  / # export SHELL=3D/bin/sh

    2024-01-05T20:03:58.344356  / # . /lava-12460797/environment

    2024-01-05T20:04:01.546441  /lava-12460797/bin/lava-test-runner /lava-1=
2460797/1

    2024-01-05T20:04:01.557811  . /lava-12460797/environment

    2024-01-05T20:04:01.563673  / # /lava-12460797/bin/lava-test-runner /la=
va-12460797/1

    2024-01-05T20:04:01.691207  + export 'TESTRUN_ID=3D1_bootrr'

    2024-01-05T20:04:01.691657  + cd /lava-12460797/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
sun50i-h6-pine-h64       | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65986025a03488691852a40c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig/gcc-10/lab-collabo=
ra/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig/gcc-10/lab-collabo=
ra/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65986025a03488691852a415
        failing since 162 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-01-05T20:09:04.865007  / # #

    2024-01-05T20:09:04.965655  export SHELL=3D/bin/sh

    2024-01-05T20:09:04.965792  #

    2024-01-05T20:09:05.066332  / # export SHELL=3D/bin/sh. /lava-12460781/=
environment

    2024-01-05T20:09:05.066458  =


    2024-01-05T20:09:05.166971  / # . /lava-12460781/environment/lava-12460=
781/bin/lava-test-runner /lava-12460781/1

    2024-01-05T20:09:05.167234  =


    2024-01-05T20:09:05.178494  / # /lava-12460781/bin/lava-test-runner /la=
va-12460781/1

    2024-01-05T20:09:05.238462  + export 'TESTRUN_ID=3D1_bootrr'

    2024-01-05T20:09:05.238536  + cd /lava-1246078<8>[   18.233762] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12460781_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

