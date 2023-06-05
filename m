Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6824C77B73
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 11:10:52 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.4758.1685963448682794970
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 04:10:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=1+m8Dmrh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-64d24136685so3325822b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 04:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685963447; x=1688555447;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m7PdK4P+S9AFzYv0EaVEESCkmepKLDvmF6ygQ7Rfgqw=;
        b=1+m8DmrhfW7dzWWUELA5WuXcSVbq0wLWTsQ3itmbIMQijG8Z2GzWrK3l9zvhYm9Y1q
         16VGcIq9B3c+L8biXJGtQQpdS8Y6jYcXUsVr+eZDxKA1LEd275JlufdIqtRAFt31QzFq
         lp1uI8HTXE85POqBKUkpYMt2PEafv1Qf3Yp+9BhG1uDj7YjBG9nw/h5PdcwjEZMMxg3z
         tRjK2FcUha+wPaqHMwwTDacPy4rv/RedLhPNR+f0jFAEkwajHvf7e6ENUMN4C2ng8ows
         nBhofjo/TvdsOhuS7eVO+ts3ipwUiwPeypdZ1ItU3GGg0/Zl6enPQelMgupRLS5DIW7h
         1Azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685963447; x=1688555447;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7PdK4P+S9AFzYv0EaVEESCkmepKLDvmF6ygQ7Rfgqw=;
        b=LQEJXwglqaTlN+yA3M66tWinHmAt/Cy5saFksZmca7H0HzJaKZkErOiQE2pzWC5pyn
         cwXOTNm4BUcafxJ7q0EJWAQ1ungvHoPSrsRfK9DhYNvpdR0ZvPCZetnIifDqBh/ULzn5
         L2xJiBbZi7PzjggP1tkLBRF/aLbwNBJol+PleiEFNlZNMhuZNM9aisqViDVR6hpHdXqc
         fuLnbNcBP0sEUiQ/RuA/s2USQAEQoA3fqwAwOIb7siwB7A3bgpHRpV7o44m6lHFOjKgb
         VSWuLIk0w+rAIhMP894Ci9N7qo3yNmKWD4L62CqWlGnHZ63IAx/8s8rhjC+uEsKbm7je
         driA==
X-Gm-Message-State: AC+VfDwTOPsVwas9sm4YYnNq9cgKDz3b3hyjjNxe7M5bTuZxuhWi4yos
	RgnHmZJej/OSE0dM6mwssAE/WVZ0US+RMPLLwqWVag==
X-Google-Smtp-Source: ACHHUZ4m67ZBmMZoMH0xNLsEd+5ecvpSwigMfaePqDjHHuEkImWnBcFcTQwBORz5pSa6mM4qg2kfdA==
X-Received: by 2002:a05:6a00:1797:b0:65a:8392:a5c4 with SMTP id s23-20020a056a00179700b0065a8392a5c4mr3303950pfg.11.1685963446518;
        Mon, 05 Jun 2023 04:10:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c16-20020aa78810000000b00646ebc77b1fsm5043026pfo.75.2023.06.05.04.10.45
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 04:10:45 -0700 (PDT)
Message-ID: <647dc2b5.a70a0220.cb370.8464@mx.google.com>
Date: Mon, 05 Jun 2023 04:10:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-236-g6d219c607dc68
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 154 runs,
 9 regressions (v5.10.180-cip34-236-g6d219c607dc68)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 11:10:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11797

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 154 runs, 9 regression=
s (v5.10.180-cip34-236-g6d219c607dc68)

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

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.180-cip34-236-g6d219c607dc68/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.180-cip34-236-g6d219c607dc68
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6d219c607dc68f956270abf58e720f31e27b38f5 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647db5f3e6eadcb019f5dec9

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647db5f3e6eadcb019f5df01
        failing since 151 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-06-05T10:15:57.914898  <8>[   16.616720] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 562317_1.5.2.4.1>
    2023-06-05T10:15:58.026011  / # #
    2023-06-05T10:15:58.128958  export SHELL=3D/bin/sh
    2023-06-05T10:15:58.129819  #
    2023-06-05T10:15:58.231876  / # export SHELL=3D/bin/sh. /lava-562317/en=
vironment
    2023-06-05T10:15:58.232795  =

    2023-06-05T10:15:58.334906  / # . /lava-562317/environment/lava-562317/=
bin/lava-test-runner /lava-562317/1
    2023-06-05T10:15:58.336234  =

    2023-06-05T10:15:58.340895  / # /lava-562317/bin/lava-test-runner /lava=
-562317/1
    2023-06-05T10:15:58.441354  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647dbcb604a1ad7192f5de89

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647dbcb604a1ad7192f5de90
        failing since 151 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-06-05T10:45:02.934563  / # #
    2023-06-05T10:45:03.038047  export SHELL=3D/bin/sh
    2023-06-05T10:45:03.039133  #
    2023-06-05T10:45:03.141550  / # export SHELL=3D/bin/sh. /lava-953062/en=
vironment
    2023-06-05T10:45:03.142634  =

    2023-06-05T10:45:03.245109  / # . /lava-953062/environment/lava-953062/=
bin/lava-test-runner /lava-953062/1
    2023-06-05T10:45:03.246971  =

    2023-06-05T10:45:03.256833  / # /lava-953062/bin/lava-test-runner /lava=
-953062/1
    2023-06-05T10:45:03.398671  + export 'TESTRUN_ID=3D1_bootrr'
    2023-06-05T10:45:03.399296  + cd /lava-953062/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647db72bef0e166567f5de4b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopu=
s.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopu=
s.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647db72bef0e166567f5de54
        failing since 45 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-05T10:21:22.485346  + set +x

    2023-06-05T10:21:22.491846  <8>[   10.881830] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10590280_1.4.2.3.1>

    2023-06-05T10:21:22.596563  / # #

    2023-06-05T10:21:22.697280  export SHELL=3D/bin/sh

    2023-06-05T10:21:22.697504  #

    2023-06-05T10:21:22.798037  / # export SHELL=3D/bin/sh. /lava-10590280/=
environment

    2023-06-05T10:21:22.798270  =


    2023-06-05T10:21:22.898823  / # . /lava-10590280/environment/lava-10590=
280/bin/lava-test-runner /lava-10590280/1

    2023-06-05T10:21:22.899176  =


    2023-06-05T10:21:22.903800  / # /lava-10590280/bin/lava-test-runner /la=
va-10590280/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647db77d53df586dd3f5de25

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4=
020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4=
020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647db77d53df586dd3f5de2e
        failing since 45 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-05T10:22:49.660968  + set +x

    2023-06-05T10:22:49.667498  <8>[   16.608652] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10590666_1.4.2.3.1>

    2023-06-05T10:22:49.774663  / # #

    2023-06-05T10:22:49.877761  export SHELL=3D/bin/sh

    2023-06-05T10:22:49.878411  #

    2023-06-05T10:22:49.979659  / # export SHELL=3D/bin/sh. /lava-10590666/=
environment

    2023-06-05T10:22:49.980339  =


    2023-06-05T10:22:50.081702  / # . /lava-10590666/environment/lava-10590=
666/bin/lava-test-runner /lava-10590666/1

    2023-06-05T10:22:50.082710  =


    2023-06-05T10:22:50.087747  / # /lava-10590666/bin/lava-test-runner /la=
va-10590666/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647db6ad29631f33e4f5de6e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647db6ad29631f33e4f5de77
        failing since 45 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-05T10:19:07.402158  + set +x

    2023-06-05T10:19:07.408218  <8>[   13.315834] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10590269_1.4.2.3.1>

    2023-06-05T10:19:07.513239  / # #

    2023-06-05T10:19:07.613972  export SHELL=3D/bin/sh

    2023-06-05T10:19:07.614215  #

    2023-06-05T10:19:07.714730  / # export SHELL=3D/bin/sh. /lava-10590269/=
environment

    2023-06-05T10:19:07.714977  =


    2023-06-05T10:19:07.815559  / # . /lava-10590269/environment/lava-10590=
269/bin/lava-test-runner /lava-10590269/1

    2023-06-05T10:19:07.815917  =


    2023-06-05T10:19:07.821322  / # /lava-10590269/bin/lava-test-runner /la=
va-10590269/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647db74d2282b99b10f5de27

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647db74d2282b99b10f5de30
        failing since 45 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-05T10:21:57.491477  <8>[   14.327693] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10590709_1.4.2.3.1>

    2023-06-05T10:21:57.494721  + set +x

    2023-06-05T10:21:57.598932  #

    2023-06-05T10:21:57.599259  =


    2023-06-05T10:21:57.699978  / # #export SHELL=3D/bin/sh

    2023-06-05T10:21:57.700272  =


    2023-06-05T10:21:57.801029  / # export SHELL=3D/bin/sh. /lava-10590709/=
environment

    2023-06-05T10:21:57.801219  =


    2023-06-05T10:21:57.901750  / # . /lava-10590709/environment/lava-10590=
709/bin/lava-test-runner /lava-10590709/1

    2023-06-05T10:21:57.902008  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647db7586e6e2dfcfef5debd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647db7586e6e2dfcfef5d=
ebe
        failing since 10 days (last pass: v5.10.179-cip32-384-g291adc46abef=
0, first fail: v5.10.180-cip33-21-g090289427e8b2) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/647dbc56e3efb4a54bf5de2c

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/647dbc56e3efb4a54bf5de38
        failing since 45 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-05T10:43:27.140280  <8>[   61.121966] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-06-05T10:43:28.165235  /lava-10590931/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/647dbc56e3efb4a54bf5de39
        failing since 45 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-05T10:43:27.127929  /lava-10590931/1/../bin/lava-test-case
   =

 =20

