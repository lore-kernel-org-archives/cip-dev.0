Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B01EE01F8
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 17:40:02 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web11.3477.1694626795145103078
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Sep 2023 10:39:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=oy+CcqFM;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-68a3ced3ec6so23506b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Sep 2023 10:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694626794; x=1695231594; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o0LPTxPOu4fpSvILevI0sDXpUmd3FewdDMP19w52aOQ=;
        b=oy+CcqFM/0TW/Exs4hEpq9gmAQtafmwXaN4gwJB3tn/x5DM4C5LOU9d3chdM+gG6/R
         Y5GO78DQX3YYxJccS04D5e3ajqLd2FRQWFpx+Bs/hHf97JQB3fMyAVQW1OperZV7Zd+Q
         VURiBGViEHH4d4EDt0/cq3YuewV8oPta6GRExlEayuMWlHQoxWzEswr9BD5CYC1yD8i5
         XtHjqArGJ36JaABL9fjLT+D90mkDCoKoYrj4Y0gziYWwSgsE79LFAcBVCnwwaKMlX2vj
         HjDQTsSTg3+Wij0Apguj7nhaR1nMsxJSdeJL95LEXHV18Oi5wof5mPeJGuyf+i9CJjo+
         +z3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694626794; x=1695231594;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0LPTxPOu4fpSvILevI0sDXpUmd3FewdDMP19w52aOQ=;
        b=k+K7w/QU1Y3XENaGKL/NAR5GUw7Ls/cRAydjuxapeE1Tm1gD1W6jo0A0Sme0p9tBZE
         E0QElvKc/qzTnwEl6zB+lvof29oTOQtCVQVLnsJmn/LyXnqsbnBYGXLp/ziHuOuwIckx
         U91mUU70DFFhUoVtIONf5EuHdJkrTk3SrklQRAdlCfBhNE9nPhG1thVxmmyrinmCufms
         Glb0WY7vL4uVTA38P0Ao7ozoD0JUFkZBxYSwhEUDLj6aULhjIMacTG6YdRQcgvEUCg4A
         N1YL0NF5usQ82LP/wSjILlyITFQTGTT+jQ7KPEWgqDvh3CyzOtRPk2v3oUJ48hd+M2I4
         iEFQ==
X-Gm-Message-State: AOJu0YwhVrWZdcDThZPwKkmsnyogVWY9Pwf+BBPL2sp28LY1udS9bvMX
	heeIw/veXl46rypF7fa3t0GLGmBg35PVHQxlkhQ=
X-Google-Smtp-Source: AGHT+IEkQTQqeRaj+/04mibepCQIX5wx51oZwMgtfhS2L7pk88gqxEdRt/6AjKtzPrUzDCcihGw2og==
X-Received: by 2002:a05:6a00:190e:b0:68a:59c6:c0a6 with SMTP id y14-20020a056a00190e00b0068a59c6c0a6mr3435131pfi.24.1694626794022;
        Wed, 13 Sep 2023 10:39:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w15-20020aa7858f000000b00682a27905b9sm9741230pfn.13.2023.09.13.10.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 10:39:53 -0700 (PDT)
Message-ID: <6501f3e9.a70a0220.26561.bf36@mx.google.com>
Date: Wed, 13 Sep 2023 10:39:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.191-cip38-29-g9e1aa2001db8
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-ipc: 4 runs,
 2 regressions (v5.10.191-cip38-29-g9e1aa2001db8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 17:40:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13116

cip/linux-5.10.y-cip ltp-ipc: 4 runs, 2 regressions (v5.10.191-cip38-29-g9e=
1aa2001db8)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 1       =
   =

qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.191-cip38-29-g9e1aa2001db8/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.191-cip38-29-g9e1aa2001db8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      9e1aa2001db862da32812062860b8756cbc8890a

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/6501e391bf1499c7ef8a0a57

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/riscv/defconfig/gcc-10/lab-broonie/ltp-ipc-qemu_smp=
8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/riscv/defconfig/gcc-10/lab-broonie/ltp-ipc-qemu_smp=
8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6501e391bf1499c7ef8a0a=
58
        new failure (last pass: v5.10.191-cip38-17-g8dad6b499cfe5) =

 =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/6501e35f21ad6de7e68a0a9b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/riscv/defconfig/gcc-10/lab-collabora/ltp-ipc-qemu_s=
mp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/riscv/defconfig/gcc-10/lab-collabora/ltp-ipc-qemu_s=
mp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6501e35f21ad6de7e68a0a=
9c
        new failure (last pass: v5.10.191-cip38-17-g8dad6b499cfe5) =

 =20

