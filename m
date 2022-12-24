Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F91C4167B
	for <webhook@archiver.kernel.org>; Sat, 24 Dec 2022 00:17:12 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web10.86927.1671841030510446038
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Dec 2022 16:17:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=L+xcinTI;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id o31-20020a17090a0a2200b00223fedffb30so6239107pjo.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 23 Dec 2022 16:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rVJz20vWKzUOVjsJiLMQ3Wiv3UCOPji/lqksRC5z0LM=;
        b=L+xcinTIt1xsuYVeWINJKMBuzjGAY94oK+isqrt/VaowD7yW3FmtAL9wQ/3aN2WwV6
         or1M71tC4ZocIEJVA/yakChp7/eAQ1ejOrRr2E/AiLsHVyW4qbV4s0MtqDRFtqEEnrID
         dusWBlFifs5Dlh/YE3xOiassyqHmZwIWUA0fxKEG+2w8TcYM0feLew+qKJw1eIMmjdVK
         bAEc7E5NpnXyfU5pB+hHdXZR0hTqkvihoBd5M9VISdUkIEMyqrJ486zyKC+9F+ZIx6Rm
         8e3uRYb71mhJU4MGnJ2p1ChwQ6uESRs4Y7yRl5qAJXRVLoO2FH/YQOMgqL3b4yXyBdBh
         vzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rVJz20vWKzUOVjsJiLMQ3Wiv3UCOPji/lqksRC5z0LM=;
        b=3nL4azmeEcqDqGJ/0sjq4oAZoN5HqmfP79/8YKPnIZ4r1eIBCGt0nB3mXCvyVk2Uv5
         6A/XAEPRzK3ktNBtVjt+PecWKZGowUerJZVpI78biKfDsXVhMawlGXFqoThDdO/EnCMq
         4hYWdObHxt59XQIboLT1a50UQn89Ud7nwnD5vmsc0Rq+DvjdAq/aBjF2PsbzX4IoKkp1
         b/VwdaIZ1eov9tXjW+L7ZpmZWl66JlNCfJEHQBkt7rUP3NDJTwAkCKqbVBp1HMnxtcRr
         Vd58Zt7lrHTwE596XZSh21pWqQ1SVjRbqlX7JuJCsTKOMHcThgOQH1sBT+V8aMXF+EIc
         3eGA==
X-Gm-Message-State: AFqh2kooU+1uJDBT4fqBvuVON50Ow31CBx28L7so1bwb325A6KDQomID
	8Jm7kB24hePdr51yrhDSWtI3xYH/tl5Clz7ZsFk=
X-Google-Smtp-Source: AMrXdXv932afG+BKzuUTygNpdSi4/ySc4erMLS3s9xStQ7bD6Us9Bo0Sa7nmCq1nsyxs/DUH/CTHig==
X-Received: by 2002:a17:90b:3689:b0:219:1be:6d52 with SMTP id mj9-20020a17090b368900b0021901be6d52mr12759780pjb.3.1671841029828;
        Fri, 23 Dec 2022 16:17:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id dw6-20020a17090b094600b00223f495dc28sm2734136pjb.14.2022.12.23.16.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 16:17:09 -0800 (PST)
Message-ID: <63a64505.170a0220.39110.599d@mx.google.com>
Date: Fri, 23 Dec 2022 16:17:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.269-cip88
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip smc: 4 runs, 2 regressions (v4.19.269-cip88)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 24 Dec 2022 00:17:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10269

cip/linux-4.19.y-cip smc: 4 runs, 2 regressions (v4.19.269-cip88)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.269-cip88/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.269-cip88
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      68472fb565eddeb233132b8be94440d06330ffbb =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63a637c7ad0c882acd4eee47

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.269=
-cip88/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.269=
-cip88/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221216.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/63a637c7ad0c882acd=
4eee53
        failing since 168 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2022-12-23T23:20:33.646465  <8>[    8.988150] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/63a637c7ad0c882acd=
4eee54
        failing since 168 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2022-12-23T23:20:33.636991  <8>[    8.977885] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =20

