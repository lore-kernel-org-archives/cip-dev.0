Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE69C77B76
	for <webhook@archiver.kernel.org>; Thu, 20 Apr 2023 14:53:38 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.10210.1682002415959794669
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Apr 2023 07:53:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=wd5EF4GA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1a6715ee82fso12908725ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Apr 2023 07:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682002415; x=1684594415;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PT6Qc2mgTkHWVDq/71BN9hyB7XXglus563+gCDDMm8s=;
        b=wd5EF4GARa8vjl/TS5Iiamiyp6rnHsIGPjZmDb6NiaIOuYrlsKv7uQgM3kbWT0b3Nf
         tfWNpM4iSq2R2GN1wFYfvunum02Vh7aQszUSA4Xby9gEJAXxRhcWv8CoQBNV/VzP3PzY
         WPXoHlbFDxAZ4T8ImIDI8nXwm7SfeIPT4cbA9fSYYCVQUoplQt7XjFtapg0mWirL48vX
         ske2Kh0nrNBco0zTg8pzQQ06DSQBKuFEarJLT/ZaDa/zxkR9/3/2vy+FJyDk+RrWoYhA
         U5SuvhFsI4cc4GmTDcmhBmjYDSsjFSWJYlNzoMQvHrbVVnx74w3nu8aJKHvHH5+0wVKS
         eIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682002415; x=1684594415;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PT6Qc2mgTkHWVDq/71BN9hyB7XXglus563+gCDDMm8s=;
        b=YOYpwkCQ6NckuLfmB7czzKyNgYYluN6T3vhOsJWtJypYC3+55Jkx6NYbMvCioXynMP
         2OsnLez191NCmaTCwjIQiYl4XVMUDfsJcURDI6KS8c2Tl6fZSGGM40aY3NKwxwanNfNF
         HSXnLG7AGt0x5RK/rN0owW09lXZoRa5T6/Cle0jD0A4fIKNtmNDBRe2Mr5FYon/Qf3m8
         lfJYF9Kd6fBt7tzDxrhnaj2oi/OEWVt6OpChJf9iR/Hvglaxr+Mx8cCwn9Sm8qEjsI4R
         luP42FDzz/aRnIUGRkVtSJ8IFU9tp/u5RQ9FGF7MdbWwVvrlMkVvC8I0YNNDai7s/HgR
         RTjQ==
X-Gm-Message-State: AAQBX9dNSMlJ6VqYZfeIL6fW73Xe4tVOR95c8scHRkQgNEFhjtV0xhBW
	iRbcFDXe1SPuRNQcx7M6l/L6n22wrmp9fEjDV323C8Wc
X-Google-Smtp-Source: AKy350bnePCRNAOYblx/D5CMUEmTMEfqYXEuyr5maVNsNQb+YgJpxb80mP1osB1wUcetJgUaTZBWew==
X-Received: by 2002:a17:902:ba8a:b0:1a5:1b94:e63d with SMTP id k10-20020a170902ba8a00b001a51b94e63dmr1750687pls.65.1682002414933;
        Thu, 20 Apr 2023 07:53:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m19-20020a170902bb9300b001a4edbab9c4sm1249754pls.254.2023.04.20.07.53.34
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 07:53:34 -0700 (PDT)
Message-ID: <644151ee.170a0220.c3cd9.2501@mx.google.com>
Date: Thu, 20 Apr 2023 07:53:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.177-cip31-122-gfb6ca504156b4
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 75 runs,
 9 regressions (v5.10.177-cip31-122-gfb6ca504156b4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Apr 2023 14:53:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11246

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 75 runs, 9 regress=
ions (v5.10.177-cip31-122-gfb6ca504156b4)

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

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.177-cip31-122-gfb6ca504156b4/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.177-cip31-122-gfb6ca504156b4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      fb6ca504156b4789acc2b019a0aaeae91c6d73dc =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64414786a31bd974182e8605

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oc=
topus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oc=
topus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64414786a31bd974182e860a
        new failure (last pass: v5.10.168-cip27-638-g0d599cd2b6695)

    2023-04-20T14:08:49.522212  + set +x<8>[   18.811535] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10062539_1.5.2.3.1>

    2023-04-20T14:08:49.522311  =


    2023-04-20T14:08:49.627112  / # #

    2023-04-20T14:08:49.727970  export SHELL=3D/bin/sh

    2023-04-20T14:08:49.728180  #

    2023-04-20T14:08:49.829131  / # export SHELL=3D/bin/sh. /lava-10062539/=
environment

    2023-04-20T14:08:49.829345  =


    2023-04-20T14:08:49.930298  / # . /lava-10062539/environment/lava-10062=
539/bin/lava-test-runner /lava-10062539/1

    2023-04-20T14:08:49.930601  =


    2023-04-20T14:08:49.935696  / # /lava-10062539/bin/lava-test-runner /la=
va-10062539/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6441487394fb9e11bd2e8612

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010n=
r-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010n=
r-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6441487394fb9e11bd2e8617
        new failure (last pass: v5.10.168-cip27-638-g0d599cd2b6695)

    2023-04-20T14:12:55.371893  + set +x

    2023-04-20T14:12:55.378350  [   23.696129] <LAVA_SIGNAL_ENDRUN 0_dmesg =
10062609_1.5.2.3.1>

    2023-04-20T14:12:55.488537  / # #

    2023-04-20T14:12:55.591479  export SHELL=3D/bin/sh

    2023-04-20T14:12:55.592311  #

    2023-04-20T14:12:55.694207  / # export SHELL=3D/bin/sh. /lava-10062609/=
environment

    2023-04-20T14:12:55.695102  =


    2023-04-20T14:12:55.797254  / # . /lava-10062609/environment/lava-10062=
609/bin/lava-test-runner /lava-10062609/1

    2023-04-20T14:12:55.798558  =


    2023-04-20T14:12:55.803444  / # /lava-10062609/bin/lava-test-runner /la=
va-10062609/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644147306448b9971d2e860a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/644147306448b9971d2e860f
        new failure (last pass: v5.10.168-cip27-109-g23841ec76bec)

    2023-04-20T14:07:26.130950  + [   18.897516] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 10062569_1.5.2.3.1>

    2023-04-20T14:07:26.133641  set +x

    2023-04-20T14:07:26.238853  / # #

    2023-04-20T14:07:26.339937  export SHELL=3D/bin/sh

    2023-04-20T14:07:26.340126  #

    2023-04-20T14:07:26.440921  / # export SHELL=3D/bin/sh. /lava-10062569/=
environment

    2023-04-20T14:07:26.441084  =


    2023-04-20T14:07:26.542024  / # . /lava-10062569/environment/lava-10062=
569/bin/lava-test-runner /lava-10062569/1

    2023-04-20T14:07:26.542328  =


    2023-04-20T14:07:26.547137  / # /lava-10062569/bin/lava-test-runner /la=
va-10062569/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6441482030913786f92e8658

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.=
txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6441482030913786f92e865d
        new failure (last pass: v5.10.168-cip27-638-g0d599cd2b6695)

    2023-04-20T14:11:32.159825  + set[   18.395272] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10062616_1.5.2.3.1>

    2023-04-20T14:11:32.159933   +x

    2023-04-20T14:11:32.264011  / # #

    2023-04-20T14:11:32.364959  export SHELL=3D/bin/sh

    2023-04-20T14:11:32.365112  #

    2023-04-20T14:11:32.466024  / # export SHELL=3D/bin/sh. /lava-10062616/=
environment

    2023-04-20T14:11:32.466184  =


    2023-04-20T14:11:32.567108  / # . /lava-10062616/environment/lava-10062=
616/bin/lava-test-runner /lava-10062616/1

    2023-04-20T14:11:32.567350  =


    2023-04-20T14:11:32.572665  / # /lava-10062616/bin/lava-test-runner /la=
va-10062616/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6441497ccfc899cbb82e85f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6441497ccfc899cbb=
82e85f2
        new failure (last pass: v5.10.168-cip27-638-g0d599cd2b6695) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6441492797c8e84bad2e85f1

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/6441492797c8e84bad2e85f7
        new failure (last pass: v5.10.168-cip27-638-g0d599cd2b6695)

    2023-04-20T14:16:00.431731  /lava-10062654/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/6441492797c8e84bad2e85f8
        new failure (last pass: v5.10.168-cip27-638-g0d599cd2b6695)

    2023-04-20T14:15:58.278571  <8>[   93.614356] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-04-20T14:15:59.343250  /lava-10062654/1/../bin/lava-test-case

    2023-04-20T14:15:59.379423  <8>[   94.716278] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/64414c0de290db5c5f2e85f1

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64414c0de290db5c5f2e85f7
        new failure (last pass: v5.10.168-cip27-638-g0d599cd2b6695)

    2023-04-20T14:28:21.576450  [   56.768158] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-04-20T14:28:22.732936  /lava-10062723/1/../bin/lava-test-case

    2023-04-20T14:28:22.813196  [   58.007090] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64414c0de290db5c5f2e85f8
        new failure (last pass: v5.10.168-cip27-638-g0d599cd2b6695)

    2023-04-20T14:28:21.494342  /lava-10062723/1/../bin/lava-test-case
   =

 =20

