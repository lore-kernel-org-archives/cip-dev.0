Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98860C3DA6E
	for <webhook@archiver.kernel.org>; Wed,  3 Jan 2024 08:13:03 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.13410.1704269582836992678
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Jan 2024 00:13:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Y7ir6VAN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28cba988d6bso1151906a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 03 Jan 2024 00:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704269582; x=1704874382; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BObopa4eToxSP3XeFwNA4vMJJ3EpI9aUujUXpgF9970=;
        b=Y7ir6VANU8XESbW2jdHutZqtqJJmoVncO3xwaoewAMGNET5N49rzXDRz5XeyyT7c9P
         icU901Nz8Rjzlar3weiptWmPFvkTjdu+f9ewNQqz5UnrT39ABuMX0OlFC84Mq/tHIcuf
         1TWyiaBXnKqD0ST9vf4Ys0xSREAONQyNDTjP7WoG1A6NTOO0HaGxT7FS4PWVzyv69D6U
         S+LPgJd+U3kUXHkOtrbY8msP1Bl9RA266W2Bd7nuyyTGa7CSlg22iNTTXTqzJP+87jkq
         NPuimt9WkYlJZNDyOmeQfd/6vVlv3UVx3doT3tkHXXrHCiejum1PachqWeQsEsl1f2Dc
         DC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704269582; x=1704874382;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BObopa4eToxSP3XeFwNA4vMJJ3EpI9aUujUXpgF9970=;
        b=gC3m1BKb5N1lQB3G3geflUYbKtJfzcZxgHUOL27ueq0GTKChvEvTSb8+dPIh2LOkqQ
         6B+spQmSqFQDOXUj0VOFj24wyAz9nkfo1a81OtWASo1xSmjY59LMNdusr3nmQMNEhQFc
         Mk/Qbw8gkFaoGAQ1DUlkMeP194ASz2vaXBBNoI6SUPgZBuz8fQ+nzDM8wA6tzC34BSZZ
         h2cIVs5Yl680jAmMbUIzg2NxC+UNx7P7XBq9y7qCLu3qOy9XjZ2dwRmwUMPukskuBSSe
         aqEDHCQl/xzCuVdZhoGpLqDB56Xj0lgNbkSCIJ/VrNqcKb33n9RPLqseckI8UrANwxCf
         LI5g==
X-Gm-Message-State: AOJu0Yz1PSIluge3qe3IY5qpAIahNAIKzgjrYz4jkCMjEoi+55yBS8SO
	+suCKijjM39IqmRUUyq7jzvrj5mOpEAsEIJ4XH4OXuVd6cc=
X-Google-Smtp-Source: AGHT+IGSO5revOnYJn/FZ6WSVgJ+/sMO7KMlfiXv6sBVCLWh7isTNpB/zbjWUbLqc49qRyZR6IVMiQ==
X-Received: by 2002:a17:90b:24a:b0:28c:23fe:dca4 with SMTP id fz10-20020a17090b024a00b0028c23fedca4mr4944371pjb.1.1704269581739;
        Wed, 03 Jan 2024 00:13:01 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id rr16-20020a17090b2b5000b0028ce54e7a09sm975559pjb.50.2024.01.03.00.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 00:13:01 -0800 (PST)
Message-ID: <6595170d.170a0220.d394a.21aa@mx.google.com>
Date: Wed, 03 Jan 2024 00:13:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1224-ga0ac575eeff8
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip baseline-cip-nfs: 4 runs,
 2 regressions (v4.4.302-cip72-1224-ga0ac575eeff8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Jan 2024 08:13:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14239

cip/linux-4.4.y-cip baseline-cip-nfs: 4 runs, 2 regressions (v4.4.302-cip72=
-1224-ga0ac575eeff8)

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


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-1224-ga0ac575eeff8/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-1224-ga0ac575eeff8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a0ac575eeff89882d3aa16d67979a86e668f5d1d =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65951191a93cfc2b1577b5b7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1224-ga0ac575eeff8/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1224-ga0ac575eeff8/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65951191a93cf=
c2b1577b5b8
        failing since 22 days (last pass: v4.4.302-cip70, first fail: v4.4.=
302-cip72-1187-g657481329b53c) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/659512ccb95b75372277b5a3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1224-ga0ac575eeff8/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1224-ga0ac575eeff8/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/659512ccb95b7=
5372277b5a4
        failing since 22 days (last pass: v4.4.302-cip70, first fail: v4.4.=
302-cip72-1187-g657481329b53c) =

 =20

