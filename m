Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A45C48292
	for <webhook@archiver.kernel.org>; Sun,  4 Feb 2024 05:10:36 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web11.33190.1707023428344612968
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 03 Feb 2024 21:10:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=z4cajIF7;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2954b34ddd0so2848121a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 03 Feb 2024 21:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707023427; x=1707628227; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mrF80o0VeVqsmiZiJwgLtcz6p0UWVkZBOJjZy2MnU5w=;
        b=z4cajIF7XHmBAO9TIStD8KDyDdHRQgTHKWp19e6Tv7HeHpjU1ZzM8jnygy0fbsmomc
         HwZfXNBc3Qm7iB2ZuSwhY9/uO4hUooalSr0jfXiX+me7tVxnAXeCx8MhGcoQNjVmjsgW
         /+7p/gpr6whyPmVaCUMpA/e+rEh6E5IGqGEbznFu9V/FowjFsmeQd07pFDK9lqw7NEbW
         A3rBkv2HXYp2qwnZPR+ZHTVNj6dmAWgOitBJlLC3ba7OxMQvLulp1QU1AuA4PnMtCYri
         mnmPuqWK9WcuZt/UnD0LxCehqew3cntemN7U7uSZjh7gl5EVq9BxATLbsiA9tx43h6Qv
         s1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707023427; x=1707628227;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mrF80o0VeVqsmiZiJwgLtcz6p0UWVkZBOJjZy2MnU5w=;
        b=i0ul2mtHgDDi8gcEt6zY7HI4tgXhWoxasBuuFd6Cn7Oxqmcehy6U+D9d1kJYZErarC
         WMH8AQJfG9nLUQ2QdeoChCmxhtPohsWXui0kMM3Qfv8ns/zR4OeM3E14rw7N/ubQ1hNn
         5xZCUiVC+U+c9lFKqj/m7ukjPaCo1uAXjxU1l0Y+mGwFu3w2yqnRI7w4AxUl9jemHMPt
         0BGw4TpoxN2PYgd069wUS+444Gq1O60WNn5e9BTJdNH888k4GZnRfN8uYmI3mP9jpbWa
         jGH/B9ZxxO3rd2OvtFcqvzvjLMJvI7AOaeEL6hUSQ1W0svjCnOYCF/1cPaRWSDe5IWdk
         4bJQ==
X-Gm-Message-State: AOJu0YxNE99PhFvJEYqyAUiwmOYJ2JGNfiJw/bvuprLSRdnb/h4OQgN9
	9h3+w3UyrFpEXqH61zWptdLcdgWOLIlxkbntQKtlziwG9J+UUBlqNzO9bdQPpDjCQLzKwNO2yBh
	2Oz8=
X-Google-Smtp-Source: AGHT+IFPSq+KIlIeAi+rN2OEnZY7hGY5xTKwCbUCHyEGKMB47V+qxW2uLDPbyc2+h0GRteHxeuPL0A==
X-Received: by 2002:a17:90a:34cd:b0:294:cc80:ea03 with SMTP id m13-20020a17090a34cd00b00294cc80ea03mr9273796pjf.44.1707023426711;
        Sat, 03 Feb 2024 21:10:26 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v7-20020a170903238700b001d960a29da2sm3985265plh.62.2024.02.03.21.10.25
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 21:10:26 -0800 (PST)
Message-ID: <65bf1c42.170a0220.b4371.e6e0@mx.google.com>
Date: Sat, 03 Feb 2024 21:10:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.75-cip14-132-g6e54756fbd6c2
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 53 runs,
 19 regressions (v6.1.75-cip14-132-g6e54756fbd6c2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 04 Feb 2024 05:10:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14646

cip-gitlab/ci/pavel/linux-test baseline-nfs: 53 runs, 19 regressions (v6.1.=
75-cip14-132-g6e54756fbd6c2)

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

bcm2835-rpi-b-rev2           | arm    | lab-broonie   | gcc-10   | bcm2835_=
defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig         | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

imx8mp-evk                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                  | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 3          =

sc7180-trogdor-kingoftown-r1 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

sc7180-trogdo...zor-limozeen | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.75-cip14-132-g6e54756fbd6c2/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.75-cip14-132-g6e54756fbd6c2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6e54756fbd6c2a85eb65a7be04700955d2e49b68 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf14bf46eafc810100a048

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/x86_64/x86_64_defconfig+x86-board/gcc-10/=
lab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/x86_64/x86_64_defconfig+x86-board/gcc-10/=
lab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65bf14bf46eafc810100a051
        failing since 16 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-04T04:37:59.148259  <8>[   17.153120] #

    2024-02-04T04:37:59.251588  / # #export SHELL=3D/bin/sh

    2024-02-04T04:37:59.252431  =


    2024-02-04T04:37:59.354033  / # export SHELL=3D/bin/sh. /lava-12699718/=
environment

    2024-02-04T04:37:59.354815  =


    2024-02-04T04:37:59.456566  / # . /lava-12699718/environment/lava-12699=
718/bin/lava-test-runner /lava-12699718/1

    2024-02-04T04:37:59.457774  =


    2024-02-04T04:37:59.462920  / # /lava-12699718/bin/lava-test-runner /la=
va-12699718/1

    2024-02-04T04:37:59.607944  + export TESTRUN_ID=3D1_bootrr

    2024-02-04T04:37:59.610997  + cd /lava-12699718/1/tests/1_bootrr
 =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf0f4b14ff7569bc00a040

  Results:     48 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm/multi_v5_defconfig/gcc-10/lab-broonie=
/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm/multi_v5_defconfig/gcc-10/lab-broonie=
/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65bf0f4b14ff7569bc00a079
        failing since 38 days (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6=
, first fail: v6.1.66-cip11-rt6-10-g38253b8903b4)

    2024-02-04T04:14:37.510085  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 542363_1.6.2=
.4.1>
    2024-02-04T04:14:37.614325  #
    2024-02-04T04:14:37.717557  / # #export SHELL=3D/bin/sh
    2024-02-04T04:14:37.718369  =

    2024-02-04T04:14:37.820357  / # export SHELL=3D/bin/sh. /lava-542363/en=
vironment
    2024-02-04T04:14:37.821114  =

    2024-02-04T04:14:37.923230  / # . /lava-542363/environment/lava-542363/=
bin/lava-test-runner /lava-542363/1
    2024-02-04T04:14:37.924463  =

    2024-02-04T04:14:37.928405  / # /lava-542363/bin/lava-test-runner /lava=
-542363/1
    2024-02-04T04:14:38.354096  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
bcm2835-rpi-b-rev2           | arm    | lab-broonie   | gcc-10   | bcm2835_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf13177b3868272500a05b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm/bcm2835_defconfig/gcc-10/lab-broonie/=
baseline-nfs-bcm2835-rpi-b-rev2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm/bcm2835_defconfig/gcc-10/lab-broonie/=
baseline-nfs-bcm2835-rpi-b-rev2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65bf13177b3868272=
500a05c
        new failure (last pass: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf184ecd2b17d85c00a040

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm/multi_v7_defconfig/gcc-10/lab-cip/bas=
eline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm/multi_v7_defconfig/gcc-10/lab-cip/bas=
eline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65bf184ecd2b17d85=
c00a041
        new failure (last pass: v6.1.72-cip13-30-g79e2886a5da69) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf12d799b468bd4600a047

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm/omap2plus_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm/omap2plus_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65bf12d799b468bd4600a06b
        failing since 16 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-04T04:29:30.075415  <8>[  111.125283] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 542497_1.6.2.4.1>
    2024-02-04T04:29:30.196297  / # #
    2024-02-04T04:29:30.297723  export SHELL=3D/bin/sh
    2024-02-04T04:29:30.298096  #
    2024-02-04T04:29:30.399291  / # export SHELL=3D/bin/sh. /lava-542497/en=
vironment
    2024-02-04T04:29:30.399716  =

    2024-02-04T04:29:30.500926  / # . /lava-542497/environment/lava-542497/=
bin/lava-test-runner /lava-542497/1
    2024-02-04T04:29:30.501526  =

    2024-02-04T04:29:30.505572  / # /lava-542497/bin/lava-test-runner /lava=
-542497/1
    2024-02-04T04:29:31.265767  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf14a4c39fe6639300a077

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/x86_64/x86_64_defconfig+x86-board/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/x86_64/x86_64_defconfig+x86-board/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65bf14a4c39fe6639300a080
        failing since 16 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-04T04:37:39.414081  <8>[   13.669408] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12699702_1.5.2.3.1>

    2024-02-04T04:37:39.515693  / ##

    2024-02-04T04:37:39.616215  export SHELL=3D/bin/sh

    2024-02-04T04:37:39.616392   #

    2024-02-04T04:37:39.716860  / # export SHELL=3D/bin/sh. /lava-12699702/=
environment

    2024-02-04T04:37:39.717070  =


    2024-02-04T04:37:39.817612  / # . /lava-12699702/environment/lava-12699=
702/bin/lava-test-runner /lava-12699702/1

    2024-02-04T04:37:39.817898  =


    2024-02-04T04:37:39.822210  / # /lava-12699702/bin/lava-test-runner /la=
va-12699702/1

    2024-02-04T04:37:39.897296  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf14b11166c6ab0c00a086

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/x86_64/x86_64_defconfig+x86-board/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/x86_64/x86_64_defconfig+x86-board/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65bf14b11166c6ab0c00a08f
        failing since 16 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-04T04:40:34.345378  <8>[   15.716581] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12699720_1.5.2.3.1>

    2024-02-04T04:40:34.447401  /#

    2024-02-04T04:40:34.548296   # #export SHELL=3D/bin/sh

    2024-02-04T04:40:34.548477  =


    2024-02-04T04:40:34.648951  / # export SHELL=3D/bin/sh. /lava-12699720/=
environment

    2024-02-04T04:40:34.649142  =


    2024-02-04T04:40:34.749623  / # . /lava-12699720/environment/lava-12699=
720/bin/lava-test-runner /lava-12699720/1

    2024-02-04T04:40:34.749889  =


    2024-02-04T04:40:34.754978  / # /lava-12699720/bin/lava-test-runner /la=
va-12699720/1

    2024-02-04T04:40:34.843566  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf14b6bfaec34e8800a067

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/x86_64/x86_64_defconfig+x86-board/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/x86_64/x86_64_defconfig+x86-board/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65bf14b6bfaec34e8800a070
        failing since 16 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-04T04:37:57.841025  <8>[   14.967306] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12699774_1.5.2.3.1>

    2024-02-04T04:37:57.946018  / # #

    2024-02-04T04:37:58.046600  export SHELL=3D/bin/sh

    2024-02-04T04:37:58.046869  #

    2024-02-04T04:37:58.147443  / # export SHELL=3D/bin/sh. /lava-12699774/=
environment

    2024-02-04T04:37:58.147670  =


    2024-02-04T04:37:58.248263  / # . /lava-12699774/environment/lava-12699=
774/bin/lava-test-runner /lava-12699774/1

    2024-02-04T04:37:58.248579  =


    2024-02-04T04:37:58.253512  / # /lava-12699774/bin/lava-test-runner /la=
va-12699774/1

    2024-02-04T04:37:58.336360  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx8mp-evk                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf11838ccefc70a500a040

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-nfs-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-nfs-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65bf11838ccefc70a500a049
        failing since 38 days (last pass: v5.10.201-cip41-77-g545d45774209f=
, first fail: v6.1.66-cip11-rt6-10-g38253b8903b4)

    2024-02-04T04:24:02.847425  <8>[   33.291595] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 542433_1.6.2.4.1>
    2024-02-04T04:24:03.000982  / # #
    2024-02-04T04:24:04.163748  export SHELL=3D/bin/sh
    2024-02-04T04:24:04.169513  #
    2024-02-04T04:24:05.665939  / # export SHELL=3D/bin/sh. /lava-542433/en=
vironment
    2024-02-04T04:24:05.671997  =

    2024-02-04T04:24:08.392487  / # . /lava-542433/environment/lava-542433/=
bin/lava-test-runner /lava-542433/1
    2024-02-04T04:24:08.399061  =

    2024-02-04T04:24:08.413049  / # /lava-542433/bin/lava-test-runner /lava=
-542433/1
    2024-02-04T04:24:09.948694  + export TESTRUN_ID=3D1_bootrr =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf14b341585444d200a094

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/x86_64/x86_64_defconfig+x86-board/gcc-10/=
lab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/x86_64/x86_64_defconfig+x86-board/gcc-10/=
lab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65bf14b341585444d200a09d
        failing since 16 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-04T04:37:47.567614  <8>[   17.137579] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12699781_1.5.2.3.1>

    2024-02-04T04:37:47.671424  / # #

    2024-02-04T04:37:47.771986  export SHELL=3D/bin/sh

    2024-02-04T04:37:47.772168  #

    2024-02-04T04:37:47.872700  / # export SHELL=3D/bin/sh. /lava-12699781/=
environment

    2024-02-04T04:37:47.872858  =


    2024-02-04T04:37:47.973322  / # . /lava-12699781/environment/lava-12699=
781/bin/lava-test-runner /lava-12699781/1

    2024-02-04T04:37:47.973566  =


    2024-02-04T04:37:47.978176  / # /lava-12699781/bin/lava-test-runner /la=
va-12699781/1

    2024-02-04T04:37:48.026906  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf10c15ca85681f300a0cd

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/6=
5bf10c25ca85681f300a0fc
        new failure (last pass: v6.1.72-cip13-32-gf60d2e8cb51c)

    2024-02-04T04:21:12.893471  /lava-542399/1/../bin/lava-test-case
    2024-02-04T04:21:12.952889  <8>[   39.376076] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2024-02-04T04:21:12.953223  /lava-542399/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf15bbb09c117a0200a0a8

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/6=
5bf15bbb09c117a0200a0d8
        new failure (last pass: v6.1.72-cip13-32-gf60d2e8cb51c)

    2024-02-04T04:42:16.065456  /lava-542522/1/../bin/lava-test-case
    2024-02-04T04:42:16.133874  <8>[   36.543994] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2024-02-04T04:42:16.134541  /lava-542522/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf118c8ccefc70a500a06a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig/gcc-10/lab-cip/baseline-n=
fs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig/gcc-10/lab-cip/baseline-n=
fs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65bf118c8ccefc70a=
500a06b
        failing since 3 days (last pass: v4.19.299-cip105-1134-gc868d5e4ada=
a, first fail: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 3          =


  Details:     https://kernelci.org/test/plan/id/65bf166168ea58971300a084

  Results:     80 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.cros-ec-sysfs-attr-kb_wake_angle: https://kernelci.=
org/test/case/id/65bf166168ea58971300a0c2
        new failure (last pass: v6.1.72-cip13-32-gf60d2e8cb51c)

    2024-02-04T04:44:53.330189  <8>[   39.913942] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sysfs-attr-flashinfo RESULT=3Dpass>

    2024-02-04T04:44:54.358127  /lava-12699874/1/../bin/lava-test-case

    2024-02-04T04:44:54.390392  <8>[   40.977809] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sysfs-attr-kb_wake_angle RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.cros-ec-sensors-driver-present: https://kernelci.or=
g/test/case/id/65bf166168ea58971300a0c8
        new failure (last pass: v6.1.72-cip13-32-gf60d2e8cb51c)

    2024-02-04T04:44:49.841546  <8>[   36.428225] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-rtc-probed RESULT=3Dfail>

    2024-02-04T04:44:50.870238  /lava-12699874/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.cros-ec-rtc-probed: https://kernelci.org/test/case/=
id/65bf166168ea58971300a0c9
        new failure (last pass: v6.1.72-cip13-32-gf60d2e8cb51c)

    2024-02-04T04:44:48.762575  <8>[   35.346616] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-rtc-driver-present RESULT=3Dpass>

    2024-02-04T04:44:49.809433  /lava-12699874/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sc7180-trogdor-kingoftown-r1 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf15b6b09c117a0200a09b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-sc7180-trogdor-kingoftown-r1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-sc7180-trogdor-kingoftown-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65bf15b6b09c117a0200a0a4
        new failure (last pass: v6.1.72-cip13-32-gf60d2e8cb51c)

    2024-02-04T04:42:16.685651  <8>[   27.554376] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12699801_1.6.2.3.1>

    2024-02-04T04:42:16.793833  / # #

    2024-02-04T04:42:16.896044  export SHELL=3D/bin/sh

    2024-02-04T04:42:16.897173  #

    2024-02-04T04:42:16.998583  / # export SHELL=3D/bin/sh. /lava-12699801/=
environment

    2024-02-04T04:42:16.999486  =


    2024-02-04T04:42:17.101320  / # . /lava-12699801/environment/lava-12699=
801/bin/lava-test-runner /lava-12699801/1

    2024-02-04T04:42:17.102735  =


    2024-02-04T04:42:17.109612  / # /lava-12699801/bin/lava-test-runner /la=
va-12699801/1

    2024-02-04T04:42:17.345264  + export TESTRUN_ID=3D1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sc7180-trogdo...zor-limozeen | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf15c858c87c0e3d00a03a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-sc7180-trogdor-lazor-limozeen.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/baseline-nfs-sc7180-trogdor-lazor-limozeen.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65bf15c858c87c0e3d00a043
        new failure (last pass: v6.1.72-cip13-32-gf60d2e8cb51c)

    2024-02-04T04:42:35.855129  + set +x

    2024-02-04T04:42:35.861856  <8>[   29.170507] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12699837_1.6.2.3.1>

    2024-02-04T04:42:35.964140  #

    2024-02-04T04:42:36.066853  / # #export SHELL=3D/bin/sh

    2024-02-04T04:42:36.067639  =


    2024-02-04T04:42:36.169367  / # export SHELL=3D/bin/sh. /lava-12699837/=
environment

    2024-02-04T04:42:36.170162  =


    2024-02-04T04:42:36.271832  / # . /lava-12699837/environment/lava-12699=
837/bin/lava-test-runner /lava-12699837/1

    2024-02-04T04:42:36.273167  =


    2024-02-04T04:42:36.279941  / # /lava-12699837/bin/lava-test-runner /la=
va-12699837/1
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf1267f2b92255a900a050

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-nfs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-nfs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65bf1267f2b92255a=
900a051
        new failure (last pass: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =20

