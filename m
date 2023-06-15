Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249BEC3DA40
	for <webhook@archiver.kernel.org>; Thu, 15 Jun 2023 12:56:51 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web10.17414.1686833802143389074
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 15 Jun 2023 05:56:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=crx7QXED;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-66615629689so2133104b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 15 Jun 2023 05:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686833801; x=1689425801;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RmYmV4eE5tmY0PBy3dfzLWxj7/RNAsONdcNAvUCU07I=;
        b=crx7QXED0yqj/Z68nyaYQQUQAk2iGny3prJFxI4xjSMs0c/OlyrAHO5njzb9UtftaL
         w5iAP2tT/zpQTrfbQDhTMjlYAp4zOmkVF6rxTRJOG7Mk6P+x7IQwga/SecrRjNdw5zxW
         TtefApYE1xNfKGr6zA454p4wCZWCUDRQfYVYohOuf3IeSQ28zWqKFBvo9X9kgEcBFxDG
         e3XIqeBUbpYx3spOQvBRWtIB9a/gppE8KNWzcZc9Ib2IqH8PVUiOlVJwP+KRPJAiNeTS
         kTwWpD23D4R4z+qLY1mov7maTIKHNDxEugrHQfW3OUlDnktY/U7c0mH9OKQcQekPy799
         m1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686833801; x=1689425801;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RmYmV4eE5tmY0PBy3dfzLWxj7/RNAsONdcNAvUCU07I=;
        b=huXSu5T5Gl3vXKzbZyvJtg7XfehMuchxNK20wWw1JRR6ZowHhCpt/OiPZDo45Wt5mL
         sM8TA/29qdkokPTjXfrnlUlala7mWAClLSANoWOh/+fQH6UUObSYqHwP1PwgTI2pdxXz
         KMyDQQdwGGvXUmwQo4idglqxiaEKzG2MXYfShnSNAgkFz/Dklaa3DPxNY3K8WRhS8T0v
         MzFv6BFtMWCvTk8ozgtNBn5jkOLoypeD2NZHVkarLM9iAc/LrNCtQRWbglmp8dTvBFHz
         DenHKiU7X/7d+zb7v1w9VH5FwyqyhS+fHm+CY9WgtTJKaj4T/6wcKRqsA67osDRuv2cS
         Qlgg==
X-Gm-Message-State: AC+VfDzYY4/8CR3WA92LNyNU9ThJEbOVk44Af/Mtl/ioD3jFlmJZiq/5
	aFm7hmbQ59dunyxXKXvJnbxU1O6sblXvuod0nlUdig==
X-Google-Smtp-Source: ACHHUZ6Y2770/iVZNkgGBsjujxSzd9Tj6yM/fi/X3FK/hX/wTZUx1k2GiT3BSIbmOkWbGJyh7hVrOw==
X-Received: by 2002:a05:6a21:9812:b0:10b:a9ca:97ca with SMTP id ue18-20020a056a21981200b0010ba9ca97camr3853217pzb.51.1686833800944;
        Thu, 15 Jun 2023 05:56:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w22-20020a170902d71600b001a64851087bsm5155127ply.272.2023.06.15.05.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 05:56:39 -0700 (PDT)
Message-ID: <648b0a87.170a0220.b85c7.a3a1@mx.google.com>
Date: Thu, 15 Jun 2023 05:56:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.31-53-g486caac40d06
Subject: cip/linux-6.1.y-cip kselftest-futex: 9 runs,
 1 regressions (v6.1.31-53-g486caac40d06)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jun 2023 12:56:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12060

cip/linux-6.1.y-cip kselftest-futex: 9 runs, 1 regressions (v6.1.31-53-g486=
caac40d06)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.31-53-g486caac40d06/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.31-53-g486caac40d06
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      486caac40d06a2c987e5514b550d341cf6791b17 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648afd8b98a94a1cd430612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-53=
-g486caac40d06/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/kselftes=
t-futex-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-53=
-g486caac40d06/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/kselftes=
t-futex-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230609.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/648afd8b98a94a=
1cd430612f
        failing since 5 days (last pass: v6.1.26-1320-gc38e4a9845945, first=
 fail: v6.1.31-45-gce658d9231044) =

 =20

