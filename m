Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9868DC48299
	for <webhook@archiver.kernel.org>; Sun,  4 Feb 2024 05:10:36 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web10.33401.1707023427350126143
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 03 Feb 2024 21:10:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=nAGWPhBe;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.182, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-53fa455cd94so2542364a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 03 Feb 2024 21:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707023426; x=1707628226; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KyAZtwg5Z1gd97+9D4CcCrtE6diJatLC7QPvfty9ZxE=;
        b=nAGWPhBeRb8fxi2C5Er2PtypbFbnCSfOBNH30p1SkLpOl1iKZ+sOwwlcoX4DMDgklt
         7Cs1+hDRzB5wHG15FALAigFFIP9cQ0Idmr3JzGSmEAPA7j+A4NN+w5+aTfzuz0k9WzuV
         DvPMXAjkTZES4taUZYxVzILTqPwPihJ6ZeYtGR42Odn0kNi3cqprFefagUIWPfu7AxSE
         rtD1yoFbKigkO7osQxS3P2jL8CZbYVasE4bwCBViaS6fGOZF18Xz6QrmL7bWUhwCOgQI
         a3u7Pj+5Pd/5BQbGy7O5ciA2oYTy/S4rhKGFhQ9Sp0s/wJ8ZVsoVftKwtXZanN7ihSpF
         4HxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707023426; x=1707628226;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KyAZtwg5Z1gd97+9D4CcCrtE6diJatLC7QPvfty9ZxE=;
        b=V1UW2yvkZVYcj8/Ew9RZY64gQuu4LxVgzd3cqZmKQJnKmTU1yBFDNg8HdkpZUQ5lJn
         GVnCQTPl4EIUyGm3zie2U2gFeFe6yX4I/OK59W09buykoGH4TXV104gqFR8wyYci8r/a
         u48p3Qq53MCeDLeq6hb4e34sRQCwVNSRs6GRB6ascQKt8tIP1XpYHc19jIdYUL4YfIXg
         PZZ5qn8yKA9uIcTa+gtl+4/X4770q81i9FS5DZqJUddse1wO4WXk+LES2jB4jEryYX5j
         SuYjAwslXWlbv11s7XIuLU/jnBLwWiu4cLYK2IT4bvwjxkmBtb5bslE5aGYZfoGLXJQx
         PUkw==
X-Gm-Message-State: AOJu0Yy9bwolwCwPeGWpXPJEYr4LvaichoCXN2GMa+x7e853t1tEViZb
	flhN8oEZLM/k0LM0irmwNa8maWnQX+Fj+xjjTN6H/GS+jF6Fdkd7QGwD5JiZctju/6ZtlmxrdJ3
	Clc4=
X-Google-Smtp-Source: AGHT+IEGa1jc1mt8kBTNGGHR3V+eGlBWKaWtxgRsiml5XoSQeqegpUOHaQ/9OOpcoRvcTwpVuzyodg==
X-Received: by 2002:a17:902:e807:b0:1d7:6d49:c78a with SMTP id u7-20020a170902e80700b001d76d49c78amr14955282plg.58.1707023426162;
        Sat, 03 Feb 2024 21:10:26 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ke15-20020a170903340f00b001d96fce5505sm3770130plb.163.2024.02.03.21.10.25
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 21:10:25 -0800 (PST)
Message-ID: <65bf1c41.170a0220.da0f.c6f5@mx.google.com>
Date: Sat, 03 Feb 2024 21:10:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.75-cip14-132-g6e54756fbd6c2
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 9 runs,
 6 regressions (v6.1.75-cip14-132-g6e54756fbd6c2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 04 Feb 2024 05:10:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14645

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 9 runs, 6 regressions (v6.=
1.75-cip14-132-g6e54756fbd6c2)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig         | 1          =

beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig         | 1          =

beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.75-cip14-132-g6e54756fbd6c2/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.75-cip14-132-g6e54756fbd6c2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6e54756fbd6c2a85eb65a7be04700955d2e49b68 =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf122e53d2f4bac200a03b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65bf122e53d2f=
4bac200a03c
        failing since 503 days (last pass: v4.4-st20-229-gb433f12afe250, fi=
rst fail: v4.4-st20-231-g7349cef09ddd2) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf168f28cef9839800a0a3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm/multi_v7_defconfig/gcc-10/lab-cip/bas=
eline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm/multi_v7_defconfig/gcc-10/lab-cip/bas=
eline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65bf168f28cef=
9839800a0a4
        failing since 503 days (last pass: v4.4-st20-229-gb433f12afe250, fi=
rst fail: v4.4-st20-231-g7349cef09ddd2) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf131c7fa6d6288000a03a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm/omap2plus_defconfig/gcc-10/lab-brooni=
e/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm/omap2plus_defconfig/gcc-10/lab-brooni=
e/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65bf131c7fa6d=
6288000a03b
        failing since 75 days (last pass: v4.4-st20-231-g7349cef09ddd2, fir=
st fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf12fce3639d3f3800a04e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig/gcc-10/lab-cip/baseline-c=
ip-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig/gcc-10/lab-cip/baseline-c=
ip-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65bf12fce3639=
d3f3800a04f
        failing since 516 days (last pass: v5.10.131-cip13-84-g5fcbe4a63ab4=
d, first fail: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf117964cf6e0a4200a078

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig/gcc-10/lab-cip/baseline-c=
ip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig/gcc-10/lab-cip/baseline-c=
ip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65bf117964cf6=
e0a4200a079
        failing since 75 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543e=
, first fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf17194ed1cf12c800a0d3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-cip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-cip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65bf17194ed1c=
f12c800a0d4
        failing since 72 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543e=
, first fail: v6.1.62-cip9-13-g34c303883a305) =

 =20

