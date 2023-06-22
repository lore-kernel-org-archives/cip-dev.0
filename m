Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302C3EB64D7
	for <webhook@archiver.kernel.org>; Thu, 22 Jun 2023 02:35:03 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.1182.1687401293567577285
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 21 Jun 2023 19:34:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Mv9zrWmb;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1b51780bed0so51958575ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 21 Jun 2023 19:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687401292; x=1689993292;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qnyb3hfPmCywiNvAtiy4tXY4rPgxWMJFn8Bxtv5wKwk=;
        b=Mv9zrWmbvPea3vaxMyQe01k2Noz+7NZJNNky22g3P2Q3dNm/ST9eqK0YeYkBit7bVv
         pFCh8mWSEr63WR1NSbWpsYQowHUWGBxXMCftZ6QedKKx1N3puiQbYNSIs1O20AhCupzg
         ziYdKqeMaKbEewH3u/6a0JRgNQ1u7/FIrrA2UD5elXPoOcU8LIE8aeYJzO3io2UbeXwN
         J/7evURavXYhgFKhNifXvyjCLtkGE7vm9m+90aAICcYNP2SV1VcsPc/5Enlgvoo6+VKx
         sDFc+g04ugRseJMnS8Oo0wIZun1uO6id0vaUjLHlZ0ylbppgRxbIV9U/5YyVgSzX6dQi
         +F7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687401292; x=1689993292;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qnyb3hfPmCywiNvAtiy4tXY4rPgxWMJFn8Bxtv5wKwk=;
        b=fJImf4mFyVugxJ6i89X+MF/HfxI6VI1tNOxdUiqSLkdHGzp4oMESEH3d4iHP6QzBL/
         mvy3xBvbjzC9bE8wTFubMM8OddEzyph0mkYiID/WkfXyyYMi8XxR+ViAv5h8AAnMU7Ik
         c/XWzetdlgrG/EwPGcWET3tyn706e4rHY62q4991yi8XLs11yduoOWMkJYqzvMSqEAGL
         pcVMUHTB4LYKGZiUyEWcsTrEZ1b7l25rpZ4zOVs8unuT0SfY/ODIQBtG8yGQ3UQ6j+pD
         0YIDMQGylWK1AuYdq4rszUhKnLFVLIQqKZ2tClXleTJP+aGG4o1EFuskhzts0bisAm2x
         A5Hw==
X-Gm-Message-State: AC+VfDwJP4C5qwIB5JQ4xdkPQfX91DJQoh0E7KRFhFuabQZwDm3UB/8J
	JX7c73tqE2hj0ueXukgwa8p8osRvdg9PcrUTXJReHw==
X-Google-Smtp-Source: ACHHUZ7XOfaQEeVSLdp2EERThN5w4d5+4Ouaag4ELTEymAQM3hgYaCBHjVA8vscf19HKMVTVY5vfSg==
X-Received: by 2002:a17:903:18a:b0:1b6:6b8d:9d9f with SMTP id z10-20020a170903018a00b001b66b8d9d9fmr9232447plg.59.1687401292590;
        Wed, 21 Jun 2023 19:34:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ec8400b001b682336f66sm3833093plg.55.2023.06.21.19.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 19:34:51 -0700 (PDT)
Message-ID: <6493b34b.170a0220.6fb5d.8c19@mx.google.com>
Date: Wed, 21 Jun 2023 19:34:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.184-cip36
Subject: cip/linux-5.10.y-cip smc: 4 runs, 2 regressions (v5.10.184-cip36)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jun 2023 02:35:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12112

cip/linux-5.10.y-cip smc: 4 runs, 2 regressions (v5.10.184-cip36)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.184-cip36/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.184-cip36
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f34f3ecd0387c3ad8b34bf65ac19ec84a38f2333 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6493ad1db2a4d8e044306139

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/6493ad1db2a4d8e044=
306145
        failing since 352 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-06-22T02:08:24.177774  <8>[   17.200352] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/6493ad1db2a4d8e044=
306146
        failing since 352 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-06-22T02:08:24.163838  <8>[   17.186734] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

