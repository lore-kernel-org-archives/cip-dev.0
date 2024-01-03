Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D719C3DA6E
	for <webhook@archiver.kernel.org>; Wed,  3 Jan 2024 07:14:33 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.12862.1704266071035815315
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 02 Jan 2024 23:14:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=AGGdh2Ij;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d3dee5f534so1199545ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 02 Jan 2024 23:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704266070; x=1704870870; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8dtb2GIPIpmnT4I6WVbqvAVy9+B9MwRHWvBRFVJMBak=;
        b=AGGdh2IjJecoX6hnUAj87jJ1INj522JzTOPCxFkyXNivA9WSsRKMRfM7CMN9gHgKCQ
         9W/Q6LnoOvxFO3XIRIjBqbNu0NxPOryWvW3ylor+MDDafCthCloFEP3gX7Uiveov79ya
         hhuVs0NeNfEYRftGjdElDHL202YpNkpWfIjEB+NCkDcj7eWnEs27zKOQbjCX4JZY0zpz
         slNHBevSY2YxurPDH6ctTMSerfhEpEhDrwYINBYZ8NLFxm9srt283kOomyxWTQ+0MGKv
         QDxt/OiCxbZEMj4YLH0Bi0GfKID5v91EzmoN2lEWpcSrx09WQ8JqX/XVAQ5wvrIyMKwK
         Vesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704266070; x=1704870870;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8dtb2GIPIpmnT4I6WVbqvAVy9+B9MwRHWvBRFVJMBak=;
        b=A5t83mDGAeu53XnP7GUgn3b0T5UYaSzim8wcp3gAvXutC6CfCnpm47BqKjYWdFz7Nf
         BgZIWaaQu0FVRKgPlwwQmifA4KcZ7bUW91kVgHerDRlggj6YMNDVadkTLn0PL4ZFYu96
         olycrQUJxtBv3F01BIvaKEu7wPokRtuzvpm4TZ4hn+iiiiU5tSO9cokOG25ir28fZodj
         MOoN+XAGpSFrMBYc+U0YzBqn3JUHWN+CCygLTr6IogOcn+lpTEOnLoD/ZwSgmEGoDTrV
         RwjpN0qzuM02vee1uienOSDaO06UpqK28kuvIX5lOuOwtsi/VFIrh2QZrYf5jwih9v8u
         sLtw==
X-Gm-Message-State: AOJu0YwaEXtrY0+JJ/p9Fuc4cGfB6bSVeIASh3rXdpRpwNCiMtoqkOuT
	IkDkYA0CPSK4Rb0RsNKMG1LRHlbdGkFRa+hEMzEmdjeHt/U=
X-Google-Smtp-Source: AGHT+IFbf+IiFxub0YjI9dhvd4/q5mAn8uzBGQfOBHPgBBr63zbs2TWNenZEakHl/6BBRZSfPzCrlg==
X-Received: by 2002:a17:902:d54f:b0:1d4:b4a:9cd5 with SMTP id z15-20020a170902d54f00b001d40b4a9cd5mr1028274plf.48.1704266069989;
        Tue, 02 Jan 2024 23:14:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902ee8200b001d362b6b0eesm23187798pld.168.2024.01.02.23.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 23:14:29 -0800 (PST)
Message-ID: <65950955.170a0220.2884.331a@mx.google.com>
Date: Tue, 02 Jan 2024 23:14:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-2023-g7107c2a794ba
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-st baseline-nfs: 27 runs,
 3 regressions (v4.4-st20-2023-g7107c2a794ba)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Jan 2024 07:14:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14237

cip/linux-4.4.y-st baseline-nfs: 27 runs, 3 regressions (v4.4-st20-2023-g71=
07c2a794ba)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

imx6q-udoo                | arm    | lab-broonie   | gcc-10   | imx_v6_v7_d=
efconfig        | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st/kernel/=
v4.4-st20-2023-g7107c2a794ba/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st
  Describe: v4.4-st20-2023-g7107c2a794ba
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7107c2a794baad1966136a65be58aa844a296613 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/659503c21552de14c577b580

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-2=
023-g7107c2a794ba/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/ba=
seline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-2=
023-g7107c2a794ba/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/ba=
seline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/659503c21552de14c=
577b581
        new failure (last pass: v4.4-st20-1988-gdf21aeeacf3cd) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
imx6q-udoo                | arm    | lab-broonie   | gcc-10   | imx_v6_v7_d=
efconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/6595037a4b61444df877b588

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-2=
023-g7107c2a794ba/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-i=
mx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-2=
023-g7107c2a794ba/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-i=
mx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6595037a4b61444df=
877b589
        failing since 22 days (last pass: v4.4-st20-1873-g923c12c3034a, fir=
st fail: v4.4-st20-1988-gdf21aeeacf3cd) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65950296bfcc5b397677b5cc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-2=
023-g7107c2a794ba/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/ba=
seline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-2=
023-g7107c2a794ba/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/ba=
seline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65950296bfcc5b397=
677b5cd
        new failure (last pass: v4.4-st20-1988-gdf21aeeacf3cd) =

 =20

