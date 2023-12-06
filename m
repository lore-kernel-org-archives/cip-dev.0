Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC18C4167B
	for <webhook@archiver.kernel.org>; Wed,  6 Dec 2023 07:04:55 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web10.26200.1701846291525628572
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Dec 2023 23:04:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=l3VT/sGS;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ce7c1b07e1so971525b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 05 Dec 2023 23:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701846290; x=1702451090; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OLK0H+mw6356ACVRnY9wKtl2RrQDvaLs5QjPiRQi5t8=;
        b=l3VT/sGS8ZxlKaxLTEudeE7Mwwyt7dNVpGm0HkdPLUrFeXYIuAQCcKO0mfU2/xGJBL
         pWriWa1oScd+ihNLsX/7NDpgjBFrrGqjbchgcHdVYtYmV6lNEteHdcgi91UygKM2G12T
         gLg5hvrC4emFkvNiLpPxO/p2r9VUuxNV5m5oO3cvIOisnn+htAqsQkWljwcrAYrS+d2H
         0oNbIJMen8dSTwG7myITGNTBDeGx8ngNOyNzmDQR65HVtk/+FLhMhZ5ZtN7ZrT+vYYS3
         Rm0HTQbecO6va+iSuIBubYyb/PTRSG2uRCh8sRdsHK50F6D1Cb7hD+yMAOePbfbfDwhx
         5WXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701846290; x=1702451090;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLK0H+mw6356ACVRnY9wKtl2RrQDvaLs5QjPiRQi5t8=;
        b=Q5Lq06ceUZvwWHwYT7ws4ismg9iB0oF1vZHI5cgu1YOmR/ZX5ZoukFVPmtcdYOyE1H
         kuUS49Nx/DyfuM1HNWxJe+xX7ziv1hpsOEct6cXCtV4qxzpOtHKYl0CSB8NAINDmy1IM
         uHBttl+iWjz2aPlAiG22LDykFeDgeGWqo/SZMSgsXMTq2sZKJX8VjcuI5GYMc4hOyUjP
         WkJHovR5eUAx1r1BRzXc05mjiP6EAVUWy/li/SbUKoYsIWY2m3FL7PEP4h5b+v81MEeh
         h1pumuO/9YYy4ydVcROOMCAf6CCLNxQsHHYEiMhv3IhBVgdO1sbVCAI1bpdNsOl8s0ix
         Erfg==
X-Gm-Message-State: AOJu0Yyqupv9O6PYwFaIFYBUgsNHEMumZW1qSHx0qNnpBfB++VyDazyv
	QcUPRQx5hzDzDqFPKCdND6a0ZYRAF/2sr4G91Y6Axg==
X-Google-Smtp-Source: AGHT+IFuI5lCA/MkvtpM9Glfmt4fzkyiuczaNY82P8O1I+8sLt8yMClt4BE7fA/ZjER/4ByofA2T+g==
X-Received: by 2002:a05:6a00:218e:b0:6ce:3935:fa72 with SMTP id h14-20020a056a00218e00b006ce3935fa72mr426106pfi.41.1701846290129;
        Tue, 05 Dec 2023 23:04:50 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t189-20020a6281c6000000b00690c0cf97c9sm10919893pfd.73.2023.12.05.23.04.48
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 23:04:49 -0800 (PST)
Message-ID: <65701d11.620a0220.67d9e.0673@mx.google.com>
Date: Tue, 05 Dec 2023 23:04:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-16-g3c85fba3b6e5d
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 45 runs,
 25 regressions (v5.10.201-cip41-16-g3c85fba3b6e5d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Dec 2023 07:04:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13795

cip-gitlab/ci/pavel/linux-test baseline-nfs: 45 runs, 25 regressions (v5.10=
.201-cip41-16-g3c85fba3b6e5d)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

acer-chromebox-cxi5-brask    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig          | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig         | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig        | 1          =

imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 10         =

kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g                  | 3          =

kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g                  | 3          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-cip41-16-g3c85fba3b6e5d/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-cip41-16-g3c85fba3b6e5d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3c85fba3b6e5da8b112e7ecd142649674648028f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65700ef3515dd3d462e1347c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65700ef3515dd3d46=
2e1347d
        new failure (last pass: v6.1.64-cip10-rt5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-chromebox-cxi5-brask    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65700efeaf31925ad3e1348e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-chromebox-cxi5-brask.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-chromebox-cxi5-brask.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65700efeaf31925ad=
3e1348f
        new failure (last pass: v6.1.64-cip10-rt5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/657011d84ef4f05469e13478

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/657011d84ef4f0546=
9e13479
        new failure (last pass: v6.1.64-cip10-rt5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/6570132da3bbdf3a28e134a3

  Results:     48 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id=
/6570132da3bbdf3a28e134a8
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:22:30.698229  /lava-313505/1/../bin/lava-test-case
    2023-12-06T06:22:30.804472  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65700fd054e1c18d69e1347b

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/65700fd054e1c18d69e13495
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:08:08.291878  /lava-313442/1/../bin/lava-test-case
    2023-12-06T06:08:08.375506  <8>[   51.756725] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/657010ce1d51b83c83e134ae

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/=
id/657010ce1d51b83c83e134c7
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:12:19.054025  /lava-1052589/1/../bin/lava-test-case
    2023-12-06T06:12:19.118993  <8>[   46.448353] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/657019148a9e99fa72e13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/657019148a9e99fa7=
2e13476
        new failure (last pass: v6.1.64-cip10-rt5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65701a8c1b40cedfa1e1347c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65701a8c1b40cedfa=
1e1347d
        new failure (last pass: v6.1.64-cip10-rt5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 10         =


  Details:     https://kernelci.org/test/plan/id/657012a08b93a6eea1e1347e

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.led7-probed: https://kernelci.org/test/case/id/6570=
12a08b93a6eea1e1348b
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:20:04.327338  /lava-313478/1/../bin/lava-test-case
    2023-12-06T06:20:04.364171  <8>[   71.517790] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led6-probed: https://kernelci.org/test/case/id/6570=
12a08b93a6eea1e1348c
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:20:03.244230  /lava-313478/1/../bin/lava-test-case
    2023-12-06T06:20:03.288222  <8>[   70.442921] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led5-probed: https://kernelci.org/test/case/id/6570=
12a08b93a6eea1e1348d
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:20:02.157238  /lava-313478/1/../bin/lava-test-case
    2023-12-06T06:20:02.205191  <8>[   69.363017] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led4-probed: https://kernelci.org/test/case/id/6570=
12a08b93a6eea1e1348e
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:20:01.081130  /lava-313478/1/../bin/lava-test-case
    2023-12-06T06:20:01.118075  <8>[   68.273342] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led3-probed: https://kernelci.org/test/case/id/6570=
12a08b93a6eea1e1348f
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:19:59.995161  /lava-313478/1/../bin/lava-test-case
    2023-12-06T06:20:00.042049  <8>[   67.197241] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led2-probed: https://kernelci.org/test/case/id/6570=
12a08b93a6eea1e13490
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:19:58.445446  <4>[   65.580539] amba 20010000.etf: deferr=
ed probe timeout, ignoring dependency
    2023-12-06T06:19:58.445799  <4>[   65.587730] amba 20030000.tpiu: defer=
red probe timeout, ignoring dependency
    2023-12-06T06:19:58.446094  <4>[   65.594996] amba 20040000.funnel: def=
erred probe timeout, ignoring dependency
    2023-12-06T06:19:58.446333  <4>[   65.602438] amba 20070000.etr: deferr=
ed probe timeout, ignoring dependency
    2023-12-06T06:19:58.446529  <4>[   65.609615] amba 20100000.stm: deferr=
ed probe timeout, ignoring dependency
    2023-12-06T06:19:58.488669  <4>[   65.616789] amba 20120000.replicator:=
 deferred probe timeout, ignoring dependency
    2023-12-06T06:19:58.489028  <4>[   65.624573] amba 22010000.cpu-debug: =
deferred probe timeout, ignoring dependency
    2023-12-06T06:19:58.489225  <4>[   65.632277] amba 22040000.etm: deferr=
ed probe timeout, ignoring dependency
    2023-12-06T06:19:58.489623  <4>[   65.639451] amba 220c0000.funnel: def=
erred probe timeout, ignoring dependency
    2023-12-06T06:19:58.489791  <4>[   65.646889] amba 22110000.cpu-debug: =
deferred probe timeout, ignoring dependency =

    ... (12 line(s) more)  =


  * baseline-nfs.bootrr.led1-probed: https://kernelci.org/test/case/id/6570=
12a08b93a6eea1e13491
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:19:57.404331  <4>[   64.557319] arm-smmu 2b600000.iommu: =
deferred probe timeout, ignoring dependency
    2023-12-06T06:19:57.407452  <4>[   64.565022] arm-smmu: probe of 2b6000=
00.iommu failed with error -110
    2023-12-06T06:19:57.823188  /lava-313478/1/../bin/lava-test-case
    2023-12-06T06:19:57.871149  <8>[   65.028460] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.iommu1-probed: https://kernelci.org/test/case/id/65=
7012a08b93a6eea1e134a4
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:19:54.541010  /lava-313478/1/../bin/lava-test-case
    2023-12-06T06:19:54.582065  <8>[   61.736754] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case=
/id/657012a18b93a6eea1e134b1
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:19:52.610881  /lava-313478/1/../bin/lava-test-case
    2023-12-06T06:19:52.649692  <8>[   59.805047] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led0-probed: https://kernelci.org/test/case/id/6570=
12a18b93a6eea1e134ba
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:19:56.748220  /lava-313478/1/../bin/lava-test-case
    2023-12-06T06:19:56.786260  <8>[   63.941319] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g                  | 3          =


  Details:     https://kernelci.org/test/plan/id/65701132ff5c31f449e13475

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/65701132ff5c31f449e134b5
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:13:55.260529  /lava-402292/1/../bin/lava-test-case
    2023-12-06T06:13:55.263697  <8>[   22.199080] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/65701132ff5c31f449e134b6
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:13:56.270446  /lava-402292/1/../bin/lava-test-case
    2023-12-06T06:13:56.299094  <8>[   23.236461] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-12-06T06:13:57.322562  /lava-402292/1/../bin/lava-test-case
    2023-12-06T06:13:57.344515  <8>[   24.282144] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/65701132ff5c31f449e134cd
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:14:00.382920  /lava-402292/1/../bin/lava-test-case
    2023-12-06T06:14:00.409625  <8>[   27.346885] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g                  | 3          =


  Details:     https://kernelci.org/test/plan/id/65701146af5b3c600ae1347e

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/65701147af5b3c600ae134c5
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:14:13.310762  <8>[   15.482685] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dpci-host-generic-probed RESULT=3Dpass>
    2023-12-06T06:14:14.317387  /lava-402290/1/../bin/lava-test-case
    2023-12-06T06:14:14.343477  <8>[   16.517081] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/65701147af5b3c600ae134c6
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:14:15.365696  /lava-402290/1/../bin/lava-test-case
    2023-12-06T06:14:15.386623  <8>[   17.559391] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-12-06T06:14:16.393220  /lava-402290/1/../bin/lava-test-case
    2023-12-06T06:14:16.424010  <8>[   18.597757] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/65701147af5b3c600ae134db
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:14:19.267629  /lava-402290/1/../bin/lava-test-case
    2023-12-06T06:14:19.294586  <8>[   21.468223] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/657013cd6f45c12d46e13475

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.sound-card: https://kernelci.org/test/case/id/65701=
3cd6f45c12d46e13478
        new failure (last pass: v6.1.64-cip10-rt5)

    2023-12-06T06:24:58.057271  /lava-313504/1/../bin/lava-test-case
    2023-12-06T06:24:58.583676  <8>[   81.699003] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =

 =20

