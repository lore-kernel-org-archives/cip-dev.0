Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D6BEE0200
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 18:12:32 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web11.4324.1694628745891519968
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Sep 2023 11:12:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=fKm3xxer;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1c3cbfa40d6so543665ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Sep 2023 11:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694628745; x=1695233545; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=idADWK5blNV7U1tKRL5YYxdzNsUu1lnfmprDrAkaV6w=;
        b=fKm3xxerC9lmGku5bYACmVQkrQd1do5MnRJuwQ/YrAAgeoMp6JP468rGtSTigJJE+y
         QvohtNcIxCPbZHuypnVv93/4THGWIV1rOG/iftgw0CkL/iXM7prxiUKDu3muWRoHmzYa
         R7qArMngW/0gA7L2N+TV/C0YTA2MOBX7C+R99WgyWlSKa2qtwmaJY9ABc917JmZSN1sp
         5SdbrjyUGmJWrFXS8IhdwAAXThtSm1BsStWt85KVS7tZ8+hkmH850gf29avNzRXcc2eq
         zgU0oIkNB8N1tjEGM8iEa07LeZAklVw4Uy/VFnT9sJv7JGpYlITQmuQswbfho7cLNuEZ
         8g4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694628745; x=1695233545;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idADWK5blNV7U1tKRL5YYxdzNsUu1lnfmprDrAkaV6w=;
        b=LmoLyC3Pmhv7i1QEUM7nRmrbPGShBAUm1+3qqJeKfRaYhX10MPpF94zwZ4hOzAul/O
         jpbSuzQVsN9sijpb/ztA8rA9dvJKz54hbyhjpehptVxdVSi4iGHC2Qz8/yjPwxiiFzzI
         PJ83ocI/+QzUQdFGGyFnOlX5oYGOlVnvmvGlKZ+oNr3WL9T638eO/hXCbocIL9SHR+wh
         tMRzBObAJawafvQw4UvhceTX62L6WUbG8NfIobwyEAnq1VRfJOPgWdH1BbaBP8ZSd1yJ
         OuPf8bKBuNjTG6C/zHVrfzYSCoh/1EMQ1RQDdt1IRZAzROhs9s+N2fPkxm7+pigNGc2K
         EnWQ==
X-Gm-Message-State: AOJu0Yynub9d14Sccr8LHSyct16qooaFm2Q4Bg8D1sNFGMSKapn9miBZ
	PwzwFxHcqxB2K7xg+UmOBf6RMwYRuNJ7mQgWPuA=
X-Google-Smtp-Source: AGHT+IEJ64+tZsDrotH+kDGX5DFP8E6e/eJSyMdIiDAzT+WjXQV/oRgnxpwi7gZxnndEolpB9Yf2wA==
X-Received: by 2002:a17:903:455:b0:1bc:98dd:e857 with SMTP id iw21-20020a170903045500b001bc98dde857mr3508912plb.38.1694628744862;
        Wed, 13 Sep 2023 11:12:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g18-20020a170902869200b001bdd7579b5dsm8554078plo.240.2023.09.13.11.12.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 11:12:24 -0700 (PDT)
Message-ID: <6501fb88.170a0220.c94ff.9764@mx.google.com>
Date: Wed, 13 Sep 2023 11:12:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v6.1.52-cip5-29-g9fee06894d496
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs,
 2 regressions (v6.1.52-cip5-29-g9fee06894d496)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 18:12:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13124

cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs, 2 regressions (v6.1.52-c=
ip5-29-g9fee06894d496)

Regressions Summary
-------------------

platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.52-cip5-29-g9fee06894d496/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.52-cip5-29-g9fee06894d496
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      9fee06894d496c0a873d78633ef74e3395d81c89

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/6501e9aadb33e7b8128a0a8f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/riscv/defconfig/gcc-10/lab-broonie/ltp-time=
rs-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/riscv/defconfig/gcc-10/lab-broonie/ltp-time=
rs-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6501e9aadb3=
3e7b8128a0a94
        failing since 99 days (last pass: v6.1.26-1298-g61395b9756bd5, firs=
t fail: v5.10.180-cip34-26-gc198172c84b6a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6501e9aadb3=
3e7b8128a0a94
        failing since 99 days (last pass: v6.1.26-1298-g61395b9756bd5, firs=
t fail: v5.10.180-cip34-26-gc198172c84b6a) =

 =20

