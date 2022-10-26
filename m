Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E98C38A2D
	for <webhook@archiver.kernel.org>; Wed, 26 Oct 2022 11:17:33 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web09.6386.1666783045029741625
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 26 Oct 2022 04:17:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=IWlG4aGw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id c24so13697935pls.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 26 Oct 2022 04:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kx4/YMo2mBiv0tp1zGyJhGPmlI58Bzc9DqwN4s/7sUU=;
        b=IWlG4aGwpda387yBtY6fYb8iYgLMg8IONr5t/e7c6hBVrE2owfReRpF9LC9cXtCrTj
         kfdcdlAvYbBqVAdMI9LYTy2RagOKNAHa0pjLq06DJy7koNCqNfpVG/xgd5WsYLcarFfk
         QC/AnzZqabIGDPuzwuzaESCmp8bFBXT7S8J+4fiawGH7Py0BH9HSU4FH1UUQk3MvNqKU
         9FvPAc+ie68rnMyQMDFsqjny9rAImkE8/S29CQ5rzr/Q+bq1IiTlaanx+o2Ohl+hkWIi
         Q2S1NLJ9lNI/czR9nEMFpZ16nncmjhUif+AXktmZlQQkhxIV1QZBM25gKmF2h77LUaVJ
         SDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kx4/YMo2mBiv0tp1zGyJhGPmlI58Bzc9DqwN4s/7sUU=;
        b=2gmZBnF+nn52btfrTxMG/JEKt126Fq+sHMqguclfU/cXDWhLqh902F3AiaZ+oEV08+
         4tvHKOxlpowJwq0cbq26Kk42+kI4OyT6YP49aQcJfD/0WkXO66GI0b+MFOpIVldwaW25
         DT8E9ZqV0H/wN1lC7Rin/a5MILavC6ZPRnxteXEpmC3EcxvF5Hatsb4OP9w741faPGRf
         yk2HVR46cIr4T/zYLGPLAJTNqZI4j0LlK1Jmlp7+1HJs4ejHtd+3YFr7xwvQnIa+eLYC
         Uz4Dc5Q9HAKZVjhh6cdb+rfbFp4DgAbgy967yCBDQyzyEaa569M6U8y50PDqhVGrGNtL
         a19Q==
X-Gm-Message-State: ACrzQf0QYVBRbKGms9qFivooQyDBt1/NPzGugHLskbuvs9g9qpeHFKYC
	jee6BVHnpMoE/QgOgUdq4bkhvRzRZe7Mqgdq
X-Google-Smtp-Source: AMsMyM75B2hdN7uaaM4I9fLkroTs/hrGnTRtLkRN0i2JMvS9x1sE2n96Y9EQsDtMbj4tS1f5rnv21A==
X-Received: by 2002:a17:90a:6845:b0:210:7ef5:ab99 with SMTP id e5-20020a17090a684500b002107ef5ab99mr3671866pjm.80.1666783044400;
        Wed, 26 Oct 2022 04:17:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u14-20020a170903124e00b00177ff4019d9sm2689805plh.274.2022.10.26.04.17.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 04:17:24 -0700 (PDT)
Message-ID: <63591744.170a0220.64daf.5a46@mx.google.com>
Date: Wed, 26 Oct 2022 04:17:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-12-g7bc9523ecfb7f
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 11 runs,
 2 regressions (v5.10.147-cip18-12-g7bc9523ecfb7f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Oct 2022 11:17:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9863

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 11 runs, 2 regressions (v5.=
10.147-cip18-12-g7bc9523ecfb7f)

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
Flinux-5.10.y-cip-rc/kernel/v5.10.147-cip18-12-g7bc9523ecfb7f/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.147-cip18-12-g7bc9523ecfb7f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7bc9523ecfb7fa7dc71764a249207893ef14174c =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/6359078d41a26c3d485e5b97

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-12-g7bc9523ecfb7f/arm64/defconfig/gcc-10/lab-b=
roonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-12-g7bc9523ecfb7f/arm64/defconfig/gcc-10/lab-b=
roonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221007.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/6359078d41a26c3d485e5b98
        failing since 169 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6=
, first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63590a6fa278f518d95e5b3b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-12-g7bc9523ecfb7f/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-12-g7bc9523ecfb7f/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221007.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/63590a6fa278f518d95e5b3c
        failing since 166 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6=
, first fail: v5.10.112-cip6-289-g2969e096d186) =

 =20

