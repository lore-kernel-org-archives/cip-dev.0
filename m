Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C26C54E49
	for <webhook@archiver.kernel.org>; Fri, 23 Feb 2024 12:22:27 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web10.9348.1708690944825162975
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Feb 2024 04:22:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=eTt/Dw8a;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e4cf3c5658so153361b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 23 Feb 2024 04:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708690944; x=1709295744; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uawbNhKy//ggVw9ydmMKz4WCdN4RhPPdbwL+vCSbH3I=;
        b=eTt/Dw8aZxNBmwrVxtxdAsI0itqGktIF1jsCVrU2+KIgVZrhpP0eq6dFF+Kih/n2UT
         cqp1sKrqGJCO//3RmDh66iJ4ptluwLoRJujiXtSSJ/ai5gG3hobMFJWb96pZlYDI+2uG
         KaBVTkrQGGZwpr9AzI0E3wp55DRwd86eb40lFFfjeRO2+Sg96yoAgqaSw6H7BAIb6c+S
         j+ckEVomAkPr9w8FS2Qq8ANS/QYKaVrL4wlsCYkPnVNjrs+Zs0ZKTxJNL3av5PrWAocj
         xVkfORT2lq5fc8x/FTAr1nOGcJ95GueUqBwt+Nh52tgAbSjzlPKBdE2sEU1YHtcuwU5b
         W70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708690944; x=1709295744;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uawbNhKy//ggVw9ydmMKz4WCdN4RhPPdbwL+vCSbH3I=;
        b=PPW2Y+pv2b24poho+vv30lApDYtE+XRGXrQRLt7uQRHmof9vF9Qhzp6QmIOWbJvlSU
         2MBuEwJMgfvImriHhrIMz99ezGUn5GiPhgZhXiToeNLyprgq4iz0Ahnr0WD9ciYUIGdb
         CVhL4MhJjC7XmvMT2tvPyH+DKxnUT2JzVUU2Y8ubDQAW6WuZEJKLoJtKXR/Uu9EwJ90w
         pvOMLgwNPCx+TznNBQjar20CEltBQ0KtA23b1WHtq3qN8N8n/rJM2pDRYZxnBH9ZuTL1
         09nwcgUl7Bac44ku2wlbfhrjHbEjezxbI/H5bh0XbQJg6UUF1A0sABv6wEcp63bBfeia
         DVmw==
X-Gm-Message-State: AOJu0YxRhLCkmVQcUaHa8AihKlCA4v8+0KhAGMGx7KXkZeobWea96qiy
	HBkX48kTZZAXHobDWvUphMpDELqMVr8JNHji35V5MTNYW27v6/DCrfI/7ldw81IjLUtsW4YlEHm
	VvC4=
X-Google-Smtp-Source: AGHT+IFp7tZiBoZAnkLF+6uqcyKn1EDPnbB5mY9+PpfvXVtYRkfjs8Xdk0mY3Dm4Clhc0XTBuWEEoA==
X-Received: by 2002:a05:6a21:3115:b0:19c:93c2:7ef3 with SMTP id yz21-20020a056a21311500b0019c93c27ef3mr1198643pzb.46.1708690943512;
        Fri, 23 Feb 2024 04:22:23 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n3-20020aa79843000000b006e319d8c752sm12171456pfq.150.2024.02.23.04.22.22
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 04:22:22 -0800 (PST)
Message-ID: <65d88dfe.a70a0220.7af5e.6d9b@mx.google.com>
Date: Fri, 23 Feb 2024 04:22:22 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.306-cip107-201-gc2afc54e2d6bb
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 91 runs,
 3 regressions (v4.19.306-cip107-201-gc2afc54e2d6bb)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Feb 2024 12:22:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15079

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 91 runs, 3 regressions=
 (v4.19.306-cip107-201-gc2afc54e2d6bb)

Regressions Summary
-------------------

platform          | arch | lab         | compiler | defconfig          | re=
gressions
------------------+------+-------------+----------+--------------------+---=
---------
at91sam9g20ek     | arm  | lab-broonie | gcc-10   | at91_dt_defconfig  | 2 =
         =

r8a7743-iwg20d-q7 | arm  | lab-cip     | gcc-10   | shmobile_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.306-cip107-201-gc2afc54e2d6bb/plan/baseli=
ne/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.306-cip107-201-gc2afc54e2d6bb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c2afc54e2d6bb0bb2a9214444545a17298928975 =



Test Regressions
---------------- =



platform          | arch | lab         | compiler | defconfig          | re=
gressions
------------------+------+-------------+----------+--------------------+---=
---------
at91sam9g20ek     | arm  | lab-broonie | gcc-10   | at91_dt_defconfig  | 2 =
         =


  Details:     https://kernelci.org/test/plan/id/65d87b9cfcc1c32089637086

  Results:     42 PASS, 8 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-201-gc2afc54e2d6bb/arm/at91_dt_defconfig/gcc-=
10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-201-gc2afc54e2d6bb/arm/at91_dt_defconfig/gcc-=
10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/65d87b9cf=
cc1c32089637091
        failing since 28 days (last pass: v4.19.304-cip106-27-gf3e967c370d4=
4, first fail: v4.19.304-cip106-176-g770d0422c72e9)

    2024-02-23T11:03:47.275278  /lava-621534/1/../bin/lava-test-case
    2024-02-23T11:03:47.309936  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dsou=
nd-card RESULT=3Dfail>   =


  * baseline.bootrr.audio-card-probed: https://kernelci.org/test/case/id/65=
d87b9cfcc1c32089637092
        failing since 28 days (last pass: v4.19.304-cip106-27-gf3e967c370d4=
4, first fail: v4.19.304-cip106-176-g770d0422c72e9)

    2024-02-23T11:03:46.189388  /lava-621534/1/../bin/lava-test-case
    2024-02-23T11:03:46.224191  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Daud=
io-card-probed RESULT=3Dfail>   =

 =



platform          | arch | lab         | compiler | defconfig          | re=
gressions
------------------+------+-------------+----------+--------------------+---=
---------
r8a7743-iwg20d-q7 | arm  | lab-cip     | gcc-10   | shmobile_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65d88167f895a92a2663705b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-201-gc2afc54e2d6bb/arm/shmobile_defconfig/gcc=
-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-201-gc2afc54e2d6bb/arm/shmobile_defconfig/gcc=
-10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65d88167f895a92a26637=
05c
        failing since 28 days (last pass: v4.19.304-cip106-27-gf3e967c370d4=
4, first fail: v4.19.304-cip106-176-g770d0422c72e9) =

 =20

