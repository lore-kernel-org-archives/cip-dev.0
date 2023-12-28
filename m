Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B5AC46CD4
	for <webhook@archiver.kernel.org>; Thu, 28 Dec 2023 00:37:35 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
 by mx.groups.io with SMTP id smtpd.web10.114524.1703723852011737431
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 27 Dec 2023 16:37:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=obUXbVLS;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.180, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bba50cd318so2931343b6e.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 27 Dec 2023 16:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703723850; x=1704328650; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VWZT/L1msOCN8GWKxDHeqYhP2ElJHnHDZOzUtH9wX2w=;
        b=obUXbVLSu2cWqsTvG/Y+zSy7UdG9FUS09QE4BXw4q6ix6pW/uq1DgcqjUM9JcXvkpz
         V+EycgsP09oQJGpBG28bpgiHCVhkVca+xuEjl8AeA9uo3MoRA4b3MSBTrLGHGDKDpXRP
         dT9cbXdEw/FWfhVwkUUCPSHTuxbgmmf03pTjYKWjBdujtBCb1WAzeaUVGkf5wPrQUUEW
         B/BGBIgQPsvX9zcs8z8ohk3Kyzwz/H0Z1RCHZjANBPa/bLLyw5TIeqtsdBbM6KWa3AgH
         H8Aosmj1aSGi9auUMQgiCF0bc870FRWjZEH4HDqSlV3RvDtTxX6SQKq/1HiOXglGdFSb
         U+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703723850; x=1704328650;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VWZT/L1msOCN8GWKxDHeqYhP2ElJHnHDZOzUtH9wX2w=;
        b=m3EawdvGr06dkNnCunJkdP1X6JKDPuNz0OW7k6AKQOsIApi1Wa1YXM2QSHOOcuUZwl
         ZGYZDX1yhQ5gVWa+NSmkgCvNHNucOvfZo/1CmTek12iFOssyufP1xBH5ObT5Vl9McRb/
         vOlHVlF+9pet17vMxGaKsFO7pbsWPIEo9v//i0KQyh/wSIV0cMy/A/UQCND8HAA5eLBO
         wxgJQHxpwily00BfQccsZjDdx1Pu7+E3mizYxvTkkOTMNQGJ/ft0Ord95Rl/b2QYiOwg
         AVcisr7bT0ujGXjN1aEfq3dFh+/1z8rOFnEJNXNOJoHY6bnphhlCK//GZqtXyffdINbH
         aWeg==
X-Gm-Message-State: AOJu0Yy4MLTz74nYrO9uCg+GzAvMJcWOms1N+wTiTou7rRdLNzBzvuNI
	3/MuwUfEoRXP9XQsGPuQ0XcIa2gX8CFbzuHd0km0M5/Ena8=
X-Google-Smtp-Source: AGHT+IEqj9468Jqq73fXHL5pZyZmGcdTNdRfop7aFZ36yAz76BtyYUAcQhNyjMoLEsnjE3r5YtUNnQ==
X-Received: by 2002:a05:6808:114a:b0:3bb:cd0d:aa55 with SMTP id u10-20020a056808114a00b003bbcd0daa55mr992527oiu.72.1703723850502;
        Wed, 27 Dec 2023 16:37:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a18-20020aa78e92000000b006d9beb968c3sm5443181pfr.106.2023.12.27.16.37.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 16:37:30 -0800 (PST)
Message-ID: <658cc34a.a70a0220.e8f21.b220@mx.google.com>
Date: Wed, 27 Dec 2023 16:37:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.66-cip11-rt6-10-g38253b8903b4
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 18 runs,
 6 regressions (v6.1.66-cip11-rt6-10-g38253b8903b4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Dec 2023 00:37:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14213

cip-gitlab/ci/pavel/linux-test ltp-timers: 18 runs, 6 regressions (v6.1.66-=
cip11-rt6-10-g38253b8903b4)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

qemu_riscv64              | riscv  | lab-broonie   | gcc-10   | defconfig  =
                | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.66-cip11-rt6-10-g38253b8903b4/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.66-cip11-rt6-10-g38253b8903b4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      38253b8903b46da162814048c6f555bba4399ca8

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb9a015bec02d56e13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/658cb9a015bec02d56e=
13476
        new failure (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/658cba7627b8b7f8a8e13477

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/658cba7627b8b7f8a8e=
13478
        new failure (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/658cba7b27b8b7f8a8e1347b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/658cba7b27b8b7f8a8e=
1347c
        new failure (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
qemu_riscv64              | riscv  | lab-broonie   | gcc-10   | defconfig  =
                | 2          =


  Details:     https://kernelci.org/test/plan/id/658cafcf7b65c1d0fae1349c

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/riscv/defconfig/gcc-10/lab-broonie/ltp-=
timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/riscv/defconfig/gcc-10/lab-broonie/ltp-=
timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/658cafcf7b6=
5c1d0fae134a1
        failing since 14 days (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6=
, first fail: v5.10.201-cip41-77-g545d45774209f) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/658cafcf7b6=
5c1d0fae134a1
        failing since 14 days (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6=
, first fail: v5.10.201-cip41-77-g545d45774209f) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb828e4eca1a5a8e13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/658cb828e4eca1a5a8e=
13476
        new failure (last pass: v6.1.64-cip10-rt5) =

 =20

