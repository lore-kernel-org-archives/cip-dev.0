Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93619C4828D
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 05:35:29 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web10.14525.1707284128075533941
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Feb 2024 21:35:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=pbbqPvH0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.174, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso155496a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Feb 2024 21:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707284127; x=1707888927; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4cTjxYRxK2rR0ZjL8hQGzZ0Z8XYyWv1Lv0Dq/hat2BM=;
        b=pbbqPvH0QiHhkQ386peIL1kvIzXP/9zNwE2V+/gy4lTpxiRx5L5yUXkcPb4SMGJZiK
         jROLHs5n2xRzCenFa7sYWhP/C6SzFah5VhgQ3GSuHAePz+qCwPAikHmpnZlf8l/6/8Tv
         sZV9UTDLD0861erA7fwJ++7CT5NG/RyszAvUes0Zu1/wpsqIfda3YbXzLsN65LwhwFyy
         cOQftdzouCMK6Q+xrCZq1Lgi4T4UoBGcazK4VMw6WrwRhMvtmKJd73l6QISqv2gSdDf9
         QzTkWNz0VVG6iJaCUmwKVvZfn0BN/xjcmhsmf363Lo3R/+xKz46Kz0wAJIrIA+FnV1vd
         URoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707284127; x=1707888927;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4cTjxYRxK2rR0ZjL8hQGzZ0Z8XYyWv1Lv0Dq/hat2BM=;
        b=dkJsrYiwD5KA3vFzm0+s1g/kAUCVpxD5wvE95GpZ/XXsxCcQWWkMhESo09oHYwI5S8
         PWv/gPW4DY5mQjiSHm1gTelBii6EOrQ1NxE13fjsIqYQVatnLtpI/MX3w3nMS1iPalP/
         vrP/HV9lZdP5reucKhb/NGyfR+WYSYILnrbjpzUSGViMd8Hbi5+ovUKP2webrWlk6n3y
         XQoCocTURvUdSEsWwQ7mU5kv3xY3m8jf1gQZhWkmfrRTu3e9dywf5qZixRt0qbj1PY4t
         oSqcyS6SG49rskZRXdov4/Pl5p/RGx78nkfSXNWbEIuiYxlg5YAOojzmTYLdzLvJF24V
         vQoA==
X-Gm-Message-State: AOJu0Yz10YVTdqpdwmLo71KvuIaAYxqCkJmccwqrdYmQ+zfzoUnwR3bp
	SgCWA2ZjdsNX7nA9UAWa9dNk+1x8UNG98II7AEUgkkFGxJc1Yec9fF23Qo8xPXZ9DtSBGn5WKFF
	O
X-Google-Smtp-Source: AGHT+IEXQ7bBtoxLlqUQietDF4GhqJfSujqS7sy3LPWvUsUNrIvqsi1lKuZsl+oXnoJPNmUq0aOeIA==
X-Received: by 2002:a05:6a20:958e:b0:19e:3ccd:6f86 with SMTP id iu14-20020a056a20958e00b0019e3ccd6f86mr4857496pzb.43.1707284126928;
        Tue, 06 Feb 2024 21:35:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqkjbdY6HiYifOQluynxI9ASC5W/RH21xlcT4HjrAL0cUu8btHMxsu5Jm7Y2GMC21/9tKUqmBSbQGi5ADM6OmHRhdjuUMP7uKABr+rzcpWHybHeYmPzWh5s481SoifL+f4Vf9LdFGzP0xL3mQPKu6seQ==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id kw13-20020a170902f90d00b001d9f1b293dcsm226163plb.88.2024.02.06.21.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 21:35:26 -0800 (PST)
Message-ID: <65c3169e.170a0220.70dab.067c@mx.google.com>
Date: Tue, 06 Feb 2024 21:35:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1250-gd530578b1386
Subject: cip/linux-4.4.y-cip baseline-cip-nfs: 5 runs,
 3 regressions (v4.4.302-cip72-1250-gd530578b1386)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 05:35:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14869

cip/linux-4.4.y-cip baseline-cip-nfs: 5 runs, 3 regressions (v4.4.302-cip72=
-1250-gd530578b1386)

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

beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-1250-gd530578b1386/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-1250-gd530578b1386
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d530578b1386a94e84c4ef7993e59fd028af441d =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65c3109cccd6c17ac28e1f96

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1250-gd530578b1386/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1250-gd530578b1386/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c3109cccd6c=
17ac28e1f97
        failing since 57 days (last pass: v4.4.302-cip70, first fail: v4.4.=
302-cip72-1187-g657481329b53c) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65c30e6a1debb724808e1e8c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1250-gd530578b1386/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1250-gd530578b1386/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c30e6a1debb=
724808e1e8d
        failing since 57 days (last pass: v4.4.302-cip70, first fail: v4.4.=
302-cip72-1187-g657481329b53c) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65c30f1bcfa9677a158e1ecc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1250-gd530578b1386/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-cip=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1250-gd530578b1386/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-cip=
-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65c30f1bcfa96=
77a158e1ecd
        failing since 57 days (last pass: v4.4.302-cip70, first fail: v4.4.=
302-cip72-1187-g657481329b53c) =

 =20

