Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC626C10DC3
	for <webhook@archiver.kernel.org>; Mon,  4 Dec 2023 00:04:37 +0000 (UTC)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
 by mx.groups.io with SMTP id smtpd.web11.52070.1701648271273614187
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 03 Dec 2023 16:04:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=TNAKXmRV;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.45, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1fae23895c9so2132234fac.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 03 Dec 2023 16:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701648270; x=1702253070; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTlko0Gr+ZYCkUhsshpAVf6PH6KO3hRABFumfpcaYm0=;
        b=TNAKXmRVtuJKaf/mC/wgnJjdrn0y9yBfM3HJVkSBTtY/fiAfVnfFf9ppyYMbCffSPn
         LCiT+eYJKpPvU81x6i4SVveq4JRatAx/cH6W1ukYCNgsxLfcVTjM4bDsROkj2RlUrma7
         M3GRlznHumYspiBY7tVxJfUIliGOKl5WiprsP9P0l9kNpdxTU1aKx0Yr7NHk4qGBK7Qx
         U0InJZOSxz4m0lCS7z5CaU/oLku48SWy3j+eOOuQnS0th6yWHVfRmgPog9ZxOGWVQ5KW
         hElAkGHbyxMkobk8o+f2Tgeug/uKS2+1OQKxajyMS82knGz40wDx0cMg+9/GNd0FxzEe
         BofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701648270; x=1702253070;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZTlko0Gr+ZYCkUhsshpAVf6PH6KO3hRABFumfpcaYm0=;
        b=IBSNSPgv/nrtwmkNgdakfvOBcO0Zsp8qSUmAf8K2XnSK1kyPK1HoSEQv0GZBvV6V1v
         5fprJxiHnT5r2vL9lccAgavUgzWIAuxIXPn62OzdUJL+dX1V2fux4r/2XihqGbFO97a6
         yzdtXPHAnOpeiWNe6x73svgD/0Cn7dVnxSQG1SZZDvj0pgWyWH9Ca6yi4UQw8XLebgMI
         SB3r7uFzOz8rRvRdWuxD0u39AmqWfhHyxcf8ct1zsnHfb8yB++fN7ddUq2a156pmWfmb
         buEIsZgTaq1h/8UlW2XiJg5A3M7Qyk40NdhyN/hHK2vyuLEwGDVeTkYIV88+RdAGXpU2
         pKHw==
X-Gm-Message-State: AOJu0Yy0Dlf1VXbECFEyVPFGJEOSOB7MGjYXOnCE4q6YSf5i/X8Fcufj
	Tchh7qg8Dio0t4GzxzpipVIkEWpbo4D+809LEFY3kw==
X-Google-Smtp-Source: AGHT+IFbLc6GYoVH45YHmC6PJ+anZUodXLWXHzGsuNiSsF9OJENURMc3QP7h5R2Ng9VsBKWsn0u67Q==
X-Received: by 2002:a05:6870:3328:b0:1fb:75a:6d3c with SMTP id x40-20020a056870332800b001fb075a6d3cmr4186605oae.99.1701648270058;
        Sun, 03 Dec 2023 16:04:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c18-20020a056a00009200b006ce458995f8sm1487320pfj.173.2023.12.03.16.04.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 16:04:29 -0800 (PST)
Message-ID: <656d178d.050a0220.5bd9a.2abb@mx.google.com>
Date: Sun, 03 Dec 2023 16:04:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.64-cip10-rt5
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 8 runs,
 6 regressions (v6.1.64-cip10-rt5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Dec 2023 00:04:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13779

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 8 runs, 6 regressions (v6.=
1.64-cip10-rt5)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig         | 1          =

beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =

beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.64-cip10-rt5/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.64-cip10-rt5
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b0295fc12bdaf65b61b93e18a316c8e20c1f2507 =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig         | 1          =


  Details:     https://kernelci.org/test/plan/id/656d0cd79012dd7c06e1352a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-cip-n=
fs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-cip-n=
fs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/656d0cd79012d=
d7c06e1352b
        failing since 441 days (last pass: v4.4-st20-229-gb433f12afe250, fi=
rst fail: v4.4-st20-231-g7349cef09ddd2) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/656d06bf43cf2606fee134a6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-cip-=
nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-cip-=
nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/656d06bf43cf2=
606fee134a7
        failing since 13 days (last pass: v4.4-st20-231-g7349cef09ddd2, fir=
st fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/656d081ed38403f914e134cc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-cip-nfs-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-cip-nfs-=
beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/656d081ed3840=
3f914e134cd
        failing since 13 days (last pass: v4.4-st20-231-g7349cef09ddd2, fir=
st fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/656d09f676362ab085e134c1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline=
-cip-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline=
-cip-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/656d09f676362=
ab085e134c2
        failing since 9 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543e,=
 first fail: v6.1.62-cip9-12-g3a5321f469b07) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/656d0962b043f22d07e1347c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline=
-cip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline=
-cip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/656d0962b043f=
22d07e1347d
        failing since 10 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543e=
, first fail: v6.1.62-cip9-13-g34c303883a305) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/656d0ce59012dd7c06e13531

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774c0=
-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774c0=
-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/656d0ce59012d=
d7c06e13532
        failing since 13 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543e=
, first fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =20

