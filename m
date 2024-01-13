Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3621CC47DA2
	for <webhook@archiver.kernel.org>; Sat, 13 Jan 2024 07:27:39 +0000 (UTC)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
 by mx.groups.io with SMTP id smtpd.web10.15249.1705130852147409439
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Jan 2024 23:27:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=EZPZhm2Y;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.51, mailfrom: bot@kernelci.org)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7beda6a274bso142477839f.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 12 Jan 2024 23:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705130851; x=1705735651; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wL6htoMfVxHFrh1EeoWPUGwyt3AHaV/QZyumytJYQuM=;
        b=EZPZhm2Yvx+9zQo/nYLwq3GkCGY9SjUhorcqa3Z+8Ocx6Nw2fdfSrdyj1M3Hm4vmtZ
         ghqPU/tdzNJmDN4fNyF18q9tupup8t+gt0DgkNf5cCKEBjqPBYIbS/y6szbJdKIGpMJ5
         STGglP5SPeQ0hiaVKaprMDpOg2slqlsw9BnUD4ekJDif5ar0RlF1x/gXPqEOgZs1+Oex
         flZt7u/IM9plaPoCZo8RsWL8BPPOg/MhShKcewGuOt6qwirQpGa1GtzyoGqfTtkGElRT
         ToW21JM0RZNGEDw2ta1Y+QDZKMuNASQaZqnpi9QdGy1cjAc2efr0zTC5MwMn3hLTwHf0
         BC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705130851; x=1705735651;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wL6htoMfVxHFrh1EeoWPUGwyt3AHaV/QZyumytJYQuM=;
        b=NDlTVYGNPwcEaS4c44uON4gKj+kkdDyo2WgAFSAYyLxF/M/xHLm+U+0mhfxm1Xo4AY
         ejoMgGMiSPNe7F/+kfQT5IS0i6nf5KZQleG3WvikbOkBcp0E2KLjGvyb/cowg4TK437f
         p5XbrshQGkPLn8w5FzddZcQmloceQtm7hbDAnN7o4UY0aZqoz0etvmsVNhdy4vNqCaov
         FNFOk06VXqy6kr5fvTHrWkKox22ZEK3e+7XCf9MDy1fCf9/bNfIUO3Mdb9V5/5TgGPUJ
         xHbn5m1L8n7Mw4WY1T9Qyuw315OVsCwJA2DjGw7MywuCw72BG7xD6GOhAilpSJ+GS7e0
         XbFA==
X-Gm-Message-State: AOJu0Yw3MJtDzuh99Yj6Uk9HpOGTfhqlhvulS+upqtnDScGu/14X1KYw
	6Po1o1DWSits7lzymoTnsZgO00lALWVGO+WPSOvuaPAc0L4=
X-Google-Smtp-Source: AGHT+IFabnDsmd08xI8qexMg7gSnvqu4RrrEAMtyJjVaa7/QcEEDOifWPPHySZ4n3/Z0wBtXl1m5ow==
X-Received: by 2002:a6b:c8c2:0:b0:7bc:3b38:eadf with SMTP id y185-20020a6bc8c2000000b007bc3b38eadfmr3149611iof.19.1705130850798;
        Fri, 12 Jan 2024 23:27:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id kt4-20020a170903088400b001d39af62b1fsm4283286plb.232.2024.01.12.23.27.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 23:27:25 -0800 (PST)
Message-ID: <65a23b5d.170a0220.96b78.eca0@mx.google.com>
Date: Fri, 12 Jan 2024 23:27:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.205-905-gb40421b142370
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 18 runs,
 5 regressions (v5.10.205-905-gb40421b142370)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Jan 2024 07:27:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14368

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 18 runs, 5 regressio=
ns (v5.10.205-905-gb40421b142370)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 2          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.205-905-gb40421b142370/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.205-905-gb40421b142370
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b40421b142370404ab8c5dae183e5541de854979

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65a22fe3a786a5e9cb52a468

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/x86_64/x86_64_defconfig+x86-board=
/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/x86_64/x86_64_defconfig+x86-board=
/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65a22fe3a786a5e9cb5=
2a469
        new failure (last pass: v5.10.205-897-gcc9858ae2881) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65a22d2fdacced44d152a406

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook/=
gcc-10/lab-broonie/ltp-timers-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook/=
gcc-10/lab-broonie/ltp-timers-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65a22d2fdac=
ced44d152a40b
        failing since 6 days (last pass: v5.10.201-cip41-473-gc43d7b7bbe83a=
, first fail: v5.10.205-897-gcc9858ae2881) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65a22d2fdac=
ced44d152a40b
        failing since 6 days (last pass: v5.10.201-cip41-473-gc43d7b7bbe83a=
, first fail: v5.10.205-897-gcc9858ae2881) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65a230c1027a6d6bb052a3f6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-brooni=
e/ltp-timers-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-brooni=
e/ltp-timers-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65a230c1027a6d6bb05=
2a3f7
        new failure (last pass: v5.10.205-897-gcc9858ae2881) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65a227d63b27dd94a652a3fd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook/=
gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook/=
gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65a227d63b27dd94a65=
2a3fe
        failing since 7 days (last pass: v5.10.201-cip41-540-g3640150b3b169=
, first fail: v5.10.205-897-gcc9858ae2881) =

 =20

