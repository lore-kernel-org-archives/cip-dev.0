Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47228C4828F
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 18:11:49 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web11.5135.1707329506589266449
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Feb 2024 10:11:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=pjtoHjx/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6da9c834646so766870b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Feb 2024 10:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707329505; x=1707934305; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U8prlucRXaWS3Pfd7+expLTZEnt1Ubiw6Z646ohn5lE=;
        b=pjtoHjx//1tEfc96rE+pFHdH0IucJRTgHJsRkwfMznjZXByJbiaGmuk0Og5+YCWpYY
         x4rsdcgYh1VBG5Coe5LJL25oHG6ZbluzTl15RZ5KbA+JIqckT0J1h2lcO7R7PFJvjCep
         LkgpwS3zIeWcnGNeX9RzkWxMzV4EB+9AKNUPAvsz9um1bfQyH8S3XvQXZc0n2Zf7vaXd
         CT9iBFCMvt8birXqrjkJ4uGyHaj+TkJs3SlipNicFzjr1xilF4gjfWUXMiUe8qfb0sqc
         EXCWiKqShzQQqqn2oEPSH+cK/r/vwihVFe3bb2sfmfoBZ+UQwNs45MXTTf0oe9kYh4qM
         btDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707329505; x=1707934305;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8prlucRXaWS3Pfd7+expLTZEnt1Ubiw6Z646ohn5lE=;
        b=LJSKT1BMPB+keUQIHEGGVhDagwd3sGGcVSUwaD/Bv1FEtde9OXjGln7/Dryz0j/h/b
         rQCrU98y2vkdrWeQgUdtf9Dv7xIiehwhZC/pSmV1eA9cAKnlV0Ty+5uaZRdd6PmN6EDd
         RuEMISNbXUifEPRZM2dQ0qfXgVXwF9wC0MEJp0ySf04PDNb4KjagzqyR9sUaKUN0uBcG
         bYpZfsQ+PiIPfVjYgrWnV8/EJ9WUTLzbCXZHospTrPBea5H3ecgDiiYnXcg9HSlTtFht
         yyWv5SYn9/4IhOeNseswCITn+gyjAuqFRhClY57r99sCVS3XQukQViCc3r8JtjrJm2IW
         gI6g==
X-Gm-Message-State: AOJu0YyfKerfXsHgDaoFhUgp/ZBlz+/ULeWy8k5lyO4owv323KFMHgvc
	vSL+qCrLdRw0wfVkXqXjf7R2nCbYqYSWUDJPA1cJIIntQnTgQmRBlb57t3w/+IRaTHjaSO5YAjN
	gdAE=
X-Google-Smtp-Source: AGHT+IGybaVL5GGIXDR+KSWp2/6mbLAiKmYq/uV3TPp+94fDz1oIR/vmYmQ+n5rWK4A1rd9Azxzvdg==
X-Received: by 2002:a05:6a00:44c5:b0:6e0:6c89:e306 with SMTP id cv5-20020a056a0044c500b006e06c89e306mr2081440pfb.18.1707329505117;
        Wed, 07 Feb 2024 10:11:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUnRCJoceWBbiTEUedUvEjs9CYIyAYYOlxS4BfseFCECoz5iVwOej0xf96w5Ufnv0ruNqledJxROmtNYMkpFz5dFMZSfS2WQXD6+5O9cwSYKGq+OdMz9IGfhRscBKIXCwnHKmQTD4L54r1UQlQKnYCwTQ==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y11-20020aa793cb000000b006e044e376adsm1926563pff.166.2024.02.07.10.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 10:11:44 -0800 (PST)
Message-ID: <65c3c7e0.a70a0220.983da.65f4@mx.google.com>
Date: Wed, 07 Feb 2024 10:11:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.304-cip106-3-gaf120b32b886e
Subject: cip/linux-4.19.y-cip baseline-cip-nfs: 9 runs,
 9 regressions (v4.19.304-cip106-3-gaf120b32b886e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 18:11:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14897

cip/linux-4.19.y-cip baseline-cip-nfs: 9 runs, 9 regressions (v4.19.304-cip=
106-3-gaf120b32b886e)

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

beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.304-cip106-3-gaf120b32b886e/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.304-cip106-3-gaf120b32b886e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      af120b32b886ebb728032aa594bafc1d152eb9f5 =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3bffe4707c66cde8e1e85

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-cip=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-cip=
-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c3bffe4707c=
66cde8e1e86
        failing since 61 days (last pass: v4.19.256-cip80, first fail: v4.1=
9.299-cip105) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3bc417bf33117f68e1e7d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c3bc417bf33=
117f68e1e7e
        failing since 61 days (last pass: v4.19.251-cip77, first fail: v4.1=
9.299-cip105) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3c2e2d179df07e98e1e7b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-ci=
p-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-ci=
p-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c3c2e2d179d=
f07e98e1e7c
        failing since 61 days (last pass: v4.19.251-cip77, first fail: v4.1=
9.299-cip105) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3be468964b3a08d8e1e86

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c3be468964b=
3a08d8e1e87
        failing since 61 days (last pass: v4.19.256-cip80, first fail: v4.1=
9.299-cip105) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3beb2e5f9a901f48e1e7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-cip-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-cip-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c3beb2e5f9a=
901f48e1e7b
        failing since 61 days (last pass: v4.19.256-cip80, first fail: v4.1=
9.299-cip105) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3bd56b43cb048848e1e88

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774b1-hihope-rzg2n-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c3bd56b43cb=
048848e1e89
        failing since 61 days (last pass: v4.19.256-cip80, first fail: v4.1=
9.299-cip105) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3bfc296833a806f8e1e86

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-cip-nfs-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-cip-nfs-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c3bfc296833=
a806f8e1e87
        failing since 61 days (last pass: v4.19.256-cip80, first fail: v4.1=
9.299-cip105) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3bd43b43cb048848e1e85

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c3bd43b43cb=
048848e1e86
        failing since 61 days (last pass: v4.19.256-cip80, first fail: v4.1=
9.299-cip105) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3c09e04f99526778e1e79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-cip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-cip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c3c09e04f99=
526778e1e7a
        failing since 61 days (last pass: v4.19.256-cip80, first fail: v4.1=
9.299-cip105) =

 =20

