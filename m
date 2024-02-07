Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA51EC4829C
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 20:44:41 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web10.878.1707338677931986627
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Feb 2024 12:44:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=eSmi9MBb;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.172, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso838636a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Feb 2024 12:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707338677; x=1707943477; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/RiMO06IRqMH0oPr7sGqgZXsIkv/VNEl02FTJR4noU=;
        b=eSmi9MBbPiBskks1yKzxAUNLnL83MU4ERNyOQ8bCrHJQGakqQjPf9OpVNYDTI3p6T+
         nCTC0fT2n6gtW5Sy9qitXAQxQpDlYDe4RDT0oA6r+iOEoCEeEKU28kzz375JWNgJEquD
         I7Ik2y7T3YF39YyqXhdQdwWGT8MYm+AmGau1ffQIEgasKuUJ2860Ql/hZfM7yGLY3OUD
         06d2L6DGXuz4JalA2TDEtlUPZamp4fzCZY+IPjgXwXd5tBRscwZoGwcDPvFAoB11z+gF
         YGpY6sVBjBjmvApHhNX6IvDIegfdfMpQitz6IdtK1oPShJENoieKdWkb/rZvgz999syy
         hJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707338677; x=1707943477;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/RiMO06IRqMH0oPr7sGqgZXsIkv/VNEl02FTJR4noU=;
        b=I2kF+04lI6fEjNwtolmR/BwobnmwX/uXgodXI4zCT2sGCVFLzDJUTkGa+4wHIO3MKb
         TKeQi1u1m1az7UxYrBo/QNtLlE5xUP3YiOiKNQcF4iUiYmqeXR7mAUHcDM351qDlU/lt
         cyr6e5q0pUFFNzuZBd+5sO1tOv8DLkcl+pWPqePvse8zIhbG6X1Zg+CVzB9ywSXigdyx
         Hv+XPuY2c3RKsEAr+O4rr6BEexva3nkeAdkcMwNtkV0+PYFJEw1B5sNQ9ppsk/NjSO4+
         z/UsoL211Io8wj/UYjoa/wxvcuWzWBHt9w9w11csDV3ALVqU7pxpE2MOP/ZXv/OW/MiW
         gu9g==
X-Gm-Message-State: AOJu0Yyvroyv0zk0q/RuyA5zu7kAi1o6Wq38wwP0sUGSYMu8JhAw+c/a
	0n3evHG0l2WcJ4y357ubBlvOKJpD/J0jRv+WL4IzF5cM12fksKHUyX26XB+ympv3CmOknrVvskz
	GoQ4=
X-Google-Smtp-Source: AGHT+IFZTM8iqyrmenG69OQtVggKJbmagAeiMKLfS3XTs/g8EMwxDDD2fOeGy9JY+u/BpSWZFQDegA==
X-Received: by 2002:a05:6a20:262a:b0:19e:4f20:3325 with SMTP id i42-20020a056a20262a00b0019e4f203325mr4811517pze.46.1707338676703;
        Wed, 07 Feb 2024 12:44:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqXPVyud6A/EM6g7+D3HRW5q9g0n9UnKBK67CUHEH3JzXKsHZ1ytAavq1F0Iof8qfu308WoCg+lAs0dB87z6cC4Y9mgUXiNS8sO6QxhJYyKBp42MFFogzA8rwfaJtBltVZOGvDJmSmEbfv/K7Lo/UC0Q==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id sz14-20020a17090b2d4e00b00295b93bfb24sm2202508pjb.22.2024.02.07.12.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 12:44:36 -0800 (PST)
Message-ID: <65c3ebb4.170a0220.c24e0.7414@mx.google.com>
Date: Wed, 07 Feb 2024 12:44:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1251-g681701bd9bc1f
Subject: cip/linux-4.4.y-cip baseline-cip-nfs: 4 runs,
 2 regressions (v4.4.302-cip72-1251-g681701bd9bc1f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 20:44:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14906

cip/linux-4.4.y-cip baseline-cip-nfs: 4 runs, 2 regressions (v4.4.302-cip72=
-1251-g681701bd9bc1f)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =

beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-1251-g681701bd9bc1f/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-1251-g681701bd9bc1f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      681701bd9bc1f65237982eebce24afcffab64f4f =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/65c3dea79725c4803b8e1eaa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1251-g681701bd9bc1f/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1251-g681701bd9bc1f/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c3dea79725c=
4803b8e1eab
        failing since 58 days (last pass: v4.4.302-cip70, first fail: v4.4.=
302-cip72-1187-g657481329b53c) =

 =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/65c3e20370484cd1218e1e79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1251-g681701bd9bc1f/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-cip=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1251-g681701bd9bc1f/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-cip=
-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c3e20370484=
cd1218e1e7a
        failing since 58 days (last pass: v4.4.302-cip70, first fail: v4.4.=
302-cip72-1187-g657481329b53c) =

 =20

