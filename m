Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8571C48BEB
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 19:46:06 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.23041.1707853558548915256
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 13 Feb 2024 11:45:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=SYNOyWOn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6da9c834646so3888122b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 13 Feb 2024 11:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707853557; x=1708458357; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZJBJyaexyKZVYkus6Yv0UjEy8HD3/OwCk6EnNuSCmE=;
        b=SYNOyWOn33OqNmrtvtwrVBJi+dDybg/UA/JEyRI3qxOLklWOv/po5S+JRxKQ6fld8r
         vy+mOYYHRQ5+QNnlIJdTlY/Sy9McIZv/r3X9SiaogMcnK6AUO9+gjVi2sLxRre6kveNh
         UQQd39Y3LIYZH6F/NUsPVElSed3rmD4/EIdokV2Fd34xEhuBqh272V1q6WZhut0ALL62
         47tfabI/W5LOjXeRSv7AGBRomAbgub+BhbS3z7BqVGK+BRZM2Io/IernkYtsH7LkGMmG
         NIwJl+PmZOqYaqhX4PYaCOhx0kgpEUjPN/4S2N24XnuF+NeiQj9t7j/cy3sY8i/5A6tw
         kM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707853557; x=1708458357;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ZJBJyaexyKZVYkus6Yv0UjEy8HD3/OwCk6EnNuSCmE=;
        b=fy3DHmY3CyDSf+v0kDDVjerUtUafZvcgYTmJAgvj0Y/J26shwLWimsSzZ52Rkceaij
         0BZa4F7l/inLIFz/R5dr58Kzmto98Cv+KVqNuU40iP1eY0IdgDzXz13sCrNSFN3fBmaO
         m0BXFzbi8hW3/+LLLVKuIw/oCi+d/Fpsxx4YMJwEb/qZmbXsW+RY+hh9WK16V+F1Y3K8
         md5OrNlp/KTnBWkC6W0QZTOhfLKZ52PBGafyS7mzKS3MIypr5z17r6Fuq9LC8HcI+HdD
         AZUZsdB9StbmScJxoS8+fCgWGNGL0TNUC6GOpV/4ZX0PSH3FXHLZ9TN50jp8fr9ZCNzM
         MYng==
X-Gm-Message-State: AOJu0YzTWorP6UItjsJg48GNq37zHcwE79bY1s8iIE2Ai3tjEP4N8a9G
	FE0tDTDYfz9DLkWhec7Sjp7eytPBCfgTpnNx5wnjbYhf1JQmke4jJXlpadUGnlvf9qW9eKAbHDH
	GdoM=
X-Google-Smtp-Source: AGHT+IFrH+wSOVDzgvr3mgDiSYqKooRyWDi2KrOKF6crvkkE9ndV+ZKsMsVBEhwm3GfDpM3mVkiCtA==
X-Received: by 2002:aa7:88d5:0:b0:6e0:933b:9cf9 with SMTP id k21-20020aa788d5000000b006e0933b9cf9mr293824pff.29.1707853557441;
        Tue, 13 Feb 2024 11:45:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a193-20020a6390ca000000b005d553239b16sm2796619pge.20.2024.02.13.11.45.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 11:45:56 -0800 (PST)
Message-ID: <65cbc6f4.630a0220.67be7.a092@mx.google.com>
Date: Tue, 13 Feb 2024 11:45:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.209-cip44-51-gdb99ac443b0da
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 17 runs,
 5 regressions (v5.10.209-cip44-51-gdb99ac443b0da)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Feb 2024 19:46:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14961

cip-gitlab/ci/pavel/linux-test ltp-timers: 17 runs, 5 regressions (v5.10.20=
9-cip44-51-gdb99ac443b0da)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =

qemu_riscv64             | riscv | lab-broonie   | gcc-10   | defconfig    =
              | 2          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.209-cip44-51-gdb99ac443b0da/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.209-cip44-51-gdb99ac443b0da
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      db99ac443b0da75f00a4fc49e0040ac5dfa47e72

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb4005019f27cc8637025

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-timers-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-timers-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65cbb4005019f27cc86=
37026
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
qemu_riscv64             | riscv | lab-broonie   | gcc-10   | defconfig    =
              | 2          =


  Details:     https://kernelci.org/test/plan/id/65cbb4c7c8bbb78e92637012

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/riscv/defconfig/gcc-10/lab-broonie/ltp-t=
imers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/riscv/defconfig/gcc-10/lab-broonie/ltp-t=
imers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65cbb4c7c8b=
bb78e92637017
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65cbb4c7c8b=
bb78e92637017
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb754abd7771a55637014

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-cip/ltp-timer=
s-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-cip/ltp-timer=
s-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65cbb754abd7771a556=
37015
        failing since 13 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbbba8d2a027affb637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65cbbba8d2a027affb6=
37013
        failing since 7 days (last pass: v5.10.209-cip44-rebase, first fail=
: v5.10.209-cip44-526-gbbb905888ca85) =

 =20

