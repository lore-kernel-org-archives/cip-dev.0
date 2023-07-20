Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9A9EB64DC
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 13:18:06 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.12704.1689859082708856548
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Jul 2023 06:18:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=n+N0yAHt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso5469025ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Jul 2023 06:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689859081; x=1690463881;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M7p0QSA2XGl8SYaio2AwBU9sVK7mGywvr2PIHBSiS4o=;
        b=n+N0yAHtMRtefQJmmJm9OkH0/90kR+Q9x8wsiZZQjZa96xTFMptEO6XKsn9Nz3h+wH
         JEkWtHfaWSzP1UWX2dVWi9X57soKWbbL8iin9TN7pRlYDn72bajWGsKfcZ5vuhC1lUzr
         fOOPPt96qce4+GF8hBn64Ji4+5ugHYIIqv6GiWXEuSvyOBZoMPisFRhfAFFFnGJOUqaQ
         C2s46ooBkBu0ZN439QsS/urN+Wka55HzCbtyV42dmGRNACoshhXtcvib/rdcltYQt0E3
         P8mDOGN9htEm63ywVpfrcEP5my+uB4AvEyqk5Jeu9YsuQ6Um4wVe1mqOjodwJmZfTMs0
         A1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689859081; x=1690463881;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7p0QSA2XGl8SYaio2AwBU9sVK7mGywvr2PIHBSiS4o=;
        b=H95ggK8fdB/yn34F4Bc/gQRgL0ZQ+Oj6iomAlFuD3dYlzmIDFvWNsxZW/GPKZLD6AC
         cXPzs/xExNzn1/4vt9/W0sEzTuzxcmXVb8KudE1K3lvzrkL9+ckPnZ7cjKvVM5eNlbzM
         /XSCtThdfoBjTtjOuBVsuvOPXBNMMPTz13rDI+mXRiG7TBI863gXdGxx6T1HyvtO26xl
         8iqASPCLnhAuLObPL0moFRR9MCrNljXwngWKLWY6bgiKcFQZ0+Ap7JMRKkNWroKMTHQk
         Qe/39IJtmjhpIHN0matF7uldKOR13mIm6bAlxcjPack7MmIX9cf2XB/FE2r4zmhxKmwC
         NCkg==
X-Gm-Message-State: ABy/qLZvEAissoGG0ANllVPShF6wN6d6Ys0bmiwWQqf5eqDSpxz1iIep
	hRzkI2APhQMPHHx5fc1yZEuEF76IiEdNULPPqe1PwA==
X-Google-Smtp-Source: APBJJlGJ7Ds9dGswUSYtB2AwEB5Amtoy1dXXPoJjGUjEdd3neK1XpKm5qq+RrGJ3dSj2esjjn1wEnw==
X-Received: by 2002:a17:903:32c9:b0:1b8:860c:2a7 with SMTP id i9-20020a17090332c900b001b8860c02a7mr2725722plr.28.1689859081239;
        Thu, 20 Jul 2023 06:18:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b001b53c8659fesm1339471plg.30.2023.07.20.06.18.00
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:18:00 -0700 (PDT)
Message-ID: <64b93408.170a0220.b9e2f.1d54@mx.google.com>
Date: Thu, 20 Jul 2023 06:18:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.38-cip1-13-ga3621452a4fc
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 6 runs,
 4 regressions (v6.1.38-cip1-13-ga3621452a4fc)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 13:18:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12468

cip-gitlab/ci/pavel/linux-test ltp-timers: 6 runs, 4 regressions (v6.1.38-c=
ip1-13-ga3621452a4fc)

Regressions Summary
-------------------

platform     | arch   | lab           | compiler | defconfig        | regre=
ssions
-------------+--------+---------------+----------+------------------+------=
------
qemu_riscv64 | riscv  | lab-broonie   | gcc-10   | defconfig        | 2    =
      =

qemu_x86_64  | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig | 2    =
      =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.38-cip1-13-ga3621452a4fc/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.38-cip1-13-ga3621452a4fc
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a3621452a4fc3c78df12c07b61aa0b03d9af5fec

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


  Details:     https://kernelci.org/test/plan/id/64b91aa218d52c7bc38ace2c

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/riscv/defconfig/gcc-10/lab-broonie/ltp-timer=
s-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/riscv/defconfig/gcc-10/lab-broonie/ltp-timer=
s-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b91aa218d=
52c7bc38ace31
        failing since 44 days (last pass: v6.1.26-1298-g61395b9756bd5, firs=
t fail: v5.10.180-cip34-26-gc198172c84b6a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b91aa218d=
52c7bc38ace31
        failing since 44 days (last pass: v6.1.26-1298-g61395b9756bd5, firs=
t fail: v5.10.180-cip34-26-gc198172c84b6a) =

 =



platform     | arch   | lab           | compiler | defconfig        | regre=
ssions
-------------+--------+---------------+----------+------------------+------=
------
qemu_x86_64  | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig | 2    =
      =


  Details:     https://kernelci.org/test/plan/id/64b91db51a3db321658ace20

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/x86_64/x86_64_defconfig/gcc-10/lab-collabora=
/ltp-timers-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/x86_64/x86_64_defconfig/gcc-10/lab-collabora=
/ltp-timers-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b91db51a3=
db321658ace25
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480)

    2023-07-20T11:42:25.655912  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b91db51a3=
db321658ace25
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480)

    2023-07-20T11:42:25.655912  =

   =

 =20

