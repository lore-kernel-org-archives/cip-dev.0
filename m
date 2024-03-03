Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9516AC54E41
	for <webhook@archiver.kernel.org>; Sun,  3 Mar 2024 12:33:02 +0000 (UTC)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
 by mx.groups.io with SMTP id smtpd.web10.72057.1709469180876423195
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 03 Mar 2024 04:33:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=AuIxb6RT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.180, mailfrom: bot@kernelci.org)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3650c7e0dd2so13564025ab.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 03 Mar 2024 04:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709469179; x=1710073979; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vK9e689NVb63TLtvPmOltfyB5SCr/Fw8t7SiC1RmDHg=;
        b=AuIxb6RTkgfqKZhCsTuxnPr0HosA2nNBhd8lJAn0NrzpgtNXMHvwzbGdfURyV4Hk0M
         viECxA0/8v3qEONEbiKSVw6f2+jUD06I/VjYa0IqPX5Eni7sqEa9t6BlbjWrluqFMLjb
         KECX4rkkzVK+LR4NiBUbx/8PYlAg0aX9z3EEsEHvBxE4U+89qTMZMUsddEood1hDNCpc
         UUGNgMNdftESgPEG5aWF1JV4hqIPo0uvlDxl92lYA3ANnzDf+cQIJZAZfdsruGmayVJv
         nn+kbxK6sDlW+T/+zzCSY8qITUNOzsf3xMgkyBjiNIwT05+R+Y8lzo+hURO/jqlB6V7f
         zmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709469179; x=1710073979;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vK9e689NVb63TLtvPmOltfyB5SCr/Fw8t7SiC1RmDHg=;
        b=Wd7TmE87OvMV8Yq7TItWNdFmfhMIpyp8WA4ipNB3Jl9sduC6JdM+XuRXy/pc31hEOz
         jD/C9OfKF8HjyfINy8FifhQAQdEnnnZX8lRWhNLkIIcYGDj1p2qqukEKuHr7xp4A+2w/
         js5fxeaNq3wjiQE5pcQoGHN9DV7Nnh9B9lQ/vppRxwgiRak10iVRtIfKpOn1EOgj16b8
         ldmSmW3p3/lxlO34xow6DL6iq1OgKzHia5ptV0B9jyZhy2iWqPg1juOO9KFhWuJOH2zP
         y2D30WfBUTGIsAKG3ZVy3tE0EGAD4qaQBF7FQvfe6AlOdXkJiN/KUyx+D9yfKchP3Gzz
         NRSQ==
X-Gm-Message-State: AOJu0Yy9xOMZob6gag6ErTs2FarVtchHZ/MYXP+a357TX1tBG8x/owsH
	Rg5pEHC9+QjALHNGmZbUHdDdp85tAeakjkXZR0tXIGEbpC4GOLSMU/X7KgMUib+Q/WLZOMRvKo+
	Iy/o=
X-Google-Smtp-Source: AGHT+IFuYP9myd5oILbVvRNmWoXXmZjdV/Nxb8FFBdu5LQxf01ATZhycH0070hPyI9a7nnrXtqUuYg==
X-Received: by 2002:a05:6e02:1c82:b0:365:b614:5cb7 with SMTP id w2-20020a056e021c8200b00365b6145cb7mr9610002ill.16.1709469179461;
        Sun, 03 Mar 2024 04:32:59 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p1-20020a62ab01000000b006e55a21ac02sm5596787pff.152.2024.03.03.04.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 04:32:59 -0800 (PST)
Message-ID: <65e46dfb.620a0220.151e.6b58@mx.google.com>
Date: Sun, 03 Mar 2024 04:32:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Kernel: v6.1.80-cip16
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip ltp-timers: 18 runs, 6 regressions (v6.1.80-cip16)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 03 Mar 2024 12:33:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15177

cip/linux-6.1.y-cip ltp-timers: 18 runs, 6 regressions (v6.1.80-cip16)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 2          =

qemu_riscv64                 | riscv | lab-broonie | gcc-10   | defconfig  =
                | 2          =

qemu_smp8_riscv64            | riscv | lab-broonie | gcc-10   | defconfig  =
                | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.80-cip16/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.80-cip16
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c4a8a3898cc297c755b7d041d731243bf2338f24 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65e4625bc9d7af2b44637055

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.80-ci=
p16/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/ltp-timers-meson-gx=
l-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.80-ci=
p16/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/ltp-timers-meson-gx=
l-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65e4625bc9d=
7af2b4463705a
        failing since 30 days (last pass: v6.1.72-cip13-30-g79e2886a5da69, =
first fail: v6.1.72-cip13-31-g9539320ac89dc) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65e4625bc9d=
7af2b4463705a
        failing since 30 days (last pass: v6.1.72-cip13-30-g79e2886a5da69, =
first fail: v6.1.72-cip13-31-g9539320ac89dc) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
qemu_riscv64                 | riscv | lab-broonie | gcc-10   | defconfig  =
                | 2          =


  Details:     https://kernelci.org/test/plan/id/65e45a5a3608bee90d637186

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.80-ci=
p16/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.80-ci=
p16/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65e45a5a360=
8bee90d63718b
        failing since 6 days (last pass: v6.1.75-cip14-6-geddeb7f8123c, fir=
st fail: v6.1.78-cip15) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65e45a5a360=
8bee90d63718b
        failing since 6 days (last pass: v6.1.75-cip14-6-geddeb7f8123c, fir=
st fail: v6.1.78-cip15) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
qemu_smp8_riscv64            | riscv | lab-broonie | gcc-10   | defconfig  =
                | 2          =


  Details:     https://kernelci.org/test/plan/id/65e45aaaee2b12d123637018

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.80-ci=
p16/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.80-ci=
p16/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65e45aaaee2=
b12d12363701d
        failing since 69 days (last pass: v6.1.66-cip11-1-g2d3d776d703d7, f=
irst fail: v6.1.67-cip12) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65e45aaaee2=
b12d12363701d
        failing since 69 days (last pass: v6.1.66-cip11-1-g2d3d776d703d7, f=
irst fail: v6.1.67-cip12) =

 =20

