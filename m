Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B082C83F15
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 20:38:01 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web10.1337.1693427878395015073
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 30 Aug 2023 13:37:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=i5LUobpK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-68a3b66f350so62701b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 30 Aug 2023 13:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693427877; x=1694032677; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yPar5Z6GJZhr4IwuQO4XBIBirKbD4AgEb34cAJp5JpA=;
        b=i5LUobpK3ZFEbLKPe42HYZkTjXmip0CtBFbTUxcK3w3BDzDOk5SbdoaGhGrKdntdid
         hDuBS1oKBDXSnLKKoIhIjfkelgtcQiiBSvrXGYgtpVBMT0vCn4C0/uUeNqHGrQ43cPRH
         vCMtx5XSwUJXw0b9Y/Wq4xWf71Dg/AbSZB7HYG/72J35XoX42HoVpKawbdxQGwmhRvuz
         8T7gNG/cLGoMg7u54FXzFA157WmSiP+VufkKsD0qUKxYTI7ZeGUJiV9Fz4D7z5EV70JL
         c3T8Fid5yhL6P1OdOMfN9svzBVbnzsctnj8HmbAvZ/81Degqx88La67eYoW2nF41QhAF
         +YAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693427877; x=1694032677;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yPar5Z6GJZhr4IwuQO4XBIBirKbD4AgEb34cAJp5JpA=;
        b=JEFzP4vjWDen3gJis9Tzoj0KFa5dtqRsYQT7d/P3+LomkvAgFIxXT46vbojqZTIxG1
         ANfBTMZ5qzxkfAKW0BZSWDS2ZOM+XMWlJ2c8Xs7nxxskPuR0UeoMgLFMl/eRmcoi6de3
         +CcuOSR8g/dBHKk1g4F9qYDxhjkJ0aXWJNfoM0Sna7lmoAwAeWAMXhN5yL1/8hE24z4J
         O209JGqOng3H7uOIkUVoaXNjUaX6RfIBOlfvztQWnc/Spa2aW8fDK6eywkj9pU2AGEaX
         xKaXxQ9IFmKnBPvZpsHxADoLtSFSVhpBs1e8xJn2LVwU8g2xiCXDcD5iWtABC295JzPx
         qsiQ==
X-Gm-Message-State: AOJu0Yy6WMo/ZNkHlOEXB69UgII+CdSxSE9F178xN7R05Tr0yAy4NBGs
	DLDk1n66RCc5l/ydx7LaMSOJTQYsE568ecBHzw4=
X-Google-Smtp-Source: AGHT+IE8+QVeptRMLEyDK3/HNDeAOQyZUkklGxQkkDm/6WLyQSJMP3r83fY2l7aSaqa8vHi+UAVaaA==
X-Received: by 2002:a05:6a20:1011:b0:14c:512c:60d9 with SMTP id gs17-20020a056a20101100b0014c512c60d9mr3010259pzc.27.1693427877064;
        Wed, 30 Aug 2023 13:37:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d3-20020aa78143000000b00687a4b70d1esm10399352pfn.218.2023.08.30.13.37.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 13:37:56 -0700 (PDT)
Message-ID: <64efa8a4.a70a0220.d648d.22c9@mx.google.com>
Date: Wed, 30 Aug 2023 13:37:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.191-cip38-218-g9947ff6f0dba7
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 5
 runs, 1 regressions (v5.10.191-cip38-218-g9947ff6f0dba7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Aug 2023 20:38:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12923

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 5 runs, 1 r=
egressions (v5.10.191-cip38-218-g9947ff6f0dba7)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.191-cip38-218-g9947ff6f0dba7/plan/ltp-fcn=
tl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.191-cip38-218-g9947ff6f0dba7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      9947ff6f0dba77de14d710cf958ecb42c2f4c10f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/64ef9718c27d698c7a286d71

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/riscv/defconfig/gcc-10/lab-=
collabora/ltp-fcntl-locktests-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/riscv/defconfig/gcc-10/lab-=
collabora/ltp-fcntl-locktests-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/64ef9718c2=
7d698c7a286d72
        new failure (last pass: v5.10.186-cip37-982-g80a0585c0aa62) =

 =20

