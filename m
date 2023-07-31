Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FD2EB64DD
	for <webhook@archiver.kernel.org>; Mon, 31 Jul 2023 01:15:23 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web10.85279.1690766113927876713
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 30 Jul 2023 18:15:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=MFjHqX5n;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-686fa3fc860so2392595b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 30 Jul 2023 18:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690766113; x=1691370913;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7GZ7m9958jRBgFtUufRgCrjAc98W2yiXDl87CmFtcwA=;
        b=MFjHqX5n+FTwcjmKe1a+i2up8fAtRJ7MGh2Ls0iRBGVWaSc8K3Pad7XZu2MZyoVIph
         fac1nfY6iyACYJRjqgKQ4TrrV706N0eEqDu9X9ww4i1kjTqkZzBEJEqvKq3audlONVzo
         P+Lorge7AFsgD3ca4Er0932SpoC0FLq729BvhBLlsuw/tqxFlUGmLm2u4UZ5pOzkAz68
         Cjw6LsBxTHzLDtg3hCQ6BJULIPCzAx1EXxQrOa/k60o/hEW2IwIyULKxenlQW0Mc2u3a
         Y4wPfrF0vmawiUmu7bHYgHqtQTkwZV5UiDeTiqUxGJWJO6dyrVwSgtVFBYgiX/r5btRw
         ggsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690766113; x=1691370913;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7GZ7m9958jRBgFtUufRgCrjAc98W2yiXDl87CmFtcwA=;
        b=gkqdECTbnELcXGjlUPBs7NYqzWIKZwmJi01BynauootEINx0KLEtW3BWe/jNqmOR9H
         MCtEfbIWrhMKppfgw3LrXG0GaxRwzrN4KQymzDp+vVl5PJppCYLjV0fYloI30MH0ggbD
         HPpuNil+Fo7bizpJUfut34yr/4Nr4HzTyn14VoJz0No36zA7eQ5pZ9yZoRtz66TjRp8i
         8SUkszjct6e495GJEavwPK2TaSl1fJezGCwRLqcr6mS1E0paNPQ0+M6IImRPKLjoGAIZ
         REnfS0ozqtKSsY6i49wHW1q23MnjbIXYu8r4u3ZDHHlYQO1BMX2UAp17ssk1ypVSkNRP
         LpzQ==
X-Gm-Message-State: ABy/qLbteqsRTeZPFjKutJO2xhVSMDlDWDYkMkVMk7lWPmHmoi52fJiB
	ewfmrXDW8yV98Dx8ufm2IHn8m/s3EwOiUnvV+rIzvw==
X-Google-Smtp-Source: APBJJlGtNX54MBmk/wsqgE9TWu3mg2QzOwU18nh/wkTNZGpIw3PoEIQsEd4Jelq8fRpklmqR7v0T0Q==
X-Received: by 2002:a17:903:228a:b0:1b5:561a:5ca9 with SMTP id b10-20020a170903228a00b001b5561a5ca9mr9644958plh.50.1690766112933;
        Sun, 30 Jul 2023 18:15:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902ea1000b001b80de83b10sm7182600plg.301.2023.07.30.18.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 18:15:11 -0700 (PDT)
Message-ID: <64c70b1f.170a0220.e3234.d409@mx.google.com>
Date: Sun, 30 Jul 2023 18:15:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Kernel: v6.1.42-cip2
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip ltp-timers: 8 runs, 6 regressions (v6.1.42-cip2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Jul 2023 01:15:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12528

cip/linux-6.1.y-cip ltp-timers: 8 runs, 6 regressions (v6.1.42-cip2)

Regressions Summary
-------------------

platform     | arch   | lab           | compiler | defconfig               =
     | regressions
-------------+--------+---------------+----------+-------------------------=
-----+------------
qemu_riscv64 | riscv  | lab-broonie   | gcc-10   | defconfig               =
     | 2          =

qemu_riscv64 | riscv  | lab-collabora | gcc-10   | defconfig               =
     | 2          =

qemu_x86_64  | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-chrome=
book | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.42-cip2/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.42-cip2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0d2ec524c820bab8eabc0f1b34aa41ff55d4e9b1

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform     | arch   | lab           | compiler | defconfig               =
     | regressions
-------------+--------+---------------+----------+-------------------------=
-----+------------
qemu_riscv64 | riscv  | lab-broonie   | gcc-10   | defconfig               =
     | 2          =


  Details:     https://kernelci.org/test/plan/id/64c6fa91c7fe008e2f8ace1e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.42-ci=
p2/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.42-ci=
p2/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64c6fa91c7f=
e008e2f8ace23
        failing since 24 days (last pass: v6.1.31-53-g486caac40d06, first f=
ail: v6.1.31-64-g93fc2d0f5008) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64c6fa91c7f=
e008e2f8ace23
        failing since 24 days (last pass: v6.1.31-53-g486caac40d06, first f=
ail: v6.1.31-64-g93fc2d0f5008) =

 =



platform     | arch   | lab           | compiler | defconfig               =
     | regressions
-------------+--------+---------------+----------+-------------------------=
-----+------------
qemu_riscv64 | riscv  | lab-collabora | gcc-10   | defconfig               =
     | 2          =


  Details:     https://kernelci.org/test/plan/id/64c6f907766750cc4a8ace1c

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.42-ci=
p2/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.42-ci=
p2/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64c6f907766=
750cc4a8ace21
        failing since 24 days (last pass: v6.1.31-53-g486caac40d06, first f=
ail: v6.1.31-64-g93fc2d0f5008)

    2023-07-30T23:57:50.884118  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64c6f907766=
750cc4a8ace21
        failing since 24 days (last pass: v6.1.31-53-g486caac40d06, first f=
ail: v6.1.31-64-g93fc2d0f5008)

    2023-07-30T23:57:50.884118  =

   =

 =



platform     | arch   | lab           | compiler | defconfig               =
     | regressions
-------------+--------+---------------+----------+-------------------------=
-----+------------
qemu_x86_64  | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-chrome=
book | 2          =


  Details:     https://kernelci.org/test/plan/id/64c6f53260d198f30c8ace1e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.42-ci=
p2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-timers-q=
emu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.42-ci=
p2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-timers-q=
emu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64c6f53260d=
198f30c8ace23
        new failure (last pass: v6.1.38-cip1-7-g5cff59cac977b)

    2023-07-30T23:41:33.108120  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64c6f53260d=
198f30c8ace23
        new failure (last pass: v6.1.38-cip1-7-g5cff59cac977b)

    2023-07-30T23:41:33.108120  =

   =

 =20

