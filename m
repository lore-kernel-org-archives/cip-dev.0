Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCB1EE49A3
	for <webhook@archiver.kernel.org>; Tue, 22 Aug 2023 13:19:48 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web10.7767.1692710383165752540
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 22 Aug 2023 06:19:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=KZzmTJQi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-68a6cd7c6a6so614737b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 22 Aug 2023 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692710382; x=1693315182;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0b6qgj1vskRnlH/7O7Uati38x402CgzxpcgsVrTfJtU=;
        b=KZzmTJQi0ZS66fR525jhmJN14ozK/xez9jzmJkAh7Vhzo2EYRIH+AkznK5rYdahz+d
         k4F6xGf/qXj03sLf72BTWfz3LqKiOCZXHmmZzE4TP1Mi8z0FU69X7rG3lVSZ3OA/0jJP
         j6LZ3AGwW0qlf8lVWRBkqgSgbMKu5H59ZhejKj/M9BLOjyBH1J3IiHED73KsyffHILJZ
         jg/asi3jmJp9GAzo0D0WNvGy+Qf+j7+J5t0eG4iiE1cKczufKx+nFcK7Us8rsnGA/Th5
         HkXJmwBYZYUaud8LGb9USQkYWnjD/TSM7WjqmLx+DXiWRzXGFLT7oBiZ/Wb/5r2/xHnb
         hh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692710382; x=1693315182;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0b6qgj1vskRnlH/7O7Uati38x402CgzxpcgsVrTfJtU=;
        b=SzeaH2n4lowUbaX94i3ObmUhbcHQoOoDDKgOaX9t4BCgqTUrmq4A9oJfFUAnGmLdfM
         EEiU1Tab3Xw2d7rqLmy7krUC4mqCWabHsR29twBclR+asSO/msPANyA6dWlL9JsRYez+
         /HaoyDOo6KZEc/sh8ko3Ecc49hLGIM9FXrd6KlaLTfQkarWeddVX2yw/xR9sFrxolx0R
         1vXa+SXu+9hQCnQRwQ6KF8cNxEd8j5LWcO8cQTKsBlyU8rQmRAT4mvurfXxkFCUPapBJ
         G2rFeEwJ4PqoIN+U9p0YYbaLd5w/ln7U99iMdpaLd2NjUIdElrWJq1av01bDDhWJgUE5
         zuGg==
X-Gm-Message-State: AOJu0YwKz67vTy9bITOzIxiHHr3aib5nxU3X//PL/IQ8o4ZrzZMKlGLy
	nl8IGqIKfsjl8/yJ8LkVtv/0EnTf+/glGI0z9pyO/w==
X-Google-Smtp-Source: AGHT+IFlQLNSYUGoEjGX6apq7+Wbm6Sd/SBgxBFqyEGWq6/uWI/Uo7kgIFH0CbOQKyW32B9kT3F+2Q==
X-Received: by 2002:a05:6a20:551f:b0:149:f82a:2640 with SMTP id ko31-20020a056a20551f00b00149f82a2640mr31461pzb.30.1692710382201;
        Tue, 22 Aug 2023 06:19:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b3-20020aa78103000000b0065438394fa4sm8002104pfi.90.2023.08.22.06.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 06:19:39 -0700 (PDT)
Message-ID: <64e4b5eb.a70a0220.dfea6.eedd@mx.google.com>
Date: Tue, 22 Aug 2023 06:19:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-27-gd6d928db0a620
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip ltp-timers: 8 runs,
 2 regressions (v5.10.186-cip37-27-gd6d928db0a620)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Aug 2023 13:19:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12826

cip/linux-5.10.y-cip ltp-timers: 8 runs, 2 regressions (v5.10.186-cip37-27-=
gd6d928db0a620)

Regressions Summary
-------------------

platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.186-cip37-27-gd6d928db0a620/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.186-cip37-27-gd6d928db0a620
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d6d928db0a620394e433833b5dda4ec7ac822999

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64e4a440000391abb1b1e3b0

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu=
_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu=
_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64e4a440000=
391abb1b1e3b5
        failing since 32 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-11-g2b3c22dc0633) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64e4a440000=
391abb1b1e3b5
        failing since 32 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-11-g2b3c22dc0633) =

 =20

