Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20A9C04A95
	for <webhook@archiver.kernel.org>; Wed, 28 Sep 2022 15:12:59 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web11.9097.1664377966851394502
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 28 Sep 2022 08:12:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=uL9Kt1zl;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id
 v10-20020a17090a634a00b00205e48cf845so2684159pjs.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 28 Sep 2022 08:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=+gzh9Cws0HQCzaZSu4uClSHtewPZK8wEIkxW/J9iBjs=;
        b=uL9Kt1zl+6QrqYTa75WwM97u4XxrBXtTJkc4K0WfNrwisdBGbLKOEkH4Xt/G3ek/4G
         Gk9lqTdfiqEqADFIFhPfwWnUbfLk4Tj1XJWfLGN0I1RSfW8X23cXqCgPlB3SjnBUl8Wu
         /9IUn1Nd4uuEpsTTk3XnKNeP81DgeNa7aUba3V4TpjtkEUbDCIJnigm8TefYWBocbK6A
         5dUVEg3vVe+cFiUbBxfy1koN3o47gciSI7JoTnk2w0xWtUp4jC29JSF0Ot2PTwEGaa9q
         mhDdNlBkeXop4L/zZIfB4MSuduycVofn+RMtOU44cKyBmU654mypuVW1jaPWGV0IatRP
         cDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=+gzh9Cws0HQCzaZSu4uClSHtewPZK8wEIkxW/J9iBjs=;
        b=gncD0q/PPhehP+8xg7VZQIaG6r1URIpftvwrL+sVH8zkQyJ5zbH3fQAckVDbRc7n1P
         UvUgVxfLW3AnmluU0SKwEGc+XSc7ak0D5nal2uWoQ9IFCq66RkUF2083GoAYzwy8/qGh
         WFSfz6ejXDU6wbpEBViUPFk5mu35GyFL2gy7Fdn9HOdPzHVSh53UogargKFERSPIXGB3
         uDj/mnq7pDF3VN8jTDDaOgOGU6XZtD+kYVndxvcUwiPnxki0+B1nDB86kWhs3VjqBZk4
         NQjnB8bfz8LPHZwMhxKK90nnLdg3lucZRmORRUsPzuf0sDwn/mLNVqUV90VbV7a0dUbR
         sgGg==
X-Gm-Message-State: ACrzQf01ntmHpYciAQ2awyFSolXWCbB6lba87ap+TJ7D+NVyj/ZSy+kN
	r+PO/uahPXoARj8adCR8nos7QO0iX/PNrI1r
X-Google-Smtp-Source: 
 AMsMyM4itjYfswCIRqjBWRfMZm5RHxvWUtk1MgM7R3a37z061mUvDOfw1YGvx6BuyFJGdGtjOxzUdg==
X-Received: by 2002:a17:90a:5ac2:b0:205:de77:72be with SMTP id
 n60-20020a17090a5ac200b00205de7772bemr9194678pji.24.1664377966092;
        Wed, 28 Sep 2022 08:12:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 t6-20020a62d146000000b0053e8368ec34sm4123295pfl.32.2022.09.28.08.12.44
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:12:45 -0700 (PDT)
Message-ID: <6334646d.620a0220.77c14.7343@mx.google.com>
Date: Wed, 28 Sep 2022 08:12:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-cip17-140-g62223aebb3a92
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 4 runs,
 2 regressions (v5.10.145-cip17-140-g62223aebb3a92)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Sep 2022 15:12:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9571

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 4 runs, 2 regre=
ssions (v5.10.145-cip17-140-g62223aebb3a92)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
beaglebone-black             | arm   | lab-cip      | gcc-10   | multi_v7_d=
efconfig | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
         | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.145-cip17-140-g62223aebb3a92/plan/kselfte=
st-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.145-cip17-140-g62223aebb3a92
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      62223aebb3a921dd8f6ae0008df527bf6bd30935 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
beaglebone-black             | arm   | lab-cip      | gcc-10   | multi_v7_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63345668cdd5720b77ec4ec0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/arm/multi_v7_defconfig/gcc-=
10/lab-cip/kselftest-futex-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/arm/multi_v7_defconfig/gcc-=
10/lab-cip/kselftest-futex-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/63345668cdd572=
0b77ec4ec1
        new failure (last pass: v5.10.140-cip16-261-g8fa62effa305f) =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/63345668cdd5720b77ec4ec3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/arm64/defconfig/gcc-10/lab-=
baylibre/kselftest-futex-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-140-g62223aebb3a92/arm64/defconfig/gcc-10/lab-=
baylibre/kselftest-futex-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/63345668cdd572=
0b77ec4ec4
        failing since 55 days (last pass: v5.10.126-cip11-116-gef362fbbff52=
8, first fail: v5.10.131-cip13-431-g420b8f43ddc46) =

 =20

