Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FD2C10DC1
	for <webhook@archiver.kernel.org>; Wed, 29 Nov 2023 00:17:09 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web11.15301.1701217022773604022
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 28 Nov 2023 16:17:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Rkbkmz9z;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6cdd28aa7f8so29335b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 28 Nov 2023 16:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701217021; x=1701821821; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5BuNHO9mVA9psmDHelBT5liuOCgVAll6aIbJcFfORvc=;
        b=Rkbkmz9zK64Lv3GFr7VsECprQcSIQrvxUpz2JNiVKGTuwqW75qsBsbL2a7Z4Yka14T
         BAeXi0q8U0kix+zOhPI8pINiKre6FSWVW0+qYDrGPz4DJWI4rYvLp7gr4ibS1WsvOKP7
         gaRrhs2/mJkfgVwwZBS5JQ85hWkSrjOBM03H+Mrj2buxvEapVI07rRETICu0+s16FgWc
         U0SqR95+V/CsBvhragEPgj0zZMUPCjgKm2RSj3JjVk/vKO4HA81lBuNx6Xt0BBxY2DF2
         LMgx6AfNj1b7gKy6O9R5LuECsoZlGubf582ZuF3u4UrUV09/aH3fDpwRPLTUTji9KSC3
         uh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701217021; x=1701821821;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BuNHO9mVA9psmDHelBT5liuOCgVAll6aIbJcFfORvc=;
        b=fJ8FzIOUVlKpivD5UCNPu/3zzsMyyW8OQp6z2pZZgiHiA5DKw8DMgSbfwawGMev9bG
         puG9ea8v5ZH2JeLd/BxrfC3Gq28RZE7RIyuBLmA0SgFvsH4k77yvImthMZCZlX6tedXX
         rD63v60qTiGCehReTp8rYGbgD4w082REtrnE9h6Sh+0/eMtFc6EoAmCkM1NyGK2GwhLk
         RqNCOhkdMC2DeY4UGat+NktlsBLy47AbNiDdVUVnwVarOO2qNRtwJv/eCOO2iEQKPDHn
         TncuS55YzHofV6dL9WbHOJP1wnQlPGDG9W4fBiCLd0gUJPOlNu6u7iTYzsUNjVVPMli1
         pj5w==
X-Gm-Message-State: AOJu0YzM37yifq6iAVsk2UyM/Vq8W5pVvoLCF6wI3YWTUwri4kHxdY6s
	ZHCUEpq8A3sQ57XgTzuXNlMC6wqPqV6pLzM6pnQ=
X-Google-Smtp-Source: AGHT+IE2I6Wf3IsN6sBLGPfXc1BD/TYwN04apbVuJsI91bTGJqLLPKe4Mmrbr/+U247zOMU0Is1GXw==
X-Received: by 2002:a05:6a20:3d85:b0:18b:af9d:438f with SMTP id s5-20020a056a203d8500b0018baf9d438fmr18789418pzi.49.1701217021080;
        Tue, 28 Nov 2023 16:17:01 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k7-20020aa792c7000000b006cbb58301basm9805266pfa.19.2023.11.28.16.16.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 16:16:59 -0800 (PST)
Message-ID: <656682fb.a70a0220.8c6eb.8f06@mx.google.com>
Date: Tue, 28 Nov 2023 16:16:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.201-cip41-197-g2d08925b44e52
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 16 runs,
 4 regressions (v5.10.201-cip41-197-g2d08925b44e52)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Nov 2023 00:17:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13761

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 16 runs, 4 regressio=
ns (v5.10.201-cip41-197-g2d08925b44e52)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
qemu_riscv64             | riscv | lab-broonie | gcc-10   | defconfig      =
            | 2          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-197-g2d08925b44e52/plan/ltp-tim=
ers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-197-g2d08925b44e52
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2d08925b44e52ce450bf165f843637412f9c979b

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
qemu_riscv64             | riscv | lab-broonie | gcc-10   | defconfig      =
            | 2          =


  Details:     https://kernelci.org/test/plan/id/656671f33c6af134e07e4aaf

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/656671f33c6=
af134e07e4ab4
        failing since 94 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4c=
8, first fail: v5.10.186-cip37-982-g80a0585c0aa62) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/656671f33c6=
af134e07e4ab4
        failing since 94 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4c=
8, first fail: v5.10.186-cip37-982-g80a0585c0aa62) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/656670d3a78f9d7baf7e4a7d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/656670d3a78f9d7baf7=
e4a7e
        failing since 26 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/6566733f3537054c527e4aaa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/656673403537054c527=
e4aab
        failing since 26 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

