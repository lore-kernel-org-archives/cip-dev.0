Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBD0C46CC5
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 10:52:52 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.5760.1702291972147581886
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 11 Dec 2023 02:52:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=wjP34Ch4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d0ccda19eeso25217135ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 11 Dec 2023 02:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702291971; x=1702896771; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7aB74TuwoA7GeyEAG8aeTo0XEpNjcHoXFgyY8WGyaW4=;
        b=wjP34Ch4Ym3RvN/1cz9/Lb1xlWlZM10hYo8g4VGSTAjQsh+y2Wdkg6B29j0wCdgOpB
         4s1gup6wDx3kMEc9v2IKWQvZIFsGMd0LGvDW7xWdHsBmvO1VK8reHRy2kq80348IA8HU
         eTWmGXWcGJ59zv0X7UnNoJrYFJWwfSY+irUMidOHmmhAJJNcgOSFHIybOd0SG24KeUVt
         ptXp3swiPmhtgbYU+coAfCLwvxhZw64YPAxsQgwJTjrsJnsGyBhaZZs4wd9q9FpVL+uv
         AecAVnnjVZIpE1cnIOkzPPFPCkFn/qmeqnCumyjfZFjJ4Q/cTq8VVC/Yh3mOugaNpSwz
         Sc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291971; x=1702896771;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7aB74TuwoA7GeyEAG8aeTo0XEpNjcHoXFgyY8WGyaW4=;
        b=j64GKMRqVkbk+hmon4tiNTo0lL3s1R8PQXuJsn17pl9+FenpJjW/ItImeM9G4SEJNd
         5UF/2H//wIYQIlopO6HWQnQPnbZqd3DCsCG5Zek1alG8W9L93w3XubgsFc/IfAY4Wast
         fK3NAkXN0uJC8scLuH+p1gZth1l+OY+Kk4HVpm7TKCs8rOPL3c7gVtYq9tPR3xlaUkZc
         vFTpidIS/PpWAnYg9tRay97HvoKRUofdPE3xsFq7j4jmfrtL+LNvWsw2IQAtVUFZ5E14
         LQbc/Gfj2STXwKfXHnHwS6RTqcaeredsz8HUitJi/UV/OBv5LfyegX++u587jLQd+CxF
         TZkA==
X-Gm-Message-State: AOJu0YzrnXToFJpfG5Gg/L8PwKCH1nKsMbVSEugEill7AwBcll5fo4nL
	ytabjwyf3T3G3sup/aCTuq1UjOhOmPrKus6CodMS0w==
X-Google-Smtp-Source: AGHT+IGB/cKhsonU/EVtPzrnEgeGGLM0Jdf5+xjwawDsRfO5wl/kLBayEAGvy9UaAQhp5gLdEsrSIw==
X-Received: by 2002:a17:903:11c9:b0:1d1:e0b6:1acc with SMTP id q9-20020a17090311c900b001d1e0b61accmr1845946plh.5.1702291971162;
        Mon, 11 Dec 2023 02:52:51 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902c18b00b001bc6e6069a6sm6361557pld.122.2023.12.11.02.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:52:45 -0800 (PST)
Message-ID: <6576e9fd.170a0220.dce07.10f0@mx.google.com>
Date: Mon, 11 Dec 2023 02:52:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-63-gfdfe1fbf93bc6
Subject: cip/linux-5.10.y-cip ltp-timers: 9 runs,
 2 regressions (v5.10.201-cip41-63-gfdfe1fbf93bc6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 10:52:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14017

cip/linux-5.10.y-cip ltp-timers: 9 runs, 2 regressions (v5.10.201-cip41-63-=
gfdfe1fbf93bc6)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-63-gfdfe1fbf93bc6/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-63-gfdfe1fbf93bc6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      fdfe1fbf93bc6fe6ed2708f11c2613bef556fdeb

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/6576e344bb14576e1ee1349b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-colla=
bora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-colla=
bora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6576e344bb14576e1ee=
1349c
        new failure (last pass: v5.10.201-cip41-46-g596f4c151d286) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6576d9c10b6f2905ebe1347c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1=
-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1=
-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6576d9c10b6f2905ebe=
1347d
        failing since 31 days (last pass: v5.10.194-cip39-1-g53e59f50ca3ff,=
 first fail: v5.10.200-cip40) =

 =20

