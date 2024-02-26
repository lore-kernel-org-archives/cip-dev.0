Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B16C47DD9
	for <webhook@archiver.kernel.org>; Mon, 26 Feb 2024 03:15:26 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.13136.1708917325393027812
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 25 Feb 2024 19:15:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=T4+DZe/g;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6da202aa138so1631181b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 25 Feb 2024 19:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708917324; x=1709522124; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G8WGe9OIPvIsSUGzpIQMuJJtrCjXddBpZ9IBoY1IQtI=;
        b=T4+DZe/gPFCWIZNNNbivgOltfsTH16eehRq0AiSBEVYbB01uN4s7GGlr1XmAOLkgvN
         0aiGNxyu2+i5l8kRe0PpqxA7Ds50rNiRnGBeDBaObr5UM1ycYNr7M8omg/Kg79WFT7u8
         3zWAN14B2KZIkDwSV189T9PvJig6cOqEssH/WzMb0zcke9G2SvtKW9Z77zKOTOTfNeCO
         QpAL/sPBoX2wEtesA2PoO5Kfd37Mcor4tyaClfFMfPdvQ3UIt2nSrSnlQvieyVOP7ZM1
         Kl7e2MgLwh/ZF25pqgJLLp+U9tfadoHpOUTy3mK0yo+opDun1RLAk9DKlY95rD83ZClT
         A/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708917324; x=1709522124;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8WGe9OIPvIsSUGzpIQMuJJtrCjXddBpZ9IBoY1IQtI=;
        b=Kc2Oqn/4/FZU7pTAqYoJlpQuOiCF/KigKhTyPfbi4Pge1psPJIrJ9rj0hVurHswvdN
         Pj7jT1nuHwANiBX2xsV4eiajDuKBsCD+J1WT8bw4ol+h5L6/cI4e1k5fawtj7GZVqA7C
         Cd6fab/V9Cx63iWyDHKTdtnCZxL3cmwd5l6mEDbeJ6Oa84JTFnZ76cu12D3ibJ8F+52w
         Flv4Dgn5fZifIspMiPiU51T9EUnSUo12vjLRvbyqMQ31TqeGLdikl/r090ZMBIeRjVcI
         M2ay4viFU5IxzHvS7EGX/9SSbjQtVTuYMd1zFfk813WGJ8qfUad3Hrv/SqUyyVyqusEe
         00cw==
X-Gm-Message-State: AOJu0YymkJf9ngWeacrj2SAO/EvvDsjkfGXRgvHaMncXg0P1t+8F6v2e
	uHUco44XZJWf0Rr9JT+jtzFLKSRuF3Foh5A3yLsElNs2f+LeDfyOBaCZ0aRgMhBiJZriK9ZvR/G
	Y
X-Google-Smtp-Source: AGHT+IFZP30L835AxPeOpTcSvDhCFG1ukZtcWErs40nzIfdNRPolQKG9SHVkjvKIhE3KQXxFhnUQ4g==
X-Received: by 2002:a05:6a00:9391:b0:6e5:34b5:4485 with SMTP id ka17-20020a056a00939100b006e534b54485mr593229pfb.29.1708917324320;
        Sun, 25 Feb 2024 19:15:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o4-20020a634104000000b005dc88b232a5sm2973316pga.26.2024.02.25.19.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:15:23 -0800 (PST)
Message-ID: <65dc024b.630a0220.a4119.7c8f@mx.google.com>
Date: Sun, 25 Feb 2024 19:15:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Kernel: v6.1.78-cip15
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip baseline: 114 runs, 1 regressions (v6.1.78-cip15)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 26 Feb 2024 03:15:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15084

cip/linux-6.1.y-cip baseline: 114 runs, 1 regressions (v6.1.78-cip15)

Regressions Summary
-------------------

platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.78-cip15/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.78-cip15
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8e0cf035f64a98ea0d7ed2527a547f39866c37ba =



Test Regressions
---------------- =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65dbf040c9c33235d46370c1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.78-ci=
p15/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.78-ci=
p15/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65dbf040c9c33235d46370c6
        failing since 93 days (last pass: v6.1.59-cip8, first fail: v6.1.62=
-cip9-12-g3a5321f469b07)

    2024-02-26T01:59:29.724055  / # #

    2024-02-26T01:59:30.798223  export SHELL=3D/bin/sh

    2024-02-26T01:59:30.799507  #

    2024-02-26T01:59:32.282627  / # export SHELL=3D/bin/sh. /lava-12860298/=
environment

    2024-02-26T01:59:32.283886  =


    2024-02-26T01:59:35.002832  / # . /lava-12860298/environment/lava-12860=
298/bin/lava-test-runner /lava-12860298/1

    2024-02-26T01:59:35.004654  =


    2024-02-26T01:59:35.004884  / # /lava-12860298/bin/lava-test-runner /la=
va-12860298/1

    2024-02-26T01:59:35.072080  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-26T01:59:35.072325  +<8>[   28.470438] <LAVA_SIGNAL_STARTRUN 1_=
bootrr 12860298_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =20

