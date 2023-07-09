Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B7FEB64DC
	for <webhook@archiver.kernel.org>; Sun,  9 Jul 2023 13:17:33 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web11.16965.1688908647644640680
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 09 Jul 2023 06:17:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=O5uijIp4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-666e97fcc60so2298234b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 09 Jul 2023 06:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688908647; x=1691500647;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QQ+y7w8Fvbjr+TpBsUgPe2qGAWxO6QwuxpiWdBDZnzY=;
        b=O5uijIp42xPmJQu015IOBBTXFf8VdRvqUwKkMrs31I+3wq6qMWD9CVjCQl+RcesS7d
         lCes4QG0lEijwBjIpwEARjqTZ9cdcxhZLxbTimleA6Qv1uRARK6jcDab9eQI2ojcQ9cQ
         ldEXJvRrZoH+6irW9HzO6CqZSvN0YjylEsZ5P07yF9iKvCu3VlJf1gXiso15YsFKsNSk
         XQ0BfZaXb4ZUerSA9c1ls4sW25D3RS0sLaNYvc5lzGEcHIhIOqMKgsxvmzi2G6duhr+S
         T+D6nEdZvHwn7SFig5utpgKv9KbtB3DcIVTr+SYaCt/xZWVtaiW0nqdyBPR3L+MpjL8v
         +C7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688908647; x=1691500647;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQ+y7w8Fvbjr+TpBsUgPe2qGAWxO6QwuxpiWdBDZnzY=;
        b=VFXuCX0e7vR1J715N7mJYTOKSV25RPqJmPjFhwCAc2cuLq2BUm8Tyd3xnQCaDvMdMr
         MHmf8FUpUafoXZ95OxOaBROCRonU3h9ZwbZCms4p/FK/nX8s8GZGQXDu4VUtTcsazGEv
         JyHiad4zMyQRTJsPtLhSJFBHdxjiDAPEbCJYi/2VHKtHFm829lKliVDcG5aKILtUOy9O
         QUfpq4ZPcDox2lKLDhuIw9+Ch/NfZpyRtKUDeD34+3xLJ7IDiKDY40/svKg80Tm0PYXo
         v0KCZ1XzuSc91Mx85nXH/f22e8tAEpHT0n7/bDCn1sg/w4mRV/zDJqzQ2/DDEAUpfl1j
         zwmA==
X-Gm-Message-State: ABy/qLZ4BkKhQeHPULLgY/dWrUeINctbJshZE9FhnMT/0m2oy+LVYD6E
	9qSzCcReWpPwmWpoPCa9tBF0Xl+XjhxU4rhsY1Y=
X-Google-Smtp-Source: APBJJlFiKpJ3tEKg/uy97he3Ol5i1jwO1CJCbs1w0wE1dn1ZASxkmbZKYDR1TLU88LUa+SYvCPMTQA==
X-Received: by 2002:a17:902:d4c3:b0:1b8:1c9e:4453 with SMTP id o3-20020a170902d4c300b001b81c9e4453mr10354610plg.4.1688908646747;
        Sun, 09 Jul 2023 06:17:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902f7c700b001ac444fd07fsm6302462plw.100.2023.07.09.06.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 06:17:26 -0700 (PDT)
Message-ID: <64aab366.170a0220.692ef.bbac@mx.google.com>
Date: Sun, 09 Jul 2023 06:17:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.31-65-ge66be31505fa
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y-cip
Subject: cip/linux-6.1.y-cip ltp-timers: 6 runs,
 4 regressions (v6.1.31-65-ge66be31505fa)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 09 Jul 2023 13:17:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12282

cip/linux-6.1.y-cip ltp-timers: 6 runs, 4 regressions (v6.1.31-65-ge66be315=
05fa)

Regressions Summary
-------------------

platform     | arch  | lab           | compiler | defconfig | regressions
-------------+-------+---------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 2          =

qemu_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.31-65-ge66be31505fa/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.31-65-ge66be31505fa
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e66be31505fad0a8b90cd493f9b42353590498f1

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform     | arch  | lab           | compiler | defconfig | regressions
-------------+-------+---------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64aaaa77228e285bc0bb2bc0

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-65=
-ge66be31505fa/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_riscv64.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-65=
-ge66be31505fa/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_riscv64.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64aaaa77228=
e285bc0bb2bc5
        failing since 3 days (last pass: v6.1.31-53-g486caac40d06, first fa=
il: v6.1.31-64-g93fc2d0f5008) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64aaaa77228=
e285bc0bb2bc5
        failing since 3 days (last pass: v6.1.31-53-g486caac40d06, first fa=
il: v6.1.31-64-g93fc2d0f5008) =

 =



platform     | arch  | lab           | compiler | defconfig | regressions
-------------+-------+---------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64aaa6a4dd691c4985bb2aa5

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-65=
-ge66be31505fa/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu_riscv64=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-65=
-ge66be31505fa/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu_riscv64=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64aaa6a4dd6=
91c4985bb2aaa
        failing since 3 days (last pass: v6.1.31-53-g486caac40d06, first fa=
il: v6.1.31-64-g93fc2d0f5008)

    2023-07-09T12:22:39.320158  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64aaa6a4dd6=
91c4985bb2aaa
        failing since 3 days (last pass: v6.1.31-53-g486caac40d06, first fa=
il: v6.1.31-64-g93fc2d0f5008)

    2023-07-09T12:22:39.320158  =

   =

 =20

