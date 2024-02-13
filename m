Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8C0C4829F
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 19:06:16 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.21893.1707851174389807456
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 13 Feb 2024 11:06:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=fpRAqEgd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d51ba18e1bso46071475ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 13 Feb 2024 11:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707851173; x=1708455973; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BAZDAAocKifisFYl9a9osoxFDoB8WbMBFkrMGF645o4=;
        b=fpRAqEgdCeiaAI46MfLOjMK5rD0gJC/qwwSO8PJBk51XgRn5ItqdPpW88kA37paz0h
         wNtB8otGC1QC4A13+0SL4HihPutyHsvawK1hmJ7x15sBltUcLnc3jmgSYJMzJrqDkuhR
         c+46e4z954dvLumdzP0NDZYUKGWPEZFZog/chAducgU+NBH550Rrkg+Z3mktQ2+Eh24f
         7aSyLFikuuAkOk+aHNpuFXj3HUTDipoglDkSzqBJpvnzCT/MGv5M0VfE6iGWeEYE4YP/
         cywXzkDbO8pQIPlk15WSAEAnsJMJ9rbb46A3aTFUR5mV0ayGKZcOsaJIBPFECAilIvK9
         oSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707851173; x=1708455973;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAZDAAocKifisFYl9a9osoxFDoB8WbMBFkrMGF645o4=;
        b=RimBKDcNAfHPeGbaWbZYfzVsx2aEtoxHPKbYGgY87KMNEpSsIiruLDobWHZtxm8sOF
         nCY6JoaU2bOCq7HUePUM/lXgvNHcYd+Ig8Mnd+lPIVJtVfU3uvvoQorsI+/A89f2RHQp
         snYwyaDX6Gk0Ee7GjXg5eq4DSyLi1xSoVR9LqZEMjNJVq+lqkpCN2ZjuHoUEuYcqr/W2
         gb/SLg2hKTvNvvgvTcEIIfnnbbzVblqhZZCGn7M5ZRmNvI6gKSEVVIhk+d35vFoamXZH
         Na/ga5xTKkOHj+j3YohqgkM2mvRyXOfDWZf5IQb9Z+uV+0UAUh2z2nImsthwOqosg973
         4b5w==
X-Gm-Message-State: AOJu0Yzd9i3CPlYbxMXBMw7n3A35/DX/VRiv18MkPcZOnd5aESz3wChd
	bkia3k0hT9HZcR0Ht+qJinMtxwSy+9meghxBUWTojgjkM3wM807Sm0/VQlaOH5x7o95VaCaSpIu
	fkik=
X-Google-Smtp-Source: AGHT+IE3cafm2aMMnBB3I4fcpkvn+Rnam+AXkK4JPhuABTJ+F9q/8alfMwCv0+jzWY1ti/5YUxEwyg==
X-Received: by 2002:a17:903:26cf:b0:1d9:3bb5:2819 with SMTP id jg15-20020a17090326cf00b001d93bb52819mr393429plb.34.1707851173234;
        Tue, 13 Feb 2024 11:06:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXGBJd7PUJZnoaSp+obP1yJh8yc7y3Ccsv/vhVQTruMrHuMjydTvqxCfZi3zDIqFvIJEaF0RScgnsCUjhxAaKjaRs4ChcdijILFfbiO536ZmL5vcqaLbsSf4bOm9y+JzB/2oHSTG0qY6tYROYvdS0XiCg==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u11-20020a170903308b00b001d9fa58f5a4sm2421914plc.48.2024.02.13.11.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 11:06:12 -0800 (PST)
Message-ID: <65cbbda4.170a0220.dad9c.8948@mx.google.com>
Date: Tue, 13 Feb 2024 11:06:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44-51-gdb99ac443b0da
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-lib: 2 runs,
 1 regressions (v5.10.209-cip44-51-gdb99ac443b0da)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Feb 2024 19:06:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14946

cip/linux-5.10.y-cip kselftest-lib: 2 runs, 1 regressions (v5.10.209-cip44-=
51-gdb99ac443b0da)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44-51-gdb99ac443b0da/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44-51-gdb99ac443b0da
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      db99ac443b0da75f00a4fc49e0040ac5dfa47e72 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb1ec32874f6eb5637015

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65cbb1ec32874f6e=
b5637016
        failing since 132 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =20

