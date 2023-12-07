Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31178C46CA3
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 21:44:21 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web11.104559.1701985460245982853
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 13:44:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=MjOul8sB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d0897e99e0so11085065ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 13:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701985459; x=1702590259; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x7VO7S/z3my3LWYbW/dPbEbwARxQJG/ZuEVNrTo1Now=;
        b=MjOul8sBnrrzmMu48PAwhTimSBVIOrQ47wsjV7Z2jkOuqOhCYVwUOgb/8UiKRrfEi6
         H7SpCAYwrwDHnICwgt5rDXmF5nKFSG5A4QKKbHt7MqpcDfkdl3aI3Wj9J1yH490Wtkcc
         m7tcHC+ZoXZwQLaFYn6vB4jNP+aeYhXaorXj7QoYH0sFFlhmI/2EJzHJ/xzCNWWM4uM7
         /6LSMh97aHpEVlheK/WpFFqICPmJjNpLl9rZrg4B18NCzFcpPWFbrD4d0FSows1fTugl
         HbR3/vcIROCGixc4MPkzyn+IJytX1gRt0+uBm36l/TIy+7kK+xYSrNuR0v7Aca30+fYK
         mfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701985459; x=1702590259;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7VO7S/z3my3LWYbW/dPbEbwARxQJG/ZuEVNrTo1Now=;
        b=DFXQtLX+Xm4KpyeHH+d3tI7VjGE63LHjKEl1CJR+i8Ooa1QtUbPHPPOEmZKtRSGtNW
         OmBsdg15DNUuqUJbbMXhTaFLhEptozaXCUQGH1TA95WUdCiRVPgd8bkdKyybygw/etdX
         Gl8K3SmLukApM7wfZrsnZH0tbOc0RaFFBSmKPhDiiS8w1vR3RiBrcNFoJ0NAERPnp/ik
         pVvFhTa1KWSivcIUbUlIp0E+m31IQdzuC/KyWtGsMsuOQVrwwQ/xKpKrqLwUjUU9Ky5P
         o9GaYj7u4w95iwWd17tZhWWR0c1rOsjN3CjmHPh/RgIr7qB0qtZ8dJIUAaztg8gzH26U
         Zegg==
X-Gm-Message-State: AOJu0YyREgS23M2Fgyl9YXpq67XSq8gonUxuMwM78w6Cyt4F3Kx44CsL
	ul/T2jF7S0yBdzHApft7l5IBcBGZvlLHIaGKLRUPtg==
X-Google-Smtp-Source: AGHT+IGNhHDJvfEX9zuHzO0lWSA23SA1XNoSMF2GYdXWwZmkoTepe2LPl/K15AgXHLwIbHiKMdC+YA==
X-Received: by 2002:a17:902:c386:b0:1d0:d196:265d with SMTP id g6-20020a170902c38600b001d0d196265dmr3316890plg.0.1701985458912;
        Thu, 07 Dec 2023 13:44:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902db0900b001d06b93c66dsm277664plx.233.2023.12.07.13.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:44:18 -0800 (PST)
Message-ID: <65723cb2.170a0220.d923c.1b8a@mx.google.com>
Date: Thu, 07 Dec 2023 13:44:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.299-cip105
Subject: cip/linux-4.19.y-cip ltp-ipc: 10 runs,
 2 regressions (v4.19.299-cip105)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 21:44:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13925

cip/linux-4.19.y-cip ltp-ipc: 10 runs, 2 regressions (v4.19.299-cip105)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =

beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.299-cip105/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.299-cip105
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d152f9dce44a3068c74de8c2046a16b8dd3c1544

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/657233ecfa313170e3e1348a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm/multi_v7_defconfig/gcc-10/lab-broonie/ltp-ipc-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm/multi_v7_defconfig/gcc-10/lab-broonie/ltp-ipc-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/657233ecfa313170e3e134=
8b
        new failure (last pass: v4.19.295-cip103) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/6572317acb546c84dae1349c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm/omap2plus_defconfig/gcc-10/lab-broonie/ltp-ipc-beaglebone-black=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm/omap2plus_defconfig/gcc-10/lab-broonie/ltp-ipc-beaglebone-black=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6572317acb546c84dae134=
9d
        new failure (last pass: v4.19.295-cip103) =

 =20

