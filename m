Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB04BC4167D
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 06:46:42 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.web11.22876.1699598795362862547
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 09 Nov 2023 22:46:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=MLFQ9BZR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.46, mailfrom: bot@kernelci.org)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6cd09f51fe0so1012806a34.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 09 Nov 2023 22:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699598794; x=1700203594; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mR6G8vr0Hgp/nGh7brbzFPxWNrEAJdKdpdCKzRn6fJw=;
        b=MLFQ9BZR9l7+iS1iY7sLma+9CDXlDs8qy3QBEU6MIdZKnjSsLlyG7NiAuibV8HlRL/
         0LFAbMkC6XGjTf7U5I+0ZWfABnNAjyIET6wMx5Rj1puVqD14QvPYoHTkkxOJ0SGvnzDr
         dm7IitzTojlbAJRgNTV2dS/A5w/CWkEAB2TYQsdcR9VY4En1bFQdJK1v4n0MRBF188js
         qkze8J4113jnEMh4V1Z90xa6G7uTw8JCzlLojX0Ou1rUKh76eawr/+MN4v3EGWEm4XcS
         sCQ2o6XhZsOQvda4ZWLFB0TTyonMZPvemX0DOFXhLPVnYwWdOxWpoeG/tq36E4WzW4hY
         3ECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699598794; x=1700203594;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mR6G8vr0Hgp/nGh7brbzFPxWNrEAJdKdpdCKzRn6fJw=;
        b=czgxp4RJjSV02gcA/eOfa6x3nnQr2883FxtHBYBNjOIyl6bDRYdHg4Tbz5U7AbuONM
         wclcY1y+Fz0Tk9vpFyp5VQdF7pBgMTyi8e5cym0o6/IPAZnXdzIN0bSHYy2AcOG1qfqS
         bMZLXhUVFjHE/epHU7gfemtRsdywhQlnjC7tp9vUyOBAZA4KQoRwUxR5eqrugSqwRNl2
         84sz0XYLIBgex7aTA8/vcyIUDo8KDDhj7AlNLI0lm4AbHA8FGaZRlV/zdll5Awnq/hwc
         G6hfWYZGt9QGsLUav2J9ZLxvRLZBK/IMUqtUYsADTmNt5IvT1xbrYtEwiOVv4KbG/Kpd
         BEXg==
X-Gm-Message-State: AOJu0YzbJMixl3LULmzl+98QEaYvfMkdoVbxb3f0E+6VUcxclGbbys4G
	o4rJTBlbljcnKFFwFA5IxOVn658nHWCVQ3HUuaX8KA==
X-Google-Smtp-Source: AGHT+IEd7rmBDJROmjhsKymw9qEtEK5PAJ3sJPdHVZ9WquKPUILrrdGeL+w8iA4flCSaWRQQh9wNyQ==
X-Received: by 2002:a05:6870:392c:b0:1e9:e0d7:3663 with SMTP id b44-20020a056870392c00b001e9e0d73663mr8618700oap.49.1699598793955;
        Thu, 09 Nov 2023 22:46:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s1-20020aa78281000000b006b4a5569694sm11745829pfm.83.2023.11.09.22.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 22:46:33 -0800 (PST)
Message-ID: <654dd1c9.a70a0220.3e627.fde2@mx.google.com>
Date: Thu, 09 Nov 2023 22:46:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.200-cip40
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline-cip-nfs: 6 runs,
 6 regressions (v5.10.200-cip40)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Nov 2023 06:46:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13552

cip/linux-5.10.y-cip baseline-cip-nfs: 6 runs, 6 regressions (v5.10.200-cip=
40)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig  | 1          =

beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig  | 1          =

beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.200-cip40/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.200-cip40
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      166400a23a22e665f5d880a99149b73abede402d =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig  | 1          =


  Details:     https://kernelci.org/test/plan/id/654dc74501236a676defcef7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-cip-nfs-beaglebon=
e-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-cip-nfs-beaglebon=
e-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/654dc74501236=
a676defcef8
        new failure (last pass: v5.10.131-cip13-37-ge3a52725ce96) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig  | 1          =


  Details:     https://kernelci.org/test/plan/id/654dcec7d789951a89efcf09

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-cip-nfs-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-cip-nfs-beaglebone-bl=
ack.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/654dcec7d7899=
51a89efcf0a
        new failure (last pass: v5.10.131-cip13-37-ge3a52725ce96) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/654dc923763e9c98f9efcef5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-cip-nfs-beaglebo=
ne-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-cip-nfs-beaglebo=
ne-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/654dc923763e9=
c98f9efcef6
        new failure (last pass: v5.10.131-cip13-38-ga8671b4cc3c74) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/654dcaf4cea75bebf7efcf70

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774a1-hihope-rzg2=
m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774a1-hihope-rzg2=
m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/654dcaf4cea75=
bebf7efcf71
        new failure (last pass: v5.10.138-cip15) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/654dcbd0807fc647baefcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774b1-hihope-rzg2=
n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774b1-hihope-rzg2=
n-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/654dcbd0807fc=
647baefcef4
        new failure (last pass: v5.10.138-cip15) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/654dcc71985810062aefcef6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/654dcc7198581=
0062aefcef7
        new failure (last pass: v5.10.138-cip15) =

 =20

