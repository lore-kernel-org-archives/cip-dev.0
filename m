Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FA5C7EE2F
	for <webhook@archiver.kernel.org>; Sat, 10 Jun 2023 10:54:59 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.15340.1686394489810078085
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 10 Jun 2023 03:54:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=vf+j949X;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1b039168ba0so15698375ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 10 Jun 2023 03:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686394489; x=1688986489;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WBIB56st9FqNcfF1agvdoNftgoqxn73MbZ+0uASUf1o=;
        b=vf+j949XZVK8cHaFdMSDjGOMyiT/W9BUF4AO3ATUc1MjYey3VH3unjwrTRDjKmvaDI
         bXsol6PXu10DyqHYoydxOKRqbqbPy1s+yNXBV5fYljwEDhoWaxF21kRbSzyhYh8jfWOu
         3f8Dm8/Ae+uEnwwYz4vw3UQY7dMwULMgnRrdZxGIqGVDQgkIxsN158D6S6equj5aT4fW
         qydRWYawuL+zLbwmY1oaiM4DTso5dapJaIj+zM6+ozYgKf+MWiAMSgVcZofKCpMuO+QX
         PzS72xBpIH9T9OB6j+GyS3hXuJsr0Zk3sbKiXZRGaEmHvyiBWK62f/5dMBLuymKIfK56
         Wjmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686394489; x=1688986489;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBIB56st9FqNcfF1agvdoNftgoqxn73MbZ+0uASUf1o=;
        b=atEBvaCVjusliU347iqUq4I3+BlvLLxbxQ1Ckb2kbFmjvJ6XM9DzvdVKfEWudR4tnb
         3g7KVj8Mz6kbFP40r720fjSHcADJqEM3L5aLFB/ILSM1EoUo8AJU+3UCosqzWvTOc/u9
         WdQ8eVpJugKPFzOehUvl4nEtucLcXJt3uFjkI7gQjlI2wKKvzo04dl2sgr4GEiQCdVgE
         6oLWwKvJmucPd0B9WjcqJ5NW6fFDVTlN8gSwoC0LeGr3Cp//rjbhxS8E9VZzsSvPuwxo
         903hkBOWVynLWrhTCQ7VWscQACPczZQ0AOKIIqF8nvXJ7y11RZgPwk2xEFyIbL86FocX
         LqPg==
X-Gm-Message-State: AC+VfDwGMLOfIMHqh+9qd+Qj7mrAppy/Yz4/2BttP2SS8h/mIKnjsZIG
	j8Z8Uc6r6pr/yblM/q6U5AuoM/WmOjWwd/zlYCwtGA==
X-Google-Smtp-Source: ACHHUZ4n9FiMmJxSwkYhHDqakPCP8JPuPWH1t672/2IvfKEtNxqRmBF9/7QbOXb858vPz+S3DpVk0A==
X-Received: by 2002:a17:902:d501:b0:1b0:663e:4b10 with SMTP id b1-20020a170902d50100b001b0663e4b10mr1729334plg.64.1686394488679;
        Sat, 10 Jun 2023 03:54:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b001b027def496sm4711555plf.270.2023.06.10.03.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 03:54:48 -0700 (PDT)
Message-ID: <64845678.170a0220.ea7f.a07e@mx.google.com>
Date: Sat, 10 Jun 2023 03:54:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.31-45-gce658d9231044
Subject: cip/linux-6.1.y-cip baseline-nfs: 58 runs,
 3 regressions (v6.1.31-45-gce658d9231044)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 10 Jun 2023 10:54:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11963

cip/linux-6.1.y-cip baseline-nfs: 58 runs, 3 regressions (v6.1.31-45-gce658=
d9231044)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =

beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =

imx6q-udoo       | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.31-45-gce658d9231044/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.31-45-gce658d9231044
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      ce658d9231044091c42896a08fbbfad40ebc58ce =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/648450ec96bd81924b30612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-45=
-gce658d9231044/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-45=
-gce658d9231044/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/648450ec96bd81924=
b30612f
        new failure (last pass: v6.1.26-1320-gc38e4a9845945) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/64844bd5b8ed7f3889306193

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-45=
-gce658d9231044/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-45=
-gce658d9231044/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64844bd5b8ed7f388=
9306194
        failing since 3 days (last pass: v6.1.26-1314-g1ab0ac1d7e2e3, first=
 fail: v6.1.26-1320-gc38e4a9845945) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
imx6q-udoo       | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/64844d344b002f57c430625f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-45=
-gce658d9231044/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-imx=
6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-45=
-gce658d9231044/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-imx=
6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64844d344b002f57c=
4306260
        new failure (last pass: v6.1.26-1320-gc38e4a9845945) =

 =20

