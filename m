Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAEDC83F01
	for <webhook@archiver.kernel.org>; Sat, 26 Aug 2023 17:26:27 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.12788.1693070778929293012
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 26 Aug 2023 10:26:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=kAzhSO/F;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1bdc19b782aso13893895ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 26 Aug 2023 10:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693070778; x=1693675578;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3CHvuzdBr42oEfzXW0MTEhJZMMBK7umH0ZodKBxhDkM=;
        b=kAzhSO/FxZKtuvR8jXSjw7R11WFxpWHLWr1Qt9AsXyImQoHnTxn9+1NbqeRm8jHk5s
         d1qKoPBkmbceLafmn3o9uwhbh7CpG7KXr8X/qgS9XGCOxGDCCjHgDYR/gd5gDhS+/k6B
         nCNjmIWNjuHG/dub8+OiphwwFfkckD6F40Cge0+xhPerSyu37Rr0DpyxVZD7H1zBzux6
         rx0vxGmPlLiAeK9yYtH7F/oUsPd6z+zKkF3Skaf20MSvHLS+uSJI566lBa552TuLJbBf
         sC16DPGMBVFN6g53eCYaW3ygkcU7JpKV67Uq8Jdwq+Dfg2xlm6FEJA+8XSagFak2T5eJ
         NfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693070778; x=1693675578;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3CHvuzdBr42oEfzXW0MTEhJZMMBK7umH0ZodKBxhDkM=;
        b=hn8N5mOXe5nMSwLyUy/L8tr3U+u7cDzqgwYC7OSKRPM87/IN0BmmQ0hFsmfsETGEqk
         d7guPd8KRaqFgCWiyjQt2l6/xj+HG1kpmQMe2VVbsew9WdvdSv3ZMeGuW5KxmWD15w61
         FyF3WEMW3mucs5LcHqcmvYkLUplynDmFvhYdSJcn4HQtQRHuXaGmkJHpGxP6YtS1eGRx
         EWwp2dsxL2RyOXMrc8T0QVaZXnEcS/1PITBF3Q0XLy1KyBz6TnKP5Qgjrj71Og5ot5Be
         p+dCPQwZU2z5Z6dl/n4OzEu/YQu2zjWXZoi9DwBK/+w/fVCJYNhLqGKz6c/XAFaXhF2H
         dw5w==
X-Gm-Message-State: AOJu0YxmH3SKiprgKfBzu0T7/VTyXXdDXbXz6lFC8HNJdjSp4XjENE2d
	IIPJVMoLgtWnjLyPZsb74yP2HfsYYuQBucysUrE=
X-Google-Smtp-Source: AGHT+IFRaOLBfRtZ27dPLdao/2To+4mC9lZ8RDM0ZAy0H6EVOeGLKzk+rPb0m9ezrhLinjDcq+nSjw==
X-Received: by 2002:a17:903:24f:b0:1b8:a3a0:d9b3 with SMTP id j15-20020a170903024f00b001b8a3a0d9b3mr18917415plh.47.1693070777875;
        Sat, 26 Aug 2023 10:26:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902694100b001bdc6e13665sm3924308plt.275.2023.08.26.10.26.15
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 10:26:16 -0700 (PDT)
Message-ID: <64ea35b8.170a0220.8869c.656c@mx.google.com>
Date: Sat, 26 Aug 2023 10:26:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-982-g80a0585c0aa62
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 8 runs,
 3 regressions (v5.10.186-cip37-982-g80a0585c0aa62)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 26 Aug 2023 17:26:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12855

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 8 runs, 3 regression=
s (v5.10.186-cip37-982-g80a0585c0aa62)

Regressions Summary
-------------------

platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_riscv64      | riscv | lab-broonie | gcc-10   | defconfig | 2          =

qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.186-cip37-982-g80a0585c0aa62/plan/ltp-tim=
ers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.186-cip37-982-g80a0585c0aa62
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      80a0585c0aa62f4c1dd47f7b489c39ee5bba99ab

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_riscv64      | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64ea280db89f0d2508286d7e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64ea280db89=
f0d2508286d83
        new failure (last pass: v5.10.186-cip37-770-gddd36cfc4c4c8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64ea280db89=
f0d2508286d83
        new failure (last pass: v5.10.186-cip37-770-gddd36cfc4c4c8) =

 =



platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea2af178dadca871286d6e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/64ea2af178dadca8712=
86d6f
        new failure (last pass: v5.10.186-cip37-770-gddd36cfc4c4c8) =

 =20

