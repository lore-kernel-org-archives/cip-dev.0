Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8D0C7EE2E
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 04:26:30 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
 by mx.groups.io with SMTP id smtpd.web11.243.1685939184404679214
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 04 Jun 2023 21:26:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=5kEC91QC;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.128.180, mailfrom: bot@kernelci.org)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-565c3aa9e82so50575757b3.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 04 Jun 2023 21:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685939183; x=1688531183;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AP6Xm1LGFzg+TkDzt/WyFulVyl7KoRWdMXvY1DvEU+s=;
        b=5kEC91QCgs3Rz4v1dW9QBtgcNJRYJVZNp0LACozh+GpBt5PY07qKx0q7wQyMnGvIda
         /iyPHnbU2cojKSNDOEcabwdeoBVwCS9+uGJMhhAiRP412ka6uxVNMQEeTkHp+ovxLOq8
         j9uSZRNrmC29/d3fNJmXw4slD+Gwmd1rt8iApwgDWUu6/7dkyWpsSrWIH6B4uhNQu5d6
         nLxFo6PtKM/O/DzicCQDFqrZ4NmLUYIWacAlcIZJFJ3J/2YCQZ25kLiaF3yDJEJo1y/u
         7PBXi847KuFVc6dO7zAFjMXWr6nqd3p/qEQu0zWikMiT8rmmR61GHrlj/kuu2TSL96Bc
         xqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685939183; x=1688531183;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AP6Xm1LGFzg+TkDzt/WyFulVyl7KoRWdMXvY1DvEU+s=;
        b=UafNHHrqqK2kmbF2v59Omn6B5XjelY47uZTlFnyLl4WM5RD70cWfgyb5DVlUQi7z2r
         bs0Nm/bnxIePOT7CHKmLaiVwzMuX9rv+o2QhaUO8WfJmw1o23CL2cvydJPAynG0GvYHG
         ZFROxiSYWrb7IwHsNhGPGY9w+XQ265FiRxPMoVDMMbCxGrRPG+HBWh+1v2QA8WbMqYHg
         ue0oF6/AHYe2GDgidoEVF8HezNGsmURjoUNnkN/lYHkBYkkQbGxAOFh2++NQgyBAIbsq
         jFvB0htZO9xw0EbJuWAmabNo8R5Z2WaBoJqr7rZh3tltWRmZhlQsTeMKRAbB947XMcEi
         Y7yA==
X-Gm-Message-State: AC+VfDxgwPoz02WeeaaW5qbZ5uXKl+av/k0+CXozg2VWJ2yZhtjKteta
	wXuo7f1pcPLS8uAWWSOKDQhj3O/gxAmivdgnpTSA+Q==
X-Google-Smtp-Source: ACHHUZ4ag5hKvAmZZTVPVWLVjFuNY1ad05DqyCPUcfP5VxXPTon435uxpf+O6v1b5YsH0BMVs7V3hA==
X-Received: by 2002:a81:d34d:0:b0:568:d586:77bb with SMTP id d13-20020a81d34d000000b00568d58677bbmr8012912ywl.14.1685939182983;
        Sun, 04 Jun 2023 21:26:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i9-20020aa787c9000000b0064d3e4c7658sm4407393pfo.96.2023.06.04.21.26.20
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 21:26:20 -0700 (PDT)
Message-ID: <647d63ec.a70a0220.eb785.759f@mx.google.com>
Date: Sun, 04 Jun 2023 21:26:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-19-gae79bc689058c
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 17 runs,
 14 regressions (v5.10.180-cip34-19-gae79bc689058c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 04:26:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11776

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 17 runs, 14 regressi=
ons (v5.10.180-cip34-19-gae79bc689058c)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_riscv64                 | riscv  | lab-broonie   | gcc-10   | defconfi=
g                    | 2          =

qemu_riscv64                 | riscv  | lab-collabora | gcc-10   | defconfi=
g                    | 2          =

qemu_smp8_riscv64            | riscv  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.180-cip34-19-gae79bc689058c/plan/ltp-time=
rs/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.180-cip34-19-gae79bc689058c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ae79bc689058cc27e73e1cde11fdc558c96a2889

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/647d59b49ce3b66cd8f5de25

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647d59b49ce=
3b66cd8f5de2a
        failing since 221 days (last pass: v5.10.147-cip18-56-g87bd4289362b=
e, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647d59b49ce=
3b66cd8f5de2a
        failing since 221 days (last pass: v5.10.147-cip18-56-g87bd4289362b=
e, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/647d5d228174ef26d2f5de48

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647d5d22817=
4ef26d2f5de4d
        failing since 221 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647d5d22817=
4ef26d2f5de4d
        failing since 221 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/647d56146bd41ae44cf5de25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/ltp-timers-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/ltp-timers-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/647d56146bd41ae44cf=
5de26
        failing since 8 days (last pass: v5.10.168-cip27-638-g0d599cd2b6695=
, first fail: v5.10.180-cip33-21-g090289427e8b2) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647d5cdfa930974273f5de33

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/arm64/defconfig/gcc-10/lab-b=
roonie/ltp-timers-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/arm64/defconfig/gcc-10/lab-b=
roonie/ltp-timers-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/647d5cdfa930974273f=
5de34
        failing since 84 days (last pass: v5.10.168-cip27-109-g23841ec76bec=
, first fail: v5.10.168-cip27-638-g0d599cd2b6695) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_riscv64                 | riscv  | lab-broonie   | gcc-10   | defconfi=
g                    | 2          =


  Details:     https://kernelci.org/test/plan/id/647d545e90f884d97cf5deec

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/riscv/defconfig/gcc-10/lab-b=
roonie/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/riscv/defconfig/gcc-10/lab-b=
roonie/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30527.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647d545e90f=
884d97cf5def1
        failing since 5 days (last pass: v5.10.180-cip33-21-g090289427e8b2,=
 first fail: v5.10.180-cip34-213-g6582dd41d2c22) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647d545e90f=
884d97cf5def1
        failing since 5 days (last pass: v5.10.180-cip33-21-g090289427e8b2,=
 first fail: v5.10.180-cip34-213-g6582dd41d2c22) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_riscv64                 | riscv  | lab-collabora | gcc-10   | defconfi=
g                    | 2          =


  Details:     https://kernelci.org/test/plan/id/647d528653d0a285dff5de26

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/riscv/defconfig/gcc-10/lab-c=
ollabora/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/riscv/defconfig/gcc-10/lab-c=
ollabora/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30527.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647d528653d=
0a285dff5de2b
        failing since 5 days (last pass: v5.10.180-cip33-21-g090289427e8b2,=
 first fail: v5.10.180-cip34-213-g6582dd41d2c22)

    2023-06-05T03:11:54.890641  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647d528653d=
0a285dff5de2b
        failing since 5 days (last pass: v5.10.180-cip33-21-g090289427e8b2,=
 first fail: v5.10.180-cip34-213-g6582dd41d2c22)

    2023-06-05T03:11:54.890641  =

   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_smp8_riscv64            | riscv  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647d56a7950e0078c8f5de70

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/riscv/defconfig/gcc-10/lab-c=
ollabora/ltp-timers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/riscv/defconfig/gcc-10/lab-c=
ollabora/ltp-timers-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30527.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/647d56a7950e0078c8f=
5de71
        failing since 9 days (last pass: v5.10.179-cip32-384-g291adc46abef0=
, first fail: v5.10.180-cip33-21-g090289427e8b2) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/647d53c85b293c6e28f5de27

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/647d53c85b293c6e28f=
5de28
        new failure (last pass: v5.10.180-cip34-213-g6582dd41d2c22) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/647d589bfe3d6567a8f5de41

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647d589bfe3=
d6567a8f5de46
        failing since 221 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647d589bfe3=
d6567a8f5de46
        failing since 221 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =20

