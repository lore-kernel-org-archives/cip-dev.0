Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F95C77B73
	for <webhook@archiver.kernel.org>; Sun, 21 May 2023 10:25:24 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.5484.1684664723240875081
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 21 May 2023 03:25:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Sk4eoorr;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ae3ed1b0d6so34206915ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 21 May 2023 03:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684664722; x=1687256722;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=27BUyTPaG7p4GqAAOd7bkRH7le1Do7ExYgip2aQq8l0=;
        b=Sk4eoorr9JqZF0d6csfMfDCSVP0iy5PRLPraL7Xsba0DxAdxaVfJmI6ra0t0gYtzrr
         u/GU+ZRCGCfoJYhrzLmPrkhwfKyxT39f/2ffJ/HpCuhAFUNCq/UaENNZfaYpRLGkj2PC
         W3qDs4Onqn8jS1ahnj6miZSepmKj7MauUVvRZmND8HQzKsAIh+ZKQmnauf/d5XlkrLVC
         0MCGTCpcqrGaDTh7WWUA8hjpuTYturltEYi6XVEw8Mcz2ut3V6misUI5BKsCbvR/lx7T
         sxXs7lWNHUjRQ0R2yao+/cAvHSz+rakeWAI1HfYRb0qUvjwtk/y9aHxLeyrX2/fgiyRm
         YBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684664722; x=1687256722;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27BUyTPaG7p4GqAAOd7bkRH7le1Do7ExYgip2aQq8l0=;
        b=Wbrd6CWrrlGIg2OtzdOvfGuMNpT1PmWjPjQUzZBOc9dsmt732Oll7pTgVpSW1a76HC
         KM7kylb9llajOExn1kbmC0nTiS3VMrFOteE2moB/qkZjorFsfDqQRQ0oPArYHpUHA0v6
         sW9nQP1U9PO2p1vpEIL2/6huuq9Ulp5NHHAtcdfunRrKpDzAj+WIWuCUMQ/OlwfUrL++
         xnN9NapwM4xRuYV9dqEZvaziFfXeWT/UAP4AYPnT/8knTWyGVDeOpcVU/kuuxBdQH8iZ
         6Vp/DubzHuOVDZGjwWuOzFxiIQZNSwCaVttKELRVi40f6x7/S+Si2cSQ9/4wjeHe/8Wc
         HPNw==
X-Gm-Message-State: AC+VfDxheAhb4wb1RRME5kJQcAB7ShISqY+LmFSMMCkRMyotMJlyRYN1
	ENvNjBdbCBUxHF6bjyNYroyne4BqtEjxQYlVBcQbAg==
X-Google-Smtp-Source: ACHHUZ6HbcLxOq0VNNZxuw9b5YADVW9H/I0P2CQfZ8OLXyyEICyPBX/0RDup5MBLC//2pWbX71Z0+g==
X-Received: by 2002:a17:902:f681:b0:1ad:e8f5:7c7b with SMTP id l1-20020a170902f68100b001ade8f57c7bmr9534967plg.62.1684664721726;
        Sun, 21 May 2023 03:25:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z2-20020a1709028f8200b001ab0159b9edsm2706336plo.250.2023.05.21.03.25.20
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 03:25:21 -0700 (PDT)
Message-ID: <6469f191.170a0220.35a60.3f7a@mx.google.com>
Date: Sun, 21 May 2023 03:25:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.180-cip33-11-gfea7994097935
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 16 runs,
 6 regressions (v5.10.180-cip33-11-gfea7994097935)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 21 May 2023 10:25:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11577

cip-gitlab/ci/pavel/linux-test ltp-timers: 16 runs, 6 regressions (v5.10.18=
0-cip33-11-gfea7994097935)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
qemu_riscv64     | riscv | lab-broonie   | gcc-10   | defconfig            =
      | 2          =

qemu_riscv64     | riscv | lab-collabora | gcc-10   | defconfig            =
      | 2          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.180-cip33-11-gfea7994097935/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.180-cip33-11-gfea7994097935
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      fea799409793527f9b9b2d2c53f0dc4e3ac7ac6a

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
qemu_riscv64     | riscv | lab-broonie   | gcc-10   | defconfig            =
      | 2          =


  Details:     https://kernelci.org/test/plan/id/6469dfd57d02af4a052e85ec

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/riscv/defconfig/gcc-10/lab-broonie/ltp-t=
imers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/riscv/defconfig/gcc-10/lab-broonie/ltp-t=
imers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30512.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6469dfd57d0=
2af4a052e85f1
        failing since 59 days (last pass: v5.10.167-cip26-2-g28bb49f7179b, =
first fail: v5.10.175-cip29-rt12) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6469dfd57d0=
2af4a052e85f1
        failing since 59 days (last pass: v5.10.167-cip26-2-g28bb49f7179b, =
first fail: v5.10.175-cip29-rt12) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
qemu_riscv64     | riscv | lab-collabora | gcc-10   | defconfig            =
      | 2          =


  Details:     https://kernelci.org/test/plan/id/6469de1d222d075e0c2e85fa

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/riscv/defconfig/gcc-10/lab-collabora/ltp=
-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/riscv/defconfig/gcc-10/lab-collabora/ltp=
-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30512.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6469de1d222=
d075e0c2e85ff
        failing since 59 days (last pass: v5.10.167-cip26-2-g28bb49f7179b, =
first fail: v5.10.175-cip29-rt12)

    2023-05-21T09:02:09.831082  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6469de1d222=
d075e0c2e85ff
        failing since 59 days (last pass: v5.10.167-cip26-2-g28bb49f7179b, =
first fail: v5.10.175-cip29-rt12)

    2023-05-21T09:02:09.831082  =

   =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6469ebd9bb3720e17f2e85eb

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6469ebd9bb3=
720e17f2e85f0
        failing since 193 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3=
b, first fail: v5.10.147-cip18-15-gef247a3cd0ad) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6469ebd9bb3=
720e17f2e85f0
        failing since 193 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3=
b, first fail: v5.10.147-cip18-15-gef247a3cd0ad) =

 =20

