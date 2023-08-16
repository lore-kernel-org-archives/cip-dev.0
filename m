Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9F5C04A6A
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:21:39 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web11.161777.1692195691209994864
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:21:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=ToW8OfV1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-68879fc4871so880674b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Aug 2023 07:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692195690; x=1692800490;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OlNLavuShc3O/U7UN2qBRXQMSxOT9Tki5eEkSTMcoOA=;
        b=ToW8OfV1BZ3bsRgPPdjNOzdjTTffVrdEZkmo5Y/VFxcAyNv8QaXvyMNJyY0k02DG2t
         KhrKag8yGqTPcnpY5JrTZCH49HcAnA56244Jklwm2+04Cjp7ttMV8J7DWYTsMoqXgO2W
         RoJIbI1h9j9yjxyVmEdPhqdDTmjgh9X/71z+MuXDzOK6f+0bAneioStelrgH5um6K1WQ
         HhpDBrKmndgC0avSyrOuLz5mWtq+vh3tiPGzM3Xg6poCIrn3tlrvFkpsME3M3ChFIqqB
         4hF7XHRfwgMKWTCZPME66EOft22hcm/g54yowh79OMw3PT21Jfs7ggu4XFh01uOEpkMB
         ExVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692195690; x=1692800490;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OlNLavuShc3O/U7UN2qBRXQMSxOT9Tki5eEkSTMcoOA=;
        b=Gqn0UebTQxzotVavpJz45Qxm6vW0gqJgBKTma77dPyTKIFgY4MZFyCidcmaatpwoM8
         GCWxtivlW5LFUEycA8fmSoMMddc3+Q884l9s0qrlMkWGA+qBW7ap/tHX/CK7N/SV2fHA
         +8ecO4lm7HNl1d0D8I7FjuLm9eGiwPAeaXIFNsT4bG3lDOWB9vbXHWsl6PKg6W2OU7wQ
         RNT1Q/5I5kSFICSgIFYc3q7U15EVwo0RosPw2AfHbze+iZ8H0dFsAeJVGfCL3QRECoI5
         2dcpRcnDihRxum5qC3tGd7tN42IcdtSYK3M7QHyZFlBgBV4Rfx7qyzOVbrHpe29ixegR
         EAQQ==
X-Gm-Message-State: AOJu0YyQ2n+mqjy93yuYQ9g9UHLMWettq/Oi2AAlkBntcH+8fCuCNK2X
	dEpLjWqLTFWE/QXo5/uAjmtatFRDvYzCN+qCtIgp4Q==
X-Google-Smtp-Source: AGHT+IG6UPuMmFrLZBp1o0lrJrhCJkMFL+ZNfPJ+z1y3oCZkvqpTAPYwyq06qSY8mtX30ohVKR423g==
X-Received: by 2002:a05:6a00:23cd:b0:687:4fcf:8fcd with SMTP id g13-20020a056a0023cd00b006874fcf8fcdmr2372256pfc.18.1692195690112;
        Wed, 16 Aug 2023 07:21:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78159000000b00686f082cc0fsm11131383pfn.106.2023.08.16.07.21.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 07:21:29 -0700 (PDT)
Message-ID: <64dcdb69.a70a0220.b1956.4525@mx.google.com>
Date: Wed, 16 Aug 2023 07:21:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-16-gf8567732a40d
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs,
 3 regressions (v5.10.186-cip37-16-gf8567732a40d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:21:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12712

cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs, 3 regressions (v5.10.186=
-cip37-16-gf8567732a40d)

Regressions Summary
-------------------

platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_riscv64      | riscv | lab-broonie | gcc-10   | defconfig | 2          =

qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.186-cip37-16-gf8567732a40d/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.186-cip37-16-gf8567732a40d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f8567732a40de26cd92366e14e0f9857935fd92d

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_riscv64      | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64dccf61bd8c6d800835b1d9

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/riscv/defconfig/gcc-10/lab-broonie/ltp-ti=
mers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/riscv/defconfig/gcc-10/lab-broonie/ltp-ti=
mers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64dccf61bd8=
c6d800835b1de
        failing since 71 days (last pass: v6.1.26-1298-g61395b9756bd5, firs=
t fail: v5.10.180-cip34-26-gc198172c84b6a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64dccf61bd8=
c6d800835b1de
        failing since 71 days (last pass: v6.1.26-1298-g61395b9756bd5, firs=
t fail: v5.10.180-cip34-26-gc198172c84b6a) =

 =



platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcd3ad41f90a6b0f35b1fb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/riscv/defconfig/gcc-10/lab-broonie/ltp-ti=
mers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-16-gf8567732a40d/riscv/defconfig/gcc-10/lab-broonie/ltp-ti=
mers-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/64dcd3ad41f90a6b0f3=
5b1fc
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b) =

 =20

