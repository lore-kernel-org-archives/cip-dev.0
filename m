Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD15C77B7A
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 08:06:42 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web10.45063.1685347596777519499
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 29 May 2023 01:06:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=ei9pRojj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-64d24136685so2072775b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 29 May 2023 01:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685347596; x=1687939596;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8wJko1FhLdZQjpP3dMJFH2HUM38W53+3+TT/82akukw=;
        b=ei9pRojjgyU3Y3N3LhDh4BNNoso1fGV/iT/G8bihPueL7lielsJInIrqoH2LWBMDkK
         aBkYx7PMeo0BEHZyYJczM3bZilumd4liYd3I2P+FRPwu9dhcR2jqki09pfCbzBpoqUAO
         DLnZX5MJ/9mtQ0JU2cjoosjixfZ5cE50vX2lRuCqMLMHP1SFgf/vx2bd/wGlc/BrjhHc
         +/hRgXFVFEIKRz86sVvTclznkGz2cDoUpZUKTxfYqdQKnexGRWpXnv0y3JISGVa3A41s
         P84oI5zg0bh+OnBjHeNPoP9HyJslmLplRUthtxQg7E/cGh1geo7aUY9OrPuTKeWg6jKB
         d7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685347596; x=1687939596;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wJko1FhLdZQjpP3dMJFH2HUM38W53+3+TT/82akukw=;
        b=PPp6UippENVWkbEjxoqmmrX2X5TqqjzFpqX7RnP6PA0042WMOj0Y8d8oICjzqYAHZc
         IiM5tEz5NHhGYTxf3uEIqqqEu/XuCcqsqMRY0d+qfNY4EjwXav4VOC8GrpKVzPycMbgB
         aM9jDUbefp809Ojj/TtbWjPkordXnuuOzHmrN57nUQZdu55bSefCvTiH56vXvTUOIu7S
         EiBWJUXb5rA6gjoD66ulz9gjGe5NizU5GX9uMhjDZf9IhlBDwvPfR3FlLxJiq7zKalR1
         wzOhIn3I65O/8xV8P9lplnBvsVJgQkfhm4eipJSWlx4v7TWCfkICLNjhwTGuVfyk7VNc
         xeRQ==
X-Gm-Message-State: AC+VfDznkfDxo6nLRbKjOcoOduIfUzRwSvFmfO1wPIIILVxYiK4K5V2x
	88Aj2KdAZiFnS9MqB8Qjs6+Kx8fwF66uMoA3PZn7Tg==
X-Google-Smtp-Source: ACHHUZ76RaH+4/l0qLILRxpVGxgydyBzDBJzYGbzuqlczLr6R2G7HB/szwXFNHDBbPAY5Dl5APoMuQ==
X-Received: by 2002:a05:6a00:2315:b0:646:c56c:f0e0 with SMTP id h21-20020a056a00231500b00646c56cf0e0mr7624473pfh.15.1685347595753;
        Mon, 29 May 2023 01:06:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t16-20020a62ea10000000b0064d32771fa8sm6201136pfh.134.2023.05.29.01.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 01:06:35 -0700 (PDT)
Message-ID: <64745d0b.620a0220.bdeba.bbea@mx.google.com>
Date: Mon, 29 May 2023 01:06:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip34
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-futex: 12 runs,
 2 regressions (v5.10.180-cip34)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 May 2023 08:06:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11687

cip/linux-5.10.y-cip kselftest-futex: 12 runs, 2 regressions (v5.10.180-cip=
34)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
beaglebone-black             | arm   | lab-broonie | gcc-10   | multi_v7_de=
fconfig         | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip34/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip34
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      aa80091745d6b40c944d419c12ba8cb65b1a57a5 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
beaglebone-black             | arm   | lab-broonie | gcc-10   | multi_v7_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/64745833f237ab36192e85e8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/multi_v7_defconfig/gcc-10/lab-broonie/kselftest-futex-beaglebone=
-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm/multi_v7_defconfig/gcc-10/lab-broonie/kselftest-futex-beaglebone=
-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230519.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/64745833f237ab=
36192e85e9
        new failure (last pass: v5.10.180-cip33-21-g8eb0cdf459a2) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6474598ce66ee44b3e2e85e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/kselftest-futex-=
meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/kselftest-futex-=
meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230519.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6474598ce66ee4=
4b3e2e85e8
        new failure (last pass: v5.10.180-cip33-21-g8eb0cdf459a2) =

 =20

