Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F853C7EE29
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 13:44:21 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web11.297.1686059060992790487
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Jun 2023 06:44:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=blPfkmZn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.174, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-53f8da65701so3170206a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Jun 2023 06:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686059060; x=1688651060;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yx2V4gXMUruSeLYfXK/imZ5RVMXfNqL4S4+y+9Ennyg=;
        b=blPfkmZnmpc7j619062DqF4KO5N5M4msrR9pasd8sPPFfm+fCOa9jQfQmsW0wroJu7
         a2/abStHaJskXR1cI2gX7u0bH0unTZd7JGfiF+qP/OMALhoQIhixEMrOfkZCFqNXsznN
         7MBYeg2tFK/9jPZpDQxHzEnfvC0S+s3RHWhMrIt4OqR2EH1HC1/Uyq5ZyllCo/yzHO/S
         NgkPZ3esG6lfMAkgqyTq5eN+30BC/ISrRx8GcGhmwBhr10RNh4iYHDvfNxNI6f/ndoAn
         vVse4IyxtHZsaMp+3lgUbMJH37mNKLkfm6DY9d5bVE58Ae1olTyETZpQx53Im+fmv0P7
         aR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686059060; x=1688651060;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yx2V4gXMUruSeLYfXK/imZ5RVMXfNqL4S4+y+9Ennyg=;
        b=l/RhrP1mUHhLAEcDySdUPcxPhu1AW9/aYp8MhgH0UAjvCuyLQV0DJLSJekqZaULM0o
         KApiEIMGl4MsSuhHDHx8ZUo93/PJtxwAPnzJDCQqJJ2rlNsVKeJN3QZ9esuq62G9FzaZ
         uUvGhBJ2FLV6BhMsJF/c72nBcZpux1gc+KSe6Nf4U6uVYwdKedatd7RLJec/66Ooiiwm
         HrwaL2/rZLZV27Lzy6CGtpAqKcX4t07qniqUZ8tsV3gq4F1l6wsVdYa/Qakp3iYRB0dt
         zHGcb6DfqKa4lKnytW+Vv18/Wzb91cjqi7wj1J5d95n3WIMOxNnsD8mPaQrbPVGCXKCs
         Gvyg==
X-Gm-Message-State: AC+VfDyJKQqMl5iXoNW+xbZbQUm2fJxnSL+ettCem8FXnZtIJq+K4Afx
	SSYEG/s3wQrS6aozTV20+ovUZnyShwd9UKLxwZc9EQ==
X-Google-Smtp-Source: ACHHUZ6SPZmDDA7Ee8lFANimHISHQbge+LvPrZyGdaVKDgCjEWWcPd5Z24D7Piz9cVyhMKc1gl9wIg==
X-Received: by 2002:a17:90a:1a05:b0:256:8a87:f02e with SMTP id 5-20020a17090a1a0500b002568a87f02emr980613pjk.4.1686059060038;
        Tue, 06 Jun 2023 06:44:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j4-20020a17090a908400b0025695b06decsm7674966pjo.31.2023.06.06.06.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 06:44:19 -0700 (PDT)
Message-ID: <647f3833.170a0220.f2319.d693@mx.google.com>
Date: Tue, 06 Jun 2023 06:44:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1320-gc38e4a9845945
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-6.1.y-cip ltp-timers: 12 runs,
 7 regressions (v6.1.26-1320-gc38e4a9845945)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 13:44:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11890

cip/linux-6.1.y-cip ltp-timers: 12 runs, 7 regressions (v6.1.26-1320-gc38e4=
a9845945)

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

rk3399-gru-kevin       | arm64  | lab-collabora | gcc-10   | defconfig+arm6=
4-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.26-1320-gc38e4a9845945/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.26-1320-gc38e4a9845945
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c38e4a98459459f32d3c7c627ff35defa2415935

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


  Details:     https://kernelci.org/test/plan/id/647f26b3aedd7cd606f5e04a

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
20-gc38e4a9845945/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
20-gc38e4a9845945/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647f26b3aed=
d7cd606f5e04f
        failing since 0 day (last pass: v6.1.26-1281-g84d5372e0f314, first =
fail: v6.1.26-1314-g1ab0ac1d7e2e3) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647f26b3aed=
d7cd606f5e04f
        failing since 0 day (last pass: v6.1.26-1281-g84d5372e0f314, first =
fail: v6.1.26-1314-g1ab0ac1d7e2e3) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
qemu_riscv64           | riscv  | lab-broonie   | gcc-10   | defconfig     =
               | 2          =


  Details:     https://kernelci.org/test/plan/id/647f2bc1f07fb57cf3f5de40

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
20-gc38e4a9845945/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_riscv6=
4.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
20-gc38e4a9845945/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_riscv6=
4.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30527.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647f2bc1f07=
fb57cf3f5de45
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647f2bc1f07=
fb57cf3f5de45
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
qemu_riscv64           | riscv  | lab-collabora | gcc-10   | defconfig     =
               | 2          =


  Details:     https://kernelci.org/test/plan/id/647f258929dadd34c1f5de27

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
20-gc38e4a9845945/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu_risc=
v64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
20-gc38e4a9845945/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu_risc=
v64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30527.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647f258929d=
add34c1f5de2c
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-06T12:24:26.491465  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647f258929d=
add34c1f5de2c
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-06T12:24:26.491465  =

   =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
rk3399-gru-kevin       | arm64  | lab-collabora | gcc-10   | defconfig+arm6=
4-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/647f2f780349f1d484f5de3b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
20-gc38e4a9845945/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp=
-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
20-gc38e4a9845945/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp=
-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/647f2f780349f1d484f=
5de3c
        failing since 0 day (last pass: v6.1.26-1298-g61395b9756bd5, first =
fail: v6.1.26-1314-g1ab0ac1d7e2e3) =

 =20

