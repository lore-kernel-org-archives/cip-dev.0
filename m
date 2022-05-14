X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.3905.1652514673561524654
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 14 May 2022 00:51:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Y6wcvxAl;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id p8so9594711pfh.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 14 May 2022 00:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=YRV6tyHQSfMu9QySsPTrbxtwz8PYxvcgg9NllBPpWvA=;
        b=Y6wcvxAllS8L4MOGLwgGrNKGLsKAhCN2N+j/ZeAKt6DBbUGNur1S86xuzc4k5FJhtx
         akZSnGiWHpb8EHi9glpCQIgF0ASifuit0oIebYdCr5TBAFrnlms0Tuvkm5IFSxB//k6r
         E3l7KtDdYSwdwfsEwO+wtauJNYxkD7mJC9s7XYa2kREk2CMF6k1EpUmi5SOluy00Z2M+
         +8HS6eELBgS3YXN3bnNUh3JnG3XQpvqZ8pB1UDbi7IQCqh+RX/sFUEfRaSHUVw0oChU4
         5j3qRHcNj3DzhcFsb8uZN4ajuDQcCbGCuB5un2cRWMm45cpK1sQKHOHXKdtkmpxeqaqC
         aWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=YRV6tyHQSfMu9QySsPTrbxtwz8PYxvcgg9NllBPpWvA=;
        b=gXo28Kaelff2UaujqsawM7kr27k3uvWDvO2ZBFWpjwlfGh5oKsvTf6vp0+jYWfa9N+
         DGxtcNJOmyjUUeTLP32w/0Pg7Af4vDIIROnN7CFTD0iP+azRagnylYDATdKOCx9QlAj2
         VLVSlqZkOfN7JqCUaGoslB3fH+qxg7I7sJBBOUfcI456EUy+bidbkSPNh+/RPOvQd+R3
         IL+Rhdk037C4CTnY3PsUYGOpBHS83f2SmkNpZk2RhXFuzEcZwH/j8WB/d1YymUNDHdjp
         MBYmW5TrTp5cfz0fo70j8b3VybSv3Wfhb6KbDWSC3YtgYXUOB5IsCfyzmvg1XlVCyq+q
         A0hA==
X-Gm-Message-State: AOAM530vw22PCidAU7TkEFRbE0v/JFSpm9+/Nrg3eMQ91MOQxgyduedE
	auoAWwhqv8QxbvmDy9gAfkX7FREkDQG5FbPkap4=
X-Google-Smtp-Source: ABdhPJyx7l+P5f6U/Wc/PnHR7zRfvJP1bHB78zj47sBLctCh+j2I4jcDqkqCRgshNpiKqx7ufLQ3Qw==
X-Received: by 2002:a65:6751:0:b0:3c6:42ca:ceb8 with SMTP id c17-20020a656751000000b003c642caceb8mr7089681pgu.565.1652514672899;
        Sat, 14 May 2022 00:51:12 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b8-20020aa78708000000b0050dc76281a0sm2923514pfo.122.2022.05.14.00.51.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 00:51:12 -0700 (PDT)
Message-ID: <627f5f70.1c69fb81.8d8a.79df@mx.google.com>
Date: Sat, 14 May 2022 00:51:12 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4.302-cip69-50-gba851b77071ca
Subject: cip-gitlab/ci/pavel/linux-test smc: 8 runs, 4 regressions (v4.4.302-cip69-50-gba851b77071ca) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test smc: 8 runs, 4 regressions (v4.4.302-cip69-5=
0-gba851b77071ca)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

qemu_arm-virt-gicv3       | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =

qemu_arm64-virt-gicv3     | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =

qemu_arm64-virt-gicv3     | arm64  | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip69-50-gba851b77071ca/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip69-50-gba851b77071ca
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ba851b77071ca2f6d6a35b5758aa276c8af6306d =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627f52f3b4231721948f5720

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/smc-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/smc-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/627f52f3b4231721948f5721
        failing since 2 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
qemu_arm-virt-gicv3       | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/627f56d50e3981115a8f5723

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/smc-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/smc-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/armel/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/627f56d50e3981115a8f5724
        failing since 3 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3     | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/627f54a45375955be18f5830

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/arm64/defconfig/gcc-10/lab-broonie/smc-qe=
mu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/arm64/defconfig/gcc-10/lab-broonie/smc-qe=
mu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/627f54a45375955be18f5831
        failing since 3 days (last pass: v4.19.233-516-ge5e741fbfc87, first=
 fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
qemu_arm64-virt-gicv3     | arm64  | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/627f5530798547b4f08f5733

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/627f5530798547b4f08f5734
        failing since 3 days (last pass: v4.19.233-516-ge5e741fbfc87, first=
 fail: v5.10.109-cip5-384-g722204542e8a) =

 =20

