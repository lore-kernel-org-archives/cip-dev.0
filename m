Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F393C4167B
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 13:50:48 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
 by mx.groups.io with SMTP id smtpd.web10.22502.1702561841450091638
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Dec 2023 05:50:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=UBbMGYJd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.43, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-59148c1ad35so1597340eaf.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 14 Dec 2023 05:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702561840; x=1703166640; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HKlBdZM+5i685m+jLlHCPLg6vZsTLbqXs1sK7nHUA8U=;
        b=UBbMGYJdgBkc4C/GYp2nCgOo5xShRnXTckNO+sK1u0dXdQKlViG0QYHjo71QzQ8rnE
         dAUwmgjOWoiBX1n4HF4Xw3XIoN8HvbApfBA/wt4BBPj8feA65EizwGHXeqqQk1DBffDv
         Vz+FrxKkuPXRcjLWudubTJcw81P6esMgGDAS0e5qXcAt0sWnZ5En3HuoXec2DBQlGAjC
         XvN03NVeTj4++/81s312VXa7NcjqI1/8jWv9gCgCvyEF/3wpwfyZrUTecQqR5nb7d2M5
         MnnwYTPcnQe/g+PkZDeCx2UOW0sIEGtQvFHvtAwc0Q7GNf29BvjarFay87JyFwI6t3yv
         Z/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561840; x=1703166640;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HKlBdZM+5i685m+jLlHCPLg6vZsTLbqXs1sK7nHUA8U=;
        b=loIsQ+O6kDxveUVjITi1+2JLu0WnMuGAT6LlezDdE3JhDa9TwPSPTgo6opXycCsIti
         6UXWXg4oIRZjaeUKSsRtT5AXV+QsEi4Qa/30wYG+pTeHNVNM+CPh3X4DK/hNpMV6fTCc
         lvIYUAgRFNOhdmQ0zE504qXQ7zQONv4VnpgxjCiMkZT5QF+Qn8AtRn/BZQYpGgk/T7vY
         GM9O9INvG5o94eGMOjudz3ZCCGIeMKojMkjaLL9vbB08t0ypDHWU/WdHt/CYBI3fgXVR
         oq5mtTWdXvY+q61sXsvYU5U3hRevagIWSOU0SaSMlc/JBvmpA7VD0NBCdGbpZypGXXyF
         wSzA==
X-Gm-Message-State: AOJu0YxGO10xsHZxFrw9zWbuF90+u5zZH/jf6bFsQ7NVMR21cY7F2TiB
	tzInDjeta+xfAIQIJHStktQuKM/jcUp/rVYjN98pNg==
X-Google-Smtp-Source: AGHT+IGPE9qu5G2T31HzWVdTlYmU9SLurOCgxBQXoe3g2EPSVHrhwzxP4bfR+lH0vGiLQg8F9uAGaQ==
X-Received: by 2002:a05:6358:f54:b0:170:17eb:9c56 with SMTP id c20-20020a0563580f5400b0017017eb9c56mr10979686rwj.55.1702561840140;
        Thu, 14 Dec 2023 05:50:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x17-20020a62fb11000000b006d26f1d1cedsm89098pfm.118.2023.12.14.05.50.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:50:38 -0800 (PST)
Message-ID: <657b082e.620a0220.97864.07d7@mx.google.com>
Date: Thu, 14 Dec 2023 05:50:38 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-69-g8f7b450fc28ed
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 11 runs,
 4 regressions (v5.10.201-cip41-69-g8f7b450fc28ed)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 13:50:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14107

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 11 runs, 4 regressio=
ns (v5.10.201-cip41-69-g8f7b450fc28ed)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

qemu_riscv64              | riscv  | lab-broonie   | gcc-10   | defconfig  =
                | 2          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-69-g8f7b450fc28ed/plan/ltp-time=
rs/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-69-g8f7b450fc28ed
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      8f7b450fc28ed99196853536c98ae36c2567e160

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


  Details:     https://kernelci.org/test/plan/id/657b074c67d7c789c3e13479

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/x86_64/x86_64_defconfig+x86-=
board/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/x86_64/x86_64_defconfig+x86-=
board/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/657b074c67d7c789c3e=
1347a
        new failure (last pass: v5.10.201-cip41-473-gc43d7b7bbe83a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
qemu_riscv64              | riscv  | lab-broonie   | gcc-10   | defconfig  =
                | 2          =


  Details:     https://kernelci.org/test/plan/id/657af99c832f453c31e13489

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/riscv/defconfig/gcc-10/lab-b=
roonie/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/riscv/defconfig/gcc-10/lab-b=
roonie/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/657af99c832=
f453c31e1348e
        failing since 109 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4=
c8, first fail: v5.10.186-cip37-982-g80a0585c0aa62) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/657af99c832=
f453c31e1348e
        failing since 109 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4=
c8, first fail: v5.10.186-cip37-982-g80a0585c0aa62) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/657afc7bdd5c4d4fd2e134b1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-c=
ip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-c=
ip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/657afc7bdd5c4d4fd2e=
134b2
        failing since 41 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

