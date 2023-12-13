Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C78C4167B
	for <webhook@archiver.kernel.org>; Wed, 13 Dec 2023 10:22:51 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
 by mx.groups.io with SMTP id smtpd.web11.32788.1702462965693229736
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Dec 2023 02:22:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Ja4Qomys;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.174, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3b9e2a014e8so4698255b6e.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Dec 2023 02:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702462964; x=1703067764; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/SuLjMMB7hM38EaGW05hBh6PAMxjDM+R+rmLT0VmYpA=;
        b=Ja4QomysgSFWznciJzNuJVm2hiugM3yVu95rigDOEGGN1vtF6TCJxDrK9NcH89h4md
         rRlNJVVqdGV35zjYP/e3dYlw3nKWEIL+UwtxddQMajCDg/kc8fJxKL7nPVBh1BQnsbHn
         SJYijuQAUfxuVaisOs9BkL623fmRdtqeGLQLkK/OKMfIFGY0xwe+C8QaPyTTaMSOKxZE
         0J/dqMS3nMe4VAM2N5UVpo2JJaru4iTtDZGagkhPEY0WNVuSDoSUs8g/OhEoktUJZfdN
         bC5+nPRuN921z4Zf2f19xjYDy8wt/T2ghbx5DWuz7sxuPaPr2DgRP3Z3CThFcQ2YVI2Z
         ZuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702462964; x=1703067764;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/SuLjMMB7hM38EaGW05hBh6PAMxjDM+R+rmLT0VmYpA=;
        b=UJGhyI76WYOUgOG/5lDwZn7rtlsrviifb3xedjlyIuNmmpNkRmn/4JFpKw7eGG8gf+
         lBdMj1kxZhJo0zOH+b9njm4dhd3X86gwK3SqdMaDSX7nhpqGN7c2voposeCimjOvpbLD
         XyWatLLbnSn/+E6OuU9DIvMpnLra8TzNKGQd6NbVAfLqwhHaps9mnenU9fhMcsOdPc4p
         aq3pAttsNvVBNnW06jmFgFTK7PB/pK0lH0QAq6UXohXPOZ0NZVQPQMWDFlBcn4gEV8dE
         pK2YKfOybXVczkGS03cV67ZY26sSPbFg7VsHpe8dj7WSPIQ5ER2NzIUHqWLm+RbHZr0a
         weYQ==
X-Gm-Message-State: AOJu0YwiXuVn3HYGHWfeR1VTik0hXJBsBzhd8pjWm9rtXZnTEiUK3hUi
	YkxLbANhiHaXQv42MJfShaHRHsJFWzyD6uKyBVzuuA==
X-Google-Smtp-Source: AGHT+IEjblDj0P+W7zbbAhFvPGeinGGVRMm91KlVO/f5DZjq+mXhoi1WwlzBPxxci1Aiwu39lg8dMw==
X-Received: by 2002:a05:6808:23d4:b0:3b9:dcf0:63b9 with SMTP id bq20-20020a05680823d400b003b9dcf063b9mr10847688oib.23.1702462964469;
        Wed, 13 Dec 2023 02:22:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902d34900b001cc131c65besm10263264plk.168.2023.12.13.02.22.43
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 02:22:43 -0800 (PST)
Message-ID: <657985f3.170a0220.2c317.e927@mx.google.com>
Date: Wed, 13 Dec 2023 02:22:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-77-g545d45774209f
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 7 runs,
 3 regressions (v5.10.201-cip41-77-g545d45774209f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Dec 2023 10:22:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14066

cip-gitlab/ci/pavel/linux-test ltp-timers: 7 runs, 3 regressions (v5.10.201=
-cip41-77-g545d45774209f)

Regressions Summary
-------------------

platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_riscv64      | riscv | lab-broonie | gcc-10   | defconfig | 2          =

qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-cip41-77-g545d45774209f/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-cip41-77-g545d45774209f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      545d45774209f8cd48179f8431020b19faaeef38

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_riscv64      | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/657979cdfee212ee90e13476

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/riscv/defconfig/gcc-10/lab-broonie/ltp-t=
imers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/riscv/defconfig/gcc-10/lab-broonie/ltp-t=
imers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/657979cdfee=
212ee90e1347b
        new failure (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/657979cdfee=
212ee90e1347b
        new failure (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6) =

 =



platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65797cd2a786295849e13484

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/riscv/defconfig/gcc-10/lab-broonie/ltp-t=
imers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-77-g545d45774209f/riscv/defconfig/gcc-10/lab-broonie/ltp-t=
imers-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65797cd2a786295849e=
13485
        new failure (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6) =

 =20

