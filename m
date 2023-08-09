Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFC7EB64DD
	for <webhook@archiver.kernel.org>; Wed,  9 Aug 2023 06:10:34 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
 by mx.groups.io with SMTP id smtpd.web11.82504.1691561426055914235
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 08 Aug 2023 23:10:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=PTMrdM3O;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.128.177, mailfrom: bot@kernelci.org)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-58969d4f1b6so23729857b3.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 08 Aug 2023 23:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691561425; x=1692166225;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sZw+/nq9DgkyBr/8bmF2DWUPG55f+2GZOm+6Naj8Ja0=;
        b=PTMrdM3O1rDZcyGoHBVwU1ld69mZc0RzHckAEwQKd8YXy9GNRIwnjRgE8fyy6Df4mQ
         a3GU3B3LT0t3w9BXHiHJQb56ug0bNvevA3SaAN0TpTUvfb1nS2DegV3xy9lUmBCsH+U9
         w6eLAQZ7ZXTgINFuhA7vUfVmgfwMAJDpqaoU2tdP8K6q9bundyaSYy4fmR+4JF5Cy1Hy
         qwObhHBKSkIB15NvjWFVNnWTGwj6IsQiIK1AReqHswkaJKIcTffYzVzTDbYI5AIV1trB
         EmwDBPnmeYqG25pPU27v1AH8R03sNn9HCjbnWpBp1k3uLwJ3fpzTDHAlzXxTR8H3ej4a
         9B4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691561425; x=1692166225;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZw+/nq9DgkyBr/8bmF2DWUPG55f+2GZOm+6Naj8Ja0=;
        b=JLirvwvpPs0uDTT0KW1IFWFvipJUhmrgriA/w1vnsM+x/VtnMtjga7aX0zaNa39YXJ
         V5vsAagFwtl4ZxCYA743eRk40YtPB3QhnOl1rGrtqKLUzkaVBg6NuEwViq0U05eNFpsL
         GZmCrPT8Nvygopw/zNCixG1wckDe7rb7PuHCDC9XnoKzDrEFnwY0aNCXHTRXUmBVZwlB
         w1sTj/9ZADL+Ft8A3JOqzK7vHISgBrbLsAZ//MIKruAUiRR2/oDTCHbaZUwlBKAVGFDj
         +CHkTT7msZ4XJgch02sng6Ldvhfx40bDZLIdj9WFeocgcuWvWaxf/mjDOP2ZEgLD8cvG
         7rpg==
X-Gm-Message-State: AOJu0YwALcMb5dQ95DsPKrZxX6s5RQD6Njg5BRX8GtZZ9v3/AnbXY84m
	T59P+14gBACnoUiTUE3ALc0cUesEhNK34XUs10rUuQ==
X-Google-Smtp-Source: AGHT+IH39vfjfdgwoS7ivu/j3+CpM2QixjCAf852Nj89P10q0Qq4agQHN+2Ne/LzHX6ZQU/WoM+FSA==
X-Received: by 2002:a0d:d894:0:b0:56d:9e2:7d9e with SMTP id a142-20020a0dd894000000b0056d09e27d9emr1773066ywe.21.1691561424954;
        Tue, 08 Aug 2023 23:10:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jw14-20020a170903278e00b001bc87e6e26bsm2432530plb.222.2023.08.08.23.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 23:10:23 -0700 (PDT)
Message-ID: <64d32dcf.170a0220.96846.4d5b@mx.google.com>
Date: Tue, 08 Aug 2023 23:10:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-13-g260094841fe1a
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip ltp-timers: 8 runs,
 3 regressions (v5.10.186-cip37-13-g260094841fe1a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Aug 2023 06:10:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12583

cip/linux-5.10.y-cip ltp-timers: 8 runs, 3 regressions (v5.10.186-cip37-13-=
g260094841fe1a)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 2       =
   =

qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.186-cip37-13-g260094841fe1a/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.186-cip37-13-g260094841fe1a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      260094841fe1a0a9e5ab7b9ae32450e8e4e0a4f4

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


  Details:     https://kernelci.org/test/plan/id/64d32107446054cfe635b1f6

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu=
_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu=
_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64d32107446=
054cfe635b1fb
        failing since 19 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-11-g2b3c22dc0633) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64d32107446=
054cfe635b1fb
        failing since 19 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-11-g2b3c22dc0633) =

 =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/64d31fc33206e5512635b1e8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qe=
mu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-13-g260094841fe1a/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qe=
mu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/64d31fc33206e551263=
5b1e9
        new failure (last pass: v5.10.186-cip37-12-g2710acbceb751) =

 =20

