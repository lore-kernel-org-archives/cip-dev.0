Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C967CC54E5A
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 21:13:36 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web11.35758.1709327616192416187
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 13:13:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=yUCDsAr1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.177, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so2157637a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 13:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709327615; x=1709932415; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T1ABOyzfBtehw6oddI58/dgCmgAOHoynNYPemPDUR7s=;
        b=yUCDsAr19kRYdUVJGWHW68OoCivkNuN4fyBBNedV7wfP7zbz5dKDv6+zzRV4sHu305
         L7j9CPKeKtePWN9MriJNwjhDi4arj/pWzlUMH1abqWHQEIT+aeWP9zeYKts/r9SG7cyo
         lRH4A1+a/kJSMIIq62zkM76HfzmcPYl8dQIS3awUJDVkS0VR47LEcevjs8ahUETOcC9M
         bWQV5axX+ntRWsHI3e+jNXp65sYOSMvfdY/BKl2rhPu3movMYRs4Rk/4c7CkV8u0IpDM
         hli016t7oLJhtvr275PdO1J/C6qqvkZgO52Rak1AzdP514T31kae1tR5cyJfgY+Zq5JL
         mZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709327615; x=1709932415;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T1ABOyzfBtehw6oddI58/dgCmgAOHoynNYPemPDUR7s=;
        b=L5RfhRA6U4fttjdFjWgDNRM4I/AK5DkYKnoeHlShnqao8X+gGKuJVyqMEcAKepvLZj
         4smADnGjWFFRw/Ci4dtf/dsA4L2yb6MCScmz6IqysGjpQEaQM5oM5FERPFGU4BsgHZFV
         mnSTVqFPTkvVwGx+M0voxclP78AfDX6suL9RDUt3pyOJY0TXKj7xmh9oVzQ+HiENiWS0
         zn7UhWotdPXQEldLFKLcvzrrMN1p3Rr/IUgR8PuAZ126Vv2nD9G4H43L+RQoO/EAfFPA
         jMBsnN06mPsVn43UsuHRki8kcjAsC6ak8JBNvNUzQTKKyxIHl0PjXGFWFFGgvdw+12Lj
         9bjg==
X-Gm-Message-State: AOJu0YzmXD1CzXTM7x8PR0rHWLVWXPcNGWGQtr1wHDsJeHViEz+bz6cR
	EF8U+Nqq3UiPVXA4xv3MwFWpZ9CklrZhn5szsAqyvrbyh1QNuj9YMFIzGsmotUt406FM4UfODSk
	h474=
X-Google-Smtp-Source: AGHT+IGqWwBjHYpH1v8EPUTefU7UhQZZZr0B7KLJZ60w/6GmsUWIuuXz3+dnvsGHFOnHg+a18c8knA==
X-Received: by 2002:a17:90a:68c5:b0:29a:a31d:695a with SMTP id q5-20020a17090a68c500b0029aa31d695amr3906969pjj.1.1709327615169;
        Fri, 01 Mar 2024 13:13:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090aa00e00b0029b32b85d3dsm159396pjp.29.2024.03.01.13.13.30
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 13:13:33 -0800 (PST)
Message-ID: <65e244fd.170a0220.77272.19b1@mx.google.com>
Date: Fri, 01 Mar 2024 13:13:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-552-gc0460fb20fc00
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 16 runs,
 5 regressions (v5.10.209-cip44-552-gc0460fb20fc00)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 21:13:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15147

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 16 runs, 5 regressio=
ns (v5.10.209-cip44-552-gc0460fb20fc00)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_riscv64                 | riscv | lab-broonie | gcc-10   | defconfig  =
                | 2          =

qemu_smp8_riscv64            | riscv | lab-broonie | gcc-10   | defconfig  =
                | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-552-gc0460fb20fc00/plan/ltp-tim=
ers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-552-gc0460fb20fc00
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c0460fb20fc000a52548daa693788068d4fc9a8e =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65e2391c9549626624637016

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/ltp-timers-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/ltp-timers-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-timers.login: https://kernelci.org/test/case/id/65e2391c95496266246=
37017
        new failure (last pass: v5.10.209-cip44-424-g38943e302f8c8) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
qemu_riscv64                 | riscv | lab-broonie | gcc-10   | defconfig  =
                | 2          =


  Details:     https://kernelci.org/test/plan/id/65e23d91b54ca46592637012

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65e23d91b54=
ca46592637017
        failing since 7 days (last pass: v5.10.205-905-gb40421b142370, firs=
t fail: v5.10.209-cip44-424-g38943e302f8c8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65e23d91b54=
ca46592637017
        failing since 7 days (last pass: v5.10.205-905-gb40421b142370, firs=
t fail: v5.10.209-cip44-424-g38943e302f8c8) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
qemu_smp8_riscv64            | riscv | lab-broonie | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65e24174f9fcf1916a637070

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



  * ltp-timers.login: https://kernelci.org/test/case/id/65e24174f9fcf1916a6=
37071
        new failure (last pass: v5.10.209-cip44-56-g55117716ac0fd) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65e2385d417759433a63701a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-timers.login: https://kernelci.org/test/case/id/65e2385d417759433a6=
3701b
        failing since 56 days (last pass: v5.10.201-cip41-540-g3640150b3b16=
9, first fail: v5.10.205-897-gcc9858ae2881) =

 =20

