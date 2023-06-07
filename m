Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0A2C7EE25
	for <webhook@archiver.kernel.org>; Wed,  7 Jun 2023 14:49:45 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web10.82.1686149381331872253
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Jun 2023 07:49:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=wxPvxyEU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.182, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-53f7bef98b7so6625806a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Jun 2023 07:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686149380; x=1688741380;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3c6N1im0Xo+Zi6N5zwy8pvx3fPYyB3XNVz8y/P1gHB4=;
        b=wxPvxyEUmrCX88QfugVa2QoIs7G+gQqf6cY1R46b05VGPSoze+woGBqy70XoVJ+M4V
         qguQTQytnRxv6GDwRy90DBmhbGdG4vXccVueMvOrufdxuSYs+Du8M/W0OYqeLU65YFVF
         U3swdl16BTq28kBvIBGaR+0GxTZpOhI6G7hPG3YHJhiZZGdcv6GeAooTZZQMlLl+AccJ
         G0TgsgjAMhpzx3XBuQKaOfKzLS4/OO3//f36KfNLhlLdhTLuy1Rbus86737EydUdNRJv
         r/0XWMKSbE4JP02uRFMsAtaabWnprzt8Ey8ohKDb6UWEh/h3DT6OATiL0ZUkWhDtNmrs
         IWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686149380; x=1688741380;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3c6N1im0Xo+Zi6N5zwy8pvx3fPYyB3XNVz8y/P1gHB4=;
        b=dY7EypRs8DLxOaWGh9e3All5dJ95IRbYG13OWL0qnews9G5PknuOpzmZKsDRCnuWpr
         t6BakbF9wvyKh2a2z7ntsxc1dzUMYkbWIxDHMhxAbdDVraggRRB0B7JFxCilO/0Im0YR
         b3ozZCo7h+FFxsAiR+Xj21cgQjkZUVlKpAk1MubJ6Yhx5VZpAWcjWKhi8Knf/asVWIIr
         MStruWBsksDJevNLWX1ubz/bvTpwiWaUGc1tCrmKKTvTXsZZ4rfutVIjf55dT7payuct
         02EEWYeKVsIEFX9M0O5VGorpqqB5G+QV2m/ZbP+N/ZOaY5okJKBc+zKwDNVrIc77PxzN
         t6hA==
X-Gm-Message-State: AC+VfDxTbOrfrC+rZzFUdSM/ellJRm1mAMUmGcYtRyUK0jEPEF6FNhJZ
	Y9DeNCqM7+2aJKUg2QuIbIeyV2HHFyCBMPRVTKihQA==
X-Google-Smtp-Source: ACHHUZ50M8VM2mvEzBW3ZtKB3SJ9wEkxl67uSIzV/iaAuSLucQpa8XJNxwFAWrbS0bVrpig5saj3yg==
X-Received: by 2002:a17:903:11c6:b0:1b0:1608:d7eb with SMTP id q6-20020a17090311c600b001b01608d7ebmr6451075plh.5.1686149380363;
        Wed, 07 Jun 2023 07:49:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902b78400b001b03d543549sm10562788pls.72.2023.06.07.07.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 07:49:39 -0700 (PDT)
Message-ID: <64809903.170a0220.13fc7.3fe1@mx.google.com>
Date: Wed, 07 Jun 2023 07:49:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rt
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-2172-gb3363b986efb
Subject: cip/linux-4.4.y-st-rt kselftest-filesystems: 6 runs,
 1 regressions (v4.4-st20-2172-gb3363b986efb)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jun 2023 14:49:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11915

cip/linux-4.4.y-st-rt kselftest-filesystems: 6 runs, 1 regressions (v4.4-st=
20-2172-gb3363b986efb)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rt/kern=
el/v4.4-st20-2172-gb3363b986efb/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-4.4.y-st-rt
  Describe: v4.4-st20-2172-gb3363b986efb
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      b3363b986efb791c4506119c9fbab1b52628f0c7 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6480842866f6c206143061b4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rt/v4.4-st2=
0-2172-gb3363b986efb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/kselftest-filesystems-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rt/v4.4-st2=
0-2172-gb3363b986efb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/kselftest-filesystems-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/64808428=
66f6c206143061b5
        failing since 120 days (last pass: v4.4-st20-1094-gf7138ca4b303, fi=
rst fail: v4.4-st20-1684-gd04aea87b5a3) =

 =20

