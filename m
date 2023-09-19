Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17EACE79A9
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 15:55:38 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.13498.1695138936021754693
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 19 Sep 2023 08:55:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=DU8eD3CY;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1c434c33ec0so32318105ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 19 Sep 2023 08:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695138935; x=1695743735; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AedyQxDjZIFpKvYHtkyAaQ5jLXStSNsCXCicE0PsP8A=;
        b=DU8eD3CYq51aQ7+13txsv+9RnJv036UWC5SGxt+VnXBFfGEmmZfMWg1ZNMMxn5Yjq0
         hMiZPc4HxZI3lAcoO7t5tih5m4B53vBUqe49c/Vg06ElPNiSJ56Tg3n4TWS6HjiRuJNx
         TVOAWq89fCM1qmiyK5OBepVZaIlx5ikPvFNZClCT9xP0neUgtRCb13YJ8V7SBzHZEJJy
         iVIkNXjnCdTO8HZfPZJDUrQrBXBtl1Yt89rT3YM4aEttlIij+dkhuDRh+JbnVQhNrmUt
         rQEyHb5Oruf8uwxbGsUygAyJ3x/uNWBklLi32iPm+oaL9njiuJXW05sKM07JvUsnySy6
         s2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695138935; x=1695743735;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AedyQxDjZIFpKvYHtkyAaQ5jLXStSNsCXCicE0PsP8A=;
        b=Q22Sf7f3QFqNMZTVlmVIyflmY3nJM7qZS9DQxGOs7YKBx3dYkTxrc9Af8H3rJrveVv
         9R4hKFIfeYBU8W9f3JDvsfh+APEG5wtc0eQLtiDIn5A+ZPX7mbtcC1LZRt/H46qy1QKw
         HRxY0UhytDc3zwPwTQ/DuBNfd4ZQPVrVkLIjfs28kKwi2+yKGFyNB2wXObhP/78jHg4X
         HYwdjqZGcPucIh7vmGhE5esZgwikyuvX4qI8h1JCryg8kOT7362WVufBNph4MA45YKCh
         wpyqRiL1TvfZCq/stHQ9w2s/H9Xgy3++FxtN/I19pDo562xJ14fII0uicoNXMFDxceNd
         9c0A==
X-Gm-Message-State: AOJu0Yy00jkYE4PTHtM/lwtFFWBljNLh7UF0kOHENItZL0sumrNZ+pYl
	G92e76zkc6eNw4K+SMDy2n0uHnVw0NbO0Yn17oEsRA==
X-Google-Smtp-Source: AGHT+IHEpkbdWFR2hP+vNMLmUmpHai/bx/QQCasuf1IHAsY0jBwUTY8FqQsm5qLT4z9IGG5EXseCgw==
X-Received: by 2002:a17:902:eaca:b0:1c4:7c4:b2e9 with SMTP id p10-20020a170902eaca00b001c407c4b2e9mr11010659pld.43.1695138935044;
        Tue, 19 Sep 2023 08:55:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v7-20020a1709029a0700b001bdeedd8579sm10101141plp.252.2023.09.19.08.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 08:55:34 -0700 (PDT)
Message-ID: <6509c476.170a0220.ac39a.2cc8@mx.google.com>
Date: Tue, 19 Sep 2023 08:55:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.194-cip39
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-timers: 8 runs,
 2 regressions (v5.10.194-cip39)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 15:55:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13159

cip/linux-5.10.y-cip ltp-timers: 8 runs, 2 regressions (v5.10.194-cip39)

Regressions Summary
-------------------

platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.194-cip39/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.194-cip39
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      ecda23c2ad8c5eae1f19054d0b67a7904546b7f4

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/6509c0671a4b4319118a0a42

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6509c0671a4=
b4319118a0a47
        new failure (last pass: v5.10.191-cip38-29-g9e1aa2001db8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6509c0671a4=
b4319118a0a47
        new failure (last pass: v5.10.191-cip38-29-g9e1aa2001db8) =

 =20

