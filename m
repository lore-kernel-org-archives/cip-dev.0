Return-Path: <SRS0=uzU2=GI=lists.cip-project.org=bounce+64572+5999+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08227C433DB
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 13:16:35 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF88229EF
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 13:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF88229EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5999+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id TUdPYY4521723xKFYteRNIrg; Tue, 05 Jan 2021 05:16:33 -0800
X-Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web09.4866.1609852568218800536
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 05:16:08 -0800
X-Received: by mail-pf1-f180.google.com with SMTP id t8so18351101pfg.8
        for <cip-dev@lists.cip-project.org>; Tue, 05 Jan 2021 05:16:08 -0800 (PST)
X-Gm-Message-State: YBAIt6oQ2dyY2QAyAIGRzw2mx4520388AA=
X-Google-Smtp-Source: ABdhPJzDEsr5mnWAJpZkR+7ifV4hvXoPe3+az2+Jt+0lymHrnKg4bvJE3QWLokuBy+kSxA2iMH6AiQ==
X-Received: by 2002:a62:1dd5:0:b029:19d:fc87:5f45 with SMTP id d204-20020a621dd50000b029019dfc875f45mr70436387pfd.63.1609852567214;
        Tue, 05 Jan 2021 05:16:07 -0800 (PST)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d36sm63131691pgm.77.2021.01.05.05.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 05:16:06 -0800 (PST)
Message-ID: <5ff46696.1c69fb81.b493e.c196@mx.google.com>
Date: Tue, 05 Jan 2021 05:16:06 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.163-cip40-5-g95fea62f9f453
X-Kernelci-Report-Type: test
Subject: [cip-dev] cip/linux-4.19.y-cip baseline: 239 runs, 6 regressions (v4.19.163-cip40-5-g95fea62f9f453)
To: cip-dev@lists.cip-project.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="QErmyuTgySXCw6OEJ3Nz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609852593;
 bh=yfB5D87+rQFUNBYkUyjYBB+vynfi72qOmtXMdMiaRcs=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=fg+r4rW3pHkLuYB8OSmfcc5hXhJUp+9stafSNyUIBRVGUGN9Qi7EN9ZVFA59ySp1mwM
 DEr2Yrmokzkifhl5yJmTVoFN4nRRKerkESS4s9SvUYE0v7w0hcXb63+rWIi4ZZgCprqed
 scxxvawGHh4WwLv+t9N5Fq4z5u1yw753vdM=

--QErmyuTgySXCw6OEJ3Nz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline: 239 runs, 6 regressions (v4.19.163-cip40-5-g=
95fea62f9f453)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
meson-gxl-s905x-khadas-vim | arm64 | lab-baylibre  | gcc-8    | defconfig+C=
ON...BIG_ENDIAN=3Dy | 1          =

panda                      | arm   | lab-collabora | gcc-8    | omap2plus_d=
efconfig          | 1          =

qemu_arm-versatilepb       | arm   | lab-baylibre  | gcc-8    | versatile_d=
efconfig          | 1          =

qemu_arm-versatilepb       | arm   | lab-broonie   | gcc-8    | versatile_d=
efconfig          | 1          =

qemu_arm-versatilepb       | arm   | lab-cip       | gcc-8    | versatile_d=
efconfig          | 1          =

qemu_arm-versatilepb       | arm   | lab-collabora | gcc-8    | versatile_d=
efconfig          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.163-cip40-5-g95fea62f9f453/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.163-cip40-5-g95fea62f9f453
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      95fea62f9f4534c3b963acd44f03754d9fe0829a =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
meson-gxl-s905x-khadas-vim | arm64 | lab-baylibre  | gcc-8    | defconfig+C=
ON...BIG_ENDIAN=3Dy | 1          =


  Details:     https://kernelci.org/test/plan/id/5ff459cf6c343e6634c94cf5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+CONFIG_CPU_BIG_ENDIAN=3Dy
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-5-g95fea62f9f453/arm64/defconfig+CONFIG_CPU_BIG_ENDIAN=3Dy/gcc-8/lab=
-baylibre/baseline-meson-gxl-s905x-khadas-vim.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-5-g95fea62f9f453/arm64/defconfig+CONFIG_CPU_BIG_ENDIAN=3Dy/gcc-8/lab=
-baylibre/baseline-meson-gxl-s905x-khadas-vim.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64be/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ff459cf6c343e6634c94=
cf6
        failing since 23 days (last pass: v4.19.160-cip39-1-g00b5977d73363,=
 first fail: v4.19.163-cip40) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
panda                      | arm   | lab-collabora | gcc-8    | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/5ff45a3527873bd33dc94cdc

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-5-g95fea62f9f453/arm/omap2plus_defconfig/gcc-8/lab-collabora/baselin=
e-panda.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-5-g95fea62f9f453/arm/omap2plus_defconfig/gcc-8/lab-collabora/baselin=
e-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/5ff45a3527873bd=
33dc94ce1
        failing since 38 days (last pass: v4.19.160-cip39, first fail: v4.1=
9.160-cip39-1-g00b5977d73363)
        2 lines

    2021-01-05 12:23:12.859000+00:00  kern  :emerg :  lock: emif_lock+0x0/0=
xffffed34 [emif], .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
    2021-01-05 12:23:12.873000+00:00  <8>[   22.870971] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D2>   =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm-versatilepb       | arm   | lab-baylibre  | gcc-8    | versatile_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/5ff4583923e753101cc94ccd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-5-g95fea62f9f453/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline=
-qemu_arm-versatilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-5-g95fea62f9f453/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline=
-qemu_arm-versatilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ff4583923e753101cc94=
cce
        failing since 52 days (last pass: v4.19.152-cip37-37-g18852869b06b,=
 first fail: v4.19.157-cip38) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm-versatilepb       | arm   | lab-broonie   | gcc-8    | versatile_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/5ff4584123e753101cc94cdc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-5-g95fea62f9f453/arm/versatile_defconfig/gcc-8/lab-broonie/baseline-=
qemu_arm-versatilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-5-g95fea62f9f453/arm/versatile_defconfig/gcc-8/lab-broonie/baseline-=
qemu_arm-versatilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ff4584123e753101cc94=
cdd
        failing since 52 days (last pass: v4.19.152-cip37-37-g18852869b06b,=
 first fail: v4.19.157-cip38) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm-versatilepb       | arm   | lab-cip       | gcc-8    | versatile_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/5ff4584223e753101cc94cdf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-5-g95fea62f9f453/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu=
_arm-versatilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-5-g95fea62f9f453/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu=
_arm-versatilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ff4584223e753101cc94=
ce0
        failing since 52 days (last pass: v4.19.152-cip37-37-g18852869b06b,=
 first fail: v4.19.157-cip38) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
qemu_arm-versatilepb       | arm   | lab-collabora | gcc-8    | versatile_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/5ff4584a0cc303e08bc94cbc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-5-g95fea62f9f453/arm/versatile_defconfig/gcc-8/lab-collabora/baselin=
e-qemu_arm-versatilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-5-g95fea62f9f453/arm/versatile_defconfig/gcc-8/lab-collabora/baselin=
e-qemu_arm-versatilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ff4584a0cc303e08bc94=
cbd
        failing since 52 days (last pass: v4.19.152-cip37-37-g18852869b06b,=
 first fail: v4.19.157-cip38) =

 =20

--QErmyuTgySXCw6OEJ3Nz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5999): https://lists.cip-project.org/g/cip-dev/message=
/5999
Mute This Topic: https://lists.cip-project.org/mt/79449344/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--QErmyuTgySXCw6OEJ3Nz--
