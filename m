Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0649C4167B
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 15:45:49 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web10.25748.1702568741240630523
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Dec 2023 07:45:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=jvm+qUDp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28b012f93eeso908719a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 14 Dec 2023 07:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702568740; x=1703173540; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bfjpmVKE0iuA/H3jaG/PFhDZvGtNAeU1SJHZjc3kc5g=;
        b=jvm+qUDpD/TvDe+r7fC4QYS/Z5c6i8nbfm7UvuR21rjjV31ITkxzN3DqofPXgbHCmM
         hfi0/CQajnK9m1y7ZtdBrWCl/6vbih79Jhqdc4F2ji7vj3qJH55/2A/o645F5YXSB052
         ChhYUOl61Gl2B6pGp051FV2NMcgDkvtEe2moSOXrm+JfUN9+goTHUx9rGmAwR1jrTEmN
         BAF9EUhfphprBkZsmDwz49jJ0y2Z3qnC6I9K6J6IIcJi0bewMsCfn6D2dgsoXGUKC5YP
         sgKHeRwpMpSj4DM1+7JVuIzeVjdNlltEfkxkvP/7fV2V+YDeK0XfNkfw9GWm/9U0/51D
         WDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702568740; x=1703173540;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bfjpmVKE0iuA/H3jaG/PFhDZvGtNAeU1SJHZjc3kc5g=;
        b=np73puZGNLo/ZeGOVJ3BcT3l23GtsavXsbtnQWLMmvPyQnHpcAm9xviNubifoIqF2Q
         SgKIjmbGfH0PLL1gFrDamx46mZAuuv/LiZEKCW6Lcx8/XsnTzY++w2mmxUxN8Ti5GVqs
         ePKOv2Oj94ImhIav1pfg3JkqVKkBEa+hUDRqrc7BmBDrtTwH7JbAy3nkjn3s8tR8iuqu
         xKILRdTUbLw5HrIaE4P02NNUd8eXItacWr1SmjCq1A3iYR1Zxf9RM4qKQdcgGddpd6fd
         cvCbJ3KKp+ShX7Gozn4AJCjul+kHVKpp6BOKuoz7GyT1Nb89oHLccH9OFkbEROo5TFpx
         pz5A==
X-Gm-Message-State: AOJu0Yxv/SSuGgtIC6gDZS5+LWA20n+T+SQV5K6NrRUaKR5ZIgH3EgM/
	rYYyGbxP8MEjNabcEampw5C0t0RR9vtOchCLTIE=
X-Google-Smtp-Source: AGHT+IFZboXt5OtMxavqczTcQJg+d4Kk6a0bmL0uzGlz8MmXAefBBlyNqFf21AiQlsWmT4jG5BdSoA==
X-Received: by 2002:a17:90a:468e:b0:28a:f90f:9bd8 with SMTP id z14-20020a17090a468e00b0028af90f9bd8mr1130290pjf.94.1702568740225;
        Thu, 14 Dec 2023 07:45:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id nb14-20020a17090b35ce00b0028ad536ea86sm978688pjb.48.2023.12.14.07.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 07:45:39 -0800 (PST)
Message-ID: <657b2323.170a0220.27e61.3133@mx.google.com>
Date: Thu, 14 Dec 2023 07:45:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-69-g8f7b450fc28ed
Subject: cip/linux-5.10.y-cip baseline-nfs: 36 runs,
 5 regressions (v5.10.201-cip41-69-g8f7b450fc28ed)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 15:45:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14111

cip/linux-5.10.y-cip baseline-nfs: 36 runs, 5 regressions (v5.10.201-cip41-=
69-g8f7b450fc28ed)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
beaglebone-black         | arm   | lab-cip       | gcc-10   | multi_v7_defc=
onfig  | 1          =

imx6q-sabrelite          | arm   | lab-collabora | gcc-10   | multi_v7_defc=
onfig  | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
       | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
       | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-69-g8f7b450fc28ed/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-69-g8f7b450fc28ed
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8f7b450fc28ed99196853536c98ae36c2567e160 =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
beaglebone-black         | arm   | lab-cip       | gcc-10   | multi_v7_defc=
onfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/657b22c50cfb435850e1347b

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/657b22c50cfb435850e134a8
        failing since 334 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-14T15:43:06.585369  + set +x
    2023-12-14T15:43:06.589751  <8>[   68.748228] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1059372_1.6.2.4.1>
    2023-12-14T15:43:06.976387  #
    2023-12-14T15:43:07.078438  / # #export SHELL=3D/bin/sh
    2023-12-14T15:43:07.079046  =

    2023-12-14T15:43:07.179971  / # export SHELL=3D/bin/sh. /lava-1059372/e=
nvironment
    2023-12-14T15:43:07.180528  =

    2023-12-14T15:43:07.281434  / # . /lava-1059372/environment/lava-105937=
2/bin/lava-test-runner /lava-1059372/1
    2023-12-14T15:43:07.282309  =

    2023-12-14T15:43:07.288302  / # /lava-1059372/bin/lava-test-runner /lav=
a-1059372/1 =

    ... (13 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
imx6q-sabrelite          | arm   | lab-collabora | gcc-10   | multi_v7_defc=
onfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/657b19f88f1d74df70e13481

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/657b19f88f1d74df70e13486
        failing since 334 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-14T15:06:17.514300  / # #

    2023-12-14T15:06:17.617059  export SHELL=3D/bin/sh

    2023-12-14T15:06:17.617890  #

    2023-12-14T15:06:17.719799  / # export SHELL=3D/bin/sh. /lava-12271973/=
environment

    2023-12-14T15:06:17.720644  =


    2023-12-14T15:06:17.822438  / # . /lava-12271973/environment/lava-12271=
973/bin/lava-test-runner /lava-12271973/1

    2023-12-14T15:06:17.823830  =


    2023-12-14T15:06:17.827127  / # /lava-12271973/bin/lava-test-runner /la=
va-12271973/1

    2023-12-14T15:06:17.986975  + export TESTRUN_ID=3D1_bootrr

    2023-12-14T15:06:18.002753  + cd /lava-12271973/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/657b1b763929032137e1347a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774=
a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774=
a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/657b1b76392903213=
7e1347b
        failing since 71 days (last pass: v5.10.194-cip39, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/657b19215c64b0210ee13477

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gcc-10/lab-collabora/bas=
eline-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gcc-10/lab-collabora/bas=
eline-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/657b19215c64b0210ee1347c
        failing since 71 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff)

    2023-12-14T15:02:30.298378  / # #

    2023-12-14T15:02:31.558722  export SHELL=3D/bin/sh

    2023-12-14T15:02:31.569661  #

    2023-12-14T15:02:31.570118  / # export SHELL=3D/bin/sh

    2023-12-14T15:02:33.313281  . /lava-12271855/environment

    2023-12-14T15:02:33.324148  / # . /lava-12271855/environment

    2023-12-14T15:02:36.517858  /lava-12271855/bin/lava-test-runner /lava-1=
2271855/1

    2023-12-14T15:02:36.535673  / # /lava-12271855/bin/lava-test-runner /la=
va-12271855/1

    2023-12-14T15:02:36.936143  + export TESTRUN_ID=3D1_bootrr

    2023-12-14T15:02:36.936616  + cd /lava-12271855/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/657b1b032c3c9a0542e13475

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-=
rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-=
rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/657b1b032c3c9a0542e1347a
        failing since 71 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff)

    2023-12-14T15:10:39.990339  / # #

    2023-12-14T15:10:41.250685  export SHELL=3D/bin/sh

    2023-12-14T15:10:41.261547  #

    2023-12-14T15:10:41.261996  / # export SHELL=3D/bin/sh

    2023-12-14T15:10:43.004207  / # . /lava-12272027/environment

    2023-12-14T15:10:46.204742  /lava-12272027/bin/lava-test-runner /lava-1=
2272027/1

    2023-12-14T15:10:46.216178  . /lava-12272027/environment

    2023-12-14T15:10:46.216494  / # /lava-12272027/bin/lava-test-runner /la=
va-12272027/1

    2023-12-14T15:10:46.416534  + export TESTRUN_ID=3D1_bootrr

    2023-12-14T15:10:46.416984  + cd /lava-12272027/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =20

