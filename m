Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C672AEB64DB
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 12:57:25 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
 by mx.groups.io with SMTP id smtpd.web10.10934.1686747443341149422
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 14 Jun 2023 05:57:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=petTfhxg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.45, mailfrom: bot@kernelci.org)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6b1576c2f6eso4310214a34.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 14 Jun 2023 05:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686747442; x=1689339442;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dkDt4C3HPZ2TZW/UCNi+fhWIGszjhxjtt/PQTe4EaRM=;
        b=petTfhxgOyOmsWCb7O1Pux+6aKON7RdvergmK2mRXd0mmoQuCwX0x1YjyBFB6UpaEF
         xdWr/jIdDze+Nqd+HMTD3XzWiqWiFL8xe5iha9DjI1ZYWAPedB4gZBGe0Z/Wj+QQ9jwi
         y81yR7e2Q9xzPqYgYTWCEVRiCX/rqG127tuZGgAKROeiXxYSX35mf3/VE22LeIOB0Hmu
         P0tbHhAyvJWGy16/aJd9wa8VU50D7ZpbnecOpDz8BUM4lKyKN8cHHdMEF/s3h/kzMfCz
         dwEJXhrc7e8N9EtK/tgJYcg40TjLXbPrmYPpx1NOX0pc0pHCjViW86HoP8l6MThn5Dxw
         QU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686747442; x=1689339442;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkDt4C3HPZ2TZW/UCNi+fhWIGszjhxjtt/PQTe4EaRM=;
        b=HYLqVYLFjFngz23LaZyrzvg/BS393upRwX1o+M+zBMuuWKwxH9CKirEpZe6m4V9qsG
         qLP8ND8umlwjylinuBV5uwKTOsqVXbHxThpvTOeIXQh4I06ihWlDqepn3tJ9By++zESj
         qWIAzpEUzH9SQAB+IBOdU3C77hJvZ1QSqLse6ApdCMc7nqeJq4qDR4pSl3gArGhDe5gU
         LBtj/8lm6IeXSMgjy6IH703aXAvrljiW3V6qe/v6VR3K896Wcqs2csSIX2vkztsY7p8v
         VoV30UYKdPPAiVf3NSjtsgwZzYQdJscZygvW413ZIabwu4arREIHg7NHt5xnUEZNV0kx
         Ucvw==
X-Gm-Message-State: AC+VfDyEF7ZtX98jlufYSdy3GHSTyCbsabQdHNcLBjgnbkoKO+mghBnt
	D5jN4gX40XU2SS3CGJtPpMFo5/uh7AmO2ORc/IbxKw==
X-Google-Smtp-Source: ACHHUZ42Krpwz50wakLSKYkEfvT6uhxd8XxjtR7lA3f9gwhRnXSKMZ5fZKrKVhmHg9qkntDcwnohKA==
X-Received: by 2002:a05:6359:59d:b0:128:55b:df76 with SMTP id ee29-20020a056359059d00b00128055bdf76mr8596904rwb.8.1686747442049;
        Wed, 14 Jun 2023 05:57:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q25-20020a656859000000b0053f22b76cdcsm10278372pgt.82.2023.06.14.05.57.18
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 05:57:19 -0700 (PDT)
Message-ID: <6489b92f.650a0220.14494.449a@mx.google.com>
Date: Wed, 14 Jun 2023 05:57:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-191-gf4efde512959
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 9 runs,
 7 regressions (v5.10.182-cip35-191-gf4efde512959)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 12:57:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12021

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 9 runs, 7 regression=
s (v5.10.182-cip35-191-gf4efde512959)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

qemu_riscv64             | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 2          =

rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.182-cip35-191-gf4efde512959/plan/ltp-time=
rs/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.182-cip35-191-gf4efde512959
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f4efde5129594b413888498ce6f27da48a03771e

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  97c2fdb137a68e1eefed07c900db1a862edcdbf8 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6489a7a58cf28d2b19306242

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6489a7a58cf=
28d2b19306247
        failing since 230 days (last pass: v5.10.147-cip18-56-g87bd4289362b=
e, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6489a7a58cf=
28d2b19306247
        failing since 230 days (last pass: v5.10.147-cip18-56-g87bd4289362b=
e, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6489a95458d9e11dea30614d

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6489a95458d=
9e11dea306152
        failing since 230 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6489a95458d=
9e11dea306152
        failing since 230 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_riscv64             | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 2          =


  Details:     https://kernelci.org/test/plan/id/6489a7e506395e0138306194

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/riscv/defconfig/gcc-10/lab-c=
ollabora/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/riscv/defconfig/gcc-10/lab-c=
ollabora/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30609.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6489a7e5063=
95e0138306199
        failing since 0 day (last pass: v5.10.180-cip34-236-g6d219c607dc68,=
 first fail: v5.10.182-cip35-8-gc3d08808cfa7)

    2023-06-14T11:43:13.050783  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6489a7e5063=
95e0138306199
        failing since 0 day (last pass: v5.10.180-cip34-236-g6d219c607dc68,=
 first fail: v5.10.182-cip35-8-gc3d08808cfa7)

    2023-06-14T11:43:13.050783  =

   =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b1cc050352024c30612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6489b1cc050352024c3=
0612f
        failing since 0 day (last pass: v5.10.180-cip34-236-g6d219c607dc68,=
 first fail: v5.10.182-cip35-8-gc3d08808cfa7) =

 =20

