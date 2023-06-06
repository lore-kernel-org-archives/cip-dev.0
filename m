Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92001C7EE24
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 11:00:30 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web10.5798.1686049220763057446
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Jun 2023 04:00:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=JbxawRXt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-650bacd6250so3295007b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Jun 2023 04:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686049220; x=1688641220;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t/ap+aUp1GqNM7qbwtI2IWbOQwoUxmx637C5UwTUaco=;
        b=JbxawRXt5CJD3CEGxzlagSJvPRgoLd37GiT+ewscgjgcU0j5fY3yenJZ3CfVzzYUee
         lXKMSYU5kzBj+1DDSZ4pJ3lNND5RvUUDVDuQTAwK4kYqbka4tTbnYxedzWr30BLt/SjR
         vXKdR/rGowWTPMrfobBTf9Z6WlANGj4aGqkgPyk2+7UQGRNULNRH14h66An33SMT3R/Q
         UUcoG5/xnCwi5sGQ95V5bnmDFW4hLkECP3XtR+teZART8eLHJrMkjcmFsk8WlpIG2rdE
         BTxws6+5beclZ8Ot+uzhT4kaV9yvnSq2k++veC/c7ymIwizw1mx+EOdAM9lZn14eb2Im
         jVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686049220; x=1688641220;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/ap+aUp1GqNM7qbwtI2IWbOQwoUxmx637C5UwTUaco=;
        b=JSgoC56nqkqRX6g1Gw1CTB7LNoE+ursqOkxJii51Goebsf4UJlIp7OJ4JVOq29HXJT
         XlfCbNXc3393JCzPkXWGfM5Xd3aCHqsWdelOHflKllkLQBNdNwSlXWpHnwB+/CZwQMJp
         sacNrvqmlL3cih7ZJvQb1/x7MUEKhQNlM3o5nr2oVqNwcUxo1m1OYg6fAlH2+mq9lZdf
         PWS+PWIMRLUfQnR2bN1pvKUHnC8FezZL3vekuHMnugwAHhZ/dqELa96GmvQCRuMz8wwp
         f0Cwphbb9MTNSxGMs8Y6tuyDx/2RJMawPWvxHB4ruia8xmlR/IKC58mwQrLV60KiKe3i
         qbZQ==
X-Gm-Message-State: AC+VfDy5f+r6TxWT54SQNkVT5rkNf3UABIRWj+sOSWwqZtSmIIIhl1v/
	e4KxhQIRU5uvkxBviQCsC3cWrDXMwMkX4or4Oj/kCQ==
X-Google-Smtp-Source: ACHHUZ5du3phw0RFIbEfm8vkC9jHV/Nyqx4qs7VYH7HC22F7d0JyF5GYDGFrE09c5paS+dxsX363vw==
X-Received: by 2002:a05:6a00:a1f:b0:65c:e35b:b13a with SMTP id p31-20020a056a000a1f00b0065ce35bb13amr1043046pfh.14.1686049219071;
        Tue, 06 Jun 2023 04:00:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s19-20020aa78293000000b0063f0068cf6csm6536958pfm.198.2023.06.06.04.00.18
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 04:00:18 -0700 (PDT)
Message-ID: <647f11c2.a70a0220.54949.b420@mx.google.com>
Date: Tue, 06 Jun 2023 04:00:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1321-g3152fb7c8d2d6
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline: 80 runs,
 18 regressions (v6.1.26-1321-g3152fb7c8d2d6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 11:00:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11869

cip-gitlab/ci/pavel/linux-test baseline: 80 runs, 18 regressions (v6.1.26-1=
321-g3152fb7c8d2d6)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1321-g3152fb7c8d2d6/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1321-g3152fb7c8d2d6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3152fb7c8d2d6c6a2c22edfc334cb69a5428ccad =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f071e15e751b7d9f5de9b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f071e15e751b7d9f5dea4
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-06T10:14:45.733170  + set +x

    2023-06-06T10:14:45.739545  <8>[   10.291434] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10604261_1.4.2.3.1>

    2023-06-06T10:14:45.848445  #

    2023-06-06T10:14:45.848687  =


    2023-06-06T10:14:45.949364  / # #export SHELL=3D/bin/sh

    2023-06-06T10:14:45.950192  =


    2023-06-06T10:14:46.051761  / # export SHELL=3D/bin/sh. /lava-10604261/=
environment

    2023-06-06T10:14:46.051983  =


    2023-06-06T10:14:46.152491  / # . /lava-10604261/environment/lava-10604=
261/bin/lava-test-runner /lava-10604261/1

    2023-06-06T10:14:46.152740  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f082537c4572e8cf5de30

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f082537c4572e8cf5de39
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-06T10:18:59.113181  + set<8>[   12.015162] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10604292_1.4.2.3.1>

    2023-06-06T10:18:59.113720   +x

    2023-06-06T10:18:59.220640  / # #

    2023-06-06T10:18:59.321696  export SHELL=3D/bin/sh

    2023-06-06T10:18:59.322486  #

    2023-06-06T10:18:59.424150  / # export SHELL=3D/bin/sh. /lava-10604292/=
environment

    2023-06-06T10:18:59.425012  =


    2023-06-06T10:18:59.526561  / # . /lava-10604292/environment/lava-10604=
292/bin/lava-test-runner /lava-10604292/1

    2023-06-06T10:18:59.527756  =


    2023-06-06T10:18:59.532896  / # /lava-10604292/bin/lava-test-runner /la=
va-10604292/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f072815e751b7d9f5dec9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f072815e751b7d9f5ded2
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-06T10:14:59.073440  <8>[   12.231211] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10604274_1.4.2.3.1>

    2023-06-06T10:14:59.076876  + set +x

    2023-06-06T10:14:59.178310  =


    2023-06-06T10:14:59.279060  / # #export SHELL=3D/bin/sh

    2023-06-06T10:14:59.279299  =


    2023-06-06T10:14:59.379875  / # export SHELL=3D/bin/sh. /lava-10604274/=
environment

    2023-06-06T10:14:59.423114  =


    2023-06-06T10:14:59.525019  / # /lava-10604274/bin/lava-test-runner /la=
va-10604274/1

    2023-06-06T10:14:59.525358  . /lava-10604274/environment

    2023-06-06T10:14:59.530308  / # /lava-10604274/bin/lava-test-runner /la=
va-10604274/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/647f05e3fd47991076f5de9c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/arm/bcm2835_defconfig/gcc-10/lab-collabora/bas=
eline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/arm/bcm2835_defconfig/gcc-10/lab-collabora/bas=
eline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f05e3fd47991076f5dea5
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-06T10:09:58.897469  / # #

    2023-06-06T10:09:58.999568  export SHELL=3D/bin/sh

    2023-06-06T10:09:59.000322  #

    2023-06-06T10:09:59.101682  / # export SHELL=3D/bin/sh. /lava-10604094/=
environment

    2023-06-06T10:09:59.102435  =


    2023-06-06T10:09:59.203866  / # . /lava-10604094/environment/lava-10604=
094/bin/lava-test-runner /lava-10604094/1

    2023-06-06T10:09:59.204947  =


    2023-06-06T10:09:59.221652  / # /lava-10604094/bin/lava-test-runner /la=
va-10604094/1

    2023-06-06T10:09:59.331445  + export 'TESTRUN_ID=3D1_bootrr'

    2023-06-06T10:09:59.331966  + cd /lava-10604094/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647f067038e9f983d9f5de91

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647f067038e9f983d9f5d=
e92
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f08fdc63b6abd31f5de30

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f08fdc63b6abd31f5de39
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31)

    2023-06-06T10:22:41.403033  + set +x

    2023-06-06T10:22:41.410132  <8>[   11.352328] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10604327_1.4.2.3.1>

    2023-06-06T10:22:41.514877  / # #

    2023-06-06T10:22:41.617470  export SHELL=3D/bin/sh

    2023-06-06T10:22:41.618271  #

    2023-06-06T10:22:41.719838  / # export SHELL=3D/bin/sh. /lava-10604327/=
environment

    2023-06-06T10:22:41.720663  =


    2023-06-06T10:22:41.822325  / # . /lava-10604327/environment/lava-10604=
327/bin/lava-test-runner /lava-10604327/1

    2023-06-06T10:22:41.823633  =


    2023-06-06T10:22:41.828721  / # /lava-10604327/bin/lava-test-runner /la=
va-10604327/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f0849ecc58758c8f5de33

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f0849ecc58758c8f5de3c
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31)

    2023-06-06T10:19:40.307187  <8>[   10.580520] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10604295_1.4.2.3.1>

    2023-06-06T10:19:40.312137  + set +x

    2023-06-06T10:19:40.418170  #

    2023-06-06T10:19:40.419627  =


    2023-06-06T10:19:40.521708  / # #export SHELL=3D/bin/sh

    2023-06-06T10:19:40.522397  =


    2023-06-06T10:19:40.624136  / # export SHELL=3D/bin/sh. /lava-10604295/=
environment

    2023-06-06T10:19:40.624856  =


    2023-06-06T10:19:40.726239  / # . /lava-10604295/environment/lava-10604=
295/bin/lava-test-runner /lava-10604295/1

    2023-06-06T10:19:40.726620  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f071e63e3027f9ff5de7a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f071e63e3027f9ff5de83
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-06T10:14:32.588900  + <8>[   11.090036] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10604279_1.4.2.3.1>

    2023-06-06T10:14:32.588990  set +x

    2023-06-06T10:14:32.693530  / # #

    2023-06-06T10:14:32.794262  export SHELL=3D/bin/sh

    2023-06-06T10:14:32.794509  #

    2023-06-06T10:14:32.895086  / # export SHELL=3D/bin/sh. /lava-10604279/=
environment

    2023-06-06T10:14:32.895347  =


    2023-06-06T10:14:32.995958  / # . /lava-10604279/environment/lava-10604=
279/bin/lava-test-runner /lava-10604279/1

    2023-06-06T10:14:32.996322  =


    2023-06-06T10:14:33.000798  / # /lava-10604279/bin/lava-test-runner /la=
va-10604279/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647f06a2a02eba7763f5de5e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/=
baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/=
baseline-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f06a2a02eba7763f5de67
        failing since 0 day (last pass: v5.10.180-cip34-26-gc198172c84b6a, =
first fail: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-06T10:12:25.267369  + set +x
    2023-06-06T10:12:25.267563  [   12.872452] <LAVA_SIGNAL_ENDRUN 0_dmesg =
968861_1.5.2.3.1>
    2023-06-06T10:12:25.375612  / # #
    2023-06-06T10:12:25.477198  export SHELL=3D/bin/sh
    2023-06-06T10:12:25.477707  #
    2023-06-06T10:12:25.578950  / # export SHELL=3D/bin/sh. /lava-968861/en=
vironment
    2023-06-06T10:12:25.579475  =

    2023-06-06T10:12:25.680779  / # . /lava-968861/environment/lava-968861/=
bin/lava-test-runner /lava-968861/1
    2023-06-06T10:12:25.681434  =

    2023-06-06T10:12:25.684965  / # /lava-968861/bin/lava-test-runner /lava=
-968861/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647f06c9adf7246b67f5de28

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/=
baseline-imx6dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/=
baseline-imx6dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f06c9adf7246b67f5de31
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-06T10:13:08.181497  + set[   14.937829] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 968862_1.5.2.3.1>
    2023-06-06T10:13:08.181703   +x
    2023-06-06T10:13:08.287659  / # #
    2023-06-06T10:13:08.389281  export SHELL=3D/bin/sh
    2023-06-06T10:13:08.389783  #
    2023-06-06T10:13:08.491052  / # export SHELL=3D/bin/sh. /lava-968862/en=
vironment
    2023-06-06T10:13:08.491554  =

    2023-06-06T10:13:08.592901  / # . /lava-968862/environment/lava-968862/=
bin/lava-test-runner /lava-968862/1
    2023-06-06T10:13:08.593589  =

    2023-06-06T10:13:08.596492  / # /lava-968862/bin/lava-test-runner /lava=
-968862/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647f08bc7c330a285bf5e0b5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647f08bc7c330a285bf5e=
0b6
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647f093536167a5edcf5de65

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647f093536167a5edcf5d=
e66
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647f07cadc31d938c6f5de3c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/baselin=
e-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/baselin=
e-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647f07cadc31d938c6f5d=
e3d
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647f08c57c330a285bf5e0cf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline=
-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline=
-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f08c57c330a285bf5e0d6
        failing since 75 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f6=
, first fail: v5.10.175-cip29-rt12)

    2023-06-06T10:20:18.997283  + set +x<8>[   33.538122] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1234259_1.5.2.4.1>
    2023-06-06T10:20:18.997590  =

    2023-06-06T10:20:19.106737  / # #
    2023-06-06T10:20:20.266357  export SHELL=3D/bin/sh
    2023-06-06T10:20:20.272123  #
    2023-06-06T10:20:20.272404  / # export SHELL=3D/bin/sh
    2023-06-06T10:20:21.818892  / # . /lava-1234259/environment
    2023-06-06T10:20:24.645538  /lava-1234259/bin/lava-test-runner /lava-12=
34259/1
    2023-06-06T10:20:24.651571  . /lava-1234259/environment
    2023-06-06T10:20:24.651828  / # /lava-1234259/bin/lava-test-runner /lav=
a-1234259/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f0722df8fbf17f5f5de31

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647f0722df8fbf17f5f5de3a
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-06T10:14:39.646374  + set<8>[   12.960876] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10604342_1.4.2.3.1>

    2023-06-06T10:14:39.646513   +x

    2023-06-06T10:14:39.750909  / # #

    2023-06-06T10:14:39.851597  export SHELL=3D/bin/sh

    2023-06-06T10:14:39.851824  #

    2023-06-06T10:14:39.952348  / # export SHELL=3D/bin/sh. /lava-10604342/=
environment

    2023-06-06T10:14:39.952611  =


    2023-06-06T10:14:40.053204  / # . /lava-10604342/environment/lava-10604=
342/bin/lava-test-runner /lava-10604342/1

    2023-06-06T10:14:40.053607  =


    2023-06-06T10:14:40.057846  / # /lava-10604342/bin/lava-test-runner /la=
va-10604342/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647f05c2204ba97cc3f5de73

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/arm/shmobile_defconfig/gcc-10/lab-cip/baseline=
-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/arm/shmobile_defconfig/gcc-10/lab-cip/baseline=
-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647f05c2204ba97cc3f5d=
e74
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/647f060b7cf36d82c4f5de5b

  Results:     66 PASS, 4 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/647f060b7cf36d82c4f5de8f
        failing since 136 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-06-06T10:10:47.113586  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   19.774907] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-06-06T10:10:47.113805  ST

    2023-06-06T10:10:47.113855  =


    2023-06-06T10:10:47.119039  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-06-06T10:10:47.121635  FIRST, INC default to 1.

    2023-06-06T10:10:47.121852  =


    2023-06-06T10:10:47.125216  	-w	Pad to last with leading zeros

    2023-06-06T10:10:47.127949  	-s SEP	String separator

    2023-06-06T10:10:47.131791  /lava-10604155/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/647f060b7cf36d82c4f5de90
        failing since 136 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-06-06T10:10:47.085340  <8>[   19.753177] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>

    2023-06-06T10:10:47.098990  BusyBox v1.31.1 (2023-05-27 14:14:16 UTC) m=
ulti-call binary.

    2023-06-06T10:10:47.099212  =

   =

 =20

