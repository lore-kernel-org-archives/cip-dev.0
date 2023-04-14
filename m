Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CC6C77B77
	for <webhook@archiver.kernel.org>; Fri, 14 Apr 2023 11:23:10 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.6714.1681471387884457691
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 14 Apr 2023 04:23:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=nVL4AgIa;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id o2so17974464plg.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 14 Apr 2023 04:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681471387; x=1684063387;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IRE9vtoC0CUAOpGdNIKFtS8/me5pr5IlYBSC1RPKk0s=;
        b=nVL4AgIa3/lUz2yu3dwE03C42upsW13x3vg2keCwqaeYu1B8fZLphcteYugHJj0awy
         Z52rxkXmnsW/AWrnEAeBAvZGin2cEKpJO19EtI2ufHn4JJ1MDkfIcj678I0qbDGF5dcB
         O/57T0TVvjR+8mUTUN6DOmZUP9+sgQTeDnxVuVlJdyqnFJqHgUi1yP1QyWrUMgb5m597
         HS87DZVcjyTCqWQZ/NZ+jtIDhI2VUUGUOOVC9Liuj0a/MaGFOmUADcaDgPtdOAHyft5O
         TTalnO+9PPZ++JtWlSPkM12UvNeGqN0lvuIq6IhHE1ZDn68FAbV06josCVkOwuOP5Bds
         4Z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681471387; x=1684063387;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IRE9vtoC0CUAOpGdNIKFtS8/me5pr5IlYBSC1RPKk0s=;
        b=h8QgjiZSHKiuNNmYQgcSUoN9Wv+u6zIFq5HKsxnipeISEBpyHNOgekjFQhY6xinBu0
         miYcAH01FzkuDmP7ik4VDTqibATSZsDOET1nNv+6kXUIOT7nOeFPDvckrKME6f5AFeif
         Ta2Ih7Dka3kB9+y588ccrrQ8w8upxI/kFDGeESAwAGRj3qMe0H+Zl1M/57YggaLrct+C
         tJkG4+vMf/dFfjVkiC3VrShkM32sEZBzx/thfxHn04r9uxzAsKw5dwd4Wm7lFTfeFmvI
         XO3xqmmwPNOovOJkSSAPIEYKuXLVF0oRASaaj1u2NkevNcgtvLk2nuRP0EB/5IysxId7
         RoGg==
X-Gm-Message-State: AAQBX9dM5/A5IRyLHsene3chQsQLkxSWx5EatFkOvV3fbBS3RkTIkVIM
	GXN3DihswLcHt7YsGMq8VJj0x1PX1xFT2O0A9IuEu6GD
X-Google-Smtp-Source: AKy350bK586qSiUPCZ5j3bp8EtQDWw5z4IF0Vkl5opc4Fltvtr2k124+UXWgzfyMOZXcI9ac33PUpg==
X-Received: by 2002:a17:90a:f3cc:b0:23d:1b50:1ebe with SMTP id ha12-20020a17090af3cc00b0023d1b501ebemr5341690pjb.27.1681471387041;
        Fri, 14 Apr 2023 04:23:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y13-20020a170902ed4d00b0019cb6222691sm2884887plb.133.2023.04.14.04.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:23:06 -0700 (PDT)
Message-ID: <6439379a.170a0220.94afd.6c2f@mx.google.com>
Date: Fri, 14 Apr 2023 04:23:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.177-cip31
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-timers: 12 runs,
 7 regressions (v5.10.177-cip31)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Apr 2023 11:23:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11216

cip/linux-5.10.y-cip ltp-timers: 12 runs, 7 regressions (v5.10.177-cip31)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

qemu_smp8_riscv64        | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =

rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.177-cip31/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.177-cip31
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      deb75c99ed78d677587a345854b8a00fb2cac68c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  cb9b37a6a47ea5f9e442b4473c6eb06877bd18ac =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/643928fed1007dae462e861f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230407.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/643928fed10=
07dae462e8624
        failing since 62 days (last pass: v5.10.165-cip25, first fail: v5.1=
0.167-cip26) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/643928fed10=
07dae462e8624
        failing since 62 days (last pass: v5.10.165-cip25, first fail: v5.1=
0.167-cip26) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64392bba3c3c62fce02e86af

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230407.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64392bba3c3=
c62fce02e86b4
        failing since 161 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64392bba3c3=
c62fce02e86b4
        failing since 161 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_smp8_riscv64        | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/6439256a18cea9a28e2e8609

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu_smp8_riscv64.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30407.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6439256a18cea9a28e2=
e860a
        new failure (last pass: v5.10.176-cip30) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6439329a4ae0a528142e85e6

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230407.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6439329a4ae=
0a528142e85eb
        failing since 161 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6439329a4ae=
0a528142e85eb
        failing since 161 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =

 =20

