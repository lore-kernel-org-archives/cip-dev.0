Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05A0C83F01
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 01:40:35 +0000 (UTC)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
 by mx.groups.io with SMTP id smtpd.web10.5035.1693186832471138426
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 27 Aug 2023 18:40:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=lcyE1eHh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.177, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3a7781225b4so2010900b6e.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 27 Aug 2023 18:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693186831; x=1693791631;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K6f4HyiEpj8ElxxNQEIhupZXw1ay5qz5u778YURo5X4=;
        b=lcyE1eHhIwTcvkd03A7YR+wS5Sf0aVFCpYIyhp04aREJvNdKNVfmf35d7lMlvW9rEp
         9Huj3I7/qQ+XY1j0KbExffXksCCKAxGtD4gIS95vPVgiECS/tY0iax+gHgVdNiQYwmXv
         vxATGAaWr5YDNiTnU1DSrD1xRHbRvlI/4ctHT4zBVhaeAuWm+cB4xmU4wjVyt2n90YyG
         3PL7wGFreWAFm4IMlQCjee5zrmi23aFvjW2wz12gCAtA0EmJnZicrXxGfnAFwMwvZmi+
         KJQRSXRAULwIU8djermsM7brdpmB2qtSt8GvC7DKkvPiYvd7kfHaRdyLAC0znL9l2U4D
         gQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693186831; x=1693791631;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6f4HyiEpj8ElxxNQEIhupZXw1ay5qz5u778YURo5X4=;
        b=Hzezli37fMeTOmFxmHF0rL75lZ9tYvfj0BjW5auHKUy0iaAzwCXUuwMlrfhQQXWwsl
         ONexVvVsh5XYgzhIllh/koLW08wHge/otv96iKmwItvgSHw0MD45nE2WGZIEdNfJIp4q
         3zskbM+y3aB8+X9xPgw3P+EHRvS+gOQGqYnsbRLM1KXhOwSHkKO7WHM8iGyFUOB45Rpd
         dEAriM/xxtvHsZzsjEmUq5jLS6Sjw6hrmyvo5W4Z7Unafecf0OpBE+cO8ITaUnboqtV1
         f5sK/hGe1Sq8kANLazEdIxr9a7WA9arPN30LeYRuIEOfdb9+F+eWZjjQ48vHtmRsT766
         HnbA==
X-Gm-Message-State: AOJu0YxDnKzUjef4HUw8ptMTCFpR4QFHj2Ed3Ssy0rKxDikc4o1diRWA
	GftC49xCugJInD8cj8EtII0fGG0A0b4FwR9Kkk4=
X-Google-Smtp-Source: AGHT+IEXx9ABig/jLF92u3xeK+r2yW9TGe0i4RuaK+O+YUis2J3wPzYAq4rsYvuS8gBvql6DO5CYmg==
X-Received: by 2002:a05:6808:144f:b0:3a7:37ca:7de1 with SMTP id x15-20020a056808144f00b003a737ca7de1mr11705776oiv.48.1693186830817;
        Sun, 27 Aug 2023 18:40:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i6-20020aa787c6000000b0067aea93af40sm5487652pfo.2.2023.08.27.18.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 18:40:30 -0700 (PDT)
Message-ID: <64ebfb0e.a70a0220.6f201.7f7f@mx.google.com>
Date: Sun, 27 Aug 2023 18:40:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.191-cip38
Subject: cip/linux-5.10.y-cip baseline-nfs: 27 runs,
 12 regressions (v5.10.191-cip38)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 01:40:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12863

cip/linux-5.10.y-cip baseline-nfs: 27 runs, 12 regressions (v5.10.191-cip38)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.191-cip38/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.191-cip38
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      78bddf33c2b7d94fc34e09bc56638615095ddc28 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf11ed73ea2db30286d84

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ebf11ed73ea2db30286db5
        failing since 225 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-28T00:57:15.040454  + set +x
    2023-08-28T00:57:15.044319  <8>[   51.528800] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 73697_1.6.2.4.1>
    2023-08-28T00:57:15.165567  / # #
    2023-08-28T00:57:15.267526  export SHELL=3D/bin/sh
    2023-08-28T00:57:15.268053  #
    2023-08-28T00:57:15.369931  / # export SHELL=3D/bin/sh. /lava-73697/env=
ironment
    2023-08-28T00:57:15.370377  =

    2023-08-28T00:57:15.471691  / # . /lava-73697/environment/lava-73697/bi=
n/lava-test-runner /lava-73697/1
    2023-08-28T00:57:15.472499  =

    2023-08-28T00:57:15.476785  / # /lava-73697/bin/lava-test-runner /lava-=
73697/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf15ad7f2b10872286da3

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ebf15ad7f2b10872286daa
        failing since 225 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-28T00:58:04.590032  + set +x
    2023-08-28T00:58:04.593729  <8>[   46.842851] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1001785_1.6.2.4.1>
    2023-08-28T00:58:04.827450  #
    2023-08-28T00:58:04.930489  / # #export SHELL=3D/bin/sh
    2023-08-28T00:58:04.931204  =

    2023-08-28T00:58:05.033053  / # export SHELL=3D/bin/sh. /lava-1001785/e=
nvironment
    2023-08-28T00:58:05.033764  =

    2023-08-28T00:58:05.135594  / # . /lava-1001785/environment/lava-100178=
5/bin/lava-test-runner /lava-1001785/1
    2023-08-28T00:58:05.136775  =

    2023-08-28T00:58:05.142521  / # /lava-1001785/bin/lava-test-runner /lav=
a-1001785/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf1f0a9e70ca279286d87

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-b=
lack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-b=
lack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ebf1f0a9e70ca279286dbe
        failing since 225 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-28T01:01:02.517916  <8>[   41.973864] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 73735_1.6.2.4.1>
    2023-08-28T01:01:02.636805  / # #
    2023-08-28T01:01:02.738310  export SHELL=3D/bin/sh
    2023-08-28T01:01:02.738693  #
    2023-08-28T01:01:02.840066  / # export SHELL=3D/bin/sh. /lava-73735/env=
ironment
    2023-08-28T01:01:02.840550  =

    2023-08-28T01:01:02.941763  / # . /lava-73735/environment/lava-73735/bi=
n/lava-test-runner /lava-73735/1
    2023-08-28T01:01:02.942401  =

    2023-08-28T01:01:02.946747  / # /lava-73735/bin/lava-test-runner /lava-=
73735/1
    2023-08-28T01:01:03.192985  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf1c0a610acea1f286e07

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ebf1c0a610acea1f286e0e
        failing since 225 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-28T01:00:23.632592  / # #
    2023-08-28T01:00:23.736300  export SHELL=3D/bin/sh
    2023-08-28T01:00:23.737442  #
    2023-08-28T01:00:23.839776  / # export SHELL=3D/bin/sh. /lava-1001790/e=
nvironment
    2023-08-28T01:00:23.840896  =

    2023-08-28T01:00:23.943439  / # . /lava-1001790/environment/lava-100179=
0/bin/lava-test-runner /lava-1001790/1
    2023-08-28T01:00:23.945255  =

    2023-08-28T01:00:23.959292  / # /lava-1001790/bin/lava-test-runner /lav=
a-1001790/1
    2023-08-28T01:00:24.270483  + export TESTRUN_ID=3D1_bootrr
    2023-08-28T01:00:24.271272  + cd /lava-1001790/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebef7ac8466cb2c0286d83

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ebef7ac8466cb2c0286d8c
        failing since 135 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-08-28T00:51:56.404690  + set +x<8>[   18.173054] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11368188_1.5.2.3.1>

    2023-08-28T00:51:56.404771  =


    2023-08-28T00:51:56.508362  / # #

    2023-08-28T00:51:56.609047  export SHELL=3D/bin/sh

    2023-08-28T00:51:56.609265  #

    2023-08-28T00:51:56.709781  / # export SHELL=3D/bin/sh. /lava-11368188/=
environment

    2023-08-28T00:51:56.709959  =


    2023-08-28T00:51:56.810485  / # . /lava-11368188/environment/lava-11368=
188/bin/lava-test-runner /lava-11368188/1

    2023-08-28T00:51:56.810867  =


    2023-08-28T00:51:56.815464  / # /lava-11368188/bin/lava-test-runner /la=
va-11368188/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebef87cf50676001286d72

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ebef87cf50676001286d7b
        failing since 135 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-08-28T00:51:02.136256  + set +x

    2023-08-28T00:51:02.142295  <8>[   19.880297] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11368205_1.5.2.3.1>

    2023-08-28T00:51:02.246466  / # #

    2023-08-28T00:51:02.347097  export SHELL=3D/bin/sh

    2023-08-28T00:51:02.347271  #

    2023-08-28T00:51:02.447760  / # export SHELL=3D/bin/sh. /lava-11368205/=
environment

    2023-08-28T00:51:02.447932  =


    2023-08-28T00:51:02.548512  / # . /lava-11368205/environment/lava-11368=
205/bin/lava-test-runner /lava-11368205/1

    2023-08-28T00:51:02.548812  =


    2023-08-28T00:51:02.553429  / # /lava-11368205/bin/lava-test-runner /la=
va-11368205/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf0dcef8f82a7fe286dcd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ebf0dcef8f82a7fe286dd4
        failing since 225 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-28T00:57:51.380559  / # #

    2023-08-28T00:57:51.482730  export SHELL=3D/bin/sh

    2023-08-28T00:57:51.483440  #

    2023-08-28T00:57:51.584880  / # export SHELL=3D/bin/sh. /lava-11368322/=
environment

    2023-08-28T00:57:51.585640  =


    2023-08-28T00:57:51.687128  / # . /lava-11368322/environment/lava-11368=
322/bin/lava-test-runner /lava-11368322/1

    2023-08-28T00:57:51.688364  =


    2023-08-28T00:57:51.690950  / # /lava-11368322/bin/lava-test-runner /la=
va-11368322/1

    2023-08-28T00:57:51.802405  + export TESTRUN_ID=3D1_bootrr

    2023-08-28T00:57:51.818381  + cd /lava-11368322/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf01cbc0ce39e73286dc9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64ebf01cbc0ce39e7=
3286dca
        failing since 33 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf159d7f2b10872286da0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihop=
e-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihop=
e-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64ebf159d7f2b1087=
2286da1
        failing since 11 days (last pass: v5.10.186-cip37-13-g260094841fe1a=
, first fail: v5.10.186-cip37-14-gc9b5a049d8ea) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf4e0a1dea99169286dd9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-nfs-r8a774a=
1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-nfs-r8a774a=
1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64ebf4e0a1dea9916=
9286dda
        failing since 5 days (last pass: v5.10.186-cip37-14-gc9b5a049d8ea, =
first fail: v5.10.186-cip37-27-gd6d928db0a620) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64ebf47b060900859a286d70

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64ebf47b060900859a286d7a
        failing since 158 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-08-28T01:13:17.634502  /lava-11368420/1/../bin/lava-test-case

    2023-08-28T01:13:17.669019  <8>[   38.521751] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64ebf47b060900859a286d7b
        failing since 158 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-08-28T01:13:16.532738  /lava-11368420/1/../bin/lava-test-case

    2023-08-28T01:13:16.571656  <8>[   37.423745] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

