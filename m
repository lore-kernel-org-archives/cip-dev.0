Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DD5C47DAF
	for <webhook@archiver.kernel.org>; Fri, 19 Jan 2024 01:02:43 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.10985.1705626157959234505
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 18 Jan 2024 17:02:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=cjFdee4H;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d71207524dso1253505ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 18 Jan 2024 17:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705626157; x=1706230957; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KS7wnZ0mz2aKX8ZlHT4zO3No/GmgrYsN9uSb2CPizJA=;
        b=cjFdee4HsgY3RZWUlL6KbqigzzK47Glc0gtUfb31dW5tuRhV/byIpY1nsEiRW5UPCk
         vsAlggyFX3ZOXlSTIoCSlIsfNXc8Abu30sMoAIHULEeIMahuK40O1l1+AaXpdUmeWuU+
         43U8MKnlMihd+/M8H5hq7qd4VNC5NfACIPkSds1fd/zLjwg1iL9DoJ5mnu6WklXVIlmR
         EVh+uSOylvETUIeyDnIRQK3HWiFFVpIR1ZLHJuaOS/VCrc8wO05fqMCPBbXLYAu/vWOa
         jXN1SXmMYovwC+1Iv2hMd7UeXwILWtt6mH2y/wfEMFjE/6j6HCbqlnn02jnPPIC/FbYg
         JnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705626157; x=1706230957;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KS7wnZ0mz2aKX8ZlHT4zO3No/GmgrYsN9uSb2CPizJA=;
        b=VQgK4HpYCkiER/u/QyvsaWSi4wvFJchAL8oumf4RokKSRxPbPcf48vDQlj8uyd2yOA
         xhacnzD9OMbP5iGH7lLVf4LG57wBt2CADUuI1mrrbtzObRIpA/Af2WsAYjJgeVygp1KE
         odnRdp2Dd5DwicQ9ALWQ2ta0KlEUxECIh2ZONcpWP0VcZe4QJz0Hz8ZzOaXcYeDzXVTc
         B5awwRYW7IZZamfy9piQSeMc9N3YajeoIskqEFez/mXPqDHrpbK/jJ9lMU4QtjlfhEEX
         dLHSXPJ8idXjs/FoizMGcCTNjIlAA6R3+n/j653df8BLSTmtKiA3+2mrTkIVFk3AK+Ld
         RVXg==
X-Gm-Message-State: AOJu0YzuD11cChe0PpRtam9Cd8LvsiTiXJkx98R9G291X0UpQjzg6vXX
	91cKoBkj/Ii8PBjKybdE3cV38yokosYbsndLaJfXVrhmMIe3mi91rleukA+95XlXiwStLeVsjuM
	kWS8=
X-Google-Smtp-Source: AGHT+IE0cnQwNZTlBqCYvb25ugJNKXtigSfUXfYDF81II34ExeD1lVpqt2Vyv7S/qT2aAS2i19iqvA==
X-Received: by 2002:a17:902:f80a:b0:1d7:308:b1f8 with SMTP id ix10-20020a170902f80a00b001d70308b1f8mr1558471plb.12.1705626156793;
        Thu, 18 Jan 2024 17:02:36 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j4-20020a17090276c400b001d5af7fbda0sm1937050plt.122.2024.01.18.17.02.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 17:02:36 -0800 (PST)
Message-ID: <65a9ca2c.170a0220.a9ab8.99db@mx.google.com>
Date: Thu, 18 Jan 2024 17:02:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v6.1.72-cip13-30-g79e2886a5da69
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 6 runs,
 4 regressions (v6.1.72-cip13-30-g79e2886a5da69)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jan 2024 01:02:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14412

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 6 runs, 4 regressions (v6.=
1.72-cip13-30-g79e2886a5da69)

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
nux-test/kernel/v6.1.72-cip13-30-g79e2886a5da69/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.72-cip13-30-g79e2886a5da69
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      79e2886a5da69a8a86ec82215b5e9e0748943546 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65a9bf70ec50615d8252a421

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65a9bf70ec506=
15d8252a422
        failing since 487 days (last pass: v4.4-st20-229-gb433f12afe250, fi=
rst fail: v4.4-st20-231-g7349cef09ddd2) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65a9c5bdc7a390cd9d52a4ea

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/arm/multi_v7_defconfig/gcc-10/lab-cip/base=
line-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/arm/multi_v7_defconfig/gcc-10/lab-cip/base=
line-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65a9c5bdc7a39=
0cd9d52a4eb
        failing since 487 days (last pass: v4.4-st20-229-gb433f12afe250, fi=
rst fail: v4.4-st20-231-g7349cef09ddd2) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65a9be9cdb630fb7fd52a3f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/arm/omap2plus_defconfig/gcc-10/lab-broonie=
/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/arm/omap2plus_defconfig/gcc-10/lab-broonie=
/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65a9be9cdb630=
fb7fd52a3f2
        failing since 59 days (last pass: v4.4-st20-231-g7349cef09ddd2, fir=
st fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65a9bdff22661454e852a478

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/arm/omap2plus_defconfig/gcc-10/lab-cip/bas=
eline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/arm/omap2plus_defconfig/gcc-10/lab-cip/bas=
eline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65a9bdff22661=
454e852a479
        failing since 59 days (last pass: v4.4-st20-231-g7349cef09ddd2, fir=
st fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =20

