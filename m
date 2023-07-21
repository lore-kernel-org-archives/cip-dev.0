Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87B9EB64DD
	for <webhook@archiver.kernel.org>; Fri, 21 Jul 2023 03:35:58 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web10.241.1689910553573695169
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Jul 2023 20:35:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=XwzrXSng;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-668704a5b5bso1325391b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Jul 2023 20:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689910552; x=1690515352;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rYAeOfxHdBCNcnMfPnzQsyVeY0su+Qv8zrZoTltfMWM=;
        b=XwzrXSngLTzeuL+J85FdMnwX6bIdI5M7TkUQaJxN8TYRos+ZczKQhEUad7syhN8BnR
         S0P6BldT/Ve0WeLUmiKCJvrxMbIuThbFOonxxTRJIRt3wmcOIlC9INHO8LGfi4vR5Ma6
         LCYC4BtFQ6mjVP66TS6XePRDHWVBkiqqhWD/lD3RrB9U/2DeZNZ1uzEyS3nn/yLVJB+X
         mUZxv+mLv+Goqw/i03rj8s8BMJsRn6ZktDzCmIEKzYQTubA40plW5u8tVA9tV5Yyu4xg
         fx1xWiaiX0O1CpFhhMcUp4Eg5l6McWRnuqu9bswd0VlEwPRVPZk985iU+YmcOQwxbEV7
         5dCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689910552; x=1690515352;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYAeOfxHdBCNcnMfPnzQsyVeY0su+Qv8zrZoTltfMWM=;
        b=GU+2zsUp1fcW0juyuhf+l2Fki6PKYMArwbVMlQ5OwVAlhClnrAIk87V+oeX3LEiCbL
         dBMBTXgCi49C0m/2ceD5sntD3HYkFUDBI1Z0RoELx+ME92vobinZM8WGW8CrWV09X2vL
         2X46Eg8xvRtNMN+b3EZTy87+gQkvANv1gUKQpSA7DYR7G1g/z7cg42pO78p/EhB82gC/
         BBqUPjHZ5+MMgxJ/BKtmfg6o4w8oziNNkdHs1E+CHidIha8b++8ry7tJFKAoHf8CdC24
         mr5oPMmHGHBcG4xZsFAh/1khtigvuUPoDr2Lv6nEsOePzq3YtgrBwIsvEw1EwdnRiItz
         ib1w==
X-Gm-Message-State: ABy/qLYhq8SKe6garzCuafojt8L6VXgFO4xJWzqc3zrantcGaVoAooEQ
	jb71zAbeMvPyIKGTPojyy9RpX6IZ4Gvqq7ky6JsMEg==
X-Google-Smtp-Source: APBJJlHnIhE51LlmfTty+sWw1cJVcvQjUe+wnsVrxGEFGHRIK4VxICgYUPGOjs9GfIJHbTVkbdx4Sg==
X-Received: by 2002:a05:6a00:811:b0:67b:f249:35e2 with SMTP id m17-20020a056a00081100b0067bf24935e2mr998024pfk.21.1689910552307;
        Thu, 20 Jul 2023 20:35:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k9-20020a633d09000000b0054fd46531a1sm2065794pga.5.2023.07.20.20.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 20:35:51 -0700 (PDT)
Message-ID: <64b9fd17.630a0220.ec555.476c@mx.google.com>
Date: Thu, 20 Jul 2023 20:35:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.186-cip37-11-g2b3c22dc0633
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-timers: 4 runs,
 4 regressions (v5.10.186-cip37-11-g2b3c22dc0633)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Jul 2023 03:35:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12492

cip/linux-5.10.y-cip ltp-timers: 4 runs, 4 regressions (v5.10.186-cip37-11-=
g2b3c22dc0633)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 2       =
   =

qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 2       =
   =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.186-cip37-11-g2b3c22dc0633/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.186-cip37-11-g2b3c22dc0633
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2b3c22dc06337fb4c486cdf00b4182c35f61bb58

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
qemu_smp8_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 2       =
   =


  Details:     https://kernelci.org/test/plan/id/64b9ebd63bceead4b28ace27

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-11-g2b3c22dc0633/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_=
smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-11-g2b3c22dc0633/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_=
smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b9ebd63bc=
eead4b28ace2c
        new failure (last pass: v5.10.184-cip36-13-g8fae18103387) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b9ebd63bc=
eead4b28ace2c
        new failure (last pass: v5.10.184-cip36-13-g8fae18103387) =

 =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 2       =
   =


  Details:     https://kernelci.org/test/plan/id/64b9e9ea09a1b08f468ace36

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-11-g2b3c22dc0633/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qem=
u_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-11-g2b3c22dc0633/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qem=
u_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b9e9ea09a=
1b08f468ace3b
        new failure (last pass: v5.10.184-cip36-13-g8fae18103387)

    2023-07-21T02:13:50.165507  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b9e9ea09a=
1b08f468ace3b
        new failure (last pass: v5.10.184-cip36-13-g8fae18103387)

    2023-07-21T02:13:50.165507  =

   =

 =20

