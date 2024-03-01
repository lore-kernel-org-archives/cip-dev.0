Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC72C5478C
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 15:22:15 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.25900.1709306525494439648
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 07:22:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=aobWCWUA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc09556599so20585365ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 07:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709306524; x=1709911324; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cfxZ0wtYVaiOn96ctx9NkIp/6k1IzgCfJEirVno/ak8=;
        b=aobWCWUAdyj8cZfWoGN8vMV4Rn1L4kd3Szprfr0+H4HJcmdoH+AgKjpGP5Gyqkld3u
         4ajUexqEHW65SAptrLF0x84aCp2sJ9a2Jyb2TKKSZQk7ZmzQYjRMAiprVP2+R2WyM7yH
         Ag3VRgnZatWGs73jhb+OMM1njlaRm3EzjsKDabi+KyYxHVs+k+VWF5OW4S6T8hYCmzV9
         nxAyB5WHrOmtFCN5flRkXpwmj4cOn6nOF/pqicCQ2Aj4QgBhSDCMlK4So/yCwSQ3a1cO
         2+VKodN5tmf0oPS+XERcupkq1uNCseywfC8dtU9Z7pvhwis2vQB7pwgUGA/ziN81bo3H
         en/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709306524; x=1709911324;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfxZ0wtYVaiOn96ctx9NkIp/6k1IzgCfJEirVno/ak8=;
        b=OLoovzK6v6M0FVyxgTnjNwcyHdqbnNjojcRmsPX3zGtmsOvmJaOy+Q9pOkSPwz8CNS
         s1w3SrJ7Fk2X2jncNUO1HRP3EkCfozDJltlBEGztrgL+lY9AiksyeDoHiGiPcvygUQQ8
         7QLe1i8QnsCCvwGVhaGKvNRTY0+Ci1QMoSmu7vL67YGvEdi94+e2BWAkb0QY81GNm2y6
         xAHnjajluj+np/tt9KF8cYWZaoXnuFmsJkpQAzBXePEtTmeyHkUuAdLJxhEj+mxz27yv
         0rJszo47HOFMk5TjWb4dTpNrQXXR5bnUc3hXl0vxT7I5zyFkb731jy/ZIjJOCnII48+c
         /mgw==
X-Gm-Message-State: AOJu0YxeQ2jRZZIpgLm0w8UHv6exjgHwDKoJFLv8y5/EHjD8GIHNttuF
	k0BfxvqNo5HJQq5v1EWW7THHaqsDlJpZjOLBa4uuvN6R9jBIvnX7mLrlD8sWYJbKjUVvsdIeypg
	amsM=
X-Google-Smtp-Source: AGHT+IFNOc+4pj+wNQ9TSoRVvGAzUNor43ljdGG7rfhYgY5HlgpPEm/PmUb8BMTL3KePXeMfLWB/Rw==
X-Received: by 2002:a17:903:1248:b0:1dc:744f:5317 with SMTP id u8-20020a170903124800b001dc744f5317mr1786038plh.50.1709306524370;
        Fri, 01 Mar 2024 07:22:04 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b001dca997b3e3sm3569217plf.65.2024.03.01.07.22.03
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:22:03 -0800 (PST)
Message-ID: <65e1f29b.170a0220.1e176.fbaf@mx.google.com>
Date: Fri, 01 Mar 2024 07:22:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.209-cip44-56-gdc749db3de7d1
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 12 runs,
 2 regressions (v5.10.209-cip44-56-gdc749db3de7d1)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 15:22:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15123

cip-gitlab/ci/pavel/linux-test ltp-timers: 12 runs, 2 regressions (v5.10.20=
9-cip44-56-gdc749db3de7d1)

Regressions Summary
-------------------

platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.209-cip44-56-gdc749db3de7d1/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.209-cip44-56-gdc749db3de7d1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      dc749db3de7d1c1c07950e25062de70fd66057ae =



Test Regressions
---------------- =



platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/65e1e2c9924b9b0f8b63701f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/riscv/defconfig/gcc-10/lab-broonie/ltp-t=
imers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-56-gdc749db3de7d1/riscv/defconfig/gcc-10/lab-broonie/ltp-t=
imers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65e1e2c9924=
b9b0f8b637024
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65e1e2c9924=
b9b0f8b637024
        failing since 24 days (last pass: v6.1.75-cip14-6-ga817aa655908, fi=
rst fail: v5.10.209-cip44-rebase) =

 =20

