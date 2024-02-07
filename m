Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96FAC4829A
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 20:44:41 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web10.879.1707338678155427881
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Feb 2024 12:44:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=cKjwuTLX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d94b222a3aso9778895ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Feb 2024 12:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707338677; x=1707943477; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T833CkZXuryPipUpDFZ0vo0/B1uqtWkIzl9PRppMYio=;
        b=cKjwuTLXrPwvp7uzQdvKMuEy0ZBkAQQZ+cMyqN+ZRJV7JFFfKrO/IKuQkeLNrBHKgs
         P5XJSeuM+MvLGu3bMAoUaxagKnxNCaqi6W0UyP1OJ/9b4zrZUevUCW8eX8UABdlTqkMB
         m2lt3BdTlEdSSNC5dcFgeHhpMNszDO51gxqPOu9RjMLwRywOHuvqI7Nn5Qfrzu0VUEBB
         G0Hw8Apskfn03imutSuwPR8DBvgj7tWSJNGXVAGHvKdlNQcXnQTKYqalPDThAbF4EQyU
         Zb+uJ+0gp0e0EnV8Soa6y+jzHBEKdYS+qAsUlLAKR7LO2CFDVSfo3qs1/QAy0LT5aD86
         v9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707338677; x=1707943477;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T833CkZXuryPipUpDFZ0vo0/B1uqtWkIzl9PRppMYio=;
        b=rkhVwBs64ZJ3BXZr7kZGj2ynSyfaSqmbcbnQ+MOVfGsB9e3a93pIfxvmnWDuhpZDDT
         uVuNNZjAoKufkfdWQt6nbbfxlVwz/rsz7E2wWLID9WDaPjzJqlCyFoLfphm64Rtdx098
         n9zht+WY2BHw1qwB3r28jyyhHRv6EU3wyKvRDDCLgjAe/kwtVYysxxf5SWGeEhWphpHJ
         5+gfoWyeHWF47LQCjr/g+nf7iZ9mk+JnmzTwoPsMHvEQWxW1glXlXVDjYlVYATggJObi
         Tig9vUEfh2HCl8rhjd4cWvI6kIAu+nOuCiOquub//+gIPoEEpZxN4QBV8PLuOh2+4unx
         ZR7w==
X-Gm-Message-State: AOJu0YzNfmvAcuAe2Q0iqCIRJwCu8C68izgVICR2Xz4M/A7TbxiFRRGo
	40lunZ473JiOxtexz+UXwlc3I8O2L+RT6MuHjJ2mPRhAjjBf/GppKnygYrNPIt6cBuNQjwhk6eo
	Ag8Q=
X-Google-Smtp-Source: AGHT+IEb2IhrXvqjCtVoAqImN127ZYS/CPAR/GAvRqHzUTkUivb1weB/zBkUOb8itQwTId3iY/xwTw==
X-Received: by 2002:a17:902:ee42:b0:1d9:a50f:9419 with SMTP id 2-20020a170902ee4200b001d9a50f9419mr5864764plo.40.1707338677188;
        Wed, 07 Feb 2024 12:44:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUpjibuJoKK46jGurPVXjH4MotN6taBemNnQT9/rctFTOCTdzx80UVKrPeXWp/fAcw3KOlt+nm6O5ILKwvpx8Ed1DO3QBwvHoZ2Mi4ttED1BTuex35OrPGRT8fKVGcwBjGmDzmkYpDxzZYxKMh3VwgMjg==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ka5-20020a170903334500b001d99530e3eesm1882538plb.282.2024.02.07.12.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 12:44:36 -0800 (PST)
Message-ID: <65c3ebb4.170a0220.277bd.64d1@mx.google.com>
Date: Wed, 07 Feb 2024 12:44:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1251-g681701bd9bc1f
Subject: cip/linux-4.4.y-cip baseline: 65 runs,
 2 regressions (v4.4.302-cip72-1251-g681701bd9bc1f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 20:44:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14905

cip/linux-4.4.y-cip baseline: 65 runs, 2 regressions (v4.4.302-cip72-1251-g=
681701bd9bc1f)

Regressions Summary
-------------------

platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig | =
2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-1251-g681701bd9bc1f/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-1251-g681701bd9bc1f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      681701bd9bc1f65237982eebce24afcffab64f4f =



Test Regressions
---------------- =



platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig | =
2          =


  Details:     https://kernelci.org/test/plan/id/65c3ddc2cba1f954238e1eb9

  Results:     37 PASS, 22 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1251-g681701bd9bc1f/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1251-g681701bd9bc1f/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/65c3ddc3cba1f954238e1ee2
        failing since 378 days (last pass: v4.4.302-cip71-1-g61333eee4869, =
first fail: v4.4.302-cip71-590-g22fc523bf881)

    2024-02-07T19:52:04.257470  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA[ =
  26.250398] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-au=
dio-present RESULT=3Dfail>

    2024-02-07T19:52:04.257704  ST

    2024-02-07T19:52:04.257757  =


    2024-02-07T19:52:04.262141  Print numbers from FIRST to LAST, in steps =
of INC.

    2024-02-07T19:52:04.264493  FIRST, INC default to 1.

    2024-02-07T19:52:04.264836  =


    2024-02-07T19:52:04.267779  	-w	Pad to last with leading zeros
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/65c3ddc3cba1f954238e1ee3
        failing since 378 days (last pass: v4.4.302-cip71-1-g61333eee4869, =
first fail: v4.4.302-cip71-590-g22fc523bf881)

    2024-02-07T19:52:04.203991  [   26.200175] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dfail>

    2024-02-07T19:52:04.244806  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2024-02-07T19:52:04.245133  =

   =

 =20

