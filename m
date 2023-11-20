Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D91C54FB9
	for <webhook@archiver.kernel.org>; Mon, 20 Nov 2023 11:21:49 +0000 (UTC)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
 by mx.groups.io with SMTP id smtpd.web11.48157.1700479305524231697
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 20 Nov 2023 03:21:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=D8334d7O;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.177, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3b5ff072fc4so2765850b6e.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 20 Nov 2023 03:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700479304; x=1701084104; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yWaoXR0PzzbErIsQc+TuGCYaZQxiT7nklD6Ewrpn7XM=;
        b=D8334d7OhVAlyHbZ1YUocujPSQ2SQQith+aI/gJrl3o5aT+Fya/nFPff682xEB23Qy
         H31HXjpgsrrSyXmLPcH5jG5eTl8d6HKOztKpHvvPnGlXOmnmCQRoFjHzBLyIvgBF2Zi4
         KKGhZZ+XKKjxveUZba8Jo70tkojge9GOWfxk9kMBE9dTu/fEW/JEeMaTngJKTN7eRgnq
         Xq195cBpRPZBlaGFSf5xQsJ+Vhx19q2G+tB7g35Ek6Mebu18In7YHH5I/dydN5wnG94b
         3yZmocbsog6fTKpkMniSDaTiuqdIr07glU8/sGFYcEj3pWn+D9DmYXPemhE2CADKY3Dd
         736A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700479304; x=1701084104;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yWaoXR0PzzbErIsQc+TuGCYaZQxiT7nklD6Ewrpn7XM=;
        b=vT5HrESZRYMv5v3eR9UWyAxq8Romd435Xa8EG9VI4kO/OARMkPu0MXqlXMXlT7ymeB
         bMhXD3Ayrj0W62x41MLNhu/KPIySJZ0j8urRP38pJZ0efjqnN5FwjcUNUyI1fnU8PgbO
         wEmXGguA4Q2DzpwGmD+cffmSG081BcsqkCSqZcH81NUp238435wON7fwWFreWYYTQMZ3
         SSiVkDb6/qIXsob2w9as27RK3QeTww/lzGeNNDKMywMHaHr/bpQCTpvQLVI+m6hc2mFg
         xzo8itqfUMqTpCdm85mM1VuzI0mXGLStQwNIjz2Ixkb1ZIIsB0ES7zIl7zc/xIXyVTZV
         QHLA==
X-Gm-Message-State: AOJu0YzpCT/dhGavfakjvOTBcTUmW9tztN9/7yLxneas7SZ8qH8lCmKj
	7ySpVZyutRQsemYukgsb21sPDqnwwSGxsLih43c=
X-Google-Smtp-Source: AGHT+IF6PDiSgfSfyyRz4yFxO7VwqmxGTw6lKSlmlZwGItGr6pM/FFWlW3UJuB4ooMOnc82t/UPdnw==
X-Received: by 2002:a05:6808:318e:b0:3ae:1b21:fab1 with SMTP id cd14-20020a056808318e00b003ae1b21fab1mr2368289oib.31.1700479303850;
        Mon, 20 Nov 2023 03:21:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k25-20020a63ba19000000b005b944b20f34sm5014374pgf.85.2023.11.20.03.21.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 03:21:42 -0800 (PST)
Message-ID: <655b4146.630a0220.fe1f1.ad03@mx.google.com>
Date: Mon, 20 Nov 2023 03:21:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.200-cip40-513-g195b5d2b5c744
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 7 runs,
 4 regressions (v5.10.200-cip40-513-g195b5d2b5c744)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Nov 2023 11:21:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13601

cip-gitlab/ci/pavel/linux-test ltp-timers: 7 runs, 4 regressions (v5.10.200=
-cip40-513-g195b5d2b5c744)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
 | regressions
-----------------------------+-------+---------------+----------+----------=
-+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
 | 1          =

qemu_riscv64                 | riscv | lab-broonie   | gcc-10   | defconfig=
 | 1          =

qemu_smp8_riscv64            | riscv | lab-broonie   | gcc-10   | defconfig=
 | 1          =

qemu_smp8_riscv64            | riscv | lab-collabora | gcc-10   | defconfig=
 | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.200-cip40-513-g195b5d2b5c744/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.200-cip40-513-g195b5d2b5c744
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      195b5d2b5c7445a89862b44b490b78e540906e81

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
 | regressions
-----------------------------+-------+---------------+----------+----------=
-+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/655b3f15af58f000c37e4ad7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm64/defconfig/gcc-10/lab-broonie/ltp-=
timers-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm64/defconfig/gcc-10/lab-broonie/ltp-=
timers-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/655b3f15af58f000c37=
e4ad8
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e) =

 =



platform                     | arch  | lab           | compiler | defconfig=
 | regressions
-----------------------------+-------+---------------+----------+----------=
-+------------
qemu_riscv64                 | riscv | lab-broonie   | gcc-10   | defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/655b3a1551d2ccf8c17e4a83

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/riscv/defconfig/gcc-10/lab-broonie/ltp-=
timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/riscv/defconfig/gcc-10/lab-broonie/ltp-=
timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/655b3a1551d2ccf8c17=
e4a84
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e) =

 =



platform                     | arch  | lab           | compiler | defconfig=
 | regressions
-----------------------------+-------+---------------+----------+----------=
-+------------
qemu_smp8_riscv64            | riscv | lab-broonie   | gcc-10   | defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/655b39e443b0ebcb347e4a7d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/riscv/defconfig/gcc-10/lab-broonie/ltp-=
timers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/riscv/defconfig/gcc-10/lab-broonie/ltp-=
timers-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/655b39e443b0ebcb347=
e4a7e
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e) =

 =



platform                     | arch  | lab           | compiler | defconfig=
 | regressions
-----------------------------+-------+---------------+----------+----------=
-+------------
qemu_smp8_riscv64            | riscv | lab-collabora | gcc-10   | defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/655b3766a70abf27f87e4a6f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/riscv/defconfig/gcc-10/lab-collabora/lt=
p-timers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/riscv/defconfig/gcc-10/lab-collabora/lt=
p-timers-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/655b3766a70abf27f87=
e4a70
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e) =

 =20

