Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94039C7EE25
	for <webhook@archiver.kernel.org>; Wed,  7 Jun 2023 14:58:25 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web10.319.1686149901814771789
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Jun 2023 07:58:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=5QE/3LR6;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-65242634690so4243608b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Jun 2023 07:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686149901; x=1688741901;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RCMSwx0us1AAlCTte46zIVKLBYIT8tn2VQRulH7Jjv0=;
        b=5QE/3LR6i4Ikx6nq7aPJ/IYJUQnzVIyZDpurRDbxUE0DkzbckyrXejXUCCytuABp5i
         P1sxqpTrY0WmOauDT6qmM/x7Lua3PzTlHyBcMTj/G5dJdZ8maGXUKTszMzTPyIZQGZ8c
         M9NVQBpJbQ7jTiRfcV+U7TQZD5qqr8RZGk+dvyDNUKJ/NGGSrblJWfgADUrXjzXcu6ai
         qLefY8fy0+z8ovhskC7KyN3Jw58baDGadsHOci7Fu+OfCTAISEDprIiS2fUBWUgcBv7/
         9GpgHVIVSVwM0mFMa34TPdudpcqr4eIdabLY5t9/fK10jSlx9M752sZY51PtHH0DfWr5
         D34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686149901; x=1688741901;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCMSwx0us1AAlCTte46zIVKLBYIT8tn2VQRulH7Jjv0=;
        b=YKeV0JoYSjaATKJuhLXWB+ifO/si2PKV9tJ8VSV6zyo9imdiPyuwVVSBR4lD1Zdbza
         FTOWCgZoZ3IO/WhM/u2cQoXVIbc0SL7XvB6UGS5zm+oiCeEF1O7qWyh6zPioulBkb5tL
         VDR2EtfnMf5lj65UZ62gav9EXUTX269uSqtgWHPINBOq/DpvdZR9t+HMMl6o3HuSAoQE
         Gowi6JUsqOr3dZ4DdzjtHy11UJsWils0MHEb4UDNEB1aCttmk+mETmnwWOUJwgPDnNRD
         SWuRbjeuFqgoH5xZ+VCYWYLICp8cGemcx7K6TxF1hoW2VJww7v36b1upaLOWg9dPpvqT
         6H5w==
X-Gm-Message-State: AC+VfDz6N8BK92h/2A6ktX3mqMok9qdd0dEhwwNb8enuSrCbvzf8lKGq
	h1e/UaDj5yEnSRNAzDhPpFWrNKRp+3eTH8s68RFE9g==
X-Google-Smtp-Source: ACHHUZ6CA//vzMRbjh2+CnKOxEVht2qvnkFnmWt/3VJU8z8vP1MA2DMcMEz3Al2UKQEfqV0FRzEovg==
X-Received: by 2002:a05:6a20:8f27:b0:10b:646f:d9f1 with SMTP id b39-20020a056a208f2700b0010b646fd9f1mr2532508pzk.5.1686149900763;
        Wed, 07 Jun 2023 07:58:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id iw4-20020a170903044400b001aae64e9b36sm10565323plb.114.2023.06.07.07.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 07:58:20 -0700 (PDT)
Message-ID: <64809b0c.170a0220.de8f8.4b2c@mx.google.com>
Date: Wed, 07 Jun 2023 07:58:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip76-rt44
Subject: cip/linux-4.4.y-cip-rt ltp-ipc: 14 runs,
 3 regressions (v4.4.302-cip76-rt44)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jun 2023 14:58:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11918

cip/linux-4.4.y-cip-rt ltp-ipc: 14 runs, 3 regressions (v4.4.302-cip76-rt44)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | defconfig+x8=
6-chromebook     | 1          =

asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...k+preempt_rt | 1          =

beaglebone-black         | arm    | lab-broonie   | gcc-10   | omap2plus_de=
fconfig          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip-rt/ker=
nel/v4.4.302-cip76-rt44/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-4.4.y-cip-rt
  Describe: v4.4.302-cip76-rt44
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      246f4be89a7760f90649094cbfabcccfce7dafd1

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
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | defconfig+x8=
6-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/64808b3790338f421e306142

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip76-rt44/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-ipc-a=
sus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip76-rt44/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-ipc-a=
sus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/64808b3790338f421e3061=
43
        new failure (last pass: v4.4.302-cip74-rt43) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64808c99692e134b0d306164

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip76-rt44/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-c=
ollabora/ltp-ipc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip76-rt44/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-c=
ollabora/ltp-ipc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/64808c99692e134b0d3061=
65
        failing since 63 days (last pass: v4.4.302-cip72-rt42, first fail: =
v4.4.302-cip74-rt43) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
beaglebone-black         | arm    | lab-broonie   | gcc-10   | omap2plus_de=
fconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64809aad0e875b80363061a0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip76-rt44/arm/omap2plus_defconfig/gcc-10/lab-broonie/ltp-ipc-beaglebone-=
black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip76-rt44/arm/omap2plus_defconfig/gcc-10/lab-broonie/ltp-ipc-beaglebone-=
black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/64809aad0e875b80363061=
a1
        new failure (last pass: v4.4.302-cip72-rt42) =

 =20

