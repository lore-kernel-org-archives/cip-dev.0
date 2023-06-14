Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF58BEB64D9
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 13:45:15 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web11.12305.1686750311972125885
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 14 Jun 2023 06:45:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=kzfCdCNm;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-66643830ab3so718576b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 14 Jun 2023 06:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686750311; x=1689342311;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e6kSgq/ggqveQU4Ft7O8O6rQtUMRpBZDS7YlhALy4gE=;
        b=kzfCdCNm+x3kLvj7oLn1+cjN36E2aVjhxm3SrXg+JLLc+WCWeDIqpzJ4dG5pDtr2gB
         QP5lqjZpfr2hJn17Njf/JzyUp3y5nMNRIwBAkYOq5kOg87aPS8wK6XiFsSNF5ctc/zns
         nY06Ev+29T2qkhZiyikJMWQB68jFFkqf3Upycp5L5y0Pa/AGqQNFteUS8i8nBE3p4xem
         ZefF4DrkPTUwf8SSbOO6t1+cPBgarH8qFG925fj0KEFGwOmyq2MIzu1TmQlo1XOylPos
         feQS5Lcl20S5YmAeL16FvEK9a78FARfjqGMTp/uiSH/6eETg7UdTGxfVWcoqTBM7uZHb
         DNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686750311; x=1689342311;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6kSgq/ggqveQU4Ft7O8O6rQtUMRpBZDS7YlhALy4gE=;
        b=ZWxad4QykrJ+piFeCkBfwIVP+8DsawlqVBMIvoDYZJ3e3DHflxoRsLWQ3bzTmPNj85
         bnWEb9FmGtW8kgWxVUvsgTAc/jMvmfAjD9XYkelGcdkEaiZo7wUO9k97foVYHsb8B0ks
         xryP9b+AQNP4atBpGzJp/CHuMxmU6Wzv1aHOifQsdXx08ayaVSm4rAkcwEk0SGxWjC7t
         a6TEPqRf+WyRE7JyS0eTdVI2rWPU2OLScYrMlH9PadpcoF1W1JFZz1RwzT72NdBlC0GK
         GGnrNNZbE5A/GZ4QQoTdBkEBI4f5DpsN6WeN+bHEhPl/YhD07WLcZYo3zYOB5+G3hfgC
         hgig==
X-Gm-Message-State: AC+VfDy/GeTePRO2FiDWOe9X7ps+hvauXgnObC1xrVsiTV/9L2ihpt2g
	0FKfQqmvmoEh5WCf7FnXJUCMu5z3brDNaG8J0Jc2Lw==
X-Google-Smtp-Source: ACHHUZ68KilT/J4+fdgHPkxzKPdCd11DnCXYTJz9JU3iTE22aKhd/kt1Onv+WRHuloQ52niFMcSNng==
X-Received: by 2002:a05:6a20:43ac:b0:112:2843:b546 with SMTP id i44-20020a056a2043ac00b001122843b546mr1696819pzl.58.1686750310908;
        Wed, 14 Jun 2023 06:45:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k13-20020aa7820d000000b0064f708ca12asm5296776pfi.70.2023.06.14.06.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:45:10 -0700 (PDT)
Message-ID: <6489c466.a70a0220.b4f3f.a878@mx.google.com>
Date: Wed, 14 Jun 2023 06:45:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.31-46-g4cc1cc26e90f
Subject: cip/linux-6.1.y-cip ltp-timers: 9 runs,
 10 regressions (v6.1.31-46-g4cc1cc26e90f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 13:45:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12032

cip/linux-6.1.y-cip ltp-timers: 9 runs, 10 regressions (v6.1.31-46-g4cc1cc2=
6e90f)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

mt8173-elm-hana          | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =

qemu_riscv64             | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 2          =

qemu_x86_64              | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig             | 2          =

qemu_x86_64              | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.31-46-g4cc1cc26e90f/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.31-46-g4cc1cc26e90f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      4cc1cc26e90f104dbefb9aa54defaf48b5802325

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


  Details:     https://kernelci.org/test/plan/id/6489b7d4acc6e8326930612f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-46=
-g4cc1cc26e90f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-46=
-g4cc1cc26e90f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6489b7d4acc=
6e83269306134
        failing since 8 days (last pass: v6.1.26-1281-g84d5372e0f314, first=
 fail: v6.1.26-1314-g1ab0ac1d7e2e3) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6489b7d4acc=
6e83269306134
        failing since 8 days (last pass: v6.1.26-1281-g84d5372e0f314, first=
 fail: v6.1.26-1314-g1ab0ac1d7e2e3) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489bde9e4c4ca79bc30614d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-46=
-g4cc1cc26e90f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-46=
-g4cc1cc26e90f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6489bde9e4c4ca79bc3=
0614e
        new failure (last pass: v6.1.31-45-gce658d9231044) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
mt8173-elm-hana          | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6489c0104a283a7313306158

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-46=
-g4cc1cc26e90f/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-ti=
mers-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-46=
-g4cc1cc26e90f/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-ti=
mers-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6489c0104a283a73133=
06159
        new failure (last pass: v6.1.31-45-gce658d9231044) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_riscv64             | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 2          =


  Details:     https://kernelci.org/test/plan/id/6489b81a0f388a3e563061aa

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-46=
-g4cc1cc26e90f/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu_riscv64=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-46=
-g4cc1cc26e90f/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu_riscv64=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30609.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6489b81a0f3=
88a3e563061af
        new failure (last pass: v6.1.31-45-gce658d9231044) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6489b81a0f3=
88a3e563061af
        new failure (last pass: v6.1.31-45-gce658d9231044) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_x86_64              | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig             | 2          =


  Details:     https://kernelci.org/test/plan/id/6489b5f7d871a91187306136

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-46=
-g4cc1cc26e90f/x86_64/x86_64_defconfig/gcc-10/lab-collabora/ltp-timers-qemu=
_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-46=
-g4cc1cc26e90f/x86_64/x86_64_defconfig/gcc-10/lab-collabora/ltp-timers-qemu=
_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/amd64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6489b5f7d87=
1a9118730613b
        failing since 9 days (last pass: v6.1.26-1281-g84d5372e0f314, first=
 fail: v6.1.26-1298-g61395b9756bd5)

    2023-06-14T12:43:22.236232  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6489b5f7d87=
1a9118730613b
        failing since 9 days (last pass: v6.1.26-1281-g84d5372e0f314, first=
 fail: v6.1.26-1298-g61395b9756bd5)

    2023-06-14T12:43:22.236232  =

   =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_x86_64              | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6489b7b0364674a770306182

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-46=
-g4cc1cc26e90f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
ltp-timers-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-46=
-g4cc1cc26e90f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/=
ltp-timers-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/amd64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6489b7b0364=
674a770306189
        new failure (last pass: v6.1.31-45-gce658d9231044)

    2023-06-14T12:50:36.157044  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6489b7b0364=
674a770306189
        new failure (last pass: v6.1.31-45-gce658d9231044)

    2023-06-14T12:50:36.157044  =

   =

 =20

