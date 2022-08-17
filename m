Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98703C3F6B0
	for <webhook@archiver.kernel.org>; Wed, 17 Aug 2022 00:42:51 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web10.23265.1660696967281967070
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 Aug 2022 17:42:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=M52/0wQv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id u22so2414645plq.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 Aug 2022 17:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=wJG5ri53kbyPOKFXvvN9GWd18vO7Lw452X0y4yF5Qkw=;
        b=M52/0wQvYRxRQEMLMk/1Qd5u3R1yD+b0ZAaxm+WrYSD/im6TWMJZwi4KHwYNKQqO2B
         BRKbI4jHD+bYreRnWMGICNXfM94CYAG+5Q7YsBlHWyTTpEJD1zF4P0/khXbLGQQCR0xi
         n56UB4s/vY1JIY8avQNh++jTqmBmJ7c+QgAOSket81pKI2Ha6bMzh9bIhH+Hb530QFFv
         a5VzAcRMS7JmWFpBHNpDD9II7swyXKcwEFVI4E7EMP83BapmzeGXR8anrMNXaAT64mt0
         jgYrec41uTfIH4XKlfm6R9qIDtw9psdvHQK4xcMDKp4AEb9kZL9D/k3bF4VmiHEkwOsl
         15BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=wJG5ri53kbyPOKFXvvN9GWd18vO7Lw452X0y4yF5Qkw=;
        b=n7rFJn2nKcsKwTEvm+B+QsctbRvKrKHLBsK603BObfxAyMjY+XTgTTKkJLhpzclATY
         EB8sZ0CUAuhQ4dWEHlBptepWyH47biqVNf1ZhRlMQy22kL+w9ErrvB6+hvpNm5ogZzHp
         ADpSvkqI+lGJQYexlOmMh8mYQzpZklCNqzwuMzcUVG3bAJETOUA3ULXxQjco0DPDSpE6
         6Ii5TtQZ5Ky6BycwSfu5oRctLXAHrtAPVQgHQ73dUaE7PPcLY0Th5F34gI8u7YhP9DoP
         OKTLZj3fRLKU0tAiGrb7TOmSa+6SAi4Xpam7ncf62IEGJb8w8vakuej+mUDyh0q65tks
         pQ2w==
X-Gm-Message-State: ACgBeo2xAT3/x1EMFA4cUfS5U66YNaQXfRgjoaXjmzbsMxOayzD9JEok
	dUEBhhlBjY5m6rxuTaRWvRwWTOSi4T3Nz44R
X-Google-Smtp-Source: 
 AA6agR6Ft0JPT24M8oi0FGOpn9vC19uGFrIi5c9CuKF6Flm1MGM41WWib+PtLgYJ+GXDB6sWXR0yxw==
X-Received: by 2002:a17:90a:8548:b0:1f4:85e1:63e0 with SMTP id
 a8-20020a17090a854800b001f485e163e0mr1163286pjw.81.1660696966481;
        Tue, 16 Aug 2022 17:42:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 c10-20020aa7952a000000b005327281cb8dsm8842659pfp.97.2022.08.16.17.42.45
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 17:42:45 -0700 (PDT)
Message-ID: <62fc3985.a70a0220.698a5.e7cb@mx.google.com>
Date: Tue, 16 Aug 2022 17:42:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-84-g5fcbe4a63ab4d
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 31 runs,
 3 regressions (v5.10.131-cip13-84-g5fcbe4a63ab4d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Aug 2022 00:42:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9263

cip-gitlab/ci/pavel/linux-test baseline-nfs: 31 runs, 3 regressions (v5.10.=
131-cip13-84-g5fcbe4a63ab4d)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
imx6q-udoo                   | arm   | lab-broonie  | gcc-10   | imx_v6_v7_=
defconfig | 1          =

imx6q-udoo                   | arm   | lab-broonie  | gcc-10   | multi_v7_d=
efconfig  | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
          | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.131-cip13-84-g5fcbe4a63ab4d/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.131-cip13-84-g5fcbe4a63ab4d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      5fcbe4a63ab4d3a1c958bd377c1c3c31e82f8909 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
imx6q-udoo                   | arm   | lab-broonie  | gcc-10   | imx_v6_v7_=
defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62fc37cc4ad5314a94355646

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-84-g5fcbe4a63ab4d/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-84-g5fcbe4a63ab4d/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220812.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62fc37cc4ad5314a9=
4355647
        failing since 0 day (last pass: v4.4-st20-96-g74ff989472f09, first =
fail: v5.10.131-cip13-49-g1145e9c6352e6) =

 =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
imx6q-udoo                   | arm   | lab-broonie  | gcc-10   | multi_v7_d=
efconfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/62fc354cd20cfa2d74355657

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-84-g5fcbe4a63ab4d/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-84-g5fcbe4a63ab4d/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220812.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62fc354cd20cfa2d7=
4355658
        failing since 4 days (last pass: v4.4-st20-96-g74ff989472f09, first=
 fail: v5.10.131-cip13-35-gab58aa0904675) =

 =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/62fc31798361c7d416355647

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-84-g5fcbe4a63ab4d/arm64/defconfig/gcc-10/lab-baylibre/base=
line-nfs-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-84-g5fcbe4a63ab4d/arm64/defconfig/gcc-10/lab-baylibre/base=
line-nfs-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220812.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62fc31798361c7d41=
6355648
        failing since 12 days (last pass: v5.10.112-cip6, first fail: v5.10=
.131-cip13-24-ga6f4ea41fe167) =

 =20

