Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5545FC4167B
	for <webhook@archiver.kernel.org>; Wed, 21 Dec 2022 20:44:36 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web10.30115.1671655466127673124
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 21 Dec 2022 12:44:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=HC4uXwLT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id u4-20020a17090a518400b00223f7eba2c4so3255906pjh.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 21 Dec 2022 12:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sru4HPQAaXegv9Pqcn+N/HFMEdUFJ1Pyy75npohUlRM=;
        b=HC4uXwLT2eltmRxdBxl9Wj2XTbSk/mxEptjm6vekw/ZHxqnFM3kjEVKAjQGTzY7qFg
         ewyXhSUskTaGNB4TnKgPZRUnN2PKuFrAB7OkK0IY67xIRxIWQp9SUzVEjMULwlkM0CRk
         VA64C5/3GuYprv2SMpLGa9haI8wWU92xWPlJ6BumYGoNid4q7inb6SmeQm/M+q9koczn
         0LzKrryg0cWJy0/pEWlMZTnLOsxvvZaHvueiDk1DCQNeww9jDGcMY5hIKP8E+sDDhSIz
         9KgmxNCYUBMVfZfe5VjksBXDc4DUcK+uFxb+AF9PLNHxXMFAdGmP7sz9Scu7gwe/Yxu9
         v47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sru4HPQAaXegv9Pqcn+N/HFMEdUFJ1Pyy75npohUlRM=;
        b=8Qcm+nPGC+13SKfcKklzYmtbtzivWfsWD//0n+PrRswanYqgGcQ19ziMLO3LDqw7kS
         dfHLp5rgKWs7T2S82OXQ+4aRG06J97G8rh1KIwG/e+XuSLehWNWyI89H0PS3dA/9j+Ec
         Ny/B3ztVjrlDu80ucs2reepg/ge73VKk/Xb1kyhXM6Ay6tW80cB6H7I/oxL/roda+vVQ
         p7LjEy56a5hE1mVHoSUC5AxdhYAR+oDYvY6T2IXGrk9LkF5CSuxbrQrZMmRFAr8hyOoY
         OZQ3Cxe86MEq5jH884TYyBydPhGWJ4LrdPbrQ/7NZptC13E2Kf07l7lJbUbdFuu9b/h3
         WVvg==
X-Gm-Message-State: AFqh2kpsAYu12zwdk16ikRjjaNIB2G0OCoO7ybgSgP8Zr9gTlCN9FCjz
	9Fs5jHMp1S+gXFYJizbskLPi1RkK7B/kHxkJLH4=
X-Google-Smtp-Source: AMrXdXvfou2Pge+pGnqImM/gaoU5ZeOcf25HzpK48+yUMAuAhkfVQ/5jSnlIMw9ryHYDxD0wGIidXQ==
X-Received: by 2002:a17:902:e34c:b0:185:441e:4cfa with SMTP id p12-20020a170902e34c00b00185441e4cfamr3210934plc.42.1671655465118;
        Wed, 21 Dec 2022 12:44:25 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id cp12-20020a170902e78c00b00188ea79fae0sm11872206plb.48.2022.12.21.12.44.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 12:44:24 -0800 (PST)
Message-ID: <63a37028.170a0220.39faa.62be@mx.google.com>
Date: Wed, 21 Dec 2022 12:44:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.158-cip22-142-g79bb6f9db05d
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 9
 runs, 1 regressions (v5.10.158-cip22-142-g79bb6f9db05d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Dec 2022 20:44:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10259

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 9 runs, 1=
 regressions (v5.10.158-cip22-142-g79bb6f9db05d)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.158-cip22-142-g79bb6f9db05d/plan/kselftes=
t-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.158-cip22-142-g79bb6f9db05d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      79bb6f9db05dca63bd1dd09dc84a45072dbc2ee9 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/63a36b7a3605f520e74eee40

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.158-cip22-142-g79bb6f9db05d/arm64/defconfig/gcc-10/lab-b=
aylibre/kselftest-filesystems-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.158-cip22-142-g79bb6f9db05d/arm64/defconfig/gcc-10/lab-b=
aylibre/kselftest-filesystems-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63a36b7a=
3605f520e74eee41
        failing since 112 days (last pass: v5.10.136-cip14-542-g97767707d3d=
0, first fail: v5.10.138-cip15-90-gd4130d0ee3c7) =

 =20

