Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1476CC48BF6
	for <webhook@archiver.kernel.org>; Thu, 29 Feb 2024 09:57:02 +0000 (UTC)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
 by mx.groups.io with SMTP id smtpd.web10.21174.1709200613609176893
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 29 Feb 2024 01:56:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=roAJolwH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.178, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c1a3384741so443396b6e.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 29 Feb 2024 01:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709200612; x=1709805412; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BjPA1mIwyH98dAl6ljpfg59c3F0olrKU77Tr3It6jjM=;
        b=roAJolwHVwaGU1sStl0943aqsSR6xOnabe2KGwYFFKaZxk9FVyK4trUorLDpepaHB1
         sDwF3Q2yfw20VMMfo7eFFItcwPqF6wT63vXpJswClgkXp2geZjSPHeK6UAgsC9TFuLEG
         TNPybT6ODFmEfCgy7g207PKnAI4tjjZo8M6xYkLSyGpjQhSA88fNpFdctROMnCzsYgEB
         ZXk1c3IV1Q/I4RJp3H+hdAgc4XkF8zBOnyWV5PZOBWIOfmeFlIuGMwmiJJ2I/i+KcHxE
         /B8aoCOM/EobejoiB0JnROCvyUXWzCJ8gVJzjj6QfPUHYNSgFrU2rRpoVhEo5waW17g6
         g/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709200612; x=1709805412;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjPA1mIwyH98dAl6ljpfg59c3F0olrKU77Tr3It6jjM=;
        b=LI7OdZJhstR+xedYSjjNJSedNRs4vkf1yreBIM5xWfYzCDwItdr2ExBZxWs2VhJmT0
         DEeQeV0z57KzYPKeZzC4Kp64ADai0ceB/KUP81pZCy9AX3TD21t0vx2IJyOr3HSisMwu
         oRgWl8ORU3wMqdtYrydxp2HvSWdAjlvvFF/fV/M8myJqrGzOhxn9O/7ztbUsaWScKJh8
         GJu4eOQXEOyZMPuP78oG4q4nqNFh66/gwWuD5L+e8lzcD8T7r3U36Imz3vKR8rt8a9+7
         xXW26vPxsAenfFw6igVAjRC0n/QfBfcuEDcWTGbtavGg5KeoXUY2tRJWg3edokhATENv
         0c9g==
X-Gm-Message-State: AOJu0Yyl04/ua7S6x1YzPnWIw6HsqtCfGaPN/C8yNwZM0dqn65W9mh9W
	m9qyWqYtScYC9qHUhZIfJKb55JrYTn3CtIqa5SQQusZAQrnUq2OYyt3FQl22sL0SszLQ/hx3U1I
	J9uU=
X-Google-Smtp-Source: AGHT+IHh7P4Wyho0mYHAyk/M5NGS9VVShI2ef0Zk2bD/J/qQWaBT65N1qmvUghCrlwbyupEiwFEtAg==
X-Received: by 2002:a05:6808:2090:b0:3c1:b3b2:e2d with SMTP id s16-20020a056808209000b003c1b3b20e2dmr1654622oiw.10.1709200612387;
        Thu, 29 Feb 2024 01:56:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y17-20020a62f251000000b006e4452bd4c6sm882136pfl.157.2024.02.29.01.56.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 01:56:51 -0800 (PST)
Message-ID: <65e054e3.620a0220.a4abc.27c8@mx.google.com>
Date: Thu, 29 Feb 2024 01:56:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-56-g55117716ac0fd
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 7 runs,
 2 regressions (v5.10.209-cip44-56-g55117716ac0fd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Feb 2024 09:57:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15105

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 7 runs, 2 regre=
ssions (v5.10.209-cip44-56-g55117716ac0fd)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-56-g55117716ac0fd/plan/kselftes=
t-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-56-g55117716ac0fd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      55117716ac0fd541adb5a35e66eb21c45107b040 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65e03f18dbeb1398c5637022

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65e03f18dbeb13=
98c5637023
        failing since 118 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/65e0445459708aadef637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig+kselftest/gc=
c-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig+kselftest/gc=
c-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65e0445459708a=
adef637013
        failing since 118 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

