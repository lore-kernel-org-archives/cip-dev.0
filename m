Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38D7C77B73
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 18:37:44 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.17021.1685990259780830031
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 11:37:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=qrDUkEN7;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-64d24136685so3726863b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 11:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685990259; x=1688582259;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8k3ZaaDaQ///ksob00BIbxkWBJQYo/S32lukxFPyRns=;
        b=qrDUkEN7WU1BTPdUp1rdrkxRfBLhAcIifadwHo5nZebGZRUEPbo998Y33TpJT4eUqd
         RlOCYc6pgJdGtPMKUhDqEEDJFoemgNCHDcM+EGfGopPEQurk2G/+tIFZX+KaybHHItN6
         401p5l0z23S1/jzqm7IcpkI/+q5++eanvnKGQaqeFHa/7RUsaXRLvWkaYr7koBi+Oe7D
         OOl4YoAeLBSqP6bsmdMJEu4ruXVi8w6lg656QeWevW79CzFMjEZJOm0jbtBAfLWm4FrM
         mD4em2PtqBtG/uPH2JOpVq3MV0bPB5Gwu9P5v8dLlW1iN1qdhPDCGZGlOycZ6peoDqof
         8wQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685990259; x=1688582259;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8k3ZaaDaQ///ksob00BIbxkWBJQYo/S32lukxFPyRns=;
        b=JAOJ/NiiJ1IAiPas22PY8lOBkc+OZXrQSgJbDV6cZ8XewekjpUt1DG/j8S0b05ojXw
         GsDNm5KDnM7UvoRbrRDCrYwUAKtqtVERw5LM1sRVyEKtdkddzinCvrQ32oBdE/mSk73m
         jt8n0mRQ/mmCOjHbLUwx1vlfWmZZ1n4PSraZPRLHB6HCaoLb+OsFT6Pct8zlQnKu0tHR
         m2mYhU1L1C8kP9WWdm5w6j6VJo5D+Jb22dBJvlDcN+FjvIucCTgnm4losJIqmN+TM+tG
         ClVmWHaqSF7Zq+3bUHuC9RuJt2K9dX/ckyMRa7ff+pCwCuqpPs3x4qNJnKUwVgwbpbSU
         tmnQ==
X-Gm-Message-State: AC+VfDy1XnxFjaJSR2wXgB0lNvVPZS5iSLneC/2O4CnuPgVp1Cb6jL0o
	3iVDAdk4CahqkorjKrLLZenBjbH612sSJlC1Czakpg==
X-Google-Smtp-Source: ACHHUZ5atNUGjXosxlJEbdcSgN0HgprzXGWHug2/Gz/rHieECysi3hZIFISmhWntVMlEgKphO2Y5wg==
X-Received: by 2002:a05:6a00:189b:b0:658:e9f4:f7b6 with SMTP id x27-20020a056a00189b00b00658e9f4f7b6mr344066pfh.15.1685990258766;
        Mon, 05 Jun 2023 11:37:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n21-20020aa78a55000000b006259e883ee9sm5494946pfa.189.2023.06.05.11.37.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 11:37:37 -0700 (PDT)
Message-ID: <647e2b71.a70a0220.23693.9d40@mx.google.com>
Date: Mon, 05 Jun 2023 11:37:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-26-gc198172c84b6a
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 16 runs,
 7 regressions (v5.10.180-cip34-26-gc198172c84b6a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 18:37:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11822

cip-gitlab/ci/pavel/linux-test ltp-timers: 16 runs, 7 regressions (v5.10.18=
0-cip34-26-gc198172c84b6a)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

mt8173-elm-hana           | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

qemu_riscv64              | riscv  | lab-broonie   | gcc-10   | defconfig  =
                  | 2          =

qemu_riscv64              | riscv  | lab-collabora | gcc-10   | defconfig  =
                  | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.180-cip34-26-gc198172c84b6a/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.180-cip34-26-gc198172c84b6a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c198172c84b6a9338925de15df053d71eda6a6cc

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e20324985e785dff5def7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/647e20324985e785dff=
5def8
        new failure (last pass: v6.1.26-1298-g61395b9756bd5) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
mt8173-elm-hana           | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/647e1e3aa489a79679f5de2d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-timers-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-timers-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/647e1e3aa489a79679f=
5de2e
        failing since 0 day (last pass: v6.1.26-1281-g84d5372e0f31, first f=
ail: v6.1.26-1298-g61395b9756bd5) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
qemu_riscv64              | riscv  | lab-broonie   | gcc-10   | defconfig  =
                  | 2          =


  Details:     https://kernelci.org/test/plan/id/647e1f77e7a288918bf5de2e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/riscv/defconfig/gcc-10/lab-broonie/ltp-t=
imers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/riscv/defconfig/gcc-10/lab-broonie/ltp-t=
imers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30527.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647e1f77e7a=
288918bf5de33
        failing since 0 day (last pass: v6.1.26-1302-g2631206dd75c2, first =
fail: v6.1.26-1298-g61395b9756bd5) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647e1f77e7a=
288918bf5de33
        failing since 0 day (last pass: v6.1.26-1302-g2631206dd75c2, first =
fail: v6.1.26-1298-g61395b9756bd5) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
qemu_riscv64              | riscv  | lab-collabora | gcc-10   | defconfig  =
                  | 2          =


  Details:     https://kernelci.org/test/plan/id/647e192661a6072abef5de32

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/riscv/defconfig/gcc-10/lab-collabora/ltp=
-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/riscv/defconfig/gcc-10/lab-collabora/ltp=
-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30527.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647e192661a=
6072abef5de37
        failing since 0 day (last pass: v6.1.26-1302-g2631206dd75c2, first =
fail: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:19:24.454089  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647e192661a=
6072abef5de37
        failing since 0 day (last pass: v6.1.26-1302-g2631206dd75c2, first =
fail: v6.1.26-1298-g61395b9756bd5)

    2023-06-05T17:19:24.454089  =

   =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/647e25adb0a64ab488f5de4e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/647e25adb0a64ab488f=
5de4f
        new failure (last pass: v6.1.26-1298-g61395b9756bd5) =

 =20

