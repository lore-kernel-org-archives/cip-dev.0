Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0132CC001DF
	for <webhook@archiver.kernel.org>; Sat, 15 Jul 2023 02:31:20 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web10.4863.1689388277067353038
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 14 Jul 2023 19:31:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=bl5vF10v;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-262e839647eso1715095a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 14 Jul 2023 19:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689388276; x=1691980276;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OAOfz1OdUq/kPXW78UN3RDbbXnIfswF2BPuLGmK+MmM=;
        b=bl5vF10vaPNzUGg8+P5e+5gAT0RIJTZxMZVe0T5zQK4lfVnkkXQ0KEXz7p8sEE/26G
         sEXHBYu1L2nAw8aTaRIZF7GN1//Fk++3pOs/QEUKg9vGCMmheNkJp/NTmQeTJxjTldUe
         s2D9KYZCXSMdYNy/V3l1Q60VvlHY5R8dY0Wqy/FlynNDBIvUqr8bw3tkujzNP53ukP1W
         tNOncIK163ux+Wl4PmN4ShZzact2JKmsqaBiqoTxWTxBlx2nIo5ycCFoe9rCJ+LCGGQK
         a3XFNXuTKV9jU1S1x/viZrvK9nGDWacJ0o6dlHE+D5BQ0Q1MvRxho731zAsNqsW3hwjo
         m44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689388276; x=1691980276;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OAOfz1OdUq/kPXW78UN3RDbbXnIfswF2BPuLGmK+MmM=;
        b=a7mESd93dm0rMb/en21uegHu2DfdISkMGgeGo5BHhivPadpr7zrij2pm7p4hObV+3B
         JRtZq0rYn3SCTHntD0KwA12/ezLzg0rc/mRGP5sNqRtK/qmhbM8dWP38xBxnk0GYa5VJ
         k6B/b0qqi6Js6x2iPbVJGAhM+xrcBCgNa+uKZFOvb/Ewx82m6NT3HdXthvCAqBW1f8gF
         78tU6qoYvGsPcn9JYcvx7+AWbEqjP5nLANym6V58DUBHUQkV5oF1NlSXTi7Of4Bp+En7
         TInkCrQI1YiMTRSYLUmTM1bYq/FEQEt93vGIjP6oMD6wQBQQx1mG6cq15y0dimLz/Bdv
         C/SA==
X-Gm-Message-State: ABy/qLYf4FnKoXw9tF2UkrmIYgQvULNCBCXKXjXrFq1Bqorv/xRnyQ77
	FbLZAo5nQiO8CgKFz7XKdCxCSHw0IL1LnfzRpLv25Q==
X-Google-Smtp-Source: APBJJlGm3GKU9h8BoKlQdoNUOdDa85oSJ3ZybK0MwjS+wxTH8s1cz0lFQHdNTpN2dTTq7VzMsKIX2w==
X-Received: by 2002:a17:90b:1bd0:b0:263:3194:d691 with SMTP id oa16-20020a17090b1bd000b002633194d691mr5561069pjb.45.1689388276064;
        Fri, 14 Jul 2023 19:31:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b30-20020a63931e000000b0055bbc746272sm8002328pge.17.2023.07.14.19.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 19:31:11 -0700 (PDT)
Message-ID: <64b204ef.630a0220.f864.1709@mx.google.com>
Date: Fri, 14 Jul 2023 19:31:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.186-cip37-rt15
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt ltp-timers: 8 runs,
 5 regressions (v5.10.186-cip37-rt15)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 15 Jul 2023 02:31:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12360

cip/linux-5.10.y-cip-rt ltp-timers: 8 runs, 5 regressions (v5.10.186-cip37-=
rt15)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_riscv64      | riscv | lab-broonie   | gcc-10   | defconfig | 2       =
   =

qemu_riscv64      | riscv | lab-collabora | gcc-10   | defconfig | 2       =
   =

qemu_smp8_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.186-cip37-rt15/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.186-cip37-rt15
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      db05335d4d4ee47b8fc64652b2c2ad8e57eeaf52

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_riscv64      | riscv | lab-broonie   | gcc-10   | defconfig | 2       =
   =


  Details:     https://kernelci.org/test/plan/id/64b1ef40a163f4b38e8ace23

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_riscv64.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_riscv64.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b1ef40a16=
3f4b38e8ace28
        failing since 22 days (last pass: v5.10.179-cip32-rt13, first fail:=
 v5.10.184-cip36-rt14) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b1ef40a16=
3f4b38e8ace28
        failing since 22 days (last pass: v5.10.179-cip32-rt13, first fail:=
 v5.10.184-cip36-rt14) =

 =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_riscv64      | riscv | lab-collabora | gcc-10   | defconfig | 2       =
   =


  Details:     https://kernelci.org/test/plan/id/64b1ef79e99ad22d348ace25

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu_riscv64=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu_riscv64=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b1ef79e99=
ad22d348ace2a
        failing since 22 days (last pass: v5.10.179-cip32-rt13, first fail:=
 v5.10.184-cip36-rt14)

    2023-07-15T00:59:26.859965  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b1ef79e99=
ad22d348ace2a
        failing since 22 days (last pass: v5.10.179-cip32-rt13, first fail:=
 v5.10.184-cip36-rt14)

    2023-07-15T00:59:26.859965  =

   =

 =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/64b1f2ecfe66e8da968ace1c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_smp8_risc=
v64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_smp8_risc=
v64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/64b1f2ecfe66e8da968=
ace1d
        new failure (last pass: v5.10.184-cip36-rt14) =

 =20

