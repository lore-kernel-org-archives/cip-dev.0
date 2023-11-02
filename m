Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19323C001DB
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 17:49:20 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web10.38680.1698947355982418351
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 02 Nov 2023 10:49:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=TXOcvUAq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1c9b7c234a7so10609035ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 02 Nov 2023 10:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698947355; x=1699552155; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pR3hBEynN3Bi5z5Ui70l/NWLPGPPtUv78g46PBPcNTs=;
        b=TXOcvUAqzfJ7htGUQ5kallRKcFmTvEsKz90xztuCBlo/TW9FArAqCbP8pBqXmXRV0m
         Zy8MvbCxskiZqZrV4a5Fl4VNpd1oZjEELcxo4BeQ5YdCwqX6US9UvJPciRRsYQXyyOrF
         1LfPGaHiK7dJaoYcovJ89gcKzGFrLZ/YZY/m4DhVgGZAlfP34LEvwFJntAAqiu6WVIuK
         wDovqopxwTXEsXs9G7ewt29pf509Cztasc1yfR5righ+4Tits19k0TGdD/a7NmNrFriz
         sEZT0MBT5ZKw6WSZLNEwvX+UyX6jHFPaQClwiDTQdGoitoMA3ZtljyU51ScAr6cY2cGY
         JmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947355; x=1699552155;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pR3hBEynN3Bi5z5Ui70l/NWLPGPPtUv78g46PBPcNTs=;
        b=PAeL3/isWQFgSdE6T7ryr7VI3G8sZ4hpaO+cLJI6xwG6NhBrOum5CdJX37kcx+71TH
         Qklu71U5qgJOBBpLGPXImG0owJwu9nC0gezm1SJhGSiT0IeTTS4YMfX7HDdQ6/nbiSJX
         w9Zmegu94Bxr5Y8SyOXdsqNIZA6wPBStP/hn/ach5Is5YYuDlcjsN9jNRfMw9sM050aA
         n7kyuK74d5Y4+8hGmg06+wjPUfgfLNH1bBAPilfncdXamrT3O35Tys4Sh08ZVF2hATB2
         15YklTMCkqoa5P3Tx68U3CZoevv3EwEQdVdJIpjdm87ljOl+BYVcxDWpPpjQnVWjqwsm
         2wrQ==
X-Gm-Message-State: AOJu0Yx6g+4cDoq8kFVhBj4NYzqDQx7h4daZEWtBEhekqCuavpRzNI2H
	HxjVfmAtB6x3S30CQ5qbYUKrWSlbA4/KLQUWMRL5qQ==
X-Google-Smtp-Source: AGHT+IFx2DNQrj9+T7aOq6if6zD5YZceJBxj0tNeFvZkS7rAen8YWiCTxIggr/iVbgG3P8eCvxp6KA==
X-Received: by 2002:a17:902:dac4:b0:1cc:5c49:6b10 with SMTP id q4-20020a170902dac400b001cc5c496b10mr10403903plx.17.1698947354794;
        Thu, 02 Nov 2023 10:49:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ji5-20020a170903324500b001cc2dc61c99sm31345plb.22.2023.11.02.10.49.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 10:49:12 -0700 (PDT)
Message-ID: <6543e118.170a0220.3be84d.030b@mx.google.com>
Date: Thu, 02 Nov 2023 10:49:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-cip39-915-g96fa7f16cf02
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 10 runs,
 2 regressions (v5.10.194-cip39-915-g96fa7f16cf02)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Nov 2023 17:49:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13525

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 10 runs, 2 regressions =
(v5.10.194-cip39-915-g96fa7f16cf02)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.194-cip39-915-g96fa7f16cf02/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.194-cip39-915-g96fa7f16cf02
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      96fa7f16cf0228e65eeaeaeef1b73f242f4e169e

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6543cb8208948e7788efcf3b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig/gcc-10/lab-c=
ip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig/gcc-10/lab-c=
ip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6543cb8208948e7788efcf=
3c
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6543cd94642ade6ca5efcf41

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6543cd94642ade6ca5efcf=
42
        new failure (last pass: v5.10.182-cip35-289-g3c0549540706) =

 =20

