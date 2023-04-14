Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14F6C77B6E
	for <webhook@archiver.kernel.org>; Fri, 14 Apr 2023 10:43:40 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web10.6079.1681469011051902502
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 14 Apr 2023 03:43:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Ffvy+7ip;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-63b5465fb99so345970b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 14 Apr 2023 03:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681469010; x=1684061010;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oeLAXF/9qUooAKGQJnPgrrbTYTZ2IMnHNnDiOE7zQx4=;
        b=Ffvy+7ip5s7ObebHcoTSzaR0kDdLq4bp755kAWVK5vnPSiNWoSPsSqtGh2X1+9uUcX
         2fGNxxY8asiXpQ7vPiz+ooqGtm2xRK8GwV/RNtGFp90kRL4rE4MJVJS9zJPqi4uxrVay
         ii2lYm9ZfTtefhzaQCsTCO+4Kv+CAFMVHEXrJhnhpSvG+4UBFZ3+8gj0P74OW/Raik2d
         VaSn7NupQo379vQOOHq1HkycGtOWxYI8fLes2k5KsEcakDeE7yzOALp7jBiK+PT//Jrf
         jt7hZMYyzn+vJ7KWsABryRsJWDgbTYrEiv/x/VWONsPHq9FFk3lOS0hHpLoMcblO5H7M
         5rOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681469010; x=1684061010;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeLAXF/9qUooAKGQJnPgrrbTYTZ2IMnHNnDiOE7zQx4=;
        b=ZLkRz8om/99FGfIKvhAR1Tzb/L7ubRftAKeKeHWy+cg9/594BxLQaJKhJLkJXT17FP
         UBR62jeEC7lTn+1IwdebXpeB+o5vSTMIiMwn2hgdVkNxl50CIrJ+UUMgMxq7ApxQzzmP
         36nYwool5xifV0ZW7iRfsXhEI7etfivFj68Bzzgk9+Ldx1wVPD7dG0QO2Tn0GoJ/SeHe
         OX3zCJdzdcefJfJ8E0inrORFlP3ZVJjBmF4244G7nPQx3M0+/+wEQBsdkTzykKW+nQBu
         rsoL1kkYsgt1uiLf/mg2VVrGK4lgJI9D9jD5RTHZ28Pe1fHlsNgnsfk+DAiFLBfL0Egs
         axfg==
X-Gm-Message-State: AAQBX9frxC8rO/qaZnSRY157Idf3gzXuW7MkFHovJzVvZ4PVX5oaYgXj
	xfvUFXcOdY9Xg9Lh24oLHE8oSwurf1xX3VgML315T93t
X-Google-Smtp-Source: AKy350aTxFSt1Geu9fbS1NLIhKGcphCOp52fXGk1AJh6pP2dx+h8gA7ikFjlEBH5sDr6ve9wrkTtzg==
X-Received: by 2002:a05:6a00:1905:b0:639:243f:da25 with SMTP id y5-20020a056a00190500b00639243fda25mr7523722pfi.22.1681469009715;
        Fri, 14 Apr 2023 03:43:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k17-20020aa790d1000000b005825b8e0540sm2769790pfk.204.2023.04.14.03.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 03:43:29 -0700 (PDT)
Message-ID: <64392e51.a70a0220.fbb58.606d@mx.google.com>
Date: Fri, 14 Apr 2023 03:43:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.280-cip96
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip baseline: 127 runs,
 22 regressions (v4.19.280-cip96)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Apr 2023 10:43:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11207

cip/linux-4.19.y-cip baseline: 127 runs, 22 regressions (v4.19.280-cip96)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
at91sam9g20ek              | arm   | lab-broonie   | gcc-10   | multi_v5_de=
fconfig           | 1          =

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

r8a7743-iwg20d-q7          | arm   | lab-cip       | gcc-10   | shmobile_de=
fconfig           | 1          =

rk3399-gru-kevin           | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.280-cip96/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.280-cip96
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0f5788ca10e5121ce62a8a58a84c723b7d99607f =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
at91sam9g20ek              | arm   | lab-broonie   | gcc-10   | multi_v5_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/643927eb7dec0f43762e85e7

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/643927eb7dec0f43762e8619
        failing since 31 days (last pass: v4.19.273-cip92, first fail: v4.1=
9.276-cip93)

    2023-04-14T10:15:29.926972  + set +x
    2023-04-14T10:15:29.932149  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 327756_1.5.2=
.4.1>
    2023-04-14T10:15:30.045418  / # #
    2023-04-14T10:15:30.148346  export SHELL=3D/bin/sh
    2023-04-14T10:15:30.149230  #
    2023-04-14T10:15:30.251256  / # export SHELL=3D/bin/sh. /lava-327756/en=
vironment
    2023-04-14T10:15:30.252120  =

    2023-04-14T10:15:30.353973  / # . /lava-327756/environment/lava-327756/=
bin/lava-test-runner /lava-327756/1
    2023-04-14T10:15:30.355355  =

    2023-04-14T10:15:30.361707  / # /lava-327756/bin/lava-test-runner /lava=
-327756/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/643929621c3c1013e42e8647

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/643929621c3c1013e42e8=
648
        failing since 234 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64392b6a73feda08bc2e8602

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64392b6a73feda08bc2e8=
603
        failing since 234 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6439264640dacb94752e861f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6439264640dacb94752e8=
620
        failing since 234 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/643927af406630fde82e860c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_=
arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_=
arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/643927af406630fde82e8=
60d
        failing since 234 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/643927fb4b891e6e5e2e860b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-ue=
fi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-ue=
fi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/643927fb4b891e6e5e2e8=
60c
        failing since 234 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64392b42154db4c7bb2e8614

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64392b42154db4c7bb2e8=
615
        failing since 234 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6439261e9d34b39d6e2e85fa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-=
uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2-=
uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6439261e9d34b39d6e2e8=
5fb
        failing since 234 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/643927ae406630fde82e8607

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_=
arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_=
arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/643927ae406630fde82e8=
608
        failing since 234 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | cip://4.19.=
y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64392e3ba611fc198d2e85fd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: cip://4.19.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/cip---4.19.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie=
/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/cip---4.19.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie=
/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64392e3ba611fc198d2e8=
5fe
        failing since 234 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | cip://4.19.=
y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/643928b2195507b9cb2e85ed

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: cip://4.19.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/cip---4.19.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-collabo=
ra/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/cip---4.19.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-collabo=
ra/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/643928b2195507b9cb2e8=
5ee
        failing since 234 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6439284aa3114d65e42e860f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6439284aa3114d65e42e8=
610
        failing since 234 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64392cab621f161b772e862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64392cab621f161b772e8=
630
        failing since 234 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64392646a81783ad772e8603

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64392646a81783ad772e8=
604
        failing since 234 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/643927c276dbf8305e2e85eb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_=
arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_=
arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/643927c276dbf8305e2e8=
5ec
        failing since 234 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/643927fa4b891e6e5e2e8608

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-ue=
fi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-ue=
fi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/643927fa4b891e6e5e2e8=
609
        failing since 234 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64392bce98ceff30512e85eb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64392bce98ceff30512e8=
5ec
        failing since 234 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6439260a91b41f2db02e8603

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-=
uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-=
uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6439260a91b41f2db02e8=
604
        failing since 234 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/643927c276dbf8305e2e85ee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_=
arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_=
arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/643927c276dbf8305e2e8=
5ef
        failing since 234 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
r8a7743-iwg20d-q7          | arm   | lab-cip       | gcc-10   | shmobile_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6439253b18cea9a28e2e85f3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6439253b18cea9a28e2e8=
5f4
        failing since 62 days (last pass: v4.19.271-cip90, first fail: v4.1=
9.272-cip91) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin           | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6439266ada6605bbdc2e8653

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6439266ada6605bbdc2e8659
        failing since 23 days (last pass: v4.19.276-cip93, first fail: v4.1=
9.277-cip94)

    2023-04-14T10:09:38.055709  /lava-9975505/1/../bin/lava-test-case

    2023-04-14T10:09:38.065147  <8>[   37.348863] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6439266ada6605bbdc2e865a
        failing since 23 days (last pass: v4.19.276-cip93, first fail: v4.1=
9.277-cip94)

    2023-04-14T10:09:37.039904  /lava-9975505/1/../bin/lava-test-case<8>[  =
 36.323961] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drockchip-usb2phy0-probed R=
ESULT=3Dfail>

    2023-04-14T10:09:37.040387  =

   =

 =20

