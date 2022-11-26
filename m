Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C53C47088
	for <webhook@archiver.kernel.org>; Sat, 26 Nov 2022 12:03:05 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web10.68802.1669464179047276272
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 26 Nov 2022 04:02:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=MSANZrNC;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id b4so6274626pfb.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 26 Nov 2022 04:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/lFjSvUi8UK5yicCVrzqbrb1g5UlazES5hWBeijL/P4=;
        b=MSANZrNCar0T6LHKZz/FoG1jk+e1RQVp/Nfc0NWDeHxlnOFICvHEsfhb34NlzQBNWK
         y5qHuEJsveL/BonaYzKKaPI508RwxCULQ5EmPe7aM1Y80UteYU1HG+nzTUwtU8fe5DVB
         J2d8+h8FBEonyTzfSViI9UJAcNvnq3WtbwOWyaIiP4Hz6Q/3EUfVXd0bKb7+URV8UlCZ
         m+poZmnUysFLU1WCRqvm0hFfl1UrPd2QQUhRotb3wgpLmwgwd/G+wLzf09PSffMY2b8H
         Quts0CQLYU5l2+QgImpoo4WMyCk/FRazknFEZfFb6Xl4qgznuJ00GjqCZOZZk2keBEof
         LCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/lFjSvUi8UK5yicCVrzqbrb1g5UlazES5hWBeijL/P4=;
        b=w9EH7DM9clT4bhHNcwHneCRRLjDyP2bZiCot48xmnwcr2HJwj0VC8nSVlAlAdZFaCL
         CHKdrJUhjuTseWPr4JhQmruhhtAN0wNjlgReuYKL1986RcXhw4utDPdRyZoVkMV3mcag
         smdmw24tfV9NvXbAXQwNYkfmg507H0am64AE7ftMB4Lad7tJcNTERJkZxTzzGfSAE66n
         +zDqS1Lx+AvoNfv0fL0VWENMJG6gnVIEALAJApJkk/uwhRQX68UnEiTIcBYEOeWVhA9G
         ZBLmnGCyxWI11aFuAQMMDqueei9rqSwzAAjxNIHzkDBj1Do2VjyMarWYB1mA7WKoIcuh
         3Juw==
X-Gm-Message-State: ANoB5pmVCxAQxvGYKewxYw4Srge9WF7sA6N7GmKwFOg6uixfZcn04bXG
	mAu68VUB4wyMDG6GbB4MXxVvt8cdLagTvuM1e08=
X-Google-Smtp-Source: AA0mqf4v+/i+Xu7/EMJ7g24l96uWQLIFMVgtf2vg0ZtGZaxISSlkEVZDzySU0EyT8h7rdWr2u90Ylw==
X-Received: by 2002:a63:e34b:0:b0:477:de0a:3233 with SMTP id o11-20020a63e34b000000b00477de0a3233mr7301034pgj.467.1669464178091;
        Sat, 26 Nov 2022 04:02:58 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 22-20020a621616000000b005624e2e0508sm4569870pfw.207.2022.11.26.04.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 04:02:57 -0800 (PST)
Message-ID: <63820071.620a0220.5110d.626c@mx.google.com>
Date: Sat, 26 Nov 2022 04:02:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.155-cip21
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip smc: 4 runs, 2 regressions (v5.10.155-cip21)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 26 Nov 2022 12:03:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10122

cip/linux-5.10.y-cip smc: 4 runs, 2 regressions (v5.10.155-cip21)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.155-cip21/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.155-cip21
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      02e30f9cbbfce3d687cb1ab288e46ad20079e8e0 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6381f039286dd87c172abd36

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/6381f039286dd87c17=
2abd42
        failing since 145 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2022-11-26T10:53:37.855968  <8>[   12.645932] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/6381f039286dd87c17=
2abd43
        failing since 145 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2022-11-26T10:53:37.837538  <8>[   12.627607] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =20

