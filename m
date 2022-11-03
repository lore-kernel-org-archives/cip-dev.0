Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7158FC43217
	for <webhook@archiver.kernel.org>; Thu,  3 Nov 2022 10:03:51 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web12.17586.1667469821881339614
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 03 Nov 2022 03:03:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=FCIp4l2K;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id k15so1152769pfg.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 03 Nov 2022 03:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nI8aWTJp7OcV0v5aGNwS7dYbL0Xfw7Oc0DfhK3bIVaY=;
        b=FCIp4l2KEdPp0Yvaoy3h3/DQn7kh0oDYlH+W4GYEGMocpWdTR8089i2Y0LlpQbbwCi
         JKmCC20+BVzd2C3emKUbT1g38YU/8H3R0DdowvUf+d74M9tHO1Cb3gW3/pYLiiyZ2+hv
         CrDQjoKrSk/CIBaBk5lFW8mmOamrhc/yk4oR8xV20czw69FDOOz+rwClb0P8N2S11Ggy
         1H//k7UHQjpjF0210tFSKXtZRzc3QyLyDZ/O0mqfz6H1o6+MT3Up4EGCs9tNGhX68ZoG
         bDtIcK4oBWVPYqsfyBcG3s54QOeV/OS3hzZ+Easc017WnmyrNTz+/w6KUqRI7DjZgWGa
         Eckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nI8aWTJp7OcV0v5aGNwS7dYbL0Xfw7Oc0DfhK3bIVaY=;
        b=TIRs0su7QFCh8WKS3O/+YnMimOUZS8vrSG0MdugtbOMiM81T53k7KdDoqobOxl6r4d
         p6pD3oLCPfhLK6pUnkBvmePDzPZpqaLgJdPol9FvTVEM/B8UbT+Y++YyGraN+UcgpujV
         X8YQSXXjRtEQmrXrxmnvp2G3sTcfQeSA/qzvjlHtbE8y/aSI0tbYIb558hajI0bEnfK0
         Hn1u5IO9MlHY1dzMp+2lakjPsyYFLQ6D7FijqAhx2MEuERwZRdX92Zw5c78pXqkhT2qQ
         jHzQNoLGNC2pRw1T1DX5Qr+H+fk8eUEaeuGRrzVJKOHnF3mbRLnfUo188n+AZfZBwkRH
         ZaVQ==
X-Gm-Message-State: ACrzQf3U7c5fa/4wi7HUxpKEfSXiqJR0iQ/ZAEIJKQzTxHuZARP6oDXz
	LnZO73hFYnvtOmFYJp4KVLQfIPtZVOMkKnWg
X-Google-Smtp-Source: AMsMyM520s5YMNP1/+NJ2FETcw0s51JmO76frNAdkj+1z6xhr6rtAu000K6QcQS2mgIzaTdiEzGHpA==
X-Received: by 2002:a63:f20a:0:b0:464:8c6:f27e with SMTP id v10-20020a63f20a000000b0046408c6f27emr25378929pgh.411.1667469820863;
        Thu, 03 Nov 2022 03:03:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id pj2-20020a17090b4f4200b00212e60c7d9csm3014025pjb.41.2022.11.03.03.03.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 03:03:40 -0700 (PDT)
Message-ID: <636391fc.170a0220.9b9cb.53cc@mx.google.com>
Date: Thu, 03 Nov 2022 03:03:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-12-gcb2b164780be
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline: 111 runs,
 12 regressions (v5.10.147-cip18-12-gcb2b164780be)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Nov 2022 10:03:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9905

cip-gitlab/ci/pavel/linux-test baseline: 111 runs, 12 regressions (v5.10.14=
7-cip18-12-gcb2b164780be)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
bcm2836-rpi-2-b            | arm   | lab-collabora | gcc-10   | multi_v7_de=
fconfig    | 1          =

da850-lcdk                 | arm   | lab-baylibre  | gcc-10   | davinci_all=
_defconfig | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
           | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
           | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig  =
           | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
           | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
           | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
           | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
           | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
           | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
           | 1          =

zynqmp-zcu102              | arm64 | lab-cip       | gcc-10   | defconfig  =
           | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.147-cip18-12-gcb2b164780be/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.147-cip18-12-gcb2b164780be
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      cb2b164780beff6c4be7ccfd9020e39c07c44f3c =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
bcm2836-rpi-2-b            | arm   | lab-collabora | gcc-10   | multi_v7_de=
fconfig    | 1          =


  Details:     https://kernelci.org/test/plan/id/636388d5b7a6711002e7db7b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm/multi_v7_defconfig/gcc-10/lab-collabo=
ra/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm/multi_v7_defconfig/gcc-10/lab-collabo=
ra/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/636388d5b7a6711002e7d=
b7c
        failing since 176 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
da850-lcdk                 | arm   | lab-baylibre  | gcc-10   | davinci_all=
_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/636383e030c7b75ef8e7db57

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: davinci_all_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm/davinci_all_defconfig/gcc-10/lab-bayl=
ibre/baseline-da850-lcdk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm/davinci_all_defconfig/gcc-10/lab-bayl=
ibre/baseline-da850-lcdk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/armel/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/636383e030c7b75=
ef8e7db5f
        failing since 176 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a)
        4 lines

    2022-11-03T09:03:05.963935  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3000
    2022-11-03T09:03:05.965437  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3400
    2022-11-03T09:03:05.966073  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3800
    2022-11-03T09:03:05.967672  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3c00
    2022-11-03T09:03:06.007972  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dale=
rt RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D4>   =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/6363845db72b777dd8e7db66

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-baylibre/basel=
ine-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-baylibre/basel=
ine-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6363845db72b777dd8e7d=
b67
        failing since 176 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/6363851d4136de1534e7db6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6363851d4136de1534e7d=
b6e
        failing since 176 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/6363844ab72b777dd8e7db58

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-collabora/base=
line-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-collabora/base=
line-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6363844ab72b777dd8e7d=
b59
        failing since 176 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/6363845fb72b777dd8e7db74

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-baylibre/basel=
ine-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-baylibre/basel=
ine-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6363845fb72b777dd8e7d=
b75
        failing since 176 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/636385314136de1534e7db92

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/636385314136de1534e7d=
b93
        failing since 176 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-baylibre  | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/6363846063ee401934e7db4f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-baylibre/basel=
ine-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-baylibre/basel=
ine-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6363846063ee401934e7d=
b50
        failing since 176 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/636385324136de1534e7db95

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/636385324136de1534e7d=
b96
        failing since 176 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre  | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/6363846163ee401934e7db56

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-baylibre/basel=
ine-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-baylibre/basel=
ine-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6363846163ee401934e7d=
b57
        failing since 176 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/6363868515829a0d02e7db72

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6363868515829a0d02e7d=
b73
        failing since 176 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
           | regressions
---------------------------+-------+---------------+----------+------------=
-----------+------------
zynqmp-zcu102              | arm64 | lab-cip       | gcc-10   | defconfig  =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/6363845e266fddac15e7db4f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-cip/baseline-z=
ynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-cip/baseline-z=
ynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6363845e266fddac15e7d=
b50
        failing since 176 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a) =

 =20

