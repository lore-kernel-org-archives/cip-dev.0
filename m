Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B270C48298
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 16:07:58 +0000 (UTC)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
 by mx.groups.io with SMTP id smtpd.web10.66788.1707149276170871217
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 08:07:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=WDd4/2gh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.43, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2046b2cd2d3so3552738fac.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 08:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707149275; x=1707754075; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dD1akZYvAnLbJGOrilUa0vNYH8E2aI2TImgqhvnkNZE=;
        b=WDd4/2ghK4wKHvPChbKmIFpImC/s5aifoFONbUhmJKIw5bgcK/RRN1L19SUE9kMJC4
         cfJcv4XIkgvR85vwQRwuanhNgWSVPjsY+mKwmJWkctDC9TC7FEModAqSuB0sEVO/eaB4
         72DNQdh6WVDIy3kJ4VoxBgV2lXV3DMna7ht1F1tgygtJztfseybtFmvBMfJ0mDTi1QMB
         IAsTD+Zc2mLI63PnB3IilcOXGQCNKDuyrx5jvt+tjhCgBW8tWJKKyUG2qK6tEDwhT8sj
         sMer4rJ2ufyuZBh7skqw47RAOjvA9BegPFsnsSm/qOE8/uytx6bFXGpxP+LIGeaEX1i6
         ObUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707149275; x=1707754075;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dD1akZYvAnLbJGOrilUa0vNYH8E2aI2TImgqhvnkNZE=;
        b=NIvLb6EhliwvLzifQAVDT8mxNZmzpRhPuOe7b3Y9cvkNe4NETPw4bPrjDHDnq8kW8F
         ++xqN0EQNNLapMMqjI+hxQgNXKEwpw2qDug/hlfvrT5rqqEyRrD5ghr1qRprLTdE6yoc
         7koU5VWoGI2WklY19IrfatDa1obv+CUEO6KwhIawC2bNxWOSFfC4fomCQu1L01T3T8kn
         zAIuNpzz2ieaQPbajrGmSLtw6pw/+RNP+oJYXyQ1TJDPIv7XNYxnIHhBAIpoCHbTCdTN
         3rVICOWT2UGyJMTR/8m1Vgv033ljIbBfiFHsRDQ2NK15APslTOkbrKBiVdEMAIy1kRTw
         WbgQ==
X-Gm-Message-State: AOJu0YxGqK1OlJo7G3N6BL1kWOq2QSNhNQQfztUK1Z5OpBdFQio+3uh3
	RHR6Ncczm5r2QawZ2q/3nVAyB6p9/2DIg+U5UPyY8qjl5NtT5jYFZyQajF/pr+hduotsIIgMO4C
	f
X-Google-Smtp-Source: AGHT+IEMcMoKl0HId1H1kx21If3qK1mcyodlMMiGUvpIvYeJWIk8erqVVn+7t7v3AxIYp4F1kyIzPA==
X-Received: by 2002:a05:6870:2107:b0:219:88b7:f9cb with SMTP id f7-20020a056870210700b0021988b7f9cbmr141975oae.28.1707149274868;
        Mon, 05 Feb 2024 08:07:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a23-20020a631a57000000b005d8e30897e4sm101863pgm.69.2024.02.05.08.07.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:07:54 -0800 (PST)
Message-ID: <65c107da.630a0220.602f0.0b1b@mx.google.com>
Date: Mon, 05 Feb 2024 08:07:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.209-cip44-rebase
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 19 runs,
 8 regressions (v5.10.209-cip44-rebase)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 16:07:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14739

cip-gitlab/ci/pavel/linux-test ltp-timers: 19 runs, 8 regressions (v5.10.20=
9-cip44-rebase)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 2          =

mt8173-elm-hana          | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook | 1          =

qemu_riscv64             | riscv  | lab-broonie   | gcc-10   | defconfig   =
               | 2          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
               | 1          =

rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.209-cip44-rebase/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.209-cip44-rebase
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      17e47f846f71ff31baabe74a720660536794686d

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 2          =


  Details:     https://kernelci.org/test/plan/id/65c0f00eb3b7f272e800a046

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65c0f00eb3b=
7f272e800a04b
        failing since 1 day (last pass: v6.1.72-cip13-32-gf60d2e8cb51c, fir=
st fail: v6.1.75-cip14-132-g6e54756fbd6c2) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65c0f00eb3b=
7f272e800a04b
        failing since 1 day (last pass: v6.1.72-cip13-32-gf60d2e8cb51c, fir=
st fail: v6.1.75-cip14-132-g6e54756fbd6c2) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
mt8173-elm-hana          | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f131d560b2a92700a0ae

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/ltp-timers-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/ltp-timers-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c0f131d560b2a9270=
0a0af
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
qemu_riscv64             | riscv  | lab-broonie   | gcc-10   | defconfig   =
               | 2          =


  Details:     https://kernelci.org/test/plan/id/65c0f674ed43f1d8b200a039

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_=
riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_=
riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65c0f674ed4=
3f1d8b200a04a
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65c0f674ed4=
3f1d8b200a04a
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
               | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f5eac0ecc53b7700a043

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-=
hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-=
hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c0f5eac0ecc53b770=
0a044
        failing since 5 days (last pass: v4.19.299-cip105-1134-gc868d5e4ada=
a, first fail: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65c0f5eac0ecc53b7700a048

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65c0f5eac0e=
cc53b7700a04d
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65c0f5eac0e=
cc53b7700a04d
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908) =

 =20

