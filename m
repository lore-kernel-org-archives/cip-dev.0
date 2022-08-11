Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF0AC19F2A
	for <webhook@archiver.kernel.org>; Thu, 11 Aug 2022 15:27:30 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web11.7878.1660231644030903669
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 11 Aug 2022 08:27:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=SZsV14EY;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id gp7so3582355pjb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 11 Aug 2022 08:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=ewqCkWE/v6i358Mp7S96P0cWpk3vd9sakE9rI6sYJBY=;
        b=SZsV14EY+MCz0nivLZC07GbpHcI284lzW82v3bnK7yCa/yBNgQZAGvdnBI5OUBTuRI
         7ilCxVIbNs8VWSwh7kjSMnpmATLVDuI9gkHAyAXca3ArHBvvIzfcSULw93S0/K8CDvQR
         MUpO8pNFn7pkGhZTc3dxzuI8FEKwZG9DrJ/S94XG2sJ4j7uMeAY0etroKGR5bzjEkULL
         I7y75BVlh2VJA9oFFtu4/T8GdQuIs8tYYqaV8Wq6ovTwoWjFb5PAcj6aKM+WdgyfxB1K
         eLq4oDLHVc7zq81aqsuxBVDt6L90LYERG8ZAqNuoMQTqqZqAhGy9CyH+4dSlI4aao+lv
         TwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=ewqCkWE/v6i358Mp7S96P0cWpk3vd9sakE9rI6sYJBY=;
        b=djOmDzLWNclg5LgfxffmDpsFllDdrc5ocrbGDTrwXqetYnI2nCqm9M6YMgdOwnjlnD
         BTup/5JKsG/ZBXsRbSHYHUNLyU7KK3++2E+0PDQbgoQ1leVGas80mFHZBJiZnN8l6FCb
         epCkw+k2nQtLXWBsy2EYBIq27VVLZnljOpr95BFobKDuHugYNw7IcCjQaSn5MbBGEGfG
         LAOECktn9k/rqXWPTn7hUy+ytV2IwUwMZrrXZXpbdAlX/rr0kKOfgKDETuuEi1tHFDYc
         lCGokqVxV4ec0radUoeP7J96mQuZgxjfcLugcn/k55sEpzwJt08BTTb/ge6QAySlN7X2
         cReQ==
X-Gm-Message-State: ACgBeo3jZgzHLwRT2GGDKWIz0fE9XFAewgsMCG2CKNJXI0yFAJLrdE6E
	i34h141+kBj0SjguxNpP5fhlej1j9c8vjJ1fV8Y=
X-Google-Smtp-Source: 
 AA6agR40K9g26PGS0L72dDX1+2N+Hfx3Vr9kX7faNV/gX6eA+Evh0LAokaLEsX21huOsFPSX73P/cw==
X-Received: by 2002:a17:90b:33cb:b0:1f4:f635:93f8 with SMTP id
 lk11-20020a17090b33cb00b001f4f63593f8mr9647742pjb.74.1660231643244;
        Thu, 11 Aug 2022 08:27:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 r11-20020a170902c60b00b0016dd6929af5sm14833939plr.206.2022.08.11.08.27.21
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 08:27:22 -0700 (PDT)
Message-ID: <62f51fda.170a0220.8dd37.9467@mx.google.com>
Date: Thu, 11 Aug 2022 08:27:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.252-cip78-146-g6acc38498265c
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc smc: 9 runs,
 2 regressions (v4.19.252-cip78-146-g6acc38498265c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Aug 2022 15:27:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9162

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc smc: 9 runs, 2 regressions (v4.1=
9.252-cip78-146-g6acc38498265c)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.252-cip78-146-g6acc38498265c/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.252-cip78-146-g6acc38498265c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6acc38498265c7429063eae4888e1bc9fd68ccd4 =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/62f5157fc29a9a5b3bdaf0a7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.252-cip78-146-g6acc38498265c/arm64/defconfig/gcc-10/lab-=
broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.252-cip78-146-g6acc38498265c/arm64/defconfig/gcc-10/lab-=
broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62f5157fc29a9a5b3bdaf0a8
        failing since 66 days (last pass: v4.19.239-cip72-68-g407458469172,=
 first fail: v4.19.245-cip74-32-g2d021d7a9e637) =

 =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62f515bb26497ecbb0daf0eb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.252-cip78-146-g6acc38498265c/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.252-cip78-146-g6acc38498265c/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62f515bb26497ecbb0daf0ec
        failing since 66 days (last pass: v4.19.239-cip72-68-g407458469172,=
 first fail: v4.19.245-cip74-32-g2d021d7a9e637) =

 =20

