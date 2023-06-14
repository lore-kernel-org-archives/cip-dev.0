Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C66EB64D8
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 03:25:01 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web11.3533.1686713098007942356
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 13 Jun 2023 20:24:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=iGWQdCt4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1b3d0b33dc2so18150905ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 13 Jun 2023 20:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686713097; x=1689305097;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QgyAHN6CHPDGfWGqj22AJFExbPBdOYl+akbz1wfA+3k=;
        b=iGWQdCt4ywFTJi6eU6TprA6HImjhonZxCxGiIzxIgx900uhQ/2CySaRGlqovUO8/Tm
         Gf+msjh5sijLZ/5LAcuXQ850yWBsgBeZ0QzLYiHnyS76pZrgs2X03eLbJ4X0BjlWn1HB
         ydrkbHfPbyIF/OA4j7Q4dWaqsyCRMd6ktcwqlVXVwKP9l05H/z4d8jXgQHBBGM2EF92Y
         bKnIWyZwoXAmx+ZOH295HIYEeCk+FX/T0Mnc2n84JCXYwdhXt8cfXQCOYw4YVcphKHS+
         AK3SCezr05kDFVSKK+odM109wAR/bfmkz3Vq0yn89J60CtQwwhivRMV/EKNWTB8sPIpT
         873Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686713097; x=1689305097;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QgyAHN6CHPDGfWGqj22AJFExbPBdOYl+akbz1wfA+3k=;
        b=khg8eTacSKY2nOozY2xTZ6RBkdr+cRdx8xkoS2btiysdUj3WcuqThSxf2oHJvvOBhf
         b1krLf2IFUJxFaXmMqfPhzeeszSwMlij95aPxG+qFqPRKFhM1LWkXQkJD/5IYC6Qh817
         BaBlF7z5juQmZU6hJumgNFDbtfvy4Nj6QnmSFZy27/eTGG5ibdGg6JWpObV+5qjb2xBE
         J9UA6Vh+bWEGk7ntq0djTu8LLvrj/V+LZzcPgckteYARsSxHg5a7ZTVOGkZKAyvF6t0i
         PX0rmgAn1cVlnjATSLLhOtDMo7eVh9PyejcgsXblMQkLdd5VgczOVf2z7c5hj1JID9rR
         DuOg==
X-Gm-Message-State: AC+VfDwRgGN7Zdxh9tE8Z5/x0DmVfPrh+2Pt02gYVqfDSpTRZJ3kewlf
	xAmG99M7uzMxWzMa3IXa+2cxjIGCKXBGEVXErwGIzQ==
X-Google-Smtp-Source: ACHHUZ7+RLHnNz40C6zGqnY6f6ZLXkxo02x5DyVtw/U8mHnRHM1NjGzp9r9M5c4C/RyCvXodJ5xN1Q==
X-Received: by 2002:a17:902:ce8a:b0:1aa:e938:3ddf with SMTP id f10-20020a170902ce8a00b001aae9383ddfmr12434911plg.7.1686713096529;
        Tue, 13 Jun 2023 20:24:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i8-20020a170902c94800b001b02df0ddbbsm4402737pla.275.2023.06.13.20.24.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 20:24:56 -0700 (PDT)
Message-ID: <64893308.170a0220.56558.9d68@mx.google.com>
Date: Tue, 13 Jun 2023 20:24:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-8-gc3d08808cfa7
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 10 runs,
 8 regressions (v5.10.182-cip35-8-gc3d08808cfa7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 03:25:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12001

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 10 runs, 8 regressio=
ns (v5.10.182-cip35-8-gc3d08808cfa7)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

qemu_riscv64             | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 2          =

rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.182-cip35-8-gc3d08808cfa7/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.182-cip35-8-gc3d08808cfa7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c3d08808cfa768cd3cc5ecfba684f72db3e04b9f

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


  Details:     https://kernelci.org/test/plan/id/648921d62591dc85dc30617c

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/648921d6259=
1dc85dc306181
        failing since 230 days (last pass: v5.10.147-cip18-56-g87bd4289362b=
e, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/648921d6259=
1dc85dc306181
        failing since 230 days (last pass: v5.10.147-cip18-56-g87bd4289362b=
e, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6489248358d69733b8306132

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6489248358d=
69733b8306137
        failing since 230 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6489248358d=
69733b8306137
        failing since 230 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64892a3fa86c75231e30615b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/64892a3fa86c75231e3=
0615c
        new failure (last pass: v5.10.180-cip34-236-g6d219c607dc68) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_riscv64             | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 2          =


  Details:     https://kernelci.org/test/plan/id/648920b8ae33f057bc306147

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/riscv/defconfig/gcc-10/lab-col=
labora/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/riscv/defconfig/gcc-10/lab-col=
labora/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30609.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/648920b8ae3=
3f057bc30614c
        new failure (last pass: v5.10.180-cip34-236-g6d219c607dc68)

    2023-06-14T02:06:39.799731  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/648920b8ae3=
3f057bc30614c
        new failure (last pass: v5.10.180-cip34-236-g6d219c607dc68)

    2023-06-14T02:06:39.799731  =

   =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64892a0a0e7e4f57ab30614c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/64892a0a0e7e4f57ab3=
0614d
        new failure (last pass: v5.10.180-cip34-236-g6d219c607dc68) =

 =20

