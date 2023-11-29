Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9D9C4167B
	for <webhook@archiver.kernel.org>; Wed, 29 Nov 2023 00:17:09 +0000 (UTC)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
 by mx.groups.io with SMTP id smtpd.web10.15087.1701217020276406853
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 28 Nov 2023 16:17:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=t07VkwtP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.171, mailfrom: bot@kernelci.org)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-35c5ca63c03so17849025ab.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 28 Nov 2023 16:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701217019; x=1701821819; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2khuk37g3hFh52O1bYPwN5bTcs+OE5Yq+Z87geSXezc=;
        b=t07VkwtP0P8cjmcycXkr69VEni3Ks12I1H1oPvBmZ6EX4ka62w/yq2ywifP38czmjd
         A5iuznWMwKdPmwfRd2XdTJ/dCEuw663gZNmaJk5u2mhKeFOOFySwKeZESI6ug6JVGsLY
         TLaAG049JV1D87ERMEN5WEB3AcGh3A7ULEmneAyAPgWSudosGvMmMJhWntCEYSgbjbG5
         IVoXq82XNP6LHoR+OTTEQt+NgpdlzsbhIYeaz8hMA76ygvoRwPUyWRx1oPHfdH3qkGML
         F99VhojMufL75dAUyFOTZ2oOLZDhe5vYvgBrkWE5C35Pc4+SnzjlOmmNsStpLyO0s6qI
         KYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701217019; x=1701821819;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2khuk37g3hFh52O1bYPwN5bTcs+OE5Yq+Z87geSXezc=;
        b=bZTRanPl5lyVRzE07Raksc01LXij2PUJc8Z0TLGeE5jZgmQ5gpomw7pz11rwV2CdBG
         qwHPrN7KyoGFfGzxrAYBml8qoNsbtCt52Ed7UVJib13HsngPtTC5aUUTP/Ur08ZwSO68
         Gz2NEnYAWD6ZDUlMV5+1b+qrMsFof3m+1OYs+Y/fPwhswG/kWmba0RxIH6n2Lzx0lSU6
         j0aY/zyaui+jq1OXJxpQ4f+dNCJFOWZgxvnCf0AIzl+Wh19eRGrMQbTkPt9wDVU5hlh2
         TouAhTlpeS3xM/xNSy4WCdswxfGbW08hxnbg8Z1TZ9FjzhkNlZtDGNoZuuNtSyI8Cvpu
         84ew==
X-Gm-Message-State: AOJu0YzeW1uUR7kB6oghIE7nQk5kTsP5EbrKtiH6C8ZAjgHkctJIV3Q0
	AoP1v70ZhFtzXlUaPP3g8/mrKyiVeD6bTAckMQw=
X-Google-Smtp-Source: AGHT+IFF3pcKrUT9GNG+ltWNsUmvR0rPS0piE/zKhnOYtjknW+z0lR221D+s0hr6sHd0+PLrInS5Sw==
X-Received: by 2002:a05:6e02:ec2:b0:35d:2419:8741 with SMTP id i2-20020a056e020ec200b0035d24198741mr2446674ilk.25.1701217018671;
        Tue, 28 Nov 2023 16:16:58 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u9-20020a632349000000b005c2422a1171sm9880429pgm.66.2023.11.28.16.16.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 16:16:56 -0800 (PST)
Message-ID: <656682f8.630a0220.d488e.9206@mx.google.com>
Date: Tue, 28 Nov 2023 16:16:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.201-cip41-197-g2d08925b44e52
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 18 runs,
 5 regressions (v5.10.201-cip41-197-g2d08925b44e52)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Nov 2023 00:17:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13757

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 18 runs, 5 regressions =
(v5.10.201-cip41-197-g2d08925b44e52)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =

qemu_riscv64                 | riscv | lab-broonie   | gcc-10   | defconfig=
                  | 1          =

qemu_smp8_riscv64            | riscv | lab-collabora | gcc-10   | defconfig=
                  | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-197-g2d08925b44e52/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-197-g2d08925b44e52
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2d08925b44e52ce450bf165f843637412f9c979b

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6566793d46f83608f77e4a83

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
broonie/ltp-ipc-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
broonie/ltp-ipc-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6566793d46f83608f77e4a=
84
        new failure (last pass: v5.10.200-cip40-188-g33d0b44cd71d) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
qemu_riscv64                 | riscv | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65666c786b9da060497e4a6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/riscv/defconfig/gcc-10/lab-=
broonie/ltp-ipc-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/riscv/defconfig/gcc-10/lab-=
broonie/ltp-ipc-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65666c786b9da060497e4a=
6e
        new failure (last pass: v5.10.200-cip40-188-g33d0b44cd71d) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
qemu_smp8_riscv64            | riscv | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65666aa38bf9d986337e4a79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/riscv/defconfig/gcc-10/lab-=
collabora/ltp-ipc-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/riscv/defconfig/gcc-10/lab-=
collabora/ltp-ipc-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65666aa38bf9d986337e4a=
7a
        new failure (last pass: v5.10.200-cip40-188-g33d0b44cd71d) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6566711da95e70cbc27e4a6f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6566711da95e70cbc27e4a=
70
        failing since 26 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/656674e4c5c00679337e4a93

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/656674e4c5c00679337e4a=
94
        new failure (last pass: v5.10.200-cip40-188-g33d0b44cd71d) =

 =20

