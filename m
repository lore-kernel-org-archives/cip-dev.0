Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A74C7EE32
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 08:06:42 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web11.45181.1685347598174919229
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 29 May 2023 01:06:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=EG/jDriX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2562cc85d3dso2517525a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 29 May 2023 01:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685347597; x=1687939597;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sprxNfTfBTAa2QQ9foxANQZ2MLOtd2SIT+ad+vRr/k8=;
        b=EG/jDriXy8skp/umWhVTSeDq2ofYpZvhzgDU6ODRKEr4DBRkWJzNu4fX/lN39rGfQO
         RLYNy3DV/6f74Rwt96ZG4v4cbVs4uFbkLZmlIOrktYc1997oHJUB8FckoiCEdGGhHI1d
         ATiay98Ouc4+f2J97kg98Aj94olZN9LyINybcz9mx1Nq+c1d8q5VRXI3gHDHHteW2dpE
         MZ89IKzVQaUrxnBx/Nps1oxt82o7tJpa7CtkPcd8cDDc0bgjxJSXMoRTTcIAUlEiySif
         awMsq9y3KZrZxUTFZ4BOnIWjncJNvlBBe2kCpmdzc8iJzZPM906Jtv+xlByIRteFPJ0i
         q+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685347597; x=1687939597;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sprxNfTfBTAa2QQ9foxANQZ2MLOtd2SIT+ad+vRr/k8=;
        b=jtN4qGCsJJMKHVRoW11y414+s1/kQuVeQCEQAvY2ijiTZWwUcNVdE0RbxwRECZzfCU
         ek9jITEdfU5na7xfMlxF4xzmv1Man5ad3p0opc0mvbiAIspdr4y4QLc8sP0h5W04kBty
         7kKKcMze3osqt7398NW6wwmRDn2Qhk/kQkJn+IUMbQUCntp8P84zSxl6iWVqcoROIwKa
         s3ALXmXNEesUOVFXRxEyryyTcjNxsggxHTvbd9wQeIMoSj96pX8B4Z6jHOhKpOYdXT9C
         ehsh52M7pcwq1C3qQX5Ld48izVQXw7dhq4yabRI3cmhasckgVySG1qXz02cqTaXOgZLR
         1SgA==
X-Gm-Message-State: AC+VfDwKU+q7TIEPZRz6YsFXwAkzoXNJKJq19gLHr5OowVu9oMBL9bLh
	vTbGInxL2lqpqrS/fZOeOsENE63rP1HHYAx2pXW1YA==
X-Google-Smtp-Source: ACHHUZ7GqTTNLZK9FynFmgXNNIp9Z4Bz0SaQs9Wp/wrqk8R1NGmaX2aaeQ42/XpfKLKAlBKCMEnutQ==
X-Received: by 2002:a17:90a:9907:b0:253:30f9:1849 with SMTP id b7-20020a17090a990700b0025330f91849mr10251835pjp.12.1685347597363;
        Mon, 29 May 2023 01:06:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id nn12-20020a17090b38cc00b00252b3328ad8sm6579045pjb.0.2023.05.29.01.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 01:06:36 -0700 (PDT)
Message-ID: <64745d0c.170a0220.96b37.c694@mx.google.com>
Date: Mon, 29 May 2023 01:06:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip34
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-fcntl-locktests: 13 runs,
 1 regressions (v5.10.180-cip34)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 May 2023 08:06:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11689

cip/linux-5.10.y-cip ltp-fcntl-locktests: 13 runs, 1 regressions (v5.10.180=
-cip34)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip34/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip34
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      aa80091745d6b40c944d419c12ba8cb65b1a57a5

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  04e8f2f4fd9493f595b34320403cf6b4f1f6789d =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6474595864868404c02e85e8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/ltp-fcntl-lockte=
sts-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/ltp-fcntl-lockte=
sts-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230519.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6474595864=
868404c02e85e9
        new failure (last pass: v5.10.180-cip33-21-g8eb0cdf459a2) =

 =20

