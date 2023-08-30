Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F47EC83F12
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 00:28:09 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
 by mx.groups.io with SMTP id smtpd.web10.3372.1693355283850648702
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 29 Aug 2023 17:28:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=mXnSYUa/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.170, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3a8506f5b73so3493479b6e.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 29 Aug 2023 17:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693355283; x=1693960083; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nEOpKhXRA2BNjMEpks5YBi0rqJ0ozUA45GEkWI1r60E=;
        b=mXnSYUa/d6iI4uP9obTF18OjMdDCHeg/LzwHvRSHrWwuonqPr4SzA4an2EnMxoWgj1
         08XRbKs8VKSXBmCvDhRnzsNFC5rclvAt+XwHBAiEJfLxzem+qk9C01zK4/3p7jhs+Jk5
         ngCZI03d3VP/wxRW19kHlFw7pdNRKwl4FM0FtgXve4qmcpA1Ogp9dxmcjAhCUi6ncoCb
         OieMYUjN7y3L8UdMtHw6Xpu4XnkAOkBOozZpS3P8P+vHmRwFVNsnT+atoREkOhFOaC9T
         KPap6O4CLv6cIr+5CzY/vbC+z/5cz45GbfCnXkfpBp5NdJjLFele+9h/JvkuVyTAzSpx
         wBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693355283; x=1693960083;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEOpKhXRA2BNjMEpks5YBi0rqJ0ozUA45GEkWI1r60E=;
        b=N5hNXRF8201Qj6DnhenQpwVbt9BT0iTu85oAlqNF3dQb2AKRir814wpXdEf2SS5IK9
         Imkcii3LatXcfZ7qn+1MCqZjbDFMF3L6g/Io2OhFoRhrjX5ECrcX2AOv+YCAfYUXYePi
         4yVAfP3EIuLpyaEYaNK97FqEILom6WPvZ4wEoShZ01U9t+LlUszbWTQw1pNTTENb9UUB
         fo6A6aW/NVmnHsz0iD1bVSysSaa0RudSiIMshz3uKLk3wdAli7LJyvL/WvhpyKBam1Z7
         ZH+slJoaQOzNr8KPWaNihPlm8kgvFRKz0MqXfU7qUZHbyFTYLIuUtey7EAQhL8tWVYeT
         jBsQ==
X-Gm-Message-State: AOJu0YwxCZ8KB4rZerBLVkp+7jF+fsgPuUzLuqlbcdqYlgz3WqK9V2s8
	SCLaWF/Tgu1r2C3iSsGIVbAZmJ+I5nYSKtlLZto=
X-Google-Smtp-Source: AGHT+IGl/FxEw7lSq3f6k3jWPxjW1utStbJPN2rOh0zR+mRVtNT4ICEmkX2p6Rn1oNGYN0LPnQzmbw==
X-Received: by 2002:a05:6808:1897:b0:3a7:4e0c:faa7 with SMTP id bi23-20020a056808189700b003a74e0cfaa7mr890746oib.14.1693355282794;
        Tue, 29 Aug 2023 17:28:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p20-20020a637414000000b0056c466b09a4sm9617557pgc.59.2023.08.29.17.28.01
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 17:28:01 -0700 (PDT)
Message-ID: <64ee8d11.630a0220.3834e.e180@mx.google.com>
Date: Tue, 29 Aug 2023 17:28:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.191-cip38-2-g05fb42f86d06a
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs,
 2 regressions (v5.10.191-cip38-2-g05fb42f86d06a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Aug 2023 00:28:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12902

cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs, 2 regressions (v5.10.191=
-cip38-2-g05fb42f86d06a)

Regressions Summary
-------------------

platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.191-cip38-2-g05fb42f86d06a/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.191-cip38-2-g05fb42f86d06a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      05fb42f86d06ab31aa144cefe1ccd3c7cd8bbc72

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64ee79f817b671cad0286d7e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/riscv/defconfig/gcc-10/lab-broonie/ltp-ti=
mers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-2-g05fb42f86d06a/riscv/defconfig/gcc-10/lab-broonie/ltp-ti=
mers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64ee79f817b=
671cad0286d83
        failing since 85 days (last pass: v6.1.26-1298-g61395b9756bd5, firs=
t fail: v5.10.180-cip34-26-gc198172c84b6a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64ee79f817b=
671cad0286d83
        failing since 85 days (last pass: v6.1.26-1298-g61395b9756bd5, firs=
t fail: v5.10.180-cip34-26-gc198172c84b6a) =

 =20

