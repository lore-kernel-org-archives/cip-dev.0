Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AC4C10F1D
	for <webhook@archiver.kernel.org>; Wed, 21 Dec 2022 20:44:36 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.29880.1671655466465961081
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 21 Dec 2022 12:44:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=b5NUNIP2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id 17so61777pll.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 21 Dec 2022 12:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p7GIXKwlAqCh3a/wTYO4RspUHX4BAznKMSi0+OMs4tw=;
        b=b5NUNIP2NkLvknK0vPF6Y8z9/IG23RAoMPUxE/QbsGuJt4jQAuJTP9rPprplFotx8C
         un9x2mBozx/3777mL6/XRRCrAiKKaMjmeG8sHy04QBpEBpNqi0rp3OK+Nm7nq2y9nQ8G
         55weMAZa/2ugSaP78nJr+BeuAfJJq8lHKmfihTmia3CAgk+EYJDRLBU5/mTrOoGU5Fux
         PWm7ZvjrK+IYlv054fttD7I7YKgoQx0KHi73e9Dy6eaemMkft6xRVCrWIlJlJyxBzVjD
         a1fcB/D5ePjy7aWLeXXDKx/p6F6HlEg9OcwwaViFinikSaTXhE1XiOui8K3kS7wQLNkd
         ngcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7GIXKwlAqCh3a/wTYO4RspUHX4BAznKMSi0+OMs4tw=;
        b=f+rp99BG3AJqNl0+IKFSHfOuyBLFVn2zw6Q5INZ9gUlFrinXDyU7ias5/yc7FwykHk
         lNmpEjR6JaEn3OeMpdQLjuT0t5koZ97cP0opgoDzWEAnQYFzFg7ozQ0EDuZ/CZkxDuMK
         mS2d4mIN2KoCwYhsxU0/Jghi5TxXkECs4ilOCZLBdIZAEsio+LT7LjCpos7rbLXo8Jd4
         0wdp6ofrIE/nhskrJuHGLXCBkg1xkYEJXTboAzokzpFWvIquQ+VG5td7SL4y8CYnqvGa
         d6vPObnPghFFskQVk5RJbxGjvQj5ztBMrqTQ1kQf/k2b5mFxTQRkdm2OqjbMAnbQgTXv
         mZ2Q==
X-Gm-Message-State: AFqh2kpVb+WOu570vGbOsceWtuo3D60vF92d6MbjFAdpINy3LY9wK9eW
	Ip56UuXABnFJTLNsmKm2sBgYjX+KSvy7Nxg4h5Q=
X-Google-Smtp-Source: AMrXdXsSlCj7YML1cLIVzSinxwxjo+ekwCNhY9X5Kd1J1SecKON+TDC179O0hT5P0qcuHzoAD4XOyQ==
X-Received: by 2002:a17:902:e742:b0:191:2f59:9041 with SMTP id p2-20020a170902e74200b001912f599041mr4175417plf.44.1671655465708;
        Wed, 21 Dec 2022 12:44:25 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902cf0c00b001895d87225csm11930285plg.182.2022.12.21.12.44.25
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 12:44:25 -0800 (PST)
Message-ID: <63a37029.170a0220.dc271.65e9@mx.google.com>
Date: Wed, 21 Dec 2022 12:44:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.158-cip22-142-g79bb6f9db05d
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 8 runs,
 2 regressions (v5.10.158-cip22-142-g79bb6f9db05d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Dec 2022 20:44:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10260

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 8 runs, 2 regre=
ssions (v5.10.158-cip22-142-g79bb6f9db05d)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip      | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.158-cip22-142-g79bb6f9db05d/plan/kselftes=
t-futex/

  Test:     kselftest-futex
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


  Details:     https://kernelci.org/test/plan/id/63a36ed7aa821014cb4eee1b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.158-cip22-142-g79bb6f9db05d/arm64/defconfig/gcc-10/lab-b=
aylibre/kselftest-futex-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.158-cip22-142-g79bb6f9db05d/arm64/defconfig/gcc-10/lab-b=
aylibre/kselftest-futex-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/63a36ed7aa8210=
14cb4eee1c
        failing since 139 days (last pass: v5.10.126-cip11-116-gef362fbbff5=
28, first fail: v5.10.131-cip13-431-g420b8f43ddc46) =

 =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip      | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/63a36158cea4da1ad04eee35

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.158-cip22-142-g79bb6f9db05d/arm64/defconfig/gcc-10/lab-c=
ip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.158-cip22-142-g79bb6f9db05d/arm64/defconfig/gcc-10/lab-c=
ip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221216.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/63a36158cea4da=
1ad04eee36
        new failure (last pass: v5.10.147-cip18-468-g86403a07ae1c) =

 =20

