Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2771C7EE2D
	for <webhook@archiver.kernel.org>; Thu, 18 May 2023 12:16:36 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web11.15408.1684412192700975737
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 18 May 2023 05:16:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=LhMB0ytr;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.172, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-52cb78647ecso1303217a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 18 May 2023 05:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684412191; x=1687004191;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RdUQOAr+7CwBttys2q6ZXzEx8GT3x3Z1d//gY0m73oc=;
        b=LhMB0ytrpAPVPSrcikroeZakCFuEu+DPtVFlIWUhrn/4COXnrqz1qFmEfbd8z1iuIm
         4v8MLF1W1LK4YN7Bmx8pVSa353XJ9ZVH4z+/CU+9E/4ZaHmXT2rRU87jCtKdln8V7elM
         ju186m9YNaXiH5bjpbuNJ9jNkafKR4yZBJLG0YxsXhV0X6q3EzBy+H4w5GVTX7Uqrvq1
         +AfVcjHAMl5ZvOZh8i8FcaDP7yLBpfxqzACkAZcRGri3+7MLqxJi9bJAkIu0FEdaIbuj
         is1gQNKRTM2U/VnOvSU8PIdBqrNYCHtfAy9wU2L9ivkeHcVeSbfRJgJXqzysY4hMUWm0
         r17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684412191; x=1687004191;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdUQOAr+7CwBttys2q6ZXzEx8GT3x3Z1d//gY0m73oc=;
        b=YVTG6B6Uo2VmawRweZ3YvpoV+i5KZxb3UjRV5F3QNpKq1hz3jQE5co1KqBxXv8sIUR
         5x1q7pHJVrR4rfc6U2HBj4oFr+6TdbfL5wBPrFVxjYRWKZCRTuMz3vwVg8ckCJgpkmBC
         1G5wNORjXA/Zvpi+gdz3hcA23L4GNMpR8/HwV1ENf7BWgKuUich5Q2xhowOnaUeS+/Iq
         MHzDcS8pq1NJvqViZ9LbgDMWwU58mb8YG5SmcMEsHaNhCocZzQ312wsnznM5daSYagvY
         ewtD+pDFHBdtQHHLZiwdDRwc9v+G9+wGvP4W7SD4ULqLEjN7K/p1utmDl9pZh0hLoyf1
         4yjg==
X-Gm-Message-State: AC+VfDwQZciZsrlMwRI17dJK4WLaTz3hGeIWJFL6DLMbayAV6n5OZpbd
	dK/jA+LaX/C07kBFLGb4pelTLxbE0NcAiAFXsK+eJw==
X-Google-Smtp-Source: ACHHUZ7ZFkIEDWC+Q1sU19GbMRR9/iSuxNG23HXY+kcKBTdqH9wDWKUw01MrwUudtAtk5UB7/JMuaQ==
X-Received: by 2002:a17:902:b18c:b0:1ae:5c80:5d61 with SMTP id s12-20020a170902b18c00b001ae5c805d61mr1803456plr.28.1684412191418;
        Thu, 18 May 2023 05:16:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ja19-20020a170902efd300b001a6ff7bd4d9sm1316852plb.15.2023.05.18.05.16.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 05:16:30 -0700 (PDT)
Message-ID: <6466171e.170a0220.5d5c8.1d4a@mx.google.com>
Date: Thu, 18 May 2023 05:16:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.179-cip32-471-g18129e1b68691
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 14 runs,
 1 regressions (v5.10.179-cip32-471-g18129e1b68691)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 May 2023 12:16:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11520

cip-gitlab/ci/pavel/linux-test ltp-ipc: 14 runs, 1 regressions (v5.10.179-c=
ip32-471-g18129e1b68691)

Regressions Summary
-------------------

platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.179-cip32-471-g18129e1b68691/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.179-cip32-471-g18129e1b68691
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      18129e1b6869127ae39e5978bb2fe70ecd53f174

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/646607f1b28561c9802e8654

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/riscv/defconfig/gcc-10/lab-broonie/ltp-=
ipc-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/riscv/defconfig/gcc-10/lab-broonie/ltp-=
ipc-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30512.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/646607f1b28561c9802e86=
55
        new failure (last pass: v5.10.179-cip32-4-g580ea5dd85ae) =

 =20

