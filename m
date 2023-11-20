Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C27C54E76
	for <webhook@archiver.kernel.org>; Mon, 20 Nov 2023 14:11:09 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web10.51032.1700489469072057516
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 20 Nov 2023 06:11:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Z0xYtFqE;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6bee11456baso3666608b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 20 Nov 2023 06:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700489467; x=1701094267; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=14bnJK+D5z2RpkuCLh363wR1T7n29A+aJ2alPj65JK8=;
        b=Z0xYtFqEYKrqZ6Hp9o8Fa5sUKOXXeMKoLvdtLUAmXRpgtM/zIUp1p7UwX1BoqzAANs
         xgidHjsrvw/T8HjEZnXQmPjWuLjMAAUyn2cHNVomO6H8J/TPEaNuFFHEHODkGhReoTXP
         at7+qFOBfTNMX5jyNNwVsjL1jDVXoF4nK/FX9GOpC5o3ot3DCl99nPXVK6iYDOi6rYkP
         NauewSG2D06Bo+V0MeJ63izYGw6cN4K6O6W+qvg7B4eShKNSDXGra2oH+KkzucGJS17s
         pzZIj8zlJ9ktXeHf4R8w1f4Aj4y2v78OH/Vnv+ASRJrBqTiys0USVX3WslpdqmICYN25
         FcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700489467; x=1701094267;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14bnJK+D5z2RpkuCLh363wR1T7n29A+aJ2alPj65JK8=;
        b=CY6/lkAVR/MnHTmJQoD78la9Th9yMmtDAhSyty2ehM5ZMZTLmJgPUVDeS85CXB1eYq
         iR2gYULwWM3mk6wB9sBGJIZ16X7bnR8DUvFOYKJvLQ3HiAy6tes5bWVaTYa9y36FUlP/
         XwyJYBIYk+N167iLlhkE9Y2tu3/SggoL3ESVAAEGF6XnaeVr2xmIW4ldf7R+oVjVQVwA
         kC4MrERbCqZqHr4IMSjVKdFetJNzCjbAr6vjigJdp24oL9b0aVSjuc9NJOegk5pTspBc
         BknbQ8scXlAbCnOFeu4OqUnvH8rohKLXerbyHVoGYNq7JrsxPIFGTKuEtLOiUbWLnVUP
         /V1Q==
X-Gm-Message-State: AOJu0Yz9lh9Ets4R0543EZIO7j60afKkuu2+WPZTikWWPXW0cB8UfX7z
	AaNBsNBgxL/TBY4mDYaPst3kbSCpjtTHXMRMgGw=
X-Google-Smtp-Source: AGHT+IEn/WTxl1+Govo8D8Nir5Q9EcrAJKsSx9IENSI1UdIw1dYeZHCXBAhHz81voFT/c7QhHaz5jg==
X-Received: by 2002:a05:6a00:392a:b0:6c5:11c:9ff with SMTP id fh42-20020a056a00392a00b006c5011c09ffmr6009317pfb.25.1700489467469;
        Mon, 20 Nov 2023 06:11:07 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g21-20020aa78755000000b006cb88a284f0sm2534063pfo.201.2023.11.20.06.11.06
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 06:11:07 -0800 (PST)
Message-ID: <655b68fb.a70a0220.2d7fe.58ee@mx.google.com>
Date: Mon, 20 Nov 2023 06:11:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.297-cip104-152-g5bde1c076bf53
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 62 runs,
 2 regressions (v4.19.297-cip104-152-g5bde1c076bf53)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Nov 2023 14:11:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13605

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 62 runs, 2 regressions=
 (v4.19.297-cip104-152-g5bde1c076bf53)

Regressions Summary
-------------------

platform          | arch | lab         | compiler | defconfig           | r=
egressions
------------------+------+-------------+----------+---------------------+--=
----------
beaglebone-black  | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1=
          =

r8a7743-iwg20d-q7 | arm  | lab-cip     | gcc-10   | shmobile_defconfig  | 1=
          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.297-cip104-152-g5bde1c076bf53/plan/baseli=
ne/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.297-cip104-152-g5bde1c076bf53
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      5bde1c076bf539d6bb2f2eb64fd95e7d2a5c3214 =



Test Regressions
---------------- =



platform          | arch | lab         | compiler | defconfig           | r=
egressions
------------------+------+-------------+----------+---------------------+--=
----------
beaglebone-black  | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1=
          =


  Details:     https://kernelci.org/test/plan/id/655b630b3de9ca5cfb7e4a94

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.297-cip104-152-g5bde1c076bf53/arm/omap2plus_defconfig/gc=
c-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.297-cip104-152-g5bde1c076bf53/arm/omap2plus_defconfig/gc=
c-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655b630b3de9ca5cfb7e4ac9
        new failure (last pass: v4.19.297-cip104-63-ge7301d2e196ae)

    2023-11-20T13:45:10.365870  + set +x<8>[   18.718433] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 256598_1.5.2.4.1>
    2023-11-20T13:45:10.366156  =

    2023-11-20T13:45:10.476008  / # #
    2023-11-20T13:45:10.577538  export SHELL=3D/bin/sh
    2023-11-20T13:45:10.577962  #
    2023-11-20T13:45:10.679166  / # export SHELL=3D/bin/sh. /lava-256598/en=
vironment
    2023-11-20T13:45:10.679543  =

    2023-11-20T13:45:10.780772  / # . /lava-256598/environment/lava-256598/=
bin/lava-test-runner /lava-256598/1
    2023-11-20T13:45:10.781598  =

    2023-11-20T13:45:10.785923  / # /lava-256598/bin/lava-test-runner /lava=
-256598/1 =

    ... (12 line(s) more)  =

 =



platform          | arch | lab         | compiler | defconfig           | r=
egressions
------------------+------+-------------+----------+---------------------+--=
----------
r8a7743-iwg20d-q7 | arm  | lab-cip     | gcc-10   | shmobile_defconfig  | 1=
          =


  Details:     https://kernelci.org/test/plan/id/655b60cc31ff5cbda17e4a6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.297-cip104-152-g5bde1c076bf53/arm/shmobile_defconfig/gcc=
-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.297-cip104-152-g5bde1c076bf53/arm/shmobile_defconfig/gcc=
-10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/655b60cc31ff5cbda17e4=
a6e
        new failure (last pass: v4.19.297-cip104-63-ge7301d2e196ae) =

 =20

