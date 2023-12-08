Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E8CC10DC1
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 17:49:15 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.42748.1702057750215146438
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Dec 2023 09:49:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=u1cpQct8;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so18236395ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 08 Dec 2023 09:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702057749; x=1702662549; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OhYoUmSRD1Shu7dWWkESh+mY6pBGmcrc8lPAwpPTDqw=;
        b=u1cpQct8/KCx/pHc1SC1zxCleAJFl1tV+X7PxWCCZ6T9DAn8yL+hHSYayvPUM7cuYo
         BYHdx32lkqx3hiQvHmzqau9tetLUU0mXLKvFbHm+5kUq9NjRxKYIl1dX6pHrN/Q4z/b8
         S7CTZK9ubOwylP/WeosTN633TXc6BaUSLMM23y/wKq+G/al7GE0EGv1W5z0fkpxz1XIg
         h1cy2WUsL0gGGYyINZTb1trMeJE5wEL0J59tnt7roVNJOo2T9qieZ5bBmFLcVQqN6Q9h
         iRG/ZqWvfYPoKzPEkj7XqlO7Ezsph0yjfFABDPYezCf0ls04bSNODqaof8FA3uxNQ3vD
         74ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057749; x=1702662549;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OhYoUmSRD1Shu7dWWkESh+mY6pBGmcrc8lPAwpPTDqw=;
        b=pJvyNFY4CZapT93WqHbJjkjZnrx9Riockmq5m0ygGevh7yPgGWOfsoDC6spC+M3wIj
         EsKJ6xsWqYah8sGSDWwZbk2GdFSCLTO1HdJ91v2RLT0smoKWADhY9bw9FPWdvcY3h+8X
         AdDEPIN/DvxKA6ajGr9RGltRN9qGKcpkxRXrcsU96db3rfiybyj7xiAYvXosxTG0L/eB
         B7LAPS/BTIuXP9ZgV7umHd4ySJMlNK1qygfSK5H/UjalXCljmqMd/5ZW9NaKp7+HsJNM
         vgd6ke8yR3W1CvJhTDRqneJZk+Ez8lSq1MohaHNtDEE+Pzjrm6oCCZl/eNDCQI6zJp3Q
         cyWA==
X-Gm-Message-State: AOJu0YzHAbuqGFKUq0Xg81tZlLguKFPmy0b3dL7mqBOd/CHzuYxwdJko
	yGPk93dOgylAlLCuJ2N2v6OO7F0XCjF5nh9CmbXoTA==
X-Google-Smtp-Source: AGHT+IFClheCfOivwVLvQs7JoUID0S3M8NL5sYdPlYzCORHh0uWaxdkrwpDD2Xk1TZ2IOUbWzjGAtQ==
X-Received: by 2002:a17:903:2c5:b0:1cf:5629:a0c6 with SMTP id s5-20020a17090302c500b001cf5629a0c6mr423488plk.13.1702057749004;
        Fri, 08 Dec 2023 09:49:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id be3-20020a170902aa0300b001cfc6838e30sm1959467plb.308.2023.12.08.09.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:49:06 -0800 (PST)
Message-ID: <65735712.170a0220.1ba0d.6cfb@mx.google.com>
Date: Fri, 08 Dec 2023 09:49:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-46-g596f4c151d286
Subject: cip/linux-5.10.y-cip ltp-ipc: 12 runs,
 1 regressions (v5.10.201-cip41-46-g596f4c151d286)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 17:49:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13986

cip/linux-5.10.y-cip ltp-ipc: 12 runs, 1 regressions (v5.10.201-cip41-46-g5=
96f4c151d286)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-46-g596f4c151d286/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-46-g596f4c151d286
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      596f4c151d286c71a3612a2120ab33f4ac885d2e

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657348599a22376201e13488

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hi=
hope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hi=
hope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/657348599a22376201e134=
89
        failing since 65 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

