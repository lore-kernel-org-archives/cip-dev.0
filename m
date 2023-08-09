Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1B8C001B0
	for <webhook@archiver.kernel.org>; Wed,  9 Aug 2023 00:35:03 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.78026.1691541295571461041
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 08 Aug 2023 17:34:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Km5QTIbV;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1bc8045e09dso9842715ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 08 Aug 2023 17:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691541294; x=1692146094;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0w/t33iM1Vt3ZuXoB/vSlpcDcaY4ZUJM8TiU7+39IUo=;
        b=Km5QTIbVugUpNsVBj1n9C8egXzG2phtmkFDStjQXbM1LOleQVOqqjeFqz5lo7sqSfD
         KJbUcRvh/B6l5QFWJqs2a3tMBDfVWImHuJ8A2KRs6CgKHhdvZY+itFUGfKnpEXjv+VmK
         R+TwAzsFi6QQWtw3n82qrWLb4N98GVcFS/pHEvY0vubCyzINbmHjXRofhh2qrZG5RegA
         HV+GwnU6F3ExLqgNse97GuXUuqb0v86LwlQcIJnQ9/uHrALXCGfiP6yEccB0jTXVAEhu
         q2Q7fmPzI5CmeBFuXRYbhj+7Z3Z0bHSkFRaGkMNlGFsJRpolACljRcv/9R4JPDKjCgPW
         g+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691541294; x=1692146094;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0w/t33iM1Vt3ZuXoB/vSlpcDcaY4ZUJM8TiU7+39IUo=;
        b=j+Ogm0jkA17KbtrYtaI/0KfUpgPNxQ0wuXv4lkqfEZcDQ+jBq3e/tatrwV4unUtfh1
         q+CCD6zLKkuOcttCpG1OZRjmsGL4yGhBv+MHXtTnwgHLAVFWGO0i/iDgTvuRW712cpmL
         p9/gN0UKmvjEOxj2N25BFfIIOnKYksd7dYZF9S36rt7guloxEiEYBU/6ZdH93iuSVjIl
         kJYPZqzOAWJ6LEhdKulIn/6xuBWZlULBsD+mPWzImBILfS0/T4+50894h73yDFsjLM9T
         PdoeOCfD6yR4Nmu4gqxRJq8Z5tcH/ge4OLceCBBGKjFj6YcK5tjTekDNxF3CmN4gGCyh
         Q8BA==
X-Gm-Message-State: AOJu0YxmmKWyvQEJXrbMWqEZ+AfPy67sXqnG10DOtNkUao/LqgnBJbnu
	rR1iWztMX70NDJMsDRK7u4+Auwcuwe8NfmfEnFZ0yA==
X-Google-Smtp-Source: AGHT+IHGzaHVZEVsuGqf/Bc/EEuvVItxrqQIFZAnTq8rm7oDvVDLJumOTvSYP+sTW6soD4Dx82YWAw==
X-Received: by 2002:a17:902:7b94:b0:1bc:4171:67e3 with SMTP id w20-20020a1709027b9400b001bc417167e3mr1133672pll.31.1691541293688;
        Tue, 08 Aug 2023 17:34:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ju18-20020a170903429200b001b86e17ecacsm9616869plb.131.2023.08.08.17.34.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 17:34:53 -0700 (PDT)
Message-ID: <64d2df2d.170a0220.5fcd8.253c@mx.google.com>
Date: Tue, 08 Aug 2023 17:34:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-566-g36076316ef049
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 181 runs,
 24 regressions (v5.10.186-cip37-566-g36076316ef049)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Aug 2023 00:35:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12568

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 181 runs, 24 regressio=
ns (v5.10.186-cip37-566-g36076316ef049)

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
g+kselftest          | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.186-cip37-566-g36076316ef049/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.186-cip37-566-g36076316ef049
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      36076316ef0496f258d98ea65b29aa2c5b0bc603 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2d82a1e6c576c2d35b21d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm/bcm2835_defconfig/gcc-1=
0/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm/bcm2835_defconfig/gcc-1=
0/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2d82a1e6c576c2d35b222
        failing since 12 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-09T00:05:59.364067  / # #

    2023-08-09T00:05:59.466161  export SHELL=3D/bin/sh

    2023-08-09T00:05:59.466892  #

    2023-08-09T00:05:59.568199  / # export SHELL=3D/bin/sh. /lava-11238190/=
environment

    2023-08-09T00:05:59.568838  =


    2023-08-09T00:05:59.670083  / # . /lava-11238190/environment/lava-11238=
190/bin/lava-test-runner /lava-11238190/1

    2023-08-09T00:05:59.671184  =


    2023-08-09T00:05:59.672436  / # /lava-11238190/bin/lava-test-runner /la=
va-11238190/1

    2023-08-09T00:05:59.752329  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-09T00:05:59.790480  + cd /lava-11238190/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2d7f51e6c576c2d35b1de

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2d7f51e6c576c2d35b213
        failing since 216 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-08-09T00:03:44.099765  <8>[   15.975992] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 39523_1.5.2.4.1>
    2023-08-09T00:03:44.208133  / # #
    2023-08-09T00:03:44.311283  export SHELL=3D/bin/sh
    2023-08-09T00:03:44.311746  #
    2023-08-09T00:03:44.413070  / # export SHELL=3D/bin/sh. /lava-39523/env=
ironment
    2023-08-09T00:03:44.413564  =

    2023-08-09T00:03:44.515010  / # . /lava-39523/environment/lava-39523/bi=
n/lava-test-runner /lava-39523/1
    2023-08-09T00:03:44.515868  =

    2023-08-09T00:03:44.520318  / # /lava-39523/bin/lava-test-runner /lava-=
39523/1
    2023-08-09T00:03:44.627269  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2d7f12d8f341c4435b1e1

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2d7f12d8f341c4435b1e4
        failing since 216 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-08-09T00:03:51.378289  / # #
    2023-08-09T00:03:51.481652  export SHELL=3D/bin/sh
    2023-08-09T00:03:51.482616  #
    2023-08-09T00:03:51.584925  / # export SHELL=3D/bin/sh. /lava-994499/en=
vironment
    2023-08-09T00:03:51.585957  =

    2023-08-09T00:03:51.688263  / # . /lava-994499/environment/lava-994499/=
bin/lava-test-runner /lava-994499/1
    2023-08-09T00:03:51.689769  =

    2023-08-09T00:03:51.700810  / # /lava-994499/bin/lava-test-runner /lava=
-994499/1
    2023-08-09T00:03:51.796768  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-09T00:03:51.835840  + cd /lava-994499/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2d1d39da58e2cca35b1db

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopu=
s.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopu=
s.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2d1d39da58e2cca35b1e0
        failing since 110 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-08T23:37:38.155872  + set +x

    2023-08-08T23:37:38.162325  <8>[   10.699969] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11238023_1.4.2.3.1>

    2023-08-08T23:37:38.266987  / # #

    2023-08-08T23:37:38.367686  export SHELL=3D/bin/sh

    2023-08-08T23:37:38.367891  #

    2023-08-08T23:37:38.468383  / # export SHELL=3D/bin/sh. /lava-11238023/=
environment

    2023-08-08T23:37:38.468588  =


    2023-08-08T23:37:38.569088  / # . /lava-11238023/environment/lava-11238=
023/bin/lava-test-runner /lava-11238023/1

    2023-08-08T23:37:38.569440  =


    2023-08-08T23:37:38.574233  / # /lava-11238023/bin/lava-test-runner /la=
va-11238023/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2d61ed8fcb8e27735b22a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4=
020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4=
020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2d61ed8fcb8e27735b22f
        failing since 110 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-08T23:56:07.444041  + set +x<8>[   16.294637] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11238157_1.4.2.3.1>

    2023-08-08T23:56:07.444549  =


    2023-08-08T23:56:07.552795  / # #

    2023-08-08T23:56:07.655425  export SHELL=3D/bin/sh

    2023-08-08T23:56:07.656286  #

    2023-08-08T23:56:07.757807  / # export SHELL=3D/bin/sh. /lava-11238157/=
environment

    2023-08-08T23:56:07.758601  =


    2023-08-08T23:56:07.860246  / # . /lava-11238157/environment/lava-11238=
157/bin/lava-test-runner /lava-11238157/1

    2023-08-08T23:56:07.861607  =


    2023-08-08T23:56:07.866484  / # /lava-11238157/bin/lava-test-runner /la=
va-11238157/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2d1bca9afe9bdf835b1d9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2d1bca9afe9bdf835b1de
        failing since 110 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-08T23:37:19.868303  + set +x<8>[   12.869741] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11238051_1.4.2.3.1>

    2023-08-08T23:37:19.868875  =


    2023-08-08T23:37:19.976501  #

    2023-08-08T23:37:19.977984  =


    2023-08-08T23:37:20.080007  / # #export SHELL=3D/bin/sh

    2023-08-08T23:37:20.080789  =


    2023-08-08T23:37:20.182339  / # export SHELL=3D/bin/sh. /lava-11238051/=
environment

    2023-08-08T23:37:20.183126  =


    2023-08-08T23:37:20.284916  / # . /lava-11238051/environment/lava-11238=
051/bin/lava-test-runner /lava-11238051/1

    2023-08-08T23:37:20.286246  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2d61f396387d89435b1fe

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2d61f396387d89435b203
        failing since 110 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-08T23:55:57.523825  <8>[   12.671122] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11238135_1.4.2.3.1>

    2023-08-08T23:55:57.527193  + set +x

    2023-08-08T23:55:57.632647  =


    2023-08-08T23:55:57.734305  / # #export SHELL=3D/bin/sh

    2023-08-08T23:55:57.735003  =


    2023-08-08T23:55:57.836380  / # export SHELL=3D/bin/sh. /lava-11238135/=
environment

    2023-08-08T23:55:57.837082  =


    2023-08-08T23:55:57.938452  / # . /lava-11238135/environment/lava-11238=
135/bin/lava-test-runner /lava-11238135/1

    2023-08-08T23:55:57.939529  =


    2023-08-08T23:55:57.945178  / # /lava-11238135/bin/lava-test-runner /la=
va-11238135/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2d8bfc4d18e938d35b22a

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2d8c0c4d18e938d35b266
        new failure (last pass: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-09T00:06:47.573586  <8>[   19.477076] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 39551_1.5.2.4.1>
    2023-08-09T00:06:47.681679  / # #
    2023-08-09T00:06:47.784545  export SHELL=3D/bin/sh
    2023-08-09T00:06:47.785366  #
    2023-08-09T00:06:47.887265  / # export SHELL=3D/bin/sh. /lava-39551/env=
ironment
    2023-08-09T00:06:47.888062  =

    2023-08-09T00:06:47.990185  / # . /lava-39551/environment/lava-39551/bi=
n/lava-test-runner /lava-39551/1
    2023-08-09T00:06:47.991624  =

    2023-08-09T00:06:48.005041  / # /lava-39551/bin/lava-test-runner /lava-=
39551/1
    2023-08-09T00:06:48.183678  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2d9b044420bc16f35b1f4

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig/gcc-10/lab-=
broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig/gcc-10/lab-=
broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2d9b044420bc16f35b22f
        failing since 12 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-09T00:11:02.030671  / # #
    2023-08-09T00:11:02.133670  export SHELL=3D/bin/sh
    2023-08-09T00:11:02.134444  #
    2023-08-09T00:11:02.236417  / # export SHELL=3D/bin/sh. /lava-39564/env=
ironment
    2023-08-09T00:11:02.237337  =

    2023-08-09T00:11:02.339302  / # . /lava-39564/environment/lava-39564/bi=
n/lava-test-runner /lava-39564/1
    2023-08-09T00:11:02.340629  =

    2023-08-09T00:11:02.354444  / # /lava-39564/bin/lava-test-runner /lava-=
39564/1
    2023-08-09T00:11:02.414313  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-09T00:11:02.414826  + cd /lava-39564/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2d8709c6c9af7cf35b25a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d2d8709c6c9af7cf35b=
25b
        failing since 74 days (last pass: v5.10.179-cip32-384-g291adc46abef=
0, first fail: v5.10.180-cip33-21-g090289427e8b2) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2d8c0b6daf4081a35b1e4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2d8c0b6daf4081a35b1e7
        failing since 12 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-09T00:07:07.456003  + set +x
    2023-08-09T00:07:07.456125  <8>[   83.709616] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 994506_1.5.2.4.1>
    2023-08-09T00:07:07.562947  / # #
    2023-08-09T00:07:09.023023  export SHELL=3D/bin/sh
    2023-08-09T00:07:09.043462  #
    2023-08-09T00:07:09.043624  / # export SHELL=3D/bin/sh
    2023-08-09T00:07:10.926526  / # . /lava-994506/environment
    2023-08-09T00:07:14.383473  /lava-994506/bin/lava-test-runner /lava-994=
506/1
    2023-08-09T00:07:14.404269  . /lava-994506/environment
    2023-08-09T00:07:14.404384  / # /lava-994506/bin/lava-test-runner /lava=
-994506/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2d959b9e20ed6b735b1d9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2d959b9e20ed6b735b1dc
        new failure (last pass: v5.10.180-cip34-19-gae79bc689058c)

    2023-08-09T00:09:47.060036  + set +x
    2023-08-09T00:09:47.060604  <8>[   87.570105] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 994523_1.5.2.4.1>
    2023-08-09T00:09:47.174556  #
    2023-08-09T00:09:48.646194  / # #export SHELL=3D/bin/sh
    2023-08-09T00:09:48.667507  =

    2023-08-09T00:09:48.668079  / # export SHELL=3D/bin/sh
    2023-08-09T00:09:50.563367  / # . /lava-994523/environment
    2023-08-09T00:09:54.038001  /lava-994523/bin/lava-test-runner /lava-994=
523/1
    2023-08-09T00:09:54.059369  . /lava-994523/environment
    2023-08-09T00:09:54.059608  / # /lava-994523/bin/lava-test-runner /lava=
-994523/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2da78a8d2b5627135b1dd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2da78a8d2b5627135b1e0
        failing since 12 days (last pass: v5.10.182-cip35-289-g3c0549540706=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-09T00:14:17.263863  + set +x
    2023-08-09T00:14:17.264089  <8>[   83.970610] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 994512_1.5.2.4.1>
    2023-08-09T00:14:17.369717  / # #
    2023-08-09T00:14:18.831931  export SHELL=3D/bin/sh
    2023-08-09T00:14:18.852472  #
    2023-08-09T00:14:18.852689  / # export SHELL=3D/bin/sh
    2023-08-09T00:14:20.734801  / # . /lava-994512/environment
    2023-08-09T00:14:24.184346  /lava-994512/bin/lava-test-runner /lava-994=
512/1
    2023-08-09T00:14:24.205008  . /lava-994512/environment
    2023-08-09T00:14:24.205140  / # /lava-994512/bin/lava-test-runner /lava=
-994512/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2d8fb91343b42c135b24b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2d8fb91343b42c135b24e
        failing since 12 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-09T00:08:08.367588  / # #
    2023-08-09T00:08:09.828418  export SHELL=3D/bin/sh
    2023-08-09T00:08:09.848875  #
    2023-08-09T00:08:09.849046  / # export SHELL=3D/bin/sh
    2023-08-09T00:08:11.731472  / # . /lava-994507/environment
    2023-08-09T00:08:15.182768  /lava-994507/bin/lava-test-runner /lava-994=
507/1
    2023-08-09T00:08:15.203337  . /lava-994507/environment
    2023-08-09T00:08:15.203434  / # /lava-994507/bin/lava-test-runner /lava=
-994507/1
    2023-08-09T00:08:15.382168  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-09T00:08:15.382390  + cd /lava-994507/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2d9d7618000d4d635b1f6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2d9d7618000d4d635b1f9
        failing since 12 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-09T00:11:46.267546  / # #
    2023-08-09T00:11:47.727265  export SHELL=3D/bin/sh
    2023-08-09T00:11:47.747738  #
    2023-08-09T00:11:47.747896  / # export SHELL=3D/bin/sh
    2023-08-09T00:11:49.630563  / # . /lava-994510/environment
    2023-08-09T00:11:53.085276  /lava-994510/bin/lava-test-runner /lava-994=
510/1
    2023-08-09T00:11:53.105878  . /lava-994510/environment
    2023-08-09T00:11:53.105986  / # /lava-994510/bin/lava-test-runner /lava=
-994510/1
    2023-08-09T00:11:53.182778  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-09T00:11:53.182998  + cd /lava-994510/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2dade3f859d851835b1f4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2dade3f859d851835b1f7
        failing since 12 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-09T00:16:18.845732  / # #
    2023-08-09T00:16:20.305272  export SHELL=3D/bin/sh
    2023-08-09T00:16:20.325718  #
    2023-08-09T00:16:20.325884  / # export SHELL=3D/bin/sh
    2023-08-09T00:16:22.208076  / # . /lava-994524/environment
    2023-08-09T00:16:25.661481  /lava-994524/bin/lava-test-runner /lava-994=
524/1
    2023-08-09T00:16:25.682052  . /lava-994524/environment
    2023-08-09T00:16:25.682167  / # /lava-994524/bin/lava-test-runner /lava=
-994524/1
    2023-08-09T00:16:25.864258  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-09T00:16:25.864459  + cd /lava-994524/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2dbe01f32bbaf1e35b1fa

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig/gcc-10/lab-=
cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig/gcc-10/lab-=
cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2dbe01f32bbaf1e35b1fd
        failing since 12 days (last pass: v5.10.182-cip35-289-g3c0549540706=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-09T00:20:35.285881  / # #
    2023-08-09T00:20:36.748855  export SHELL=3D/bin/sh
    2023-08-09T00:20:36.769430  #
    2023-08-09T00:20:36.769638  / # export SHELL=3D/bin/sh
    2023-08-09T00:20:38.655284  / # . /lava-994532/environment
    2023-08-09T00:20:42.113495  /lava-994532/bin/lava-test-runner /lava-994=
532/1
    2023-08-09T00:20:42.134392  . /lava-994532/environment
    2023-08-09T00:20:42.134503  / # /lava-994532/bin/lava-test-runner /lava=
-994532/1
    2023-08-09T00:20:42.214703  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-09T00:20:42.214922  + cd /lava-994532/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2d82b87234c987d35b23b

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig/gcc-10/lab-=
collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig/gcc-10/lab-=
collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2d82b87234c987d35b240
        failing since 12 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-09T00:06:07.604071  / # #

    2023-08-09T00:06:07.704551  export SHELL=3D/bin/sh

    2023-08-09T00:06:07.704672  #

    2023-08-09T00:06:07.805147  / # export SHELL=3D/bin/sh. /lava-11238322/=
environment

    2023-08-09T00:06:07.805263  =


    2023-08-09T00:06:07.905754  / # . /lava-11238322/environment/lava-11238=
322/bin/lava-test-runner /lava-11238322/1

    2023-08-09T00:06:07.905944  =


    2023-08-09T00:06:07.912739  / # /lava-11238322/bin/lava-test-runner /la=
va-11238322/1

    2023-08-09T00:06:07.972110  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-09T00:06:07.972186  + cd /lav<8>[   16.415018] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11238322_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2d83e1e6c576c2d35b365

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig+kselftest/g=
cc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig+kselftest/g=
cc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2d83e1e6c576c2d35b36a
        failing since 12 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-09T00:06:32.463673  / # #

    2023-08-09T00:06:32.565599  export SHELL=3D/bin/sh

    2023-08-09T00:06:32.566280  #

    2023-08-09T00:06:32.667470  / # export SHELL=3D/bin/sh. /lava-11238316/=
environment

    2023-08-09T00:06:32.667733  =


    2023-08-09T00:06:32.768441  / # . /lava-11238316/environment/lava-11238=
316/bin/lava-test-runner /lava-11238316/1

    2023-08-09T00:06:32.769395  =


    2023-08-09T00:06:32.772508  / # /lava-11238316/bin/lava-test-runner /la=
va-11238316/1

    2023-08-09T00:06:32.885600  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-09T00:06:32.886087  + cd /lava-11238316/1/tests/1_bootrr
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64d2d969aaf6796dce35b28a

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64d2d969aaf6796dce35b290
        failing since 110 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-09T00:10:38.459166  <8>[   33.891624] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-08-09T00:10:39.483147  /lava-11238309/1/../bin/lava-test-case

    2023-08-09T00:10:39.494295  <8>[   34.928360] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64d2d969aaf6796dce35b291
        failing since 110 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-09T00:10:38.446981  /lava-11238309/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/64d2d97db9e20ed6b735b1f9

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64d2d97db9e20ed6b735b1ff
        failing since 110 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-09T00:10:44.643948  /lava-11238292/1/../bin/lava-test-case

    2023-08-09T00:10:44.669093  <8>[   44.383911] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64d2d97db9e20ed6b735b200
        failing since 110 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-09T00:10:43.556864  /lava-11238292/1/../bin/lava-test-case

    2023-08-09T00:10:43.582219  <8>[   43.296849] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2d9420839279c4135b1e5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d2d9420839279c4135b1ea
        failing since 12 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-09T00:10:54.680055  / # #

    2023-08-09T00:10:54.780737  export SHELL=3D/bin/sh

    2023-08-09T00:10:54.781396  #

    2023-08-09T00:10:54.882407  / # export SHELL=3D/bin/sh. /lava-11238325/=
environment

    2023-08-09T00:10:54.882538  =


    2023-08-09T00:10:54.983300  / # . /lava-11238325/environment/lava-11238=
325/bin/lava-test-runner /lava-11238325/1

    2023-08-09T00:10:54.983587  =


    2023-08-09T00:10:54.993999  / # /lava-11238325/bin/lava-test-runner /la=
va-11238325/1

    2023-08-09T00:10:55.057139  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-09T00:10:55.057521  + cd /lava-1123832<8>[   18.346835] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11238325_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

