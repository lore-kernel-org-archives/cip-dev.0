Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CB3C41535
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 17:49:19 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.38686.1698947357782695740
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 02 Nov 2023 10:49:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=JcUYVbVe;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1cc5fa0e4d5so10817665ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 02 Nov 2023 10:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698947356; x=1699552156; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=120bHT1APnJNIcBcRTpX9Gp2i4XCcGj6zUxaIzqq5ag=;
        b=JcUYVbVeoY4kboM7x4oKzaNxq0GYcYVGwE253C5sbPskuZs6yX8pvZgNgMLuhSvv/l
         suTODel5dNdIPCI4Cqt4CDXn5AtWQ57+HzJT/xmwo3GGuXdDekGZn2F+9nLOGQiwEltU
         ARHfXvWTNXjpLFgUms9rBbcuUVUdZ0WPlTcIrsh4gJ2/fDl8loweXEuw6cMQfxTc13dL
         skcfgVpV03j4NCku9BFusQCp5bKJF9/MHXxpv5jE9yJau1YzQSQTN9amVEExIIScvYBQ
         gZv8wAP6L0qJevSCPSi+DyAkUbnYhLu7UZYZ9UA6OwCIN2xbBT10kixBp0O6Homf0LfW
         mMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947356; x=1699552156;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=120bHT1APnJNIcBcRTpX9Gp2i4XCcGj6zUxaIzqq5ag=;
        b=T99xfT/yixuJpM2l3EbGqHGE8p7Lxr+qlevp1jj4BRcFXkVF5Saqan5gY/WWUxvun0
         /FIdv/f/hpsJjObS1UWxPwnafrZ6LZH+jxK4ZACRyV3Yc5R2F8VrFpHloeaeJrNeJx24
         X/JOeWzUmNPDcc00QqZoRhLGTD/rG3r28BT5ok5laNiPCaGD2oHKdBLTmcaGrCSFhixp
         pi/+qjG7GoVuczU8jz3gHJMmTlGAEjyWOENccXg4toGBGLHSeDMFvnfNK6AFu37tQMqe
         CqTteK56p8IEl92O6h4A3QHRyyB+bYVb9htU9FfOZDG9IoycycHsYJ0RCcodzay4FS2w
         weFQ==
X-Gm-Message-State: AOJu0Yzw2853jZ7jFH4GTJXxKV8OYEJegyXyL0/NHusz6avYSuYSRJUs
	v7zl/MX2tYQshI6sgDAFT+v7ftjv0+m4A2fROsXyqA==
X-Google-Smtp-Source: AGHT+IFtHXxEwSB1vyMe0OBar1wbVMSqZCXBjcrSDDMEov/Rro+2RgWYLOrHmAbLKx5abcOhUGLkDg==
X-Received: by 2002:a17:902:e84b:b0:1cc:4559:f5 with SMTP id t11-20020a170902e84b00b001cc455900f5mr15590747plg.14.1698947356609;
        Thu, 02 Nov 2023 10:49:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jb20-20020a170903259400b001c74876f032sm21276plb.162.2023.11.02.10.49.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 10:49:12 -0700 (PDT)
Message-ID: <6543e118.170a0220.b7bf5.0195@mx.google.com>
Date: Thu, 02 Nov 2023 10:49:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-cip39-915-g96fa7f16cf02
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 12 runs,
 2 regressions (v5.10.194-cip39-915-g96fa7f16cf02)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Nov 2023 17:49:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13527

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 12 runs, 2 regr=
essions (v5.10.194-cip39-915-g96fa7f16cf02)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.194-cip39-915-g96fa7f16cf02/plan/kselftes=
t-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.194-cip39-915-g96fa7f16cf02
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      96fa7f16cf0228e65eeaeaeef1b73f242f4e169e =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6543c9844630b504e8efcf6e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig/gcc-10/lab-c=
ip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig/gcc-10/lab-c=
ip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6543c9844630b5=
04e8efcf6f
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6543ceac113df631c6efcef9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6543ceac113df6=
31c6efcefa
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1) =

 =20

