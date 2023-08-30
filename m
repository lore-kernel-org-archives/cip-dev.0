Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A052EC6FA8F
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 09:01:41 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.9664.1693386091819399203
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 30 Aug 2023 02:01:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=yOYj3mT2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1c1f7f7151fso16264305ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 30 Aug 2023 02:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693386091; x=1693990891; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9c4Gw4JQVD5yUAMMpZDWiZEGsZO1MGRKAZ3u/KKTpiI=;
        b=yOYj3mT26WWvnV+Axn5qJgDS7taYsrphnJTNet5qBgrBEZTCy3KzcafJFV624aJFP4
         xI6msNNektuZY0KDbf1TxS6ayBs9R7o6ZzwKCNUra8fSctaIFNnsJuROszcKF0lp9znE
         09HdD1EsBEgCDfHrRwpcf+z/LH2lgNlSevfzRcEiaLMOWPtkastTHn0atzAkNO4oOaH0
         Ux07+sJGpiGGCXWpUICtCw0cckbv0M8sta1HrSOQusIPi0bcw12GDmKs9ROITYXqzaB8
         llIbDjZhKAQWGJp58p7wGiEsxRvSbpg1+T0BzopSQuSNrmMwxVSHOMsTL1aH3wFf1j1L
         /2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693386091; x=1693990891;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9c4Gw4JQVD5yUAMMpZDWiZEGsZO1MGRKAZ3u/KKTpiI=;
        b=dco9yRzRRqPw4S4ogju5ps8whVij8jcS25Z7C11xwi+Jukv1jMRI3wTZupEIXBtYF1
         cyICwq2IgVJffMpFvEAMiU0Ar9f7M0QMc1EAIsT5m0tvurzsrXttoNP6yMajYH7ez5dG
         GTk99gSq9iMRl050/48Os7AwEiWUeLz3Ixo1c1cTDV+qW2RgXU3NvvAjC7xE8/5xAXP3
         E7ebqSyv/4X3vWyTFe5KjvRWwUwMjrOSUghZh3B1XWnHu2xIpYpseur+WwPv6qlBJsdy
         RdVvr8iIJp4JbJrdHnSSn8eM1yuqnaWG1tbR/oG3fGKY25w6qSzNUWKmnBoK+WRVBtCt
         DcFQ==
X-Gm-Message-State: AOJu0YweNSxtVscHcPuGICwjg2fRteYeEEcKOGGOqDnj//3l000+Ym9U
	Vha+p4PX87iEPet48TlDMq1irtPbeZ7SZHZkFLA=
X-Google-Smtp-Source: AGHT+IG2x0axALIngAgYm7o6u5QYGGG8Ra/pGX4hz9NjrxMlwnwXt+doyItY+DXWwjpXu8iqRP+61Q==
X-Received: by 2002:a17:902:ec84:b0:1b9:de3e:7a59 with SMTP id x4-20020a170902ec8400b001b9de3e7a59mr1724390plg.10.1693386090682;
        Wed, 30 Aug 2023 02:01:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e19-20020a170902f1d300b001a5260a6e6csm10705859plc.206.2023.08.30.02.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 02:01:30 -0700 (PDT)
Message-ID: <64ef056a.170a0220.2930e.30e4@mx.google.com>
Date: Wed, 30 Aug 2023 02:01:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.191-cip38-2-g09e5ecd8645b
Subject: cip/linux-5.10.y-cip ltp-timers: 8 runs,
 2 regressions (v5.10.191-cip38-2-g09e5ecd8645b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Aug 2023 09:01:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12912

cip/linux-5.10.y-cip ltp-timers: 8 runs, 2 regressions (v5.10.191-cip38-2-g=
09e5ecd8645b)

Regressions Summary
-------------------

platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.191-cip38-2-g09e5ecd8645b/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.191-cip38-2-g09e5ecd8645b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      09e5ecd8645b66c95202559dbcf24b99bdfa5a85

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64eef02d9c67145c47286d6c

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_r=
iscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-2-g09e5ecd8645b/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_r=
iscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64eef02d9c6=
7145c47286d71
        new failure (last pass: v5.10.191-cip38) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64eef02d9c6=
7145c47286d71
        new failure (last pass: v5.10.191-cip38) =

 =20

