Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ED2EB64DD
	for <webhook@archiver.kernel.org>; Tue, 11 Jul 2023 15:02:58 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web11.1948.1689087778360483439
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Jul 2023 08:02:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=30qeTeiV;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-51452556acdso4026526a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 11 Jul 2023 08:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689087777; x=1691679777;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JolN7HqF7gKYr04QtHi/N6B4ULYLULlq2Ed7XfPmJSU=;
        b=30qeTeiVKWQTm3GXK7AjxWN1YMimjsWLq73NJXseY/wV0egXKH03+f+pTyeOtR+d2W
         wzb7EQNw6+Loxibh6rwG+qjVQEFSwrMM4PhsUnVgqheabAiM31+69+lV2EnMG0685sIF
         H2xmIRvZIxI3jhC1JOQkdtyA2VBv6iokk+GBHMsm4koINEUIulgizO6npVhbdzYBBam3
         smS4PaPzs2xzHuP6FmElL44/pZ3/tlPNrwgLY6huitVRIMzoL9jnZ5/ju7oVhwmlXoRJ
         0sYDJQDt6SgW0Olwj0KXOjLj4tjfjPkLW/8nT2d3AAnFG86lDO8xUP5TobFmSnufbE8K
         5wLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689087777; x=1691679777;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JolN7HqF7gKYr04QtHi/N6B4ULYLULlq2Ed7XfPmJSU=;
        b=YmsRZElSFf/+7K6bAgUzldB0ogfh8I3WcFuNZgfc3e8dJl5r5XPpwqXUppEv6UehIA
         NsDV2bnJYN3zQ2yITngXDvqxtKB3Z+XPAuR04p6BcYR7RZ7iSbSwMOde1OP+d5isjPoD
         VKcqnfwVXKjXOhM17h4Tl9Aw3ekm/y2cZjUn5cNxNx2vxh2XT1cXTeFd/7QXZE2zZTle
         9dlQkMAKEyWajUATvuQoL5mA8rapxj/7xge0kRBlfLQJRuzrtQ1krmBw5tsXpjJf/GAm
         bHR/jZGH6erVQOmwvQFR4UY6Nvr70Zc2KoZ1ZZ2JYerhuCOeY6ZuPFVhVUIhc0Bj3iMR
         pV+w==
X-Gm-Message-State: ABy/qLZrnPGfpZL1bhCphYtEJPjRR79/KgdpdKPYGMcfDCjjnu5dz99p
	V6DGI2SIa35eCIOF3K20/T6FschcpBlPfzPwGO+C1Q==
X-Google-Smtp-Source: APBJJlFApxI9O2Naa6lsUk1U/3LTGDpEB0EO5QOdF/l6brVm5dd11aNb/+sMj5y46SqpwD1yX5WKUA==
X-Received: by 2002:a17:90a:6748:b0:263:5c6a:1956 with SMTP id c8-20020a17090a674800b002635c6a1956mr12267411pjm.25.1689087777247;
        Tue, 11 Jul 2023 08:02:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090a0f8e00b0025bfda134ccsm2090829pjz.16.2023.07.11.08.02.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:02:56 -0700 (PDT)
Message-ID: <64ad6f20.170a0220.791e.41d7@mx.google.com>
Date: Tue, 11 Jul 2023 08:02:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.184-cip36-13-g8201543bbc8b6
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs,
 5 regressions (v5.10.184-cip36-13-g8201543bbc8b6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jul 2023 15:02:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12313

cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs, 5 regressions (v5.10.184=
-cip36-13-g8201543bbc8b6)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_riscv64      | riscv | lab-broonie   | gcc-10   | defconfig | 2       =
   =

qemu_riscv64      | riscv | lab-collabora | gcc-10   | defconfig | 2       =
   =

qemu_smp8_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.184-cip36-13-g8201543bbc8b6/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.184-cip36-13-g8201543bbc8b6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      8201543bbc8b67c2cfc76e71fda24c2e1f8a7920

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_riscv64      | riscv | lab-broonie   | gcc-10   | defconfig | 2       =
   =


  Details:     https://kernelci.org/test/plan/id/64ad627320d6f76a98bb2a90

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/riscv/defconfig/gcc-10/lab-broonie/ltp-t=
imers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/riscv/defconfig/gcc-10/lab-broonie/ltp-t=
imers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64ad627320d=
6f76a98bb2a95
        failing since 19 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64ad627320d=
6f76a98bb2a95
        failing since 19 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b) =

 =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_riscv64      | riscv | lab-collabora | gcc-10   | defconfig | 2       =
   =


  Details:     https://kernelci.org/test/plan/id/64ad61714de2a73f4cbb2a97

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/riscv/defconfig/gcc-10/lab-collabora/ltp=
-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/riscv/defconfig/gcc-10/lab-collabora/ltp=
-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64ad61714de=
2a73f4cbb2a9c
        failing since 19 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64ad61714de=
2a73f4cbb2a9c
        failing since 19 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b) =

 =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/64ad64cb909f500e92bb2a75

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/riscv/defconfig/gcc-10/lab-broonie/ltp-t=
imers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/riscv/defconfig/gcc-10/lab-broonie/ltp-t=
imers-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/64ad64cb909f500e92b=
b2a76
        new failure (last pass: v6.1.31-61-g32a95f5a4e3b) =

 =20

