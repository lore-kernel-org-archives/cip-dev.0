Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3D4C7EE2A
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 11:10:52 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.4757.1685963448317114811
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 04:10:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=tPDDUwqQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1b026657a6fso40605955ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 04:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685963447; x=1688555447;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yP6forB8kgN2SeSaNaqHx8g+sKjigY+7SxVjbcKkmXI=;
        b=tPDDUwqQV4Va3Fo8ivOMwZAK9F+JyXK+dBrkXhWwj1ZuORhi9wre10BZy6uU0jl9Ss
         JrGeaV4OxWigkd07rm+6R3nRmxfHi3cR9WdQY+BNdQwilhDuUGO6KKYfSQ/Jplvnw6qN
         13mIo2RdNA9s1eWamxIr+lMeWyj8Wv+R4HB/sWWJG4GKKgrMlS4PeSvFwHVrcBmrwZNg
         a9rh0G1KaKchfMvqu/aMlw0yHUPjt1AxyL+RIKQFYtQgZBpsqpd273+udQDOKQJJysUG
         iMJD/VXQXZL0VwvjbVFVDTlIlhq1XsYIJtY0EWs4kvurBFGV5epzI29z7mu52UWZmwSk
         aFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685963447; x=1688555447;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yP6forB8kgN2SeSaNaqHx8g+sKjigY+7SxVjbcKkmXI=;
        b=eWmBp+Nnq9waGtJCOURfomNyJs6rkpNyQ+2azU5yv51RcUNlp0YCBCH2YniBIfK5HD
         hjvIEj3AOEjaHL2a1axgyhdiA7+55svRUQnZ7Jp30PfUFtrGdmd6+s5LGEMGiDBnZNQ5
         983DWUGsBFx0ZOhcsjaU7aDi7Ff7EWuLA9svpnfr8KX0xo6jpWxUDmw6EOaOj1Nw0NlP
         meSqo6YbiUGFTPHrxFNdmyd7btfk7H5JGwXycYWdwb30U0wa5pBOWtwcK8vfqkLMCtHv
         t+t5AqNkvFMuFLsr89jLdIyDlrIcFKwg15P7Nk789y5XYU30u7X5yjfZL/a8EIIG5REE
         BGJg==
X-Gm-Message-State: AC+VfDxLkw8AAjI+0PjXOr81XoXv0BjUVVv1nZmnsEfkZJneYUEkhpCN
	TirmWlONoHIYMycrw0ZUFoBumlldH7xAQt8BBFk2yg==
X-Google-Smtp-Source: ACHHUZ43qF3XgSdmYMSz0E8S95XSn9O9BAV/4aoiYUDFF05OCixDYvultJejh+hHlT+88Wha7cilyg==
X-Received: by 2002:a17:902:ea11:b0:1ac:d03a:9702 with SMTP id s17-20020a170902ea1100b001acd03a9702mr8705724plg.67.1685963447068;
        Mon, 05 Jun 2023 04:10:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x16-20020a170902ec9000b001aaecc15d66sm6261874plg.289.2023.06.05.04.10.45
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 04:10:46 -0700 (PDT)
Message-ID: <647dc2b6.170a0220.57b2.a3bd@mx.google.com>
Date: Mon, 05 Jun 2023 04:10:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-236-g6d219c607dc68
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 66 runs,
 9 regressions (v5.10.180-cip34-236-g6d219c607dc68)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 11:10:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11796

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 66 runs, 9 regress=
ions (v5.10.180-cip34-236-g6d219c607dc68)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig+kselftest | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.180-cip34-236-g6d219c607dc68/plan/baselin=
e-nfs/

  Test:     baseline-nfs
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
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647db8238a016ba853f5de5b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/arm/multi_v7_defconfig+ksel=
ftest/gcc-10/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/arm/multi_v7_defconfig+ksel=
ftest/gcc-10/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647db8238a016ba85=
3f5de5c
        failing since 0 day (last pass: v5.10.180-cip34-213-g6582dd41d2c22,=
 first fail: v5.10.180-cip34-19-gae79bc689058c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647dba9077323fc52cf5dede

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647dba9077323fc52=
cf5dedf
        failing since 0 day (last pass: v5.10.180-cip34-213-g6582dd41d2c22,=
 first fail: v5.10.180-cip34-19-gae79bc689058c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647db8473a09b33f80f5de43

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oc=
topus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oc=
topus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647db8473a09b33f80f5de4c
        failing since 45 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-05T10:26:00.858222  + set[   22.684732] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10590333_1.5.2.3.1>

    2023-06-05T10:26:00.858345   +x

    2023-06-05T10:26:00.963150  / # #

    2023-06-05T10:26:01.063949  export SHELL=3D/bin/sh

    2023-06-05T10:26:01.064189  #

    2023-06-05T10:26:01.164752  / # export SHELL=3D/bin/sh. /lava-10590333/=
environment

    2023-06-05T10:26:01.164996  =


    2023-06-05T10:26:01.265561  / # . /lava-10590333/environment/lava-10590=
333/bin/lava-test-runner /lava-10590333/1

    2023-06-05T10:26:01.265962  =


    2023-06-05T10:26:01.270595  / # /lava-10590333/bin/lava-test-runner /la=
va-10590333/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647db8c488e9e10e1cf5de38

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010n=
r-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010n=
r-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647db8c488e9e10e1cf5de41
        failing since 45 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-05T10:27:54.154107  + set +x

    2023-06-05T10:27:54.160510  <8>[   28.812664] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10590680_1.5.2.3.1>

    2023-06-05T10:27:54.270866  / # #

    2023-06-05T10:27:54.371498  export SHELL=3D/bin/sh

    2023-06-05T10:27:54.371673  #

    2023-06-05T10:27:54.472194  / # export SHELL=3D/bin/sh. /lava-10590680/=
environment

    2023-06-05T10:27:54.472375  =


    2023-06-05T10:27:54.572878  / # . /lava-10590680/environment/lava-10590=
680/bin/lava-test-runner /lava-10590680/1

    2023-06-05T10:27:54.573167  =


    2023-06-05T10:27:54.577511  / # /lava-10590680/bin/lava-test-runner /la=
va-10590680/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647db798be825e0a43f5deeb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647db798be825e0a43f5def4
        failing since 45 days (last pass: v5.10.168-cip27-109-g23841ec76bec=
, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-05T10:23:00.896818  + set +x

    2023-06-05T10:23:00.903288  <8>[   24.484179] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10590318_1.5.2.3.1>

    2023-06-05T10:23:01.007717  / # #

    2023-06-05T10:23:01.108338  export SHELL=3D/bin/sh

    2023-06-05T10:23:01.108528  #

    2023-06-05T10:23:01.209009  / # export SHELL=3D/bin/sh. /lava-10590318/=
environment

    2023-06-05T10:23:01.209203  =


    2023-06-05T10:23:01.309700  / # . /lava-10590318/environment/lava-10590=
318/bin/lava-test-runner /lava-10590318/1

    2023-06-05T10:23:01.310044  =


    2023-06-05T10:23:01.315493  / # /lava-10590318/bin/lava-test-runner /la=
va-10590318/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647db7994256e28008f5de25

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.=
txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647db7994256e28008f5de2e
        failing since 45 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-05T10:22:59.978102  + set<8>[   21.122125] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10590670_1.5.2.3.1>

    2023-06-05T10:22:59.978223   +x

    2023-06-05T10:23:00.082990  / # #

    2023-06-05T10:23:00.183704  export SHELL=3D/bin/sh

    2023-06-05T10:23:00.183897  #

    2023-06-05T10:23:00.284419  / # export SHELL=3D/bin/sh. /lava-10590670/=
environment

    2023-06-05T10:23:00.284646  =


    2023-06-05T10:23:00.385217  / # . /lava-10590670/environment/lava-10590=
670/bin/lava-test-runner /lava-10590670/1

    2023-06-05T10:23:00.385554  =


    2023-06-05T10:23:00.390207  / # /lava-10590670/bin/lava-test-runner /la=
va-10590670/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/647dbb27d56b38fa5bf5de3b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647dbb27d56b38fa5=
bf5de3c
        new failure (last pass: v5.10.180-cip34-19-gae79bc689058c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/647dbc62dcfde5fa91f5de46

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-236-g6d219c607dc68/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/647dbc62dcfde5fa91f5de5d
        failing since 45 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-05T10:43:19.569200  /lava-10590925/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/647dbc62dcfde5fa91f5de5e
        failing since 45 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-05T10:43:18.473034  /lava-10590925/1/../bin/lava-test-case

    2023-06-05T10:43:18.509891  [   36.604156] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

