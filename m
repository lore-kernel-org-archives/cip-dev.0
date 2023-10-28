Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FF0C4332F
	for <webhook@archiver.kernel.org>; Sat, 28 Oct 2023 20:58:39 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web10.34091.1698526711035349216
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 28 Oct 2023 13:58:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Q/h0JixT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1cc1e1e74beso16897725ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 28 Oct 2023 13:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698526710; x=1699131510; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AO0pxPft6vEIDtcQWlR6d/W/SBMqBD7+jAyLoevCzVo=;
        b=Q/h0JixTxBR9pBgyDxs3wvQbfo4J3cJd7IO4i4a1jszwrxvKrpj29eqSn+FoqGkcFR
         /wZ/2buUd9sUD1cN1k2Ljmc9rgkFzt1WIj+b6KWwDZjQvi73/Isuxzx+Dcpua9IasN5Y
         jEzsd3RhDXBzchqkhP4RMgGYd1PRxxEzO421Aa6utmWFa8ZT2MNOL3s7sLiJKibpsEz4
         SuV94pbrTXXnA9YifOEbJ7zXO9pTR/9Clbc3jA2LeQUFs7anWrsQr5Iqk7i08mWzvsVC
         IGzwkboMEjf27Nen8Trh9haCzJi5rliSJU0OnLQCRbvEfDCioEQOIGH0SLGDsnVCZ+qP
         usQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698526710; x=1699131510;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AO0pxPft6vEIDtcQWlR6d/W/SBMqBD7+jAyLoevCzVo=;
        b=FndZ8wyf7w2EVmhbP+RayXVju+4RXPdifuFb+SpJ5eFHA86ewdnyuoebt0fbWtCPLU
         F7cahUCYvkSn8v2T8ZmJgn9SBH/KronOMZedFDFZ983HQTRjrp20WIm5qmJ5BeJd8s8P
         PXcmXluBiyJeLzaJje1bqMwsUPGyjjxyhU9ov1gZf4vW1a+LI6yb+vqDZlZWL2n2hmVl
         ZPFRL5W0aS/taMX6v2052DOS5oDcgjYnRte2MUV3cVsvQFiTkxPvNVQiNjsAFTuDJN/j
         LKTbZHVn+OiyU/UUV7lyO8pw/zjquxPwhu1z9elb4cotEU+v5Fxi+tLzKuq12k90Ah3K
         axFQ==
X-Gm-Message-State: AOJu0YyrcGKHuUJQELx7KBHxXiMap3xlyrq+wQB8SB4H9OGSLu7QoqpC
	gXmGqXHB85QFjoosIYXeyiE6GQA2Xw0LN+u+pfI=
X-Google-Smtp-Source: AGHT+IHa4cpUescYyie8VjMpHhUVN8grMvlkJSi13VjQsT9f+V0Z/VNj3eTrF3xydwT7Xf6XzF+Pzw==
X-Received: by 2002:a17:903:228e:b0:1ca:8419:1857 with SMTP id b14-20020a170903228e00b001ca84191857mr7642604plh.47.1698526709938;
        Sat, 28 Oct 2023 13:58:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902c21100b001bbb8d5166bsm3590751pll.123.2023.10.28.13.58.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 13:58:28 -0700 (PDT)
Message-ID: <653d75f4.170a0220.43e0.af3f@mx.google.com>
Date: Sat, 28 Oct 2023 13:58:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.59-cip8-106-g65bd536c294e
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 9 runs,
 5 regressions (v6.1.59-cip8-106-g65bd536c294e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 28 Oct 2023 20:58:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13492

cip-gitlab/ci/pavel/linux-test ltp-timers: 9 runs, 5 regressions (v6.1.59-c=
ip8-106-g65bd536c294e)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
qemu_riscv64      | riscv | lab-broonie   | gcc-10   | defconfig           =
       | 2          =

qemu_smp8_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig           =
       | 2          =

rk3399-gru-kevin  | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.59-cip8-106-g65bd536c294e/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.59-cip8-106-g65bd536c294e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      65bd536c294e2f5356dabd805e63516e90d72628

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
qemu_riscv64      | riscv | lab-broonie   | gcc-10   | defconfig           =
       | 2          =


  Details:     https://kernelci.org/test/plan/id/653d70bf1bec41a75defcf02

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/riscv/defconfig/gcc-10/lab-broonie/ltp-time=
rs-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/riscv/defconfig/gcc-10/lab-broonie/ltp-time=
rs-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/653d70bf1be=
c41a75defcf07
        failing since 1 day (last pass: v5.10.194-915-g33f52aa14b957, first=
 fail: v6.1.58-cip7-132-gb38ea1474c159) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/653d70bf1be=
c41a75defcf07
        failing since 1 day (last pass: v5.10.194-915-g33f52aa14b957, first=
 fail: v6.1.58-cip7-132-gb38ea1474c159) =

 =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
qemu_smp8_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig           =
       | 2          =


  Details:     https://kernelci.org/test/plan/id/653d6e3e722e51d29defcf01

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/riscv/defconfig/gcc-10/lab-broonie/ltp-time=
rs-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/riscv/defconfig/gcc-10/lab-broonie/ltp-time=
rs-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/653d6e3e722=
e51d29defcf06
        new failure (last pass: v6.1.58-cip7-132-gb38ea1474c159) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/653d6e3e722=
e51d29defcf06
        new failure (last pass: v6.1.58-cip7-132-gb38ea1474c159) =

 =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
rk3399-gru-kevin  | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/653d6fd794a6401d07efcf02

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/653d6fd794a6401d07e=
fcf03
        new failure (last pass: v6.1.58-cip7-132-gb38ea1474c159) =

 =20

