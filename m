Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80639C61D97
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 12:07:16 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.134058.1700827629075006041
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Nov 2023 04:07:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=YXgfPr3F;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1cf856663a4so12905725ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Nov 2023 04:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700827628; x=1701432428; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IWgEijicxJs8p9tVf3rxgtO3OlZxhXq21tUxdT4niUY=;
        b=YXgfPr3FaAU+2enkcp6WB96Qpvp3JuR8touXatBkkVEn0pJHKU55Ah+TqvtNpb6aog
         uaDlbw6JFSxOvfrZNXvttGeKCkYiPTQWeIACmkYTfW2NDHheyIV01gWDmJYtcU/pM/CJ
         3Mwr8lXN44rcTiocdEXIqzGhBSl1osf5P9QKFol7f2LQmbm7Pch5IEsFT8OARCIVEJEI
         R1RRwPWLSzPUayAxv4UCIOsVyTAF7qD1uypqc74z/Kw9l4RFq2kT78MdhobBR/bYKtTx
         5pSJwi8XM8Ktf8tURfL/FByaZTVtLFNW//JZpxTxMzjXNndP8DBphySXxpGX6iyQWyz8
         8F5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700827628; x=1701432428;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWgEijicxJs8p9tVf3rxgtO3OlZxhXq21tUxdT4niUY=;
        b=wmejCb/s7OfRLcA2wGo4R/itsoC2MVtXv4qfKcK3jhvmfjfyNmrEMfkhTlwt4+6u4Q
         IWEcrijh0ZgB+IpNyph2JSqZ6dXXlIgH96mfPo177/Os2HqcaPDEMB1tksmgLuJBQW00
         LTKAvoquaDj7m4bt4SEuBeu0if8qgCGX2gjsiNPaG6sLM9dcNRJjdS1ogCqImn23y/ui
         t604u3mQPB/vrYWbPhkw5/WoXhpLVM468jEoBiJUdCkbUjN2d+P2AdsD4HxggaT4WLup
         s/NKvPg+J5NzqmNwRNlJfb5kk5e4pvOf4WhuTOS8c+u8n5tiVdN4pnNXp1Ys8bD6ELaF
         jaQA==
X-Gm-Message-State: AOJu0Yy1GncIwaunY5fPllMsLkAWZtp/lAmfPoz+qnw8KtSJ2QP7TF/q
	/ywRaYyBalUtNhO2aOVdl85vC+SYgHtkRKGFwXk=
X-Google-Smtp-Source: AGHT+IE7cmdYxx773H8cwavCIkjxH7qZIcbnk2RPY+ccYREPf6sPaN/P6420RzfbHaKEri7BrciBig==
X-Received: by 2002:a17:902:ee94:b0:1cf:54e9:88b8 with SMTP id a20-20020a170902ee9400b001cf54e988b8mr2502899pld.20.1700827627888;
        Fri, 24 Nov 2023 04:07:07 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a4-20020a1709027d8400b001c9d968563csm3042592plm.79.2023.11.24.04.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 04:07:07 -0800 (PST)
Message-ID: <656091eb.170a0220.21820.6e38@mx.google.com>
Date: Fri, 24 Nov 2023 04:07:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.201-cip41-11-ga539098fe70dd
Subject: cip/linux-5.10.y-cip kselftest-filesystems: 9 runs,
 2 regressions (v5.10.201-cip41-11-ga539098fe70dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 12:07:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13728

cip/linux-5.10.y-cip kselftest-filesystems: 9 runs, 2 regressions (v5.10.20=
1-cip41-11-ga539098fe70dd)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
    | regressions
-------------------------+-------+-------------+----------+----------------=
----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-11-ga539098fe70dd/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-11-ga539098fe70dd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a539098fe70dd29de0ce67ad5a39c40867ba5b2c =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
    | regressions
-------------------------+-------+-------------+----------+----------------=
----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig | 1          =


  Details:     https://kernelci.org/test/plan/id/65608ce89bdb80514c7e4add

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/multi_v7_defconfig/gcc-10/lab-broonie/kselftes=
t-filesystems-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm/multi_v7_defconfig/gcc-10/lab-broonie/kselftes=
t-filesystems-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/65608ce8=
9bdb80514c7e4ade
        new failure (last pass: v5.10.200-cip40) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
    | regressions
-------------------------+-------+-------------+----------+----------------=
----+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/65608452ac442b31bd7e4a7b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-cip/kselftest-filesyste=
ms-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-cip/kselftest-filesyste=
ms-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/65608452=
ac442b31bd7e4a7c
        failing since 50 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

