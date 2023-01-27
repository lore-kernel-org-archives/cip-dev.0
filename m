Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E14BC54EAA
	for <webhook@archiver.kernel.org>; Fri, 27 Jan 2023 01:22:47 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.92352.1674782561617065090
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 26 Jan 2023 17:22:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=zQGRmL/2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9so3519883pll.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 26 Jan 2023 17:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6Af3S2xHqKPA4b4kEHM5fduChvh6HPHbgkigv8AWDw4=;
        b=zQGRmL/226QSrWY9p5XMtHkdQ4yvYUBEqi4TOdVERSHpkk9RwP5z3MlpArDjPKiURP
         lkASXMh75uu+t+wPbr62+Es9f5/sB0Lk+swjHtapVYlnOAgsTAcpCT+81U/hcvy+wNf3
         ToqOTADWrmm+w2R6U8bMFqwQGV4scRIliqpM+a6/AyxK+7s3XH+QDW/C8WoGnm4l0TzR
         E2VfCQkbxzFM41Csvi1XVttxGmgm/R/qVkMbtyFzKY0XscPsGI2UkIL/vc9o9X8LTm4a
         Kzed4hgj2pUkmK7Pk1hBHbnoTkQSkFAXfHD54b3KrFMGFWQfGORNE1hy45B9ZmPbttPu
         oVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Af3S2xHqKPA4b4kEHM5fduChvh6HPHbgkigv8AWDw4=;
        b=6RkUn5CzJcioXflkvM8zeDovO+pQVQrhWwuL/uHkh+Cacu/ovMG5rPCE27480F8FH3
         cIneU+7gIydQWRlcHuqKbQk44ljX0Zs6LFs2LDqy3qTE/PbRayWkI3mXIwOE6E617Mn9
         xULtCW3oIJCEroH3b1kuobEF5wmcspfgOA7GXg+gfzxB8FmwIVz4ei+MyWFbGLvstBhb
         arN1qLd91X3fMec63UVYdMpbRjvz9i2xo/CbbucRte9qCnGM7sz+N6+zX5iNjNnsiRsr
         FYyQE1EGkJWDNOh33wK5QXjCIfiPoOyyx/UhdqV8LkKGpf1vfXK+87nPHoKHde0rLAjr
         7p2w==
X-Gm-Message-State: AFqh2krgZDncmsP4aLTXVIfgyrqQm2RSRF8l0Ncv6hMeJ2jRsqZ3JHhr
	smvEHv1lXpAJd9sBkADi+fv65JWDlloun5FiwZ5b1Q==
X-Google-Smtp-Source: AMrXdXuObBopPzrKaCdEEDXIogFpm4hSinjMJglLgnyWJ2ET+GRVSTeeCBZgnsCPCVoWM+JJ+hY0Aw==
X-Received: by 2002:a05:6a20:a5a2:b0:b8:8a94:5bf with SMTP id bc34-20020a056a20a5a200b000b88a9405bfmr36363964pzb.21.1674782560850;
        Thu, 26 Jan 2023 17:22:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v26-20020aa7809a000000b00589d91962d5sm1422338pff.195.2023.01.26.17.22.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 17:22:40 -0800 (PST)
Message-ID: <63d32760.a70a0220.12e60.26c8@mx.google.com>
Date: Thu, 26 Jan 2023 17:22:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.162-cip24-443-g1f8fb81fe752
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 17 runs,
 10 regressions (v5.10.162-cip24-443-g1f8fb81fe752)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Jan 2023 01:22:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10488

cip-gitlab/ci/pavel/linux-test ltp-timers: 17 runs, 10 regressions (v5.10.1=
62-cip24-443-g1f8fb81fe752)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
qemu_riscv64             | riscv | lab-baylibre  | gcc-10   | defconfig    =
              | 2          =

qemu_riscv64             | riscv | lab-broonie   | gcc-10   | defconfig    =
              | 2          =

qemu_riscv64             | riscv | lab-collabora | gcc-10   | defconfig    =
              | 2          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 2          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.162-cip24-443-g1f8fb81fe752/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.162-cip24-443-g1f8fb81fe752
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1f8fb81fe7523922b7ff40bbacc9ac4aa9e11796

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  d042c168dd037bb0128b86ee4ac4f5c526eddc7b =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
qemu_riscv64             | riscv | lab-baylibre  | gcc-10   | defconfig    =
              | 2          =


  Details:     https://kernelci.org/test/plan/id/63d31d1bb0f0942209915eb9

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/riscv/defconfig/gcc-10/lab-baylibre/ltp-=
timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/riscv/defconfig/gcc-10/lab-baylibre/ltp-=
timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30120.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d31d1bb0f=
0942209915ebe
        new failure (last pass: v5.10.162-929-gae713b3c4626e) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d31d1bb0f=
0942209915ebe
        new failure (last pass: v5.10.162-929-gae713b3c4626e) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
qemu_riscv64             | riscv | lab-broonie   | gcc-10   | defconfig    =
              | 2          =


  Details:     https://kernelci.org/test/plan/id/63d31b0c06719185c0915ec5

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/riscv/defconfig/gcc-10/lab-broonie/ltp-t=
imers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/riscv/defconfig/gcc-10/lab-broonie/ltp-t=
imers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30120.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d31b0c067=
19185c0915eca
        new failure (last pass: v5.10.162-929-gae713b3c4626e) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d31b0c067=
19185c0915eca
        new failure (last pass: v5.10.162-929-gae713b3c4626e) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
qemu_riscv64             | riscv | lab-collabora | gcc-10   | defconfig    =
              | 2          =


  Details:     https://kernelci.org/test/plan/id/63d31a6ec4fe7509eb915ec3

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/riscv/defconfig/gcc-10/lab-collabora/ltp=
-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/riscv/defconfig/gcc-10/lab-collabora/ltp=
-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30120.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d31a6ec4f=
e7509eb915ec8
        new failure (last pass: v5.10.162-929-gae713b3c4626e)

    2023-01-27T00:27:16.981436     =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d31a6ec4f=
e7509eb915ec8
        new failure (last pass: v5.10.162-929-gae713b3c4626e)

    2023-01-27T00:27:16.981436     =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 2          =


  Details:     https://kernelci.org/test/plan/id/63d31f9d2c66505fe9915eee

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm64/defconfig/gcc-10/lab-cip/ltp-timer=
s-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm64/defconfig/gcc-10/lab-cip/ltp-timer=
s-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230120.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d31f9d2c6=
6505fe9915ef9
        failing since 71 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f6=
, first fail: v4.19.265-cip85-rt27) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d31f9d2c6=
6505fe9915ef9
        failing since 71 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f6=
, first fail: v4.19.265-cip85-rt27) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63d31bf502556d787b915ecb

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-cip24-443-g1f8fb81fe752/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230120.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d31bf5025=
56d787b915ed0
        failing since 79 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b=
, first fail: v5.10.147-cip18-15-gef247a3cd0ad) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d31bf5025=
56d787b915ed0
        failing since 79 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b=
, first fail: v5.10.147-cip18-15-gef247a3cd0ad) =

 =20

