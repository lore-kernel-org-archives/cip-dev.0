Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C892EC4828D
	for <webhook@archiver.kernel.org>; Wed, 31 Jan 2024 13:21:37 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.13593.1706707291909041098
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Jan 2024 05:21:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=MCXeVNE0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d7881b1843so42266975ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 31 Jan 2024 05:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706707291; x=1707312091; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fsS/VlZ0fWvYHsgXCW9BRiAb1KYIfRT+vdsD5zgorAw=;
        b=MCXeVNE0cULaa3lUh9iaY35ueOQsDpUAyOK1XW8qXDEmf2ISjuWFLVlqo4XqbvPWlJ
         BwkB88ASTb5XUACSQxLAGpwIlmSpiCaXSH3fjHvCPatYMCFHXYi4qXzIYdv3GXAEIQRA
         E1zehsZfGXxk5SFDR7BL6Of/7svr1LQLcOzvZDZ9hr8HHLtI8AjHpwG3/OX/ZOgPPKyI
         YXrw0aWHH5xRNc6uVpsSNJ7isYsKkr2unYXzTqLRGb43XBH8dQ5IIXgxEBDx+Jkemgr6
         TV/PwiXA6y6rrxUBfZCR15VAJhcF3m6tpoJq7ol68+4MYJeUd/XB1JWM0LCZHwvivfDe
         8cKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706707291; x=1707312091;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fsS/VlZ0fWvYHsgXCW9BRiAb1KYIfRT+vdsD5zgorAw=;
        b=DHB3AOtJgsMKEO/VdghgtW2XOR34BP7WzLp/lHXuW5L0eH9QZc2BKs1aIaePNUmOsb
         rjEphzGH7PCITzXlDqv+JzFTBycb8gf/Vf0UDQeS27Uo8NyRDqXIew4XZ3JWV7ACIOQO
         pOnqT0jTWmkR0SQQiojm/DmYKTs2qvYcxcJJNYsnu0TBK9vvTvd8byLC+BTAcY6YHXLT
         A0lL6pr20SkKPVsBFoCyodc1omI3xi/ZB1Ie4XLgtGQJ1NXzkHJAOCDO02XCNZj+TbM3
         GulV9AeCjQ1AOMDGEn70J6eauP3u79dR9AZWQS8Wcp1wulAyeuFh0cipmOTf1W962VNr
         dZUA==
X-Gm-Message-State: AOJu0Ywm28yDdMyjIJvnNjtzFo8gUqYa8MC91U7j6owK/kPbbBFBk4Rs
	gkkOwaQXilBYeDkMbzI+pyx540LsCGZRBk04YXyQBhDoBvJNTtLI1Vugc9MnIRuLQ6ICd24uVWw
	T
X-Google-Smtp-Source: AGHT+IFsX5JE1sUWGi0IxnkTeZlgVZrPOuBbzyhG5UP/qZq1ZMcRW8a+bx1x6Tw1GSt8CRH5xCctZg==
X-Received: by 2002:a17:903:2344:b0:1d9:14fb:d142 with SMTP id c4-20020a170903234400b001d914fbd142mr2063257plh.32.1706707291014;
        Wed, 31 Jan 2024 05:21:31 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090332c400b001d942aa2554sm46002plr.212.2024.01.31.05.21.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:21:27 -0800 (PST)
Message-ID: <65ba4957.170a0220.84044.0421@mx.google.com>
Date: Wed, 31 Jan 2024 05:21:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.72-cip13-32-gf60d2e8cb51c
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 19 runs,
 3 regressions (v6.1.72-cip13-32-gf60d2e8cb51c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jan 2024 13:21:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14568

cip-gitlab/ci/pavel/linux-test ltp-timers: 19 runs, 3 regressions (v6.1.72-=
cip13-32-gf60d2e8cb51c)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig | reg=
ressions
-------------------------+-------+-------------+----------+-----------+----=
--------
qemu_riscv64             | riscv | lab-broonie | gcc-10   | defconfig | 2  =
        =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.72-cip13-32-gf60d2e8cb51c/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.72-cip13-32-gf60d2e8cb51c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f60d2e8cb51c9da65ffcfe73144286c27725ceea

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig | reg=
ressions
-------------------------+-------+-------------+----------+-----------+----=
--------
qemu_riscv64             | riscv | lab-broonie | gcc-10   | defconfig | 2  =
        =


  Details:     https://kernelci.org/test/plan/id/65ba36a5547688d0f900a039

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/riscv/defconfig/gcc-10/lab-broonie/ltp-time=
rs-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/riscv/defconfig/gcc-10/lab-broonie/ltp-time=
rs-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65ba36a5547=
688d0f900a03e
        failing since 49 days (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6=
, first fail: v5.10.201-cip41-77-g545d45774209f) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65ba36a5547=
688d0f900a03e
        failing since 49 days (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6=
, first fail: v5.10.201-cip41-77-g545d45774209f) =

 =



platform                 | arch  | lab         | compiler | defconfig | reg=
ressions
-------------------------+-------+-------------+----------+-----------+----=
--------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/65ba3197856437fb9f00a13d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r=
8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r=
8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65ba3197856437fb9f0=
0a13e
        new failure (last pass: v4.19.299-cip105-1134-gc868d5e4adaa) =

 =20

