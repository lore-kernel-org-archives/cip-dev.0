Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F744EB64DC
	for <webhook@archiver.kernel.org>; Wed, 21 Jun 2023 19:33:35 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web10.7775.1687376008983714561
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 21 Jun 2023 12:33:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=FxhfV3L2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-666eef03ebdso2700774b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 21 Jun 2023 12:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687376008; x=1689968008;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1WdybbfOvEcEST4hxsgyQMcYqPZxxcGuSGKR7SHLdMw=;
        b=FxhfV3L2kz8QZD91pgGI/ljcu3a9gGW2eQ9wHPsrIL6iTvmdcIfFczjzWNDLo2vif0
         qRZTjjOUO+ne8/Nm0fJzUByabdowSVJF7BrGl0cQG+mzYjscsvDAahMIK3qWj5v4qLxa
         mIe2lg+sKUpcdCPuzguNra9bdXMSetKHU0+kTXZKsrYnw52fk9m9upHiJ5i1W7V5jn7S
         /DmV2F9Ft8koVBPNEgLyI1ITbkDi9HzEwHDVkCJjCho9lTzTUR/obht4xHEUrjyZ5G4M
         /CvFShRNy64Aq9/ZMavenTS1GIvWqsmiUi+z36Cuwlr9Hx0Sx+25wEFEN/ibDD5iaBoh
         uEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376008; x=1689968008;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1WdybbfOvEcEST4hxsgyQMcYqPZxxcGuSGKR7SHLdMw=;
        b=Xv8fezwYnsz3gvZo5fdFYgeVPUJxMjfxYnGVm6rR0bk+oN0dy1haP1BIfPGdbKXxMU
         ePtDy6hjkpomm3bfr4bgjlsxKRhu66nLoXNlJC5vqC+g3PEJBxq1+JifowPPzws91R2E
         S2XfNciJ2Y+fVoH1PusObu/8qcpyTf/BWmIbCQd9xsIsGiyipknz5B9TmhSR345Vqz4j
         EMC/HdhVBh+vy/K6LX20PUUb44JZtpWYGHa82Ch86GA0IS8S86MQAawojwk40Md3SaN7
         cNF/D5cv4IPTsaFZBF7RWMfuBoQxPApn17tedXnsZNzytoZGdV4rU0HEqT3TNkLy9gYA
         sLBA==
X-Gm-Message-State: AC+VfDzZvMg7CsjmgalDdS4yBZFK7VUIYniBDs/A5kTltyWfmO9wxdAU
	W4a7seWp8BWqmBSei8LFhDBd/k1ORLEZWhrMTA5BeA==
X-Google-Smtp-Source: ACHHUZ74VW5KcPv5ZmDGprhmw891X1IbjvTvS4aeXjUJH0uB1ZeQjhezzO1w6p6imAB1vdxi0gbJAw==
X-Received: by 2002:a05:6a20:9385:b0:10c:4ff5:38b7 with SMTP id x5-20020a056a20938500b0010c4ff538b7mr7621959pzh.6.1687376007461;
        Wed, 21 Jun 2023 12:33:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902a60d00b001ae0a4b1d3fsm3878144plq.153.2023.06.21.12.33.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:33:26 -0700 (PDT)
Message-ID: <64935086.170a0220.8ae46.95ed@mx.google.com>
Date: Wed, 21 Jun 2023 12:33:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-289-g3c0549540706
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 65 runs,
 8 regressions (v5.10.182-cip35-289-g3c0549540706)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Jun 2023 19:33:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12094

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 65 runs, 8 regress=
ions (v5.10.182-cip35-289-g3c0549540706)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.182-cip35-289-g3c0549540706/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.182-cip35-289-g3c0549540706
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3c0549540706be602c1cc58f7ebdcae39509baa7 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6493453b9c7ae82f6930627f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/arm/multi_v7_defconfig/gcc-1=
0/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/arm/multi_v7_defconfig/gcc-1=
0/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6493453b9c7ae82f6=
9306280
        new failure (last pass: v5.10.182-cip35-191-gf4efde512959) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6493418be3ced3d8d2306190

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr=
-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr=
-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6493418ce3ced3d8d2306199
        failing since 62 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-21T18:29:25.399972  + set +x

    2023-06-21T18:29:25.406879  <8>[   27.894625] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10848582_1.5.2.3.1>

    2023-06-21T18:29:25.511719  / # #

    2023-06-21T18:29:25.612384  export SHELL=3D/bin/sh

    2023-06-21T18:29:25.612571  #

    2023-06-21T18:29:25.713117  / # export SHELL=3D/bin/sh. /lava-10848582/=
environment

    2023-06-21T18:29:25.713337  =


    2023-06-21T18:29:25.813872  / # . /lava-10848582/environment/lava-10848=
582/bin/lava-test-runner /lava-10848582/1

    2023-06-21T18:29:25.814180  =


    2023-06-21T18:29:25.819503  / # /lava-10848582/bin/lava-test-runner /la=
va-10848582/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6493432325ec21adc7306130

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oct=
opus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oct=
opus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6493432325ec21adc7306139
        failing since 62 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-21T18:35:57.809457  + set +x

    2023-06-21T18:35:57.815584  <8>[   18.162412] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10848760_1.5.2.3.1>

    2023-06-21T18:35:57.919762  / # #

    2023-06-21T18:35:58.020362  export SHELL=3D/bin/sh

    2023-06-21T18:35:58.020567  #

    2023-06-21T18:35:58.121109  / # export SHELL=3D/bin/sh. /lava-10848760/=
environment

    2023-06-21T18:35:58.121300  =


    2023-06-21T18:35:58.221841  / # . /lava-10848760/environment/lava-10848=
760/bin/lava-test-runner /lava-10848760/1

    2023-06-21T18:35:58.222117  =


    2023-06-21T18:35:58.226607  / # /lava-10848760/bin/lava-test-runner /la=
va-10848760/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64934171c77099ce6b306169

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.t=
xt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64934171c77099ce6b306172
        failing since 62 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-21T18:28:51.477620  + set +x

    2023-06-21T18:28:51.484147  <8>[   19.974472] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10848586_1.5.2.3.1>

    2023-06-21T18:28:51.594665  / # #

    2023-06-21T18:28:51.695250  export SHELL=3D/bin/sh

    2023-06-21T18:28:51.695469  #

    2023-06-21T18:28:51.795970  / # export SHELL=3D/bin/sh. /lava-10848586/=
environment

    2023-06-21T18:28:51.796185  =


    2023-06-21T18:28:51.896745  / # . /lava-10848586/environment/lava-10848=
586/bin/lava-test-runner /lava-10848586/1

    2023-06-21T18:28:51.897033  =


    2023-06-21T18:28:51.902036  / # /lava-10848586/bin/lava-test-runner /la=
va-10848586/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649342c6d8fed194cb30615c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/649342c6d8fed194cb306165
        failing since 62 days (last pass: v5.10.168-cip27-109-g23841ec76bec=
, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-21T18:34:25.205643  + set +x<8>[   20.762876] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10848752_1.5.2.3.1>

    2023-06-21T18:34:25.205741  =


    2023-06-21T18:34:25.310238  / # #

    2023-06-21T18:34:25.412520  export SHELL=3D/bin/sh

    2023-06-21T18:34:25.413311  #

    2023-06-21T18:34:25.514982  / # export SHELL=3D/bin/sh. /lava-10848752/=
environment

    2023-06-21T18:34:25.515772  =


    2023-06-21T18:34:25.617468  / # . /lava-10848752/environment/lava-10848=
752/bin/lava-test-runner /lava-10848752/1

    2023-06-21T18:34:25.618658  =


    2023-06-21T18:34:25.623639  / # /lava-10848752/bin/lava-test-runner /la=
va-10848752/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649345278344b40f6430613f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/649345278344b40f6=
4306140
        new failure (last pass: v5.10.182-cip35-191-gf4efde512959) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/649348afa7aa3997853061b0

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/649348afa7aa3997853061ba
        failing since 62 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-21T18:59:43.294595  <8>[   94.843116] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-06-21T18:59:44.343174  /lava-10849140/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/649348afa7aa3997853061bb
        failing since 62 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-21T18:59:43.261760  /lava-10849140/1/../bin/lava-test-case
   =

 =20

