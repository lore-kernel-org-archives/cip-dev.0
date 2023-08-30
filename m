Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5027DC83F14
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 20:08:01 +0000 (UTC)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
 by mx.groups.io with SMTP id smtpd.web10.614.1693426080112521141
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 30 Aug 2023 13:08:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=N8HVr4t2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.45, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1c4c6717e61so4244973fac.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 30 Aug 2023 13:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693426079; x=1694030879; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wHlbTiUjDtVihRGSNPWXIsyVu7OQq5rLWP6CiXu9oRg=;
        b=N8HVr4t2T8EnWqJLARgu+g3wWMoy6cPp+ltukVPxjPVCBzoiHJ7kymXwbHJTCxVaPd
         DGdT+Jgnn4wr9cODmONgF+1ok13slKTRbgSq7vgOmCETquj2X6JhNwjIvOHnpBRDdrTr
         8EZVLg7Wo1ir/MoKhAyJm5jThEU+P5hPxZBiudCBE6zzNeBkgHnBIqQEg75ULQP2IVeT
         dfs3J+2+fBrVOCrHIIHWGFFjGyqpUTptEeNXhU/CJ8kT7YehZJSh4oLntx2IqpAIZTZq
         MlcGRKEOMEu+UlfrTjlmiTLMIbrGZw59az85h20Ktzd+Zs1kWwhTQPByO/rnmQEQa3NY
         OZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693426079; x=1694030879;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHlbTiUjDtVihRGSNPWXIsyVu7OQq5rLWP6CiXu9oRg=;
        b=NxRbjusMyzcYN4CWR5NDxyRgWePjF62lVw5js4x38hph2zXnZKlNdgZh3UPkja/dk9
         1t5p5G1n/U+iNhJ/Eba/JBji+NGH+wJFy4ykfuqd9tUI1UlvaxW3tpsBjOcR7+2elTXh
         avI6oKzTbvE5mZcwtnWXK95kghQgGTJ2oNtQsJyLXEKsK8LIEl+12iOoZM/2fnVnYXZN
         nrerrkaGB0rBVh0/DVqisWKiiXt9kojJtJMFtrWMl6livilTdyucciNrX9ThMf+dxiOX
         dzyrCNr3fWwZpCDM7iavf0fQmY/XrhArPOjdxk5qX11uBf7uJZYeR/RzexT7qEPlrRci
         jDFw==
X-Gm-Message-State: AOJu0YyOuC/4ryzqcWNEaS4X0TFn5tnlqQu+3DFq/njJ0aKbX2WzZXk/
	7NaUIC4wxYWA1Bcf+E+qDeQq22VLvl2CHeSzIIs=
X-Google-Smtp-Source: AGHT+IEiXxYkAnp/lH6/nfRRxvSUylJzJXweNhx+OlGyZ1WzQV9t16dFnNSLu6xrb/SmUXf4/shKLQ==
X-Received: by 2002:a05:6870:e88f:b0:1bf:4a66:d550 with SMTP id q15-20020a056870e88f00b001bf4a66d550mr3474173oan.52.1693426078455;
        Wed, 30 Aug 2023 13:07:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q30-20020a638c5e000000b005637030d00csm10867987pgn.30.2023.08.30.13.07.57
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 13:07:57 -0700 (PDT)
Message-ID: <64efa19d.630a0220.3c292.0e54@mx.google.com>
Date: Wed, 30 Aug 2023 13:07:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.191-cip38-218-g9947ff6f0dba7
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 139 runs,
 14 regressions (v5.10.191-cip38-218-g9947ff6f0dba7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Aug 2023 20:08:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12922

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 139 runs, 14 regressio=
ns (v5.10.191-cip38-218-g9947ff6f0dba7)

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
efcon...ok+kselftest | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.191-cip38-218-g9947ff6f0dba7/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.191-cip38-218-g9947ff6f0dba7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      9947ff6f0dba77de14d710cf958ecb42c2f4c10f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef940ba2e4eb65ae286d6f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/arm/bcm2835_defconfig/gcc-1=
0/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/arm/bcm2835_defconfig/gcc-1=
0/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef940ba2e4eb65ae286d78
        failing since 34 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-30T19:11:19.754795  / # #

    2023-08-30T19:11:19.856977  export SHELL=3D/bin/sh

    2023-08-30T19:11:19.857682  #

    2023-08-30T19:11:19.959092  / # export SHELL=3D/bin/sh. /lava-11386074/=
environment

    2023-08-30T19:11:19.959800  =


    2023-08-30T19:11:20.061164  / # . /lava-11386074/environment/lava-11386=
074/bin/lava-test-runner /lava-11386074/1

    2023-08-30T19:11:20.062358  =


    2023-08-30T19:11:20.063518  / # /lava-11386074/bin/lava-test-runner /la=
va-11386074/1

    2023-08-30T19:11:20.143767  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-30T19:11:20.186650  + cd /lava-11386074/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef92527787852d80286d6c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef92527787852d80286da6
        failing since 238 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-08-30T19:02:22.654749  + set +x
    2023-08-30T19:02:22.664017  <8>[   19.289818] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 79751_1.5.2.4.1>
    2023-08-30T19:02:22.770619  / # #
    2023-08-30T19:02:22.873836  export SHELL=3D/bin/sh
    2023-08-30T19:02:22.874574  #
    2023-08-30T19:02:22.976857  / # export SHELL=3D/bin/sh. /lava-79751/env=
ironment
    2023-08-30T19:02:22.977604  =

    2023-08-30T19:02:23.079970  / # . /lava-79751/environment/lava-79751/bi=
n/lava-test-runner /lava-79751/1
    2023-08-30T19:02:23.081249  =

    2023-08-30T19:02:23.084993  / # /lava-79751/bin/lava-test-runner /lava-=
79751/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef92475b16beb062286da5

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef92475b16beb062286da8
        failing since 238 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-08-30T19:02:19.619265  + set +x
    2023-08-30T19:02:19.621317  <8>[   13.974114] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1003035_1.5.2.4.1>
    2023-08-30T19:02:19.730293  / # #
    2023-08-30T19:02:19.832163  export SHELL=3D/bin/sh
    2023-08-30T19:02:19.832629  #
    2023-08-30T19:02:19.934026  / # export SHELL=3D/bin/sh. /lava-1003035/e=
nvironment
    2023-08-30T19:02:19.934476  =

    2023-08-30T19:02:20.035903  / # . /lava-1003035/environment/lava-100303=
5/bin/lava-test-runner /lava-1003035/1
    2023-08-30T19:02:20.036651  =

    2023-08-30T19:02:20.038915  / # /lava-1003035/bin/lava-test-runner /lav=
a-1003035/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef974e87462469de286da1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4=
020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4=
020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef974e87462469de286daa
        failing since 132 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-30T19:23:54.163364  + set +x<8>[   15.931424] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11386100_1.4.2.3.1>

    2023-08-30T19:23:54.163457  =


    2023-08-30T19:23:54.267750  / # #

    2023-08-30T19:23:54.368329  export SHELL=3D/bin/sh

    2023-08-30T19:23:54.368509  #

    2023-08-30T19:23:54.469020  / # export SHELL=3D/bin/sh. /lava-11386100/=
environment

    2023-08-30T19:23:54.469200  =


    2023-08-30T19:23:54.569854  / # . /lava-11386100/environment/lava-11386=
100/bin/lava-test-runner /lava-11386100/1

    2023-08-30T19:23:54.570124  =


    2023-08-30T19:23:54.574654  / # /lava-11386100/bin/lava-test-runner /la=
va-11386100/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef98a2671833b3e0286d86

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopu=
s.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopu=
s.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef98a2671833b3e0286d8f
        failing since 132 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-30T19:29:25.412004  + set +x

    2023-08-30T19:29:25.418655  <8>[   10.506235] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11386144_1.4.2.3.1>

    2023-08-30T19:29:25.523457  / # #

    2023-08-30T19:29:25.624011  export SHELL=3D/bin/sh

    2023-08-30T19:29:25.624206  #

    2023-08-30T19:29:25.724699  / # export SHELL=3D/bin/sh. /lava-11386144/=
environment

    2023-08-30T19:29:25.724879  =


    2023-08-30T19:29:25.825383  / # . /lava-11386144/environment/lava-11386=
144/bin/lava-test-runner /lava-11386144/1

    2023-08-30T19:29:25.825707  =


    2023-08-30T19:29:25.830131  / # /lava-11386144/bin/lava-test-runner /la=
va-11386144/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef974527302d06e7286d89

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef974527302d06e7286d92
        failing since 132 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-30T19:23:29.648915  + <8>[   14.114974] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11386086_1.4.2.3.1>

    2023-08-30T19:23:29.649001  set +x

    2023-08-30T19:23:29.750147  #

    2023-08-30T19:23:29.850967  / # #export SHELL=3D/bin/sh

    2023-08-30T19:23:29.851141  =


    2023-08-30T19:23:29.951670  / # export SHELL=3D/bin/sh. /lava-11386086/=
environment

    2023-08-30T19:23:29.951840  =


    2023-08-30T19:23:30.052332  / # . /lava-11386086/environment/lava-11386=
086/bin/lava-test-runner /lava-11386086/1

    2023-08-30T19:23:30.052593  =


    2023-08-30T19:23:30.057511  / # /lava-11386086/bin/lava-test-runner /la=
va-11386086/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef98a657fc6355e6286e2e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef98a657fc6355e6286e37
        failing since 132 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-30T19:29:26.468158  <8>[   11.971034] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11386165_1.4.2.3.1>

    2023-08-30T19:29:26.471407  + set +x

    2023-08-30T19:29:26.572705  #

    2023-08-30T19:29:26.572936  =


    2023-08-30T19:29:26.673450  / # #export SHELL=3D/bin/sh

    2023-08-30T19:29:26.673638  =


    2023-08-30T19:29:26.774141  / # export SHELL=3D/bin/sh. /lava-11386165/=
environment

    2023-08-30T19:29:26.774324  =


    2023-08-30T19:29:26.874851  / # . /lava-11386165/environment/lava-11386=
165/bin/lava-test-runner /lava-11386165/1

    2023-08-30T19:29:26.875192  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8f41a13f1da6b6286d92

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/arm64/defconfig/gcc-10/lab-=
broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/arm64/defconfig/gcc-10/lab-=
broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef8f41a13f1da6b6286dd1
        failing since 34 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-30T18:49:04.943016  / # #
    2023-08-30T18:49:05.045836  export SHELL=3D/bin/sh
    2023-08-30T18:49:05.046656  #
    2023-08-30T18:49:05.148593  / # export SHELL=3D/bin/sh. /lava-79721/env=
ironment
    2023-08-30T18:49:05.149349  =

    2023-08-30T18:49:05.251375  / # . /lava-79721/environment/lava-79721/bi=
n/lava-test-runner /lava-79721/1
    2023-08-30T18:49:05.252633  =

    2023-08-30T18:49:05.266689  / # /lava-79721/bin/lava-test-runner /lava-=
79721/1
    2023-08-30T18:49:05.325557  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-30T18:49:05.326090  + cd /lava-79721/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef9365322581014d286d7f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ef9365322581014d286=
d80
        failing since 4 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4c8=
, first fail: v5.10.186-cip37-982-g80a0585c0aa62) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8efa9a26c9c007286da7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/arm64/defconfig/gcc-10/lab-=
cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/arm64/defconfig/gcc-10/lab-=
cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef8efa9a26c9c007286daa
        new failure (last pass: v5.10.180-cip33-21-g090289427e8b2)

    2023-08-30T18:48:06.793140  + set +x
    2023-08-30T18:48:06.793710  <8>[   84.047304] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1003023_1.5.2.4.1>
    2023-08-30T18:48:06.901870  / # #
    2023-08-30T18:48:08.373317  export SHELL=3D/bin/sh
    2023-08-30T18:48:08.394633  #
    2023-08-30T18:48:08.395337  / # export SHELL=3D/bin/sh
    2023-08-30T18:48:10.360844  / # . /lava-1003023/environment
    2023-08-30T18:48:13.977493  /lava-1003023/bin/lava-test-runner /lava-10=
03023/1
    2023-08-30T18:48:13.999395  . /lava-1003023/environment
    2023-08-30T18:48:13.999839  / # /lava-1003023/bin/lava-test-runner /lav=
a-1003023/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8f69408f2c700b286d71

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/arm64/defconfig/gcc-10/lab-=
cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/arm64/defconfig/gcc-10/lab-=
cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef8f69408f2c700b286d74
        failing since 34 days (last pass: v5.10.182-cip35-289-g3c0549540706=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-30T18:49:47.990272  / # #
    2023-08-30T18:49:49.450740  export SHELL=3D/bin/sh
    2023-08-30T18:49:49.471235  #
    2023-08-30T18:49:49.471437  / # export SHELL=3D/bin/sh
    2023-08-30T18:49:51.425335  / # . /lava-1003029/environment
    2023-08-30T18:49:55.020400  /lava-1003029/bin/lava-test-runner /lava-10=
03029/1
    2023-08-30T18:49:55.041122  . /lava-1003029/environment
    2023-08-30T18:49:55.041230  / # /lava-1003029/bin/lava-test-runner /lav=
a-1003029/1
    2023-08-30T18:49:55.117625  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-30T18:49:55.117840  + cd /lava-1003029/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8ea7078bc2134a286e1b

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/arm64/defconfig/gcc-10/lab-=
collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/arm64/defconfig/gcc-10/lab-=
collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef8ea7078bc2134a286e24
        failing since 34 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-30T18:48:21.075422  / # #

    2023-08-30T18:48:21.177578  export SHELL=3D/bin/sh

    2023-08-30T18:48:21.178266  #

    2023-08-30T18:48:21.279660  / # export SHELL=3D/bin/sh. /lava-11386042/=
environment

    2023-08-30T18:48:21.280403  =


    2023-08-30T18:48:21.381895  / # . /lava-11386042/environment/lava-11386=
042/bin/lava-test-runner /lava-11386042/1

    2023-08-30T18:48:21.382976  =


    2023-08-30T18:48:21.399715  / # /lava-11386042/bin/lava-test-runner /la=
va-11386042/1

    2023-08-30T18:48:21.448108  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-30T18:48:21.448564  + cd /lav<8>[   16.394534] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11386042_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8ec49a26c9c007286d6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/arm64/defconfig/gcc-10/lab-=
collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/arm64/defconfig/gcc-10/lab-=
collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef8ec49a26c9c007286d75
        failing since 4 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4c8=
, first fail: v5.10.186-cip37-982-g80a0585c0aa62)

    2023-08-30T18:47:10.566767  / # #

    2023-08-30T18:47:11.821341  export SHELL=3D/bin/sh

    2023-08-30T18:47:11.831618  #

    2023-08-30T18:47:11.831709  / # export SHELL=3D/bin/sh

    2023-08-30T18:47:13.567532  / # . /lava-11386050/environment

    2023-08-30T18:47:16.758527  /lava-11386050/bin/lava-test-runner /lava-1=
1386050/1

    2023-08-30T18:47:16.768903  . /lava-11386050/environment

    2023-08-30T18:47:16.775224  / # /lava-11386050/bin/lava-test-runner /la=
va-11386050/1

    2023-08-30T18:47:16.791069  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-30T18:47:16.824097  + cd /lava-11386050/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8ebb078bc2134a286e5d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ef8ebb078bc2134a286e66
        failing since 34 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-08-30T18:48:38.935314  / # #

    2023-08-30T18:48:39.037432  export SHELL=3D/bin/sh

    2023-08-30T18:48:39.038128  #

    2023-08-30T18:48:39.139488  / # export SHELL=3D/bin/sh. /lava-11386053/=
environment

    2023-08-30T18:48:39.140185  =


    2023-08-30T18:48:39.241635  / # . /lava-11386053/environment/lava-11386=
053/bin/lava-test-runner /lava-11386053/1

    2023-08-30T18:48:39.242693  =


    2023-08-30T18:48:39.259769  / # /lava-11386053/bin/lava-test-runner /la=
va-11386053/1

    2023-08-30T18:48:39.301462  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-30T18:48:39.317593  + cd /lava-1138605<8>[   18.217152] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11386053_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

