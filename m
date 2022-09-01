Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF94ECAAD1
	for <webhook@archiver.kernel.org>; Thu,  1 Sep 2022 06:19:21 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web11.9059.1662013150138734414
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 23:19:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=0TdnzJwi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id y127so16603429pfy.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 23:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=Y6wh7MXRx/J2l4K1X7dmwDJZjZ465dVAS7D6e5nMwyI=;
        b=0TdnzJwiuMKper3kaTD54BTECTJUBrdf3JCQeYhMrrBf9CsBVWEwKx90QrufpAnDCj
         qpcjZG9l/afifqleL0AmPQL54fwWtPlK0HbK6yPa2SbvExkZr2IgVjxFY1g9zFp5+yUC
         JY5Yt7N/FV7SOUL5IcOsxo8bF+BIGwT6y6qYhGRaqg90Wna2AA/wPKgnoEhTRBXDOpgD
         TxzLO9OUH44UtHT7mrc++f+H1ZLgKH+mr8scp0wSOndtVZom2faYylxuQw9uWDC4PHx9
         y1C2Vn6FyTzhIVu525uHP1H72XIYj66l2zDMKFkM1oul/aoX+bBCH37RkL/PQUhBK26X
         enHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Y6wh7MXRx/J2l4K1X7dmwDJZjZ465dVAS7D6e5nMwyI=;
        b=pSygiYebjiTgvvqeCia5bOIOj9lD07dwu50zN1s0SMdcxtE3GfXsdqLfY73snto1Yr
         abp7iTFgyCFAoLtjOMGyTXfN9a3YSlfRUCudlbF+bDIVFThUvxwQ4vzVHCR9FUIEG06N
         sY6AC+h58qcwNamg/orhE4o0HKQHzkaYiNMdhYbgDsvXrTDC1CsCHJCqx5bwf/YIdmUZ
         RM9yy8ug18aOHhG0xU6n673XhWm7TR/93/zmyTj10mKigzVQx6DPcSmGf+7A4eMV28Yy
         b7LcY6aXHTHCbZnuB48wJDQO04kIvZn82IOkfE+vU/iWgP3/xOVoQVoFfjxC7+ZiSJJa
         5w7w==
X-Gm-Message-State: ACgBeo3YYcSCjv35JDnodouSzBFhLvWd29eRz8GoUcySymi7ZAcWv3NN
	k7fqYmRCNW5io6jvYqnnRuLwKB4v/j96CZdrnF8=
X-Google-Smtp-Source: 
 AA6agR5lz7V8F0rYyyz/ih3+Qs0TA8FoNB8zuG/E+e3p8SwkOxWGmOa5yUtbFs+awL9D4BeWsoMcow==
X-Received: by 2002:a63:ab05:0:b0:427:fb94:f9d6 with SMTP id
 p5-20020a63ab05000000b00427fb94f9d6mr24192076pgf.544.1662013149099;
        Wed, 31 Aug 2022 23:19:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 w18-20020a1709027b9200b001728ac8af94sm12700850pll.248.2022.08.31.23.19.08
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 23:19:08 -0700 (PDT)
Message-ID: <63104edc.170a0220.a7d2b.7511@mx.google.com>
Date: Wed, 31 Aug 2022 23:19:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.256-cip80-1-g68250b8eafbe0
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc smc: 10 runs,
 2 regressions (v4.19.256-cip80-1-g68250b8eafbe0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Sep 2022 06:19:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9402

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc smc: 10 runs, 2 regressions (v4.=
19.256-cip80-1-g68250b8eafbe0)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig | 1   =
       =

qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig | 1   =
       =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.256-cip80-1-g68250b8eafbe0/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.256-cip80-1-g68250b8eafbe0
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      68250b8eafbe07c581320a9a33cdfd6217030bb8 =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/631042731715a76e89355652

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.256-cip80-1-g68250b8eafbe0/arm64/defconfig/gcc-10/lab-br=
oonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.256-cip80-1-g68250b8eafbe0/arm64/defconfig/gcc-10/lab-br=
oonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/631042731715a76e89355653
        failing since 86 days (last pass: v4.19.239-cip72-68-g407458469172,=
 first fail: v4.19.245-cip74-32-g2d021d7a9e637) =

 =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/631040ed6bc01e027135566f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.256-cip80-1-g68250b8eafbe0/arm64/defconfig/gcc-10/lab-co=
llabora/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.256-cip80-1-g68250b8eafbe0/arm64/defconfig/gcc-10/lab-co=
llabora/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/631040ed6bc01e0271355670
        failing since 86 days (last pass: v4.19.239-cip72-68-g407458469172,=
 first fail: v4.19.245-cip74-32-g2d021d7a9e637) =

 =20

