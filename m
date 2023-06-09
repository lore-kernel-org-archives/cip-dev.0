Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF2EC7EE25
	for <webhook@archiver.kernel.org>; Fri,  9 Jun 2023 16:20:09 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.17654.1686327600711838370
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Jun 2023 09:20:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Sefcu4dT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1b02d0942caso7445985ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Jun 2023 09:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686327600; x=1688919600;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=313XSOL4HPGZsG4nPYep5Q/Ak9u5kInvQqu2O9nFyAo=;
        b=Sefcu4dTdUwb2wRJ3fjKMVnYclnyqg+PJRQNYHeim/Ih6KwLSVf0PwpflWf3etB+W6
         SfXSnts81uxUpNQmZuHtL26kT6f7aO0HerlTvBWFpy07UdTmlSrQRMUXoWCc5jjq62YC
         MQLN+8dCWK1QM8ns9vT7sQYd8nRK4Zn/1B1kiyfb8MJfK6UjPqks/Mw6/zZIn4epGmYo
         EcwlLuengrGC5xNCxGprqj57SSewsZzq/Zlk1u71VnbRjwlishoswjJEPxMKT1oVgK5L
         VnSktYlI8wEywn/O1oi4pEWebQoTaklB44Qbs39IMjelQPYYNQ1SyQ+/ThqK+nlkTvGc
         Bc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686327600; x=1688919600;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=313XSOL4HPGZsG4nPYep5Q/Ak9u5kInvQqu2O9nFyAo=;
        b=kiytWNMD6KGIiLtRmfzx6Y37JgH27hjSoWwMM62otDho/EyqzL1iOS8qJL8Xs2bKoW
         7wSZTDxEG9MYlsRnm+gnE1UQVzUzXvELhHjf+q4ZpSb0IjEXDd6kPLID2c0Zereue1SA
         XVq7HEylxev+ePqSeJS1MjLhBJQYEDKlWt7q1npYjYlYc4U8ZjBXJzaCBrxzNzu1WpaI
         qtQevE4oM1r7h2PFyHurvPjOKIk/TgbDbLTwca8FokKfCJ03C5zPZWgyf2swJDfr3/Fa
         vdcVY0wzc4DzGkBqBzFcFsWMy0FBguL1G2EuqwxypJ2iJptIQlIxdy4jQBSSDctZ+fQf
         3zSg==
X-Gm-Message-State: AC+VfDwVGrpjesHp0YMDpirPr/1TmzJsgTvjDaK7vNQvYRfvrwIIY3aO
	RT83gFV3aYwwtuE0m9ZSVL4mLH0XR3+AvNLFaEvo5A==
X-Google-Smtp-Source: ACHHUZ7Y1B7p9NBzZEQtSIlTNAeCyn1Fa/lTZBXnioisFNp73NZ+8nxZ4SrTQ4spRD/r2zy30fqsMg==
X-Received: by 2002:a17:902:8645:b0:1b2:499f:672c with SMTP id y5-20020a170902864500b001b2499f672cmr1273751plt.33.1686327599840;
        Fri, 09 Jun 2023 09:19:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b001b1c3542f57sm3469865plb.103.2023.06.09.09.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:19:58 -0700 (PDT)
Message-ID: <6483512e.170a0220.64194.7320@mx.google.com>
Date: Fri, 09 Jun 2023 09:19:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.284-cip99
Subject: cip/linux-4.19.y-cip smc: 4 runs, 2 regressions (v4.19.284-cip99)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jun 2023 16:20:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11948

cip/linux-4.19.y-cip smc: 4 runs, 2 regressions (v4.19.284-cip99)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.284-cip99/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.284-cip99
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a13de4c6b84ab64a5cb3ef5e852b1620686d0309 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/648348f77467cac31330613a

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.284=
-cip99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.284=
-cip99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/648348f77467cac313=
306146
        failing since 335 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-06-09T15:44:48.036407  <8>[   11.632318] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/648348f77467cac313=
306147
        failing since 335 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-06-09T15:44:48.026458  <8>[   11.622530] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

