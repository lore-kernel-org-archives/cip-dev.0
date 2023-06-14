Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5B7EB64DB
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 13:45:15 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web11.12304.1686750311483642602
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 14 Jun 2023 06:45:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=ZNXVw99l;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6642e056d7fso3113129b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 14 Jun 2023 06:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686750310; x=1689342310;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=COw7JH0S+MBVJBXLydLBrNVMu1sEsubBZpSWQA8xkWs=;
        b=ZNXVw99l4Leefy4wTNGLhFZnJRWrepSeOZqxzdWhQGvTEwGzV02DHJQs9RSMxK5Zk6
         MXef2O/SEIFEAaw2gjrBSqBi/E9rPrV3BkZfB7QM+izKTrlaqhmT5oHfJGP6ulsga1J/
         L7I2E9ZFZAZYQpiTXAR1sXO5AXAme9z+7e89lu88LtNdo9CS171kcj93EsiooFNQOD9B
         bD5HeHoLeTcpj2l1nEGqrV7Rh/m25zUW2enqBY9RF+W8+24n1v7qteY1MI0mtGJ0lTdR
         FiHv1jDk8hzuRV2uWPLdi0krhV8J9caAAAsXKBRKFqukCgFF3QQl6MzRNHEmutNCZAc0
         Lv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686750310; x=1689342310;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COw7JH0S+MBVJBXLydLBrNVMu1sEsubBZpSWQA8xkWs=;
        b=FIuOrjDMGdvQ0Mz/gmMxUBbMI1GcteoRu6apieu0m6hSXcSsF/3ieV64xZLuxmUBly
         ualBqK52bIXyZOziMcZHmfCJgvo/Fj2gaYI9cg/0GGXygM9yS/Vnhq+j4Q4juWGNQ6hf
         seYscaTxTbTEpKrC6sReqwFuAnAiQEYKnao4oX8QLsjWA5LfdbM2ILjv3R616qyqFMu1
         Be7N/0HJOtlberQswIvbTPIBiScQcrqcFcD1UclOsMvjOZnfskCET8fWeMlcCeSAHYL+
         aw/QOJisOnGvuJ90Y7l8rN0UxBURKaRkJLr9vgd1ZeXpJqbMR3TQ1yI4pUE1OSoCmq/C
         9QOQ==
X-Gm-Message-State: AC+VfDx13LmV4sJy1tfuI1ZlHuMb7MbQQ9lE9B/O+6mWPTZbWKxoATqD
	aFxVkANPcAn8P71L6uvhAIgLa4lQD7kiF5WhXvRdwg==
X-Google-Smtp-Source: ACHHUZ742EWK0OYfhndVtLoniVRZbe85zc9SexwpUXdik1gr35oLIhWHnTN36UkS5WcqbRRt0rT5nw==
X-Received: by 2002:a05:6a21:9714:b0:10e:e891:534 with SMTP id ub20-20020a056a21971400b0010ee8910534mr1129251pzb.58.1686750310169;
        Wed, 14 Jun 2023 06:45:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id iw15-20020a170903044f00b001aae909cfbbsm7189950plb.119.2023.06.14.06.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:45:09 -0700 (PDT)
Message-ID: <6489c465.170a0220.4c86a.e4f0@mx.google.com>
Date: Wed, 14 Jun 2023 06:45:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.31-46-g4cc1cc26e90f
Subject: cip/linux-6.1.y-cip kselftest-filesystems: 7 runs,
 1 regressions (v6.1.31-46-g4cc1cc26e90f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 13:45:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12031

cip/linux-6.1.y-cip kselftest-filesystems: 7 runs, 1 regressions (v6.1.31-4=
6-g4cc1cc26e90f)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
     | regressions
----------------+-------+---------------+----------+-----------------------=
-----+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrome=
book | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.31-46-g4cc1cc26e90f/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.31-46-g4cc1cc26e90f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      4cc1cc26e90f104dbefb9aa54defaf48b5802325 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
     | regressions
----------------+-------+---------------+----------+-----------------------=
-----+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrome=
book | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b71abdc443ecd73061ae

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-46=
-g4cc1cc26e90f/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/kselft=
est-filesystems-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-46=
-g4cc1cc26e90f/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/kselft=
est-filesystems-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230609.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/6489b71a=
bdc443ecd73061af
        new failure (last pass: v6.1.31-45-gce658d9231044) =

 =20

