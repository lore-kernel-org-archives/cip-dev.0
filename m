Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E9EC83F01
	for <webhook@archiver.kernel.org>; Sat, 26 Aug 2023 17:26:17 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.12783.1693070777101243264
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 26 Aug 2023 10:26:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Zy5oEBMn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1bc63ef9959so15339095ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 26 Aug 2023 10:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693070776; x=1693675576;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vi4iVnrBKjHWhVINZcpbWygG9zBtc24+0dihcU6QSj4=;
        b=Zy5oEBMnd7cNSy/ynTzaoZtDGIfwJBXomfT+BHDb6YrzKpLu9dRsWFeWQgk7+BFpJr
         /luu+aD+TMHaHiX7mZGnyDfo+RmKvVj7jXJJm3hKK7/AT9HFjP87yvAtfyTdp3yl2KMj
         oDjdZCJ7arfTr62ChkyGvtN7Y7zpu6MYQxx7QD1pJR7k30RbY8l65dZoqtU2c6+Ld7Gp
         iiJ3iruRU56SOp7eX4ms7vZIfI4l66ZUAHt0vbeED9TEI9Rdn2SGfur8qewDyJoa7+Bz
         UyTOyNH2NwJcAhMC5s31WNzm258aiWv0ky8Htzszw28pjsDZ2HL1hykaaXrMIXE4G3wy
         dp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693070776; x=1693675576;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vi4iVnrBKjHWhVINZcpbWygG9zBtc24+0dihcU6QSj4=;
        b=Vemu9DdYtCiIx6aJv5fBILr+iYBk1oHnroWxKkLmhdjqFYTKgBLrWhe+fmv2lhU/d7
         Wek4oDPkNAcNuqESzLCNqXtL+XX+NYLHS7eWhNKTKaRoOQU4VmwOGTtNPsy29zMx24pV
         w2EQVRuwdyGGGxmpHgpBbbZaRURWZRq3Np3v7R5MpunLyFzwNeNWV3O3dmddTlWmYMgQ
         BbawMa+KDRKHDwDsmD36cVtXoGcZiH0+jIE7ZvxrIaemYHCejsQOBrYX/pRzSQhI3vpo
         HeRv9R3J+tFw7OJhNq43KxnYAM3JjCju+FAeB2G6zQpEVuEGsQp3stJvWiHqMdIsIk1O
         WPMQ==
X-Gm-Message-State: AOJu0YxV2BMAryVfBhBbW9NX0h3xv0+wJnrAlmhXaPnFynnkodp5gFuF
	wxjjY+0M+ecxpODHt/7+xYAZ6Y1TlFwBSPmZP1I=
X-Google-Smtp-Source: AGHT+IHHtsAiLdjtkQcS6NgLPSQoRTNlVmymRka8XhiiWk8uE6BIAO6G1+Fmd/IVzaDIhaVBk1J2wg==
X-Received: by 2002:a17:902:ecd2:b0:1bc:671d:6d31 with SMTP id a18-20020a170902ecd200b001bc671d6d31mr26645888plh.3.1693070775984;
        Sat, 26 Aug 2023 10:26:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c24c00b001befe0ac506sm3951643plg.175.2023.08.26.10.26.15
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 10:26:15 -0700 (PDT)
Message-ID: <64ea35b7.170a0220.12915.663b@mx.google.com>
Date: Sat, 26 Aug 2023 10:26:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-982-g80a0585c0aa62
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 5 runs,
 1 regressions (v5.10.186-cip37-982-g80a0585c0aa62)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 26 Aug 2023 17:26:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12853

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 5 runs, 1 regressions (=
v5.10.186-cip37-982-g80a0585c0aa62)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.186-cip37-982-g80a0585c0aa62/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.186-cip37-982-g80a0585c0aa62
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      80a0585c0aa62f4c1dd47f7b489c39ee5bba99ab

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


  Details:     https://kernelci.org/test/plan/id/64ea256fd3779bd59b286db9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/riscv/defconfig/gcc-10/lab-=
collabora/ltp-ipc-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/riscv/defconfig/gcc-10/lab-=
collabora/ltp-ipc-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/64ea256fd3779bd59b286d=
ba
        new failure (last pass: v5.10.186-cip37-770-gddd36cfc4c4c8) =

 =20

