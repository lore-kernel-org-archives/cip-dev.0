Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9C1C636D4
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 00:19:02 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web11.122239.1700785136716724112
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Nov 2023 16:18:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=bA03ugqy;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-280260db156so1177294a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Nov 2023 16:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700785135; x=1701389935; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wrUg2YrgQsSbVy53ShyAHVdqTpN9u4Y9aSWtStpyi08=;
        b=bA03ugqyB4l3/JLFUDgmJWM0sHG+tph/n9Zi3k7wmxIxuCH6C/RolzyVta34DNYrP6
         BJbesCgkV7hPZr1jn8SmFQITIhYt99COyz/xyMpAGfm9wO/g6StCa6xSeLCWru62lMUF
         xYazhv2qePmW9Dxr3W9oxnyowH0u+jBqmw7v9TPPcITP53dgqpM+gwcPqghh7K8U4t2E
         UuczGVBtUBqcT+LL1b6YQXZ4WbXPZlT3QeGEbW1pVqabm7uUsGa/vllumzVsMV7/TwF6
         0+1fBokab2CItiCAIoSQuDz/0M+ABoP2usfc8FO6xqQ65XIhRT2y6o2nLu/VjLKlWpQY
         rPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700785135; x=1701389935;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wrUg2YrgQsSbVy53ShyAHVdqTpN9u4Y9aSWtStpyi08=;
        b=LazhfwjyVY2ITzsoYkZ0Jmym3Rz0zeTNqVHLNgIj7zTrwlJj0zwRe+AGdh67p3jjaW
         wW+05k7c6YualI1QWQItlkwY2b8+FiSQ58WekvvrYTQ0n0oy6OhRt1eDijk0Ns+haFic
         OxPblBtXQqX8GrpbyxbpQj1Qrr5iWq6tjdgbk+QsZkJc/YQ/Prz2VW6k1+3moFT2rGsM
         Ia32LopT0g3FGDaC5PxeZGrjRcMOxBTfzAFNz+R6OGG5l8HXyaR7Am3x2haM1gKZJBpG
         A3eJk2N+e1CwvsM2CuV+ApDRRDNjLwsEEMTml3kpKuehQXDPlEco+y8HpfrgqJWCGxyr
         10jA==
X-Gm-Message-State: AOJu0Yz6GlPIPwEE59omfHo7pA/InPpdD8ELly00KcTy50bFDk72gzSY
	btPe1xeK14hYbAEtoTp7RjfKTwQipK+R7hpylQ4=
X-Google-Smtp-Source: AGHT+IGBN/+M/qCBv9Bzl0t/nePMli+KtQ2JKerNGx4WtWVgNHt/qxPPTP2UgpzUpwfar/dHpXbsbw==
X-Received: by 2002:a17:90b:4f44:b0:285:8d5b:631f with SMTP id pj4-20020a17090b4f4400b002858d5b631fmr9522pjb.5.1700785135624;
        Thu, 23 Nov 2023 16:18:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090311cf00b001cf66056a1bsm1929650plh.97.2023.11.23.16.18.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 16:18:52 -0800 (PST)
Message-ID: <655febec.170a0220.6c895.4f6c@mx.google.com>
Date: Thu, 23 Nov 2023 16:18:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.201-rt98-828-g27523c64bc5dd
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 14 runs,
 4 regressions (v5.10.201-rt98-828-g27523c64bc5dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 00:19:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13698

cip-gitlab/ci/pavel/linux-test ltp-timers: 14 runs, 4 regressions (v5.10.20=
1-rt98-828-g27523c64bc5dd)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

qemu_riscv64                 | riscv  | lab-broonie   | gcc-10   | defconfi=
g                  | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-rt98-828-g27523c64bc5dd/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-rt98-828-g27523c64bc5dd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      27523c64bc5dd6f1af1b227b80017fea69e616b6

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/655fe2d96c36db492c7e4a94

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/655fe2d96c36db492c7=
e4a95
        new failure (last pass: v6.1.58-cip7-132-gb38ea1474c159) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/655fdf117e9b8682317e4a6f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-broonie/ltp-t=
imers-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-broonie/ltp-t=
imers-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/655fdf117e9b8682317=
e4a70
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_riscv64                 | riscv  | lab-broonie   | gcc-10   | defconfi=
g                  | 2          =


  Details:     https://kernelci.org/test/plan/id/655fdb7edcf250897b7e4aae

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/riscv/defconfig/gcc-10/lab-broonie/ltp-t=
imers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/riscv/defconfig/gcc-10/lab-broonie/ltp-t=
imers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/655fdb7edcf=
250897b7e4ab3
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/655fdb7edcf=
250897b7e4ab3
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305) =

 =20

