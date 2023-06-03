Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35F7C7EE2D
	for <webhook@archiver.kernel.org>; Sat,  3 Jun 2023 17:43:26 +0000 (UTC)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
 by mx.groups.io with SMTP id smtpd.web10.2044.1685814197332841901
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 03 Jun 2023 10:43:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=VujpoQi+;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.172, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-39a3f26688bso2672514b6e.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 03 Jun 2023 10:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685814196; x=1688406196;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T2dwbg5lJwtmqJqbPU+UtlF4OB2fhrzy2faXCtglhHk=;
        b=VujpoQi+c1TTjstFtUQ9mHnv1ulXtOgwZQHPSUw9A9zldYo5LVstpENmuJBmSGSjPF
         ytngErqK7+yeW8s7DV3jFnt02dhqb7/uH/2unqydPYjXxRAPBHgLId7laWM+sPc++XrT
         dYfBt6Rs10ShtuRa1a9ode/n23uWTkgXydSdGhCAQHLeb7KkhDDXapvTsRAaSP0UJglb
         ZC4cHVcEf3cZsc/9HnkMK7OSRjjvjZoqfnaf6GdMwNznPtMTYlur5PyHWZA3JZ0vjDz5
         gr2KXi1/MFcs0XFMbFnx7TrW7836vScbXMq+5beK1Fg6mxXUcTDtexw3f5LJP6Oz47WJ
         u30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685814196; x=1688406196;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T2dwbg5lJwtmqJqbPU+UtlF4OB2fhrzy2faXCtglhHk=;
        b=BtAIPG8rCzYZkYgjMKjFowK6tUZ/K9fIqKz/ZYKE4oE22ko0DDIqJ6QJSdMtBnpP2X
         7D3YT9iIbP5/qdIwG76/94ZlHMdF17uZgpZhxDYRNvjXahA87fS1I8ST+f/LZR14Blx4
         vZ4Q9VUq1fyzx2VAka8hAVes/bdUuvphGpFqyC3+S4M9nKYO5bt4Cj+9MYOiftBQ9Hjz
         /dGS340bfiAbeFVkx8LhOQ9coN+VPm9bt/SO7u+ppY1DsQ2E2QZD1Zlc0j8YZzzNgEWC
         q5ocFCpp++W1GXBopakM9jCaFdxdaC8YPtyXZAgiKV2IrhyG0Pl9cR3X5UBKoT8AOHEP
         FKyw==
X-Gm-Message-State: AC+VfDyM5yCIm7MAKc3m4EGLO5jD1xFz2hGjp+ufdDkR8kP4A+CFsAm9
	7Mbfn5NOlx6injGT873wKBl3F1y+YYA0l1uwiVTiOg==
X-Google-Smtp-Source: ACHHUZ5GAOviv/S1V0DBNCwylV5Q1accIy0VTgyL4wm8ddCB+tQG1ItnZ0lAwDFMBs8nT2Oyo0wu2w==
X-Received: by 2002:aca:230c:0:b0:398:2cfa:85e7 with SMTP id e12-20020aca230c000000b003982cfa85e7mr3387119oie.11.1685814196220;
        Sat, 03 Jun 2023 10:43:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f23-20020a170902ab9700b001b1a2bf5274sm3463302plr.22.2023.06.03.10.43.15
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 10:43:15 -0700 (PDT)
Message-ID: <647b7bb3.170a0220.60f98.658e@mx.google.com>
Date: Sat, 03 Jun 2023 10:43:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1281-g84d5372e0f31
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 8 runs,
 1 regressions (v6.1.26-1281-g84d5372e0f31)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 03 Jun 2023 17:43:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11756

cip-gitlab/ci/pavel/linux-test kselftest-futex: 8 runs, 1 regressions (v6.1=
.26-1281-g84d5372e0f31)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1281-g84d5372e0f31/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1281-g84d5372e0f31
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      84d5372e0f314fb85258229768641315d1a95773 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/647b783f4f70554631f5de29

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm/multi_v7_defconfig/gcc-10/lab-broonie/kself=
test-futex-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm/multi_v7_defconfig/gcc-10/lab-broonie/kself=
test-futex-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/647b783f4f7055=
4631f5de2a
        failing since 13 days (last pass: v5.10.179-cip32-471-g18129e1b6869=
1, first fail: v5.10.180-cip33-11-gfea7994097935) =

 =20

