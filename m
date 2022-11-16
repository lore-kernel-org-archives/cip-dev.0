Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A379C4332F
	for <webhook@archiver.kernel.org>; Wed, 16 Nov 2022 02:29:01 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web08.2155.1668565740261226595
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 15 Nov 2022 18:29:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=WI+BUEYM;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.182, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f182.google.com with SMTP id b62so15405341pgc.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 15 Nov 2022 18:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6JGQcj8KEoQv7dKmnXtFLLKXBeQgbn7zK1zkYK4u9cQ=;
        b=WI+BUEYM9me+tVOll/MFTv0dIspZSqoPBiC439cakTP0rGWP4xh68ttvbYpZgwcIJ/
         RmEnn5Gq+SdzU8NrKrsshcOvY2iKLA12LcE08Bs3WH5ybGtz7Ue30ybnhcNqe0RZpjkL
         9Jyg1MV5ott2beZY87HK12Md2OltVlKXEBj4q2KV+80zBKDElx0VJu9n1DUr0if3/aDI
         ZXCgvLQ7RAwnEOfsLfAU2xsYyXNZr1kXqqmdgmVN2V5jzDa5BoMwB8U+4nIns6J4I3ED
         3lH6rDLFKzGpr6dryPGxTRRdOId3FEcNsm620bQC93yERAFJq+Eqj4hxYel4dwhKXuNR
         mIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JGQcj8KEoQv7dKmnXtFLLKXBeQgbn7zK1zkYK4u9cQ=;
        b=MhAItphjva1IGtxKMhYnQHqw5dEXqHYpYpqwipi5GLHkbqqf6gk5Ze7sIuN4VaJnqM
         C8cU5E1VWosh6Speg4NhBlyFLjxaZHj4ZrnY95rW5k3dsRrHDVGtzNxB916WSlttembo
         NRZomvfVtZqOTywNCMYcZrQmmDKGrMeX3soxuQPYB8qOX636vQSTWwskv1xmFPVJ8tAV
         Vw/19Ta4EIhlLLhjp7LZbvA3LcYv3wi8+lgXI2DOElWdeY4dWqirM/JY2WN/h3x9zGlO
         8ZQx8pBCQWAcfSxvVYdGtUw0yi2snZwln5c4m6cd1VPekU/daDVUR3Lrv8wcOvlVSSFd
         kDRA==
X-Gm-Message-State: ANoB5pnKd0vX6FhFehsWnDtDxIGQVOU+S3Zm09i+rKuhoEsXYCnhM6U3
	B0AVOOshZMPCsY0l9G2id+qCpR9BY2mmecOWmRw=
X-Google-Smtp-Source: AA0mqf4xpZ2NsstsbeLfJVmU6dklh3dDex4yVktCkFDS1S3V0KXGb9/tJvb/ryU/8egoYZWuuUJLAQ==
X-Received: by 2002:a63:ed18:0:b0:45c:eb5a:3361 with SMTP id d24-20020a63ed18000000b0045ceb5a3361mr18028690pgi.346.1668565739470;
        Tue, 15 Nov 2022 18:28:59 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 79-20020a621552000000b0056c704abca7sm9509738pfv.220.2022.11.15.18.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 18:28:59 -0800 (PST)
Message-ID: <63744aeb.620a0220.1a81b.fe0e@mx.google.com>
Date: Tue, 15 Nov 2022 18:28:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Kernel: v4.19.265-cip85-rt27
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip-rt baseline: 133 runs,
 5 regressions (v4.19.265-cip85-rt27)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Nov 2022 02:29:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10036

cip/linux-4.19.y-cip-rt baseline: 133 runs, 5 regressions (v4.19.265-cip85-=
rt27)

Regressions Summary
-------------------

platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
hp-x360-14-G1-sona         | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...k+preempt_rt | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.265-cip85-rt27/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.265-cip85-rt27
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7b2b3defe99e6a33cd295c5120b96288f81f8bd7 =



Test Regressions
---------------- =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
hp-x360-14-G1-sona         | x86_64 | lab-collabora | gcc-10   | x86_64_def=
con...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/637444db5ded5060882abd02

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
265-cip85-rt27/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
265-cip85-rt27/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/637444db5ded5060882ab=
d03
        new failure (last pass: v4.19.245-cip74-rt25) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/63744308e034d4ceb82abcff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
265-cip85-rt27/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt=
-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
265-cip85-rt27/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt=
-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63744308e034d4ceb82ab=
d00
        failing since 169 days (last pass: vv4.19.233-cip69-rt24, first fai=
l: v4.19.245-cip74-rt25) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/6374431b34d1b647372abd09

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
265-cip85-rt27/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt=
-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
265-cip85-rt27/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt=
-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6374431b34d1b647372ab=
d0a
        failing since 169 days (last pass: vv4.19.233-cip69-rt24, first fai=
l: v4.19.245-cip74-rt25) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/6374431d34d1b647372abd0f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
265-cip85-rt27/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt=
-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
265-cip85-rt27/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt=
-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6374431d34d1b647372ab=
d10
        failing since 169 days (last pass: vv4.19.233-cip69-rt24, first fai=
l: v4.19.245-cip74-rt25) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-baylibre  | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/6374431c81cb57f68c2abd17

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
265-cip85-rt27/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt=
-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
265-cip85-rt27/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt=
-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6374431c81cb57f68c2ab=
d18
        failing since 169 days (last pass: vv4.19.233-cip69-rt24, first fai=
l: v4.19.245-cip74-rt25) =

 =20

