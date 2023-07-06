Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065E9EB64DC
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 04:30:18 +0000 (UTC)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
 by mx.groups.io with SMTP id smtpd.web11.14574.1688617809687723548
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 05 Jul 2023 21:30:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=LErsLS6f;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.172, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-38e04d1b2b4so341785b6e.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 05 Jul 2023 21:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688617808; x=1691209808;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m4/Ol1AnQWsf9sgtHBU0CuYBUOpG+pVAjcc62ySHQcw=;
        b=LErsLS6f3+OA3uBkicFoMk3cwNqJq0mXg+SO87BbGHHnUcyP8E3mx6IBQRbDOME9Mo
         bXI+wphE4TCM0SsEm6r3dBR/BZviEZzFX2e8eRp1N6ChJRT+rHOCOWnSRDbOVa7NhRhY
         /pQjCJUFMX0yXd5Tuu6m1ZE1VRjrrqU7JDJCuL7s0ySQ2E/B87FKZYA7STmcUKlrqboX
         Xb6MSpPMIt/0sRanDZlbH4FaUqt8CM4CYIe6k1YD9XbRNzjGLr5dJuyMkR7Zeegepxy0
         x9Ovry9+9RSZPcRYGvwgoTEyCKY87PcASQ08n9ivXYsPobxy8pDeFvvRy9+1rbJ22lC7
         3yAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688617808; x=1691209808;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4/Ol1AnQWsf9sgtHBU0CuYBUOpG+pVAjcc62ySHQcw=;
        b=hXvyCAZRPVoTFBEEOuyaJ1Nt31VSUK76GV1w52qq1JTH9ZCn0yDxLRcbRmKdyB4q9K
         Cj4Z/brc1+W7C6C0bcSQY7Lz/Rr9sU+mmB4qP40N+a00LzlmEKmIw7OVjueLbH0Wdlyh
         4MNXp+ueYTltPPEE8Aar/7iWhOAhEJmJVNi71mCZEoMVfVLHHsB5UYex2wYE2z0Ca6K7
         /0R8I0/yhcOnooBSG/R70HhDQfDSlisqt30iCXXmJJdkAcYF26GVzg0cM6GdYGDt9yiI
         BrzBX2pTCE0Qs3mbbDgghAw+pKgGeVP3jE7GgVumwSaVQVH7H3IBbQsBlyVgUq7qW2dn
         WZ3A==
X-Gm-Message-State: ABy/qLaVDFJKEECepGRqg2Az3H496rAXZSQ2nFlksFY/0XgvxBpmZv/H
	j+wO5V3iRhpmNcDMjpCFh+ImdyDwKulYn24dTk39GQ==
X-Google-Smtp-Source: APBJJlHnGO+eDE3TZxLQB0cCmXY7HXq/eRlp0cJHjPocj8nVvO/caCNvnzdR4atjLOWu7T4seMTApQ==
X-Received: by 2002:a05:6808:d51:b0:398:f84:2862 with SMTP id w17-20020a0568080d5100b003980f842862mr580220oik.52.1688617808252;
        Wed, 05 Jul 2023 21:30:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b11-20020a63930b000000b0055bc3b97f34sm362065pge.19.2023.07.05.21.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 21:30:07 -0700 (PDT)
Message-ID: <64a6434f.630a0220.cbcd6.0f06@mx.google.com>
Date: Wed, 05 Jul 2023 21:30:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.184-cip36-8-gb192df20e8c9
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip ltp-timers: 6 runs,
 4 regressions (v5.10.184-cip36-8-gb192df20e8c9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jul 2023 04:30:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12248

cip/linux-5.10.y-cip ltp-timers: 6 runs, 4 regressions (v5.10.184-cip36-8-g=
b192df20e8c9)

Regressions Summary
-------------------

platform     | arch  | lab           | compiler | defconfig | regressions
-------------+-------+---------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 2          =

qemu_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.184-cip36-8-gb192df20e8c9/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.184-cip36-8-gb192df20e8c9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      b192df20e8c9dda03e005d4cb4909d846ea437bb

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform     | arch  | lab           | compiler | defconfig | regressions
-------------+-------+---------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64a6398274b9c56623bb2a82

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_r=
iscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_r=
iscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64a6398274b=
9c56623bb2a87
        new failure (last pass: v5.10.184-cip36) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64a6398274b=
9c56623bb2a87
        new failure (last pass: v5.10.184-cip36) =

 =



platform     | arch  | lab           | compiler | defconfig | regressions
-------------+-------+---------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64a633a11ec707bb33bb2aaf

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu=
_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu=
_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64a633a11ec=
707bb33bb2ab4
        new failure (last pass: v5.10.184-cip36)

    2023-07-06T03:22:57.222409  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64a633a11ec=
707bb33bb2ab4
        new failure (last pass: v5.10.184-cip36)

    2023-07-06T03:22:57.222409  =

   =

 =20

