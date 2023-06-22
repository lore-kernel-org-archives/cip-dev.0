Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5584AEB64D8
	for <webhook@archiver.kernel.org>; Thu, 22 Jun 2023 02:34:53 +0000 (UTC)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
 by mx.groups.io with SMTP id smtpd.web11.1178.1687401291280806904
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 21 Jun 2023 19:34:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=ISjf9Rtf;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.173, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-38ede2e0e69so4389723b6e.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 21 Jun 2023 19:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687401290; x=1689993290;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+qfbL1HI750fjNmBPHIPjng0dWrvwF/QbCyZHAeH3nY=;
        b=ISjf9RtfRdvSpjW7H3lSOxLncgOTrMu3+ChhTjPDkXKV029aRpdtttd+qZ7isYCO86
         /p+Eur+bIu2tyFEqIjzEChTIFr1eEuJP6ydqH41SfkKRQl5PsCTnCrkgICFTQtz+pUu9
         +e7v5VIZhOLB5pSxoaH5GyoV1AidB0WNAiWBPGkOFnPME8oUgNvzgIrqKBL91Jab+B0b
         4HrO8mZfk+V6wQgG3fDnlHIQ8alzThk3mZnaoyLYQIIo5vuSlBtZ7683UIK2wYcxL08/
         ac5zZbCGpUISdOBhZZmqy+coC+JYFQtODN/+o+p+uyjgSHp2skUaLUfCXwd3ljxnrBMe
         1Plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687401290; x=1689993290;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qfbL1HI750fjNmBPHIPjng0dWrvwF/QbCyZHAeH3nY=;
        b=GFppL7vMc/e0bcvub22DeZNauFZX2M/Ewj9IAikG6EMcxfdYsJ+k/3W9AEhf8guzrA
         cn2o2ZK9Ysjao+AnwlH9JMK6OLB1od2H67AEz4REEjT+jirez8UxKRibtGw7dVIW1WsP
         //lzlGdnWtZqLbAbEDD7O2IcXwiG9KpfdqIIbLfRM86D3JhPoyn0kg7SWXUiWdgbs+48
         1posBmUs/5qNu5RyzFoHO7lVmyBXJaRpeHmBCdFP/LcwB+yr6E6TjRItcokuZ6s64EcC
         BZmsVzPncXvGAq3YTGsydsGRRq3V6as6t9QT68VSjG2Xqmc47E6A79TCnSXia3iCWmjG
         pAZw==
X-Gm-Message-State: AC+VfDxfkBIHIqhNdFOUcKB3cb9sIMx0IRjTZI51Zvd4tDq6UYNTRMar
	jlBBQjioCu1a7ZJsnQ+WJIKMzKZH+FUhM6IQ1suXeQ==
X-Google-Smtp-Source: ACHHUZ63DXZSulaIso84cpuChyN22wITrR6E37DHxX1mTyQf4EvBDm5YByRRK+2V7o0fG2uWcqd7ug==
X-Received: by 2002:a05:6808:4049:b0:3a0:4faf:accd with SMTP id cz9-20020a056808404900b003a04fafaccdmr2423283oib.32.1687401290201;
        Wed, 21 Jun 2023 19:34:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b1-20020a630c01000000b00534684201b0sm3737429pgl.27.2023.06.21.19.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 19:34:49 -0700 (PDT)
Message-ID: <6493b349.630a0220.a84d8.87cd@mx.google.com>
Date: Wed, 21 Jun 2023 19:34:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.184-cip36
Subject: cip/linux-5.10.y-cip kselftest-futex: 9 runs,
 1 regressions (v5.10.184-cip36)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jun 2023 02:34:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12109

cip/linux-5.10.y-cip kselftest-futex: 9 runs, 1 regressions (v5.10.184-cip3=
6)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.184-cip36/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.184-cip36
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f34f3ecd0387c3ad8b34bf65ac19ec84a38f2333 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6493b2ca3ec3e960a3306134

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/kselftest-futex-=
meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/kselftest-futex-=
meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230609.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6493b2ca3ec3e9=
60a3306135
        failing since 7 days (last pass: v5.10.180-cip34-26-g462b2292d23e6,=
 first fail: v5.10.182-cip35-1-g7cde3fba93966) =

 =20

