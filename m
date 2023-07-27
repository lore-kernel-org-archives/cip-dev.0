Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57B5C41513
	for <webhook@archiver.kernel.org>; Thu, 27 Jul 2023 11:46:29 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web11.5363.1690458386627586698
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 27 Jul 2023 04:46:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=18URR5QI;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-686ba29ccb1so517974b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 27 Jul 2023 04:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690458385; x=1691063185;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=boTEZAXs9OQDav9OD2Pe7/yIPvh/ejkisVyYgrITJpY=;
        b=18URR5QIXAAKoCnLmMJ1hhkzEneivhjVbGzRV2hQQQhjJmUFll0x6NggZF/HYkjKRA
         jMApZGqyHjbaIPlMPPpm6oMhHtnrlugi/IEj/5vP5GvAppAUchPi/a7UfkiHf9tbNzOb
         MCE/htuSASlFllPBKEM8Cd03bQ15BoEJeranIP8cBRl1n3IipKXgDvbb5zVv7cRy9rMy
         W6BtmlB9EC8LF5KlhlNtpYEn7KbZVfqBKVJHt1N1tMQvL8pWwpab1Bl05eWP5d4hsutc
         ddsl+7SCGo/4WNkywVT5elAXx2MX3pDwmHcgVi9EZiUNo5YRggsPjSnePU0febrhgUCA
         3kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690458385; x=1691063185;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=boTEZAXs9OQDav9OD2Pe7/yIPvh/ejkisVyYgrITJpY=;
        b=bYPypm3BXiTa/AFgjwW4IVEhmtWr5xoJwJNNgjggtKNb0mS1xkXfp6hXcg0uPkJM+Z
         yIKcepIMUg53iK4qUJqAZ2kpShhjz8QwGEuirhljkz/g+80CKJzisWeajlPC1jVeLQDq
         9WcSXXRist3R0EKIJlcyFTFJoL0RISpDhT88Q3vO967CorMBtkL+oRhk4+GpUBA1hCGZ
         9/ebbOQiGHrtGErzM9YeY4iLahHjLTFufCa/nEWAAs2x9xeeK6P3EbgKX68ejvbr601W
         BUAkoQPMTcMAJie9YluB4V0TdLcCEkLOFgCSr+jYBFy2N5eGi/RONOPPsYdHx1ek6TnG
         8iwA==
X-Gm-Message-State: ABy/qLYmyueG8gQpWG4x6jNOS69tMjdVTZ9JkB8ylcIgiNKIuImYmlnu
	g9aTg+D56bJpDR1h/g+jVGD/HAz068SkWSdMwMaDzA==
X-Google-Smtp-Source: APBJJlEu/DP5TJvvjcSiXb1+kSKlGtM4k9ditM8tbadWdXdnXUB6NtxUyci6gwZCoHThoaWdTcCKLA==
X-Received: by 2002:a05:6a21:33aa:b0:12e:44:a1a6 with SMTP id yy42-20020a056a2133aa00b0012e0044a1a6mr2627672pzb.11.1690458384988;
        Thu, 27 Jul 2023 04:46:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e25-20020a62aa19000000b0063d24fcc2besm1306865pff.125.2023.07.27.04.46.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 04:46:24 -0700 (PDT)
Message-ID: <64c25910.620a0220.b3ba8.244b@mx.google.com>
Date: Thu, 27 Jul 2023 04:46:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.186-cip37-526-g7640d76efb649
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 178 runs,
 18 regressions (v5.10.186-cip37-526-g7640d76efb649)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jul 2023 11:46:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12511

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 178 runs, 18 regressio=
ns (v5.10.186-cip37-526-g7640d76efb649)

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
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.186-cip37-526-g7640d76efb649/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.186-cip37-526-g7640d76efb649
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7640d76efb649f3c7f8a243e5a966ef7bd8bda13 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64c24cefd58c696d0c8ace26

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm/bcm2835_defconfig/gcc-1=
0/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm/bcm2835_defconfig/gcc-1=
0/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c24cefd58c696d0c8ace2b
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1)

    2023-07-27T10:55:59.642133  / # #

    2023-07-27T10:55:59.744342  export SHELL=3D/bin/sh

    2023-07-27T10:55:59.745108  #

    2023-07-27T10:55:59.846521  / # export SHELL=3D/bin/sh. /lava-11150786/=
environment

    2023-07-27T10:55:59.847247  =


    2023-07-27T10:55:59.948713  / # . /lava-11150786/environment/lava-11150=
786/bin/lava-test-runner /lava-11150786/1

    2023-07-27T10:55:59.949900  =


    2023-07-27T10:55:59.951089  / # /lava-11150786/bin/lava-test-runner /la=
va-11150786/1

    2023-07-27T10:56:00.031187  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-27T10:56:00.069186  + cd /lava-11150786/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64c24ca546ec38a46c8ace34

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c24ca646ec38a46c8ace6a
        failing since 203 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-07-27T10:53:02.714176  <8>[   16.809444] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 13166_1.5.2.4.1>
    2023-07-27T10:53:02.820810  / # #
    2023-07-27T10:53:02.922708  export SHELL=3D/bin/sh
    2023-07-27T10:53:02.923218  #
    2023-07-27T10:53:03.024667  / # export SHELL=3D/bin/sh. /lava-13166/env=
ironment
    2023-07-27T10:53:03.025157  =

    2023-07-27T10:53:03.126653  / # . /lava-13166/environment/lava-13166/bi=
n/lava-test-runner /lava-13166/1
    2023-07-27T10:53:03.128006  =

    2023-07-27T10:53:03.131317  / # /lava-13166/bin/lava-test-runner /lava-=
13166/1
    2023-07-27T10:53:03.231784  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64c24cba5b2ac620748ace2e

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c24cba5b2ac620748ace31
        failing since 203 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-07-27T10:53:34.791218  + set +x
    2023-07-27T10:53:34.793280  <8>[   14.030212] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 989796_1.5.2.4.1>
    2023-07-27T10:53:34.902401  / # #
    2023-07-27T10:53:35.004214  export SHELL=3D/bin/sh
    2023-07-27T10:53:35.004661  #
    2023-07-27T10:53:35.106054  / # export SHELL=3D/bin/sh. /lava-989796/en=
vironment
    2023-07-27T10:53:35.106670  =

    2023-07-27T10:53:35.208062  / # . /lava-989796/environment/lava-989796/=
bin/lava-test-runner /lava-989796/1
    2023-07-27T10:53:35.208788  =

    2023-07-27T10:53:35.210985  / # /lava-989796/bin/lava-test-runner /lava=
-989796/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c24a8f2f4d3eab3b8ace4a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopu=
s.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopu=
s.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c24a8f2f4d3eab3b8ace4f
        failing since 97 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-27T10:44:59.223336  + set +x

    2023-07-27T10:44:59.229749  <8>[   10.871948] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11150698_1.4.2.3.1>

    2023-07-27T10:44:59.334268  / # #

    2023-07-27T10:44:59.434841  export SHELL=3D/bin/sh

    2023-07-27T10:44:59.435022  #

    2023-07-27T10:44:59.535560  / # export SHELL=3D/bin/sh. /lava-11150698/=
environment

    2023-07-27T10:44:59.535762  =


    2023-07-27T10:44:59.636284  / # . /lava-11150698/environment/lava-11150=
698/bin/lava-test-runner /lava-11150698/1

    2023-07-27T10:44:59.636536  =


    2023-07-27T10:44:59.641407  / # /lava-11150698/bin/lava-test-runner /la=
va-11150698/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64c24c3d3cf963220b8ace24

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4=
020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4=
020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c24c3d3cf963220b8ace29
        failing since 97 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-27T10:51:24.561269  + set<8>[   16.146184] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11150734_1.4.2.3.1>

    2023-07-27T10:51:24.561379   +x

    2023-07-27T10:51:24.665369  / # #

    2023-07-27T10:51:24.765948  export SHELL=3D/bin/sh

    2023-07-27T10:51:24.766120  #

    2023-07-27T10:51:24.866808  / # export SHELL=3D/bin/sh. /lava-11150734/=
environment

    2023-07-27T10:51:24.866975  =


    2023-07-27T10:51:24.967442  / # . /lava-11150734/environment/lava-11150=
734/bin/lava-test-runner /lava-11150734/1

    2023-07-27T10:51:24.967719  =


    2023-07-27T10:51:24.972440  / # /lava-11150734/bin/lava-test-runner /la=
va-11150734/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c24a8db3a29c96de8ace4a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c24a8db3a29c96de8ace4f
        failing since 97 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-27T10:44:52.083884  <8>[   11.879869] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11150685_1.4.2.3.1>

    2023-07-27T10:44:52.087607  + set +x

    2023-07-27T10:44:52.192076  / # #

    2023-07-27T10:44:52.292620  export SHELL=3D/bin/sh

    2023-07-27T10:44:52.292823  #

    2023-07-27T10:44:52.393368  / # export SHELL=3D/bin/sh. /lava-11150685/=
environment

    2023-07-27T10:44:52.393535  =


    2023-07-27T10:44:52.494058  / # . /lava-11150685/environment/lava-11150=
685/bin/lava-test-runner /lava-11150685/1

    2023-07-27T10:44:52.494382  =


    2023-07-27T10:44:52.499674  / # /lava-11150685/bin/lava-test-runner /la=
va-11150685/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64c24c4d2ed23e10488ace2d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c24c4d2ed23e10488ace32
        failing since 97 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-27T10:51:23.615362  <8>[   14.149588] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11150740_1.4.2.3.1>

    2023-07-27T10:51:23.618689  + set +x

    2023-07-27T10:51:23.726241  / # #

    2023-07-27T10:51:23.826898  export SHELL=3D/bin/sh

    2023-07-27T10:51:23.827098  #

    2023-07-27T10:51:23.927855  / # export SHELL=3D/bin/sh. /lava-11150740/=
environment

    2023-07-27T10:51:23.928529  =


    2023-07-27T10:51:24.029861  / # . /lava-11150740/environment/lava-11150=
740/bin/lava-test-runner /lava-11150740/1

    2023-07-27T10:51:24.031125  =


    2023-07-27T10:51:24.036821  / # /lava-11150740/bin/lava-test-runner /la=
va-11150740/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c24cfba42a0250a28ace2b

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm64/defconfig/gcc-10/lab-=
broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm64/defconfig/gcc-10/lab-=
broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c24cfba42a0250a28ace67
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1)

    2023-07-27T10:54:26.803145  / # #
    2023-07-27T10:54:26.906037  export SHELL=3D/bin/sh
    2023-07-27T10:54:26.906829  #
    2023-07-27T10:54:27.008907  / # export SHELL=3D/bin/sh. /lava-13160/env=
ironment
    2023-07-27T10:54:27.009672  =

    2023-07-27T10:54:27.111625  / # . /lava-13160/environment/lava-13160/bi=
n/lava-test-runner /lava-13160/1
    2023-07-27T10:54:27.112880  =

    2023-07-27T10:54:27.127345  / # /lava-13160/bin/lava-test-runner /lava-=
13160/1
    2023-07-27T10:54:27.187176  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-27T10:54:27.187711  + cd /lava-13160/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64c25122de1fa4333c8ace20

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c25122de1fa4333c8ace23
        new failure (last pass: v5.10.182-cip35-289-g3c0549540706)

    2023-07-27T11:12:03.639117  + set +x
    2023-07-27T11:12:03.639243  <8>[   83.949630] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 989815_1.5.2.4.1>
    2023-07-27T11:12:03.744289  / # #
    2023-07-27T11:12:05.203318  export SHELL=3D/bin/sh
    2023-07-27T11:12:05.223777  #
    2023-07-27T11:12:05.223949  / # export SHELL=3D/bin/sh
    2023-07-27T11:12:07.105519  / # . /lava-989815/environment
    2023-07-27T11:12:10.555134  /lava-989815/bin/lava-test-runner /lava-989=
815/1
    2023-07-27T11:12:10.575835  . /lava-989815/environment
    2023-07-27T11:12:10.575977  / # /lava-989815/bin/lava-test-runner /lava=
-989815/1 =

    ... (21 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c24d3b985ea478568ace35

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm64/defconfig/gcc-10/lab-=
cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm64/defconfig/gcc-10/lab-=
cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c24d3b985ea478568ace38
        new failure (last pass: v5.10.182-cip35-289-g3c0549540706)

    2023-07-27T10:55:12.509009  / # #
    2023-07-27T10:55:13.968066  export SHELL=3D/bin/sh
    2023-07-27T10:55:13.988583  #
    2023-07-27T10:55:13.988765  / # export SHELL=3D/bin/sh
    2023-07-27T10:55:15.870781  / # . /lava-989788/environment
    2023-07-27T10:55:19.322694  /lava-989788/bin/lava-test-runner /lava-989=
788/1
    2023-07-27T10:55:19.343347  . /lava-989788/environment
    2023-07-27T10:55:19.343455  / # /lava-989788/bin/lava-test-runner /lava=
-989788/1
    2023-07-27T10:55:19.422547  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-27T10:55:19.422772  + cd /lava-989788/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64c24e8fe477cde3308ace44

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c24e8fe477cde3308ace47
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1)

    2023-07-27T11:01:18.798587  / # #
    2023-07-27T11:01:20.258157  export SHELL=3D/bin/sh
    2023-07-27T11:01:20.278663  #
    2023-07-27T11:01:20.278866  / # export SHELL=3D/bin/sh
    2023-07-27T11:01:22.160308  / # . /lava-989802/environment
    2023-07-27T11:01:25.611575  /lava-989802/bin/lava-test-runner /lava-989=
802/1
    2023-07-27T11:01:25.632331  . /lava-989802/environment
    2023-07-27T11:01:25.632464  / # /lava-989802/bin/lava-test-runner /lava=
-989802/1
    2023-07-27T11:01:25.810617  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-27T11:01:25.810836  + cd /lava-989802/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64c24f7ee32a672dc18ace23

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c24f7ee32a672dc18ace26
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1)

    2023-07-27T11:05:20.518131  / # #
    2023-07-27T11:05:21.977682  export SHELL=3D/bin/sh
    2023-07-27T11:05:21.998139  #
    2023-07-27T11:05:21.998314  / # export SHELL=3D/bin/sh
    2023-07-27T11:05:23.879343  / # . /lava-989810/environment
    2023-07-27T11:05:27.329739  /lava-989810/bin/lava-test-runner /lava-989=
810/1
    2023-07-27T11:05:27.350325  . /lava-989810/environment
    2023-07-27T11:05:27.350442  / # /lava-989810/bin/lava-test-runner /lava=
-989810/1
    2023-07-27T11:05:27.431719  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-27T11:05:27.431898  + cd /lava-989810/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64c25316f4635a83d98aceb5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c25316f4635a83d98aceb8
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1)

    2023-07-27T11:20:36.737897  / # #
    2023-07-27T11:20:38.199130  export SHELL=3D/bin/sh
    2023-07-27T11:20:38.219702  #
    2023-07-27T11:20:38.219912  / # export SHELL=3D/bin/sh
    2023-07-27T11:20:40.103974  / # . /lava-989828/environment
    2023-07-27T11:20:43.559349  /lava-989828/bin/lava-test-runner /lava-989=
828/1
    2023-07-27T11:20:43.580096  . /lava-989828/environment
    2023-07-27T11:20:43.580205  / # /lava-989828/bin/lava-test-runner /lava=
-989828/1
    2023-07-27T11:20:43.712862  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-27T11:20:43.787744  + cd /lava-989828/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/64c24cf59d8103f37b8ace22

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64c24cf59d8103f37b8ace28
        failing since 97 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-27T10:54:35.430947  <8>[   40.980706] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-07-27T10:54:36.496507  /lava-11150782/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64c24cf59d8103f37b8ace29
        failing since 97 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-27T10:54:34.343450  <8>[   39.892822] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-07-27T10:54:35.407053  /lava-11150782/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64c24ed51076933d418acec3

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64c24ed61076933d418acec9
        failing since 97 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-27T11:02:39.167621  /lava-11150796/1/../bin/lava-test-case

    2023-07-27T11:02:39.178393  <8>[   33.508978] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64c24ed61076933d418aceca
        failing since 97 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-27T11:02:37.108275  <8>[   31.437577] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-07-27T11:02:38.132300  /lava-11150796/1/../bin/lava-test-case

    2023-07-27T11:02:38.143135  <8>[   32.473583] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64c24ca2e2a9518d638ace23

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64c24ca2e2a9518d638ace28
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1)

    2023-07-27T10:54:06.832079  / # #

    2023-07-27T10:54:06.934216  export SHELL=3D/bin/sh

    2023-07-27T10:54:06.934906  #

    2023-07-27T10:54:07.036310  / # export SHELL=3D/bin/sh. /lava-11150775/=
environment

    2023-07-27T10:54:07.037039  =


    2023-07-27T10:54:07.138458  / # . /lava-11150775/environment/lava-11150=
775/bin/lava-test-runner /lava-11150775/1

    2023-07-27T10:54:07.139516  =


    2023-07-27T10:54:07.156528  / # /lava-11150775/bin/lava-test-runner /la=
va-11150775/1

    2023-07-27T10:54:07.215669  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-27T10:54:07.216163  + cd /lava-1115077<8>[   18.357674] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11150775_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

