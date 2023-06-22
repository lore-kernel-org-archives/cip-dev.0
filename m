Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69688EB64DC
	for <webhook@archiver.kernel.org>; Thu, 22 Jun 2023 11:45:16 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.9211.1687434315692833861
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 22 Jun 2023 04:45:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=bFggRi2r;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1b52bf6e659so34732045ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 22 Jun 2023 04:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687434314; x=1690026314;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oOu2xAmXoCR2fa38xG5Zc/sjBah6uTfdQJXwMsnijAo=;
        b=bFggRi2rU/toBqrOKeW1WSKSUCJ0l+fcpHYDE56HFT57+KkkjZmygELWT5wGJs8M3v
         w09Pg51Bz0bhGCaCb7TAfU8YXS35iY0ORY0oegONiGX1nDRtU1g/jwQhsWf473+LOmBo
         NH6CIR12sDiw40wnZM2agnDIZjx8EVi5+eOYsUcXBs4Kkv1TfH2pbu9lePuLP1NQuN3m
         w6PoSbThXNeRunby6ngzPWWMHhXW7xh74tslC2cauoQ/IXeIjugCV8CedJ792MhZOgiQ
         XhYucamds5WXD/ysYgF//X8T7LZ1zKjG5DS1jc/o4Zm1twdAFDHWE/E2Iy/sSw/1LAYD
         dB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687434314; x=1690026314;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oOu2xAmXoCR2fa38xG5Zc/sjBah6uTfdQJXwMsnijAo=;
        b=DOH7aXmUcuWEzxIY0S6foQNx7UlWrWxAK/fq0WIOtXjQXp1bt19b5e7jH7PQbeF0tL
         /d1phpaLGu1Wv7k8NXOUA+64qROwUZsgcbrnzo85qkr2Ihwa/HBDXo9U+dXxZexQsqvi
         2+LkGN8DmCfzoqovjqyzcIZhqeBPMWute+d4Wl7g0bI2FeWF1skZDyuTJUNrZG4jPO/+
         4zPnAzk7KXyDlk5gTA5x3rEIn/4xv9NByRGbYsFHpoFQshJN4XdftBl6Mm7Tzmr3XtfI
         CrWUwr57fyOHaEJRRZWP+EzFkJ6eIEZu07JOGw7OyDvsrGhoh/KSaxy9Jsi65VqMEKfH
         Ce7g==
X-Gm-Message-State: AC+VfDwiiez9xlSCc1N6Fs6lCrbOlyKc5beOOYuwIa0LtH3O2DZYqWOD
	gOM2S/YbVxUs8OuLCSBP8JmCowYZ7S9l9aguuN5sfw==
X-Google-Smtp-Source: ACHHUZ5IDKMrvCy1h5QFAYKDT/TFVMt2AxtDjHsv0EmS+KLbM37z9RZTFZC59+Z8wMrkDccHQcnvlg==
X-Received: by 2002:a17:902:c941:b0:1b6:7148:f65d with SMTP id i1-20020a170902c94100b001b67148f65dmr6877186pla.17.1687434314614;
        Thu, 22 Jun 2023 04:45:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d90200b001b0499bee05sm5175555plz.191.2023.06.22.04.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 04:45:13 -0700 (PDT)
Message-ID: <64943449.170a0220.1fb24.b914@mx.google.com>
Date: Thu, 22 Jun 2023 04:45:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.184-cip36-rt14
Subject: cip/linux-5.10.y-cip-rt ltp-timers: 11 runs,
 10 regressions (v5.10.184-cip36-rt14)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jun 2023 11:45:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12125

cip/linux-5.10.y-cip-rt ltp-timers: 11 runs, 10 regressions (v5.10.184-cip3=
6-rt14)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =

qemu_riscv64              | riscv  | lab-collabora | gcc-10   | defconfig  =
                  | 2          =

qemu_smp8_riscv64         | riscv  | lab-collabora | gcc-10   | defconfig+p=
reempt_rt         | 1          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+p=
reempt_rt         | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.184-cip36-rt14/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.184-cip36-rt14
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1b650b4c826dc15118c34e6c891e42858f3367e0

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  97c2fdb137a68e1eefed07c900db1a862edcdbf8 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/649428a43aa2dc0b1c306148

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/649428a43aa2dc0b1c3=
06149
        new failure (last pass: v5.10.179-cip32-rt13) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =


  Details:     https://kernelci.org/test/plan/id/649428c626ea981c72306192

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-tim=
ers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-tim=
ers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/649428c626e=
a981c72306197
        failing since 224 days (last pass: v5.10.145-cip17-rt7, first fail:=
 v5.10.153-cip19-rt8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/649428c626e=
a981c72306197
        failing since 224 days (last pass: v5.10.145-cip17-rt7, first fail:=
 v5.10.153-cip19-rt8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =


  Details:     https://kernelci.org/test/plan/id/64942804319f2cd64230612e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64942804319=
f2cd642306133
        failing since 224 days (last pass: v5.10.145-cip17-rt7, first fail:=
 v5.10.153-cip19-rt8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64942804319=
f2cd642306133
        failing since 224 days (last pass: v5.10.145-cip17-rt7, first fail:=
 v5.10.153-cip19-rt8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
qemu_riscv64              | riscv  | lab-collabora | gcc-10   | defconfig  =
                  | 2          =


  Details:     https://kernelci.org/test/plan/id/64942260f8614ae12f30613f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu_riscv64=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu_riscv64=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30609.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64942260f86=
14ae12f306144
        new failure (last pass: v5.10.179-cip32-rt13) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64942260f86=
14ae12f306144
        new failure (last pass: v5.10.179-cip32-rt13) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
qemu_smp8_riscv64         | riscv  | lab-collabora | gcc-10   | defconfig+p=
reempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/649426149adc68fc8730612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/riscv/defconfig+preempt_rt/gcc-10/lab-collabora/ltp-timers-q=
emu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/riscv/defconfig+preempt_rt/gcc-10/lab-collabora/ltp-timers-q=
emu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30609.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/649426149adc68fc873=
0612f
        failing since 34 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v5.10.179-cip32-rt13) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+p=
reempt_rt         | 2          =


  Details:     https://kernelci.org/test/plan/id/64942659eb67ac121f306135

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm64/defconfig+preempt_rt/gcc-10/lab-cip/ltp-timers-r8a774a=
1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm64/defconfig+preempt_rt/gcc-10/lab-cip/ltp-timers-r8a774a=
1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64942659eb6=
7ac121f306140
        failing since 34 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v5.10.179-cip32-rt13) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64942659eb6=
7ac121f306140
        failing since 34 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v5.10.179-cip32-rt13) =

 =20

