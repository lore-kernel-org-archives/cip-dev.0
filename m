Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8B6C64EC7
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 20:03:58 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.3514.1677096236710417245
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Feb 2023 12:03:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=AI2RG6m4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id u14so6257158ple.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Feb 2023 12:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BhMU9mKGEX09Kv4/gqjlJn13BzFTbOvr9aIIJF41lOY=;
        b=AI2RG6m4M2TQXn3mNgj+L29p04CQU/ANJBh69Y/0O90V1vQihrl3Fp0xVvU9zLgBzx
         kr9/tOTlUccOxDkm9dBPyT9Lpku981CD4ICMtBRLRo387PX/RbaBwV+foRTGqzho5KCL
         5lOiyYx47gMPi4tCKihMWFTUuwFL2gDMUV9uvQU3dowGWYFo+L1ptBl5+ltJ6USp4Ro8
         T0k3jhUdaiBFQwRv+zBOX7jSKUGh/RNP+F1tKJJqZ8KxvlRIzrrOJR5AOqIi7ee3sYIp
         gWVivn51oynbkVXnOb6VlgNhiVKXJc6an3nfGG2dJpK/fPaXNN7oDeeyVfgFFXfzv5vb
         NVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhMU9mKGEX09Kv4/gqjlJn13BzFTbOvr9aIIJF41lOY=;
        b=2qVnqBL59lmzQAPp9TC+krzdhKMokO5laoDxsFbyBj+eOksUIPsTOpWXnTrFqT7SFk
         a5Yk7chWPmpoXKNQlJrvTuT3THv7UIzN7duGyQgfbdhxadMos4t3GFrca8ccVD/fUbYH
         s9c1kZusJ+/kRfKGTUnja4Pl+1DRSszot47h4H1zT9naQa2tHK2foFTNMa2wYPF1vEe/
         lWw80buqqPg+UfugjepuiNwsqnrA+U15JtD7ukLCINhy6AX27H4h63Rofz7zwdp4sk0O
         q7mHYLgNtbnXiScLvbAqCPUBPxtuLiUtafnE81HQPmpn44uFTqB2Soi9eEazFldpKNVd
         WHNg==
X-Gm-Message-State: AO0yUKWu0Q5Yv54pI75G6dy4RPC9eVoMGMU/5YGZRX32Loz1Iw4nY9Ve
	PjNbTrmwwzv8ZPVsx3GQbi7O7Rn5rfr2zGPQjBSteA==
X-Google-Smtp-Source: AK7set/wYfew/S87iDb3VaWXu2iNv5m3zbr3LtoBY6xbQTS8k+mjcCNnTaN9ydfaUUCa2bmfVDBObg==
X-Received: by 2002:a17:902:cf46:b0:199:1682:9175 with SMTP id e6-20020a170902cf4600b0019916829175mr8306256plg.8.1677096235875;
        Wed, 22 Feb 2023 12:03:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c24-20020a170902d91800b00198e397994bsm7088660plz.136.2023.02.22.12.03.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 12:03:55 -0800 (PST)
Message-ID: <63f6752b.170a0220.51038.d282@mx.google.com>
Date: Wed, 22 Feb 2023 12:03:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.167-cip26-192-ga2cd4acb16b2
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 12 runs,
 1 regressions (v5.10.167-cip26-192-ga2cd4acb16b2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Feb 2023 20:03:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10791

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 12 runs, 1 regressions =
(v5.10.167-cip26-192-ga2cd4acb16b2)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.167-cip26-192-ga2cd4acb16b2/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.167-cip26-192-ga2cd4acb16b2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a2cd4acb16b241aa1a262f5213f9c4e8ddfd0714

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  86f0584539eb1567f009f3e38be6940830649b92 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f666364253d1295e8c86c7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-192-ga2cd4acb16b2/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/ltp-ipc-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-192-ga2cd4acb16b2/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/ltp-ipc-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/63f666364253d1295e8c86=
c8
        new failure (last pass: v5.10.167-cip26-2-g1e87e7748b91) =

 =20

