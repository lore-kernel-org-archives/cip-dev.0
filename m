Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573D1EE49B0
	for <webhook@archiver.kernel.org>; Wed, 23 Aug 2023 10:42:56 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web11.8495.1692787372726235152
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 23 Aug 2023 03:42:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=H7BWPTKr;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-68a402c1fcdso2317115b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 23 Aug 2023 03:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692787371; x=1693392171;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mQPAaF69AzrMumRHm0+apq+cdTGJEPUQOLhbPW9fmfM=;
        b=H7BWPTKr22QgDUTWw6Xrvzjic/QQtQd5zoWuPsoWMAro2pGmuV1HFP/iuDWvYQs0By
         RHVRnLhknMzp93WoM2h3ibBypZjm4OieqWvs+Wx+vT724DUhgyz+kLninJ0VjofKVDIM
         On3HpzMSe6jOf1vvVcoiqtYrFawIUHbLSZvj04EM5OjO+Sl2/NLOuswP5W4o9mIkIUih
         3eaQFz5MmaxsqFrXhQa1lfhFdgMepi+ABZGNEEdnYmgiQRrsawwJOKkVA04iZ3ackK75
         nT3nfbMQKepJfYcLiLL0pcvnicIdWS+ws807HB9AQledFe+P6ePUoAw2wjTzWwKNKETG
         qLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692787371; x=1693392171;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQPAaF69AzrMumRHm0+apq+cdTGJEPUQOLhbPW9fmfM=;
        b=NdYs+DCwaJqR8y7y3XQU2ADli6x0GP22pLxCqsGactUO3Y/LfG+6+VMH1TSoeQwJ/Z
         dKoFg+Gz67p1FNc3UbP+b0DYWLKQR+VZrMG1pxCKfl3Fucqq1eXS/izKMrviple6z9an
         sNFQCeVrBO6H4a6VKkckbLo7MWC3wIzVlrfPg4lmLox4tRoh0IHu93Si6LQuiSGhdu/K
         FIgzIrlVfgdO8RxRybG1d3TIL4uQG1DK+llFTphAfviF1d3UDirqH9go32KEHtlnZuN0
         n0wvhseeS/qfnsWEyfGtq5Wx/KeLEiKd/GBY2gszAeLcWv8rE1W3sZb0o6kDRjlEatPL
         5+jA==
X-Gm-Message-State: AOJu0YxFLHZBg3/3TdkwBqgwNgSq/FNsiSNgY9PNr58vdcPUPLO+Aeeo
	fD5Wkrp7ZTBXBSF4+S2UVQeeNWUySzplDoDnlwc=
X-Google-Smtp-Source: AGHT+IEpFmS+8+icoTBMkgF/QvlMaRUavqOk9MZUFp6+aNtkFZQew4jx/gIdDmjZZIO0cicX+4a5KQ==
X-Received: by 2002:a05:6a20:8f0d:b0:132:cd2d:16fd with SMTP id b13-20020a056a208f0d00b00132cd2d16fdmr11561281pzk.38.1692787371314;
        Wed, 23 Aug 2023 03:42:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g7-20020a62e307000000b0068bc44dc40dsm1161214pfh.34.2023.08.23.03.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 03:42:50 -0700 (PDT)
Message-ID: <64e5e2aa.620a0220.213ad.2728@mx.google.com>
Date: Wed, 23 Aug 2023 03:42:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.45-cip3-31-gc9451d303f3d
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
Subject: cip/linux-6.1.y-cip baseline-nfs: 24 runs,
 1 regressions (v6.1.45-cip3-31-gc9451d303f3d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Aug 2023 10:42:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12838

cip/linux-6.1.y-cip baseline-nfs: 24 runs, 1 regressions (v6.1.45-cip3-31-g=
c9451d303f3d)

Regressions Summary
-------------------

platform   | arch | lab         | compiler | defconfig           | regressi=
ons
-----------+------+-------------+----------+---------------------+---------=
---
imx6q-udoo | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.45-cip3-31-gc9451d303f3d/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.45-cip3-31-gc9451d303f3d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c9451d303f3dddd89b8ee3f9bb9a2ff5b369be7f =



Test Regressions
---------------- =



platform   | arch | lab         | compiler | defconfig           | regressi=
ons
-----------+------+-------------+----------+---------------------+---------=
---
imx6q-udoo | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/64e5daf320a662aff9b1e3b2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.45-ci=
p3-31-gc9451d303f3d/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs=
-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.45-ci=
p3-31-gc9451d303f3d/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs=
-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64e5daf320a662aff=
9b1e3b3
        failing since 33 days (last pass: v6.1.31-65-ge66be31505fa, first f=
ail: v6.1.38-cip1-10-gf4eb42f19246) =

 =20

