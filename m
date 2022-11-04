Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D639C4332F
	for <webhook@archiver.kernel.org>; Fri,  4 Nov 2022 08:53:49 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web12.8886.1667552024224491564
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 04 Nov 2022 01:53:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=eBPu51vQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so4064773pjd.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 04 Nov 2022 01:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yrIEdaw/Ljhpf7GK6Iq0+iCvtTljbSEaHQB0ENJXEck=;
        b=eBPu51vQnUvrQgoHdgUZnBwnTsh9OuwAR8bLoljnOMSJ1kXUqOFRK0/6dHelhlUz3h
         mP4qxqnaYwj7iRhI4BA+1jxV3HHKtowD8dF8feezaEAWIot+aM6gI59ObSiCH9tfz2xE
         GwQqBD7QIKgpYH7ZsZBS39v7G1FmYuYWeJtjg4y8RVTEItJsGHdyFymskAaHEBhD/0EZ
         B+H2FpPnwo/8kdpR5Qtjp1qJNBSWtDY7NNV9JzWeMPdhn3vsPATRj/tzG/YIV9bAyO0M
         c2y+U5jZwGjsGi/bGRWMHQaSfD6l5c1BXHH7DS/41ARvNjVb4i7qccRAjbqwxsghRya9
         iYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yrIEdaw/Ljhpf7GK6Iq0+iCvtTljbSEaHQB0ENJXEck=;
        b=ijr1OIIpkY7uipYs9QdgLTmvqVIqNah2D8D4yUtvWbFei6FJrbmr+dNWr0qIt0dEyZ
         JJ2T4qi3JTnkmPNQVlt6M2PWdtbKWoRMNJQ9d6nlMwNK0Qbk8zai0E+bq9TBtF7ZcGIU
         pBeWnmDTeqzc3ynpSVPk4rd/0/4i6r2DDP+nxT2zg6Em3JfLx8EDrV16ZXZIrcCnn8BF
         VowIBD4jDRarUja9/89d87X7RTPhuGxIJPuw+J1leX6FL1t7Kj63vAYXM07mVwWfcsuD
         CKE70TLaauX4N5D8TLSLOuJ4PPFiQjazVyQtO3nt5lAH/v1kwJkyRgKTXfsGULkpteOx
         OS3Q==
X-Gm-Message-State: ACrzQf3GZWStccSzET/YAVVpPFRxT+EleGFfTKfhumXK7lZLXNKI9tGV
	fBP4eKAFUSrhkxwLNXHafzTzaPtAXLhJcA==
X-Google-Smtp-Source: AMsMyM6Fc8eBD3KAGJQa0fktPncXxQYq39qFl3ccmkxIGtkpchZHMU0+NMHvhcjhcMq2kt/X5ZVfUA==
X-Received: by 2002:a17:902:d489:b0:187:2b1d:1101 with SMTP id c9-20020a170902d48900b001872b1d1101mr22432150plg.158.1667552023636;
        Fri, 04 Nov 2022 01:53:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h2-20020a056a00000200b00562cfc80864sm2175692pfk.36.2022.11.04.01.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 01:53:43 -0700 (PDT)
Message-ID: <6364d317.050a0220.25f7c.3ea2@mx.google.com>
Date: Fri, 04 Nov 2022 01:53:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-12-gcb2b164780be
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline-nfs: 34 runs,
 1 regressions (v5.10.147-cip18-12-gcb2b164780be)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Nov 2022 08:53:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9926

cip/linux-5.10.y-cip baseline-nfs: 34 runs, 1 regressions (v5.10.147-cip18-=
12-gcb2b164780be)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.147-cip18-12-gcb2b164780be/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.147-cip18-12-gcb2b164780be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      cb2b164780beff6c4be7ccfd9020e39c07c44f3c =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6364c797a93ec95c24e7db76

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221024.1/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/6364c797a93ec95c24e7db98
        failing since 219 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2022-11-04T08:04:17.395402  /lava-7844773/1/../bin/lava-test-case
    2022-11-04T08:04:17.423652  [  100.641323] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

