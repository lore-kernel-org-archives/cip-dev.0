Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D706CC6FD19
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 13:05:54 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web11.19147.1678712748415480822
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 13 Mar 2023 06:05:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=noWQ2ivD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id y2so11956022pjg.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 13 Mar 2023 06:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678712747;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6id60PEM2cgLnVM0iNpJqA/3UTpds6/lBb/IiLOS75g=;
        b=noWQ2ivDkbrqd+ovD1yhnQfm2uErsW33K2KZM45eI0OjrZl3arq4WNHk/F/4R9D8lB
         LTlFFwihi2V3CJDesdl5YA1XD21J65PQ2cD4p+9iPye2Gwl+uw4Muj1RjcqHy9Z7/q1r
         SrgROZt5kvljiLVFWu4BnnAiJ3F+Q2Lst6H/q586hNpUJHq3ZZnoIpKRKcZS0hLK0yRz
         Rxvmu4XBcGy0xRaxBRDViTenGRSjm/y++Zh76J5ni0B5mqrHB+bOwvF8dRpMFY7AGNMA
         wjGRPzVcCnGPntzzzPy8CgE2+gzfJfdIMg/6BCykpMS4RXJNLTbFjVV+6yQX6chrnqhR
         x9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678712747;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6id60PEM2cgLnVM0iNpJqA/3UTpds6/lBb/IiLOS75g=;
        b=znsJHnagFxUqg60UVvg+l28lRrLjo9xlHUauJgTYAqq7d6ZKFGXHv43zCXycF5N4Qz
         EhyEdG7yS5Q+iC0oizAhjRSq1aJ9b7xLJeUcSneeRsPFM6Pw0FWk6bOwh0YmeIEAOgmn
         nsBLDT596tj+VU3I8CuiCB8WsyvPr4FlhhhRDjBmozPaauGxo+yWXT8f+RXCQIa9HDNp
         NvJR8rZiLz3BAnPYSl1MepB3AT0Zt7MtgtF/r9PUzpVukhR2NeRNB2P6tHUIJZNcUL6A
         qRsasEZtJvpJUK7r0evBoSpA3+FowajiGrMrfKWZCjelXAGl3H/OGsFvxe/PBOcOymrJ
         Fgmw==
X-Gm-Message-State: AO0yUKV2vfVwWTUUM2nmS3GuyLLdniWMsdm0c7Y0O/3fDSiyaVVyGH1k
	9nPfeZYDXGIulEXTqr/9DtoUS8G3T5MX/qolweZXxbQ5
X-Google-Smtp-Source: AK7set9AD0Vl2KhJQ3muEZ4mFPY9ZJ8HzIuBS+ylquu/agpm1MAZ9EKTTpj5f9DPKHzEveRAmrFi4Q==
X-Received: by 2002:a05:6a20:2450:b0:d5:1863:fe5f with SMTP id t16-20020a056a20245000b000d51863fe5fmr210574pzc.2.1678712747042;
        Mon, 13 Mar 2023 06:05:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n13-20020aa7904d000000b005a8512c9988sm4416602pfo.93.2023.03.13.06.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 06:05:46 -0700 (PDT)
Message-ID: <640f1faa.a70a0220.3656b.6b66@mx.google.com>
Date: Mon, 13 Mar 2023 06:05:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.276-cip93
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip baseline: 105 runs,
 13 regressions (v4.19.276-cip93)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Mar 2023 13:05:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11005

cip/linux-4.19.y-cip baseline: 105 runs, 13 regressions (v4.19.276-cip93)

Regressions Summary
-------------------

platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
at91sam9g20ek              | arm    | lab-broonie   | gcc-10   | multi_v5_d=
efconfig           | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | cip://4.19=
.y-...64_defconfig | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =

qemu_x86_64-uefi           | x86_64 | lab-broonie   | gcc-10   | cip://4.19=
.y-...mu_defconfig | 1          =

r8a7743-iwg20d-q7          | arm    | lab-cip       | gcc-10   | shmobile_d=
efconfig           | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.276-cip93/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.276-cip93
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      849e6920f9039d78588d7ab644573c58cca7e64e =



Test Regressions
---------------- =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
at91sam9g20ek              | arm    | lab-broonie   | gcc-10   | multi_v5_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640f169afba2f87b238c8641

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/640f169afba2f87b238c864a
        new failure (last pass: v4.19.273-cip92)

    2023-03-13T12:26:47.160950  + set +x
    2023-03-13T12:26:47.166158  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 151526_1.5.2=
.4.1>
    2023-03-13T12:26:47.280056  / # #
    2023-03-13T12:26:47.383040  export SHELL=3D/bin/sh
    2023-03-13T12:26:47.383811  #
    2023-03-13T12:26:47.485755  / # export SHELL=3D/bin/sh. /lava-151526/en=
vironment
    2023-03-13T12:26:47.486595  =

    2023-03-13T12:26:47.588399  / # . /lava-151526/environment/lava-151526/=
bin/lava-test-runner /lava-151526/1
    2023-03-13T12:26:47.589768  =

    2023-03-13T12:26:47.596207  / # /lava-151526/bin/lava-test-runner /lava=
-151526/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/640f1cd1356f975c908c8632

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640f1cd1356f975c908c8=
633
        failing since 286 days (last pass: v4.19.237-cip71, first fail: v4.=
19.245-cip74) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/640f1eeed7b6171a728c8730

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640f1eeed7b6171a728c8=
731
        failing since 276 days (last pass: v4.19.237-cip71, first fail: v4.=
19.246-cip75) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/640f1c95052710f3e58c866c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-ue=
fi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-ue=
fi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640f1c95052710f3e58c8=
66d
        failing since 286 days (last pass: v4.19.237-cip71, first fail: v4.=
19.245-cip74) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/640f1ec6563b100a778c862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640f1ec6563b100a778c8=
630
        failing since 276 days (last pass: v4.19.237-cip71, first fail: v4.=
19.246-cip75) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | cip://4.19=
.y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/640f1b2db1a6f507ae8c8632

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: cip://4.19.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/arm64/cip---4.19.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie=
/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/arm64/cip---4.19.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie=
/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640f1b2db1a6f507ae8c8=
633
        failing since 286 days (last pass: v4.19.235-cip70, first fail: v4.=
19.245-cip74) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/640f1ca978a54b33938c8656

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640f1ca978a54b33938c8=
657
        failing since 286 days (last pass: v4.19.237-cip71, first fail: v4.=
19.245-cip74) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/640f1f0234b7f932268c8641

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640f1f0234b7f932268c8=
642
        failing since 276 days (last pass: v4.19.237-cip71, first fail: v4.=
19.246-cip75) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/640f1cd2d68d451b728c8644

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-ue=
fi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-ue=
fi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640f1cd2d68d451b728c8=
645
        failing since 202 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie   | gcc-10   | defconfig+=
arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/640f1eda70e455a38f8c8635

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-qemu_ar=
m64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640f1eda70e455a38f8c8=
636
        failing since 276 days (last pass: v4.19.237-cip71, first fail: v4.=
19.246-cip75) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/640f172cab12e4d6528c8631

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-=
uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3-=
uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640f172cab12e4d6528c8=
632
        failing since 202 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64-uefi           | x86_64 | lab-broonie   | gcc-10   | cip://4.19=
.y-...mu_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/640f1b1974b712bdba8c8659

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: cip://4.19.y-cip/x86/cip_qemu_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/x86_64/cip---4.19.y-cip-x86-cip_qemu_defconfig/gcc-10/lab-broonie/ba=
seline-qemu_x86_64-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/x86_64/cip---4.19.y-cip-x86-cip_qemu_defconfig/gcc-10/lab-broonie/ba=
seline-qemu_x86_64-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640f1b1974b712bdba8c8=
65a
        failing since 16 days (last pass: v4.19.272-cip91, first fail: v4.1=
9.273-cip92) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
r8a7743-iwg20d-q7          | arm    | lab-cip       | gcc-10   | shmobile_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/640f1564cfcb22150e8c8630

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.276=
-cip93/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/640f1564cfcb22150e8c8=
631
        failing since 31 days (last pass: v4.19.271-cip90, first fail: v4.1=
9.272-cip91) =

 =20

