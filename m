Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E84C624B4
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 12:20:57 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web10.89392.1700742048661026030
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Nov 2023 04:20:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=nAzNEMzi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.171, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5aa7172bafdso574366a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Nov 2023 04:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700742047; x=1701346847; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Hl79EtZ51ZKJUhl3tIsKLAElNbyA3VJ8cu7oFeBDd6A=;
        b=nAzNEMziB1KbnkKqxMfu65KqnhAjlBaO8+u1k65PlfuDv76/cHd92qS58n0XY3dzuz
         orNQ41gSTaGPngvLsfJxs9uznfumooodxtJXz745yOKde+HEbar6L5s3mO23YYHwUJki
         f0vijV1Z+4NmfPR2Nkrzy5Dd09peWYZJ0GmgbDgWR9SzdyCZ/Qj/nhsrGobuLzgqvkbv
         Sc9ASlQqZutIR62WBCDSULzpcEbcbM6+r5kCKe7w5lgkjV9C14xGSBqQBpHjZSmUm4GX
         sn/22ybxuF4fzZK3Gr8ayob6bEhM+jF6frpRpNGsSidq015mzIhVhLgt56fZqST2eYFd
         MSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700742047; x=1701346847;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hl79EtZ51ZKJUhl3tIsKLAElNbyA3VJ8cu7oFeBDd6A=;
        b=hiLd/iiIb6W1ejQq8kpGOxteHks0JOF0Obm5j69fQ5HB4suxfEwC3DLk7jzuoMyYrO
         /qZssBiGzxNEXKfwAW2YTcLCB/MZxI5erncyW/m1ov4z3duhIV0i24ZTTdKI5+0hHmT4
         aLPJjaLaI6hFjFZL0yd815QdfOdfOzzTz9XaC4VIcL7S3iyMFjH/B11mCV+fiTfWgheb
         iGYoFeJi8A365cTc5E7osPLz8dhRHmHGMllyhM/0vjoIVHHNkZFUWSjWvcR8L+fLCRbE
         IMaR+UqePGqnH5GiuX2X85zMKftQWpqqafnQBFzxiSgmiu23T4YzRPlKaWMj+vPLO+dv
         arpg==
X-Gm-Message-State: AOJu0YwyDxuO9QV8cdR3Bx8k2kxtFBa1c4GKsmp6NlKsPGYOIXelyoza
	RrBv3/E/EhGkg5t4WCwpArVX9QtG5Habu+NbLZY=
X-Google-Smtp-Source: AGHT+IHzJUHY+GfDBG4Dw55jHPchqYE2T43fD2vKvPrH0vPZ5wmCsYjRTJzFPWqgCagR4VAnPWZh5w==
X-Received: by 2002:a17:90b:1d0c:b0:27f:f655:e14c with SMTP id on12-20020a17090b1d0c00b0027ff655e14cmr4899345pjb.42.1700742047559;
        Thu, 23 Nov 2023 04:20:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902748c00b001c9d011581dsm1222400pll.164.2023.11.23.04.20.46
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 04:20:47 -0800 (PST)
Message-ID: <655f439f.170a0220.b83b9.2448@mx.google.com>
Date: Thu, 23 Nov 2023 04:20:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v6.1.62-cip9-13-g34c303883a305
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 3 runs,
 2 regressions (v6.1.62-cip9-13-g34c303883a305)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Nov 2023 12:20:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13664

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 3 runs, 2 regressions (v6.=
1.62-cip9-13-g34c303883a305)

Regressions Summary
-------------------

platform       | arch  | lab     | compiler | defconfig                  | =
regressions
---------------+-------+---------+----------+----------------------------+-=
-----------
r8a774c0-ek874 | arm64 | lab-cip | gcc-10   | defconfig                  | =
1          =

r8a774c0-ek874 | arm64 | lab-cip | gcc-10   | defconfig+arm64-chromebook | =
1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.62-cip9-13-g34c303883a305/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.62-cip9-13-g34c303883a305
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      34c303883a305f474c4a18745cf56101db5e9b39 =



Test Regressions
---------------- =



platform       | arch  | lab     | compiler | defconfig                  | =
regressions
---------------+-------+---------+----------+----------------------------+-=
-----------
r8a774c0-ek874 | arm64 | lab-cip | gcc-10   | defconfig                  | =
1          =


  Details:     https://kernelci.org/test/plan/id/655f3af58934af572e7e4a7c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-13-g34c303883a305/arm64/defconfig/gcc-10/lab-cip/baseline-cip=
-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-13-g34c303883a305/arm64/defconfig/gcc-10/lab-cip/baseline-cip=
-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/655f3af58934a=
f572e7e4a7d
        failing since 3 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543e,=
 first fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform       | arch  | lab     | compiler | defconfig                  | =
regressions
---------------+-------+---------+----------+----------------------------+-=
-----------
r8a774c0-ek874 | arm64 | lab-cip | gcc-10   | defconfig+arm64-chromebook | =
1          =


  Details:     https://kernelci.org/test/plan/id/655f3ea1f687c28cd17e4a9c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-13-g34c303883a305/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-cip/baseline-cip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-13-g34c303883a305/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-cip/baseline-cip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/655f3ea1f687c=
28cd17e4a9d
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =20

