Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A59C48260
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 19:45:57 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.23038.1707853556535995025
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 13 Feb 2024 11:45:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ek5rCmu0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d934c8f8f7so11770625ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 13 Feb 2024 11:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707853555; x=1708458355; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bC1ApSfYQRwxlSFIyrrGyH3BSHF89JIEjovcApcchMY=;
        b=ek5rCmu0RcDQLdhYhdfcjuxEKWq9Ey7IM06vfiNR0Ywc4bs6PbBcWXlxuXjoqi9ER/
         +QI2+p3gwm8YS9aDN6QFs7jNpOdJ2R1GwIDv1/MFHV8HI3Gc90XTcfKVbr+9yaPEnaho
         ub29j3pAiGAG12G4vzfyqLyNc+gA92KoKkPDwFWNGnpTvsYrxm4Owbm+aOmMpUvVV9XJ
         GlGK0t5N/LNGdD4T18GVsBSNZSPIvm8uhQzhY5bYoTccWG/GodaQJ7vI2PAANFHfMaWS
         LVx3LiIUu1NHZbWV29vnN+fuv1l6fxHMDR3BmjjWHSqsAzuxfmJOYdPsqjcKRZY/9CZ0
         462Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707853555; x=1708458355;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bC1ApSfYQRwxlSFIyrrGyH3BSHF89JIEjovcApcchMY=;
        b=gkqE+uSP74HJcG09siwM2bdwr3R0UthNDbrI+47kCW9xbtj5Qn8NuDg4a0UDmkclAy
         PvZLrxB0Jf+VR6qT22OBLJVB2uH/FDrGikBJFhLdkny6KHf0CV6/4ZCjY+J+hNSGV3Ea
         y2cHYNFkYqtqH+mk6m3dJgV1//3TfjXyZq9Nt1uKGXHRjlAlDjArCGlG1ul/o8qn/WkX
         ko4FSP6+vTKV+7yV1f8qN/c63BRJJ2F1ZM1ol37AJAtXiPgLNCCduMjGVbEDVW5ZbTso
         WDKF2G+eT3MQY8xqvcf+wl3gzA2fDvsz19dezSOWtVqjxKBlQsUAQZymMEElRl+4SpZn
         ER0A==
X-Gm-Message-State: AOJu0Yywb8n22TrU7Bl4Zq1bdJYeYxEWIoeCC79yRFaZ52ENs5QMdG8L
	6gvseViOe80Tue+1FGvPkUAV1RKeEbim0VXJ0/jQV5Vro5vEnxZcIGN2Wl5TE5aJc2Zwv60amuC
	BiJA=
X-Google-Smtp-Source: AGHT+IGfU9JcT+8Ai/v30h+3oa+3ysqlxdDFNuBtvwmjRirK3eri/fDJV19QD4vlYj4gca5Wavo7Rw==
X-Received: by 2002:a17:902:bb8d:b0:1d9:c86c:39c2 with SMTP id m13-20020a170902bb8d00b001d9c86c39c2mr533020pls.14.1707853555009;
        Tue, 13 Feb 2024 11:45:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jc13-20020a17090325cd00b001d70af5be17sm2439908plb.229.2024.02.13.11.45.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 11:45:53 -0800 (PST)
Message-ID: <65cbc6f1.170a0220.ce906.89d7@mx.google.com>
Date: Tue, 13 Feb 2024 11:45:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.209-cip44-51-gdb99ac443b0da
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 11 runs,
 2 regressions (v5.10.209-cip44-51-gdb99ac443b0da)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Feb 2024 19:45:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14959

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 11 runs, 2 regressions =
(v5.10.209-cip44-51-gdb99ac443b0da)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.209-cip44-51-gdb99ac443b0da/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.209-cip44-51-gdb99ac443b0da
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      db99ac443b0da75f00a4fc49e0040ac5dfa47e72

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb3f7f510624c93637024

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-fcntl-locktests-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/ltp-fcntl-locktests-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65cbb3f7f5=
10624c93637025
        failing since 8 days (last pass: v6.1.75-cip14-6-ga817aa655908, fir=
st fail: v5.10.209-cip44-rebase) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb4e9007de3f783637037

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl=
-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl=
-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65cbb4e900=
7de3f783637038
        failing since 9 days (last pass: v4.19.299-cip105-1134-gc868d5e4ada=
a, first fail: v6.1.75-cip14-132-g6e54756fbd6c2) =

 =20

