Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71C0C4332F
	for <webhook@archiver.kernel.org>; Tue, 22 Nov 2022 11:56:29 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.17008.1669118180458748289
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 22 Nov 2022 03:56:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=UvwDke3J;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id j12so13402108plj.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 22 Nov 2022 03:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mIzkOyLspz3ZO37XBzS+sNyRgtqFaJDqNA2joODFCC8=;
        b=UvwDke3Jfd2idR3lgrG9j42iB/9rgzXHgiEul9+LyTDz/ga94MhXtiI7KYyxbEjuSZ
         nmsh0j6y40PFK4zC9p4ck6x7WNkhbKeUd7x7r9A27sRJG1l6niY7T33pSguQaTFMXMwW
         vWJcPvoeJOt9om19AgiGJ4Ko6tcv44M+1uxiNXeJcTfzCROY8JjOvrG+0rjjBprp+qJY
         ZPrvatTR0WKvD9/0AoScK8l5EiwiT655ySNLMqqVgVHaYCBqYsxRgdM9R4gF6nSvksAL
         qBLoCj9jM+ZgwDeDuUsTwW3SGbEY081jwGQzlT08WI8JTUisNCSnSmFe3738D+Tzwr32
         FOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mIzkOyLspz3ZO37XBzS+sNyRgtqFaJDqNA2joODFCC8=;
        b=zxrQkTBWZymVvp7eNguuD+GnZYnuoj+yeuXByWVXA/BE3ORrpEoKaYkRCLeF8a7NFp
         Iah/zTo7iegSYwfu6IG8i2wCrdcanxNg7glXPHoh1CzxKwrVp0vT+7OAx66liMgazUnx
         5k4CxYC4Hl6h/DRmfDpkbx0p/wqXAi0eRAlB+khu+MkQ6hQbVWJX4sMdss/5ZT+pHIsi
         7KhkqVchbwE+9Sd5UxXvI3Zqtg0LDIAB3aTntpS/js4va7GlausOaQOIRO78WNs3R7s9
         Ci2g1hrAJ0Su35fh76eqsxoWm/XIicQBSJWu0rBK78RM/oNCOsc7BTcQXmKPBfcXt9g+
         /8Zg==
X-Gm-Message-State: ANoB5pkzldZzhBc4QaTeCBZ7v31xSvnyVu864kh7O+rF9KLz7zOUpR+D
	4EsDz+9nnN3zGQlxGRP3iSLp2L7OzmMMUjzAlrU=
X-Google-Smtp-Source: AA0mqf4BVBsiqFuYg7oJrrQtSNk7ioLq9vHCJSpouVYU0a86EE4hHPCb6tNK7gxvnskvrxymkOXxbA==
X-Received: by 2002:a17:902:e04b:b0:186:94b8:5980 with SMTP id x11-20020a170902e04b00b0018694b85980mr4126495plx.113.1669118179616;
        Tue, 22 Nov 2022 03:56:19 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k28-20020aa79d1c000000b0056c702a370dsm10468301pfp.117.2022.11.22.03.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 03:56:18 -0800 (PST)
Message-ID: <637cb8e2.a70a0220.705d5.fcc1@mx.google.com>
Date: Tue, 22 Nov 2022 03:56:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip70-236-g69445bc0d4209
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip smc: 4 runs,
 1 regressions (v4.4.302-cip70-236-g69445bc0d4209)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Nov 2022 11:56:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10077

cip/linux-4.4.y-cip smc: 4 runs, 1 regressions (v4.4.302-cip70-236-g69445bc=
0d4209)

Regressions Summary
-------------------

platform    | arch   | lab           | compiler | defconfig        | regres=
sions
------------+--------+---------------+----------+------------------+-------=
-----
qemu_x86_64 | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip70-236-g69445bc0d4209/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip70-236-g69445bc0d4209
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      69445bc0d4209b0634d1f43657fd58f708cadf81 =



Test Regressions
---------------- =



platform    | arch   | lab           | compiler | defconfig        | regres=
sions
------------+--------+---------------+----------+------------------+-------=
-----
qemu_x86_64 | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/637ca8f216bde65afb2abd0f

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-236-g69445bc0d4209/x86_64/x86_64_defconfig/gcc-10/lab-collabora/smc-qe=
mu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-236-g69445bc0d4209/x86_64/x86_64_defconfig/gcc-10/lab-collabora/smc-qe=
mu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/637ca8f216bde65afb=
2abd11
        failing since 52 days (last pass: v4.4.302-cip70, first fail: v4.4.=
302-cip70-98-g7f7838c92740f)

    2022-11-22T10:48:07.726743  [    2.087604] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3DCVE-2018-12207 RESULT=3Dpass>
    2022-11-22T10:48:07.726828  =

    2022-11-22T10:48:07.730392  [    2.091703] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3DCVE-2020-0543 RESULT=3Dfail>   =

 =20

