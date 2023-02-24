Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783E8C61DA4
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 11:31:39 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web11.15475.1677238289901137945
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Feb 2023 03:31:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=G54yC31L;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.178, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f178.google.com with SMTP id z10so7269296pgr.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Feb 2023 03:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QtCTfvK6EkL2Nf5FxM/c9PoS3c4u5RqYs9mS6jFBDfE=;
        b=G54yC31LBJ9Lj68UutyLPyz/hTgCNb5kAn1gIn5VolqaCyTeKjxN8dFx01JSzZq7Ha
         iC+4w3OPhzvRQT7jE7mH8Lpwex/j5oCB6ezUFpAteTMg/KprpFmEQISUmQhl0txkLrhc
         +lYwmycaXKc6zf/UxhtxxMaJH6Rwhd+ARGLsw6+BDqeTA2M511D06GoAlrmrjlw4UBTG
         pV1zqSaK+jqaUKI/InnZyKxFtS+R3FPyyIxEA0fNzkDtVD+k4sPeCbz7dLPvn6nKEYNh
         c9bWBZaU4bJW4J09hQN7jXrsh5U6wd9MWUn1x7U1gwy6t9btw5oJ5uuF6IMnX9FF9+fm
         vX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QtCTfvK6EkL2Nf5FxM/c9PoS3c4u5RqYs9mS6jFBDfE=;
        b=DgJlAP4jnKshlyMc/y+V3X3teJO7W8HfHDHI2KmhNk+Tv5MdIXkAtwKhzgmKqml07F
         dQylt1SsoC5ZMFWLLRA7A75kWgRwEPEXQPPfm6IUX+jM5uc4iO+/qSBIC/EW13jPNGDg
         qz4aSiMVdRFubKILIIezL5FL1bcLgDajLE/LeADdk1IkTaiKlrN1IwfjVAXgYlI5D24F
         KCj1BsSPjyoqlWgrt5eM6df+8DhBVWcIMUwimgCNjRdxnSEDO3Ou0FVAtq0/IBGcKe9N
         CNm58Qddo260C9k+1wlskYfWUhUgzbGJeJ/e7dAYYR23cDbNy/fosUGXXCW5ln1Rylsw
         Nodg==
X-Gm-Message-State: AO0yUKUOVJYBAixISqF2vRBXsllolVy14ADkmLNC6cw+YUjjJMp9C9iA
	b9I//9s0YWNQwsWmp1QQLzEeG/LO4l56VypyyST7yQ==
X-Google-Smtp-Source: AK7set9jSBJtnZWx678aR/3FgEKkggTY1HSLTvQJVYI9sBu824cE1Z/IWgqSuOlbw30RomIuoKVtag==
X-Received: by 2002:a05:6a00:2995:b0:590:7330:353c with SMTP id cj21-20020a056a00299500b005907330353cmr13466953pfb.6.1677238289154;
        Fri, 24 Feb 2023 03:31:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y6-20020aa78046000000b005df065ebd5esm2361663pfm.209.2023.02.24.03.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 03:31:28 -0800 (PST)
Message-ID: <63f8a010.a70a0220.1f140.4596@mx.google.com>
Date: Fri, 24 Feb 2023 03:31:28 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.168-cip27
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-ipc: 12 runs, 1 regressions (v5.10.168-cip27)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Feb 2023 11:31:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10811

cip/linux-5.10.y-cip ltp-ipc: 12 runs, 1 regressions (v5.10.168-cip27)

Regressions Summary
-------------------

platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.168-cip27/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.168-cip27
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      cc82f737b68c179240070fa34771bcfd0a5fa421

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  86f0584539eb1567f009f3e38be6940830649b92 =



Test Regressions
---------------- =



platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63f88dd2c793a4163b8c8631

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/riscv/defconfig/gcc-10/lab-broonie/ltp-ipc-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/riscv/defconfig/gcc-10/lab-broonie/ltp-ipc-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30217.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/63f88dd2c793a4163b8c86=
32
        new failure (last pass: v5.10.167-cip26-2-g1e87e7748b91) =

 =20

