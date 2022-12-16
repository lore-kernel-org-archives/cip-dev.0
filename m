Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAFDC46467
	for <webhook@archiver.kernel.org>; Fri, 16 Dec 2022 21:10:41 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web11.6526.1671225037073044707
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 16 Dec 2022 13:10:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=HdWuNq9t;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so7340054pjj.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 16 Dec 2022 13:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YpatX4YWgHhAKk5ORiT8aGhaqJ/EVM+Ir3Hf3xW35K4=;
        b=HdWuNq9tVozPtjb0Itrf+dJhmJfc195W1xGVWmWpc/cZ1YSK+100Bvcs0DnqRBb531
         cEfsXu+LpnJWDBMRSUuqd8pg6UdxhSrjmgV43aUSVKByHIi4Dwy3z4Dv7UQ2zclr+9f9
         jh1O32QC+RRdjr6NSDlj+fZWW0bhrKhH/4pGV5sbWx0RvlxJZA8xcky1tMGc9kpxK9xD
         sRMIZkj5/f4LK8x9L26DypyicmZyOmwHv20r+H8UzE4d6v7I8JDFPF4DK7cCKCkcOglD
         /cNiRIkBmRpAIJcvAeXAqyAA6KAAhxZXHQExbKy84+U7xl0nv0JscljRU30sOEJZNAWO
         vtow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YpatX4YWgHhAKk5ORiT8aGhaqJ/EVM+Ir3Hf3xW35K4=;
        b=DYSKsRHrxvDZrRiv78DokxoJ8qcKG76hRvBDGrXQ/56c66OzeApLEYBeNho3zJ1Ame
         +bKzSmn3RcJnkkPmOExpYCAIqeZZhEVjl70X5ByiHLrXl8Q35cibmXtLJlE2p6/dkCDi
         pWlVoEdhc3mQCKAqdpdqHvgk3g0cn37KED13TvhMo75YgeOPycLrzi+q42BkjC+xI3mD
         RuHqG/wEY5s91Gc+82VlZjaaSsXCCzH6MP47El2sZh63MfpQzrIUB+eOgeOZzi+b/XBs
         RXE59an4U0m4maf5w1Y1dPFTSUm/XqfKg3WLA2OS2JMzHC2fnF8YqsZb8bC2jsX6Rlv4
         vx+g==
X-Gm-Message-State: ANoB5pkDE7xjWQ2rEXBInx6x28HzhZ5w2ieSviRYhPTszV2erLsQRQ26
	bKff7RAvhkVY0tVY/J3S9xG84jZY7JLuZ7ZZnyU=
X-Google-Smtp-Source: AA0mqf5V5ntIWtTFRvyqLU3iJaT1kTZtjyaYmaXYZRRdZUWEPkFM+dmWJSRoBsG45nthIYZ7mVPBrw==
X-Received: by 2002:a17:902:b087:b0:189:e81b:d254 with SMTP id p7-20020a170902b08700b00189e81bd254mr31155590plr.60.1671225038622;
        Fri, 16 Dec 2022 13:10:38 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ix6-20020a170902f80600b00190cabbe35fsm2061434plb.98.2022.12.16.13.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 13:10:38 -0800 (PST)
Message-ID: <639cdece.170a0220.6b966.3fec@mx.google.com>
Date: Fri, 16 Dec 2022 13:10:38 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.158-cip22-7-g92462fd9830b
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip smc: 4 runs,
 2 regressions (v5.10.158-cip22-7-g92462fd9830b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Dec 2022 21:10:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10248

cip/linux-5.10.y-cip smc: 4 runs, 2 regressions (v5.10.158-cip22-7-g92462fd=
9830b)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.158-cip22-7-g92462fd9830b/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.158-cip22-7-g92462fd9830b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      92462fd9830b23227198482fe4bee42316a5694d =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/639cced50fee3f7dab2abd2d

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221209.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/639cced50fee3f7dab=
2abd39
        failing since 165 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2022-12-16T20:02:20.822679  <8>[   13.138010] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/639cced50fee3f7dab=
2abd3a
        failing since 165 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2022-12-16T20:02:20.809335  <8>[   13.124267] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =20

