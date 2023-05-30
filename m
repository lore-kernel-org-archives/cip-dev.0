Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9543CC77B73
	for <webhook@archiver.kernel.org>; Tue, 30 May 2023 16:55:48 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web11.2645.1685465739568974602
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 30 May 2023 09:55:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=I35ZsXkf;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-64d4e45971bso3181660b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 30 May 2023 09:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685465738; x=1688057738;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FTxQFZ+0+eDWbwUr2YxItt6m+wkoEvgse6ZcFAqqmL4=;
        b=I35ZsXkfrKKupgCdw+KzIpGsV/JN1PB+W8NJQ4QYFohV7p63BWXB/WxIqz3yltFjVE
         l9+h3NVomm7RrTuaaJFSBLmnd/UV37wAk2139XEe3tPy5QNmAGEC3eHfGWPhN4xcp4sL
         r/ztHAd3h6KeGbE89KZgRf+gE4CUg8sV0IfMup/nsz8iVULrsYDMYZdFC8LvZ1ulNaUG
         6PMFzpz/lf8ge1KgXLagrymWeRsI2DQD9V9cEP3sk5o04+rA+oiw9kARwm7/CFe2LZNn
         u7choQv9hLLQoTPuw5N4rANHu7NkJPKSj5zwDcJTMX7ZGs1Ns9D4LGeVXSebzskbdDD1
         +Y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685465738; x=1688057738;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTxQFZ+0+eDWbwUr2YxItt6m+wkoEvgse6ZcFAqqmL4=;
        b=TlvKAsejfUJkz6Rq08khn0tZQcZwjLoxJIy7Zi2GXtYjHj5LFn0QClJMqjcaEQqhJA
         tjvcIrur1as6Sr6ov2EuRuyk8FvvP5VaoozESUzH4MTX7rrtHR4w9eawqPpGhjJHi0s2
         IQyirYHKt91CK93MgRDgmbdAzVRM9Dwls+iy7nZOMxYLLqEDRCSwhU4zr+Hh6A6P83w4
         62CpleIv1HBzPi0ioBCCb4SOBgtVlkUWKfx2TVKDf6DgL5Cnj0+2wW6hnjUm35GxDvzA
         Tto9R+sBLipTbXEkpjOF/wJ2bSLNhaCZAx5m4TYilDtGWMK5HgsO1zj/g58IOQ+rw5ZO
         PhjQ==
X-Gm-Message-State: AC+VfDwvIA17z8JbM7L2jfTlZYJDxFkFtlOQJWXcqwXrOgRdCKXohIhI
	M7pfgMVy29qnICHiTo70jo2u6LdQZfpojyhAXIvv7A==
X-Google-Smtp-Source: ACHHUZ6eFJ7rcc9mDGGLx5Qm9R5lXWPnyr0gGWdMNEQ55ntBoo80Dp8tmN+gHz0wQ8VVF/WBbXLdQA==
X-Received: by 2002:a05:6a20:7d83:b0:10a:a57a:9f7e with SMTP id v3-20020a056a207d8300b0010aa57a9f7emr3523689pzj.25.1685465738101;
        Tue, 30 May 2023 09:55:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s16-20020aa78d50000000b0062de9ef6915sm1796293pfe.216.2023.05.30.09.55.37
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:55:37 -0700 (PDT)
Message-ID: <64762a89.a70a0220.2a97f.38e5@mx.google.com>
Date: Tue, 30 May 2023 09:55:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.180-cip34-213-g6582dd41d2c22
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 133 runs,
 9 regressions (v5.10.180-cip34-213-g6582dd41d2c22)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 May 2023 16:55:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11706

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 133 runs, 9 regression=
s (v5.10.180-cip34-213-g6582dd41d2c22)

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
Flinux-5.10.y-cip-rc/kernel/v5.10.180-cip34-213-g6582dd41d2c22/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.180-cip34-213-g6582dd41d2c22
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6582dd41d2c22c9ea2ddcf80d06886b8470ab496 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647621130773a425b32e85f8

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647621140773a425b32e862d
        failing since 146 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-05-30T16:14:54.346549  + set +x
    2023-05-30T16:14:54.355488  <8>[   19.576097] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 537091_1.5.2.4.1>
    2023-05-30T16:14:54.458967  / # #
    2023-05-30T16:14:54.560688  export SHELL=3D/bin/sh
    2023-05-30T16:14:54.561066  #
    2023-05-30T16:14:54.662359  / # export SHELL=3D/bin/sh. /lava-537091/en=
vironment
    2023-05-30T16:14:54.662848  =

    2023-05-30T16:14:54.764532  / # . /lava-537091/environment/lava-537091/=
bin/lava-test-runner /lava-537091/1
    2023-05-30T16:14:54.765286  =

    2023-05-30T16:14:54.769821  / # /lava-537091/bin/lava-test-runner /lava=
-537091/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647623fc4719f480fa2e85f9

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647623fc4719f480fa2e85fc
        failing since 146 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-05-30T16:27:27.650118  + set +x
    2023-05-30T16:27:27.652218  <8>[   14.513711] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 947470_1.5.2.4.1>
    2023-05-30T16:27:27.760718  / # #
    2023-05-30T16:27:27.862586  export SHELL=3D/bin/sh
    2023-05-30T16:27:27.863034  #
    2023-05-30T16:27:27.964516  / # export SHELL=3D/bin/sh. /lava-947470/en=
vironment
    2023-05-30T16:27:27.965129  =

    2023-05-30T16:27:28.066575  / # . /lava-947470/environment/lava-947470/=
bin/lava-test-runner /lava-947470/1
    2023-05-30T16:27:28.067342  =

    2023-05-30T16:27:28.069531  / # /lava-947470/bin/lava-test-runner /lava=
-947470/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64761b2a9f5cb7504e2e8621

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopu=
s.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopu=
s.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64761b2a9f5cb7504e2e8626
        failing since 40 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-30T15:49:54.101636  + set +x

    2023-05-30T15:49:54.107819  <8>[   14.607114] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10526774_1.4.2.3.1>

    2023-05-30T15:49:54.212519  / # #

    2023-05-30T15:49:54.313102  export SHELL=3D/bin/sh

    2023-05-30T15:49:54.313306  #

    2023-05-30T15:49:54.413790  / # export SHELL=3D/bin/sh. /lava-10526774/=
environment

    2023-05-30T15:49:54.413980  =


    2023-05-30T15:49:54.514505  / # . /lava-10526774/environment/lava-10526=
774/bin/lava-test-runner /lava-10526774/1

    2023-05-30T15:49:54.514864  =


    2023-05-30T15:49:54.519871  / # /lava-10526774/bin/lava-test-runner /la=
va-10526774/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64761d9d12ea8fd6ae2e8618

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4=
020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4=
020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64761d9d12ea8fd6ae2e861d
        failing since 40 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-30T16:00:19.764774  + set +x

    2023-05-30T16:00:19.771287  <8>[   12.960584] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10527062_1.4.2.3.1>

    2023-05-30T16:00:19.875759  / # #

    2023-05-30T16:00:19.976425  export SHELL=3D/bin/sh

    2023-05-30T16:00:19.976626  #

    2023-05-30T16:00:20.077256  / # export SHELL=3D/bin/sh. /lava-10527062/=
environment

    2023-05-30T16:00:20.077459  =


    2023-05-30T16:00:20.178020  / # . /lava-10527062/environment/lava-10527=
062/bin/lava-test-runner /lava-10527062/1

    2023-05-30T16:00:20.178311  =


    2023-05-30T16:00:20.182580  / # /lava-10527062/bin/lava-test-runner /la=
va-10527062/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64761b3389fdcc1f422e85f5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64761b3389fdcc1f422e85fa
        failing since 40 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-30T15:49:57.138469  <8>[   13.445549] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10526766_1.4.2.3.1>

    2023-05-30T15:49:57.141944  + set +x

    2023-05-30T15:49:57.246966  / # #

    2023-05-30T15:49:57.347860  export SHELL=3D/bin/sh

    2023-05-30T15:49:57.348153  #

    2023-05-30T15:49:57.448793  / # export SHELL=3D/bin/sh. /lava-10526766/=
environment

    2023-05-30T15:49:57.449115  =


    2023-05-30T15:49:57.549782  / # . /lava-10526766/environment/lava-10526=
766/bin/lava-test-runner /lava-10526766/1

    2023-05-30T15:49:57.550221  =


    2023-05-30T15:49:57.554895  / # /lava-10526766/bin/lava-test-runner /la=
va-10526766/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64761d894f91a7a5792e85fd

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64761d894f91a7a5792e8602
        failing since 40 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-30T15:59:53.553840  + set<8>[   12.285202] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10527101_1.4.2.3.1>

    2023-05-30T15:59:53.554320   +x

    2023-05-30T15:59:53.661374  #

    2023-05-30T15:59:53.764346  / # #export SHELL=3D/bin/sh

    2023-05-30T15:59:53.765119  =


    2023-05-30T15:59:53.866519  / # export SHELL=3D/bin/sh. /lava-10527101/=
environment

    2023-05-30T15:59:53.867294  =


    2023-05-30T15:59:53.968750  / # . /lava-10527101/environment/lava-10527=
101/bin/lava-test-runner /lava-10527101/1

    2023-05-30T15:59:53.969859  =


    2023-05-30T15:59:53.975192  / # /lava-10527101/bin/lava-test-runner /la=
va-10527101/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64761cf4291d09e3c42e85f8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64761cf4291d09e3c42e8=
5f9
        failing since 4 days (last pass: v5.10.179-cip32-384-g291adc46abef0=
, first fail: v5.10.180-cip33-21-g090289427e8b2) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/647621e360ce6f0bbe2e85e6

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/647621e360ce6f0bbe2e85ec
        failing since 40 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-30T16:18:36.609225  /lava-10527275/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/647621e360ce6f0bbe2e85ed
        failing since 40 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-30T16:18:35.572903  /lava-10527275/1/../bin/lava-test-case

    2023-05-30T16:18:35.584343  <8>[   33.681058] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

