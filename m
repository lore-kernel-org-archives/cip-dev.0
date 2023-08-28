Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A8AC83F11
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 14:59:49 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.16312.1693234780553242813
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 28 Aug 2023 07:59:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=RsvPcxZE;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1bdca7cc28dso26094505ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 28 Aug 2023 07:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693234779; x=1693839579;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cq6ubzLtNAq220bK1XdmDv/miHKrTB1Ej6Lgi65e+lA=;
        b=RsvPcxZEhoh5uHYRLRVfZS+qqDua3vNWTnvl76bIXywfy95FblfU4uX5JJQyyQ+EAS
         W+uVo/emATuhqhkr3o9tVTw/65gmURMmt0iixOUSGI4+Fi3CdBRZRq7Y6nACOorv8Zez
         CyX+ifZ6zLlGei6Opqf1PvnQqsHEHLMwLIyDEf6MriAfnsozEXamNbOFW5vWm/ca2t5w
         eeiza320T326HrWyVmDRSvf1bVEAr2IPlDrrJffV063+dOY89lWafahDPngtt/i0g1kO
         sAa+pLEnmwqxTHtP+3GlZ1bIucm8L/ZeQz8GMj1ZSnURm+F44HiVfCftiCLANT2MaF7X
         E9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693234779; x=1693839579;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cq6ubzLtNAq220bK1XdmDv/miHKrTB1Ej6Lgi65e+lA=;
        b=NaobjNEarWzwWArQACtF8b3Lg56w1vzPvu6dBbAtLSNmM/m1/lqM3syeZFC4LOnNVc
         Is76I2pZfmU64p0BKk08RjYfrhR5BT6CR0vY0ttPY1Jg2QuPSOti3D6W2BVZHZGRyDZK
         f45Rp63+LsvGR9Mt1tYhjdmcv6L2IruW+G1/hPI8LmNBdJ7/oEx75itl+7iCTNVLn1it
         iyKzYCuA+1XD41J+SJcKcZ9AcpmCLvYbkzzTeZBmVW947FCHzdU32uVG0ivBqp1ka+d7
         gqKG7ZKS983W8baVtmBkv3oSyULwjyStLiJbWx+C6wfm/1uMvPkyprLc5r4CxQXwk6+d
         nSfA==
X-Gm-Message-State: AOJu0YwQMtiGd43FP4lvy6Z9pv6l9qlQL3cDg4eJqYzgQUlYwxmr+Tic
	d7+thJttmF+Q9J17vs/LAdFdFzcsY+4bv30/OsM=
X-Google-Smtp-Source: AGHT+IHqeQ+EcTTOse4abSNq48k8/XGGxsqcgsZbsMoLOFHafj84F7sp4YyWxvNNwbITJbl0DmuDaQ==
X-Received: by 2002:a17:903:264d:b0:1bf:364:f013 with SMTP id je13-20020a170903264d00b001bf0364f013mr22360289plb.45.1693234779306;
        Mon, 28 Aug 2023 07:59:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902d68b00b001b8b2fb52d4sm7479648ply.203.2023.08.28.07.59.38
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 07:59:38 -0700 (PDT)
Message-ID: <64ecb65a.170a0220.a18be.bf17@mx.google.com>
Date: Mon, 28 Aug 2023 07:59:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.46-cip4-rt2
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs,
 2 regressions (v6.1.46-cip4-rt2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 14:59:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12890

cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs, 2 regressions (v6.1.46-c=
ip4-rt2)

Regressions Summary
-------------------

platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.46-cip4-rt2/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.46-cip4-rt2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c4800588c47085de12fb82c4790e49fdee561258

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64eca7d46a985a970f286d74

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_riscv6=
4.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-rt2/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_riscv6=
4.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64eca7d46a9=
85a970f286d79
        failing since 83 days (last pass: v6.1.26-1298-g61395b9756bd5, firs=
t fail: v5.10.180-cip34-26-gc198172c84b6a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64eca7d46a9=
85a970f286d79
        failing since 83 days (last pass: v6.1.26-1298-g61395b9756bd5, firs=
t fail: v5.10.180-cip34-26-gc198172c84b6a) =

 =20

