Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F37C74A5B
	for <webhook@archiver.kernel.org>; Sun, 12 Mar 2023 09:08:32 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.63237.1678612105443894339
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 12 Mar 2023 01:08:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=AoYTaz9g;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id h8so9902327plf.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 12 Mar 2023 01:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678612104;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HeqcLS5tuloYQ7IMPs71O3fXsrIXi5yGuK39vTEFmls=;
        b=AoYTaz9go7CP9x9/XAinrhbVP+Nk0+ufqL/Wxm7SrslDKxy27ZDQPTlyh0CChB0AKn
         frStuRmbM5TTEz9NdtWEqEahKXNdzLPRmb7EsDoNHm+R4RHDVNAsx2X238HaINOEfVu1
         +i7PgkICFF/65ygN/hYXGIjFVv5IKaaZ60OFkI110KvaKjs8VWtxaTvJMdWCxQ/QTEmA
         wl0CDvThU/PX+xI8hmc4Kzo/ri1hIACE7KiS1kIuVFZ3C+/DKUViRqKEHht52RcdJrG7
         gcMeYhy4UC6Td0FlkPaJ0izLv4YYzITmHXUXvdF1+bj7R3KzpurIE7hulLEpIOA9Fwfz
         9VCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678612104;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HeqcLS5tuloYQ7IMPs71O3fXsrIXi5yGuK39vTEFmls=;
        b=ql9soKKZutNu23lx3Q1lWrDqnHxUWnDoDBmfzuEEzDnwQQYXnlkj9UiwwxlDfsQPMR
         m8ZVJiBujpxamQJWVDQGzw5o3hdqhn+94SVn6qgDiWv+xi3uAFg5uvXFm9c1ZDVicPrU
         xtZch9nBXcAbFtQf1gARyWuSa5DjwMfMlfGVrU1SQb+nibzZFX8y2Vx/MpKEP2lkYlKn
         jyK/FYfHpZupaCuCOOkEbOIatMc7tW0fyAuC84YzDjyNsMsuYp7aC7LkHXgTvoJwaKbD
         1Zi6ExnNwTj0xK4/k94GlvoVID4yWXstp4t4wrBtyGfO01qrj0b+R7pZwPlYr2jprtoN
         Np5A==
X-Gm-Message-State: AO0yUKXeroy8XpedqYGsAEW/Yx+Riz3ueWgTuAaLVLYsuQu9P3Alc6tO
	td3lSs0NRzgpp8EwWxm/18SKLQyrh3rPqnf/WLA=
X-Google-Smtp-Source: AK7set+KY4O2jKIEeTmed9XfqieYwIfqe3Arbwaof9DxklnaVwbnbZ5J83q2qII5aZ4fU3igCryY5g==
X-Received: by 2002:a17:90b:4acb:b0:237:44c3:df0b with SMTP id mh11-20020a17090b4acb00b0023744c3df0bmr33136202pjb.32.1678612104487;
        Sun, 12 Mar 2023 01:08:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l129-20020a632587000000b004fb171df68fsm2595674pgl.7.2023.03.12.01.08.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 01:08:24 -0800 (PST)
Message-ID: <640d9688.630a0220.cbcdf.4472@mx.google.com>
Date: Sun, 12 Mar 2023 01:08:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.168-cip27-638-g0d599cd2b6695
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 16 runs,
 14 regressions (v5.10.168-cip27-638-g0d599cd2b6695)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 12 Mar 2023 09:08:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10990

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 16 runs, 14 regressi=
ons (v5.10.168-cip27-638-g0d599cd2b6695)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

qemu_riscv64              | riscv  | lab-broonie   | gcc-10   | defconfig  =
                  | 2          =

qemu_riscv64              | riscv  | lab-collabora | gcc-10   | defconfig  =
                  | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.168-cip27-638-g0d599cd2b6695/plan/ltp-tim=
ers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.168-cip27-638-g0d599cd2b6695
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0d599cd2b6695e03b8e4b1bdf0c2663d16568070

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3cbaaddf6f785d91aeb370beb75d0623f8c48624 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/640d887a7c72c705ad8c8630

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230303.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640d887a7c7=
2c705ad8c8635
        failing since 136 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640d887a7c7=
2c705ad8c8635
        failing since 136 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/640d886a570fa13fd18c8642

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230303.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640d886a570=
fa13fd18c8647
        failing since 136 days (last pass: v5.10.147-cip18-56-g87bd4289362b=
e, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640d886a570=
fa13fd18c8647
        failing since 136 days (last pass: v5.10.147-cip18-56-g87bd4289362b=
e, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/640d8a2712d515ae0d8c863d

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230303.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640d8a2712d=
515ae0d8c8642
        failing since 136 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640d8a2712d=
515ae0d8c8642
        failing since 136 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/640d8bb8e6d1b97f818c863e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230303.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640d8bb8e6d=
1b97f818c8643
        failing since 18 days (last pass: v5.10.165-cip25-154-gb7e05ba4f61a=
2, first fail: v5.10.167-cip26-2-g1e87e7748b91) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640d8bb8e6d=
1b97f818c8643
        failing since 18 days (last pass: v5.10.165-cip25-154-gb7e05ba4f61a=
2, first fail: v5.10.167-cip26-2-g1e87e7748b91) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
qemu_riscv64              | riscv  | lab-broonie   | gcc-10   | defconfig  =
                  | 2          =


  Details:     https://kernelci.org/test/plan/id/640d8c41ca32afab3f8c8632

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30303.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640d8c41ca3=
2afab3f8c8637
        failing since 8 days (last pass: v5.10.167-cip26-192-ga2cd4acb16b2,=
 first fail: v5.10.168-cip27-109-g23841ec76bec) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640d8c41ca3=
2afab3f8c8637
        failing since 8 days (last pass: v5.10.167-cip26-192-ga2cd4acb16b2,=
 first fail: v5.10.168-cip27-109-g23841ec76bec) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
qemu_riscv64              | riscv  | lab-collabora | gcc-10   | defconfig  =
                  | 2          =


  Details:     https://kernelci.org/test/plan/id/640d8bb9717043a82a8c8633

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/riscv/defconfig/gcc-10/lab-=
collabora/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/riscv/defconfig/gcc-10/lab-=
collabora/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30303.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640d8bb9717=
043a82a8c8638
        failing since 8 days (last pass: v5.10.167-cip26-192-ga2cd4acb16b2,=
 first fail: v5.10.168-cip27-109-g23841ec76bec) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640d8bb9717=
043a82a8c8638
        failing since 8 days (last pass: v5.10.167-cip26-192-ga2cd4acb16b2,=
 first fail: v5.10.168-cip27-109-g23841ec76bec) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/640d8ba3da43dc92448c863a

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-638-g0d599cd2b6695/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230303.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640d8ba3da4=
3dc92448c863f
        failing since 136 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/640d8ba3da4=
3dc92448c863f
        failing since 136 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =20

