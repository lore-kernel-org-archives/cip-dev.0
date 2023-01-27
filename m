Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBCAC05027
	for <webhook@archiver.kernel.org>; Fri, 27 Jan 2023 01:56:07 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web10.92979.1674784565989628944
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 26 Jan 2023 17:56:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=B18qflQp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.176, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f176.google.com with SMTP id v3so2343955pgh.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 26 Jan 2023 17:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7K1QWbsf75ZitJs8UGq0b6Yac0UacqVf49fbfsVxHV8=;
        b=B18qflQpblZGSb00msGsaD83UuLX0a3zWi8O4imTfmE76lD6KIrHfdR+zlZqhBf8zQ
         veerggXGcCaM8sSw+THnjL4CU9KP9u0SIzCm+8SAaAKzrqzdjQ/EY6f9+LUK/ub2QWKG
         zL7T06s6EfyESdFGOidsTFGrkCqJQO+vHNBBZSFUcmq8ytE8VvHxUgSSTqKVIngfH4Jb
         EH52nyzpD//ly+9jPmQreOlC1CGrty2TyvWemH+N/HESpZTpBzt8h61e3nvoUd6+x0H4
         AJMRaMhmbEgUW8oHCcSvX8hL/tmfObuYnO0I3Vud3047e6i1mXKJgECzroWYLftfTsRh
         6K7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7K1QWbsf75ZitJs8UGq0b6Yac0UacqVf49fbfsVxHV8=;
        b=sI5M/3JO/cZ9wYpwLU+wX1zUac00AjINGaI1QtT7IhdS7YUEOSW/gaesvVZCx5fb9x
         Wzrt2jii4R9HWMKEwxYvzMTeD7QpR1jIpSgASUyeyKcUUJA953mfsVBbWtiLa9Inm7Ql
         +6mhqtreXQgS9f/Yu0ua8YXet8DjRKkV+fd88xmKXc4zR+a2/qAUCwpgiyzUxhyjgHWe
         nL1GLMA23pg6MTqIpq4SsrDtpq5lPMhdmdka0XrGBNxV/8ArX1v3Ifd5un7zNUzwgf8t
         x/O5jf3SoNr4tYgRd+ORAzRiL1QiFP8vWTLaBmRWdAtUfvKd9b+h44IOICrXN/EFaFi1
         0SpA==
X-Gm-Message-State: AO0yUKUlz0ObQBs/5+BnUYub82ofmeNNuCP/XKpmg/7j3bgCThtVWqpf
	p3A3gIUCKiJRfLfXYjxKeua13KC1qfBSY2D9v143Dg==
X-Google-Smtp-Source: AK7set/c7UF6touJMJAVowEUM/DibHcd2tQCcWUoSM2n3SkQ6vMUsYN9PRN4PHE4MLWmQ7PiCbtz7g==
X-Received: by 2002:a62:17c7:0:b0:590:77d3:1fdc with SMTP id 190-20020a6217c7000000b0059077d31fdcmr5459724pfx.10.1674784564623;
        Thu, 26 Jan 2023 17:56:04 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h8-20020a056a00230800b0058e08796e98sm1440230pfh.196.2023.01.26.17.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 17:56:04 -0800 (PST)
Message-ID: <63d32f34.050a0220.e9ed4.2b5d@mx.google.com>
Date: Thu, 26 Jan 2023 17:56:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.162-cip24-rt10
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt baseline-nfs: 76 runs,
 20 regressions (v5.10.162-cip24-rt10)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Jan 2023 01:56:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10491

cip/linux-5.10.y-cip-rt baseline-nfs: 76 runs, 20 regressions (v5.10.162-ci=
p24-rt10)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =

asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

meson-g12b-a311d-khadas-vim3 | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+preempt_rt         | 1          =

meson-g12b-a311d-khadas-vim3 | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+preempt_rt         | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g+preempt_rt         | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.162-cip24-rt10/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.162-cip24-rt10
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      55fa0afa2bb00f24b1721b532102d34eb18be47e =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/63d3232c26f84af69d915edb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d3232c26f84af69d915ee0
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:04:20.589140  [   14.623862] <LAVA_SIGNAL_ENDRUN 0_dmesg =
8894424_1.5.2.3.1>
    2023-01-27T01:04:20.694625  / # #
    2023-01-27T01:04:20.795717  export SHELL=3D/bin/sh
    2023-01-27T01:04:20.796033  #
    2023-01-27T01:04:20.896966  / # export SHELL=3D/bin/sh. /lava-8894424/e=
nvironment
    2023-01-27T01:04:20.897186  =

    2023-01-27T01:04:20.998175  / # . /lava-8894424/environment/lava-889442=
4/bin/lava-test-runner /lava-8894424/1
    2023-01-27T01:04:20.998581  =

    2023-01-27T01:04:21.004281  / # /lava-8894424/bin/lava-test-runner /lav=
a-8894424/1
    2023-01-27T01:04:21.106738  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/63d320ba75d4dee3b0915ec5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d320ba75d4dee3b0915eca
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T00:54:09.784483  [   13.689848] <LAVA_SIGNAL_ENDRUN 0_dmesg =
8894084_1.5.2.3.1>
    2023-01-27T00:54:09.889237  / # #
    2023-01-27T00:54:09.990243  export SHELL=3D/bin/sh
    2023-01-27T00:54:09.990452  #
    2023-01-27T00:54:10.091365  / # export SHELL=3D/bin/sh. /lava-8894084/e=
nvironment
    2023-01-27T00:54:10.091594  =

    2023-01-27T00:54:10.192540  / # . /lava-8894084/environment/lava-889408=
4/bin/lava-test-runner /lava-8894084/1
    2023-01-27T00:54:10.192846  =

    2023-01-27T00:54:10.198745  / # /lava-8894084/bin/lava-test-runner /lav=
a-8894084/1
    2023-01-27T00:54:10.257896  + export TESTRUN_ID=3D1_bootrr =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/63d32377049a8ded22915ec5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d32377049a8ded22915eca
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:05:35.871456  + set +x[   13.671869] <LAVA_SIGNAL_ENDRUN =
0_dmesg 8894418_1.5.2.3.1>
    2023-01-27T01:05:35.871544  =

    2023-01-27T01:05:35.976207  / # #
    2023-01-27T01:05:36.077196  export SHELL=3D/bin/sh
    2023-01-27T01:05:36.077392  #
    2023-01-27T01:05:36.178284  / # export SHELL=3D/bin/sh. /lava-8894418/e=
nvironment
    2023-01-27T01:05:36.178519  =

    2023-01-27T01:05:36.279438  / # . /lava-8894418/environment/lava-889441=
8/bin/lava-test-runner /lava-8894418/1
    2023-01-27T01:05:36.279746  =

    2023-01-27T01:05:36.284667  / # /lava-8894418/bin/lava-test-runner /lav=
a-8894418/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/63d3213d35438a91a1915ed6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d3213d35438a91a1915edb
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T00:56:20.943994  set +x
    2023-01-27T00:56:20.947282  [   14.349620] <LAVA_SIGNAL_ENDRUN 0_dmesg =
8894117_1.5.2.3.1>
    2023-01-27T00:56:21.055931  / # #
    2023-01-27T00:56:21.158754  export SHELL=3D/bin/sh
    2023-01-27T00:56:21.159712  #
    2023-01-27T00:56:21.261628  / # export SHELL=3D/bin/sh. /lava-8894117/e=
nvironment
    2023-01-27T00:56:21.262540  =

    2023-01-27T00:56:21.364691  / # . /lava-8894117/environment/lava-889411=
7/bin/lava-test-runner /lava-8894117/1
    2023-01-27T00:56:21.366051  =

    2023-01-27T00:56:21.371033  / # /lava-8894117/bin/lava-test-runner /lav=
a-8894117/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/63d32378051f8de7bc915ecd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d32378051f8de7bc915ed2
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:05:54.509146  + set +x
    2023-01-27T01:05:54.509925  =

    2023-01-27T01:05:54.515929  [   15.482564] <LAVA_SIGNAL_ENDRUN 0_dmesg =
8894415_1.5.2.3.1>
    2023-01-27T01:05:54.621977  #
    2023-01-27T01:05:54.723216  / # #export SHELL=3D/bin/sh
    2023-01-27T01:05:54.723511  =

    2023-01-27T01:05:54.824433  / # export SHELL=3D/bin/sh. /lava-8894415/e=
nvironment
    2023-01-27T01:05:54.824692  =

    2023-01-27T01:05:54.925642  / # . /lava-8894415/environment/lava-889441=
5/bin/lava-test-runner /lava-8894415/1
    2023-01-27T01:05:54.925963   =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/63d321c1474cbf0b33915ecf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d321c1474cbf0b33915ed4
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T00:58:18.082147  + set +x
    2023-01-27T00:58:18.085323  [   16.945299] <LAVA_SIGNAL_ENDRUN 0_dmesg =
8894089_1.5.2.3.1>
    2023-01-27T00:58:18.088605  =

    2023-01-27T00:58:18.193677  / # #
    2023-01-27T00:58:18.296924  export SHELL=3D/bin/sh
    2023-01-27T00:58:18.297969  #
    2023-01-27T00:58:18.399937  / # export SHELL=3D/bin/sh. /lava-8894089/e=
nvironment
    2023-01-27T00:58:18.400898  =

    2023-01-27T00:58:18.502914  / # . /lava-8894089/environment/lava-889408=
9/bin/lava-test-runner /lava-8894089/1
    2023-01-27T00:58:18.504411   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d322e7eecaa1f82d915ed4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bla=
ck.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bla=
ck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d322e7eecaa1f82d915ed9
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:03:22.094467  <8>[   55.819904] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 188461_1.6.2.4.1>
    2023-01-27T01:03:22.206298  / # #
    2023-01-27T01:03:22.309884  export SHELL=3D/bin/sh
    2023-01-27T01:03:22.310586  #
    2023-01-27T01:03:22.412509  / # export SHELL=3D/bin/sh. /lava-188461/en=
vironment
    2023-01-27T01:03:22.413363  =

    2023-01-27T01:03:22.515993  / # . /lava-188461/environment/lava-188461/=
bin/lava-test-runner /lava-188461/1
    2023-01-27T01:03:22.517222  =

    2023-01-27T01:03:22.522033  / # /lava-188461/bin/lava-test-runner /lava=
-188461/1
    2023-01-27T01:03:22.746231  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d322bd03d76c1b3c915ed5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d322bd03d76c1b3c915ed8
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:02:37.042650  <8>[   47.069023] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 834216_1.6.2.4.1>
    2023-01-27T01:02:37.191142  #
    2023-01-27T01:02:37.294390  / # #export SHELL=3D/bin/sh
    2023-01-27T01:02:37.295167  =

    2023-01-27T01:02:37.397095  / # export SHELL=3D/bin/sh. /lava-834216/en=
vironment
    2023-01-27T01:02:37.397891  =

    2023-01-27T01:02:37.499939  / # . /lava-834216/environment/lava-834216/=
bin/lava-test-runner /lava-834216/1
    2023-01-27T01:02:37.501194  =

    2023-01-27T01:02:37.507804  / # /lava-834216/bin/lava-test-runner /lava=
-834216/1
    2023-01-27T01:02:37.839132  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d3232305c3011cd3915ef2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beagl=
ebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beagl=
ebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d3232305c3011cd3915ef7
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:04:18.428410  <8>[   51.679043] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 188490_1.6.2.4.1>
    2023-01-27T01:04:18.540602  / # #
    2023-01-27T01:04:18.643397  export SHELL=3D/bin/sh
    2023-01-27T01:04:18.644194  #
    2023-01-27T01:04:18.746239  / # export SHELL=3D/bin/sh. /lava-188490/en=
vironment
    2023-01-27T01:04:18.746638  =

    2023-01-27T01:04:18.848070  / # . /lava-188490/environment/lava-188490/=
bin/lava-test-runner /lava-188490/1
    2023-01-27T01:04:18.849248  =

    2023-01-27T01:04:18.853682  / # /lava-188490/bin/lava-test-runner /lava=
-188490/1
    2023-01-27T01:04:19.037999  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d3236e049a8ded22915eb9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebon=
e-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebon=
e-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d3236e049a8ded22915ebc
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:05:34.519342  <8>[   46.777433] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 834232_1.6.2.4.1>
    2023-01-27T01:05:34.626024  #
    2023-01-27T01:05:34.728177  / # #export SHELL=3D/bin/sh
    2023-01-27T01:05:34.728752  =

    2023-01-27T01:05:34.830137  / # export SHELL=3D/bin/sh. /lava-834232/en=
vironment
    2023-01-27T01:05:34.830585  =

    2023-01-27T01:05:34.931928  / # . /lava-834232/environment/lava-834232/=
bin/lava-test-runner /lava-834232/1
    2023-01-27T01:05:34.932657  =

    2023-01-27T01:05:34.934692  / # /lava-834232/bin/lava-test-runner /lava=
-834232/1
    2023-01-27T01:05:35.138415  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d3238a049a8ded22915edb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/defconfig/gcc-10/lab-baylibre/baseline-nfs-cubietruck.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/defconfig/gcc-10/lab-baylibre/baseline-nfs-cubietruck.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d3238a049a8ded22915ee0
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:05:46.798626  [   35.186711] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3222145_1.6.2.4.1>
    2023-01-27T01:05:46.919124  / # #
    2023-01-27T01:05:47.020757  export SHELL=3D/bin/sh
    2023-01-27T01:05:47.021172  #
    2023-01-27T01:05:47.122403  / # export SHELL=3D/bin/sh. /lava-3222145/e=
nvironment
    2023-01-27T01:05:47.122815  =

    2023-01-27T01:05:47.224064  / # . /lava-3222145/environment/lava-322214=
5/bin/lava-test-runner /lava-3222145/1
    2023-01-27T01:05:47.224705  =

    2023-01-27T01:05:47.229486  / # /lava-3222145/bin/lava-test-runner /lav=
a-3222145/1
    2023-01-27T01:05:47.461863  + export TESTRUN_ID=3D1_bootrr =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d3243eef6ad5f4b6915ec0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-nfs-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-nfs-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d3243eef6ad5f4b6915ec5
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:09:04.591775  [   58.769725] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3222157_1.6.2.4.1>
    2023-01-27T01:09:04.725895  / # #
    2023-01-27T01:09:04.829402  export SHELL=3D/bin/sh
    2023-01-27T01:09:04.830648  #
    2023-01-27T01:09:04.932870  / # export SHELL=3D/bin/sh. /lava-3222157/e=
nvironment
    2023-01-27T01:09:04.934053  =

    2023-01-27T01:09:05.036340  / # . /lava-3222157/environment/lava-322215=
7/bin/lava-test-runner /lava-3222157/1
    2023-01-27T01:09:05.037937  =

    2023-01-27T01:09:05.042956  / # /lava-3222157/bin/lava-test-runner /lav=
a-3222157/1
    2023-01-27T01:09:05.324518  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d3221d03c022713f915f30

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabrel=
ite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabrel=
ite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d3221d03c022713f915f35
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:00:02.785407  + set +x
    2023-01-27T01:00:02.786268  / # [   25.727154] <LAVA_SIGNAL_TESTCASE TE=
ST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-27T01:00:02.786571  [   25.728071] <LAVA_SIGNAL_ENDRUN 0_dmesg =
8894152_1.6.2.4.1>
    2023-01-27T01:00:02.891876  #
    2023-01-27T01:00:02.995096  export SHELL=3D/bin/sh
    2023-01-27T01:00:02.995924  #
    2023-01-27T01:00:03.098039  / # export SHELL=3D/bin/sh. /lava-8894152/e=
nvironment
    2023-01-27T01:00:03.098872  =

    2023-01-27T01:00:03.201090  / # . /lava-8894152/environment/lava-889415=
2/bin/lava-test-runner /lava-8894152/1
    2023-01-27T01:00:03.202337   =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d32276108eb74108915ece

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx=
6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx=
6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d32276108eb74108915ed3
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:01:35.334506  / # #
    2023-01-27T01:01:35.435470  export SHELL=3D/bin/sh
    2023-01-27T01:01:35.435637  #
    2023-01-27T01:01:35.536830  / # export SHELL=3D/bin/sh. /lava-8894171/e=
nvironment
    2023-01-27T01:01:35.537129  =

    2023-01-27T01:01:35.638255  / # . /lava-8894171/environment/lava-889417=
1/bin/lava-test-runner /lava-8894171/1
    2023-01-27T01:01:35.638691  =

    2023-01-27T01:01:35.647196  / # /lava-8894171/bin/lava-test-runner /lav=
a-8894171/1
    2023-01-27T01:01:35.803029  + export TESTRUN_ID=3D1_bootrr
    2023-01-27T01:01:35.803143  + cd /lava-8894171/1/tests/1_bootrr =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/63d32849494adc2fa7915f3f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm64/defconfig+preempt_rt/gcc-10/lab-baylibre/baseline-nfs-=
meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm64/defconfig+preempt_rt/gcc-10/lab-baylibre/baseline-nfs-=
meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63d32849494adc2fa=
7915f40
        failing since 46 days (last pass: v5.10.153-cip19-rt8, first fail: =
v5.10.158-cip22-rt9) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d32b2db051f55942915eec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson-g12b-=
a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson-g12b-=
a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63d32b2db051f5594=
2915eed
        new failure (last pass: v5.10.158-cip22-rt9) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/63d3285dcf7ec266d4915ef9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm64/defconfig+preempt_rt/gcc-10/lab-baylibre/baseline-nfs-=
meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm64/defconfig+preempt_rt/gcc-10/lab-baylibre/baseline-nfs-=
meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63d3285dcf7ec266d=
4915efa
        new failure (last pass: v5.10.158-cip22-rt9) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d329907894060a61915ebf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s9=
05x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s9=
05x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63d329917894060a6=
1915ec0
        failing since 46 days (last pass: v5.10.145-cip17-rt7, first fail: =
v5.10.158-cip22-rt9) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/63d327fe20dc9d50d69177fe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-s=
un50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-s=
un50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d327fe20dc9d50d6917803
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:24:53.979147  [   29.324490] <LAVA_SIGNAL_ENDRUN 0_dmesg =
188598_1.6.2.4.1>
    2023-01-27T01:24:54.091161  #
    2023-01-27T01:24:54.193438  / # #export SHELL=3D/bin/sh
    2023-01-27T01:24:54.193962  =

    2023-01-27T01:24:54.295466  / # export SHELL=3D/bin/sh. /lava-188598/en=
vironment
    2023-01-27T01:24:54.295953  =

    2023-01-27T01:24:54.397513  / # . /lava-188598/environment/lava-188598/=
bin/lava-test-runner /lava-188598/1
    2023-01-27T01:24:54.398527  =

    2023-01-27T01:24:54.401275  / # /lava-188598/bin/lava-test-runner /lava=
-188598/1
    2023-01-27T01:24:54.519791  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63d329162d4cc78209915ef1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-p=
ine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-p=
ine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d329162d4cc78209915ef6
        new failure (last pass: v5.10.158-cip22-rt9)

    2023-01-27T01:29:47.235004  <8>[   35.780974] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 188723_1.6.2.4.1>
    2023-01-27T01:29:47.374268  / # #
    2023-01-27T01:29:47.476301  export SHELL=3D/bin/sh
    2023-01-27T01:29:47.476879  #
    2023-01-27T01:29:47.578515  / # export SHELL=3D/bin/sh. /lava-188723/en=
vironment
    2023-01-27T01:29:47.579481  =

    2023-01-27T01:29:47.681838  / # . /lava-188723/environment/lava-188723/=
bin/lava-test-runner /lava-188723/1
    2023-01-27T01:29:47.683013  =

    2023-01-27T01:29:47.689392  / # /lava-188723/bin/lava-test-runner /lava=
-188723/1
    2023-01-27T01:29:47.859596  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =20

