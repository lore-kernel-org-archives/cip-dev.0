Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E26C10F13
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 16:15:49 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web10.26658.1702570546935321779
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Dec 2023 08:15:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ZBTJziuc;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-28b06be7cf6so591959a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 14 Dec 2023 08:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702570546; x=1703175346; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=86JLw9PCI2ZTujerd0lGbfrwT12NQ6O1/BpziDT8CNw=;
        b=ZBTJziucqIkdNfEnCkDNgvp177PJ5kwkz6RbquOWEeStI17yTnf1gb+ZFpAfNPHWcz
         r3fQGJaqm+OGL+jXaHx1ZZBaZw0sbYC5Y6StmsV5WZ90BPy8TC4ws8zYbWt0G39pnskf
         nCr16luR2sLKtNx6UdvD0Juu0aXC10nFwz7I7ab3XOltEsWPzZT22KbU6/39zAVLocP8
         lvpURIQxe5Vz2ClypMJP9mhH2JUGrabszqkpICybcLPUg0mgQTd3zK9UUnHv6/PZrelL
         QTfvTqpbh8g4RmrZYwWVNtQS2+3jx5B7CvhU0RWRQlKsUBHNkKzfpZsBeLGDsRFk3gip
         hryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570546; x=1703175346;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=86JLw9PCI2ZTujerd0lGbfrwT12NQ6O1/BpziDT8CNw=;
        b=JIV3NoA3+FuWHkBl4gTbCb3osD0S7vPuigZQURr/6BDIJP09W8UDgZNwIOjhTLH4OD
         AvQbwtvTjJKAWUxeJrcXrS2EzKLiqhQH9jeUB7DD2EPXo3Vs/GYRSnHGkdcA7XWJBgQa
         aM13C7IYHwiJkadqkZi9Ap2L5GJCGDI1hGVtxOmCx1x4oXQjuskns0PICLli2oYHYyWk
         h7tXrwHFWVd6+JDq9PeKOYGLzWi5k7Xu8H2AMp2e3sM+TN9nvKfiF3PLlxPkKSFis7GA
         hc457loxog5NXJYUEo4Qc+28xRbQR5sfKW0JKDsfihygUlxrBhtR9XRNyJd/la5Bw88t
         B0yA==
X-Gm-Message-State: AOJu0Yx4kXZgDQQgHSi+atNUcYVS4OkmobiXjieL+l0X/I893zFhNWUa
	7BNPaJXILWj0UY5mA8Uc1n/cHkEtlk8FT3VCTyU=
X-Google-Smtp-Source: AGHT+IGayeelQPhkXzGq3mwAuE/cnsWje/zq7hVR091CkTOsAIcQmc4NWeaRTVb2jg6nU2NrLnbTrw==
X-Received: by 2002:a17:902:e747:b0:1d3:4162:17f3 with SMTP id p7-20020a170902e74700b001d3416217f3mr3478178plf.50.1702570545902;
        Thu, 14 Dec 2023 08:15:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l9-20020a170903120900b001ca86a9caccsm6742354plh.228.2023.12.14.08.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:15:41 -0800 (PST)
Message-ID: <657b2a2d.170a0220.6732d.6d6c@mx.google.com>
Date: Thu, 14 Dec 2023 08:15:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-69-g8f7b450fc28ed
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 2 runs,
 1 regressions (v5.10.201-cip41-69-g8f7b450fc28ed)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 16:15:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14119

cip/linux-5.10.y-cip kselftest-seccomp: 2 runs, 1 regressions (v5.10.201-ci=
p41-69-g8f7b450fc28ed)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-69-g8f7b450fc28ed/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-69-g8f7b450fc28ed
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8f7b450fc28ed99196853536c98ae36c2567e160 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657b19df8f1d74df70e13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-seccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/657b19df8f1d=
74df70e13476
        failing since 71 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

