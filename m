Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B968C83F01
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 20:38:01 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.1340.1693427880296432299
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 30 Aug 2023 13:38:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=AJ/CLKoT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-68c3b9f8333so42289b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 30 Aug 2023 13:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693427879; x=1694032679; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aJQDPVGC7fbCDeuwDfHQFRll4Lqh3xGZZmDS9rcdZnU=;
        b=AJ/CLKoTPu1Q6EAXuRitvR6fHwqa3s5Xyvnq2Jnsa+KVooCA2MfAEeblzY1oDmzCzV
         L3CGlTKoG85B2jGnALkUXb2f2jhDj4LN40h32hgSWD2zSd68/NO4laEr+4kto2aMyT72
         xXgZwoEIuzxN+TzTWJ3K9UUcneJQf9WDDxpOxa7NsoOxWIvBHtkZhTRm7zPUVDHYhBmO
         eWyqi93e28yQhlcY0bDMx3cXGSxNueTfGdhtGM9FLb9r3IWE1h+bLNy1DTtyFfxM7LJF
         q42Q8Eh/ZCrUaYu6zNVCoLMWoFs1kKHdu3LMhKwhjBctg/rw4tFBVGR78x4+SewtqqEC
         0eNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693427879; x=1694032679;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJQDPVGC7fbCDeuwDfHQFRll4Lqh3xGZZmDS9rcdZnU=;
        b=TBy3FWcCiONGgTk0AQO6LORPY2Gy75Xza8KFTAgx591St4qpdoWYX/BRGBTufwLHVH
         MQXzlDhVNFjKR7MBwmsiK7/8QeY/xAcKBhEl7qGlYaFTdLEZsHc73ji4EpJIs8+2xBPC
         mHJ4FeiP7M3E9n/wKlF11SoP1gslqcd5X52t8jHBdbX8HNzTxya19ooSY0O/ddj72ihu
         knhFoWpLYLHacPvBrv3qdjJ5Z1cH97xWAX8TjfOHqlPQcdhUp//shWyzaZz9khFO1DdA
         tWQcD4dVIXO1kzImCqCeqm2oTQ1G/RBlons7Y4G+4oqRgQBavyTna7oScLCEK/+EpL36
         /Oaw==
X-Gm-Message-State: AOJu0Yx0EVGzr1qU4vqg2zMPe8tTwy1abFBr7+pCadPWwI3n02igeZOK
	Gm+d9ColAsewHN7WNUMZ47BFNpUI2LKy3wnPw+c=
X-Google-Smtp-Source: AGHT+IHq5j5KJusfDz6BZDtyJwZJ55ozv0jJltaBbw6l1YxPSf1fsgfEX40nwgphiMWZkVvc80FAbw==
X-Received: by 2002:a05:6a00:4090:b0:68c:dcc:3580 with SMTP id bw16-20020a056a00409000b0068c0dcc3580mr1043191pfb.0.1693427879189;
        Wed, 30 Aug 2023 13:37:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c21-20020aa78c15000000b0068c023b6a80sm10829877pfd.148.2023.08.30.13.37.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 13:37:57 -0700 (PDT)
Message-ID: <64efa8a5.a70a0220.eb89f.350d@mx.google.com>
Date: Wed, 30 Aug 2023 13:37:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.191-cip38-218-g9947ff6f0dba7
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 8 runs,
 2 regressions (v5.10.191-cip38-218-g9947ff6f0dba7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Aug 2023 20:38:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12926

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 8 runs, 2 regression=
s (v5.10.191-cip38-218-g9947ff6f0dba7)

Regressions Summary
-------------------

platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.191-cip38-218-g9947ff6f0dba7/plan/ltp-tim=
ers/

  Test:     ltp-timers
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



platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64ef987bf83d831af0286d94

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64ef987bf83=
d831af0286d99
        failing since 4 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4c8=
, first fail: v5.10.186-cip37-982-g80a0585c0aa62) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64ef987bf83=
d831af0286d99
        failing since 4 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4c8=
, first fail: v5.10.186-cip37-982-g80a0585c0aa62) =

 =20

