Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D196CC4829C
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 17:19:18 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web11.3373.1707326358133382031
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Feb 2024 09:19:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Aki641T2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-296717ccc2aso24011a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Feb 2024 09:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707326357; x=1707931157; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zG6J8mXzBQfNAEwsIXq7QhWXFdj2FzC3hwxjI1YYx/4=;
        b=Aki641T2cJBcstTD0ysXbqI+qmS0PwpIx08+YaLHBb513WkAEx7Qbikdeg937JtHVF
         mohNBvvuWr5y4oo3u0UAb55uvORxevUaDitO0D8tFymVObyrkXzYZPAsP02zvYYoIcnc
         0QuF/1yetYxLSr2W7GdicdYVSIQcWMzH16hvYUaMfIrhYOfLMp5iQbzlc/xewYhKUp0J
         JqTZrherOJocjqb2RXBMsArOasZEbb+Fuq+VmhkKwQ3TfjgxgDPPmWCsCI9lUjTZTaB6
         r6XQHysGT3gSsnuVNdVXI01OvEQlLlXScDKw3NTYpUD5H1g9r8GC+V01rCQih+Fs3qf9
         teWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707326357; x=1707931157;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zG6J8mXzBQfNAEwsIXq7QhWXFdj2FzC3hwxjI1YYx/4=;
        b=ln1w7uOtOvi429/kE1zgwuzCYzarK9I0NfJG9R13Ojj9q7eN3zIwpGZurnO6h0IZV9
         XWXJllsN2ExFt99Wdfef4bPFrx7RvEcsYppTHx46/1qZVAAzpXH0xb72AgBjESZ9qZDA
         f2cH1vwb/+MrfJMUPyk7Z1vAI5RQK7rmruQ8U+XY2ZoGmbvCjtdqQerQPL0eqCgR+TsL
         LcASup96snHGGp8XiORBJjJKOcrAV5gS5qsvZjkkoriftlNWLCSCP8bpJHnXOJTBOMII
         IHVkN0Tm2rEAsSYky/ZKsxolZ29ONICBUt0Xi9AZ2iqlXg6ttRq8rrkoVvbxPecFonDU
         jKbQ==
X-Gm-Message-State: AOJu0Ywfs84+11YTZBpRWExaDWVNCZfYFcZk48zAU8QJAVeoV9W3ukBW
	r4xVwTaX9O12Az0s3evXkjTVWHrP01ms8hmiAFMs9CamhXNrVfsLuNdJpyrosaJAgwv0US4VQ+J
	1ccQ=
X-Google-Smtp-Source: AGHT+IGeSQXSZJm8KgcL1b7gznbDKHhmFbR5gjkeTqXlGydU+b5geKXQ/tfEjzERvT/7T2YbYZOZrw==
X-Received: by 2002:a17:90a:6343:b0:296:94cb:4cfd with SMTP id v3-20020a17090a634300b0029694cb4cfdmr213898pjs.11.1707326356879;
        Wed, 07 Feb 2024 09:19:16 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id qd3-20020a17090b3cc300b0028ce81d9f32sm1993491pjb.16.2024.02.07.09.19.16
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:19:16 -0800 (PST)
Message-ID: <65c3bb94.170a0220.309e9.650a@mx.google.com>
Date: Wed, 07 Feb 2024 09:19:16 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1251-g57b839f015944
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 6 runs,
 4 regressions (v4.4.302-cip72-1251-g57b839f015944)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 17:19:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14887

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 6 runs, 4 regressions (v4.=
4.302-cip72-1251-g57b839f015944)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =

beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig  | 1 =
         =

beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =

beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip72-1251-g57b839f015944/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip72-1251-g57b839f015944
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      57b839f0159440df3a9c4b22dccee20e801350a7 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65c3ace7da6196049c8e1e80

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c3ace7da619=
6049c8e1e81
        failing since 507 days (last pass: v4.4-st20-229-gb433f12afe250, fi=
rst fail: v4.4-st20-231-g7349cef09ddd2) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65c3b3e27437a598ea8e1e7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c3b3e27437a=
598ea8e1e7b
        failing since 507 days (last pass: v4.4-st20-229-gb433f12afe250, fi=
rst fail: v4.4-st20-231-g7349cef09ddd2) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65c3adeb541609aac18e1e79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c3adeb54160=
9aac18e1e7a
        failing since 79 days (last pass: v4.4-st20-231-g7349cef09ddd2, fir=
st fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65c3baff86e0a97ae08e1e8a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/arm/omap2plus_defconfig/gcc-10/lab-cip/=
baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1251-g57b839f015944/arm/omap2plus_defconfig/gcc-10/lab-cip/=
baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c3baff86e0a=
97ae08e1e8b
        failing since 79 days (last pass: v4.4-st20-231-g7349cef09ddd2, fir=
st fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =20

