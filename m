Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E39EB64D9
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 12:27:25 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web11.10298.1686745641523782050
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 14 Jun 2023 05:27:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=j1/V7ZSN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-66643830ab3so643382b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 14 Jun 2023 05:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686745640; x=1689337640;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tpL5hXtIyhIRi/GwJoVA2zr42fL6oE2lmW7B3Boiq0A=;
        b=j1/V7ZSNhJ4Ltcxu81tDex6PhPBLh4NhOdJaY3mX8iQ7oG3P1dDz0712/JhgEcx8eu
         rnGkXJkzxppGtVjFpVzejATBqcV6acddtkxLyyYBTvYOgzMAlwxIMXNxHDkntX5OHE1g
         ka9IvqfG3lfr2pepyOKKRpG048hd/gAn8wzfxLX9BTHqG1h7/nOtYu+uZu3MPn9zzHTu
         TYy98bLNGZxwltozqTN5DoDlRTTR1ulilpg5MuHhRx/CA3ZB0euEqP2SfotTN9dPpT+0
         epp2yjp67hABy7CzX4ddV9f/DE6txQWeYW/eWSo9YUo0o5ywsfIiq6ikZCcbQgccoykR
         m2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686745640; x=1689337640;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tpL5hXtIyhIRi/GwJoVA2zr42fL6oE2lmW7B3Boiq0A=;
        b=I2qzrPfSfToqV+z19ly5ylhIwgDBIIEu90ibzI8Z6cKaHU8Xpms4pj0OVaE177r7Rs
         f5uuOZcks2WcJYzGXfXiSv7yUswi8eJvtEZ0BAB7vvZyMIzhB4Sk4uIdxuV9dzEZOVB5
         2vSWRWuNtjfx+sPcayY39xAg6wnzL3IWbDwP+qcaV4L4MzzQo+684drjWVlKjpzqdVap
         JVsUyT0lhmoNlg95l7R28wOOc7IBzNVCJhi0ks376Jt7boOe1Ungme5yAnF9Mz9pmD+x
         1a+Ohvo3Hjwu/97EtF93V3SvKOYx5JE5efDiavIIsLs/hmVGCdN30mHj4O6j+D0RACB6
         AUaQ==
X-Gm-Message-State: AC+VfDwhOVnMyovXmXlZWfzgOE8YtCN4BehJe4Sq4z5xvngM92jajMJD
	peZ09PtugKcSjA2EKXsnp2w+CfP8hI7ANhLI4qhVaQ==
X-Google-Smtp-Source: ACHHUZ6F4jBEvAV2H81OHK04h1Sb1aTsVy4ZtEqKBM/ybE7KyiDvIYBQIiXdfflCDzq2KSzNXb0UHA==
X-Received: by 2002:a05:6a20:8e24:b0:105:e434:670b with SMTP id y36-20020a056a208e2400b00105e434670bmr2039972pzj.4.1686745639943;
        Wed, 14 Jun 2023 05:27:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h7-20020aa786c7000000b006662f36c381sm1429856pfo.144.2023.06.14.05.27.19
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 05:27:19 -0700 (PDT)
Message-ID: <6489b227.a70a0220.8079c.2aa0@mx.google.com>
Date: Wed, 14 Jun 2023 05:27:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-191-gf4efde512959
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 70 runs,
 9 regressions (v5.10.182-cip35-191-gf4efde512959)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 12:27:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12010

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 70 runs, 9 regress=
ions (v5.10.182-cip35-191-gf4efde512959)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.182-cip35-191-gf4efde512959/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.182-cip35-191-gf4efde512959
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f4efde5129594b413888498ce6f27da48a03771e =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489a472bd223b5e57306140

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oct=
opus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oct=
opus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6489a472bd223b5e57306145
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T11:28:57.778077  + set +x

    2023-06-14T11:28:57.784981  [   21.672094] <LAVA_SIGNAL_ENDRUN 0_dmesg =
10723644_1.5.2.3.1>

    2023-06-14T11:28:57.889344  / # #

    2023-06-14T11:28:57.991887  export SHELL=3D/bin/sh

    2023-06-14T11:28:57.992686  #

    2023-06-14T11:28:58.093951  / # export SHELL=3D/bin/sh. /lava-10723644/=
environment

    2023-06-14T11:28:58.094717  =


    2023-06-14T11:28:58.196178  / # . /lava-10723644/environment/lava-10723=
644/bin/lava-test-runner /lava-10723644/1

    2023-06-14T11:28:58.196423  =


    2023-06-14T11:28:58.200973  / # /lava-10723644/bin/lava-test-runner /la=
va-10723644/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6489a6da9e69ca3fca306144

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr=
-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr=
-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6489a6da9e69ca3fca306149
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T11:38:49.473043  + set +x

    2023-06-14T11:38:49.479826  <8>[   24.178342] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10723800_1.5.2.3.1>

    2023-06-14T11:38:49.586240  / # #

    2023-06-14T11:38:49.686815  export SHELL=3D/bin/sh

    2023-06-14T11:38:49.687037  #

    2023-06-14T11:38:49.787556  / # export SHELL=3D/bin/sh. /lava-10723800/=
environment

    2023-06-14T11:38:49.787742  =


    2023-06-14T11:38:49.888371  / # . /lava-10723800/environment/lava-10723=
800/bin/lava-test-runner /lava-10723800/1

    2023-06-14T11:38:49.889252  =


    2023-06-14T11:38:49.893711  / # /lava-10723800/bin/lava-test-runner /la=
va-10723800/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489a494b6f919ef1e306154

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6489a494b6f919ef1e306159
        failing since 54 days (last pass: v5.10.168-cip27-109-g23841ec76bec=
, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T11:29:11.311799  + set +x

    2023-06-14T11:29:11.317693  <8>[   20.443701] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10723648_1.5.2.3.1>

    2023-06-14T11:29:11.431647  / # #

    2023-06-14T11:29:11.534117  export SHELL=3D/bin/sh

    2023-06-14T11:29:11.534922  #

    2023-06-14T11:29:11.636465  / # export SHELL=3D/bin/sh. /lava-10723648/=
environment

    2023-06-14T11:29:11.637314  =


    2023-06-14T11:29:11.739093  / # . /lava-10723648/environment/lava-10723=
648/bin/lava-test-runner /lava-10723648/1

    2023-06-14T11:29:11.740441  =


    2023-06-14T11:29:11.745572  / # /lava-10723648/bin/lava-test-runner /la=
va-10723648/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6489a6bef39cc1267430612f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.t=
xt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6489a6bef39cc12674306134
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T11:38:28.181431  + set<8>[   21.402595] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10723796_1.5.2.3.1>

    2023-06-14T11:38:28.181540   +x

    2023-06-14T11:38:28.287375  / # #

    2023-06-14T11:38:28.389662  export SHELL=3D/bin/sh

    2023-06-14T11:38:28.390380  #

    2023-06-14T11:38:28.491836  / # export SHELL=3D/bin/sh. /lava-10723796/=
environment

    2023-06-14T11:38:28.492594  =


    2023-06-14T11:38:28.593920  / # . /lava-10723796/environment/lava-10723=
796/bin/lava-test-runner /lava-10723796/1

    2023-06-14T11:38:28.595051  =


    2023-06-14T11:38:28.600188  / # /lava-10723796/bin/lava-test-runner /la=
va-10723796/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6489a977675dcc605c306135

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6489a977675dcc605=
c306136
        new failure (last pass: v5.10.182-cip35-8-gc3d08808cfa7) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b1d583b5df18e6306130

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc=
.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6489b1d583b5df18e=
6306131
        failing since 9 days (last pass: v5.10.180-cip33-21-g090289427e8b2,=
 first fail: v5.10.180-cip34-19-gae79bc689058c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6489a846df14bfcccb30613a

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/6489a846df14bfcccb306140
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T11:44:58.076505  <8>[   95.387496] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-06-14T11:44:59.130551  /lava-10723850/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/6489a846df14bfcccb306141
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T11:44:56.986199  <8>[   94.298072] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-06-14T11:44:58.041307  /lava-10723850/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6489acb1d5faa76504306171

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6489acb1d5faa7650=
4306172
        new failure (last pass: v5.10.182-cip35-8-gc3d08808cfa7) =

 =20

