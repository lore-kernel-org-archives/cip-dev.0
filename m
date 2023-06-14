Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66FAEB64DA
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 12:27:25 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.10278.1686745642260177407
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 14 Jun 2023 05:27:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=0m816p96;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1b3b3f67ad6so35267445ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 14 Jun 2023 05:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686745641; x=1689337641;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W7XPBA5RY5R+dIBCfjm/ePy1YHK9JflyPX2/TRynvp8=;
        b=0m816p96+k8uyaL631E+XRUXCdABxj9hzKNi8kwSYRH5nX+5+Otf4igsX+UayxwBMX
         08+ghUfmeTKC9hAqgpFHORCjP4HaGVXd7j4XBlogdnIANymmekrykPRm4bAvUU5cCkW/
         hspZlRNThl9fU7EvEdn3NAl0G+xsnMS2NQyVNkP1roqLDlSK1w92P1sf0ZcuzGEnBanD
         GHUW1EMDVX5UA03QyLJ2k3335wffp2mkieKtt5ItC9lCKJhGAAxazQdfYXMg+upU2OjW
         E0YboOzjsMVIhbi2YzBgxQSdkDYiP+ydYlVl7tfw71jaZVWhYPydRmlKTysJh2o+nA/y
         eUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686745641; x=1689337641;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7XPBA5RY5R+dIBCfjm/ePy1YHK9JflyPX2/TRynvp8=;
        b=QjD+ByEK6lKKU9Us+JO6HMZ8v3/E4WIHDehEEkQu5xGlc3kWHhzmLe/wcVPUFj8V+0
         Rz6YdBTbUex/h2WKcytHtGTXTpyyOikdpHF0WDo7PuxtNdt8n5vy72IzIg/sq0rqiNhO
         xVgslpaMye9i/sOrl0OkevCKebtewVo8JAoYg9sncWgY3pCeGf4TLzRFKygGP4FctcL8
         tSxlT8brCpWu6WDewoqae6HZOHaNkhT9OaL1BYCaqbFNhmBMf7Iw4itIxqY/O1nLU3Qb
         iqic4tOZxInFxg6BfVUx9S342aJEqWpXXCX9EVB0EBNuJvpoF6diWzHX/eZYLDG/mEbl
         vtjA==
X-Gm-Message-State: AC+VfDx3mgkzVMXJNKigLTREtgWCKJJNf8bL+EzL2UliA68YS54UejIq
	1ouBOUTT9OKC8K8kVNC8dW+AFRkBX90hGFk3KXX35w==
X-Google-Smtp-Source: ACHHUZ7TYnzYklbTN7MTKyMOTCZPiPmbOAei4PXeTNgijEXPyTE7J9VnwmqSFteWYyj5U6E9tn25qA==
X-Received: by 2002:a17:902:bd8a:b0:1b5:39:f022 with SMTP id q10-20020a170902bd8a00b001b50039f022mr1243179pls.19.1686745640617;
        Wed, 14 Jun 2023 05:27:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902c11300b001b3fb1119fdsm1939371pli.297.2023.06.14.05.27.19
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 05:27:20 -0700 (PDT)
Message-ID: <6489b228.170a0220.1b65.470e@mx.google.com>
Date: Wed, 14 Jun 2023 05:27:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-191-gf4efde512959
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 150 runs,
 10 regressions (v5.10.182-cip35-191-gf4efde512959)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 12:27:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12011

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 150 runs, 10 regressio=
ns (v5.10.182-cip35-191-gf4efde512959)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.182-cip35-191-gf4efde512959/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.182-cip35-191-gf4efde512959
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f4efde5129594b413888498ce6f27da48a03771e =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6489a76e8cf28d2b19306165

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489a76e8cf28d2b19306183
        failing since 160 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-06-14T11:41:14.733503  <8>[   18.908372] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 609835_1.5.2.4.1>
    2023-06-14T11:41:14.843314  / # #
    2023-06-14T11:41:14.945705  export SHELL=3D/bin/sh
    2023-06-14T11:41:14.946291  #
    2023-06-14T11:41:15.048009  / # export SHELL=3D/bin/sh. /lava-609835/en=
vironment
    2023-06-14T11:41:15.048709  =

    2023-06-14T11:41:15.150793  / # . /lava-609835/environment/lava-609835/=
bin/lava-test-runner /lava-609835/1
    2023-06-14T11:41:15.151801  =

    2023-06-14T11:41:15.156394  / # /lava-609835/bin/lava-test-runner /lava=
-609835/1
    2023-06-14T11:41:15.265233  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6489a7b54ef5c0a11d306156

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489a7b54ef5c0a11d306159
        failing since 160 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-06-14T11:42:35.890439  + set +x
    2023-06-14T11:42:35.892514  <8>[   13.962302] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 962808_1.5.2.4.1>
    2023-06-14T11:42:36.001298  / # #
    2023-06-14T11:42:36.103170  export SHELL=3D/bin/sh
    2023-06-14T11:42:36.103640  #
    2023-06-14T11:42:36.205041  / # export SHELL=3D/bin/sh. /lava-962808/en=
vironment
    2023-06-14T11:42:36.205522  =

    2023-06-14T11:42:36.306925  / # . /lava-962808/environment/lava-962808/=
bin/lava-test-runner /lava-962808/1
    2023-06-14T11:42:36.307728  =

    2023-06-14T11:42:36.309736  / # /lava-962808/bin/lava-test-runner /lava=
-962808/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489a46d4e0023cd11306140

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus=
.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489a46d4e0023cd11306145
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T11:28:43.550202  + set +x

    2023-06-14T11:28:43.556843  <8>[   14.752151] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10723638_1.4.2.3.1>

    2023-06-14T11:28:43.663984  / # #

    2023-06-14T11:28:43.766024  export SHELL=3D/bin/sh

    2023-06-14T11:28:43.766647  #

    2023-06-14T11:28:43.867967  / # export SHELL=3D/bin/sh. /lava-10723638/=
environment

    2023-06-14T11:28:43.868593  =


    2023-06-14T11:28:43.969954  / # . /lava-10723638/environment/lava-10723=
638/bin/lava-test-runner /lava-10723638/1

    2023-06-14T11:28:43.970981  =


    2023-06-14T11:28:43.976002  / # /lava-10723638/bin/lava-test-runner /la=
va-10723638/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6489a6c8580ab2090c306178

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n40=
20-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n40=
20-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489a6c8580ab2090c30617d
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T11:38:36.923273  + set +x<8>[   16.219436] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10723792_1.4.2.3.1>

    2023-06-14T11:38:36.923360  =


    2023-06-14T11:38:37.027469  / # #

    2023-06-14T11:38:37.128002  export SHELL=3D/bin/sh

    2023-06-14T11:38:37.128169  #

    2023-06-14T11:38:37.228628  / # export SHELL=3D/bin/sh. /lava-10723792/=
environment

    2023-06-14T11:38:37.228804  =


    2023-06-14T11:38:37.329301  / # . /lava-10723792/environment/lava-10723=
792/bin/lava-test-runner /lava-10723792/1

    2023-06-14T11:38:37.329558  =


    2023-06-14T11:38:37.334280  / # /lava-10723792/bin/lava-test-runner /la=
va-10723792/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489a47e6ca71b3d1830615b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489a47e6ca71b3d18306160
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T11:28:39.691523  <8>[   12.464291] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10723651_1.4.2.3.1>

    2023-06-14T11:28:39.694617  + set +x

    2023-06-14T11:28:39.799464  / # #

    2023-06-14T11:28:39.900228  export SHELL=3D/bin/sh

    2023-06-14T11:28:39.900453  #

    2023-06-14T11:28:40.001011  / # export SHELL=3D/bin/sh. /lava-10723651/=
environment

    2023-06-14T11:28:40.001218  =


    2023-06-14T11:28:40.101763  / # . /lava-10723651/environment/lava-10723=
651/bin/lava-test-runner /lava-10723651/1

    2023-06-14T11:28:40.102110  =


    2023-06-14T11:28:40.106547  / # /lava-10723651/bin/lava-test-runner /la=
va-10723651/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6489a6b2df79140beb3061a4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489a6b2df79140beb3061a9
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T11:38:23.537434  + <8>[   14.046779] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10723787_1.4.2.3.1>

    2023-06-14T11:38:23.537866  set +x

    2023-06-14T11:38:23.642465  #

    2023-06-14T11:38:23.744959  / # #export SHELL=3D/bin/sh

    2023-06-14T11:38:23.745634  =


    2023-06-14T11:38:23.846996  / # export SHELL=3D/bin/sh. /lava-10723787/=
environment

    2023-06-14T11:38:23.847701  =


    2023-06-14T11:38:23.949075  / # . /lava-10723787/environment/lava-10723=
787/bin/lava-test-runner /lava-10723787/1

    2023-06-14T11:38:23.950249  =


    2023-06-14T11:38:23.955603  / # /lava-10723787/bin/lava-test-runner /la=
va-10723787/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6489a8927f9f5560973061c6

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6489a8927f9f5560973061cc
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T11:46:10.346626  /lava-10723879/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6489a8927f9f5560973061cd
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T11:46:08.285905  <8>[   32.958920] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-06-14T11:46:09.311283  /lava-10723879/1/../bin/lava-test-case

    2023-06-14T11:46:09.322467  <8>[   33.996679] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/6489ac055c34ab0320306152

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6489ac055c34ab0320306190
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T12:00:55.388601  /lava-10724013/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6489ac055c34ab0320306191
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T12:00:54.302464  /lava-10724013/1/../bin/lava-test-case

    2023-06-14T12:00:54.328404  <8>[   69.523544] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

