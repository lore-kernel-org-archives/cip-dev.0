Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15B5C001B0
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 11:30:18 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
 by mx.groups.io with SMTP id smtpd.web10.158584.1692185412781312590
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Aug 2023 04:30:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=aLO14C95;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.181, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3a78a29bca3so5020866b6e.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Aug 2023 04:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692185411; x=1692790211;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P23YcjURp3NhL/hRwB4xaYYQpUoL8UWUraB0ngpe3no=;
        b=aLO14C956LRw9VfzfgISszyKpQ8UrViBFMFA6785J9CqrN/IT5FB/Y2kr0fOzI7d3r
         A7bYWau3+iDYwxeLfdl00zQs+TfwrcVhaBnqUKvhsJjmLIqhMyF6QESHQzWBxPKPu39Y
         tlEQBbLhZ/s5LbR1H6vTja43ZFFAJ11XIREf6CIK5IvwMUpKFh24ifZX703Km+kx+PXg
         CmUX+DqMWnDn3ts+W8IDiD9E2hwR5YB8VggvTxt3n9dy65MRIUE4rWLRY8jUtcncPNtt
         r0fhNEGy1DB3qU9ZODbA2SqG6dCeldLKnmOxS8BKQR2uAD7FvjNFy9nb3ZfQluI5U5zM
         cGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692185411; x=1692790211;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P23YcjURp3NhL/hRwB4xaYYQpUoL8UWUraB0ngpe3no=;
        b=G+biAK2DUzqq+j6Xk5EYjLIOJa536ZNZ3+hLgcM+Zj3pkvPkyEkRaVbgcgwe8UPhNT
         s/uEw2B6OLfkmTgwjyAVPN3NA9/pGeHrKTZO2sfqsZV/W+RVuDvJIRdPbRSFAXfaRFdE
         xuPn1pzqdHEqpTlJzLGFauGvYSg5IfDzRE8XHLIlV2rsPuqzXQtVtY0fVpijq+k9Zizq
         VxyQ05byTk5qwehYr3edrH5HiJswpZzauDc8eOIsMRppP6Y/BFqWOu+2gRnDe1OADqDK
         ELq3ztirpp8sVKQZViuQ+jrukF030RDjQ19rLAWmVV7qWYhDroU7B1pAABMwDKXb6Q6k
         n0Dw==
X-Gm-Message-State: AOJu0Yy1IQ4NbMHicI4+aRcwLJK32wYgj4uMYT5MKJiLbuSBQP2B1CKf
	/plDnIvrVdFfN58oJwWKGNzq5ooXfVV+FU3GC2bb4Q==
X-Google-Smtp-Source: AGHT+IFeYiohPqMIDW34ivx9WndgELZ81uvbAL5njAJKSdoDpBaaEPyIvmE3vSStftuVty2NnjtTkA==
X-Received: by 2002:a05:6808:2a09:b0:3a3:f7b8:576f with SMTP id ez9-20020a0568082a0900b003a3f7b8576fmr1854828oib.19.1692185411162;
        Wed, 16 Aug 2023 04:30:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y3-20020a631803000000b00565ec002d14sm1654093pgl.33.2023.08.16.04.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 04:30:09 -0700 (PDT)
Message-ID: <64dcb341.630a0220.1c299.3404@mx.google.com>
Date: Wed, 16 Aug 2023 04:30:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-14-gc9b5a049d8ea
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip ltp-timers: 8 runs,
 2 regressions (v5.10.186-cip37-14-gc9b5a049d8ea)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 11:30:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12671

cip/linux-5.10.y-cip ltp-timers: 8 runs, 2 regressions (v5.10.186-cip37-14-=
gc9b5a049d8ea)

Regressions Summary
-------------------

platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.186-cip37-14-gc9b5a049d8ea/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.186-cip37-14-gc9b5a049d8ea
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c9b5a049d8ead0f771ee3424c42b20632ebc5b3b

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64dca17dac0d1d7e0935b1eb

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_=
smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_=
smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64dca17dac0=
d1d7e0935b1f0
        failing since 26 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-11-g2b3c22dc0633) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64dca17dac0=
d1d7e0935b1f0
        failing since 26 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-11-g2b3c22dc0633) =

 =20

