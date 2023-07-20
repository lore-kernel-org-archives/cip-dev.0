Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B720CEB64DC
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 15:12:16 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.15434.1689865935875064425
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Jul 2023 08:12:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=TKbzXbLz;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1b89114266dso6775855ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Jul 2023 08:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689865935; x=1690470735;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TrUJUvfcTdkvC86WJzmjIlwJbT059Pu59ioZZySsDVk=;
        b=TKbzXbLzEQhhAt/kOBi3kbJ1XrAhq6tPBTzMGPANgOneL+tfMv4/QN7qdEcANLQVEM
         fio/MDn+NbGAAzpwONfDnRGjzVHoSCtZ/t6+1TrawlgE7hKdBDUoYqlSwsQvGAprTpJL
         40jsVv2JYQ7+ms6FuZDYgyqFotgPgfPC6WIBd2hwq/6Rj3gLVf/3rfK9Ezj8u33ySuUW
         bPaYU12K5Z8W6MvhfLH9YcIMJlLDku9IdfPmsXOIxpkYy9excUAzPZVlaqbeX6foMi63
         0mgp7pVHt0yv3aTKJtNH+h4e9Mj2Gxa+nvl9Ird/zhwJ6Zj052bDfZByx8m6x9x/mHVr
         CQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689865935; x=1690470735;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TrUJUvfcTdkvC86WJzmjIlwJbT059Pu59ioZZySsDVk=;
        b=RSU3s+DDwH2Rp09Pf2CckrcTKGZ/FqwfhPFN27G6Gb2d680zkdLGnY2YqF1poUe6vI
         +LWb32kum/DDm8LxPJPnKste8SNRte0nYm9ZQ1rjZI4tMOvYiqA75Htfc2KuDKMGpZ0e
         JKe1PmZA7XTKH4CaGVqQwG2QnZaVLnT0qRuNPFmCy55YECue/eiTVO9heMcP19f75jIH
         RuGYNsBzA+Zn8VLm0XxDZUPUrCpNpeL23Pigs9eDOIcusU1tyEumISIi3bb7oVVv9AHw
         T1JjmLsvrbN/1sCeDkBa72tjheMGEKXMKTV6cplvy3FLlqeip/xzwP9ev1HP06RpNiD1
         Rmyw==
X-Gm-Message-State: ABy/qLYR+pXly9ABSViXbDrDIdt6j0HKJlU0+KJ3lBLQSIjFfRcGzyhF
	6GKDBZpe1TZFfJC+vhp02f46sl056kmT1+/yJ3oZAA==
X-Google-Smtp-Source: APBJJlHa3HSnRzwPQkOpYtkBYX1ETng6QZEY37SM2/15+/CvLp/rX2CyfkaeMBVGYtk80tJxu5g43w==
X-Received: by 2002:a17:903:124b:b0:1b8:9225:4367 with SMTP id u11-20020a170903124b00b001b892254367mr7552763plh.65.1689865934812;
        Thu, 20 Jul 2023 08:12:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090341c100b001b882880550sm1472929ple.282.2023.07.20.08.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 08:12:14 -0700 (PDT)
Message-ID: <64b94ece.170a0220.6cf45.2401@mx.google.com>
Date: Thu, 20 Jul 2023 08:12:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Kernel: v6.1.38-cip1-10-gf4eb42f19246
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip ltp-timers: 6 runs,
 6 regressions (v6.1.38-cip1-10-gf4eb42f19246)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 15:12:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12475

cip/linux-6.1.y-cip ltp-timers: 6 runs, 6 regressions (v6.1.38-cip1-10-gf4e=
b42f19246)

Regressions Summary
-------------------

platform     | arch   | lab           | compiler | defconfig        | regre=
ssions
-------------+--------+---------------+----------+------------------+------=
------
qemu_riscv64 | riscv  | lab-broonie   | gcc-10   | defconfig        | 2    =
      =

qemu_riscv64 | riscv  | lab-collabora | gcc-10   | defconfig        | 2    =
      =

qemu_x86_64  | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig | 2    =
      =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.38-cip1-10-gf4eb42f19246/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.38-cip1-10-gf4eb42f19246
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f4eb42f1924629d499c0622f4aa8616d1d719851

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform     | arch   | lab           | compiler | defconfig        | regre=
ssions
-------------+--------+---------------+----------+------------------+------=
------
qemu_riscv64 | riscv  | lab-broonie   | gcc-10   | defconfig        | 2    =
      =


  Details:     https://kernelci.org/test/plan/id/64b94385d40554560b8ace4a

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.38-ci=
p1-10-gf4eb42f19246/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_risc=
v64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.38-ci=
p1-10-gf4eb42f19246/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_risc=
v64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b94385d40=
554560b8ace4f
        failing since 14 days (last pass: v6.1.31-53-g486caac40d06, first f=
ail: v6.1.31-64-g93fc2d0f5008) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b94385d40=
554560b8ace4f
        failing since 14 days (last pass: v6.1.31-53-g486caac40d06, first f=
ail: v6.1.31-64-g93fc2d0f5008) =

 =



platform     | arch   | lab           | compiler | defconfig        | regre=
ssions
-------------+--------+---------------+----------+------------------+------=
------
qemu_riscv64 | riscv  | lab-collabora | gcc-10   | defconfig        | 2    =
      =


  Details:     https://kernelci.org/test/plan/id/64b93aac960b2dca058ace30

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.38-ci=
p1-10-gf4eb42f19246/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu_ri=
scv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.38-ci=
p1-10-gf4eb42f19246/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu_ri=
scv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b93aac960=
b2dca058ace35
        failing since 14 days (last pass: v6.1.31-53-g486caac40d06, first f=
ail: v6.1.31-64-g93fc2d0f5008)

    2023-07-20T13:46:08.618158  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b93aac960=
b2dca058ace35
        failing since 14 days (last pass: v6.1.31-53-g486caac40d06, first f=
ail: v6.1.31-64-g93fc2d0f5008)

    2023-07-20T13:46:08.618158  =

   =

 =



platform     | arch   | lab           | compiler | defconfig        | regre=
ssions
-------------+--------+---------------+----------+------------------+------=
------
qemu_x86_64  | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig | 2    =
      =


  Details:     https://kernelci.org/test/plan/id/64b9379f2176d510388ace1f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.38-ci=
p1-10-gf4eb42f19246/x86_64/x86_64_defconfig/gcc-10/lab-collabora/ltp-timers=
-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.38-ci=
p1-10-gf4eb42f19246/x86_64/x86_64_defconfig/gcc-10/lab-collabora/ltp-timers=
-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b9379f217=
6d510388ace24
        new failure (last pass: v6.1.31-65-ge66be31505fa)

    2023-07-20T13:33:02.872725  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b9379f217=
6d510388ace24
        new failure (last pass: v6.1.31-65-ge66be31505fa)

    2023-07-20T13:33:02.872725  =

   =

 =20

