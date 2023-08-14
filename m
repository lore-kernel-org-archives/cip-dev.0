Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31998C41513
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 00:59:00 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web10.98137.1691974738007928563
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 13 Aug 2023 17:58:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=40gDKZFd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-686ba29ccb1so2512526b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 13 Aug 2023 17:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691974737; x=1692579537;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8VNqqW/gLVezHCGSCIe/YHPQbok/K+MFtqvR11Ewmg=;
        b=40gDKZFdEKp4Q/d6YVNiWSiBDh9ddnh3+kr0YTeTBoZVr+Al4SE8k3N+LbsIgckPXI
         /Jmyjcz0B0mcSz7xu3aQrUtRbtkGBsKnQ7E5SEP2vrMtURAJ4RpXxUvJXZ6/274wVW4T
         SgzqSmbg4oVfYMgC2CGduwxdqyefpD0xpoDYU8Vh5o5I5xDf+kyvyKx0NQ+gwxboPv89
         By2H8rZtaitNHre2k9cfYvySFtciGwrZdh7ztAWZ/iQP2oFMXQpe9S7jLiV7vfJ2nBSf
         DLJuCLeSac6KZlLSrsjhlf3NWXGV0Oe4n5cHhLb+hecfXDxYEQAOqv9nfJVlOKpHM5uO
         tMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691974737; x=1692579537;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z8VNqqW/gLVezHCGSCIe/YHPQbok/K+MFtqvR11Ewmg=;
        b=CamsJw9CMtiLpaCeEmOOCr2ZqzVnSCG+u+pY9qc5HGnXkHb6NamTDpvPvWlXF48G/v
         7JPpv3vb5yx+FtM4RJ6GnrGs1KtFLIPE8B9FxRHXev4w4S0re2k8xNpPP7J1HifbpQCm
         I8rk2I9JjYE6u4eEIl1BzRV6kPB8WwIQy//tl2PW9G6O15s1dobvdbM8H2ajwr3y8thG
         Pktti2648aVxsymUsnfOMc38ntCtBNV/GClO0umddG+kIuCMSvTwACQyIJMt8ZYnOJGB
         9+fT7EG3G/H7CdIRyMYSB/oPjuMAaT8BVUGgnzbbQ5ZgEzZgscTIUcO8fBZpha2X9edF
         UQ0g==
X-Gm-Message-State: AOJu0YztJCFYaRT7N8QuHt1C28BxraPddboKZUB9Q1t55M4jKlapPC+U
	3RUurKZo4MrkTqO910hP2hVwfX9UpamVyM+ctnYjr7ef
X-Google-Smtp-Source: AGHT+IEkNw2hc4iI4UnBcl232RIxYb9zT8oRzCM0doDuWAIOk7bnCc3AOt91na6p5LWl1WQRNBhfBQ==
X-Received: by 2002:a05:6a00:a89:b0:676:8fac:37 with SMTP id b9-20020a056a000a8900b006768fac0037mr9412995pfl.4.1691974736814;
        Sun, 13 Aug 2023 17:58:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j7-20020a62e907000000b00686edf28c22sm6712720pfh.87.2023.08.13.17.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 17:58:56 -0700 (PDT)
Message-ID: <64d97c50.620a0220.2aced.b5c7@mx.google.com>
Date: Sun, 13 Aug 2023 17:58:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.45-cip3
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
Subject: cip/linux-6.1.y-cip baseline-nfs: 24 runs,
 1 regressions (v6.1.45-cip3)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 00:59:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12622

cip/linux-6.1.y-cip baseline-nfs: 24 runs, 1 regressions (v6.1.45-cip3)

Regressions Summary
-------------------

platform   | arch | lab         | compiler | defconfig           | regressi=
ons
-----------+------+-------------+----------+---------------------+---------=
---
imx6q-udoo | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.45-cip3/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.45-cip3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      9854793aeaee837123cc2be25bbdf869fa5ba5e8 =



Test Regressions
---------------- =



platform   | arch | lab         | compiler | defconfig           | regressi=
ons
-----------+------+-------------+----------+---------------------+---------=
---
imx6q-udoo | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/64d9715b0a10e4700435b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.45-ci=
p3/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.45-ci=
p3/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64d9715b0a10e4700=
435b1da
        failing since 24 days (last pass: v6.1.31-65-ge66be31505fa, first f=
ail: v6.1.38-cip1-10-gf4eb42f19246) =

 =20

