Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A55EB64D7
	for <webhook@archiver.kernel.org>; Fri, 23 Jun 2023 12:44:05 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web10.40984.1687524235409363229
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Jun 2023 05:43:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=QeDSEa33;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-666eec46206so368783b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 23 Jun 2023 05:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687524234; x=1690116234;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F/vVNMB3COfh7g+uD4swAwz3k+GL4zKPbdtaT5chPnM=;
        b=QeDSEa33C51SLZ6Q/goCwtHGXoIl15e1WtB+oJ97EC2zM4fo04GRBRh0xD7loQSwA0
         eR8GnokA+o9hV0uYUmBga4/l1JY+TZ2RbVhe3rVhMFEtrwBZaaO6C9tCgga41km2NcxN
         1UFpXhuuJUaRcRPyMu5mfG0phoufD9DHgIRXbbWdbhI9PgAtU0EwclgJHANIDpHTjgf5
         zOy9QmPdQIHekw+/RrmwRx7UdPJjt9FnZNZnRm/w2KpKYTVCQbJjVinDZD8bQdW7qSLB
         muMCITvBpiNke/6hwl0YZe+GJWVWRlFTGzeoxs+RCPOdVPF1wZWc1zVCDxuy22GQAmm7
         Cppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687524234; x=1690116234;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/vVNMB3COfh7g+uD4swAwz3k+GL4zKPbdtaT5chPnM=;
        b=R033D5yIDUCpaV5MgGXqS75PrDGSx5fRKvehnQ9bYkeo05BEcIUdYNWuaCc28KwKrY
         IScG2JbDuQM+zU4PJv0Qrs+nG5itoj5M4SySrgMu4l5pR2Vpn9Ql21oNmWmN2H405q4x
         soMob4SmhCknsA0/GEY7e2ZLKjMiw+IwT2sEQyjcoVWWY4wS7bFzLnQbQIZTkbJEJ6zn
         tpfUjg/H7zToijSP8q6gYJrq27/nG+CoTmnP9x2huaz/IxC73CcGV/5yRSv+7lByp/ZU
         4azLAnhK5YGZcR5CmWIJDGAAUkW+hOarMAxjUN0fsBIA1OqzAwKBpYbKSEXa7LmxPRBq
         AA/w==
X-Gm-Message-State: AC+VfDyTorxIYQ4DAKee3l8WXxOAWxUMRmZxTUe4iCI07sYauyMqglKl
	FPG+f5pVNso/64q98FA+rij8tTCIGi2zCUKnpFsn+g==
X-Google-Smtp-Source: ACHHUZ6Dvg43frYwipoG8MnIc9engabkLr96wKy4FBsQbvlEbE3QuD7xSKQXYxHhS6/GpgJ7HAYhvQ==
X-Received: by 2002:a05:6a20:728e:b0:122:4a16:dfa4 with SMTP id o14-20020a056a20728e00b001224a16dfa4mr13365366pzk.10.1687524233838;
        Fri, 23 Jun 2023 05:43:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090322c800b001aae625e422sm7138321plg.37.2023.06.23.05.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 05:43:52 -0700 (PDT)
Message-ID: <64959388.170a0220.1687c.f8d4@mx.google.com>
Date: Fri, 23 Jun 2023 05:43:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.287-cip100
Subject: cip/linux-4.19.y-cip baseline: 120 runs,
 21 regressions (v4.19.287-cip100)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Jun 2023 12:44:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12138

cip/linux-4.19.y-cip baseline: 120 runs, 21 regressions (v4.19.287-cip100)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
beaglebone-black           | arm   | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | cip://4.19.=
y-...64_defconfig | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | cip://4.19.=
y-...64_defconfig | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

rk3399-gru-kevin           | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.287-cip100/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.287-cip100
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      843423b3724d762d5593ab9aaeb68ac695871b44 =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
beaglebone-black           | arm   | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/649589936111ce74e630614a

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-blac=
k.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-blac=
k.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649589936111ce74e630617e
        failing since 13 days (last pass: v4.19.283-cip98, first fail: v4.1=
9.284-cip99)

    2023-06-23T12:00:46.542463  + set +x<8>[   17.475545] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 657205_1.5.2.4.1>
    2023-06-23T12:00:46.542861  =

    2023-06-23T12:00:46.653817  / # #
    2023-06-23T12:00:46.756092  export SHELL=3D/bin/sh
    2023-06-23T12:00:46.756674  #
    2023-06-23T12:00:46.858413  / # export SHELL=3D/bin/sh. /lava-657205/en=
vironment
    2023-06-23T12:00:46.859151  =

    2023-06-23T12:00:46.961086  / # . /lava-657205/environment/lava-657205/=
bin/lava-test-runner /lava-657205/1
    2023-06-23T12:00:46.962155  =

    2023-06-23T12:00:46.967202  / # /lava-657205/bin/lava-test-runner /lava=
-657205/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6495870fd2376803aa30612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6495870fd2376803aa306=
12f
        failing since 304 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64958a555fac95102b30612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_a=
rm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_a=
rm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64958a555fac95102b306=
12f
        failing since 304 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/649586f81eb0ef4fca306132

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649586f81eb0ef4fca306=
133
        failing since 304 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649588d2f26f084060306145

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu=
_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu=
_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649588d2f26f084060306=
146
        failing since 304 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/649587acca4a916ee3306152

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-u=
efi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-u=
efi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649587acca4a916ee3306=
153
        failing since 304 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64958af5d1e3b3544a306150

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_a=
rm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_a=
rm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64958af5d1e3b3544a306=
151
        failing since 304 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/649586f91eb0ef4fca306135

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2=
-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2=
-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649586f91eb0ef4fca306=
136
        failing since 304 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649588da76c5929a0230612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu=
_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu=
_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649588da76c5929a02306=
12f
        failing since 304 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | cip://4.19.=
y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64958bd1a70c2c72bd30613c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: cip://4.19.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/cip---4.19.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-brooni=
e/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/cip---4.19.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-brooni=
e/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64958bd1a70c2c72bd306=
13d
        failing since 304 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | cip://4.19.=
y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64958a91b030000d9d30614f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: cip://4.19.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/cip---4.19.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-collab=
ora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/cip---4.19.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-collab=
ora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64958a91b030000d9d306=
150
        failing since 304 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6495870e79099c8cce306150

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6495870e79099c8cce306=
151
        failing since 304 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64958a565fac95102b306134

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_a=
rm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_a=
rm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64958a565fac95102b306=
135
        failing since 304 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/649586f21eb0ef4fca30612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649586f21eb0ef4fca306=
12f
        failing since 304 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649588d9ff3696d340306137

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu=
_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu=
_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649588d9ff3696d340306=
138
        failing since 304 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6495870c79099c8cce30614a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-u=
efi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-u=
efi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6495870c79099c8cce306=
14b
        failing since 304 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64958aa5b030000d9d306164

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_a=
rm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_a=
rm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64958aa5b030000d9d306=
165
        failing since 304 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/649586f127e19696eb306163

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3=
-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3=
-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649586f127e19696eb306=
164
        failing since 304 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/649588d3f26f08406030614b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu=
_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu=
_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649588d3f26f084060306=
14c
        failing since 304 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin           | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/649587f40c29f01a7d306133

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk33=
99-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk33=
99-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/649587f40c29f01a7d30613d
        failing since 93 days (last pass: v4.19.276-cip93, first fail: v4.1=
9.277-cip94)

    2023-06-23T11:54:23.343615  /lava-10875977/1/../bin/lava-test-case

    2023-06-23T11:54:23.352650  <8>[   37.557675] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/649587f40c29f01a7d30613e
        failing since 93 days (last pass: v4.19.276-cip93, first fail: v4.1=
9.277-cip94)

    2023-06-23T11:54:21.308390  <8>[   35.513123] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-06-23T11:54:22.321964  /lava-10875977/1/../bin/lava-test-case

    2023-06-23T11:54:22.330703  <8>[   36.535980] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

