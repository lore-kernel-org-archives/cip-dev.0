Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83FBC77B73
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 11:29:32 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web10.5062.1685964563539589698
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 04:29:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=f4rc/GyB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.177, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5289ce6be53so4136056a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 04:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685964562; x=1688556562;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gwl+02xe9HozzPRis+ictTaN9klPDRoSlEQwtUSscZs=;
        b=f4rc/GyB4j9Wn7zbIQtyE9bNHya6nuqOr86Vk07yv3PMiWpwEqXJLKfKJO9y8uivqX
         jVbbeLVJ/jtEkQxlSRmVLeZY1np5YDLTJRMYDAUxyrzQ/V7E1ns/OuywDHHGd+6By0gD
         pWKaxtZRS3wu2jE753qzdHjeHu4KvZ3U+vQLifpW4MgRXZ/qZnj2ATyFlDcxHjFFMcm2
         6suGfvkIXIG3yBg2wVpQRPXPpONmUsHRBURUUEMpgoEmzqdS2pgrsTu0XXwISSIkskf1
         RgnVvWIHBEoFu1UoStQdDU2WM37HqzOVKPE9vu59xtwI8YWCbFXzrlvJ/gVAObR5Ojiw
         spCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685964562; x=1688556562;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwl+02xe9HozzPRis+ictTaN9klPDRoSlEQwtUSscZs=;
        b=EeZ3HGqTeejtICoDvfDdLq7UVCVRlS90Hj2usb4ijAfEo/Adz4Uqif5V/OgT16AnOB
         8RG67wQNLRa29gmqRfmROX9ydRrL0fS6nGLPRnFH2eJEW/PsSmb4rLUfNRfVfVwYdcQs
         HGWoHH8RlUlOq0sP02chZ5zOmkfn+vxCDzVRY9NDot81UZy9PQYT4mfjCLKfBrE8ZhwU
         V/PzbGzLysgas/yenI7HH9wMdflpZPlyFbRmAkbVgQoC6AXFFS+THc7J/dY9Z1IqsStN
         4RPzfLZDbCnN3ofBSE4LauiqasriNkHmR74XcePbx1Su/BWVoJRKFevXDT/hLbHRcelp
         gvlg==
X-Gm-Message-State: AC+VfDxXkyvfLg4qFxf3eXl9zV75LYEe9R/ZELqJSEqnrkspRlTDUlIN
	o0n77/GBib8ZgpxQgowFZ8taiE4K6b2t4jiE0N1yVw==
X-Google-Smtp-Source: ACHHUZ4j1MYUILIDx6JbGCUEBSrTjVTineZCXQWAND2OFenQdqtXWJh//IpyZd57xG0VURSATqQ8sQ==
X-Received: by 2002:a17:902:ab59:b0:1aa:d235:6dd4 with SMTP id ij25-20020a170902ab5900b001aad2356dd4mr7636458plb.19.1685964562526;
        Mon, 05 Jun 2023 04:29:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a12-20020a1709027d8c00b0019a6cce2060sm6371709plm.57.2023.06.05.04.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 04:29:22 -0700 (PDT)
Message-ID: <647dc712.170a0220.a58aa.a70d@mx.google.com>
Date: Mon, 05 Jun 2023 04:29:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-19-gf0f6960f132cd
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-futex: 10 runs,
 1 regressions (v5.10.180-cip34-19-gf0f6960f132cd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 11:29:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11799

cip/linux-5.10.y-cip kselftest-futex: 10 runs, 1 regressions (v5.10.180-cip=
34-19-gf0f6960f132cd)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip34-19-gf0f6960f132cd/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip34-19-gf0f6960f132cd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f0f6960f132cdf82ed0fcb61de7c496d33f0998f =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/647dc5ac6b6e070530f5de91

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm64/defconfig/gcc-10/lab-broonie/kselftest-futex=
-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm64/defconfig/gcc-10/lab-broonie/kselftest-futex=
-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/647dc5ac6b6e07=
0530f5de92
        new failure (last pass: v5.10.180-cip34) =

 =20

