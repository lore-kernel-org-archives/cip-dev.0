Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B791FEB64D7
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 02:55:01 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web10.3017.1686711298568216611
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 13 Jun 2023 19:54:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=xHtnLN1m;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.177, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-54fb3c168fcso1228033a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 13 Jun 2023 19:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686711297; x=1689303297;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jbxtIFIKMSNHTE7n4tf/VbfQzV/46WIz91wQhaOKSac=;
        b=xHtnLN1mxCMWN+yYOn3kRy4uh8A1wNf4aBBD9+kqWWwUuNwfpfjl3Y0l0WfP1YTZny
         1aTK7R1dOJKU3MwFIyt8ey9m5d9uxjFRzvYlrEzmw4Z4Fa74KOLIzv1rlSLDfsS4LLlT
         txWsElsFGETRGCqmzrgqiqffzrV6MjvuOySpTYdzetMEUKRXs+nVyjx7z3jvn2y2ZzS7
         jwgzB6wcbfjpIB/TD3OB635zv0RnrWCl80yeFvqYvTKGKOoeDvj1wKig/GKuQS3ezoU7
         vj7/AIt7W9bmEYj0YQm2lLvSm2+Ndvsdw74kVwbJ0e8kaMylb6hVpFMl1vH+eolcuRLQ
         x8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686711297; x=1689303297;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbxtIFIKMSNHTE7n4tf/VbfQzV/46WIz91wQhaOKSac=;
        b=MgAAdoPUQbDMaLxBO6DT3YsMVKH/0YyywOfNuROE3KHCueG44VxjAcbUk86woatd4t
         XGO/Ehk/NRkIYkWihuUCoQOo7ehcOXiTYdpuEVkZO4fq5U6REm0hhMzdDmzP+K7w0k4+
         8060OMxSjdqcR9XpUZxL6dg9lgHVXClH2UlFxRbBzMfHcAyelg0IhldbTPeycDblPuNJ
         Mt1D2/xgefdRv0CxjWXlYlH/MmYqrfLhH+bH3VeOKnJhBEB/2peSqmATr8RWoOE0ZKs/
         XUsLq/3yEzcBh6+nsS1ZTTZMFHdTkkv1o3sYSSYuy2DbLwadGRjg24Z7Flv53FK1Jrtw
         MD2g==
X-Gm-Message-State: AC+VfDwblNURgdoukdL1/w6bcN93B3RYuIfopoWR1ac6x4UvglUYA8Uv
	PqsgkLojqMJCluACj5gxi1B9gF8fwXtvd0iqaIq9RQ==
X-Google-Smtp-Source: ACHHUZ6UIvp5G5/FDohcTklrEcZ44OiFc+5O3yDp4+F38npz6jkzy6tKtELVsSAtoy4S1Uv2uNDMRQ==
X-Received: by 2002:a17:902:7c0b:b0:1b0:1fc7:cbc1 with SMTP id x11-20020a1709027c0b00b001b01fc7cbc1mr10643711pll.27.1686711297072;
        Tue, 13 Jun 2023 19:54:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r21-20020a170902ea5500b0019309be03e7sm10954896plg.66.2023.06.13.19.54.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 19:54:56 -0700 (PDT)
Message-ID: <64892c00.170a0220.77392.5fb6@mx.google.com>
Date: Tue, 13 Jun 2023 19:54:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-8-gc3d08808cfa7
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 148 runs,
 11 regressions (v5.10.182-cip35-8-gc3d08808cfa7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 02:55:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11999

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 148 runs, 11 regressio=
ns (v5.10.182-cip35-8-gc3d08808cfa7)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

qemu_i386                    | i386   | lab-collabora | gcc-10   | i386_def=
config               | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.182-cip35-8-gc3d08808cfa7/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.182-cip35-8-gc3d08808cfa7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c3d08808cfa768cd3cc5ecfba684f72db3e04b9f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6489201a70325a2998306132

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/arm/omap2plus_defconfig/gcc-10=
/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/arm/omap2plus_defconfig/gcc-10=
/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489201a70325a2998306164
        failing since 160 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-06-14T02:03:53.388701  + set +x
    2023-06-14T02:03:53.392499  <8>[   21.312384] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 607868_1.5.2.4.1>
    2023-06-14T02:03:53.502931  / # #
    2023-06-14T02:03:53.606128  export SHELL=3D/bin/sh
    2023-06-14T02:03:53.606875  #
    2023-06-14T02:03:53.709010  / # export SHELL=3D/bin/sh. /lava-607868/en=
vironment
    2023-06-14T02:03:53.709715  =

    2023-06-14T02:03:53.811886  / # . /lava-607868/environment/lava-607868/=
bin/lava-test-runner /lava-607868/1
    2023-06-14T02:03:53.813186  =

    2023-06-14T02:03:53.817630  / # /lava-607868/bin/lava-test-runner /lava=
-607868/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64891f4d573017bd7e306131

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.t=
xt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64891f4d573017bd7e306136
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T02:00:29.595133  + set +x

    2023-06-14T02:00:29.601786  <8>[   10.708910] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10716688_1.4.2.3.1>

    2023-06-14T02:00:29.705973  / # #

    2023-06-14T02:00:29.806549  export SHELL=3D/bin/sh

    2023-06-14T02:00:29.806737  #

    2023-06-14T02:00:29.907212  / # export SHELL=3D/bin/sh. /lava-10716688/=
environment

    2023-06-14T02:00:29.907425  =


    2023-06-14T02:00:30.007960  / # . /lava-10716688/environment/lava-10716=
688/bin/lava-test-runner /lava-10716688/1

    2023-06-14T02:00:30.008251  =


    2023-06-14T02:00:30.013110  / # /lava-10716688/bin/lava-test-runner /la=
va-10716688/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6489200147fc95f1f9306150

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/x86_64/x86_64_defconfig+x86-ch=
romebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020=
-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/x86_64/x86_64_defconfig+x86-ch=
romebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020=
-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6489200147fc95f1f9306155
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T02:03:39.698439  + set +x<8>[   16.084279] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10716749_1.4.2.3.1>

    2023-06-14T02:03:39.698538  =


    2023-06-14T02:03:39.803003  / # #

    2023-06-14T02:03:39.903668  export SHELL=3D/bin/sh

    2023-06-14T02:03:39.903874  #

    2023-06-14T02:03:40.004467  / # export SHELL=3D/bin/sh. /lava-10716749/=
environment

    2023-06-14T02:03:40.004671  =


    2023-06-14T02:03:40.105275  / # . /lava-10716749/environment/lava-10716=
749/bin/lava-test-runner /lava-10716749/1

    2023-06-14T02:03:40.105560  =


    2023-06-14T02:03:40.110437  / # /lava-10716749/bin/lava-test-runner /la=
va-10716749/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64891f45ab215f92ff30612f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64891f45ab215f92ff306134
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T02:00:19.220418  <8>[   13.663082] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10716685_1.4.2.3.1>

    2023-06-14T02:00:19.223775  + set +x

    2023-06-14T02:00:19.329627  #

    2023-06-14T02:00:19.330874  =


    2023-06-14T02:00:19.432783  / # #export SHELL=3D/bin/sh

    2023-06-14T02:00:19.433612  =


    2023-06-14T02:00:19.535127  / # export SHELL=3D/bin/sh. /lava-10716685/=
environment

    2023-06-14T02:00:19.535948  =


    2023-06-14T02:00:19.637543  / # . /lava-10716685/environment/lava-10716=
685/bin/lava-test-runner /lava-10716685/1

    2023-06-14T02:00:19.638888  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64891fdf4564f0ab8e306182

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/x86_64/x86_64_defconfig+x86-ch=
romebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/x86_64/x86_64_defconfig+x86-ch=
romebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64891fe04564f0ab8e306187
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T02:03:04.499672  <8>[   13.940506] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10716764_1.4.2.3.1>

    2023-06-14T02:03:04.503263  + set +x

    2023-06-14T02:03:04.604582  =


    2023-06-14T02:03:04.705128  / # #export SHELL=3D/bin/sh

    2023-06-14T02:03:04.705287  =


    2023-06-14T02:03:04.805858  / # export SHELL=3D/bin/sh. /lava-10716764/=
environment

    2023-06-14T02:03:04.806030  =


    2023-06-14T02:03:04.906677  / # . /lava-10716764/environment/lava-10716=
764/bin/lava-test-runner /lava-10716764/1

    2023-06-14T02:03:04.906931  =


    2023-06-14T02:03:04.911663  / # /lava-10716764/bin/lava-test-runner /la=
va-10716764/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_i386                    | i386   | lab-collabora | gcc-10   | i386_def=
config               | 1          =


  Details:     https://kernelci.org/test/plan/id/6489200366460591a130612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/i386/i386_defconfig/gcc-10/lab=
-collabora/baseline-qemu_i386.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/i386/i386_defconfig/gcc-10/lab=
-collabora/baseline-qemu_i386.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489200366460591a1306=
12f
        new failure (last pass: v5.10.180-cip34-236-g6d219c607dc68) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64892394cc854cce2830612f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/arm/shmobile_defconfig/gcc-10/=
lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/arm/shmobile_defconfig/gcc-10/=
lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64892394cc854cce28306=
130
        failing since 18 days (last pass: v5.10.179-cip32-384-g291adc46abef=
0, first fail: v5.10.180-cip33-21-g090289427e8b2) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/64892046971ecbc08330615e

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/arm64/defconfig+arm64-chromebo=
ok+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/arm64/defconfig+arm64-chromebo=
ok+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64892046971ecbc0833061aa
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T02:05:00.613800  /lava-10716780/1/../bin/lava-test-case

    2023-06-14T02:05:00.639308  <8>[   44.159823] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64892046971ecbc0833061ab
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T02:04:59.526914  /lava-10716780/1/../bin/lava-test-case

    2023-06-14T02:04:59.550724  <8>[   43.072067] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/648921638ba63dca1030612e

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/648921638ba63dca10306134
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T02:09:35.235708  /lava-10716835/1/../bin/lava-test-case

    2023-06-14T02:09:35.246864  <8>[   33.429241] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/648921638ba63dca10306135
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T02:09:34.198664  /lava-10716835/1/../bin/lava-test-case

    2023-06-14T02:09:34.209746  <8>[   32.392454] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

