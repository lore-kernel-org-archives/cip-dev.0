Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B963FC7EE2A
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 11:29:32 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.5064.1685964565210990432
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 04:29:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=ZUD8U/It;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1b025d26f4fso40537275ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 04:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685964564; x=1688556564;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5rBgFhRxGUtP5CfLv3hXKXh246n1g7P8aI+suPP/hSU=;
        b=ZUD8U/ItDxdGhE5RY8SX4IzQ7yhr8N+6oERFEXWo6RZd7EYHRui6ThXQz0/Q3i59gu
         PASOrxJoC8M4qJeAyh7K+14iobOQQqFfXlWkLvJUuSbg5+ImC6VBUJ8XE0qGDLb9sL7Q
         h7GJjpxrCa/XXzgbPXci7e29Hl5aZA3bpru+L9pPcXRIXxRLu7oOrQExYOH1eZCkiHaj
         /CXE3KmY9gMZ2yMB6pbTEbnDlJV5Rs39Z4jZtFOpSnNjhnNUv/QVkBKYK6GCT5EoBWin
         xN8HP4bZYCYXDeJY83MQdes0gC+GkM1YrnAAPaqk9xlcS5/E0aMmqJNAYbm7WuWrAhxC
         2f8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685964564; x=1688556564;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5rBgFhRxGUtP5CfLv3hXKXh246n1g7P8aI+suPP/hSU=;
        b=JMV3hsOwEm31jm8M83UzmAD/BFscfNC932sV2899IhXL5lBxvb8z+QRgcsScLs/+rL
         qxkt41FjsGzI2q+8xnHWNJUBSETc/lmF2W0tluuqeC1Yllls6jf7fUHbcRCak2IH32ck
         ZowZSZtm+8bFJN0Wnkcseu5Mk1PNmuKOlubGR+uUf7RIqf9wfeDoqWeSrSeClnXZeQbd
         Qjn6V5Ihm0yKK7XhvRrKnhoiwlW00Or3k0Xj7XfYQVkeF+MrOE/0A+KzC7zGkfoRJFMA
         kbmOXPOmNWMgrTNhJ8CbAuDZhFdjX3PixGV194+Ex3y88QdaAdJVIRR8mKFXEvf6G7PD
         Lxdw==
X-Gm-Message-State: AC+VfDzFWpzhDkhcOUX61fZBh3/KeG1ZnYeNoLQ1oAI2SKmBzkNORiuT
	9gk8IqbMvsRQ3xdKuPRfoYLbCLGvPaJijQQUfzXwgA==
X-Google-Smtp-Source: ACHHUZ5aVzAmKJPyL68Nyf8taz/a9qvJa0wCylmMm+RgPsWwCN07ViXphseCHd+nkLVB7MKI0GfZKg==
X-Received: by 2002:a17:902:9f87:b0:1aa:d971:4623 with SMTP id g7-20020a1709029f8700b001aad9714623mr7232973plq.38.1685964564068;
        Mon, 05 Jun 2023 04:29:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ja15-20020a170902efcf00b001b1920d000bsm6363308plb.234.2023.06.05.04.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 04:29:23 -0700 (PDT)
Message-ID: <647dc713.170a0220.6ad5d.a511@mx.google.com>
Date: Mon, 05 Jun 2023 04:29:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-19-gf0f6960f132cd
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip ltp-fcntl-locktests: 12 runs,
 1 regressions (v5.10.180-cip34-19-gf0f6960f132cd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 11:29:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11800

cip/linux-5.10.y-cip ltp-fcntl-locktests: 12 runs, 1 regressions (v5.10.180=
-cip34-19-gf0f6960f132cd)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip34-19-gf0f6960f132cd/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip34-19-gf0f6960f132cd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f0f6960f132cdf82ed0fcb61de7c496d33f0998f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/647dc2c66cd8822134f5e3df

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm64/defconfig/gcc-10/lab-broonie/ltp-fcntl-lockt=
ests-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/arm64/defconfig/gcc-10/lab-broonie/ltp-fcntl-lockt=
ests-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/647dc2c66c=
d8822134f5e3e0
        new failure (last pass: v5.10.180-cip34) =

 =20

