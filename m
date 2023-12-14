Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0512C4332F
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 15:45:49 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web11.25751.1702568740852919025
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Dec 2023 07:45:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=NqqYFgUI;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28659348677so613432a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 14 Dec 2023 07:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702568740; x=1703173540; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=71gtY0kbdtH0OLKmaItQxSerU3sxNfXOJlycEP/YGjw=;
        b=NqqYFgUII6qpP52nU0f9vWObcdEuHXrBrqlubkUh4d35WWlh5fiogWQntm+SpncKvJ
         Oh2Zk051Fzyo8sMjqItMV2fVD8C8slYKAuLWFLUnjDtXoPW8amzC3sZCR2r6M7Ihymg1
         j2KumLKyIa9A9qur6lVNgfPpYyp12P6nlR64svcNics+IOHo2m8wlC7ENOcpRsmwfbGk
         /5mM/b051qUYSojJNf/ES2daNIsST31GpbV/AmIEsWCNV1SnUArw21YcXCYKwelGOPdW
         /bUtn1Ghj08GZSFdHVNRTTvVpOds7GDs4vsQoo18BUyIRJhjTikqRIzT1HMdANQiQiq9
         mZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702568740; x=1703173540;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71gtY0kbdtH0OLKmaItQxSerU3sxNfXOJlycEP/YGjw=;
        b=BpCqDS1jr30IZAGxzjfZ8eRvRqIg21n5aG72dM9lkolL7ScoOd7rH2FNHHQ4t6so50
         DaZkPfyzpVR/SBsjbcM8rKCZ6uYqHoLNUbAlkJa7t0d+3RL7i/EHmlc0RPni2bZf3Heh
         KOikgRjbcdimCGXet7eIj5XfOdIaw6Z4fTAoZ+IBiglvKWJk3swI54CXLawaHD+DfWc7
         1PvnNzTenDog0Vg4Z/R/eM8U4k1cP1zJMUJOrlar1Badcibfrnvzis6Vg85Lc8XKmxCN
         +j2XmWVnyuAcxNl/3Sm/vXlALlYqfY6xTXttSQDayPNzw+ESuFhhWtvMVnBFNJVPXlI6
         ztGw==
X-Gm-Message-State: AOJu0YwCAyTy1Su5uljay5BVOIu/+y91ZarlKga35TqgHACJAXYlUP1M
	PNtI1dD7Flln4dVJ7eA2/Mp+7V34jmXTPmhbH34=
X-Google-Smtp-Source: AGHT+IFdMtHEyREGRxJ1+Zct0tuwbX/PiXXC+dPiJglCIK+r30Z1Bkge2LJlUKBGw+xmSg/tNc3KjQ==
X-Received: by 2002:a17:90b:3e8e:b0:286:576a:74d4 with SMTP id rj14-20020a17090b3e8e00b00286576a74d4mr13505842pjb.17.1702568739743;
        Thu, 14 Dec 2023 07:45:39 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902ee5300b001d37bdc4934sm138177plo.110.2023.12.14.07.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 07:45:39 -0800 (PST)
Message-ID: <657b2323.170a0220.165d1.0b2a@mx.google.com>
Date: Thu, 14 Dec 2023 07:45:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-69-g8f7b450fc28ed
Subject: cip/linux-5.10.y-cip baseline-cip-nfs: 6 runs,
 4 regressions (v5.10.201-cip41-69-g8f7b450fc28ed)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 15:45:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14110

cip/linux-5.10.y-cip baseline-cip-nfs: 6 runs, 4 regressions (v5.10.201-cip=
41-69-g8f7b450fc28ed)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
| regressions
-------------------------+-------+---------+----------+--------------------=
+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | multi_v7_defconfig =
| 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
| 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip | gcc-10   | defconfig          =
| 1          =

r8a774c0-ek874           | arm64 | lab-cip | gcc-10   | defconfig          =
| 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-69-g8f7b450fc28ed/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-69-g8f7b450fc28ed
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8f7b450fc28ed99196853536c98ae36c2567e160 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
| regressions
-------------------------+-------+---------+----------+--------------------=
+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | multi_v7_defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/657b1fe241cc8ec97ae13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-cip=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-cip=
-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/657b1fe241cc8=
ec97ae13476
        failing since 34 days (last pass: v5.10.138-cip15, first fail: v5.1=
0.200-cip40) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
| regressions
-------------------------+-------+---------+----------+--------------------=
+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/657b1d6a0c180bba99e13478

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/657b1d6a0c180=
bba99e13479
        failing since 34 days (last pass: v5.10.138-cip15, first fail: v5.1=
0.200-cip40) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
| regressions
-------------------------+-------+---------+----------+--------------------=
+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/657b1d9b131b24ef71e1347a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774b1-hihope-rzg2n-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/657b1d9b131b2=
4ef71e1347b
        failing since 34 days (last pass: v5.10.138-cip15, first fail: v5.1=
0.200-cip40) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
| regressions
-------------------------+-------+---------+----------+--------------------=
+------------
r8a774c0-ek874           | arm64 | lab-cip | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/657b1ba7aeb013d78ce1347a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/657b1ba7aeb01=
3d78ce1347b
        failing since 34 days (last pass: v5.10.138-cip15, first fail: v5.1=
0.200-cip40) =

 =20

