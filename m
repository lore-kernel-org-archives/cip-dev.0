Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC95C10DCE
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 21:13:10 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web10.104220.1701983583617011070
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 13:13:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=GHF3Gaug;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6cec976b197so336548b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 13:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701983582; x=1702588382; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ru76MOlvWKkQx7GnUDUT17SNeKZeeDUXKoogwRRy8IA=;
        b=GHF3GaugsIspZlzRi6daPer85/sthlFKl2XdD9tdFf4qX+1jsyTVbCrUdG1MjAIZGT
         50ULOdWQQSTfwLsplI8O92GC6U8XrjIoOgI3s7vzJ0mHjV6Y1wHQQ5VI/TcparD/d4oU
         dinyNBqTOtpGCQDjxVTgsxwsFU0pmnIg7SjWtd8v8VIchtUQ/g6q+yKrM3i4i/ltFVaE
         VL9+N509bNyPjQ1Hg3Uk+HPlYvJ5gEPuLOODJZCUullm+YNqLmAT1OhBHOk37Ckn3Ufu
         V3YMnwGm66bX7ZJenDjd0R99nDpHnwufxFSXra06+aIi8qlEx1ucEQPiZ0LTqvQF+3vA
         r9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701983582; x=1702588382;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ru76MOlvWKkQx7GnUDUT17SNeKZeeDUXKoogwRRy8IA=;
        b=c7ZiUfiWauja4NJbGQDM1CflPMrgG0aoTImv2s4M88Tmdga2Gi5doxUMzJ/0JUBjXc
         An7VfZsMjw/2AWwra7RbHKyZlyWd+0QpT9NyMr9p2EIOJd+68lqR41PvB90huhl1764M
         YYyDFnrEMEYAmeqbAc+hEGYG90IBLFkA1LMRrApTrb/0np3tcZ6KxDGeDbo4pi3PBz3i
         5zo+Qt50QlVnkqjJAIEprkCZAzpDZcgeDfm6XKkSorbZCdqv2Z9kU9B93EsjBGiJti0k
         OEv+nY/kxKpWrGsxlgQmIhz9DkmTJV5qWEKJP89Ijs5UJavKzRpUghB1zrdo519zDDxi
         WWaQ==
X-Gm-Message-State: AOJu0YzzdMDRdT/DV/SXcPB4zzdYxt3Y5oGO74P/0oKUgzficCiQkLkR
	yF8FThtQU7Yyix3QNVjxeB85D9nWMVsxY5/6s7CrZw==
X-Google-Smtp-Source: AGHT+IFN8fOHRLbSNdg5H4lbHnW0GWTd4tPAL3k8a8GEwJJ4LX9hhWUrhLdXG0i+vfAWvmZ6pdKinA==
X-Received: by 2002:a05:6a00:8d93:b0:6ce:7ef2:40b2 with SMTP id im19-20020a056a008d9300b006ce7ef240b2mr2891177pfb.24.1701983582500;
        Thu, 07 Dec 2023 13:13:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id kr5-20020a056a004b4500b006ce83da3076sm227190pfb.170.2023.12.07.13.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:13:01 -0800 (PST)
Message-ID: <6572355d.050a0220.ebaaa.15c9@mx.google.com>
Date: Thu, 07 Dec 2023 13:13:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-28-ga386bc478aa6b
Subject: cip/linux-5.10.y-cip kselftest-futex: 9 runs,
 1 regressions (v5.10.201-cip41-28-ga386bc478aa6b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 21:13:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13911

cip/linux-5.10.y-cip kselftest-futex: 9 runs, 1 regressions (v5.10.201-cip4=
1-28-ga386bc478aa6b)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-28-ga386bc478aa6b/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-28-ga386bc478aa6b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a386bc478aa6b422e6dd5d92a540987ddfca9397 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657227b8b19bdb6eaae13479

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-cip/kselftest-futex-r8a=
774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-cip/kselftest-futex-r8a=
774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/657227b8b19bdb=
6eaae1347a
        failing since 13 days (last pass: v5.10.200-cip40, first fail: v5.1=
0.201-cip41-11-ga539098fe70dd) =

 =20

