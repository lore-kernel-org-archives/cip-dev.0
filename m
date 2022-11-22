Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2926C4332F
	for <webhook@archiver.kernel.org>; Tue, 22 Nov 2022 11:26:19 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web10.16226.1669116376312082226
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 22 Nov 2022 03:26:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=mPZOZUbM;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id 140so14089490pfz.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 22 Nov 2022 03:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EByR+CmFM9kkrvLPkMOBMqSh/TR6DN5SoFYFIzNXSNA=;
        b=mPZOZUbMGTX0uLeBfKMvC1pYBTuXFqp+SpEuX6NYPyMEoWV+cq9ILMoFzqlcy5p5YH
         d6ixpTh70PF1owZ01WbiEJubcDoIcYmCU4rmQS0cEtU5dneu/nWXm3MJyu0nESzqCFYJ
         ZM2hW1pmE1qnbRYMbbF7xyNcsK4vOxHh1d/LnwWHly+bjmz/uzkNeJlMwVX1mofHMjhR
         5EQC3Ci+pRSxPcxFjmaTqBx9vy68Vr+29dSLlIkitIQwuGJFhtYRunfYEzyS1UVWWR1P
         KUs+B3epM8jrHXQ9pw894K4vkGZb+COSMQWsPBbjh+9p0tR5q6YGI68uYggQxySTUGLp
         mQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EByR+CmFM9kkrvLPkMOBMqSh/TR6DN5SoFYFIzNXSNA=;
        b=Q2ZY1QT6SCJylcgiAVOiq2WWI20dpA7F6XobB7PtnhqsiWeWCZkYTxPLNDoT71afis
         weGm/Yy2y79H/a0zZTLBiPCtcwX5EviHyuiPMEtEjwxqVlkUoHT6vHR5lnzsy34/i/BD
         /WN4IPobyOokT0UvoBMpJvKx4Og8x1I9LGUg7qzbYHMyr4W/dYbxFHvMbjD3vxQceIbI
         w8Ra4f8yr0GOxZQFzwyS1RdC1TzFHd9vsfoIgUkMNpnYd/U6EbBf9qRkjrGNHYTt3QAS
         7daB436qsDr3vTw7JThakv7RG24g2Q1/BUhz3I5Wu4ukiUKofdoUtP+o3trL3M5+cjCg
         YIAw==
X-Gm-Message-State: ANoB5pnwkVpeTbt9LHtMIKfAutFMUQbBDhOk2VhtlPdaxYuWJ7jsryyD
	w/JmLXygN2XIOU7RYaSV3zL+lvkLqBsdNK4j6dU=
X-Google-Smtp-Source: AA0mqf6gPqOtKvMJ/Ud6okxKaVnQdcOQrMhRQFC+3wkr/8Gcfi3Xd9VOg1r26LZHT9igaPqTZ+/5ZA==
X-Received: by 2002:a63:e411:0:b0:45f:b2a7:2659 with SMTP id a17-20020a63e411000000b0045fb2a72659mr3142766pgi.132.1669116375277;
        Tue, 22 Nov 2022 03:26:15 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j14-20020a17090a3e0e00b00218d0bf342csm943889pjc.25.2022.11.22.03.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 03:26:14 -0800 (PST)
Message-ID: <637cb1d6.170a0220.f0f2e.1514@mx.google.com>
Date: Tue, 22 Nov 2022 03:26:14 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip70-236-g69445bc0d4209
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip baseline: 45 runs,
 1 regressions (v4.4.302-cip70-236-g69445bc0d4209)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Nov 2022 11:26:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10071

cip/linux-4.4.y-cip baseline: 45 runs, 1 regressions (v4.4.302-cip70-236-g6=
9445bc0d4209)

Regressions Summary
-------------------

platform         | arch | lab     | compiler | defconfig          | regress=
ions
-----------------+------+---------+----------+--------------------+--------=
----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip70-236-g69445bc0d4209/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip70-236-g69445bc0d4209
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      69445bc0d4209b0634d1f43657fd58f708cadf81 =



Test Regressions
---------------- =



platform         | arch | lab     | compiler | defconfig          | regress=
ions
-----------------+------+---------+----------+--------------------+--------=
----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/637cad57c46396b71b2abd11

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-236-g69445bc0d4209/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-236-g69445bc0d4209/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/637cad57c46396b71b2ab=
d12
        new failure (last pass: v4.4.302-cip70-98-g7f7838c92740f) =

 =20

