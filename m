Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15AEC48260
	for <webhook@archiver.kernel.org>; Fri, 26 Jan 2024 06:18:39 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web11.9860.1706249911052164905
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 25 Jan 2024 22:18:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=jlRTod5m;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6da6b0eb2d4so289495b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 25 Jan 2024 22:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706249910; x=1706854710; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jwI1XBoH6+JmJTNJQkMBiBDtHmb78RSsBQIDxIJ5rdU=;
        b=jlRTod5m2x+TCn17DS0CfZziMTQhzRZNHwhQnrxI/r5cDB+C4H+iw1XfIcrug8SqAB
         OnoVZNtFpHE0mkuhv2TQkm9JkngD1/IvrUfGt/ERMg8yUMjn3LCsqptMLy5Iolm5PECk
         9EMozV8RkrYY9ZxERIESFaDMsg0rDCuI3ATFcwq1YQAIvxJARxGxhnsGL9AD36yGIZQb
         4VfDbP89bn2+wIU7s9vBqxJb1U1SaBnzrc7g1KyAWAMrWNbfHIxGPCYIFuqlSV5Ff7uX
         LsnMXbacvylynpjAl3Q0MmQOGJK2b9imomoKcWIu2qqyBKbzulhGaNwypGrZ9DgEljHv
         BMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706249910; x=1706854710;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwI1XBoH6+JmJTNJQkMBiBDtHmb78RSsBQIDxIJ5rdU=;
        b=XIeAJgLZS/58aZZ19ulNsfoFJv5llN2nZMC1jKyF34od4OZc6sZGlAwQSWBrkv7fcA
         7W496Yqk7MwB7RJSaICHVq+HbbzrE2pI7FfJ4aBD3jP/juQSJK0Nl18PCKMQWK0ZuCFs
         6cvafXt9b/0AaF8aQ4LwVfBwgu7OM7siJ8wAj87OLt56fS98yLqsgrlPwn0UMHQW+miN
         iyibb2jY1ZkfX2FVDsjq9gK3j1rU08Og+qgZ81KgOuTt/0twc+Uf61PFAvOhjtU3kJqF
         85pe7Xv4Shu6xNSoSfDOSlrW0PoRRe0Ze0VDdpZyP1wCUOt6v7Ph1ulaHQzJMZxlUSBa
         G9kA==
X-Gm-Message-State: AOJu0Yx02pkVLUA4vMb+w4E4lAi7hqyYCk9jeiJ1tR2fXmzhQSQ9lwoM
	xpcL9H0EREtuZvsCDRNXaV7LqIx0DPVhCkTkoyX8nzY40IPJFbJf7VFj4S+kJ8yOU9bUWK8EAAe
	OsuI=
X-Google-Smtp-Source: AGHT+IHmSuy+LQ1LW2Y+FWmu+v9vX6ulLW1A7kSfTN/zSUUmAf7z+fnGbEoBx3NsGfBVNgwEJtiq6w==
X-Received: by 2002:a05:6a20:3953:b0:19c:6cee:fb40 with SMTP id r19-20020a056a20395300b0019c6ceefb40mr784139pzg.9.1706249909536;
        Thu, 25 Jan 2024 22:18:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ld11-20020a170902facb00b001d755ec4bc0sm408544plb.241.2024.01.25.22.18.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 22:18:29 -0800 (PST)
Message-ID: <65b34eb5.170a0220.910ef.1184@mx.google.com>
Date: Thu, 25 Jan 2024 22:18:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.304-cip106-176-g770d0422c72e9
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-cip-nfs: 9 runs,
 7 regressions (v4.19.304-cip106-176-g770d0422c72e9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 Jan 2024 06:18:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14465

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-cip-nfs: 9 runs, 7 regr=
essions (v4.19.304-cip106-176-g770d0422c72e9)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig         | 1          =

beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig         | 1          =

beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.304-cip106-176-g770d0422c72e9/plan/baseli=
ne-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.304-cip106-176-g770d0422c72e9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      770d0422c72e9acab17684ec2bbff7bc9a09b1a4 =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65b3497cf23173638f52a418

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-176-g770d0422c72e9/arm/multi_v7_defconfig/gcc=
-10/lab-broonie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-176-g770d0422c72e9/arm/multi_v7_defconfig/gcc=
-10/lab-broonie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65b3497cf2317=
3638f52a419
        failing since 78 days (last pass: v4.19.252-cip78-146-g6acc38498265=
c, first fail: v4.19.297-cip104-63-ge7301d2e196ae) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65b348ebf4c7dd8fda52a3f9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-176-g770d0422c72e9/arm/multi_v7_defconfig/gcc=
-10/lab-cip/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-176-g770d0422c72e9/arm/multi_v7_defconfig/gcc=
-10/lab-cip/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65b348ebf4c7d=
d8fda52a3fa
        failing since 78 days (last pass: v4.19.252-cip78-146-g6acc38498265=
c, first fail: v4.19.297-cip104-63-ge7301d2e196ae) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65b342cb47bdfd9e6952a3fd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-176-g770d0422c72e9/arm/omap2plus_defconfig/gc=
c-10/lab-broonie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-176-g770d0422c72e9/arm/omap2plus_defconfig/gc=
c-10/lab-broonie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65b342cb47bdf=
d9e6952a3fe
        failing since 532 days (last pass: v4.19.252-cip78-113-gb7034e0f773=
f8, first fail: v4.19.252-cip78-146-g6acc38498265c) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65b340a49925d6140b52a3f9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-176-g770d0422c72e9/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-cip/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-176-g770d0422c72e9/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-cip/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65b340a49925d=
6140b52a3fa
        failing since 78 days (last pass: v4.19.252-cip78-146-g6acc38498265=
c, first fail: v4.19.297-cip104-63-ge7301d2e196ae) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65b3455593aba39e6852a3f3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-176-g770d0422c72e9/arm64/defconfig/gcc-10/lab=
-cip/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-176-g770d0422c72e9/arm64/defconfig/gcc-10/lab=
-cip/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65b3455593aba=
39e6852a3f4
        failing since 78 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0,=
 first fail: v4.19.297-cip104-63-ge7301d2e196ae) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65b33ec4f0ad54ae2052a55c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-176-g770d0422c72e9/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-cip/baseline-cip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-176-g770d0422c72e9/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-cip/baseline-cip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65b33ec4f0ad5=
4ae2052a55d
        failing since 78 days (last pass: v4.19.252-cip78-146-g6acc38498265=
c, first fail: v4.19.297-cip104-63-ge7301d2e196ae) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65b3456893aba39e6852a3fa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-176-g770d0422c72e9/arm64/defconfig/gcc-10/lab=
-cip/baseline-cip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-176-g770d0422c72e9/arm64/defconfig/gcc-10/lab=
-cip/baseline-cip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65b3456893aba=
39e6852a3fb
        failing since 78 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0,=
 first fail: v4.19.297-cip104-63-ge7301d2e196ae) =

 =20

