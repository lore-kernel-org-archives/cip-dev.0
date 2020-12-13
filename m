Return-Path: <SRS0=4BFU=FR=lists.cip-project.org=bounce+64572+5956+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D38C4361B
	for <cip-dev@archiver.kernel.org>; Sun, 13 Dec 2020 01:17:06 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87692207D0
	for <cip-dev@archiver.kernel.org>; Sun, 13 Dec 2020 01:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87692207D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5956+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id TfLSYY4521723xNDwTYfBMcB; Sat, 12 Dec 2020 17:17:04 -0800
X-Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web09.12243.1607818199249632218
 for <cip-dev@lists.cip-project.org>;
 Sat, 12 Dec 2020 16:09:59 -0800
X-Received: by mail-pl1-f181.google.com with SMTP id b8so679405plx.0
        for <cip-dev@lists.cip-project.org>; Sat, 12 Dec 2020 16:09:59 -0800 (PST)
X-Gm-Message-State: 0HyFT3SJg3YiX56gVm8agGzKx4520388AA=
X-Google-Smtp-Source: ABdhPJxH4jKjDe0XJf3Iq+w8H5T6F8qVwTvx9pTnN6L7tft8NiRCWDV3Gh8UVRmj7rQURuVoPBnxTQ==
X-Received: by 2002:a17:902:123:b029:da:420e:aab0 with SMTP id 32-20020a1709020123b02900da420eaab0mr16957696plb.30.1607818198429;
        Sat, 12 Dec 2020 16:09:58 -0800 (PST)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 77sm14560751pfx.156.2020.12.12.16.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 16:09:57 -0800 (PST)
Message-ID: <5fd55bd5.1c69fb81.504dd.b3b7@mx.google.com>
Date: Sat, 12 Dec 2020 16:09:57 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.163-cip40
X-Kernelci-Report-Type: test
Subject: [cip-dev] cip/linux-4.19.y-cip baseline: 168 runs, 4 regressions (v4.19.163-cip40)
To: cip-dev@lists.cip-project.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="tKx13JuLVjFm00UuzwIh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1607822224;
 bh=Wwua89yQ8ssv/YRk1iRPdAwo8yPOsH9UcITNIGoULcc=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=g/DfaM+HVtG3gLdfCdYvUspl0SizuE+AS2np1vCcw8milSQHaBvR27D4ktRLZ+rONn3
 kLgu3bMkRII0p29A6jIvoX/zmTynD2+SfFqWKCw6GNrcA4tugYlKwR8HMeWrIwb5dGOB4
 jeiaYg7TRLT5EG1UQTeuoP+fKj6wHj8KGio=

--tKx13JuLVjFm00UuzwIh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline: 168 runs, 4 regressions (v4.19.163-cip40)

Regressions Summary
-------------------

platform                   | arch  | lab          | compiler | defconfig   =
                 | regressions
---------------------------+-------+--------------+----------+-------------=
-----------------+------------
meson-gxbb-p200            | arm64 | lab-baylibre | gcc-8    | defconfig   =
                 | 1          =

meson-gxl-s905x-khadas-vim | arm64 | lab-baylibre | gcc-8    | defconfig+CO=
N...BIG_ENDIAN=3Dy | 1          =

qemu_arm-versatilepb       | arm   | lab-baylibre | gcc-8    | versatile_de=
fconfig          | 1          =

qemu_arm-versatilepb       | arm   | lab-cip      | gcc-8    | versatile_de=
fconfig          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.163-cip40/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.163-cip40
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      533d79a6896c55049bf3b11dea19b345bfb41743 =



Test Regressions
---------------- =



platform                   | arch  | lab          | compiler | defconfig   =
                 | regressions
---------------------------+-------+--------------+----------+-------------=
-----------------+------------
meson-gxbb-p200            | arm64 | lab-baylibre | gcc-8    | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/5fd54e3f2c5250c97cc94cb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxbb-p200.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxbb-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fd54e3f2c5250c97cc94=
cba
        new failure (last pass: v4.19.160-cip39-1-g00b5977d73363) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
                 | regressions
---------------------------+-------+--------------+----------+-------------=
-----------------+------------
meson-gxl-s905x-khadas-vim | arm64 | lab-baylibre | gcc-8    | defconfig+CO=
N...BIG_ENDIAN=3Dy | 1          =


  Details:     https://kernelci.org/test/plan/id/5fd54f29689e31b1f5c94ccd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+CONFIG_CPU_BIG_ENDIAN=3Dy
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40/arm64/defconfig+CONFIG_CPU_BIG_ENDIAN=3Dy/gcc-8/lab-baylibre/baselin=
e-meson-gxl-s905x-khadas-vim.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40/arm64/defconfig+CONFIG_CPU_BIG_ENDIAN=3Dy/gcc-8/lab-baylibre/baselin=
e-meson-gxl-s905x-khadas-vim.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64be/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fd54f29689e31b1f5c94=
cce
        new failure (last pass: v4.19.160-cip39-1-g00b5977d73363) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
                 | regressions
---------------------------+-------+--------------+----------+-------------=
-----------------+------------
qemu_arm-versatilepb       | arm   | lab-baylibre | gcc-8    | versatile_de=
fconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/5fd54d01d315d9e2bfc94cbb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-versati=
lepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-versati=
lepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fd54d01d315d9e2bfc94=
cbc
        failing since 28 days (last pass: v4.19.152-cip37-37-g18852869b06b,=
 first fail: v4.19.157-cip38) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
                 | regressions
---------------------------+-------+--------------+----------+-------------=
-----------------+------------
qemu_arm-versatilepb       | arm   | lab-cip      | gcc-8    | versatile_de=
fconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/5fd54d35d315d9e2bfc94ce0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu_arm-versatilepb.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu_arm-versatilepb.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fd54d35d315d9e2bfc94=
ce1
        failing since 28 days (last pass: v4.19.152-cip37-37-g18852869b06b,=
 first fail: v4.19.157-cip38) =

 =20

--tKx13JuLVjFm00UuzwIh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5956): https://lists.cip-project.org/g/cip-dev/message=
/5956
Mute This Topic: https://lists.cip-project.org/mt/78919878/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--tKx13JuLVjFm00UuzwIh--
