Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD70C54E59
	for <webhook@archiver.kernel.org>; Thu, 29 Feb 2024 09:57:02 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web11.20893.1709200619263543026
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 29 Feb 2024 01:56:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=qUg0v5Gx;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2998950e951so434434a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 29 Feb 2024 01:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709200618; x=1709805418; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7wpcY1jNNeTslpldNsW0uydwpG+TlBU/C7CGHoBA3AY=;
        b=qUg0v5Gx70Qgjaj1CpfmCEu0KZ6bZ/7nqo3CHVV9lAcUC4ynyHpm6JqF+0cO3/zoq4
         nmDawFLXmumpO2nPD921MGT9DiTuo1oSYfALse9peema2XywDrb2MOItzHxiDqGjdt2R
         gVyk0QXx2Tm7lMWQNUrNA7BK+yOd0XqVlA6welFXsFprggqDrW3kTw5/3mjIpqQ1g0JD
         AJ0xA/8XT3AcSlpzW58d9GpkhI3yhMgT8D8i7owjG/dOMgRVcbgYv5elJREdS/snXJ9s
         BlFWKCr36rK4Oe3rmr6FgLSwjlRu3yJzghLtg+OlTe3I8UoOzAfhqTAQvBNtpOTlDhQ6
         KqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709200618; x=1709805418;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wpcY1jNNeTslpldNsW0uydwpG+TlBU/C7CGHoBA3AY=;
        b=eOYO7+mkfQdIxerpx+glYNy2BqnygWfX0Per7m9Zh5XMNoNqb+yFnOHH3P20QGhJ/A
         sp+O/AhmjLtGUXT3s4l19NTfklCzFG37+b8WGy+YH2avNcra/xKVashFhFDcgFZvt9Ui
         h6x+umgUAUu8jdVnoZyHhERik5/0lc1SWx+3grWZOvabEV3Utl2MKln4Vbl7CsC7IqC0
         fffjocCTWXjYnN1j7gkEtj/xmjv6Ipc8PVTERFb+aAlvRdojqkdePSVU6b0fqGYPGcMD
         leglKWXTHHJGQkQEhVpFi3Wzr1ZDpVgv5T/Kaizsb+tHMqQA9z+SFAIs/eKxpN7WZjQ+
         3N4g==
X-Gm-Message-State: AOJu0YxL8wMsjzHUPAE+K5e/G+nrMo3pGsVl+bQfYwVWjw1wSJKrC0B6
	qJY0sTO2+LYl5CEFeOSIFM3UtdVu6Tf2DEWvzjG+8v+V5p2i6Y3WXyhrkPClv7/C5vvKH0SO0g+
	L3LY=
X-Google-Smtp-Source: AGHT+IFOleDXBfLsteMqbhcvjr6Qeoz174nzRwLYaxEM2MLm2jdc65WtUFcKNaIbjJTaBWIZUsYJuA==
X-Received: by 2002:a17:90a:1305:b0:29b:114f:36de with SMTP id h5-20020a17090a130500b0029b114f36demr646516pja.46.1709200617794;
        Thu, 29 Feb 2024 01:56:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id sd6-20020a17090b514600b002996778d8e7sm3208050pjb.26.2024.02.29.01.56.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 01:56:53 -0800 (PST)
Message-ID: <65e054e5.170a0220.914a6.e22c@mx.google.com>
Date: Thu, 29 Feb 2024 01:56:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-56-g55117716ac0fd
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 15 runs,
 4 regressions (v5.10.209-cip44-56-g55117716ac0fd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Feb 2024 09:57:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15112

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 15 runs, 4 regressio=
ns (v5.10.209-cip44-56-g55117716ac0fd)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =

qemu_riscv64                 | riscv | lab-broonie | gcc-10   | defconfig |=
 2          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-56-g55117716ac0fd/plan/ltp-time=
rs/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-56-g55117716ac0fd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      55117716ac0fd541adb5a35e66eb21c45107b040 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/65e045be7143dfe614637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-b=
roonie/ltp-timers-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-b=
roonie/ltp-timers-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-timers.login: https://kernelci.org/test/case/id/65e045be7143dfe6146=
37013
        failing since 47 days (last pass: v5.10.205-897-gcc9858ae2881, firs=
t fail: v5.10.205-905-gb40421b142370) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
qemu_riscv64                 | riscv | lab-broonie | gcc-10   | defconfig |=
 2          =


  Details:     https://kernelci.org/test/plan/id/65e03e87fde2c2d5b6637013

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/riscv/defconfig/gcc-10/lab-b=
roonie/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/riscv/defconfig/gcc-10/lab-b=
roonie/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65e03e87fde=
2c2d5b6637018
        failing since 5 days (last pass: v5.10.205-905-gb40421b142370, firs=
t fail: v5.10.209-cip44-424-g38943e302f8c8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65e03e87fde=
2c2d5b6637018
        failing since 5 days (last pass: v5.10.205-905-gb40421b142370, firs=
t fail: v5.10.209-cip44-424-g38943e302f8c8) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/65e0465c41bc38f013637034

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-timers.login: https://kernelci.org/test/case/id/65e0465c41bc38f0136=
37035
        new failure (last pass: v5.10.205-905-gb40421b142370) =

 =20

