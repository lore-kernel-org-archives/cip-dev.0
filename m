Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACEBC7EE29
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 02:01:06 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web10.11562.1684807257602235527
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 May 2023 19:00:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=5R0NFz//;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2533d74895bso5019464a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 22 May 2023 19:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684807256; x=1687399256;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bDuxDFWvkLoU3TEQQRRvqlbQaIydkpQ44En2S6Tbzr4=;
        b=5R0NFz//jiElzWt9iD1t5U31IcCq1+bob9Yxpt3CE3JATgY2INOXqdVJ9abp1OMicT
         nEAop8lq7fJwzUA+Y7ZcaYo6i30fXuK33uFBg/kfmObm0Y6Xylz9rY5Vpah0gHVjGuMR
         fFPv5p2LOrQJ9P3b5dMVDP4q6Tza5akd88XW4cdH+Mc3SHOw2UAo7eQz6/nNctWIqY92
         FiH5vEDAqFTv28waTaNdk73yfI7I0I+S/aQHYaPKfzMv1nKenkpgAzBwFr+3YiE78zQh
         kqZy/XkP9mIpN9ZaACLiQxzGzr17+FWU44HjrM25t5I1yGrZBn0lzyybVGKDkpYszoHV
         9OZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684807256; x=1687399256;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDuxDFWvkLoU3TEQQRRvqlbQaIydkpQ44En2S6Tbzr4=;
        b=k36eVF0CLose1JkKW8VXtD6yIUGTNyV2HuhxktIachwTLEWucf7Y+6UWMulPbtr3A3
         pE4K/Jqm1c0bw96u4ZEuKERY/VJ9p2qixMdKeiY+WBHiooDkq005ynHxf6aqRieuG3g1
         vA70FOjZgCsaLbOtLEyn16gXVTW+JkwvwSoBG2Ku/uM7HZ5VDj2DyA+2JgcPk+BqZWvT
         EhWLYtEACaiKDCOjJIUOiqqDxG0Dce8bshBKnWjLg0832M8X0RNEWyD1lw+rP80uFBfo
         F8rW0bAhDrYUOWmzzk0Ghmw8zAcZOY1vc1B42+5fLXNtm17zH30a4m2eHfGYfNnpopIp
         fQlQ==
X-Gm-Message-State: AC+VfDxbmRPgiiixl6MEGYksG71zaqy8qNd4sl8rcZsJaiUpHt3syPqP
	t2HfMh0b7i/nnFgLQS0CPpQHl/0/tgDw//zYoXMTJA==
X-Google-Smtp-Source: ACHHUZ7h4h+9PyZ22aZB1wo+fT0jNE21j9lNod6Q/rls/FMw+gPrIjUjTq9Romr3iGv0l9Ylpgcc+A==
X-Received: by 2002:a17:90a:4e4b:b0:253:e0cc:50aa with SMTP id t11-20020a17090a4e4b00b00253e0cc50aamr9276586pjl.3.1684807256373;
        Mon, 22 May 2023 19:00:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ch9-20020a17090af40900b0024df7d7c35esm4684560pjb.43.2023.05.22.19.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 19:00:54 -0700 (PDT)
Message-ID: <646c1e56.170a0220.aa4b6.8459@mx.google.com>
Date: Mon, 22 May 2023 19:00:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip33-11-gfea7994097935
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-timers: 10 runs,
 11 regressions (v5.10.180-cip33-11-gfea7994097935)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 02:01:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11605

cip/linux-5.10.y-cip ltp-timers: 10 runs, 11 regressions (v5.10.180-cip33-1=
1-gfea7994097935)

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
n...6-chromebook | 2          =

qemu_smp8_riscv64        | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =

rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip33-11-gfea7994097935/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip33-11-gfea7994097935
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      fea799409793527f9b9b2d2c53f0dc4e3ac7ac6a

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/646c12e858b6686e432e8645

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/646c12e858b=
6686e432e864a
        failing since 6 days (last pass: v5.10.177-cip31, first fail: v5.10=
.179-cip32-4-gd8c029e4780f) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/646c12e858b=
6686e432e864a
        failing since 6 days (last pass: v5.10.177-cip31, first fail: v5.10=
.179-cip32-4-gd8c029e4780f) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/646c154fe376a228582e85f0

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/646c154fe37=
6a228582e85f5
        failing since 101 days (last pass: v5.10.165-cip25, first fail: v5.=
10.167-cip26) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/646c154fe37=
6a228582e85f5
        failing since 101 days (last pass: v5.10.165-cip25, first fail: v5.=
10.167-cip26) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/646c1652e08c79ceb22e8636

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/646c1652e08=
c79ceb22e863b
        failing since 199 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/646c1652e08=
c79ceb22e863b
        failing since 199 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_smp8_riscv64        | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/646c142247b5183b6c2e85f5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qe=
mu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qe=
mu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30512.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/646c142247b5183b6c2=
e85f6
        new failure (last pass: v5.10.180-cip33) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/646c1720291ea4a7f52e8603

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/lt=
p-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/lt=
p-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/646c1720291=
ea4a7f52e860e
        failing since 3 days (last pass: v5.10.179-cip32-4-gd8c029e4780f, f=
irst fail: v5.10.180-cip33) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/646c1720291=
ea4a7f52e860e
        failing since 3 days (last pass: v5.10.179-cip32-4-gd8c029e4780f, f=
irst fail: v5.10.180-cip33) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/646c14101ad117e6492e8635

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/646c14101ad=
117e6492e863a
        failing since 199 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/646c14101ad=
117e6492e863a
        failing since 199 days (last pass: v5.10.147-cip18, first fail: v5.=
10.147-cip18-12-gcb2b164780be) =

 =20

