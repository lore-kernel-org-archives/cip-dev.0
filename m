Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D42C4828D
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 02:40:12 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web11.13344.1707187207026910704
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 18:40:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=0cX/pq/q;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5dc20645871so84252a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 18:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707187205; x=1707792005; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bhFNqzJ+sa3PK9eUlCsELCIJcngMJN7nxYMADyUyPiU=;
        b=0cX/pq/qT+F6rnnZpA6JYoEfLAbWM1Rhz0/OZHpbKSkoITUvnBRF404CueXenO56NP
         wbYollbbh3mSwCdn0a3v+BvIuK/ZoiKGy/bDfSCYa5HCu3V27IpdBXlBD9npaKOcxjtx
         MfxSGQ3a1u2BJ0jtkE7sndHaEBhq32PqHaMEDp7alLwcR5m6bqWNMatOjy9trxN0c0z/
         rWzoS4locbDwRMbttYYNLIhDCkxrVmfHI7eDhW8vtevSvVRzvR+hj1CHzVyc08hrAGvU
         ClkRKByal1txmf1gjbQ8Rk5UXaBo5KRE0vHPWGi62o7LPVf+jlJoNj20Nxax5enjFSd6
         giag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707187205; x=1707792005;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bhFNqzJ+sa3PK9eUlCsELCIJcngMJN7nxYMADyUyPiU=;
        b=w9Bj8dngP0m48SQxtRYC2JAowguu5pQsZo44dfQXaO5/UXUVEzrvE2HYFtt4IBENBP
         0tVc0LHoeYcZNDlS+r4VQKaA0GdVXDiJPTWIPZcBUMV4Dv5+wpdoKA90BV1eom6uy60i
         OJ9USTfG1bp7HkfJ7mTDa/sI4c7rqpeMJH7fGnidi5lj//KXjEal6rNEZPWVpzbnc9bH
         LObiXrAUSOmySAi4H7uedsDN6KHRxvaAdzc7FH+YOo9WHU+Ts3QBdK/or0+FQ08kcmne
         E461mIq/sAQRzc+SGorqIGTmqTVcBh3IXJr9vdfze5o15duAIbIN+9pCrM9ehX/RfYkS
         jHhQ==
X-Gm-Message-State: AOJu0YyYEKgMMsQJwq5JxRZVGdxFRspbPVVmubvsSyA4zDisrI3qI693
	xrqJ6fVB7fP46xsXdijejYY8dJyOKUjldHRASpHzHiPNhNvAwJZy+0r/Xc+sA3NyfMeJJTh9h3c
	W
X-Google-Smtp-Source: AGHT+IHyfSp8UYMZLUYh4Ct9NQrNONOATf1xYjlQytwiuGDIu+eKZ0Q7vuU99Ht3dTVStm0kw1++dw==
X-Received: by 2002:a05:6a20:1449:b0:19e:987c:8e58 with SMTP id a9-20020a056a20144900b0019e987c8e58mr497780pzi.11.1707187205488;
        Mon, 05 Feb 2024 18:40:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUKkSW/IUWI+37pitKvhHTS6Lcg//jL8QFVFzeuZ0w1D61puOBn9DUdj3VVPr5APwlSMqpiJEGdJoWa5yCQjZKCv3TVaT52nZ+EIqcFj/tiiw5wFlkfzLjDHXIqaFL3we1/atQ8L5rysxfPmEnGVWacHg==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b20-20020aa78714000000b006d9a6039745sm615741pfo.40.2024.02.05.18.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 18:40:04 -0800 (PST)
Message-ID: <65c19c04.a70a0220.f6966.3333@mx.google.com>
Date: Mon, 05 Feb 2024 18:40:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.209-cip44-rt18
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt baseline-cip-nfs: 15 runs,
 7 regressions (v5.10.209-cip44-rt18)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 02:40:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14767

cip/linux-5.10.y-cip-rt baseline-cip-nfs: 15 runs, 7 regressions (v5.10.209=
-cip44-rt18)

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

beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.209-cip44-rt18/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.209-cip44-rt18
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d814befd12dcf6c81b483cb36f507d70112c1097 =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1941f133473020700a084

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-cip-nfs-b=
eaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-cip-nfs-b=
eaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c1941f13347=
3020700a085
        failing since 74 days (last pass: v5.10.100-cip2-rt2, first fail: v=
5.10.201-cip41-rt17) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | multi_v7_defcon=
fig  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c197cd8801f7b3ce00a03f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-cip-nfs-beagl=
ebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-cip-nfs-beagl=
ebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c197cd8801f=
7b3ce00a040
        failing since 74 days (last pass: v5.10.100-cip2-rt2, first fail: v=
5.10.201-cip41-rt17) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1937a128123547400a052

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-cip-nfs-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-cip-nfs-=
beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c1937a12812=
3547400a053
        failing since 73 days (last pass: v5.10.104-cip3-rt3, first fail: v=
5.10.201-cip41-rt17) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65c19485c3dc30cf5a00a062

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-cip-nfs-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-cip-nfs-beag=
lebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c19485c3dc3=
0cf5a00a063
        failing since 73 days (last pass: v5.10.104-cip3-rt3, first fail: v=
5.10.201-cip41-rt17) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1986e9c2625678700a074

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c1986e9c262=
5678700a075
        failing since 74 days (last pass: v5.10.109-cip5-rt4, first fail: v=
5.10.201-cip41-rt17) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1994030f8f6969600a03c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774b1-hih=
ope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774b1-hih=
ope-rzg2n-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c1994030f8f=
6969600a03d
        failing since 74 days (last pass: v5.10.109-cip5-rt4, first fail: v=
5.10.201-cip41-rt17) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
     | regressions
-------------------------+-------+-------------+----------+----------------=
-----+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/65c198a05220d7bf1900a049

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774c0-ek8=
74.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774c0-ek8=
74.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c198a05220d=
7bf1900a04a
        failing since 74 days (last pass: v5.10.109-cip5-rt4, first fail: v=
5.10.201-cip41-rt17) =

 =20

