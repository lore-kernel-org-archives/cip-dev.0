Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715BCC7EE2F
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 13:44:21 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.294.1686059059667941238
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Jun 2023 06:44:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=OOdIFUR+;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1b246dd3390so523215ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Jun 2023 06:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686059058; x=1688651058;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QE3uoWMkNyYMtKvaE9/sOccMSq9PDvyb5qEo48Gyscs=;
        b=OOdIFUR+Jl0fbCkBEy0Yyq7EPFOe5kF6hpkQulF/ChvRNT6ws6ZmDgPfAksadMFJtU
         FecowXR4M7IAQzBuDvEz85x+1GYcyR2U/UbC6yrme9aaUV4i6Uea3dzb6o5NKWUkQCMt
         Gh1mLW/WBRaulREJUOkdMm2lLxV0PE4f9Wv5+wAMja3oisM4xgfd8VxQo34XSH98giLJ
         iUtDYRep/HmbM0j6hZKudDfKaWB7m9KcIUPrNV100HUZEGCxxUBwHtl1/ECaa6RLhqZS
         fs+iaFJts7o6Z7T4s0GFPjD8393X9J0kekIYz3UGMhG8CBHxtBuMN1R6CUpy6qy3l2fH
         xxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686059059; x=1688651059;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QE3uoWMkNyYMtKvaE9/sOccMSq9PDvyb5qEo48Gyscs=;
        b=LphvbX6CvUhqLihNEbEumqoLU1Te4kFyOBBN7v1X230J/UMsz69EBgLt4DzbRgj7V3
         nvIxNZH/w5Q4SuCgh239qmSv3X6JxLEwxZi4SCeo0O71cJN41gDPWkjVAvTfBEmLU7eR
         /QkJ9cL6lyhY+viyV5wOGIRqE0KQZF058QSjIPvR68Ztm8/BHcZ6qmG2HqRW4FKLFjQN
         JZtFyFD/CN50hAbVLlD7DRGAtSmcOY0e/RcaESQgqjYotOESaUhTyg8zKVUm0/d+BLk5
         1iEOwXC4AtfpcojgKgyVBvMW1XRskIQupn/Dm0vV3ZGruuJw9O1jvT6TEZgIcs+UMFpj
         LE/Q==
X-Gm-Message-State: AC+VfDwSQcHcf4KvE/mTE8AAYNssQt3BKeSEz4F+cFGbbjrxWGFE7vvR
	K2sUBP3ZPsxZ4cAisjl+zfFCeQynIrlXhQr8ZtjYew==
X-Google-Smtp-Source: ACHHUZ7qn3GMLga7/YARyPiXyn53P7/jPMyhpl+Ne0iiG2pJ1R/0ujs4dWXa/G8cCHLfhE5bwphSZQ==
X-Received: by 2002:a17:902:c3c6:b0:1ad:e2b6:d292 with SMTP id j6-20020a170902c3c600b001ade2b6d292mr2116212plj.4.1686059058745;
        Tue, 06 Jun 2023 06:44:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d2c100b001a67759f9f8sm8590825plc.106.2023.06.06.06.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 06:44:18 -0700 (PDT)
Message-ID: <647f3832.170a0220.7a1cd.fc70@mx.google.com>
Date: Tue, 06 Jun 2023 06:44:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1320-gc38e4a9845945
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-6.1.y-cip ltp-ipc: 14 runs,
 1 regressions (v6.1.26-1320-gc38e4a9845945)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 13:44:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11889

cip/linux-6.1.y-cip ltp-ipc: 14 runs, 1 regressions (v6.1.26-1320-gc38e4a98=
45945)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.26-1320-gc38e4a9845945/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.26-1320-gc38e4a9845945
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c38e4a98459459f32d3c7c627ff35defa2415935

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/647f2ac6bd97553a98f5de25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
20-gc38e4a9845945/arm/omap2plus_defconfig/gcc-10/lab-broonie/ltp-ipc-beagle=
bone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.26-13=
20-gc38e4a9845945/arm/omap2plus_defconfig/gcc-10/lab-broonie/ltp-ipc-beagle=
bone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/647f2ac6bd97553a98f5de=
26
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3) =

 =20

