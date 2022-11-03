Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934EFC4332F
	for <webhook@archiver.kernel.org>; Thu,  3 Nov 2022 10:33:51 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web10.17661.1667471626315457190
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 03 Nov 2022 03:33:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=pzY+XDKi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id q71so1278610pgq.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 03 Nov 2022 03:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Mu/rWyC9tBxms+LEFZ4fKxrs4cAnfw/oHVgiADh+JnU=;
        b=pzY+XDKio+aufrRUqGe4iY8CUltmkxk2hGNszdFLZ4g5XNZLQAyQwl+8ppayJBYdL/
         TobqmPJVFgplKcMZoWKTpkurxg6zOeHMU7hTaVf1W710US1O6K8ANIXI9LZ5xVogx7SA
         03PIKy7IyAJYnzrOmfLCUdTWTu3pjM2eSkqSJA87VVxirf85mZJKHF6VIi8oU/CXs9s9
         v46FW+s/LoPqyigh/Y/bX+B9CUVXDoligbvRGzwZ2bqGL+hVlZcSkgRu4wjD8mmLJDUQ
         iBY5GmrZ599rnaVKBSWgSmEXiNF4IEbg5OnCop1br/7BqBLbF1WW+R35b3djflgvOfre
         9UPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mu/rWyC9tBxms+LEFZ4fKxrs4cAnfw/oHVgiADh+JnU=;
        b=UUgu0bnMQnoUIRZaTuZbtu4WrI4Sr3+r3ereEFIKuk+bSU6DDgyToiv5mxXfjRRKY1
         unJi1QLmyYVojf1add/GhTbyjimZcJfadtMIAUyAJkpteXXVgOZ1yHKINRj0NFbOfmbD
         xDvzhV/p0Gt42fvZ3GWKgq6lHKIV6YYFs+pNuLgs6DwBn9cKjQr/AKlEQMyugwjX5D6F
         uEoMVTz988Tzfs3QXKU8Lr0FvusoaYiENd9+vdJmKd7xIXLuZEd6oBEsKnfIkuxJXON1
         Mo12e+/w0XdeClvLr+qgicn51z217bz/kiOnHs/ZJH0SfWgVWMn4IbXESg3RO4y7cvwO
         vUpg==
X-Gm-Message-State: ACrzQf2DgXUx9sX5Bzd+BYt1fl9kzU8XYLwx/IavGkDofQOmLWo/1b2n
	CPi2yFyE5mH43F7XkO3ZL2rIGj6JCogKYbyN
X-Google-Smtp-Source: AMsMyM6lZ7mkauJ7D+NqYl8vBOU4loxQXIcE4H56t1+fL9JNB+X3zH4n3C+Df38Z900XnoLHyeMAUA==
X-Received: by 2002:a63:fc0b:0:b0:46f:87a8:97aa with SMTP id j11-20020a63fc0b000000b0046f87a897aamr23935017pgi.234.1667471625668;
        Thu, 03 Nov 2022 03:33:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o187-20020a62cdc4000000b0056bb0357f5bsm393096pfg.192.2022.11.03.03.33.45
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 03:33:45 -0700 (PDT)
Message-ID: <63639909.620a0220.c9da1.077e@mx.google.com>
Date: Thu, 03 Nov 2022 03:33:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-12-gcb2b164780be
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test smc: 9 runs,
 1 regressions (v5.10.147-cip18-12-gcb2b164780be)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Nov 2022 10:33:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9910

cip-gitlab/ci/pavel/linux-test smc: 9 runs, 1 regressions (v5.10.147-cip18-=
12-gcb2b164780be)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.147-cip18-12-gcb2b164780be/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.147-cip18-12-gcb2b164780be
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      cb2b164780beff6c4be7ccfd9020e39c07c44f3c =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/63638a32c5c7eefe6be7db57

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-broonie/smc-qe=
mu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-broonie/smc-qe=
mu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/63638a32c5c7eefe6be7db58
        failing since 176 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a) =

 =20

