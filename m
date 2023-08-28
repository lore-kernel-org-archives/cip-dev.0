Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE466C83F11
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 02:10:45 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web10.5465.1693188635974496257
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 27 Aug 2023 19:10:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=iOX0Qaq1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.174, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5657a28f920so1158861a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 27 Aug 2023 19:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693188634; x=1693793434;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DcaVT0MvE8XffCDwsSsQ+D/+zAdu3h1Te1xz+IaP+Tw=;
        b=iOX0Qaq11xHBWaGgBc+u1OTxO/hm68x+Zi+8JmpksW0urOEyKcwO8XjIzi70r5WhK2
         4pBo/gg8WxX88PBKwy8qs8HE90goTgv5D3BlzhKcmKoG3RbfHNV47l2Q9FwCoq1iKujt
         ep43I86n3qAlkLhPYF8CLd8MzHP+UwQ+95ue5fynys5g3Z2JO9TfCUy10ilCNSo0oP7c
         CEwdWWtRCbZbcxQ3RRcQ04E/96QRURobdaJb5mbMvKM02iY61ncNMZKL1aU4XfZgNKPe
         4OdCiEV1RCn+EcUcwhbF27wUw9iRGCwEsqbgV9fBl4pK+bHxLmZT8c2IQg1TeMUHwuyL
         0Fkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693188634; x=1693793434;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DcaVT0MvE8XffCDwsSsQ+D/+zAdu3h1Te1xz+IaP+Tw=;
        b=QjFx3Fdt2rj8qyC3Zcqc8yeUGpIHoXSiftQOzS/rTOtM6CuemajKXSe9lEEqTRBHmL
         R0RUz3KWXVFT1ufA0SaZzAiAJhCIym9zGqgB4Z/LSr3p4luaSznUyJCl/BYa19sepdzq
         fePg4nr3deGO1P3Y7TyFVj1JmCWhJnDI6Mss8c6JB+ZmhsmS83FDFj8X5Po6Vwv58+YI
         tSjaDbkvTM+YLXf1ymXHfppevacyQ2J8l+ufJ/BwSGAxu2kYoI9CeTKEmc9ezpOi5kSH
         lE6EIMbNCpQ6HdhbsFPNi1kbu52x4p8pqCfzbcV4Dk3pmaMrnabDohLILScsq2yfIF9e
         PuqQ==
X-Gm-Message-State: AOJu0YxFkAL+uL9W8+WZ55qVZKnZ8n27Nty0zp4j2aIPL5l4VZrvNT48
	+yjJI6dOz2J7Ahh7BEeglTOLgbjsCE949rczfUU=
X-Google-Smtp-Source: AGHT+IFhsLITr5orlXrXpJ1SdK/IGm2zwzTjx7cWGLZMpo0r5V1a4grwpc7ky7Nyx2WJq6UXPu4B7g==
X-Received: by 2002:a17:903:2441:b0:1c0:9d5a:9b06 with SMTP id l1-20020a170903244100b001c09d5a9b06mr14094972pls.63.1693188634193;
        Sun, 27 Aug 2023 19:10:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a20-20020a170902ee9400b001bde12178b4sm5914040pld.33.2023.08.27.19.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 19:10:32 -0700 (PDT)
Message-ID: <64ec0218.170a0220.97304.9245@mx.google.com>
Date: Sun, 27 Aug 2023 19:10:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.191-cip38
Subject: cip/linux-5.10.y-cip ltp-pty: 4 runs, 1 regressions (v5.10.191-cip38)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 02:10:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12870

cip/linux-5.10.y-cip ltp-pty: 4 runs, 1 regressions (v5.10.191-cip38)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.191-cip38/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.191-cip38
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      78bddf33c2b7d94fc34e09bc56638615095ddc28

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf17c1594903829286db3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig/gcc-10/lab-broonie/ltp-pty-meson-gxl-s905x-libretech=
-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/arm64/defconfig/gcc-10/lab-broonie/ltp-pty-meson-gxl-s905x-libretech=
-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/64ebf17c1594903829286d=
b4
        new failure (last pass: v5.10.186-cip37-27-gd6d928db0a620) =

 =20

