Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B55C6379F
	for <webhook@archiver.kernel.org>; Sat, 14 Jan 2023 03:00:19 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web11.108486.1673665217478152277
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 13 Jan 2023 19:00:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=7KrwkIvL;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id 20so12044423pfu.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 13 Jan 2023 19:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=20v26R2OJHBbZNB6C4OL0QttDAGtuiTrRFADkabVj7Q=;
        b=7KrwkIvLX2ykbZSrLw4G60Y8ClBiDWoZIri6u1A6BfKCZaUNqZKmMXOThCsMw8Q7AV
         VAxElgQkEdqQrZHJiIN/tE+KtsNvK7n1RjspuXQhCFbwZcZsmAI7aPKS4R4yCO3D4JkZ
         oPxxwrAKooD6AgmGhz2aY1V0uAloOfr1v1sjaMTWDrj3dnmt8C8sg/UOyVwWDfsDrZg6
         t/pLMhb12XCI67/d2xQm+Ukyc5n/eA4+WRflt4wuwf/6DohecyqMf9OJbfvaKZwSTefb
         dAzjBc1dmVnp1f1QrR6TEMZ0YrW4pMcBjiaR7ckL/sxAWKJ4Kw+Ef286Ns5VxpMwp/me
         6pcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=20v26R2OJHBbZNB6C4OL0QttDAGtuiTrRFADkabVj7Q=;
        b=wRwTvrwEx8aqrd+zvLcAA+Or9BFcq7P5g2ej9fBgunL2AjpUc414Nd4NtIfELvctd8
         IWuTh+dxeV2/hB1nTOZYE3OPKrVL7Sm4D23nlHs6OdRfWGGtb+jeVugxekq7rRtHLtCY
         m6+CleWs3MO4aXbg+FNE6nhAYLUplbacCcrzDES+kKU9Aer51v3NBxjCf3U93cG8dNHe
         3R1qzwvK0gcvCcisSXRnbRu5BWhYW2ZVC+UMVFvT/Ej4BieP8K5vy82OESFpLBWqhiGz
         P216zGtILqZHXVwHqoMD3Lh4cl4w3qJmQWS0Z6C+/hGCz4R/N5ix6+JZ3ev34oBOm+Jq
         YliQ==
X-Gm-Message-State: AFqh2kqUIaCuwbBvA5xQHLYkDkr/ZsiVcm1m0OP6KByU1Ga4NfeGdMp1
	hF4/2z/wELvHr3ss/r8dhdmOm831+l+ZpX8MbOg=
X-Google-Smtp-Source: AMrXdXt2/6hijb8L4wg7iXAaj0W1S0XXbHYdWAb2Bw54plqN9cmd0AKUCz9NZOgKzFhyXPOwzdtVkQ==
X-Received: by 2002:a62:1c8d:0:b0:58a:541a:8b6f with SMTP id c135-20020a621c8d000000b0058a541a8b6fmr15447183pfc.10.1673665216431;
        Fri, 13 Jan 2023 19:00:16 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s62-20020a625e41000000b00580a0bb411fsm13701639pfb.174.2023.01.13.19.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 19:00:15 -0800 (PST)
Message-ID: <63c21abf.620a0220.8f8f5.6f4b@mx.google.com>
Date: Fri, 13 Jan 2023 19:00:15 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.162-cip24
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-nfs: 33 runs,
 12 regressions (v5.10.162-cip24)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 14 Jan 2023 03:00:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10352

cip/linux-5.10.y-cip baseline-nfs: 33 runs, 12 regressions (v5.10.162-cip24)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

at91sam9g20ek             | arm    | lab-broonie   | gcc-10   | multi_v5_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 5          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.162-cip24/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.162-cip24
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7ef5f1fda52a95426084959dac09acdb3c81327b =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c20de4743284d14c1d3a20

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230109.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c20de4743284d14c1d3a25
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-14T02:05:16.301889  [   17.665102] <LAVA_SIGNAL_ENDRUN 0_dmesg =
8713823_1.5.2.3.1>
    2023-01-14T02:05:16.302442  + set +x
    2023-01-14T02:05:16.306253  =

    2023-01-14T02:05:16.417742  / # #
    2023-01-14T02:05:16.520602  export SHELL=3D/bin/sh
    2023-01-14T02:05:16.521449  #
    2023-01-14T02:05:16.623424  / # export SHELL=3D/bin/sh. /lava-8713823/e=
nvironment
    2023-01-14T02:05:16.624300  =

    2023-01-14T02:05:16.726202  / # . /lava-8713823/environment/lava-871382=
3/bin/lava-test-runner /lava-8713823/1
    2023-01-14T02:05:16.727620   =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c20dcfb2afcb23c31d39d8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230109.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c20dcfb2afcb23c31d39dd
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-14T02:04:53.269041  + set<8>[   14.039955] <LAVA_SIGNAL_ENDRUN =
0_dmesg 8713793_1.5.2.3.1>
    2023-01-14T02:04:53.269135   +x
    2023-01-14T02:04:53.373419  <6>[   14.047791] lava-test-ru#
    2023-01-14T02:04:53.373721  nne (267) used greatest stack depth: 13016 =
bytes left
    2023-01-14T02:04:53.474716  / # #export SHELL=3D/bin/sh
    2023-01-14T02:04:53.474957  =

    2023-01-14T02:04:53.575697  / # export SHELL=3D/bin/sh. /lava-8713793/e=
nvironment
    2023-01-14T02:04:53.575912  =

    2023-01-14T02:04:53.676793  / # . /lava-8713793/environment/lava-871379=
3/bin/lava-test-runner /lava-8713793/1
    2023-01-14T02:04:53.677117   =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c20de4b3d305fb0b1d39dc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230109.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c20de4b3d305fb0b1d39e1
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-14T02:05:01.081017  + set +x
    2023-01-14T02:05:01.087475  [   18.125826] <LAVA_SIGNAL_ENDRUN 0_dmesg =
8713763_1.5.2.3.1>
    2023-01-14T02:05:01.197393  / # #
    2023-01-14T02:05:01.298413  export SHELL=3D/bin/sh
    2023-01-14T02:05:01.298653  #
    2023-01-14T02:05:01.399569  / # export SHELL=3D/bin/sh. /lava-8713763/e=
nvironment
    2023-01-14T02:05:01.399799  =

    2023-01-14T02:05:01.500710  / # . /lava-8713763/environment/lava-871376=
3/bin/lava-test-runner /lava-8713763/1
    2023-01-14T02:05:01.501032  =

    2023-01-14T02:05:01.505937  / # /lava-8713763/bin/lava-test-runner /lav=
a-8713763/1 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
at91sam9g20ek             | arm    | lab-broonie   | gcc-10   | multi_v5_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c20e2e18d7e014b01d39e7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20ek=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20ek=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230109.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c20e2e18d7e014b01d39ec
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-14T02:06:27.491874  + set +x
    2023-01-14T02:06:27.496915  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 109975_1.6.2=
.4.1>
    2023-01-14T02:06:27.617297  #
    2023-01-14T02:06:27.720580  / # #export SHELL=3D/bin/sh
    2023-01-14T02:06:27.721427  =

    2023-01-14T02:06:27.823341  / # export SHELL=3D/bin/sh. /lava-109975/en=
vironment
    2023-01-14T02:06:27.824104  =

    2023-01-14T02:06:27.926319  / # . /lava-109975/environment/lava-109975/=
bin/lava-test-runner /lava-109975/1
    2023-01-14T02:06:27.927760  =

    2023-01-14T02:06:27.934517  / # /lava-109975/bin/lava-test-runner /lava=
-109975/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c2115efff40942ee1d39ce

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230109.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c2115efff40942ee1d39d3
        new failure (last pass: v5.10.158-cip22)

    2023-01-14T02:20:00.854303  + set +x
    2023-01-14T02:20:00.858218  <8>[   52.253731] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 110078_1.6.2.4.1>
    2023-01-14T02:20:00.984543  / # #
    2023-01-14T02:20:01.087681  export SHELL=3D/bin/sh
    2023-01-14T02:20:01.088577  #
    2023-01-14T02:20:01.190579  / # export SHELL=3D/bin/sh. /lava-110078/en=
vironment
    2023-01-14T02:20:01.191487  =

    2023-01-14T02:20:01.293574  / # . /lava-110078/environment/lava-110078/=
bin/lava-test-runner /lava-110078/1
    2023-01-14T02:20:01.294978  =

    2023-01-14T02:20:01.299343  / # /lava-110078/bin/lava-test-runner /lava=
-110078/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c210c7620133174f1d3a13

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230109.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c210c7620133174f1d3a18
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-14T02:17:18.032952  + set<8>[   30.186164] <LAVA_SIGNAL_ENDRUN =
0_dmesg 8713928_1.6.2.4.1>
    2023-01-14T02:17:18.033399   +x
    2023-01-14T02:17:18.147727  #
    2023-01-14T02:17:18.250776  / # #export SHELL=3D/bin/sh
    2023-01-14T02:17:18.251264  =

    2023-01-14T02:17:18.352606  / # export SHELL=3D/bin/sh. /lava-8713928/e=
nvironment
    2023-01-14T02:17:18.353219  =

    2023-01-14T02:17:18.454570  / # . /lava-8713928/environment/lava-871392=
8/bin/lava-test-runner /lava-8713928/1
    2023-01-14T02:17:18.455329  =

    2023-01-14T02:17:18.457432  / # /lava-8713928/bin/lava-test-runner /lav=
a-8713928/1 =

    ... (16 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/63c2153b35b3801af71d39c3

  Results:     86 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230109.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/63c2153b35b3801af71d39e5
        failing since 290 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2023-01-14T02:36:30.041834  /lava-8713893/1/../bin/lava-test-case
    2023-01-14T02:36:30.076769  <8>[   35.708920] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-rt5514-present: https://ker=
nelci.org/test/case/id/63c2153b35b3801af71d39fa
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-14T02:36:27.310487  <8>[   32.938727] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-max98357A-present RESULT=3Dfail>
    2023-01-14T02:36:27.338633  seq: invalid floating point argument: =E2=
=80=98sound/RT5514=E2=80=99
    2023-01-14T02:36:27.342342  Try 'seq --help' for more information.
    2023-01-14T02:36:27.345863  /lava-8713893/1/../bin/lava-test-case
    2023-01-14T02:36:27.375820  <8>[   33.006051] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-rt5514-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-max98357A-present: https://=
kernelci.org/test/case/id/63c2153b35b3801af71d39fb
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-14T02:36:27.272595  seq: invalid floating point argument: =E2=
=80=98sound/MAX98357A=E2=80=99
    2023-01-14T02:36:27.276613  Try 'seq --help' for more information.
    2023-01-14T02:36:27.280272  /lava-8713893/1/../bin/lava-test-case   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelc=
i.org/test/case/id/63c2153b35b3801af71d39fc
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-14T02:36:27.171468  =

    2023-01-14T02:36:27.201318  seq: invalid floating point argument: =E2=
=80=98sound/DP=E2=80=99
    2023-01-14T02:36:27.205066  Try 'seq --help' for more information.
    2023-01-14T02:36:27.208965  /lava-8713893/1/../bin/lava-test-case
    2023-01-14T02:36:27.237328  <8>[   32.867750] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-da7219-present: https://ker=
nelci.org/test/case/id/63c2153b35b3801af71d39fd
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-14T02:36:27.130818  seq: invalid floating point argument: =E2=
=80=98sound/DA7219=E2=80=99
    2023-01-14T02:36:27.131694  =

    2023-01-14T02:36:27.134806  Try 'seq --help' for more information.
    2023-01-14T02:36:27.138553  /lava-8713893/1/../bin/lava-test-case
    2023-01-14T02:36:27.169384  <8>[   32.799823] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>   =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/63c21062aee409d8fe1d39d2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-pine64-pl=
us.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-pine64-pl=
us.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230109.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63c21062aee409d8fe1d39d7
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-14T02:15:54.485806  <8>[   29.983572] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 110044_1.6.2.4.1>
    2023-01-14T02:15:54.601633  / # #
    2023-01-14T02:15:54.704729  export SHELL=3D/bin/sh
    2023-01-14T02:15:54.705587  #
    2023-01-14T02:15:54.807868  / # export SHELL=3D/bin/sh. /lava-110044/en=
vironment
    2023-01-14T02:15:54.808499  =

    2023-01-14T02:15:54.910084  / # . /lava-110044/environment/lava-110044/=
bin/lava-test-runner /lava-110044/1
    2023-01-14T02:15:54.910881  =

    2023-01-14T02:15:54.914851  / # /lava-110044/bin/lava-test-runner /lava=
-110044/1
    2023-01-14T02:15:55.042523  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

