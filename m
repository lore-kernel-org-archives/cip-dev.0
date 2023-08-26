Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68785C83F16
	for <webhook@archiver.kernel.org>; Sat, 26 Aug 2023 16:56:27 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web10.12166.1693068979951097870
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 26 Aug 2023 09:56:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=R2wE3zLP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.171, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-56a8794b5adso1108635a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 26 Aug 2023 09:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693068979; x=1693673779;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jrJkLKSKTyd46+y4tcq9tgSsrCPskyypkdr9+SNu5rk=;
        b=R2wE3zLPmCD5IHKPEoP/GjwmHGw64d7/7uDxNfMIQSZBDDGwDWodAnLEEd60dSWaz8
         50LK0dIaIodb95yBfZN5CnWFBJzMb6VkrHGf8Lp96nTHoPpEkVejru4l930V+MtgFdpo
         8ni+wm1C5Btvf4tBzMAEfVse7vx2xGj2Na5gIUNKkYhvqtu8yZ9ieUCL85GSoQvKh4qA
         uxop4HCKvrYb8Y3Vcxi/u+ONAT2TqtebeKSNdC6FIOqGtM0IpXnNoczZh3ilaFcx+uga
         SAfhaihhOBVKKScWpnEH2DCTet298tSVTWax5npxVKLkE5gcV9i6d/S6SL7PCZ5q6hLn
         B/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693068979; x=1693673779;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrJkLKSKTyd46+y4tcq9tgSsrCPskyypkdr9+SNu5rk=;
        b=jc1bwLXc1/0BB0Z5S1ZSBcR3vZgYGoqIttnLpEI+eCQwlosS9yK6bvi7LqcWT8p8Sy
         p1bh14mMClr/YiFaRNrMQiCObyrf54Kx7zqtH2Zo1y07J9yXGC8AkYfJwdW+CC/DqvgM
         gNDqV1MZvGvWZSsUoRTlzfN4eAn2lWvbgCAPEtlCwAEoSIrvUw24dAQzle3M+13yj2fR
         1Cf8xnZrxBVEFsxICrst/4ABzccdy4uq2Vfsj14mysmTBn5CX6xbaPU0Bwnbo82h1eqS
         kpgm03TNmc6Dx4i3hD7T6uCdReUlnBxUZh68VGGer9ZzzlUqB0lOw9GVDpb6FFZSh7OY
         j+2Q==
X-Gm-Message-State: AOJu0YxAgNEsJOrxaiOUCT4igc8iTaaaBXCojaOuZW+XhsAZ3c0mt2PD
	q4/CD7scoW+rD3qRUuTpUns32RKALcsTdRHgnBo=
X-Google-Smtp-Source: AGHT+IFEjHQxp+0LkwyAcSirbK5Zs94/08BgrA7TjodLmEfvuoKTqR+yRreevkD4gN7l05pqqscX2A==
X-Received: by 2002:a17:90a:4982:b0:26b:3a18:3559 with SMTP id d2-20020a17090a498200b0026b3a183559mr19821433pjh.4.1693068977840;
        Sat, 26 Aug 2023 09:56:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ce13-20020a17090aff0d00b0026f5dd4ba28sm384695pjb.1.2023.08.26.09.56.16
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 09:56:16 -0700 (PDT)
Message-ID: <64ea2eb0.170a0220.c6c7d.006c@mx.google.com>
Date: Sat, 26 Aug 2023 09:56:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-982-g80a0585c0aa62
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 178 runs,
 25 regressions (v5.10.186-cip37-982-g80a0585c0aa62)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 26 Aug 2023 16:56:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12852

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 178 runs, 25 regressio=
ns (v5.10.186-cip37-982-g80a0585c0aa62)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =

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

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.186-cip37-982-g80a0585c0aa62/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.186-cip37-982-g80a0585c0aa62
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      80a0585c0aa62f4c1dd47f7b489c39ee5bba99ab =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea22a8883fa7bbcf286dd2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm/bcm2835_defconfig/gcc-1=
0/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm/bcm2835_defconfig/gcc-1=
0/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea22a8883fa7bbcf286dd7
        failing since 30 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-26T16:06:18.771272  / # #

    2023-08-26T16:06:18.873395  export SHELL=3D/bin/sh

    2023-08-26T16:06:18.874093  #

    2023-08-26T16:06:18.975440  / # export SHELL=3D/bin/sh. /lava-11363385/=
environment

    2023-08-26T16:06:18.976146  =


    2023-08-26T16:06:19.077609  / # . /lava-11363385/environment/lava-11363=
385/bin/lava-test-runner /lava-11363385/1

    2023-08-26T16:06:19.078702  =


    2023-08-26T16:06:19.080234  / # /lava-11363385/bin/lava-test-runner /la=
va-11363385/1

    2023-08-26T16:06:19.198189  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T16:06:19.198698  + cd /lava-11363385/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea226f56efba1320286d6c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea226f56efba1320286da0
        failing since 234 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-08-26T16:03:41.606346  <8>[   20.404477] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 72085_1.5.2.4.1>
    2023-08-26T16:03:41.717811  / # #
    2023-08-26T16:03:41.820919  export SHELL=3D/bin/sh
    2023-08-26T16:03:41.821824  #
    2023-08-26T16:03:41.923761  / # export SHELL=3D/bin/sh. /lava-72085/env=
ironment
    2023-08-26T16:03:41.924649  =

    2023-08-26T16:03:42.026808  / # . /lava-72085/environment/lava-72085/bi=
n/lava-test-runner /lava-72085/1
    2023-08-26T16:03:42.028226  =

    2023-08-26T16:03:42.032821  / # /lava-72085/bin/lava-test-runner /lava-=
72085/1
    2023-08-26T16:03:42.142404  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea225dd7cb8d2978286d7d

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea225dd7cb8d2978286d84
        failing since 234 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-08-26T16:03:29.611154  + set +x
    2023-08-26T16:03:29.613284  <8>[   13.985944] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1001175_1.5.2.4.1>
    2023-08-26T16:03:29.722707  / # #
    2023-08-26T16:03:29.824504  export SHELL=3D/bin/sh
    2023-08-26T16:03:29.824956  #
    2023-08-26T16:03:29.926342  / # export SHELL=3D/bin/sh. /lava-1001175/e=
nvironment
    2023-08-26T16:03:29.926791  =

    2023-08-26T16:03:30.028237  / # . /lava-1001175/environment/lava-100117=
5/bin/lava-test-runner /lava-1001175/1
    2023-08-26T16:03:30.028964  =

    2023-08-26T16:03:30.031331  / # /lava-1001175/bin/lava-test-runner /lav=
a-1001175/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea2245fc78995f00286d87

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4=
020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4=
020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea2245fc78995f00286d8c
        failing since 128 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-26T16:02:54.897394  + set +x<8>[   12.955748] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11363381_1.4.2.3.1>

    2023-08-26T16:02:54.897502  =


    2023-08-26T16:02:55.001798  / # #

    2023-08-26T16:02:55.102341  export SHELL=3D/bin/sh

    2023-08-26T16:02:55.102509  #

    2023-08-26T16:02:55.202964  / # export SHELL=3D/bin/sh. /lava-11363381/=
environment

    2023-08-26T16:02:55.203159  =


    2023-08-26T16:02:55.303720  / # . /lava-11363381/environment/lava-11363=
381/bin/lava-test-runner /lava-11363381/1

    2023-08-26T16:02:55.304046  =


    2023-08-26T16:02:55.308833  / # /lava-11363381/bin/lava-test-runner /la=
va-11363381/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea22e394dcbefe43286dda

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopu=
s.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopu=
s.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea22e394dcbefe43286ddf
        failing since 128 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-26T16:05:31.230767  + <8>[   10.660283] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11363422_1.4.2.3.1>

    2023-08-26T16:05:31.230852  set +x

    2023-08-26T16:05:31.332222  #

    2023-08-26T16:05:31.332547  =


    2023-08-26T16:05:31.433166  / # #export SHELL=3D/bin/sh

    2023-08-26T16:05:31.433372  =


    2023-08-26T16:05:31.533941  / # export SHELL=3D/bin/sh. /lava-11363422/=
environment

    2023-08-26T16:05:31.534200  =


    2023-08-26T16:05:31.634733  / # . /lava-11363422/environment/lava-11363=
422/bin/lava-test-runner /lava-11363422/1

    2023-08-26T16:05:31.635030  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea2235d2445bc99a286e17

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea2235d2445bc99a286e1c
        failing since 128 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-26T16:03:01.432577  + set +x

    2023-08-26T16:03:01.439268  <8>[   12.866297] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11363382_1.4.2.3.1>

    2023-08-26T16:03:01.543652  / # #

    2023-08-26T16:03:01.644192  export SHELL=3D/bin/sh

    2023-08-26T16:03:01.644347  #

    2023-08-26T16:03:01.744827  / # export SHELL=3D/bin/sh. /lava-11363382/=
environment

    2023-08-26T16:03:01.745008  =


    2023-08-26T16:03:01.845506  / # . /lava-11363382/environment/lava-11363=
382/bin/lava-test-runner /lava-11363382/1

    2023-08-26T16:03:01.845749  =


    2023-08-26T16:03:01.850806  / # /lava-11363382/bin/lava-test-runner /la=
va-11363382/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea22cfb7408eb1b7286ddb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea22cfb7408eb1b7286de0
        failing since 128 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-26T16:05:26.898223  + set +x

    2023-08-26T16:05:26.904958  <8>[   11.392334] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11363401_1.4.2.3.1>

    2023-08-26T16:05:27.007197  =


    2023-08-26T16:05:27.107878  / # #export SHELL=3D/bin/sh

    2023-08-26T16:05:27.108058  =


    2023-08-26T16:05:27.208584  / # export SHELL=3D/bin/sh. /lava-11363401/=
environment

    2023-08-26T16:05:27.208806  =


    2023-08-26T16:05:27.309342  / # . /lava-11363401/environment/lava-11363=
401/bin/lava-test-runner /lava-11363401/1

    2023-08-26T16:05:27.309619  =


    2023-08-26T16:05:27.314381  / # /lava-11363401/bin/lava-test-runner /la=
va-11363401/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea229f883fa7bbcf286d8a

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig/gcc-10/lab-=
broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig/gcc-10/lab-=
broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea229f883fa7bbcf286dc6
        failing since 30 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-26T16:04:28.381699  / # #
    2023-08-26T16:04:28.484767  export SHELL=3D/bin/sh
    2023-08-26T16:04:28.485562  #
    2023-08-26T16:04:28.587319  / # export SHELL=3D/bin/sh. /lava-72057/env=
ironment
    2023-08-26T16:04:28.588113  =

    2023-08-26T16:04:28.690116  / # . /lava-72057/environment/lava-72057/bi=
n/lava-test-runner /lava-72057/1
    2023-08-26T16:04:28.691487  =

    2023-08-26T16:04:28.704422  / # /lava-72057/bin/lava-test-runner /lava-=
72057/1
    2023-08-26T16:04:28.765255  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-26T16:04:28.765777  + cd /lava-72057/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea28a417ebc751a0286da9

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea28a417ebc751a0286de4
        failing since 17 days (last pass: v5.10.186-cip37-526-g7640d76efb64=
9, first fail: v5.10.186-cip37-566-g36076316ef049)

    2023-08-26T16:29:57.995634  <8>[   19.250246] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 72211_1.5.2.4.1>
    2023-08-26T16:29:58.103511  / # #
    2023-08-26T16:29:58.206311  export SHELL=3D/bin/sh
    2023-08-26T16:29:58.207134  #
    2023-08-26T16:29:58.309039  / # export SHELL=3D/bin/sh. /lava-72211/env=
ironment
    2023-08-26T16:29:58.309819  =

    2023-08-26T16:29:58.411770  / # . /lava-72211/environment/lava-72211/bi=
n/lava-test-runner /lava-72211/1
    2023-08-26T16:29:58.413050  =

    2023-08-26T16:29:58.426974  / # /lava-72211/bin/lava-test-runner /lava-=
72211/1
    2023-08-26T16:29:58.605725  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea23532a6331ff53286d99

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ea23532a6331ff53286=
d9a
        new failure (last pass: v5.10.186-cip37-770-gddd36cfc4c4c8) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea265fd85e6e3272286f47

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea265fd85e6e3272286f4e
        failing since 29 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-26T16:20:15.480437  + set +x
    2023-08-26T16:20:15.480673  <8>[   83.947725] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1001189_1.5.2.4.1>
    2023-08-26T16:20:15.586741  / # #
    2023-08-26T16:20:17.048291  export SHELL=3D/bin/sh
    2023-08-26T16:20:17.068811  #
    2023-08-26T16:20:17.069035  / # export SHELL=3D/bin/sh
    2023-08-26T16:20:19.023635  / # . /lava-1001189/environment
    2023-08-26T16:20:22.622506  /lava-1001189/bin/lava-test-runner /lava-10=
01189/1
    2023-08-26T16:20:22.643298  . /lava-1001189/environment
    2023-08-26T16:20:22.643410  / # /lava-1001189/bin/lava-test-runner /lav=
a-1001189/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea27975ef7905da8286d74

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea27975ef7905da8286d7b
        failing since 15 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-770-gddd36cfc4c4c8)

    2023-08-26T16:25:31.734236  + set +x
    2023-08-26T16:25:31.734816  <8>[   87.757432] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1001198_1.5.2.4.1>
    2023-08-26T16:25:31.848073  #
    2023-08-26T16:25:33.319165  / # #export SHELL=3D/bin/sh
    2023-08-26T16:25:33.340416  =

    2023-08-26T16:25:33.341035  / # export SHELL=3D/bin/sh
    2023-08-26T16:25:35.306447  / # . /lava-1001198/environment
    2023-08-26T16:25:38.923453  /lava-1001198/bin/lava-test-runner /lava-10=
01198/1
    2023-08-26T16:25:38.945366  . /lava-1001198/environment
    2023-08-26T16:25:38.945813  / # /lava-1001198/bin/lava-test-runner /lav=
a-1001198/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea22b183d6b2b805286dab

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig/gcc-10/lab-=
cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig/gcc-10/lab-=
cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea22b183d6b2b805286db2
        failing since 30 days (last pass: v5.10.182-cip35-289-g3c0549540706=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-26T16:04:44.233119  / # #
    2023-08-26T16:04:45.694361  export SHELL=3D/bin/sh
    2023-08-26T16:04:45.714890  #
    2023-08-26T16:04:45.715092  / # export SHELL=3D/bin/sh
    2023-08-26T16:04:47.669424  / # . /lava-1001169/environment
    2023-08-26T16:04:51.265825  /lava-1001169/bin/lava-test-runner /lava-10=
01169/1
    2023-08-26T16:04:51.286784  . /lava-1001169/environment
    2023-08-26T16:04:51.286937  / # /lava-1001169/bin/lava-test-runner /lav=
a-1001169/1
    2023-08-26T16:04:51.321502  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-26T16:04:51.369527  + cd /lava-1001169/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea26ad48407b93ed286d79

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea26ad48407b93ed286d80
        failing since 30 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-26T16:21:42.865200  / # #
    2023-08-26T16:21:44.328564  export SHELL=3D/bin/sh
    2023-08-26T16:21:44.349143  #
    2023-08-26T16:21:44.349351  / # export SHELL=3D/bin/sh
    2023-08-26T16:21:46.306088  / # . /lava-1001192/environment
    2023-08-26T16:21:49.909781  /lava-1001192/bin/lava-test-runner /lava-10=
01192/1
    2023-08-26T16:21:49.930913  . /lava-1001192/environment
    2023-08-26T16:21:49.931026  / # /lava-1001192/bin/lava-test-runner /lav=
a-1001192/1
    2023-08-26T16:21:50.010567  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-26T16:21:50.010788  + cd /lava-1001192/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea27da807065b77f286d79

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea27da807065b77f286d80
        failing since 30 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-26T16:26:39.018038  / # #
    2023-08-26T16:26:40.477949  export SHELL=3D/bin/sh
    2023-08-26T16:26:40.498385  #
    2023-08-26T16:26:40.498504  / # export SHELL=3D/bin/sh
    2023-08-26T16:26:42.451558  / # . /lava-1001197/environment
    2023-08-26T16:26:46.044711  /lava-1001197/bin/lava-test-runner /lava-10=
01197/1
    2023-08-26T16:26:46.065294  . /lava-1001197/environment
    2023-08-26T16:26:46.065402  / # /lava-1001197/bin/lava-test-runner /lav=
a-1001197/1
    2023-08-26T16:26:46.243473  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-26T16:26:46.243609  + cd /lava-1001197/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea28ca7541ca9402286d6d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea28ca7541ca9402286d74
        failing since 30 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-26T16:30:36.706322  / # #
    2023-08-26T16:30:38.168288  export SHELL=3D/bin/sh
    2023-08-26T16:30:38.188860  #
    2023-08-26T16:30:38.189066  / # export SHELL=3D/bin/sh
    2023-08-26T16:30:40.144406  / # . /lava-1001204/environment
    2023-08-26T16:30:43.741435  /lava-1001204/bin/lava-test-runner /lava-10=
01204/1
    2023-08-26T16:30:43.762181  . /lava-1001204/environment
    2023-08-26T16:30:43.762292  / # /lava-1001204/bin/lava-test-runner /lav=
a-1001204/1
    2023-08-26T16:30:43.942579  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-26T16:30:43.942797  + cd /lava-1001204/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea21f4fdf320f8f8286d6c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig/gcc-10/lab-=
collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig/gcc-10/lab-=
collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea21f4fdf320f8f8286d71
        failing since 30 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-26T16:03:25.510871  / # #

    2023-08-26T16:03:25.613077  export SHELL=3D/bin/sh

    2023-08-26T16:03:25.613777  #

    2023-08-26T16:03:25.715257  / # export SHELL=3D/bin/sh. /lava-11363336/=
environment

    2023-08-26T16:03:25.716019  =


    2023-08-26T16:03:25.817421  / # . /lava-11363336/environment/lava-11363=
336/bin/lava-test-runner /lava-11363336/1

    2023-08-26T16:03:25.818426  =


    2023-08-26T16:03:25.835139  / # /lava-11363336/bin/lava-test-runner /la=
va-11363336/1

    2023-08-26T16:03:25.883987  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T16:03:25.884483  + cd /lav<8>[   16.453348] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11363336_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea280cb89f0d2508286d71

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+kselftest/g=
cc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+kselftest/g=
cc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea280cb89f0d2508286d76
        failing since 30 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-26T16:29:27.816251  / # #

    2023-08-26T16:29:27.918192  export SHELL=3D/bin/sh

    2023-08-26T16:29:27.918854  #

    2023-08-26T16:29:28.020054  / # export SHELL=3D/bin/sh. /lava-11363645/=
environment

    2023-08-26T16:29:28.020734  =


    2023-08-26T16:29:28.122059  / # . /lava-11363645/environment/lava-11363=
645/bin/lava-test-runner /lava-11363645/1

    2023-08-26T16:29:28.123157  =


    2023-08-26T16:29:28.140383  / # /lava-11363645/bin/lava-test-runner /la=
va-11363645/1

    2023-08-26T16:29:28.239522  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T16:29:28.240046  + cd /lava-11363645/1/tests/1_bootrr
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64ea2611a46a86bd89286dbc

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64ea2611a46a86bd89286dc2
        failing since 128 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-26T16:19:27.032699  <8>[   34.271251] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-08-26T16:19:28.057694  /lava-11363589/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64ea2611a46a86bd89286dc3
        failing since 128 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-26T16:19:25.996411  <8>[   33.233794] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-08-26T16:19:27.020878  /lava-11363589/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/64ea276622abde39dc286d9b

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64ea276622abde39dc286da1
        failing since 128 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-26T16:24:59.902043  <8>[   42.892608] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-08-26T16:25:00.974427  /lava-11363610/1/../bin/lava-test-case

    2023-08-26T16:25:00.999698  <8>[   43.991405] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64ea276622abde39dc286da2
        failing since 128 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-26T16:24:59.876329  /lava-11363610/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea22182424155ef3286da5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig/gcc-10/lab-=
collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig/gcc-10/lab-=
collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea22182424155ef3286daa
        new failure (last pass: v5.10.186-cip37-770-gddd36cfc4c4c8)

    2023-08-26T16:03:34.323005  / # #

    2023-08-26T16:03:35.583987  export SHELL=3D/bin/sh

    2023-08-26T16:03:35.594943  #

    2023-08-26T16:03:35.595414  / # export SHELL=3D/bin/sh

    2023-08-26T16:03:37.339487  / # . /lava-11363343/environment

    2023-08-26T16:03:40.544830  /lava-11363343/bin/lava-test-runner /lava-1=
1363343/1

    2023-08-26T16:03:40.556283  . /lava-11363343/environment

    2023-08-26T16:03:40.557004  / # /lava-11363343/bin/lava-test-runner /la=
va-11363343/1

    2023-08-26T16:03:40.611200  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T16:03:40.611685  + cd /lava-11363343/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea283dbcdf5a284c286daf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+kselftest/g=
cc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+kselftest/g=
cc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea283dbcdf5a284c286db4
        new failure (last pass: v5.10.186-cip37-770-gddd36cfc4c4c8)

    2023-08-26T16:28:21.842401  / # #

    2023-08-26T16:28:23.103724  export SHELL=3D/bin/sh

    2023-08-26T16:28:23.114723  #

    2023-08-26T16:28:23.115192  / # export SHELL=3D/bin/sh

    2023-08-26T16:28:24.859343  . /lava-11363646/environment

    2023-08-26T16:28:24.870303  / # . /lava-11363646/environment

    2023-08-26T16:28:28.065786  /lava-11363646/bin/lava-test-runner /lava-1=
1363646/1

    2023-08-26T16:28:28.077234  / # /lava-11363646/bin/lava-test-runner /la=
va-11363646/1

    2023-08-26T16:28:28.209434  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T16:28:28.209920  + cd /lava-11363646/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea22092424155ef3286d94

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ea22092424155ef3286d99
        failing since 30 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-26T16:03:41.192305  / # #

    2023-08-26T16:03:41.294655  export SHELL=3D/bin/sh

    2023-08-26T16:03:41.295402  #

    2023-08-26T16:03:41.396833  / # export SHELL=3D/bin/sh. /lava-11363341/=
environment

    2023-08-26T16:03:41.397626  =


    2023-08-26T16:03:41.499052  / # . /lava-11363341/environment/lava-11363=
341/bin/lava-test-runner /lava-11363341/1

    2023-08-26T16:03:41.500242  =


    2023-08-26T16:03:41.517070  / # /lava-11363341/bin/lava-test-runner /la=
va-11363341/1

    2023-08-26T16:03:41.557507  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T16:03:41.575106  + cd /lava-1136334<8>[   18.181859] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11363341_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

