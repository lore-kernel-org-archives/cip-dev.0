Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC111C04A6A
	for <webhook@archiver.kernel.org>; Wed,  9 Aug 2023 05:29:34 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.web11.82104.1691558972514673574
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 08 Aug 2023 22:29:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=ZWB/AE/V;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.181, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-53fa455cd94so3838218a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 08 Aug 2023 22:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691558971; x=1692163771;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lrwMsnVR4Lki278nSOE0u8K3a3tatfVirsdqdUheIRg=;
        b=ZWB/AE/VKEZDXpFV2N2wSs2otEN7Lwg1fXWkGufTpB+3OqLPWCkfWkmIKP+675OC9c
         46qpNQiQXX6EiMUo+1Qer4n+rPiAokrbUpFZHeRxPfNgEmUQm9E+lgkMNapFsL84rDha
         KGISxDKV+rQxdFSVNKA8LFxphvt6roETU2+3E9ZGpsZvIL/Axoul/rFLWB0++7I7QXO3
         fG+ngirSAgeYfxnmG1nvR4SNix4mqareivKS6qX/2IDQx6vspZCJtX3hdeENylM4UjsJ
         ocdyvZNtFlcMuYZI0HbvdRsszFnAr7LM63O419p6PGvHIoOhbuwNfmTUd5NAzLQT5D1s
         oh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691558971; x=1692163771;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lrwMsnVR4Lki278nSOE0u8K3a3tatfVirsdqdUheIRg=;
        b=cngOAlY6VywoqQor0LBYW/dqCH7Be4JX7Mbrv+NBw2e7n1WlG+kSSjVmkFQXFzEx7a
         B0/iQLyNrMhYn6w7tGztL3/C1GcAgFwJqMzJPu5a+pYtYYhnc9wG1Zx9y4ZguSi5tUWt
         Q6x9r2/f0RZzCw8VUVdxc1Ngly2dRbL8mhNufYGlHy6HrVXRA7iKxsJ/EHSkpXT3TSlU
         e/BKdmIBpsrzjXWuJLVEK8/NsdaHp8rsw2fEjzMIbJpfrVXocmp2bncrDldT9wUvfHLL
         fILF51+ubjIpZwqvXXOxIvZB57Sa3bi0s3Kzq6aAnCvSWkXjm8z7PYiYLyLTUfVYQYIP
         +VPg==
X-Gm-Message-State: AOJu0YyNqoxHJvud735sgqf3m1PLoB/vtFEih+De2hCtGG6e8BEXCvsp
	mTSJ5bbf3zwjhtns/4OMs8//yU3eRZWVNufMys2+3w==
X-Google-Smtp-Source: AGHT+IE4fYbf/vBRq2NPSawJRXFXPbGzDZlkzpPG+GQX9M4757/+fBA5f7VfRrv2q+tByPPAhZcp7A==
X-Received: by 2002:a05:6a21:6811:b0:13e:8ce5:cacd with SMTP id wr17-20020a056a21681100b0013e8ce5cacdmr1330373pzb.26.1691558971529;
        Tue, 08 Aug 2023 22:29:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001adf6b21c77sm10032923plx.107.2023.08.08.22.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 22:29:30 -0700 (PDT)
Message-ID: <64d3243a.170a0220.db5d8.2fcc@mx.google.com>
Date: Tue, 08 Aug 2023 22:29:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.42-cip2-1-g47d13938e615
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
Subject: cip/linux-6.1.y-cip baseline: 114 runs,
 2 regressions (v6.1.42-cip2-1-g47d13938e615)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Aug 2023 05:29:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12577

cip/linux-6.1.y-cip baseline: 114 runs, 2 regressions (v6.1.42-cip2-1-g47d1=
3938e615)

Regressions Summary
-------------------

platform   | arch  | lab         | compiler | defconfig                    =
| regressions
-----------+-------+-------------+----------+------------------------------=
+------------
juno-uboot | arm64 | lab-broonie | gcc-10   | cip://6.1.y-c...64_defconfig =
| 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.42-cip2-1-g47d13938e615/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.42-cip2-1-g47d13938e615
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      47d13938e615152046baba32a1c3135dd09e2feb =



Test Regressions
---------------- =



platform   | arch  | lab         | compiler | defconfig                    =
| regressions
-----------+-------+-------------+----------+------------------------------=
+------------
juno-uboot | arm64 | lab-broonie | gcc-10   | cip://6.1.y-c...64_defconfig =
| 2          =


  Details:     https://kernelci.org/test/plan/id/64d317fdd22448eb5635b1eb

  Results:     55 PASS, 5 FAIL, 1 SKIP
  Full config: cip://6.1.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.42-ci=
p2-1-g47d13938e615/arm64/cip---6.1.y-cip-arm64-qemu_arm64_defconfig/gcc-10/=
lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.42-ci=
p2-1-g47d13938e615/arm64/cip---6.1.y-cip-arm64-qemu_arm64_defconfig/gcc-10/=
lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case/id/=
64d317fdd22448eb5635b219
        failing since 9 days (last pass: v6.1.31-65-ge66be31505fa, first fa=
il: v6.1.42-cip2)

    2023-08-09T04:37:04.902268  /lava-40100/1/../bin/lava-test-case
    2023-08-09T04:37:04.940969  <8>[   35.070202] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>
    2023-08-09T04:37:04.941498  /lava-40100/1/../bin/lava-test-case   =


  * baseline.bootrr.ethernet-probed: https://kernelci.org/test/case/id/64d3=
17fdd22448eb5635b21b
        failing since 9 days (last pass: v6.1.31-65-ge66be31505fa, first fa=
il: v6.1.42-cip2)

    2023-08-09T04:37:03.848580  /lava-40100/1/../bin/lava-test-case
    2023-08-09T04:37:03.872605  <8>[   34.017457] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dethernet-probed RESULT=3Dfail>
    2023-08-09T04:37:03.873129  /lava-40100/1/../bin/lava-test-case   =

 =20

