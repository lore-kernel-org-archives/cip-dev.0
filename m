Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264E0C77B73
	for <webhook@archiver.kernel.org>; Thu, 20 Apr 2023 15:23:39 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web11.11165.1682004216992062442
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Apr 2023 08:23:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=S3VxAvc1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-63b4a64c72bso1004025b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Apr 2023 08:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682004216; x=1684596216;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6neekIp6YbzcHKHgOd9mWt3yFAR2ACX+Ecz8nZ+POK0=;
        b=S3VxAvc1WJunlDt3NX3bM4xXxh7i76/9TPalBKTokvmxgwGfSFIH7LrIph+yQ8BYQ+
         a7aG8dRDSrD8/XMN81AcIzUmdXCUYJ4Hb5HYE3geKE3Ts9GPw9BPKCrvV/O3raVITuQN
         G5qusGZJb2BjwDo3CSc4U48uxHFU2D0BkEi4yPUe9AFk3qzwkDiv9/NqUgsqrsPzMetf
         /54sajBCTdpDAxBd8jfw/k5Cjq9jLif67y2U2DXH1VVaRIjk2cqgSd0gYGw3bvlNsKCo
         MbWutp5bBmS+gis9OmQ44PhqS3DhAYSi34CMRSx1QOsmm7yNtQx/vsLUtfDQ+avvLwWJ
         xgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682004216; x=1684596216;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6neekIp6YbzcHKHgOd9mWt3yFAR2ACX+Ecz8nZ+POK0=;
        b=eikeU9+FdyewpLEeXwaVLopWJm8ynWzXOUIgdvj37P7Jr55ifkT7Gpfo9I8XBrxsKJ
         DnVfYc65ga9Gsw8mRel3OLcRhjuR9MKPPeBBqPIHWaPdjIiuMbwmZYPYQ/wDGyzVSUnX
         FfNlgXlXYOzsBi0gZRW2FYEvIaoEZPojQdr3DIxnF/+hhUivyNiI9XstmYCrV8S7eQ8v
         dY9g9GLZA/D7gqX+qBtnRLegri7mpINDG7BRdOYXNngVNuTIUOFWrDffrWiI6Ig6E4SW
         oapw8eGkyguXa+2wS3x3ahDMi7YjTdyYwf0qRubX3cCbya5ZkR4aHvqjumBqNp3ckWJR
         2Peg==
X-Gm-Message-State: AAQBX9feZDkUlmaiBS8CM/2HA7vGcscNEvnv8oJFMrHpADK7RNDX0EBT
	2BuGkxJNAHm9wxxk8tSPkn6tzix8f2X6FaM46HEWs+LG
X-Google-Smtp-Source: AKy350aguGT354wyjkf1aHcG8nNxxagZ8edCN7fITMWhwuI/rYdmEdblRnmoXjMK1ccTOCFfAMRh2w==
X-Received: by 2002:a05:6a00:1582:b0:63d:3ddb:5f3f with SMTP id u2-20020a056a00158200b0063d3ddb5f3fmr2514130pfk.0.1682004216192;
        Thu, 20 Apr 2023 08:23:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x137-20020a62868f000000b0062ddcad2cbesm1424225pfd.145.2023.04.20.08.23.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 08:23:35 -0700 (PDT)
Message-ID: <644158f7.620a0220.a54be.27ae@mx.google.com>
Date: Thu, 20 Apr 2023 08:23:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.177-cip31-122-gfb6ca504156b4
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 11
 runs, 3 regressions (v5.10.177-cip31-122-gfb6ca504156b4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Apr 2023 15:23:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11250

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 11 runs, 3 =
regressions (v5.10.177-cip31-122-gfb6ca504156b4)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =

qemu_smp8_riscv64            | riscv | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.177-cip31-122-gfb6ca504156b4/plan/ltp-fcn=
tl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.177-cip31-122-gfb6ca504156b4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      fb6ca504156b4789acc2b019a0aaeae91c6d73dc

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  458f3554675aace42e9750086d26799e82829f11 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6441528fe0431273302e85f7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/ltp-fcntl-locktests-meson-gxl-s905x-libretech-cc.t=
xt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/ltp-fcntl-locktests-meson-gxl-s905x-libretech-cc.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6441528fe0=
431273302e85f8
        new failure (last pass: v5.10.168-cip27-638-g0d599cd2b6695) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/644153b1cabdb350d92e85f5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/arm64/defconfig/gcc-10/lab-=
broonie/ltp-fcntl-locktests-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/arm64/defconfig/gcc-10/lab-=
broonie/ltp-fcntl-locktests-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/644153b1ca=
bdb350d92e85f6
        new failure (last pass: v5.10.168-cip27-638-g0d599cd2b6695) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
qemu_smp8_riscv64            | riscv | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6441482ac7b31495a12e8640

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/riscv/defconfig/gcc-10/lab-=
collabora/ltp-fcntl-locktests-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.177-cip31-122-gfb6ca504156b4/riscv/defconfig/gcc-10/lab-=
collabora/ltp-fcntl-locktests-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30414.0/riscv64/rootfs.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6441482ac7=
b31495a12e8641
        new failure (last pass: v5.10.168-cip27-638-g0d599cd2b6695) =

 =20

