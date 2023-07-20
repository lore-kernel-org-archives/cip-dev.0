Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF047C001DC
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 16:45:19 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.2140.1689871513152332428
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Jul 2023 09:45:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=0XwFZzLf;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1bb119be881so7261225ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Jul 2023 09:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689871512; x=1690476312;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nwbIW90MPabge7ztXXDru5f0d43EPnEa3dI2QfsaFYE=;
        b=0XwFZzLflPbIk38jF0N8LHvI/BuyQBU+wHuzkZKD6p2Bva50X6els6sXq4jUTFLHuB
         OGyO2FesPDdOfqDJV5JfZn/iKnRO0hUG8Yn5bXXBNu8O3Fs75JsZwpeZyvptq7WJ/gRK
         cPVC4HbghYp5aD2wbTsy0bvjstq+FurP7fWmbnt845T8/B40mukgqFVe0e0QiE6/NDus
         LeX4pQauDifSm5lPnBkCeE3x0q0vrqwNqHc+HPAWaXYsQuSMkCmAlOj2QlLF0pxN41F3
         orXJxjXRKPAJiHWO9u6h16z3Dp0gpIFyWmyek4oewZtsUcWHmrq3bNfkU2nR/y6How5u
         9Rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689871512; x=1690476312;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nwbIW90MPabge7ztXXDru5f0d43EPnEa3dI2QfsaFYE=;
        b=DOk2AzIh8GtyGFnlEay1E7qVvVpTtXyUUJmOIk/A+kWxXBRmyAc72HON8bnKMEwxYu
         OdLnUgw09CffJNsmoTVseF5SjTHO+btiqu9af7d96dZP4GK2f6fX1vtKW7/x+ydZc1oc
         GY/44KybdgLICPBs/17ppUbFr5HcwunlF5DfHOUzS7bk6gpLPqJRz3EZsRRGwkznR6nv
         gEQlLa4H4RZPnl+C/0wN5FRpBoovHcquqXBbhXZmJ6LG+PDXjzU97+WCSfrIUFeOk2o+
         RRbchpjqVq+rU/eOw1DXnzHLMeHxy8IBQDyysV8fwOKOc0xiakkktCXVxwCNhiXDe7d7
         6eIg==
X-Gm-Message-State: ABy/qLatuMniBe3ISUajkVNvMCD587hdDxp8hHOrl233b3hnMqYxPYgP
	B9jkDX9fqdHMATi13FtQgfjzOfNvAuXoRliPyLKn9w==
X-Google-Smtp-Source: APBJJlGVLCRvmEyux4fZtkjyTXQ2xzOQHp4jhD4tExmC5EzHSAIRXfNE+BEdRyNKmRgzNuIHx8IWOw==
X-Received: by 2002:a17:902:d38d:b0:1b8:53b5:8518 with SMTP id e13-20020a170902d38d00b001b853b58518mr2793459pld.63.1689871512033;
        Thu, 20 Jul 2023 09:45:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902820d00b001b896686c78sm1620026pln.66.2023.07.20.09.45.08
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 09:45:09 -0700 (PDT)
Message-ID: <64b96495.170a0220.32628.2d5d@mx.google.com>
Date: Thu, 20 Jul 2023 09:45:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.186-cip37-12-gf8c9ce666de7b
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 4 runs,
 1 regressions (v5.10.186-cip37-12-gf8c9ce666de7b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 16:45:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12481

cip-gitlab/ci/pavel/linux-test ltp-ipc: 4 runs, 1 regressions (v5.10.186-ci=
p37-12-gf8c9ce666de7b)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.186-cip37-12-gf8c9ce666de7b/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.186-cip37-12-gf8c9ce666de7b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f8c9ce666de7b69f842e25063054c803ff45d06d

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


  Details:     https://kernelci.org/test/plan/id/64b941be5eb3d301c38ace22

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/riscv/defconfig/gcc-10/lab-collabora/ltp=
-ipc-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/riscv/defconfig/gcc-10/lab-collabora/ltp=
-ipc-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/64b941be5eb3d301c38ace=
23
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc) =

 =20

