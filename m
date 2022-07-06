Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C708C43334
	for <webhook@archiver.kernel.org>; Wed,  6 Jul 2022 12:33:43 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.5489.1657110816181387713
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 06 Jul 2022 05:33:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=8D/f5KBB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id p9so3391918plr.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 06 Jul 2022 05:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=IrEV8c4JdbFDOR3r+f+JTl6fDSe4YXZF8ULCRhMCTNg=;
        b=8D/f5KBBEdvO9+RbjpNCaqM1O9gcSMTom+HIrhM8Bz/b6DW71P6q/Hm+eC+Tc3FUQ5
         g+Sgziz/mA/9ZF0scQnCxveo/tBCl8BbCHhIQeOjSy5ttbNWI5qMtYiayfohxwMN/d1j
         FzRsxghqNFwCxr+o79JxY7SO0abvYzbVI7/3hvMHs1EAXj19n7Zt9DOhTE0rZz6ssn2L
         3UOOADqgjjZ5yVkj7qjx9oT2eYdccscYi8NVJAGziwq2L/lqOPVzdqtCL3Dku3lRHFPI
         mKUJr0zd4+gRijaULb/WC4rg6Dt3TJyJ1JssVPABGzUooWT1BoDilgaUuxhWgPwzF3/o
         u/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=IrEV8c4JdbFDOR3r+f+JTl6fDSe4YXZF8ULCRhMCTNg=;
        b=HFMsvIVkcbblSXXO2vikwBd11AMR8v4dyb7G3CMdorXQcU/soVS/4ppposKA4WfKKa
         BR7NpJiK7NWcgUP9FGaIYvVICVsbZrWXvG1Iv2zkZZ8nmp7fdNfEC9sQYb/H0M5U5Fx3
         ba1Ae0zt7USMdPJOWQ+tOZkEl0tExPgXiCksW8XcRQ2z+m0nKZTezfHvDfNW8dYAcur0
         fwhkrERP+pIfohOQQoQvzEhN3WBMyIjGU0Vv1Fb2XKkrGEVrLenr8qcAC4kegUxXjcgL
         v2w/hFiisuMEimHNisWZsKe5MzleDPE8Q1rAyknaOYw9Sgq/cfnP4g335HiI1fR/nI6k
         4JMQ==
X-Gm-Message-State: AJIora901R2mlg5oOgZ5OuNBzMIsPVSuvIrZzGN1Maii1sWPaXECzgKD
	SKm6jW+fmxTcxRmoXC2hlFhz9n4K0JpVNLOg
X-Google-Smtp-Source: 
 AGRyM1tb8LJ4MBo43vxLSkF79OcLj5UCSPxgDx9esersWDf6GRK46DTDvds8HYr4hwoNUv+mZGBrUw==
X-Received: by 2002:a17:90b:388c:b0:1ec:d278:7aa4 with SMTP id
 mu12-20020a17090b388c00b001ecd2787aa4mr50204471pjb.176.1657110815237;
        Wed, 06 Jul 2022 05:33:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 p10-20020a170902bd0a00b00161ac982b9esm25464462pls.185.2022.07.06.05.33.34
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 05:33:34 -0700 (PDT)
Message-ID: <62c5811e.1c69fb81.7298c.4d7c@mx.google.com>
Date: Wed, 06 Jul 2022 05:33:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-1085-gb83ed90eb98d
X-Kernelci-Branch: ci/iwamatsu/linux-4.4.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.4.y-cip-rc baseline: 36 runs,
 4 regressions (v4.4.302-1085-gb83ed90eb98d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Jul 2022 12:33:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8701

cip-gitlab/ci/iwamatsu/linux-4.4.y-cip-rc baseline: 36 runs, 4 regressions =
(v4.4.302-1085-gb83ed90eb98d)

Regressions Summary
-------------------

platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-baylibre | gcc-10   | defconfig+arm64-c=
hromebook | 1          =

qemu_arm64-virt-gicv2 | arm64 | lab-broonie  | gcc-10   | defconfig+arm64-c=
hromebook | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-baylibre | gcc-10   | defconfig+arm64-c=
hromebook | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie  | gcc-10   | defconfig+arm64-c=
hromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.4.y-cip-rc/kernel/v4.4.302-1085-gb83ed90eb98d/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.4.y-cip-rc
  Describe: v4.4.302-1085-gb83ed90eb98d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b83ed90eb98d96fda5562e79c3b9e30afd7ee105 =



Test Regressions
---------------- =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-baylibre | gcc-10   | defconfig+arm64-c=
hromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c5522e42b4cce542a39bd8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.4.302-1085-gb83ed90eb98d/arm64/defconfig+arm64-chromebook/gc=
c-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.4.302-1085-gb83ed90eb98d/arm64/defconfig+arm64-chromebook/gc=
c-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c5522e42b4cce542a39=
bd9
        new failure (last pass: v4.4.302-1082-g00b9de85d40e) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-broonie  | gcc-10   | defconfig+arm64-c=
hromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c5523c42b4cce542a39be3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.4.302-1085-gb83ed90eb98d/arm64/defconfig+arm64-chromebook/gc=
c-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.4.302-1085-gb83ed90eb98d/arm64/defconfig+arm64-chromebook/gc=
c-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c5523c42b4cce542a39=
be4
        new failure (last pass: v4.4.302-1082-g00b9de85d40e) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-baylibre | gcc-10   | defconfig+arm64-c=
hromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c5522d42b4cce542a39bd2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.4.302-1085-gb83ed90eb98d/arm64/defconfig+arm64-chromebook/gc=
c-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.4.302-1085-gb83ed90eb98d/arm64/defconfig+arm64-chromebook/gc=
c-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c5522d42b4cce542a39=
bd3
        new failure (last pass: v4.4.302-1082-g00b9de85d40e) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie  | gcc-10   | defconfig+arm64-c=
hromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c5523b42b4cce542a39bdf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.4.302-1085-gb83ed90eb98d/arm64/defconfig+arm64-chromebook/gc=
c-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.4.302-1085-gb83ed90eb98d/arm64/defconfig+arm64-chromebook/gc=
c-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c5523b42b4cce542a39=
be0
        new failure (last pass: v4.4.302-1082-g00b9de85d40e) =

 =20

