X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web10.37502.1653922221367020026
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 30 May 2022 07:50:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=hy3F4GFv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.178, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f178.google.com with SMTP id e66so10329927pgc.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 30 May 2022 07:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=m+yoNaBq2QRbzVnF4B1QauTB9J/6U1YpOjRKADcdevA=;
        b=hy3F4GFvfh12Vz+3oSY6Rhygbt4T01vuKbVIwWbY3e7Os9Hl3G5QP1GTaNMZ7E8K9Q
         Bpgj89GdE043LJTxw2Rv3AeGIrTEQl4Ho0os7UVJqx4Y7tv0W8Fch50Mv4hgYlUpeRy7
         LjKPI0w9caJd5tULGeOSzm3Nc5Khx/ajeA96VU9ywEZBf30a3jRFBECfLOdGMUES9+3U
         KKI3DHKOMBOigC+AEI9FPEvtMGgyF00Sj/ds9hPIrAEIFXuoCESSGr3udMwSiz6kKqQU
         0d9i/46YqL2upepmFx1vP3f7a2xLJ3awroq3MfRCO69WZbKwedzDjEOcVE4ftnx3ZSrK
         lJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=m+yoNaBq2QRbzVnF4B1QauTB9J/6U1YpOjRKADcdevA=;
        b=F9U6i6W0tMz8xg9hLho2+Lm/elQCdK5oUeVcWzO5OtFSLyWKbATkd7Yzti+xwyCTpt
         IGJzLdUdGjLqKeVhRHMdWajiqMF+47A4B6MEjuTKiMXEZ4iuaona1zgW7QdHjvMDfogh
         k6pSg/GY4fESjxp/bE/fYHXs8bH34DkSiQmZGJofGUxSupvaH9mqAaw2CGgpw2Jenb4J
         VvmV4SvaKEhbBWdFwXgqHi9ZkJuEMMlGNL+aEuTAcqqdGpxn/ALm/ntJnOiK9B7Yf7qb
         J2eZpOtOut63fWIWGqDPp/KaBwktgWJQlwTEneaQ+9Cudn5PPa/NTpwuDtEKFZWabh/P
         JBNg==
X-Gm-Message-State: AOAM530qGXMcCFRHmDOI6gRMHeNFBAuV5KoQ4UmyJghddiF4RyVLhW8q
	/lo0Sc3URxW2FymlH48Bevmo00GSKi4V5A3GEm0=
X-Google-Smtp-Source: ABdhPJwYt+po3p5QSrdEfepx5KglZylWXcvCpEQqgR14FXvU6bKKfrRDGI+AyRJLvdtWU24+uheBdw==
X-Received: by 2002:a63:5b13:0:b0:3c2:163c:b9cb with SMTP id p19-20020a635b13000000b003c2163cb9cbmr48158623pgb.145.1653922220633;
        Mon, 30 May 2022 07:50:20 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id iw10-20020a170903044a00b00163e96e1ed5sm1821244plb.270.2022.05.30.07.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 07:50:20 -0700 (PDT)
Message-ID: <6294d9ac.1c69fb81.47b77.3e59@mx.google.com>
Date: Mon, 30 May 2022 07:50:20 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.245-cip74-rt25
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip-rt baseline: 244 runs, 8 regressions (v4.19.245-cip74-rt25) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.19.y-cip-rt baseline: 244 runs, 8 regressions (v4.19.245-cip74-=
rt25)

Regressions Summary
-------------------

platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv3      | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.245-cip74-rt25/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.245-cip74-rt25
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c80ee3077a4ce344cf1cffa23af767c9fd75d52c =



Test Regressions
---------------- =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/6294cd0dd426156531a39bd4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
245-cip74-rt25/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt=
-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
245-cip74-rt25/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt=
-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6294cd0dd426156531a39=
bd5
        new failure (last pass: vv4.19.233-cip69-rt24) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/6294cee5e508149600a39bcf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
245-cip74-rt25/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-=
gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
245-cip74-rt25/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-=
gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6294cee5e508149600a39=
bd0
        new failure (last pass: vv4.19.233-cip69-rt24) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/6294cd0e6e332e0959a39beb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
245-cip74-rt25/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt=
-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
245-cip74-rt25/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt=
-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6294cd0e6e332e0959a39=
bec
        new failure (last pass: vv4.19.233-cip69-rt24) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/6294cf9912f2fc7bb0a39bdc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
245-cip74-rt25/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-=
gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
245-cip74-rt25/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-=
gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6294cf9912f2fc7bb0a39=
bdd
        new failure (last pass: vv4.19.233-cip69-rt24) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv3      | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/6294cd0ad040a112b3a39bdf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
245-cip74-rt25/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt=
-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
245-cip74-rt25/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt=
-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6294cd0ad040a112b3a39=
be0
        new failure (last pass: vv4.19.233-cip69-rt24) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/6294ce59cf33bf6a03a39c58

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
245-cip74-rt25/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-=
gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
245-cip74-rt25/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-=
gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6294ce59cf33bf6a03a39=
c59
        new failure (last pass: vv4.19.233-cip69-rt24) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/6294cd0bd040a112b3a39be2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
245-cip74-rt25/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt=
-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
245-cip74-rt25/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt=
-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6294cd0bd040a112b3a39=
be3
        new failure (last pass: vv4.19.233-cip69-rt24) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/6294ce6d716eeeedd8a39c1a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
245-cip74-rt25/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-=
gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
245-cip74-rt25/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-=
gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6294ce6d716eeeedd8a39=
c1b
        new failure (last pass: vv4.19.233-cip69-rt24) =

 =20

