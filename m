Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3820DC004D4
	for <webhook@archiver.kernel.org>; Sat, 21 Jan 2023 19:42:48 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web11.4388.1674330167361872306
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 21 Jan 2023 11:42:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=0H7+6gGt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso12063431pjg.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 21 Jan 2023 11:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4b0e85w5MFoumuDIw6cngFKq84+kW0xfxt76hKfONzQ=;
        b=0H7+6gGtptk/QaAVg9aXuqd0olGHgrf2Rxy4NlKo40J2QGXvKofVkjwIv+Kzb5XVl0
         KfHVUVxU36PL0w+15P1JWmx3/XH2G1GBqC3/ZLkNmvefnHmmpr18PmcQa8RK/4PLjzo2
         CeZf/ZyMGk1pBGTAxlLkwTxnasHxtCpYd0pjqQSpKFr+EIf4xdjabdWafYAKcOk0axcL
         onklTNpnRgTWP8Cc5Uwqe7eqJV3k9g9v3aC4Ps5o4sAssXOHPbN7RoXw6EsUamVGjXU/
         6bTkSNjn1SufH3g+s6g1PJbTot4AHaXzQqrZ72UIr65OlUiudu1drl6iAk8wiod7pXBd
         nCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4b0e85w5MFoumuDIw6cngFKq84+kW0xfxt76hKfONzQ=;
        b=70opDHhAkx2Qm07ZrEU8RTBSPhlHqZd1zP00YGg4zPcnibKN6TOzpspS4v5nhetnVb
         c8I85LWdvFKknQdAm1hpELlyVMOQMLMkfR7O8X8uRJXuSvTPXlKoyCKPGsitfOGZlwEy
         01C5FgR8LvBmoxcfdlGOFIbnzXq4BUBoeqcczy4ghEgCxJmfOOsAww8FCaGzxA2slqgw
         ilXYO70JFXKQsirOdMxc1nXnZl4JKhDypfXno+0032Ew8Csp/k8U2MKhfMYRRGvqnthL
         TZjGEfuWUITyJdFBCLU/MLG/JqoqyBnrnDiMgOpzXKs2EUWIvqMzvXzZlfo7E7+C1Tjs
         coYg==
X-Gm-Message-State: AFqh2kryvzA2UDuQV/JkfsV6F6G+a1FNwZZ0z7EBXyV1yOmuLH6whI/Y
	jj/r0y8SxHqxZvbGGvffrDYlnyOdPibnf9Wu5C0=
X-Google-Smtp-Source: AMrXdXscauyVH5hOs8pNeFOm/5rWypVEtKVPyYGSpqYY0bZ6JFN+jQV+nMo3cJRte9zYGBvNu4NjrA==
X-Received: by 2002:a17:902:8a98:b0:194:83fd:9a7a with SMTP id p24-20020a1709028a9800b0019483fd9a7amr19293994plo.54.1674330166138;
        Sat, 21 Jan 2023 11:42:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n24-20020a170902969800b00186f608c543sm892423plp.304.2023.01.21.11.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 11:42:45 -0800 (PST)
Message-ID: <63cc4035.170a0220.f045a.0fe9@mx.google.com>
Date: Sat, 21 Jan 2023 11:42:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.270-cip89
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip baseline: 75 runs,
 6 regressions (v4.19.270-cip89)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 21 Jan 2023 19:42:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10456

cip/linux-4.19.y-cip baseline: 75 runs, 6 regressions (v4.19.270-cip89)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-collabora | gcc-10   | defconfig       =
             | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | cip://4.19.y-...=
64_defconfig | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig       =
             | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig+arm64-=
chromebook   | 1          =

sun50i-h6-pine-h64    | arm64 | lab-baylibre  | gcc-10   | defconfig       =
             | 1          =

sun50i-h6-pine-h64    | arm64 | lab-collabora | gcc-10   | defconfig       =
             | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.270-cip89/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.270-cip89
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8cbf38242b91f4f98d6fc776bae10cc74740eff2 =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-collabora | gcc-10   | defconfig       =
             | 1          =


  Details:     https://kernelci.org/test/plan/id/63cc3a2b9c809a6d1d915f24

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.270=
-cip89/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.270=
-cip89/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63cc3a2b9c809a6d1d915=
f25
        failing since 151 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | cip://4.19.y-...=
64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63cc388707a6fe586b915ec9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: cip://4.19.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.270=
-cip89/arm64/cip---4.19.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-collabo=
ra/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.270=
-cip89/arm64/cip---4.19.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-collabo=
ra/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63cc388707a6fe586b915=
eca
        failing since 151 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig       =
             | 1          =


  Details:     https://kernelci.org/test/plan/id/63cc3a2a9c809a6d1d915f21

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.270=
-cip89/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.270=
-cip89/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-gicv3.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63cc3a2a9c809a6d1d915=
f22
        failing since 151 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig+arm64-=
chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63cc3a7ac697e47608915eda

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.270=
-cip89/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_=
arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.270=
-cip89/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-qemu_=
arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63cc3a7ac697e47608915=
edb
        failing since 151 days (last pass: v4.19.226-cip66, first fail: v4.=
19.255-cip79) =

 =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
sun50i-h6-pine-h64    | arm64 | lab-baylibre  | gcc-10   | defconfig       =
             | 1          =


  Details:     https://kernelci.org/test/plan/id/63cc3afbd6b2b788e1915f47

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.270=
-cip89/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.270=
-cip89/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cc3afbd6b2b788e1915f4c
        new failure (last pass: v4.19.266-cip86)

    2023-01-21T19:20:14.952258  / # #
    2023-01-21T19:20:15.054254  export SHELL=3D/bin/sh
    2023-01-21T19:20:15.054631  #
    2023-01-21T19:20:15.155946  / # export SHELL=3D/bin/sh. /lava-3176165/e=
nvironment
    2023-01-21T19:20:15.156382  =

    2023-01-21T19:20:15.257785  / # . /lava-3176165/environment/lava-317616=
5/bin/lava-test-runner /lava-3176165/1
    2023-01-21T19:20:15.258384  =

    2023-01-21T19:20:15.263853  / # /lava-3176165/bin/lava-test-runner /lav=
a-3176165/1
    2023-01-21T19:20:15.333773  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-21T19:20:15.334263  + cd /lava-3176165<8>[   15.641492] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 3176165_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
sun50i-h6-pine-h64    | arm64 | lab-collabora | gcc-10   | defconfig       =
             | 1          =


  Details:     https://kernelci.org/test/plan/id/63cc39420329145660915ebe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.270=
-cip89/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.270=
-cip89/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cc39420329145660915ec3
        new failure (last pass: v4.19.266-cip86)

    2023-01-21T19:12:49.908562  / # #
    2023-01-21T19:12:50.010637  export SHELL=3D/bin/sh
    2023-01-21T19:12:50.011094  #
    2023-01-21T19:12:50.112557  / # export SHELL=3D/bin/sh. /lava-8816059/e=
nvironment
    2023-01-21T19:12:50.113189  =

    2023-01-21T19:12:50.215928  / # . /lava-8816059/environment/lava-881605=
9/bin/lava-test-runner /lava-8816059/1
    2023-01-21T19:12:50.216690  =

    2023-01-21T19:12:50.231925  / # /lava-8816059/bin/lava-test-runner /lav=
a-8816059/1
    2023-01-21T19:12:50.273113  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-21T19:12:50.291129  + cd /lava-8816059<8>[   15.632888] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 8816059_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =20

