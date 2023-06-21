Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54872EB64D7
	for <webhook@archiver.kernel.org>; Wed, 21 Jun 2023 20:03:39 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.101.1687377813563626760
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 21 Jun 2023 13:03:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=ahCC9mvR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1b52bf6e66aso31485555ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 21 Jun 2023 13:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687377812; x=1689969812;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=02iebrSsXJNiHZpJGEnD3+VKzVWodOyOtb5dObcF7ZA=;
        b=ahCC9mvRPSxdiyVCE12zkRxe/rUM4iUFXfG4p/GgBOomxn1I36W1AfLmy706vgIA/p
         f+I0Zv2mtRNCKgcSUHGmgdXQmX6u4BVaOU7aOTYICaZ80IuGVrxtLTmrv6Xni8MGYzkF
         lvf7NIJlnzu7Zc4YFYQonKrnJ8HSi7dvI5YLK7g4atXlw4zXSBSyaRUHf2hMVD4CP21w
         5NtcpxO4TIhVQwC9LiQr52ixKto2EWfYy6tjAMp59YCN8jfJ6w7u0sVm0SjmxCnSfIc2
         2JRQ1/FOjkx7y3Te5br9rirvvGlW2EcyJ6zKQ7wYm314qro13XX+bVNaUX2T//O7Tg2O
         OXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687377812; x=1689969812;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02iebrSsXJNiHZpJGEnD3+VKzVWodOyOtb5dObcF7ZA=;
        b=c0qlPmUD0jvEywSwBLHKy0Tlx/YrPhzprC1VDw+Vk7Rm2i+fupCJZqLVKFo2bKvzjf
         MSDfrtbkMwhVhHFT/dnTC0mUFHuDvjdeL8NDEX83s/I2OxnV73e97Egg6z4cGAkoH/7q
         f+g30PhHU45xkZ6IWtiwyLNZsCC9fwP9Njws7jXEjDjOhVpAfGGv4sJeAKa7AcrcQSIR
         UvsCnWye8XP3J9IIJzcBopr//OPGhZK3E559SJr6uli8MnYU6HbP8moMgL+4i9r1i8cS
         PGLPsAnwlJtqPDdf2TGQ610C1nAdhQWriJx4HegieKwbzLIt9O/rhO//9LFdNNheZwY1
         NQVw==
X-Gm-Message-State: AC+VfDxhJKl1lNicJM+2lRHim/ow3sJZ6MkEFxd9GSMFy8EHgwnliqBq
	Z+eIC0+GccapUYPL2MJOGqnsHS0Wmz5MoG2PgMC4Hg==
X-Google-Smtp-Source: ACHHUZ66cl7u7193Wgl2LGB2xlKmRHaw9l0BW0mibL1E1zhej02bnamkfeMJ+iRuypvUD1L9wn0GeQ==
X-Received: by 2002:a17:902:d2cb:b0:1a9:40d5:b0ae with SMTP id n11-20020a170902d2cb00b001a940d5b0aemr7443551plc.12.1687377812578;
        Wed, 21 Jun 2023 13:03:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id iy22-20020a170903131600b001b04b1fae4dsm3913713plb.35.2023.06.21.13.03.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:03:27 -0700 (PDT)
Message-ID: <6493578f.170a0220.d545a.9441@mx.google.com>
Date: Wed, 21 Jun 2023 13:03:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-289-g3c0549540706
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 14 runs,
 1 regressions (v5.10.182-cip35-289-g3c0549540706)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Jun 2023 20:03:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12103

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 14 runs, 1 regressions =
(v5.10.182-cip35-289-g3c0549540706)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.182-cip35-289-g3c0549540706/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.182-cip35-289-g3c0549540706
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3c0549540706be602c1cc58f7ebdcae39509baa7

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  97c2fdb137a68e1eefed07c900db1a862edcdbf8 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6493520fb5d985d438306151

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/arm64/defconfig/gcc-10/lab-b=
roonie/ltp-ipc-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/arm64/defconfig/gcc-10/lab-b=
roonie/ltp-ipc-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6493520fb5d985d4383061=
52
        failing since 7 days (last pass: v5.10.182-cip35-8-gc3d08808cfa7, f=
irst fail: v5.10.182-cip35-191-gf4efde512959) =

 =20

