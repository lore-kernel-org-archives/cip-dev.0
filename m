Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6F4C7EE24
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 11:29:32 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web11.5144.1685964566992807383
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 04:29:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=X9k7TJA0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-651f2f38634so4142416b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 04:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685964566; x=1688556566;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PFGVSXSHCxNAY64bHK1YZ05gd6O6zk80nbjbxT8rZgE=;
        b=X9k7TJA074kfh6qABBGxNw5rkRK6yn1IRE+6q+igA7vN8/Z+ENiu3gnuEDHMBC6U4F
         CN53zrhrdTFXCM2OGco+NrjPIQfrSl61SYa9dP2N2FZ2f113p3WBHymNLfwC0pQBRMcB
         My0ebLI1occTcGy8vXwjmo6IYZfOXO3X0GJb+RFv9+vEz4BWUTrT7KrPUSudEfKtF1Fi
         +Ew/Mq/P/OTFMa03bXLyt3K2dzp829BviQxZD2thDSAGeoBH/P+MU+JQTdEULn/WMYbm
         E+awbOdOUPFYJG/8HDCSv+HNeFNhaxeeBIhtCF069XmARVLNk0juIvcx/QRDjTY6w31n
         mRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685964566; x=1688556566;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PFGVSXSHCxNAY64bHK1YZ05gd6O6zk80nbjbxT8rZgE=;
        b=h0qZniNrgAilWEXFJn6m2v0qyi3/JPTYg+1jop2rU56reAfHYUjaUv5F4tbbwwYUuC
         +XXuApJRu/uHLI2OL/5g4AEdzGNN6XItgvxGCVsx+SVbNYS/vmr5lp2t/yhc0R5SLlkX
         DqZJD8Kh+z/g5Es5eEhLI5czBnL//SpzwwuSmq8pwwT7n07CaspaiCtDOkTNwX1iqc1d
         3I8Ru9WzDnReJe1XGPpBKB0OoTHdbjMeSD8Avk/uT4ZoxOPkT53MIf7POFpeKoKBdNeN
         XHixNTjtnsgnTlKXRkHuJ7IvpleG/xbSGwQoe4Cr0aTs8H1sRMJuRWNZN1yrx+xT3EMT
         CzSA==
X-Gm-Message-State: AC+VfDx4107apUJbaniKF+B9obidDLq/WDfDvDglfjVy9EBvVT+Ajpzt
	b3uoQ7VJ7fDlVdtlNGzyyXvRKE5Ebg+bo2q2ZcSo5A==
X-Google-Smtp-Source: ACHHUZ4PH0wGzQWdFqg6uF7A1G861qKuHQSVC8A6Ut6F9a59/Q6tiQZz6aakuxBrVg07PlfSclc2jA==
X-Received: by 2002:a17:903:2449:b0:1ae:5fb0:4256 with SMTP id l9-20020a170903244900b001ae5fb04256mr8131877pls.57.1685964565830;
        Mon, 05 Jun 2023 04:29:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t14-20020a170902e84e00b001a5fccab02dsm6340567plg.177.2023.06.05.04.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 04:29:25 -0700 (PDT)
Message-ID: <647dc715.170a0220.f3a82.aa07@mx.google.com>
Date: Mon, 05 Jun 2023 04:29:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-19-gf0f6960f132cd
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip ltp-timers: 12 runs,
 10 regressions (v5.10.180-cip34-19-gf0f6960f132cd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 11:29:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11802

cip/linux-5.10.y-cip ltp-timers: 12 runs, 10 regressions (v5.10.180-cip34-1=
9-gf0f6960f132cd)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 2          =

qemu_riscv64           | riscv  | lab-broonie   | gcc-10   | defconfig     =
               | 2          =

qemu_riscv64           | riscv  | lab-collabora | gcc-10   | defconfig     =
               | 2          =

qemu_smp8_riscv64      | riscv  | lab-broonie   | gcc-10   | defconfig     =
               | 2          =

qemu_smp8_riscv64      | riscv  | lab-collabora | gcc-10   | defconfig     =
               | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip34-19-gf0f6960f132cd/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip34-19-gf0f6960f132cd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f0f6960f132cdf82ed0fcb61de7c496d33f0998f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/647dc2f89a6b12318ef5de3f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647dc2f89a6=
b12318ef5de44
        failing since 19 days (last pass: v5.10.177-cip31, first fail: v5.1=
0.179-cip32-4-gd8c029e4780f) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647dc2f89a6=
b12318ef5de44
        failing since 19 days (last pass: v5.10.177-cip31, first fail: v5.1=
0.179-cip32-4-gd8c029e4780f) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
qemu_riscv64           | riscv  | lab-broonie   | gcc-10   | defconfig     =
               | 2          =


  Details:     https://kernelci.org/test/plan/id/647dbde8750d968bfff5de98

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu=
_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu=
_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30527.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647dbde8750=
d968bfff5de9d
        new failure (last pass: v5.10.180-cip34) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647dbde8750=
d968bfff5de9d
        new failure (last pass: v5.10.180-cip34) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
qemu_riscv64           | riscv  | lab-collabora | gcc-10   | defconfig     =
               | 2          =


  Details:     https://kernelci.org/test/plan/id/647dbc6b541a057094f5de45

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qe=
mu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qe=
mu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30527.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647dbc6b541=
a057094f5de4a
        new failure (last pass: v5.10.180-cip34) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647dbc6b541=
a057094f5de4a
        new failure (last pass: v5.10.180-cip34) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
qemu_smp8_riscv64      | riscv  | lab-broonie   | gcc-10   | defconfig     =
               | 2          =


  Details:     https://kernelci.org/test/plan/id/647dbe370815bff833f5de87

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu=
_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu=
_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30527.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647dbe37081=
5bff833f5de9a
        failing since 13 days (last pass: v5.10.180-cip33, first fail: v5.1=
0.180-cip33-11-gfea7994097935) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647dbe37081=
5bff833f5de9a
        failing since 13 days (last pass: v5.10.180-cip33, first fail: v5.1=
0.180-cip33-11-gfea7994097935) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
qemu_smp8_riscv64      | riscv  | lab-collabora | gcc-10   | defconfig     =
               | 2          =


  Details:     https://kernelci.org/test/plan/id/647dbc06752cf82752f5de36

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qe=
mu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qe=
mu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30527.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647dbc06752=
cf82752f5de3b
        failing since 13 days (last pass: v5.10.180-cip33, first fail: v5.1=
0.180-cip33-11-gfea7994097935)

    2023-06-05T10:41:56.218299  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647dbc06752=
cf82752f5de3b
        failing since 13 days (last pass: v5.10.180-cip33, first fail: v5.1=
0.180-cip33-11-gfea7994097935)

    2023-06-05T10:41:56.218299  =

   =

 =20

