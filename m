Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A1AC43334
	for <webhook@archiver.kernel.org>; Fri,  8 Jul 2022 23:01:22 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web10.996.1657321278452942256
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Jul 2022 16:01:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=cXI3NFm2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f175.google.com with SMTP id 72so215324pge.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Jul 2022 16:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=/suqa7lu+OfJ5s05tP27550a50AXlxwr0svXirGO2vg=;
        b=cXI3NFm2woFlPzgmfhibdIQUR0nmBB3akAi6K8HG4Gex4gLYX/dg1+628W/1Gl0mKB
         0fGJh3VaYcQ8hjb7vCKo5ZUf4dszNGSCOdRcJrLT2Jhazd0S4ke4seFZ37h2wU5G32pV
         +x/+ahE7TDRCinY8nBT7wq2jAJVeEwmHDNQDJ43p8fwlky5lBOgKvtYnJ23knOdDZWcc
         6vl3CxfYBnLsckcuqkMiVChCyOMrCoiXwuOWUkrrMiHst5rmuTdWp7iqskxmv0IKjlr7
         oHw+WOXnkNBVBPWu9LXPuIwvEWliFL8SHFS6QJq9l1k46+ljH3A3o9Wb/om6XYXTGKjc
         eUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=/suqa7lu+OfJ5s05tP27550a50AXlxwr0svXirGO2vg=;
        b=UjI1Mx928osJNLn8XkequUC03eBybP2paRelEou6AiaC6iJtTl8A1YjCgK/V+mWfJu
         71jq998MeGcudgZWFRSEp5WLcuPoexqpqzMGakXAoDbs2OhoVVSvpr1nsNEMRXAda9Hj
         KxSgLG4edtDmg8FpE63vxnf897ojNAJhW5PfX83r2I5FOKLXqVTO/1xjNyURysZrDlHs
         EdR4r7xQCNAyAXCqW4V9BQVPu+S0t2nLu/XUT3hFBZ7LcnMRq116XF6LbHmbMlXqchmz
         Zz00eAIpffq0pD85TVA7Kkh3WEQMa2D7ij59JYxFE7yViAVjmdJddLkaA9i7n8uUSZ6v
         a6DQ==
X-Gm-Message-State: AJIora8FObsUdJxw/xKV9u17JYvhvVoPHPH29C6Q5DeZ25njr+rYmsvG
	ZQ5ZXXEWD5ETCtPxB65i0ZsPpHN+oDIdL6Wa
X-Google-Smtp-Source: 
 AGRyM1upi7TWKyukfYYGvind4Uuqeti15S8ymwjzZhlcFqHrkRt/eFKNUNa6Zu7kcSQqc3bJNYuB2w==
X-Received: by 2002:a63:e758:0:b0:412:28d8:6c85 with SMTP id
 j24-20020a63e758000000b0041228d86c85mr5121553pgk.283.1657321277223;
        Fri, 08 Jul 2022 16:01:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 z2-20020a1709027e8200b0016be2bb8e68sm27224pla.303.2022.07.08.16.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 16:01:16 -0700 (PDT)
Message-ID: <62c8b73c.1c69fb81.a1387.00eb@mx.google.com>
Date: Fri, 08 Jul 2022 16:01:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.251-cip77
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip baseline: 147 runs,
 23 regressions (v4.19.251-cip77)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Jul 2022 23:01:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8728

cip/linux-4.19.y-cip baseline: 147 runs, 23 regressions (v4.19.251-cip77)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
da850-lcdk                 | arm   | lab-baylibre  | gcc-10   | davinci_all=
_defconfig        | 2          =

jetson-tk1                 | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =

jetson-tk1                 | arm   | lab-baylibre  | gcc-10   | tegra_defco=
nfig              | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | cip://4.19.=
y-...64_defconfig | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | cip://4.19.=
y-...64_defconfig | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =

rk3399-gru-kevin           | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.251-cip77/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.251-cip77
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e634159f2620ade28a9251a9bc2cc23b84f527f2 =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
da850-lcdk                 | arm   | lab-baylibre  | gcc-10   | davinci_all=
_defconfig        | 2          =


  Details:     https://kernelci.org/test/plan/id/62c8afaac23d1cc63da39bcd

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: davinci_all_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm/davinci_all_defconfig/gcc-10/lab-baylibre/baseline-da850-lcdk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm/davinci_all_defconfig/gcc-10/lab-baylibre/baseline-da850-lcdk.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/62c8afaac23d1cc=
63da39bd0
        new failure (last pass: v4.19.249-cip76)
        4 lines

    2022-07-08T22:28:41.933070  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dale=
rt RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D6>
    2022-07-08T22:28:42.072159  kern  :emerg : page:c6f51000 count:0 mapcou=
nt:-128 mapping:00000000 index:0x4
    2022-07-08T22:28:42.072551  kern  :emerg : flags: 0x0()
    2022-07-08T22:28:42.074857  kern  :emerg : page:c6f59000 count:0 mapcou=
nt:-128 mapping:00000000 index:0x4
    2022-07-08T22:28:42.075120  kern  :emerg : flags: 0x0()
    2022-07-08T22:28:42.139485  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Deme=
rg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D4>
    2022-07-08T22:28:42.139752  + set +x   =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/62c8afaac23d1cc=
63da39bd1
        new failure (last pass: v4.19.249-cip76)
        6 lines

    2022-07-08T22:28:41.890565  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3400
    2022-07-08T22:28:41.890868  kern  :alert : raw: 00000000 00000100 00000=
200 00000000 00000004 0000000a ffffff7f 00000000
    2022-07-08T22:28:41.891066  kern  :alert : page dumped because: nonzero=
 mapcount
    2022-07-08T22:28:41.891223  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3800
    2022-07-08T22:28:41.891447  kern  :alert : raw: 00000000 00000100 00000=
200 00000000 00000004 0000000a ffffff7f 00000000
    2022-07-08T22:28:41.893718  kern  :alert : page dumped because: nonzero=
 mapcount   =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
jetson-tk1                 | arm   | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8b4c0fa74813c77a39bf1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c8b4c0fa74813c77a39=
bf2
        new failure (last pass: v4.19.246-cip75) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
jetson-tk1                 | arm   | lab-baylibre  | gcc-10   | tegra_defco=
nfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8b180af5a972b85a39c3c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm/tegra_defconfig/gcc-10/lab-baylibre/baseline-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm/tegra_defconfig/gcc-10/lab-baylibre/baseline-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c8b180af5a972b85a39=
c3d
        failing since 39 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.245-cip74) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8b11ce4079ba943a39c0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_a=
rm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_a=
rm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c8b11ce4079ba943a39=
c0c
        failing since 28 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.246-cip75) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8b193cd264661b4a39bce

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c8b193cd264661b4a39=
bcf
        failing since 39 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.245-cip74) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8b384e81d84a063a39be1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c8b384e81d84a063a39=
be2
        failing since 28 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.246-cip75) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8b640a597df89b2a39bf1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c8b640a597df89b2a39=
bf2
        failing since 39 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.245-cip74) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8b11ee4079ba943a39c11

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_a=
rm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_a=
rm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c8b11ee4079ba943a39=
c12
        failing since 28 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.246-cip75) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8b16aaf5a972b85a39c08

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-u=
efi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-u=
efi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c8b16aaf5a972b85a39=
c09
        failing since 39 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.245-cip74) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8b4d80ca5e31e0aa39bd6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c8b4d80ca5e31e0aa39=
bd7
        failing since 28 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.246-cip75) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8b655c54c05a2aca39bf5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-ue=
fi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-ue=
fi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c8b655c54c05a2aca39=
bf6
        failing since 39 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.245-cip74) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | cip://4.19.=
y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8b18290eeaac91ba39bce

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: cip://4.19.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/cip---4.19.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-baylibr=
e/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/cip---4.19.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-baylibr=
e/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c8b18290eeaac91ba39=
bcf
        failing since 39 days (last pass: v4.19.235-cip70, first fail: v4.1=
9.245-cip74) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | cip://4.19.=
y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8b578dd7fdbd50da39be2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: cip://4.19.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/cip---4.19.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie=
/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/cip---4.19.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie=
/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c8b578dd7fdbd50da39=
be3
        failing since 39 days (last pass: v4.19.235-cip70, first fail: v4.1=
9.245-cip74) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8b11dcf695cf539a39be6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_a=
rm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_a=
rm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c8b11dcf695cf539a39=
be7
        failing since 28 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.246-cip75) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8b183f9946b6395a39bd9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c8b183f9946b6395a39=
bda
        failing since 39 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.245-cip74) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8b386e81d84a063a39be7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c8b386e81d84a063a39=
be8
        failing since 28 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.246-cip75) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8b656c54c05a2aca39bf8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c8b656c54c05a2aca39=
bf9
        failing since 39 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.245-cip74) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8b12f180b889d93a39bea

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_a=
rm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_a=
rm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c8b12f180b889d93a39=
beb
        failing since 28 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.246-cip75) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8b17eaf5a972b85a39c39

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-u=
efi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-u=
efi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c8b17eaf5a972b85a39=
c3a
        failing since 39 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.245-cip74) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8b41051ecf0d3c6a39be5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c8b41051ecf0d3c6a39=
be6
        failing since 28 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.246-cip75) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8b4ed7ab083e4c5a39bd2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-ue=
fi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-ue=
fi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c8b4ed7ab083e4c5a39=
bd3
        failing since 39 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.245-cip74) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin           | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8b0bac615642188a39bd4

  Results:     83 PASS, 7 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/62c8b0bac615642188a39bfa
        failing since 101 days (last pass: v4.19.229-cip67, first fail: v4.=
19.235-cip70)

    2022-07-08T22:33:16.902423  /lava-6783189/1/../bin/lava-test-case
    2022-07-08T22:33:16.911193  <8>[   36.874329] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

