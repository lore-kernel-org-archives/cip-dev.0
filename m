Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CC0C64EC7
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 19:33:58 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web11.2651.1677094434898092928
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Feb 2023 11:33:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=DRQn+qtd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.178, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f178.google.com with SMTP id i31so4221329pgi.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Feb 2023 11:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pt0CKKVXIkAi5Y+vcHa5C1eoQlgBhZkxzMYwILLhcJY=;
        b=DRQn+qtdvokavYqGBuA2zoc+AEBF9qjzBK17IqGpGrhX0y55uWWQ8HW/3RAZ0n7Lp6
         39FD7EO+GvZtYsPM0kInn48WvGAnVYkJgtopTxbp28uULLDJWcgYvD1AyRnVj3hGjrWB
         uGH31vjC/qVOcyn5EFD3V7RZNKXkNKW2BsKpkgS/i/CaU5gTU+9YYijnS9anEfugfvaz
         TXxIFOg204KWVJm+Rl9kublReQKZRQ07B8YC4gQyhqL9gKoSqU5xJSKvNGSxlnx6OFvy
         tdHkaYGpn/wIwPJtjqJ98zBlgn0SaIFHh18QJURc0yRhwcCq1ph5MWsByBLzhdChvi85
         Lbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pt0CKKVXIkAi5Y+vcHa5C1eoQlgBhZkxzMYwILLhcJY=;
        b=bKmVCJMeW4SiZShGwZSUKH7bmaVNBmoGnuL9jQDCgqkBfBZ1KY2ZaOkaqRjkt8vMFB
         rPqh/rZ0EcPeGecIW2gGBeWTOBTDYHZ2/i69u7i818oKpmGkmNP/9FoWykjx1d8ym5bQ
         K0/LXFD7rIwIbM/+HaXtzic+RXOFvUKaJt3b/RLHJwqOIPxZ92TIIvrXkmWf8O/uxCa1
         Qra0sqJrOqzqB4MOEPRkZAfS+gKLBFUs3cg0fAIsvyE/ZSDbIN6Sr4HDZzrlUJ5ONA6z
         TYjjB5A7YiqTCpDjRfV2nKYCywBBynNUUflqUQP23eVN8QUupShG81rFXrGws4AuXwzP
         V79A==
X-Gm-Message-State: AO0yUKXZXx2lHGPctopwIPVFXIJIKV2RnuJdrsXj9KWWmo+TYAbRFIeB
	4tozp7xAIREWCqYjuLtfgBcs6MQgJWRlQXMstKN5uQ==
X-Google-Smtp-Source: AK7set8dm+OXvjvS749IGnlMaaAcwXSx0J8unC7PTPwT/tpg13tEDw95gm4uSvqfwfMkw2l6zYpAnA==
X-Received: by 2002:a62:1514:0:b0:5a9:1616:b607 with SMTP id 20-20020a621514000000b005a91616b607mr8390412pfv.22.1677094433849;
        Wed, 22 Feb 2023 11:33:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j26-20020aa78d1a000000b0058173c4b3d1sm11668985pfe.80.2023.02.22.11.33.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 11:33:53 -0800 (PST)
Message-ID: <63f66e21.a70a0220.a010.5351@mx.google.com>
Date: Wed, 22 Feb 2023 11:33:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.167-cip26-192-ga2cd4acb16b2
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 142 runs,
 10 regressions (v5.10.167-cip26-192-ga2cd4acb16b2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Feb 2023 19:33:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10787

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 142 runs, 10 regressio=
ns (v5.10.167-cip26-192-ga2cd4acb16b2)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
beaglebone-black       | arm    | lab-broonie   | gcc-10   | omap2plus_defc=
onfig          | 1          =

beaglebone-black       | arm    | lab-cip       | gcc-10   | omap2plus_defc=
onfig          | 1          =

qemu_i386-uefi         | i386   | lab-broonie   | gcc-10   | i386_defconfig=
               | 1          =

qemu_x86_64-uefi       | x86_64 | lab-broonie   | gcc-10   | x86_64_defconf=
ig             | 1          =

qemu_x86_64-uefi       | x86_64 | lab-broonie   | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =

qemu_x86_64-uefi       | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =

qemu_x86_64-uefi-mixed | x86_64 | lab-broonie   | gcc-10   | x86_64_defconf=
ig             | 1          =

qemu_x86_64-uefi-mixed | x86_64 | lab-broonie   | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =

qemu_x86_64-uefi-mixed | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =

r8a7743-iwg20d-q7      | arm    | lab-cip       | gcc-10   | shmobile_defco=
nfig           | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.167-cip26-192-ga2cd4acb16b2/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.167-cip26-192-ga2cd4acb16b2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a2cd4acb16b241aa1a262f5213f9c4e8ddfd0714 =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
beaglebone-black       | arm    | lab-broonie   | gcc-10   | omap2plus_defc=
onfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63f664d13c2179be2f8c8659

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-192-ga2cd4acb16b2/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-192-ga2cd4acb16b2/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f664d13c2179be2f8c8662
        failing since 49 days (last pass: v5.10.155-cip21-405-g26d566555c3d=
e, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-02-22T18:53:50.633079  <8>[   19.885942] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 57081_1.5.2.4.1>
    2023-02-22T18:53:50.741807  / # #
    2023-02-22T18:53:50.843574  export SHELL=3D/bin/sh
    2023-02-22T18:53:50.844052  #
    2023-02-22T18:53:50.945660  / # export SHELL=3D/bin/sh. /lava-57081/env=
ironment
    2023-02-22T18:53:50.946302  =

    2023-02-22T18:53:51.048041  / # . /lava-57081/environment/lava-57081/bi=
n/lava-test-runner /lava-57081/1
    2023-02-22T18:53:51.049259  =

    2023-02-22T18:53:51.053376  / # /lava-57081/bin/lava-test-runner /lava-=
57081/1
    2023-02-22T18:53:51.148989  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
beaglebone-black       | arm    | lab-cip       | gcc-10   | omap2plus_defc=
onfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63f66bb8143180a3a08c864a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-192-ga2cd4acb16b2/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-192-ga2cd4acb16b2/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63f66bb8143180a3a08c8651
        failing since 49 days (last pass: v5.10.155-cip21-405-g26d566555c3d=
e, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-02-22T19:23:21.186296  <8>[   13.125204] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 856772_1.5.2.4.1>
    2023-02-22T19:23:21.295852  / # #
    2023-02-22T19:23:21.398044  export SHELL=3D/bin/sh
    2023-02-22T19:23:21.398719  #
    2023-02-22T19:23:21.500174  / # export SHELL=3D/bin/sh. /lava-856772/en=
vironment
    2023-02-22T19:23:21.500864  =

    2023-02-22T19:23:21.602459  / # . /lava-856772/environment/lava-856772/=
bin/lava-test-runner /lava-856772/1
    2023-02-22T19:23:21.603450  =

    2023-02-22T19:23:21.610314  / # /lava-856772/bin/lava-test-runner /lava=
-856772/1
    2023-02-22T19:23:21.709777  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
qemu_i386-uefi         | i386   | lab-broonie   | gcc-10   | i386_defconfig=
               | 1          =


  Details:     https://kernelci.org/test/plan/id/63f663cee45ed313f38c8660

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-192-ga2cd4acb16b2/i386/i386_defconfig/gcc-10/l=
ab-broonie/baseline-qemu_i386-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-192-ga2cd4acb16b2/i386/i386_defconfig/gcc-10/l=
ab-broonie/baseline-qemu_i386-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f663cee45ed313f38c8=
661
        failing since 0 day (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2,=
 first fail: v5.10.167-cip26-2-g1e87e7748b91) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
qemu_x86_64-uefi       | x86_64 | lab-broonie   | gcc-10   | x86_64_defconf=
ig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63f6627a2e5de298a98c863f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-192-ga2cd4acb16b2/x86_64/x86_64_defconfig/gcc-=
10/lab-broonie/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-192-ga2cd4acb16b2/x86_64/x86_64_defconfig/gcc-=
10/lab-broonie/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f6627a2e5de298a98c8=
640
        failing since 0 day (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2,=
 first fail: v5.10.167-cip26-2-g1e87e7748b91) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
qemu_x86_64-uefi       | x86_64 | lab-broonie   | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f66524e7443eb6818c8646

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-192-ga2cd4acb16b2/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-192-ga2cd4acb16b2/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f66524e7443eb6818c8=
647
        failing since 0 day (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2,=
 first fail: v5.10.167-cip26-2-g1e87e7748b91) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
qemu_x86_64-uefi       | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f664e3f9847dc4368c8648

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-192-ga2cd4acb16b2/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-192-ga2cd4acb16b2/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f664e3f9847dc4368c8=
649
        failing since 0 day (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2,=
 first fail: v5.10.167-cip26-2-g1e87e7748b91) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
qemu_x86_64-uefi-mixed | x86_64 | lab-broonie   | gcc-10   | x86_64_defconf=
ig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63f66356b7146f48788c865d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-192-ga2cd4acb16b2/x86_64/x86_64_defconfig/gcc-=
10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-192-ga2cd4acb16b2/x86_64/x86_64_defconfig/gcc-=
10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f66356b7146f48788c8=
65e
        failing since 0 day (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2,=
 first fail: v5.10.167-cip26-2-g1e87e7748b91) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
qemu_x86_64-uefi-mixed | x86_64 | lab-broonie   | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f665375761c3e4368c864c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-192-ga2cd4acb16b2/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-192-ga2cd4acb16b2/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f665375761c3e4368c8=
64d
        new failure (last pass: v5.10.165-cip25-144-g43e1d8dfbb26) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
qemu_x86_64-uefi-mixed | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f664dec1ccd474e38c868e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-192-ga2cd4acb16b2/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-192-ga2cd4acb16b2/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f664dec1ccd474e38c8=
68f
        new failure (last pass: v5.10.165-cip25-144-g43e1d8dfbb26) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
r8a7743-iwg20d-q7      | arm    | lab-cip       | gcc-10   | shmobile_defco=
nfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63f6633b8cebbf7e978c8659

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-192-ga2cd4acb16b2/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-192-ga2cd4acb16b2/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63f6633b8cebbf7e978c8=
65a
        failing since 0 day (last pass: v5.10.165-cip25-154-gb7e05ba4f61a2,=
 first fail: v5.10.167-cip26-2-g1e87e7748b91) =

 =20

