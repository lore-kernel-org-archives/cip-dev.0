Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F37C77B73
	for <webhook@archiver.kernel.org>; Thu, 20 Apr 2023 15:30:19 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.11409.1682004614850539335
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Apr 2023 08:30:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=k2bNkXVW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1a52667955dso13710745ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Apr 2023 08:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682004614; x=1684596614;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GjcLSinFONK3oaiSbLY5xZP6Q71YB+yJk22KDgXJ3T8=;
        b=k2bNkXVWL/yHCU0a5vmZyJ10qQDB+ImfWJShnoUmeFroNeNLjY1suRU3L/WqER+eB2
         DjsdnKFP8UU8y7M32G4nn5eaFYQ6R7EXOzeW99O9ZOeo4EqXVhlUE/m4xLN06MKuUhnn
         y8AJDOlq7BEAc30gd+ixUZbp7KxjmTiGObhv/b7dLBmrVBmNX7YEPQYYSAmf3sf8a9Oy
         QqMRRobl6hEXAo34r22QZaUSWKHyRfauvQzyQDnM2nlScF83lzyur4Q4zX4FwhMF/uu2
         NYXzfG2idUmyj2KsFTDutxk+u2HolulgO+Isp2az/VP+YHcKBKFhezCO0ww7dAx3LPEJ
         T6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682004614; x=1684596614;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjcLSinFONK3oaiSbLY5xZP6Q71YB+yJk22KDgXJ3T8=;
        b=MQBfgaG7p8zzW0F0RozzNG86j/jbZX1d/ZPLWgfAuifSY0tNDGajG7NrGuydUAy+/G
         H+7lG3zYyXyJu73ocwOZ7QGyN+RoPt/ax2y9La7zCSCnUHVx4WeG9CzyvMiEyWH1StAV
         sdHke/kpvwtpP4pj8w2qxWXOtOUCCL0CWAmJiGD0UrDzgiTThOUJBMaZyk/+YhFYuZCP
         3cOqcvqM+mebyR4k7qUzOGXZjo6y7dGzZRtuBnwkxkZVVy72hp8X/VsMi3ZGZP/9hBw/
         PuwgglzsRipr2uCEZxTgYi5nkz37SN8lxj/HqPNfz+gBLOpx7ArnUkf+tENJIMSblrLF
         GEZw==
X-Gm-Message-State: AAQBX9esJ503ruRcjbRXPCaW/ssHcokIqkGnjD+xvbTVcmn4VitHekMn
	oFMlJSlWrLjv7IOJWZe769rw2hX14RlFV9pTngjvSoc4
X-Google-Smtp-Source: AKy350bqaj7Z/mwWFK10BGpu7IZNymlKLRzL4fuUng+j1Zss6Bm9ge7vLXXxnbcui+pzaou/C9m/5A==
X-Received: by 2002:a17:902:e808:b0:1a4:f7b1:12f1 with SMTP id u8-20020a170902e80800b001a4f7b112f1mr2598882plg.4.1682004613946;
        Thu, 20 Apr 2023 08:30:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902bc4500b001a68d613ad9sm1317072plz.132.2023.04.20.08.30.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 08:30:13 -0700 (PDT)
Message-ID: <64415a85.170a0220.577a9.27ea@mx.google.com>
Date: Thu, 20 Apr 2023 08:30:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.4-st20-1099-g7b2580e1565dd
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs,
 2 regressions (v4.4-st20-1099-g7b2580e1565dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Apr 2023 15:30:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11255

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs, 2 regressions (=
v4.4-st20-1099-g7b2580e1565dd)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-1099-g7b2580e1565dd/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-1099-g7b2580e1565dd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7b2580e1565ddf95b5123aaa9a1f4c33e354e397

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  458f3554675aace42e9750086d26799e82829f11 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64414d8ba3bd164a952e85e9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/64414d8ba3=
bd164a952e85ea
        failing since 29 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64414e16359e0b192d2e85f2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/64414e1635=
9e0b192d2e85f3
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43) =

 =20

