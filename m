Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C391FC77B7C
	for <webhook@archiver.kernel.org>; Fri, 26 May 2023 08:27:42 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web11.3696.1685089655272429203
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 26 May 2023 01:27:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=ndawSE+5;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ae452c2777so4617855ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 26 May 2023 01:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685089654; x=1687681654;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C7h5yMUpmK/YDd+drxyShC3/gi6Yzw46vQdoxpTNVbw=;
        b=ndawSE+5TW+oVfW3V8n6cNA/kBonZIfJrcm9yi/a7bF4DrfieDIJL+JGD9C4lRQMv5
         Vc5Avq0IUX3mKPsPNTedK6droVOfPteoqm/SjvySMuICz7XXdKau78TDdthLK1JskAjs
         7mhd9ljOjRf09DWMR/szM+5BE2aNuEwZtRnobcmMbedHBWR6hYNyDweuvZCIvgd5B7ab
         PzuEKeLBbu/rVPa/hSjGD88S8EyOgRWoPkIzjLAjN6LwpAj3ljN/vlCJ7aNY/UTR8IKv
         2mSxoEUtPN3/LPZmGTw4Rjr4u52iCX1lvEGELCsbtEabJ30OkBkxs6f89kuwU5Pw2LQ+
         9niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685089654; x=1687681654;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7h5yMUpmK/YDd+drxyShC3/gi6Yzw46vQdoxpTNVbw=;
        b=LN2ohdDHZL1datetxtAWqofe2rqq7lSx81hvIn449U3JpGFHACQfCvwCaNb7hYN+fL
         1TG3wREhfQrqgKhB7u/n//h2w0NRee4i9Dqnp7N1qdQPYB9NBNPFrKNvbrVEhIS6YciO
         WjlLjaXyaQbVE5PkbnevToPWyDwfKgHkOLWrm8FkyLZqmZnzHvv9EjVHxYvbRk4GPvEv
         BHZ7JTbYob8qqzFzvjVpeyOx6JpE2AwunUjdUJDrwq5ui+0mjLpws3N0BmaR/KY+i3T6
         YwshAB/o863MVU1oL3V7/tn8+34JctledodaF2fSX7EK9m5VE1uDaiNb2bq32jhsHBnc
         Y5fg==
X-Gm-Message-State: AC+VfDz4TECkO+MkVZ4AtD0KfBqvFoWu5ZW186YedDAUTwdt1SBP2XgU
	h+ust9iXxHBFaGcpGd73p7pKBUMC6tGrv+rq4hpZhg==
X-Google-Smtp-Source: ACHHUZ7laV4oULSz8J60FbXafLcFv1YOEHw1lEUtN9M7zrFc20CqvAxk42n4ZH5nD7WmYprmTifR0Q==
X-Received: by 2002:a17:903:186:b0:1af:bae0:6be7 with SMTP id z6-20020a170903018600b001afbae06be7mr5346401plg.10.1685089654188;
        Fri, 26 May 2023 01:27:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x184-20020a6363c1000000b0052c737ea9bbsm2327797pgb.39.2023.05.26.01.27.31
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 01:27:33 -0700 (PDT)
Message-ID: <64706d75.630a0220.8dee.4adf@mx.google.com>
Date: Fri, 26 May 2023 01:27:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.180-cip33-21-g090289427e8b2
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 16 runs,
 1 regressions (v5.10.180-cip33-21-g090289427e8b2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 May 2023 08:27:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11655

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 16 runs, 1 regressions =
(v5.10.180-cip33-21-g090289427e8b2)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.180-cip33-21-g090289427e8b2/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.180-cip33-21-g090289427e8b2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      090289427e8b2be9dac126c4d1b760b100f2c6b8

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


  Details:     https://kernelci.org/test/plan/id/64705e2f793f9ec92b2e8601

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/ltp-ipc-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/ltp-ipc-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230519.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/64705e2f793f9ec92b2e86=
02
        new failure (last pass: v5.10.177-cip31-122-gfb6ca504156b4) =

 =20

