X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web10.11103.1652273669376813861
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 11 May 2022 05:54:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=RZJyf3AY;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.171, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f171.google.com with SMTP id a19so1509812pgw.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 11 May 2022 05:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=4k3iylJwmWyPQoySPSP4RuK/pJD/C9sA1c4lucNMzrE=;
        b=RZJyf3AYsrqKFRcO2tuw03aqS+G4lse8Mh/qeERK+JmUr33EvRvChq1XbIcITpDZB4
         q3whHKOLwLPJTg2/hFRcNUUfCqk+eEuwd3M7GH48D9vjlVq52IUf/Nr0xnh6sAAnRDhM
         rhyF8Jk2jdZEkFIbVNDdNaiISaX2OPnuMPd/+KzmB8a3RC6VHcMLZ0pOTOE8c2qNP8jz
         ByixVlSAEtgErYCttMEqRB3I3nHCmQpRkkrxzHzyGvdt4cfr0uwhHC2tilbma9CimbOO
         xVRma59DeKc9cOgDYa/K8fSO8gM64oiwy4IRvns4hZadckAb62+AoMrVtFjPOJQsm+JJ
         JSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=4k3iylJwmWyPQoySPSP4RuK/pJD/C9sA1c4lucNMzrE=;
        b=GpxVa4BdY8mb/afmcDV41tOeg7xNtPmIkcFYZyxfMQISmEh7zJ6pO2b6uWkWYmwK3d
         uuhMb+P6O0Pdjm6P89eP24gQnJpvGm7gXs4hg8E5X5EbrYzwJmUzoxCNEwvvIFGGzO/n
         A+oEF2RApKXxbH57Irhxulsy6w9rkycjaElEJuDNal2iVQZMEW2i+uaDAFq1HUcuVBqx
         KBxwI1at5MdzdRwT/Edh5jCWM/ITwMKw6zxBbb6QRKwm2JTu8kcZWbjCvhDvJ/2O/v8e
         PDT+TuK+7eT2D+RvaKd0b8YELgg8RVShxqtb+d+lwmvZcEvRwBKmmbK6iKrtkBSYFCQT
         t0oA==
X-Gm-Message-State: AOAM530kQVSvsr0H+JOAji0ywJ2fhVm7ZuaMBwDhzKbmUrq8t8heRSAm
	Qz615xWf+ERBogGXY7SiNTFi8laJgZhOy91ihBs=
X-Google-Smtp-Source: ABdhPJygCXcVBjs1f3La903/qXl2vQwmzDSpqRXPOIZa86m1lh6QAIc3NDT63Eo+BmDHZLFFUUO5Xw==
X-Received: by 2002:a62:fb0f:0:b0:4f2:6d3f:5ffb with SMTP id x15-20020a62fb0f000000b004f26d3f5ffbmr24863746pfm.55.1652273668308;
        Wed, 11 May 2022 05:54:28 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k12-20020a170902c40c00b0015e8d4eb292sm1795776plk.220.2022.05.11.05.54.27
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 05:54:27 -0700 (PDT)
Message-ID: <627bb203.1c69fb81.b1455.3a26@mx.google.com>
Date: Wed, 11 May 2022 05:54:27 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-23-gf7cf04ab668f1
Subject: cip-gitlab/ci/pavel/linux-test baseline: 36 runs, 24 regressions (v4.4-st5-23-gf7cf04ab668f1) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline: 36 runs, 24 regressions (v4.4-st5-=
23-gf7cf04ab668f1)

Regressions Summary
-------------------

platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-C436FA-Flip-hatch     | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

asus-cx9400-volteer        | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

hp-x360-12b-n4000-octopus  | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

juno-uboot                 | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_x86_64-uefi-mixed     | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

qemu_x86_64-uefi-mixed     | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
config             | 1          =

qemu_x86_64-uefi-mixed     | x86_64 | lab-broonie   | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

qemu_x86_64-uefi-mixed     | x86_64 | lab-broonie   | gcc-10   | x86_64_def=
config             | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-23-gf7cf04ab668f1/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-23-gf7cf04ab668f1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f7cf04ab668f124b54f47c93fca7625e6eff3cfe =



Test Regressions
---------------- =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-C436FA-Flip-hatch     | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb1b3c6136b0f1d8f571d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627bb1b3c6136b0f1d8f5=
71e
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
asus-cx9400-volteer        | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627babf18981aebe558f5729

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627babf18981aebe558f5=
72a
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
hp-x360-12b-n4000-octopus  | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb098577dd575d78f5725

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/baseline-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627bb098577dd575d78f5=
726
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
juno-uboot                 | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/627bae8346fb65ef668f5717

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig/gcc-10/lab-broonie/baseline-jun=
o-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig/gcc-10/lab-broonie/baseline-jun=
o-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627bae8346fb65ef668f5=
718
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-261-g4f0b5ddda6cf) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/627bae7c385e47ddc18f577e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627bae7c385e47ddc18f5=
77f
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/627bae7f385e47ddc18f578b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig+arm64-chromebook/gcc-10/lab-bay=
libre/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig+arm64-chromebook/gcc-10/lab-bay=
libre/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627bae7f385e47ddc18f5=
78c
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/627baf1cd96ea9511e8f573d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig/gcc-10/lab-broonie/baseline-qem=
u_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig/gcc-10/lab-broonie/baseline-qem=
u_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627baf1cd96ea9511e8f5=
73e
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/627baf1e419d6d69c48f5717

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig+arm64-chromebook/gcc-10/lab-bro=
onie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig+arm64-chromebook/gcc-10/lab-bro=
onie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627baf1e419d6d69c48f5=
718
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/627bae29f01ab489b48f57c6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627bae29f01ab489b48f5=
7c7
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/627baef4f82513415f8f5725

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig+arm64-chromebook/gcc-10/lab-bay=
libre/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig+arm64-chromebook/gcc-10/lab-bay=
libre/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627baef4f82513415f8f5=
726
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/627baf07aec4d0e8538f5750

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig/gcc-10/lab-broonie/baseline-qem=
u_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig/gcc-10/lab-broonie/baseline-qem=
u_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627baf07aec4d0e8538f5=
751
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb05b9dde4d0c8a8f5777

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig+arm64-chromebook/gcc-10/lab-bro=
onie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig+arm64-chromebook/gcc-10/lab-bro=
onie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627bb05b9dde4d0c8a8f5=
778
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/627bae7a385e47ddc18f577b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627bae7a385e47ddc18f5=
77c
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/627bae8d161e0643b18f572e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig+arm64-chromebook/gcc-10/lab-bay=
libre/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig+arm64-chromebook/gcc-10/lab-bay=
libre/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627bae8d161e0643b18f5=
72f
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/627baf1bd96ea9511e8f5726

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig/gcc-10/lab-broonie/baseline-qem=
u_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig/gcc-10/lab-broonie/baseline-qem=
u_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627baf1bd96ea9511e8f5=
727
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb01f15ef568d058f573a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig+arm64-chromebook/gcc-10/lab-bro=
onie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig+arm64-chromebook/gcc-10/lab-bro=
onie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627bb01f15ef568d058f5=
73b
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/627bae26f01ab489b48f575d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig/gcc-10/lab-baylibre/baseline-qe=
mu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627bae26f01ab489b48f5=
75e
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/627baef5f82513415f8f572b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig+arm64-chromebook/gcc-10/lab-bay=
libre/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig+arm64-chromebook/gcc-10/lab-bay=
libre/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627baef5f82513415f8f5=
72c
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/627baef3f82513415f8f571f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig/gcc-10/lab-broonie/baseline-qem=
u_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig/gcc-10/lab-broonie/baseline-qem=
u_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627baef3f82513415f8f5=
720
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb06f3ab07791fd8f5731

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig+arm64-chromebook/gcc-10/lab-bro=
onie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/arm64/defconfig+arm64-chromebook/gcc-10/lab-bro=
onie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627bb06f3ab07791fd8f5=
732
        failing since 0 day (last pass: v4.19.233-516-ge5e741fbfc87, first =
fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64-uefi-mixed     | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627baef70a34aa09d88f5717

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-baylibre/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-baylibre/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627baef70a34aa09d88f5=
718
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64-uefi-mixed     | x86_64 | lab-baylibre  | gcc-10   | x86_64_def=
config             | 1          =


  Details:     https://kernelci.org/test/plan/id/627baf6d25070ed0008f5722

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/bas=
eline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/bas=
eline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627baf6d25070ed0008f5=
723
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64-uefi-mixed     | x86_64 | lab-broonie   | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb09710ce0c1d6e8f575b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627bb09710ce0c1d6e8f5=
75c
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64-uefi-mixed     | x86_64 | lab-broonie   | gcc-10   | x86_64_def=
config             | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb1877cfd31fb6c8f5728

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig/gcc-10/lab-broonie/base=
line-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig/gcc-10/lab-broonie/base=
line-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627bb1877cfd31fb6c8f5=
729
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =20

