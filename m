Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD9CC77B7A
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 15:56:46 +0000 (UTC)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
 by mx.groups.io with SMTP id smtpd.web11.191.1686067000994577600
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Jun 2023 08:56:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=vyuYiAjg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.42, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1a2c9f087f0so3778266fac.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Jun 2023 08:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686067000; x=1688659000;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tep0H+PLAZJeh5bR53UMdoPkiOmfeoUEmcSM2sOj/5U=;
        b=vyuYiAjg/IitObNPKy6ZqnjJ19B5mMfuBNeUckxAjBog1N3RNj/iR4GYfxbdTGJ3Pk
         631bdiE93rvPZJtzlVxB0ivGCfitTFO57nPFHlEIty/b6UYuqzWN8LcXc6IZMvP7PnFv
         4vyiMjJlNvmze/XMMKBjP4gOfxqf+rKTSlP3YtLdsoTavtSZUBggAhzOrW9IIx01idBS
         wHFMaMVn2VenExooNrHhFEZgI37NRDo/HzMKO/BjSEz5nWUYcwrr2P+Ea1saDxgbVPdh
         Fx8d7hvnBQ1RrZ+QqLS/E+yC2ITMTwZ/ELbdLg75JT62Cwsj7etenMBgJlBu4phMzq17
         v2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686067000; x=1688659000;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tep0H+PLAZJeh5bR53UMdoPkiOmfeoUEmcSM2sOj/5U=;
        b=FHNC/TlGf/8/9hIfE+XElNeMq0Zv8uJNXj4O+R/NoatcMU4Nttpr4X5sP9CUGvJOGS
         75iSi1iHmaIv9EojNzeQDZPfwsdDwNOblio366HJU8RtMEKWD/dMMSOu7IOp44R6Ee0m
         Xx5hffrfSDVvtNcVi/S5EBVtC5SN/F/tPP2E7YViqm7UG4EEVK5DHR7OTYTyCOo3YE/k
         1sZx6u17JpcvOOshvbp9iLmQ+JGsmXFaP/dapnAG6vvW5LKrf2N6eyYETI/EUkE/9C5R
         oo1mkNNNqKm2Cgd1rXrL0uVe1mY1BRjczsHPqPrXz96xJHL1fl0bBS84MGBK7C3UTKEP
         /1Yw==
X-Gm-Message-State: AC+VfDy+Fg1oGyAmTROBs0hQTEmZRBgb2Ga+4fojRBhZcE+3EoybfMA9
	FGacm2tF4uqgQrWTn8k/ls2R2kfxd+kDQJRak1EpEA==
X-Google-Smtp-Source: ACHHUZ6SB1ELbJUuo5KXkybpr7HXZ2sx/PQG9QKNZBm0H1TRV+uKhvMvZ5nS8j3XR9HVrbm3WdGxlw==
X-Received: by 2002:a05:6358:c522:b0:129:d7dd:9714 with SMTP id fb34-20020a056358c52200b00129d7dd9714mr183589rwb.9.1686066999954;
        Tue, 06 Jun 2023 08:56:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id gz18-20020a17090b0ed200b00246f9725ffcsm7802461pjb.33.2023.06.06.08.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 08:56:39 -0700 (PDT)
Message-ID: <647f5737.170a0220.f999d.e31c@mx.google.com>
Date: Tue, 06 Jun 2023 08:56:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-1308-ge1d2f27f3d7b0
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-st ltp-fcntl-locktests: 3 runs,
 1 regressions (v4.4-st20-1308-ge1d2f27f3d7b0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 15:56:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11899

cip/linux-4.4.y-st ltp-fcntl-locktests: 3 runs, 1 regressions (v4.4-st20-13=
08-ge1d2f27f3d7b0)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st/kernel/=
v4.4-st20-1308-ge1d2f27f3d7b0/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-st
  Describe: v4.4-st20-1308-ge1d2f27f3d7b0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e1d2f27f3d7b00de8c897e307a469e764166b3f0

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f441c7176b58929f5de72

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
308-ge1d2f27f3d7b0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
308-ge1d2f27f3d7b0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/647f441c71=
76b58929f5de73
        failing since 132 days (last pass: v4.4-st20-234-g4e6ec7162c8e, fir=
st fail: v4.4-st20-821-g39bdf0444b23) =

 =20

