Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8908FC001DE
	for <webhook@archiver.kernel.org>; Wed,  9 Aug 2023 01:05:03 +0000 (UTC)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
 by mx.groups.io with SMTP id smtpd.web10.78575.1691543094133622552
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 08 Aug 2023 18:04:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=iU6EQI75;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.45, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-565f2567422so4302878eaf.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 08 Aug 2023 18:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691543093; x=1692147893;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4FDBcSXpNNPIGEmQLmlVdENE+jBhFv0f9pwiugfVegs=;
        b=iU6EQI75wvG/5eX8QDcSmCYy9bXxLd25jDGhO/jj1o7aujkN26uKvWxBwLaEdMwpyB
         AZlQ3gTmqXS9pbblpsMnxt6Rxwaa+km4Rv6bh2Jdw8lN9tvDf9p5Q7NfYZ6/BeemHjqe
         JRNEDNtxS3IXJ10Pm6cuaWWVYoPrv98eE6TdfGTtUDOC/PoMNCU4VT17U+SrSUz+fLDJ
         OE3doynvhoFXOhezbkKfxeTmwZ+Jg6nczPvkbgwCfLo1mh9mCpmUv4bE+vksy5sszibZ
         N1UfRvD6t2nkDJwfw0x2MHJ0H5xikO85yzymOsUfGcUWZnWeE37uP20eaUIVBRayXqpk
         8jEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691543093; x=1692147893;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FDBcSXpNNPIGEmQLmlVdENE+jBhFv0f9pwiugfVegs=;
        b=AUrEzGgp8jez3/7wfwgRmqRZo/7fc1Xx5Krmz9ZUt4J+thUySxoF1u3UpzVzTSJAzX
         4+Ehr5WIP8W4OKhS1yYqjVys3H+sRlpSWOrRT9w7Ex5auDYwZ6aFw2U5gTZguUV8Zbd9
         dopcI7QpimzH4ior/ihp/ZoeUoL1zJrc0nOkUozCyYHLKvli7mOEIvYUo6WqpWL+qoEj
         XfBYm+L0UVHas/49I3McEuUcfR5viGNxqhdv8N5eZW8teEQhdcJhUttu4V4slvlU2LMW
         vpuJ4DMaiPAzee3YubhD0MSUwz4SirZxPZnzPAEBSRdDb/Kb3MGpPx2x5WmYTjs7h3x3
         tgwA==
X-Gm-Message-State: AOJu0YwdpV5C8MRVlN0BtmnwTzRSxFnVoFABumjNDxDJkj5vIpSSa/Cj
	EN5B/8gEcxpaGVANgMZGHfuie7H0TR+7pidpq+WGyg==
X-Google-Smtp-Source: AGHT+IHuiWOZ2qfZ8OsjvCm3dP9VbE4mX6+6jNgmLNFxhkWq9awMTml7Grf3lQcxFnp6Kaf/JKBuWA==
X-Received: by 2002:aca:f18:0:b0:3a3:b39d:a8bf with SMTP id 24-20020aca0f18000000b003a3b39da8bfmr1468471oip.45.1691543092871;
        Tue, 08 Aug 2023 18:04:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090a64ca00b00263dee538b1sm158699pjm.25.2023.08.08.18.04.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 18:04:52 -0700 (PDT)
Message-ID: <64d2e634.170a0220.62cfa.05d3@mx.google.com>
Date: Tue, 08 Aug 2023 18:04:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-566-g36076316ef049
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 6 runs,
 4 regressions (v5.10.186-cip37-566-g36076316ef049)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Aug 2023 01:05:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12571

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 6 runs, 4 regression=
s (v5.10.186-cip37-566-g36076316ef049)

Regressions Summary
-------------------

platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_riscv64      | riscv | lab-broonie | gcc-10   | defconfig | 2          =

qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.186-cip37-566-g36076316ef049/plan/ltp-tim=
ers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.186-cip37-566-g36076316ef049
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      36076316ef0496f258d98ea65b29aa2c5b0bc603

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_riscv64      | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64d2de45a8f153c2f135b22d

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64d2de45a8f=
153c2f135b23e
        failing since 55 days (last pass: v5.10.180-cip34-236-g6d219c607dc6=
8, first fail: v5.10.182-cip35-8-gc3d08808cfa7) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64d2de45a8f=
153c2f135b23e
        failing since 55 days (last pass: v5.10.180-cip34-236-g6d219c607dc6=
8, first fail: v5.10.182-cip35-8-gc3d08808cfa7) =

 =



platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64d2de9522fa0afabc35b1ec

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64d2de9522f=
a0afabc35b1f1
        new failure (last pass: v5.10.186-cip37-526-g7640d76efb649) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64d2de9522f=
a0afabc35b1f1
        new failure (last pass: v5.10.186-cip37-526-g7640d76efb649) =

 =20

