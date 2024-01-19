Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3971C47DD6
	for <webhook@archiver.kernel.org>; Fri, 19 Jan 2024 01:32:43 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web11.11605.1705627958710117188
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 18 Jan 2024 17:32:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=x06ZuDOS;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6db9e52bbccso228172b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 18 Jan 2024 17:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705627958; x=1706232758; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BhzWHY6Pasw8o3offctZEpVEvLweVilPPttaFQD2GT4=;
        b=x06ZuDOSIau907Lx3B4ILFQayRwnUn/DCLIxiTriz1IOwxDnIk7ZYi79P9sGCJMXqq
         MRVLqoijsRIJxFWxlrjz4hs2THDrzMDYr1cWWrqCw65PdodmjCtfzw/lUBaouQ2/YHOE
         kMC8yjHhkvGz4iwFLmgKVeu+gn3rwx3wd7mnzN8xL2jflYBDCIEMwX3LvWTUob51xE+p
         YhBya8Lh3Qe6ljEG5DPzpSmKGE5Orun4jZYqWEbQOlI6gqEkmICFo3KfluS8LuQ5Xf7E
         eE/bG5a5zcoKc+ZEMqAU5H2vWionvanE89mEykcCtwQ7s17jfge7x62Z3yvdzFTSP6PR
         92bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705627958; x=1706232758;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhzWHY6Pasw8o3offctZEpVEvLweVilPPttaFQD2GT4=;
        b=Y3RWP3Gfy/mnPflDnuTflkMib+RYi+mX6crFF5Yl78WKDRNsT3KoADvu2+wR8ZObRC
         IVKbyqBkzBru08FVN46jmjrUTHUYs8V4VjZeh8SrmVvWyXaO5T8HGJRLZ0Om5x/FGOTM
         cHh13qdGxHNsiD6Qc1TGlQvbx72ABTLalNcrsYTG6s+3KkGe3OiXVFtPW57BicuMzhL0
         AkjPIsWteXSW1Yxy5jOKbNg9OlZtmnPol6PxcUltmjAJDyovOuxAKHZGiIgG4G5D9lG5
         mmZEZrXnpKL06CEo659RoOx+hcp4JEiztl3QrFtcnWQk9zI5i7Gi2ja5Z8ZPmUJrIUc1
         kVng==
X-Gm-Message-State: AOJu0YxIgbjKonZJF20zswGnc8erfvQnapUtDEi9wQoKhB0Hq9kpGA8c
	qiMGjeG3DcRgeWJm3z9q9Md2wxrzdKaQ8FNapH4tI2KS5BCtm7BwsSuCLqsaNrSYqy7TpGTPfsh
	DG30=
X-Google-Smtp-Source: AGHT+IHxHSzDsdRWdx3MiZpgS4Lu9KdkIjbD9Q5l0sjElBMl7/siY+jy156ccnByvYSGjnw0Q4awxQ==
X-Received: by 2002:a17:903:1ce:b0:1d6:f295:bc46 with SMTP id e14-20020a17090301ce00b001d6f295bc46mr2184514plh.63.1705627957778;
        Thu, 18 Jan 2024 17:32:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902d3c400b001d6f4d7ed1bsm1972020plb.296.2024.01.18.17.32.37
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 17:32:37 -0800 (PST)
Message-ID: <65a9d135.170a0220.53ed3.9ced@mx.google.com>
Date: Thu, 18 Jan 2024 17:32:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v6.1.72-cip13-30-g79e2886a5da69
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 12 runs,
 2 regressions (v6.1.72-cip13-30-g79e2886a5da69)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jan 2024 01:32:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14418

cip-gitlab/ci/pavel/linux-test ltp-timers: 12 runs, 2 regressions (v6.1.72-=
cip13-30-g79e2886a5da69)

Regressions Summary
-------------------

platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.72-cip13-30-g79e2886a5da69/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.72-cip13-30-g79e2886a5da69
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      79e2886a5da69a8a86ec82215b5e9e0748943546

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/65a9bf5da2ae6c219a52a3f6

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/riscv/defconfig/gcc-10/lab-broonie/ltp-tim=
ers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-30-g79e2886a5da69/riscv/defconfig/gcc-10/lab-broonie/ltp-tim=
ers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65a9bf5da2a=
e6c219a52a3fb
        failing since 36 days (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6=
, first fail: v5.10.201-cip41-77-g545d45774209f) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65a9bf5da2a=
e6c219a52a3fb
        failing since 36 days (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6=
, first fail: v5.10.201-cip41-77-g545d45774209f) =

 =20

