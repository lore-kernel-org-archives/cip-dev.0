Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1800EE4993
	for <webhook@archiver.kernel.org>; Tue, 22 Aug 2023 16:24:34 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web11.532.1692721468124671290
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 22 Aug 2023 09:24:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=d9e9QsDT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-68a3b66f350so2566502b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 22 Aug 2023 09:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692721467; x=1693326267;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vae8Twd1FTsApxPJtwXEk+HAnaENkIqD/asQCvnUdRY=;
        b=d9e9QsDTIzSLUR28td4HZIbH/FzfLRLXeEXZreA9fseNs+c4xUvBADqXeuP+P8JLYj
         ioaGClzkPmgnepbu2MlLyml+nxgNb2Q7KJ8J2OpmWHfB9MhcXuGn9g8mmkzd5Vp+6hm1
         ErYXsu1yV5KfNAWYsH3ptCcACfvzzJgWdYHdjrxXa0ewK6sTS7CJo24yp80M13/RJrRm
         eSmnYGX4qQzBtlOujq0s5TYb4X+U2+duiQiGyB6AEvFjpF6gGGzVkmSBY9wfP3XiREe5
         bHp+daXxY5XKWXuko54JbZ+0f1NEuJXCBIf8EeRGCnRoBPhJkeiQimaabIb9RQqg5mFX
         8oOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692721467; x=1693326267;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vae8Twd1FTsApxPJtwXEk+HAnaENkIqD/asQCvnUdRY=;
        b=IT0SWkbiq3hKMaWWwxYsN+yJJEURm7BsrRl6TBk5IhtT4YF+PtWoBmWMK+JF77L/h6
         NdGJAx40webo9AYMeQF80hwMx0MI4t0NugZ0RnTq4qpe2K+F8L8BHDpJaQemvU1sDHCa
         f7TYpIIarVNr0gvIgREqA/SGc5Ms7njmkhqcadCBSmisiYxiIJ89Hysy6xUrRmQRbM9W
         LBDhk2c/xT50fl43QgbpRMMXTlkazeuXrrItz8gu4JO1wuUo/wv3jxFpiK8Yywic2jc0
         lr37Q+o+qP7HGmGI+PcTfITjrPUUAutyhQqTVvbFxHbzmpQ1w1D7j72WupNvgmDIjh5J
         qFKg==
X-Gm-Message-State: AOJu0YwUgB/Zo2I4kLIu2dFeCrISOuaA32SR7ZOG7Z4/JIo4wzrwSd+N
	Skr3hYE/JyEnEa8PhY2oPq1/uZMXdDhpkc688ZM=
X-Google-Smtp-Source: AGHT+IGd0s1ZPmzj9R6Qb5ksiG2gTiEHJx6g9hRCVhlVLqz3jgIs4HKyet4zrAKvyFq9Q4ZG9N7zFQ==
X-Received: by 2002:a05:6a20:1615:b0:138:1980:1837 with SMTP id l21-20020a056a20161500b0013819801837mr13354762pzj.13.1692721467106;
        Tue, 22 Aug 2023 09:24:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x23-20020a62fb17000000b0068a4b944beasm3910169pfm.78.2023.08.22.09.24.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 09:24:26 -0700 (PDT)
Message-ID: <64e4e13a.620a0220.7bca9.7b66@mx.google.com>
Date: Tue, 22 Aug 2023 09:24:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.45-cip3-31-gbae6b8e9a2cff
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 24 runs,
 3 regressions (v6.1.45-cip3-31-gbae6b8e9a2cff)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Aug 2023 16:24:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12829

cip-gitlab/ci/pavel/linux-test baseline-nfs: 24 runs, 3 regressions (v6.1.4=
5-cip3-31-gbae6b8e9a2cff)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
imx6q-udoo               | arm   | lab-broonie | gcc-10   | imx_v6_v7_defco=
nfig        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.45-cip3-31-gbae6b8e9a2cff/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.45-cip3-31-gbae6b8e9a2cff
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      bae6b8e9a2cff1558da85b327d6a7bd4a5d21d0a =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
imx6q-udoo               | arm   | lab-broonie | gcc-10   | imx_v6_v7_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4d96dae4101f8b9b1e3b0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64e4d96dae4101f8b=
9b1e3b1
        new failure (last pass: v4.4-st20-3262-g667bb8d8b2cb) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4d66a498fa02358b1e3b2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64e4d66a498fa0235=
8b1e3b3
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4d7ddc04d0b1c83b1e3af

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm64/defconfig/gcc-10/lab-cip/baseline-nfs=
-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.45-cip3-31-gbae6b8e9a2cff/arm64/defconfig/gcc-10/lab-cip/baseline-nfs=
-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64e4d7ddc04d0b1c8=
3b1e3b0
        failing since 6 days (last pass: v4.19.288-cip101-1117-g1f3468542aa=
9e, first fail: v5.10.186-cip37-16-gf8567732a40d) =

 =20

