Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D62C54E49
	for <webhook@archiver.kernel.org>; Wed,  6 Mar 2024 22:46:55 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.9705.1709765211347240868
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 06 Mar 2024 14:46:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ujYPTjyF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc29f1956cso2101885ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 06 Mar 2024 14:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709765210; x=1710370010; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4mOwdOoNbr2a5KxBVQ1knEvkmsBd7BBhB+ePxZaEwrc=;
        b=ujYPTjyF9FVvnjoJeU78ZBZSjgIVy9aZ8/BprhfMpk4clWb4cnn2pUoMXUEwFleo6W
         qIzwlDmFS1h/4ho+1MGFFLTtxMWwTahC3Y8/5CiY7yQeTusKdQezS40vEU6WHRtbjZWf
         mTVDkbeqvmcjF0YjxjIvSKR6EXpN/i6/PWIotpILOZmkarFgooAtpiZ7Zp8qfhcJi7nI
         C0078JFBbgiU764CpyDP0UZorLi5UJxhUGybkkVDwI9o4wdbN/fgk3FU3GuuVXAOTdMR
         bWP62G/j5ApsjI7JtNl0rqBf4pOhyUd/OVqDVvmpmHJ2r2h9b+ShoJeZj6jQBZINqJ5b
         2kPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709765210; x=1710370010;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mOwdOoNbr2a5KxBVQ1knEvkmsBd7BBhB+ePxZaEwrc=;
        b=t+CfcfV2T+nIdPavL235dz1xRMwR/vETs4xCOQQUrKQnGFppHvMGCCD/mWAjZWD1RK
         RF4IDf9pH/tPYZJwAkoT4MeJwDnrMU0uTtas5hnNXdkc3N7WsgRoq54SBBGy92dNw0ib
         S0tJhqfb3XzVuihkhuy+8a2VRp/rjq0UnXRuVvg0BHpkB4oGbyzUvHEDXTcHyzSAGbxP
         IgDRzN7xPcBCbchjeNIEzkLtLfEItvbDT8uCG6zxWJLLXL08ZYWYyVmitil2D3x/0imG
         wwkp7d2KfRAxe3f0+lIXO4NVve8OZ0o6Lc6rP0Q0Lh97OH1iykbMQnnyNXG8kFUe+3bX
         eBZw==
X-Gm-Message-State: AOJu0YwZWQGzUPOitRODmKaUdabKf2jDhja2DM3Z/1yIxCRi4jNwInsx
	1mtXNjx/M0bm05vwOgHtTYpoUDu6RzU2XH/MLDqJrMrkg1AYJS1+cOMfHiBYk75n8bNBcjOlCwp
	35lk=
X-Google-Smtp-Source: AGHT+IGHvICh6O1WUWpp19gZN+6qkDKv9iBRb1hdr216AHdxv5OAZqritoc8ajaWd5+iMSMCPkFEXA==
X-Received: by 2002:a17:902:ec92:b0:1dc:42da:bad with SMTP id x18-20020a170902ec9200b001dc42da0badmr7474024plg.62.1709765209952;
        Wed, 06 Mar 2024 14:46:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c24-20020a170902b69800b001db93340f9bsm12994034pls.205.2024.03.06.14.46.46
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 14:46:47 -0800 (PST)
Message-ID: <65e8f257.170a0220.1bf61.160b@mx.google.com>
Date: Wed, 06 Mar 2024 14:46:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.209-cip44-594-gb47da48f3bae7
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 16 runs,
 5 regressions (v5.10.209-cip44-594-gb47da48f3bae7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Mar 2024 22:46:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15247

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 16 runs, 5 regressions =
(v5.10.209-cip44-594-gb47da48f3bae7)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig         | 1          =

beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =

qemu_smp8_riscv64        | riscv | lab-broonie | gcc-10   | defconfig      =
            | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-594-gb47da48f3bae7/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-594-gb47da48f3bae7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b47da48f3bae7f477104b0c214451338a6a343df =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e462c027d0edd04c432b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm/multi_v7_defconfig/gcc-=
10/lab-cip/ltp-ipc-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm/multi_v7_defconfig/gcc-=
10/lab-cip/ltp-ipc-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/armhf/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65e8e462c027d0edd04c43=
2c
        new failure (last pass: v5.10.209-cip44-552-gc0460fb20fc00) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e7b614e1a73b724c42ef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/ltp-ipc-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/ltp-ipc-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/armhf/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65e8e7b614e1a73b724c42=
f0
        new failure (last pass: v5.10.209-cip44-552-gc0460fb20fc00) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
qemu_smp8_riscv64        | riscv | lab-broonie | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8df93eaa70964b24c42da

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/riscv/defconfig/gcc-10/lab-=
broonie/ltp-ipc-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/riscv/defconfig/gcc-10/lab-=
broonie/ltp-ipc-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65e8df93eaa70964b24c42=
db
        failing since 5 days (last pass: v5.10.209-cip44-56-g55117716ac0fd,=
 first fail: v5.10.209-cip44-552-gc0460fb20fc00) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8df8001a0057ed04c4399

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65e8df8001a0057ed04c43=
9a
        failing since 125 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e6749ee4842d9e4c4316

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig/gcc-10/lab-=
cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig/gcc-10/lab-=
cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65e8e6749ee4842d9e4c43=
17
        failing since 98 days (last pass: v5.10.200-cip40-188-g33d0b44cd71d=
, first fail: v5.10.201-cip41-197-g2d08925b44e52) =

 =20

