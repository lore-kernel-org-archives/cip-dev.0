Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA32EEB64DD
	for <webhook@archiver.kernel.org>; Wed,  9 Aug 2023 05:29:34 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.82106.1691558972146484631
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 08 Aug 2023 22:29:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=IFfNV9s7;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1bbff6b2679so42305165ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 08 Aug 2023 22:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691558971; x=1692163771;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iAZMuQGzyLUtRudGt80h0H/MgxaJJsC+manGD51os7c=;
        b=IFfNV9s7UlGRhWB5Y9u7mgz3QzXNe4KV51p/eLNjsmIBN+UsoZSzLdczG6wHDvnVt2
         H2FGSu64Myac8nKHiwiCFOTb9uVBVxwVIX+lPPYOwd5oURYMONb6Enn9hN19ot4DKYXM
         Qt9kxBppp/kFshTAZiJQ8nPMy2WTFgSBwUnJcennmV11aDgLy4URfwhF9oGs7E5Z2FX+
         T3bpEvCGJ7X38BwWlU/EtjTzss/ooKEqS5ozznIMvsMJN9DxzrOplXULU+AX83fekStF
         eJAT8zxJnL933KNlGNFvMWOQNujRUBvSqRnanwMOAhMSU61sRvQ6LV0fvFSfubySqSxL
         t1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691558971; x=1692163771;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iAZMuQGzyLUtRudGt80h0H/MgxaJJsC+manGD51os7c=;
        b=fEKZ2ml0i9/UC25neJFO7/GsUeGERxN9eUGRXruO3CDdBB3GU7uMfADUyAK8lfj31i
         1IFdGOgQs05iTRugdijTiWly6/rvKIDTnx8HwFjEurTRs7juT+mBngi3IVhkdvOUtYN3
         8OGCBwMwpsvecUdWNEfWoamhiPJ3qqXgpMyToLYRKc5KBhfGb0DCeYwchysxweR2+G9J
         m7Q5JsbDYVqNNusDTKaKaINfS0B9ZvT0br9osHWOJ+QaNRHAobbkWoqTwMD1rBTpN/js
         cp0DEpbLiZtv1+/m61w+Z3OGDcsn/6UjbKAIvywYk3Xs5Hk9nUncewCCFbnvsaJ6r4Sz
         QNgQ==
X-Gm-Message-State: AOJu0YzDPTf1Q/DyLXrfdOGE6KuOdndMF5EL0N8jz9JkFR+VIGuGvI+E
	poquS0EQU+xp2qsUQrC15Sy+U+SCjfLKsEbZRnPEVg==
X-Google-Smtp-Source: AGHT+IFZQGmUSWEmM53EIaEq61OWWLuscANk++vHxe99jV7fhpVmNNE29tyGUUxQjYzXPIYM/M2wOw==
X-Received: by 2002:a17:902:e54e:b0:1bb:83cd:ad8b with SMTP id n14-20020a170902e54e00b001bb83cdad8bmr1879487plf.30.1691558970871;
        Tue, 08 Aug 2023 22:29:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b001b06c106844sm10022582plk.151.2023.08.08.22.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 22:29:30 -0700 (PDT)
Message-ID: <64d3243a.170a0220.c6204.29fc@mx.google.com>
Date: Tue, 08 Aug 2023 22:29:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.42-cip2-1-g47d13938e615
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
Subject: cip/linux-6.1.y-cip baseline-nfs: 20 runs,
 1 regressions (v6.1.42-cip2-1-g47d13938e615)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Aug 2023 05:29:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12576

cip/linux-6.1.y-cip baseline-nfs: 20 runs, 1 regressions (v6.1.42-cip2-1-g4=
7d13938e615)

Regressions Summary
-------------------

platform   | arch | lab         | compiler | defconfig           | regressi=
ons
-----------+------+-------------+----------+---------------------+---------=
---
imx6q-udoo | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.42-cip2-1-g47d13938e615/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.42-cip2-1-g47d13938e615
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      47d13938e615152046baba32a1c3135dd09e2feb =



Test Regressions
---------------- =



platform   | arch | lab         | compiler | defconfig           | regressi=
ons
-----------+------+-------------+----------+---------------------+---------=
---
imx6q-udoo | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/64d31714a4105a66cf35b1da

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.42-ci=
p2-1-g47d13938e615/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-=
imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.42-ci=
p2-1-g47d13938e615/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-=
imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64d31714a4105a66c=
f35b1db
        failing since 19 days (last pass: v6.1.31-65-ge66be31505fa, first f=
ail: v6.1.38-cip1-10-gf4eb42f19246) =

 =20

