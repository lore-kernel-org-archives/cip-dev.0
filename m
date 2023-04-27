Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43202C77B7F
	for <webhook@archiver.kernel.org>; Thu, 27 Apr 2023 10:18:32 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web10.16765.1682590702867914801
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 27 Apr 2023 03:18:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=agwqsQMT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-64115e652eeso3790623b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 27 Apr 2023 03:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682590701; x=1685182701;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OZzB994DCNRi58btlVu/CkJxTHyFIrK8aRSTUdv1EOg=;
        b=agwqsQMTyu58M3T3Omkor2EDAw1C8XVazjV7itTvNnjxWyNFOqbdrn+s9KepspX7I/
         ekIlJH/To4srszWd2TZgFhAGtzoJtR6aZSbNsn/9MkSvqwcZDYcSwCRBuv1udAQVTi8/
         tbB7cfdy97mE2TXvPCLvTqYjsc06Fu2sbe7PJSKp/iizdjSHfzaojjbR9e0ZCTT9bxCJ
         +4Kdwx51MAOXthJrVFduOOnRq7fLfPU1icryvqqrRV40/76+0PMBazpELBnXihq86dXF
         J3J8Bu8+CUJBDnUB2GWK3GZVRbrRiPmtvyIxLFqfxj9zXK7wKPHupyTsE/VY5FmeyTD0
         vw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682590701; x=1685182701;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZzB994DCNRi58btlVu/CkJxTHyFIrK8aRSTUdv1EOg=;
        b=K+al9j2Fbj7z+m5QC4734xsHobCPabY4Isr+k+Qj4ui8ttwITh+HO2ylx4h3bpD3B5
         FS/3nJJfXTONdDQX4Fh0vHjakgDT2HzMXmoQQPQB8HXSgMvviLpNB01X+N2s0pYfKNgY
         5bK8eyltZv0qbKX7tesMJWIWHZInba7tduBLeyfAY4g5448Wj0aOYvsx0KxbAv9WZqpv
         zvKWfxdtjinrebqrFgiMtnMbPSwYhDZXn96A2yEu4Axg7tcXS20iTr8X5ouE/nnbylft
         tG3WytfpNNH6ovYeYFmeuna1XkN3pppGx5weHSW8tlgouClRmzfb0Lx2119mZcdT7D6F
         tpwA==
X-Gm-Message-State: AC+VfDxh2kPljBVTk1oVUNbYz/MFTO4pnZIFG8WSUkwTBM6ay2gKiZGk
	JgvYxT6uwu2PqTakzs9IW3W22gt16dONAseRvF2vCA==
X-Google-Smtp-Source: ACHHUZ7Y9/B2gwDXV50ed44+xA1mlsH4uMzfopjNEVV9j8BEK8TdpbdxJDeDKPWJK1LFcXde9hPMaw==
X-Received: by 2002:a05:6a00:10c6:b0:63b:19e5:a96e with SMTP id d6-20020a056a0010c600b0063b19e5a96emr1644827pfu.9.1682590701496;
        Thu, 27 Apr 2023 03:18:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h8-20020a056a00170800b00571cdbd0771sm12914753pfc.102.2023.04.27.03.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 03:18:21 -0700 (PDT)
Message-ID: <644a4bed.050a0220.9c2c8.a8cb@mx.google.com>
Date: Thu, 27 Apr 2023 03:18:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-1186-g2516b357b2e3a
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc ltp-ipc: 5 runs,
 1 regressions (v4.4-st20-1186-g2516b357b2e3a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Apr 2023 10:18:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11365

cip/linux-4.4.y-st-rc ltp-ipc: 5 runs, 1 regressions (v4.4-st20-1186-g2516b=
357b2e3a)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1186-g2516b357b2e3a/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1186-g2516b357b2e3a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2516b357b2e3a612ef2904362b0acbb97746d0a1

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  458f3554675aace42e9750086d26799e82829f11 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a3b8618f1b8b19c2e85f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-g2516b357b2e3a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-ipc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-g2516b357b2e3a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-ipc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/644a3b8618f1b8b19c2e85=
f2
        new failure (last pass: v4.4-st20-1097-g52d843097a439) =

 =20

