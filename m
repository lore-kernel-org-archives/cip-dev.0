Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26121EE4996
	for <webhook@archiver.kernel.org>; Tue, 22 Aug 2023 16:54:35 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.1347.1692723265751934439
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 22 Aug 2023 09:54:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=iphvM3ls;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1bf5c314a57so16934875ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 22 Aug 2023 09:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692723265; x=1693328065;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+iMH/B1xEdQl68IZKEPiprsBHr2qduuGZonqsPojLPE=;
        b=iphvM3lsGCeB5rr+dNwiRNn7moJqwQMRsycHmevClCyU6xgzzqFzscxfPV7sDQch/g
         yyzQzoNITm/8KzDT5wCcwWZVeYu7JDzM0Tgk6rHOLG9Irn8xrzwbt+b4Mx6ETD8ZAmKO
         RciXoNv1PqDidaa652jcY0NJXKB8w3dhvLRQ1892LfOsGGnveItklAjAz127aUKAbb97
         mIJeew4QJ2IybOZ/mx4l8RExM6Sy5CFdoA8OoHi8QuKGvLZ+KFy+ImVBIS4Tbl4jBe3q
         Lql7eqeIlQv8K38NN0FS6rNZXuXKP6CCZY7oJN69LaE50QCyGtFTNcFWGUjW7Lw7QHb4
         0GUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692723265; x=1693328065;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+iMH/B1xEdQl68IZKEPiprsBHr2qduuGZonqsPojLPE=;
        b=WZH+MuNJ6cJCWG4pUU2hYvdi+W9445lzJlZP5SbK1xM1rbpwhgcmJJAB3Rg+emmtuG
         x73T706XONAnbgJMmToLhb9+yAdaMSR6ueo+SmjCslB9nhGQPrvfuUWpsNLxH0cGgDO+
         ci00Ef5seKHwaWTzPUyXml9PjkJkiZmwoyhsO5fe3RVpFwrP/sDaqHsY2cB14bN6Fub6
         UGmnoolXjL9dW6ffhwgUFiLL4dSJpmOmMcGxxBwquudWicJ6HTIxhj9dxo609Zn9E++B
         FUgEb8xpdcWtutLOjzZOgQD7ffeabmfRUZUYaa49RT9cO0HseBfFCidaqBp1B8iDBx4p
         z2Zg==
X-Gm-Message-State: AOJu0YwbbJOycXSZ3OxPaKuse36nOi0zLtQDtGMlu+iR5p7566B1ik4c
	fCg3b6ATb1f3/iVgN9FvDElsSlm45gkkBZdwNz0=
X-Google-Smtp-Source: AGHT+IHan366ZqLpe6Lx+tCXxmRINM3LZeYoyKdnhi+wV2aKW75WAcGzSvb3PZwd8yD5Xm5M50UZTg==
X-Received: by 2002:a17:902:c14b:b0:1c0:a53a:4fc9 with SMTP id 11-20020a170902c14b00b001c0a53a4fc9mr269734plj.15.1692723264590;
        Tue, 22 Aug 2023 09:54:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jk24-20020a170903331800b001b9c960ffeasm9339555plb.47.2023.08.22.09.54.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 09:54:23 -0700 (PDT)
Message-ID: <64e4e83f.170a0220.4400b.1d75@mx.google.com>
Date: Tue, 22 Aug 2023 09:54:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.45-cip3-31-gbae6b8e9a2cff
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs,
 2 regressions (v6.1.45-cip3-31-gbae6b8e9a2cff)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Aug 2023 16:54:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12830

cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs, 2 regressions (v6.1.45-c=
ip3-31-gbae6b8e9a2cff)

Regressions Summary
-------------------

platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.45-cip3-31-gbae6b8e9a2cff/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.45-cip3-31-gbae6b8e9a2cff
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      bae6b8e9a2cff1558da85b327d6a7bd4a5d21d0a

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64e4dba9780a1d9ad4b1e3af

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/riscv/defconfig/gcc-10/lab-broonie/ltp-time=
rs-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/riscv/defconfig/gcc-10/lab-broonie/ltp-time=
rs-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64e4dba9780=
a1d9ad4b1e3b6
        failing since 77 days (last pass: v6.1.26-1298-g61395b9756bd5, firs=
t fail: v5.10.180-cip34-26-gc198172c84b6a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64e4dba9780=
a1d9ad4b1e3b6
        failing since 77 days (last pass: v6.1.26-1298-g61395b9756bd5, firs=
t fail: v5.10.180-cip34-26-gc198172c84b6a) =

 =20

