Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41F7C6FD20
	for <webhook@archiver.kernel.org>; Fri, 24 Mar 2023 10:07:35 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web11.97145.1679652451848027586
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Mar 2023 03:07:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=PIKCmjcz;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.54, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f54.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so4581487pjp.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Mar 2023 03:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679652451;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zc6WllM1GLFuOGFCOYUIRq8w1sh3MYJGgV6/2diLGI4=;
        b=PIKCmjczIomFb6GnaELGVfyeSCrFhkgf7M5mKxv4LUjjAFig0TQRFQk05lN4xK+oGj
         YIBB9PEmZF+buLheo2jaa4fFRsjkhf37KTpkoXwM61FvoKcGpddSUyOG7HRvHroCLhMu
         fwJ7U9Ti+Z5RCIyZERXH0fHBxtIL61o7dppAMAw1U/pKDqMtbzMBHLP1dw7Hba+F/FRJ
         0Bcus/mQtroP2cY7CtBkzNquv9QE79c5NkDA5J8hNpYpuHhnk7EozzdbZvioNwH2Dioh
         XsNh4/9n2ZdaYsa3CXSO1ZcbqU3OyoVqRyyy+qR5aDNIvWJp6ehTKF/qXxw57We8nRhi
         R4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679652451;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zc6WllM1GLFuOGFCOYUIRq8w1sh3MYJGgV6/2diLGI4=;
        b=iT+kmMFLGUzOjXYHflGtQEKDmNfwNJ5Ua1kbxiF3g+8YKP/EyxIkpaPD2iGUDjk855
         UItRnqjzSuQxGMGd3zEhcLMuAji6MyLlEenlbGCyYOvputZ7ValdaB8/4E7+xWoSP0/u
         Zc0LZ5DirSaDWGg9Ps+H+qEqCqKkSeWsQaOzqThQFzCWL6MRrxQnYeDHPfwZVdtwoU+m
         4L6cMtx4skyxzgEeH/vyzVTUq6jmw2XIbL/bZsbXUuFfX0smTX27yVo5x3JTKdqeZkMQ
         xSGKlEg0T7P6CHuccizKOQoXoE0cC+/u4sHYP8JJ3K64JpCaK4pClc5AUY7uN7ph1TQW
         sBsg==
X-Gm-Message-State: AAQBX9cssuaEykZ2+F1//1FVJCe4CT14RZy/tImUkRoUyMWpr2PFfZqL
	i5F/0PwLUPmUwT966ZLi5F5fAVaHaKHDHCVO7VBpUA==
X-Google-Smtp-Source: AKy350ZH0dTHtgdxfU6Oln+nYaNR2X+y9+bh9N3QX+5c+2fgqvZf7VvW6SpnQy57B5NVUYkm8OMFog==
X-Received: by 2002:a17:902:d4cb:b0:19b:dbf7:f9ca with SMTP id o11-20020a170902d4cb00b0019bdbf7f9camr2760854plg.0.1679652451018;
        Fri, 24 Mar 2023 03:07:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902b10c00b0019a70a42b0asm13839421plr.169.2023.03.24.03.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 03:07:30 -0700 (PDT)
Message-ID: <641d7662.170a0220.73fc6.a03b@mx.google.com>
Date: Fri, 24 Mar 2023 03:07:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.279-cip95
Subject: cip/linux-4.19.y-cip smc: 4 runs, 2 regressions (v4.19.279-cip95)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Mar 2023 10:07:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11113

cip/linux-4.19.y-cip smc: 4 runs, 2 regressions (v4.19.279-cip95)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.279-cip95/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.279-cip95
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a166e121fe317e5b7a79c09a0ca641ca15cb61cf =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/641d6745f1beceaae59c9536

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.279=
-cip95/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.279=
-cip95/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/641d6745f1beceaae5=
9c9542
        failing since 258 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-03-24T09:02:51.716747  <8>[   11.984960] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/641d6745f1beceaae5=
9c9543
        failing since 258 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-03-24T09:02:51.706661  <8>[   11.974746] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

