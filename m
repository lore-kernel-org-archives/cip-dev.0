Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB05C61D97
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 02:30:13 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.128213.1700793012008592768
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Nov 2023 18:30:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=iBFNrAmw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1cf7a1546c0so12312855ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Nov 2023 18:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700793010; x=1701397810; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2nHEZvxO0AFNC380DYWWNfl6s3gYdSDGiW1vHlhheIM=;
        b=iBFNrAmwayrX0YpdHzl9P3kzS9ivYSexAQmdFm9KgkXaJiy3QSDXvFiQUV+Ts3PmOL
         MKoKmOkOSJj32SB9ieQ7A+FEr57GoA7hEF8tDvwIUdOxXc6pq1LYHshIEZgct1cqa2ML
         xHfwzuHQkuxzOaas1iwTKs6e6q+m8Z/d3ZVb05IlAN/8UPkT/Lfew2EgAgMAL/Xr0kGG
         7ukPKPcpA9a3+4Q/OghmyIVga8+BRPwaHXWtSAr5i0QXf9yNhM4RehStIufUcR5piqve
         oonOxuNJIGwNi0+Prpgl9xRgISa3Yf/a9XOPsSYQ1tRhWyaRA4KmFpguleZFg19UwTXM
         Q1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700793010; x=1701397810;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2nHEZvxO0AFNC380DYWWNfl6s3gYdSDGiW1vHlhheIM=;
        b=rOQ8jSWgj9mD/OGu0xCX0NGWUr+qe3CMQPpwehL2Z58C0UYVhp8i4SoroBGDgb/9bS
         UfB/9Iaald89Oc2f2137Xy1Cz220J6/jjcGT2OOZs146EuLmMOxb5sJTxzMwXkiv1sD1
         HolXXZOb2ioBiZJFYqLEbJv0Cj8GxbHJAKhMbrlHxzw5lF7cigCmLT3qdDNZpfNXLdq9
         dd1Uh8xtkx/YP281Ry47R7u7GttzCLuoqoXzKVqYI1XjPMO7CKwj1NFuMxYrm2y5Mv4G
         q+o7fH1HQeWwIkiY3sXYCO8T2ndJIzePqQ5a170Y7YvSYy0jDR71PxbnTYtj7X5j6mnn
         NtDQ==
X-Gm-Message-State: AOJu0YwTGs0I0PjupEUTOtIFKnYXHdkAXbzqP+lD46+Gs1H1M9Vgc1oy
	LHtRJJZnGPPlyHvZXjR7ndTyHC8Se0YPAjQ0vIc=
X-Google-Smtp-Source: AGHT+IHuDzDR4kTcVIzVIZm5COPSHlRAoUQHT2Hvv9rWNr3J0s8fFPDAtpzgpfeDCGQ6yjkeUm50eA==
X-Received: by 2002:a17:903:1107:b0:1cc:5a74:b1df with SMTP id n7-20020a170903110700b001cc5a74b1dfmr1811069plh.2.1700793010498;
        Thu, 23 Nov 2023 18:30:10 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902d68b00b001ce6452a741sm1930125ply.25.2023.11.23.18.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 18:30:09 -0800 (PST)
Message-ID: <65600ab1.170a0220.6a5ed.4e03@mx.google.com>
Date: Thu, 23 Nov 2023 18:30:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.201-cip41-rt17
Subject: cip/linux-5.10.y-cip-rt baseline-cip-nfs: 14 runs,
 5 regressions (v5.10.201-cip41-rt17)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 02:30:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13701

cip/linux-5.10.y-cip-rt baseline-cip-nfs: 14 runs, 5 regressions (v5.10.201=
-cip41-rt17)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
    | regressions
-------------------------+-------+-------------+----------+----------------=
----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig | 1          =

beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
    | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
    | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.201-cip41-rt17/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.201-cip41-rt17
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      78ed1354cecc021db9a1d8a8b4755fdfcd826e33 =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
    | regressions
-------------------------+-------+-------------+----------+----------------=
----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig | 1          =


  Details:     https://kernelci.org/test/plan/id/656001147d49354c887e4a7b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-cip-nfs-b=
eaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-cip-nfs-b=
eaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/656001147d493=
54c887e4a7c
        new failure (last pass: v5.10.100-cip2-rt2) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
    | regressions
-------------------------+-------+-------------+----------+----------------=
----+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig | 1          =


  Details:     https://kernelci.org/test/plan/id/656002c7626b6233a47e4a6e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-cip-nfs-beagl=
ebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-cip-nfs-beagl=
ebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/656002c7626b6=
233a47e4a6f
        new failure (last pass: v5.10.100-cip2-rt2) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
    | regressions
-------------------------+-------+-------------+----------+----------------=
----+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/6560066149a22e53817e4a9e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/6560066149a22=
e53817e4a9f
        new failure (last pass: v5.10.109-cip5-rt4) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
    | regressions
-------------------------+-------+-------------+----------+----------------=
----+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/656007c016220c6eae7e4a72

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774b1-hih=
ope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774b1-hih=
ope-rzg2n-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/656007c016220=
c6eae7e4a73
        new failure (last pass: v5.10.109-cip5-rt4) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
    | regressions
-------------------------+-------+-------------+----------+----------------=
----+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/6560066bb5a35a1e277e4a6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774c0-ek8=
74.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774c0-ek8=
74.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/6560066bb5a35=
a1e277e4a6e
        new failure (last pass: v5.10.109-cip5-rt4) =

 =20

