Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523C0C7EE23
	for <webhook@archiver.kernel.org>; Wed, 17 May 2023 14:38:40 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web10.51735.1684334315010463070
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 17 May 2023 07:38:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=33vW0Ng0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ae4e49727eso9938075ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 17 May 2023 07:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684334314; x=1686926314;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W7zL0axDyh9sE91AhBNwS8aeoijnx/eDP8+88Hok9iU=;
        b=33vW0Ng0RTLVIOhQFddCnkAPzMIq7gGsu+SHodSLqMViH0Ks8FHx+GH1b4SuBuKHhq
         DMnGCpwcBhYqC0xeA3PVrRegW7vmx6X3MfRLfmI8SOO9VT4tecXlbqm6E2hv4d1WvWC9
         9H2k6HqtsY7jgXJehis+pk4D1iqWBQEPAYXWtc0TfHnyk+7TNeTtqHZSl/kXp+GFzy0g
         8/jU/KVejdd4AHwF/ASiBMZ8MIUGQBusMbjaAIYpJf3A2I7dIYh6820v9FD558Kr8DVy
         bCsbk4ytmGtgyaXWsApTLx418haeszZ58h8gCRgdQkPXkCv5Jzh38ZLdrX8VdX/0mn6f
         PwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684334314; x=1686926314;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7zL0axDyh9sE91AhBNwS8aeoijnx/eDP8+88Hok9iU=;
        b=ZDqRRn9Oy2Cxy3np+1BI1qXFCCekWd0LcbGsuF3h/NMTRXHia7RYBl9TJUaAu3cYgQ
         QkzYmeAzq6TgmGHqF5dCE7MsTzDbN4L4IOAQPkeKMtfG+gIH/uV+318HMxPUtxlrf1FH
         hs9JL+EX/9WAJc8JEgFknoPI3eDjyISezT6OsxjZkBRLIrFEGMq0MWAJYXYyBlYPZreT
         FWzK7we/pRZDQ2geVFd4xMqNDaigOEJWvyRJ0Hd0H+q+aHECaNGbqZpfvO4wJzGRtc26
         h0Tqddu3WvYK3mLKTHeA5xxn4P1Grq7Sg+t8Q+lrKMOGfvp/3ztSgchCyNT2pj5S3uJQ
         9GsQ==
X-Gm-Message-State: AC+VfDweZKjFSTY6KP0Jtzbfb0GphWCWuQi5/mPHGFQovUTgGDDSZPyG
	4Q/c0LJy+Ma88GOEjulUR2QSHhwdD42g83mR8VWM4g==
X-Google-Smtp-Source: ACHHUZ7T+eqLpkrs2LKWygfVo1aPDlN8tpoSgZcDAfZMj1FplkS/kyEpTkzanFsC5T+f8WAiAnVpCQ==
X-Received: by 2002:a17:903:10a:b0:1ab:11c8:777a with SMTP id y10-20020a170903010a00b001ab11c8777amr38676836plc.13.1684334313510;
        Wed, 17 May 2023 07:38:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902e9cd00b001ab0669d84csm17668974plk.26.2023.05.17.07.38.32
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 07:38:32 -0700 (PDT)
Message-ID: <6464e6e8.170a0220.e0b03.2b8d@mx.google.com>
Date: Wed, 17 May 2023 07:38:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.179-cip32-384-g291adc46abef0
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 66 runs,
 11 regressions (v5.10.179-cip32-384-g291adc46abef0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 May 2023 14:38:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11499

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 66 runs, 11 regres=
sions (v5.10.179-cip32-384-g291adc46abef0)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.179-cip32-384-g291adc46abef0/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.179-cip32-384-g291adc46abef0
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      291adc46abef012487ba16bb07999af85de2d34d =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6464e02a599d9d22962e8636

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6464e02a599d9d229=
62e8637
        new failure (last pass: v5.10.177-cip31-122-gfb6ca504156b4) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6464daeaa2ca963f612e865e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010n=
r-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010n=
r-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6464daeaa2ca963f612e8663
        failing since 26 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-17T13:47:02.582095  + set +x

    2023-05-17T13:47:02.588233  <8>[   37.769454] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10354797_1.5.2.3.1>

    2023-05-17T13:47:02.715848  / # #

    2023-05-17T13:47:02.816512  export SHELL=3D/bin/sh

    2023-05-17T13:47:02.816768  #

    2023-05-17T13:47:02.917591  / # export SHELL=3D/bin/sh. /lava-10354797/=
environment

    2023-05-17T13:47:02.917842  =


    2023-05-17T13:47:03.018368  / # . /lava-10354797/environment/lava-10354=
797/bin/lava-test-runner /lava-10354797/1

    2023-05-17T13:47:03.018638  =


    2023-05-17T13:47:03.023505  / # /lava-10354797/bin/lava-test-runner /la=
va-10354797/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464dba1131a650e112e85f4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oc=
topus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oc=
topus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6464dba1131a650e112e85f9
        failing since 26 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-17T13:50:10.594209  + set<8>[   22.494783] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10354917_1.5.2.3.1>

    2023-05-17T13:50:10.594338   +x

    2023-05-17T13:50:10.698649  / # #

    2023-05-17T13:50:10.799390  export SHELL=3D/bin/sh

    2023-05-17T13:50:10.800341  #

    2023-05-17T13:50:10.902021  / # export SHELL=3D/bin/sh. /lava-10354917/=
environment

    2023-05-17T13:50:10.902269  =


    2023-05-17T13:50:11.002851  / # . /lava-10354917/environment/lava-10354=
917/bin/lava-test-runner /lava-10354917/1

    2023-05-17T13:50:11.003233  =


    2023-05-17T13:50:11.008046  / # /lava-10354917/bin/lava-test-runner /la=
va-10354917/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6464da847a111add682e8635

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.=
txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6464da847a111add682e863a
        failing since 26 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-17T13:45:21.237075  + set +x

    2023-05-17T13:45:21.243357  <8>[   44.907211] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10354748_1.5.2.3.1>

    2023-05-17T13:45:21.349013  / # #

    2023-05-17T13:45:21.449608  export SHELL=3D/bin/sh

    2023-05-17T13:45:21.449822  #

    2023-05-17T13:45:21.550425  / # export SHELL=3D/bin/sh. /lava-10354748/=
environment

    2023-05-17T13:45:21.550631  =


    2023-05-17T13:45:21.651198  / # . /lava-10354748/environment/lava-10354=
748/bin/lava-test-runner /lava-10354748/1

    2023-05-17T13:45:21.651496  =


    2023-05-17T13:45:21.656589  / # /lava-10354748/bin/lava-test-runner /la=
va-10354748/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464db347f29e4e02d2e85f8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6464db347f29e4e02d2e85fd
        failing since 26 days (last pass: v5.10.168-cip27-109-g23841ec76bec=
, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-17T13:48:11.377419  + <8>[   26.575892] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10354940_1.5.2.3.1>

    2023-05-17T13:48:11.377533  set +x

    2023-05-17T13:48:11.562026  / # #

    2023-05-17T13:48:11.662723  export SHELL=3D/bin/sh

    2023-05-17T13:48:11.662929  #

    2023-05-17T13:48:11.763427  / # export SHELL=3D/bin/sh. /lava-10354940/=
environment

    2023-05-17T13:48:11.763633  =


    2023-05-17T13:48:11.864179  / # . /lava-10354940/environment/lava-10354=
940/bin/lava-test-runner /lava-10354940/1

    2023-05-17T13:48:11.864488  =


    2023-05-17T13:48:11.868839  / # /lava-10354940/bin/lava-test-runner /la=
va-10354940/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6464dee1510852009f2e85ed

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6464dee1510852009=
f2e85ee
        failing since 26 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6464df6d5bbec1ae5a2e85e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/arm64/defconfig/gcc-10/lab-=
broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/arm64/defconfig/gcc-10/lab-=
broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6464df6d5bbec1ae5=
a2e85e8
        new failure (last pass: v5.10.177-cip31-122-gfb6ca504156b4) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6464dd112133754a5e2e85fc

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/6464dd112133754a5e2e8602
        failing since 26 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-17T13:56:08.494202  <8>[   36.333902] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-05-17T13:56:09.556837  /lava-10355032/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/6464dd112133754a5e2e8603
        failing since 26 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-17T13:56:07.393894  <8>[   35.234250] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-05-17T13:56:08.458436  /lava-10355032/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/6464de4d806c10562e2e88bc

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.179-cip32-384-g291adc46abef0/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/6464de4d806c10562e2e88c2
        failing since 26 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-17T14:01:41.920975  /lava-10355294/1/../bin/lava-test-case

    2023-05-17T14:01:41.995537  [   57.123169] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/6464de4d806c10562e2e88c3
        failing since 26 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-17T14:01:39.535964  [   54.662544] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-05-17T14:01:40.711406  /lava-10355294/1/../bin/lava-test-case

    2023-05-17T14:01:40.782496  [   55.909797] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

