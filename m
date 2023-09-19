Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3691CE79AA
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 15:55:38 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web10.13229.1695138935817976513
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 19 Sep 2023 08:55:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=zj1Fez/E;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-690bd8f89baso1135909b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 19 Sep 2023 08:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695138935; x=1695743735; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cObHinaxfU+jnmim5Nq8GcUsQq/w2WEX1jmQU98sMrM=;
        b=zj1Fez/E1DfpbRuIcxWu90iltdcvveFO/tC6UuGoER9z073qlUk8yCM95dDIFLmint
         U8Yt8OTZQmt6sE2uq1I5eQENUstUHu/SUAyWXxOd0LRSveFLqA1+34MYseoxdOear0J1
         TzCCGTxrGQfY8bkJQv9pcUQQdHvZFNFhGUdoF7X7U3KJdAzaFud6LnwrDOmXMm2PjD5K
         TKSPIIxAIZmXT8BOr6BxbP3aLK6DwPD5IuHQMjqxbgEMgWBbchinA6psPLke+2hAfNSz
         pFDaT7dvIXxTyzNCmzBfB43WO4NYXXrfqTjnQ2kenmYXZHXbVftRXpEsEfqbRbQl0P99
         +rMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695138935; x=1695743735;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cObHinaxfU+jnmim5Nq8GcUsQq/w2WEX1jmQU98sMrM=;
        b=LAkf1+y1O8/z8O5euAVlICZjBF5SfCuWgv2Z+Pl/uBdQPAYzwxhVUp4s+tmp5P1xa4
         Stid9UONCTs2rNKlwQJtvJpGTZn2sGaRqeUNmyTY6ji6IyMWU/xJDUBYxWkmP/sN/24g
         mJvlHltTlfwy+DgO4ak/XpXH7NMT9xqCWHy5WH7ul+DlzErCbJG4zAbr7DK/rKk0gFsF
         wczKHtE1n8g6+OCIQCr19kdUwsv+h8XmGZybD9KOAmmFyqb4pfNUsvVe8s3JhGn5Tb//
         rFYscmi+M1h8QUpxmq+dZ5XHKp3SIDIL42JXMifpEwzdf2id9r6IfPZ0EXFB0PW9/OrI
         OjGA==
X-Gm-Message-State: AOJu0YztJB517E4XvCkdQb3EsRwxvNsRKvB57kCLAi+MpAqeJ5p7n5UN
	2bMzUU2oe1DaejHJm+pS2rSSf1bllpu3houE/w73NA==
X-Google-Smtp-Source: AGHT+IEtIYSgAuvFNBlh7K0sVJx9VIFX3TC5Fgg9QdXFgmQqv9Rfq3ljiM/RBCTBuUS6E0mSydWdPg==
X-Received: by 2002:a05:6a00:15cf:b0:690:c701:e0ed with SMTP id o15-20020a056a0015cf00b00690c701e0edmr144879pfu.0.1695138934659;
        Tue, 19 Sep 2023 08:55:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g7-20020aa78187000000b0068fc9025a08sm8823894pfi.151.2023.09.19.08.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 08:55:34 -0700 (PDT)
Message-ID: <6509c476.a70a0220.1a5cd.e8d7@mx.google.com>
Date: Tue, 19 Sep 2023 08:55:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.194-cip39
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-fcntl-locktests: 5 runs,
 1 regressions (v5.10.194-cip39)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 15:55:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13158

cip/linux-5.10.y-cip ltp-fcntl-locktests: 5 runs, 1 regressions (v5.10.194-=
cip39)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.194-cip39/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.194-cip39
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      ecda23c2ad8c5eae1f19054d0b67a7904546b7f4

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
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/6509b614eb771f995e8a0a78

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/riscv/defconfig/gcc-10/lab-collabora/ltp-fcntl-locktests-qemu_smp8_r=
iscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/riscv/defconfig/gcc-10/lab-collabora/ltp-fcntl-locktests-qemu_smp8_r=
iscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6509b614eb=
771f995e8a0a79
        new failure (last pass: v5.10.191-cip38-29-g9e1aa2001db8) =

 =20

