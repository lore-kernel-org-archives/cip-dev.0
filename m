Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF36C3F2D4
	for <webhook@archiver.kernel.org>; Fri,  8 Jul 2022 23:31:22 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web09.1297.1657323081196229605
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Jul 2022 16:31:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=BTCTQaKf;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.170,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f170.google.com with SMTP id q82so196531pgq.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Jul 2022 16:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=JNOUhgTJiY8FY91g/N787Grd36hUqeirGpwCv1y0YPc=;
        b=BTCTQaKfqRsey6uIb6pM5mopKqoatJkPNyfYou42LX3H4Szw7PUKzczpEq3eVNtSMM
         NAYN2IHq4CeK31+md0L3zA6fBazerMxO8NDsCKQXqMqPf3HNDhO+OBHHXOyVLLg9uctO
         dLkedyBMlwQXCRP0O8fIpejxB3lLQsFXPG1IKxykVMYJ8E7M3WWBaCYX2MLfrvsTpxXY
         +SVSKZ3x0EzFSAFPeUB03dH0xGoDnhHwXF2jnh5igX4iLhrAidJ0pGqlHOZ31ctoEkQ+
         A+6SEjxFHhbMHo1C61p1JBVoLJQWpMIiokQPlZyRmibgiHrveHf5VB9YTKGUWcJmlZOm
         Ugug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=JNOUhgTJiY8FY91g/N787Grd36hUqeirGpwCv1y0YPc=;
        b=gHzO9hEeZPYCnqoLxQhYqyWWsEuX00BhlH7CBW2Zt/mm1MeDrlRJk78WCIFKkuyoUr
         YnZszFUeXow4LsOHEzlfXUiuEhv508uSR/7QXe7X/8vGss5A/9MOrCzbtHLJbB8dULB8
         T8KNEH8IFNQ9eprEAiImaM9jQawzAUPa5NXDr+aYLVWreS7nqniQmepF7NvxiMBpzv1S
         KuoZLP5Mrld/GPuT01ePvW6Tzl58EvRR7R9VfboUns6I0iGMiameTDdrp8MuvFwQ4CYX
         nr67VzkB8P6v7c3gNih6G/2ojr7hlgAtmf0sWmtiFu+gUMV/5ZF26mijedgSKKo1TfkJ
         +n5Q==
X-Gm-Message-State: AJIora+1OaSFaVHs7kqcncy0R5PQJdRdCgEVhGO4L+qyhLt7dDLPPG9o
	cjKN2dcm0Dl+ARDcOwLW1LQUYMatmTMAPukl
X-Google-Smtp-Source: 
 AGRyM1sQPxR9+6FP1o8Qz9IiXHbCqrtC/EjT1n+7Wm8QXGKshB6YB0BJ0ZDiemBw5dHrxo1IOB/7XA==
X-Received: by 2002:a63:5a4f:0:b0:412:6081:6cee with SMTP id
 k15-20020a635a4f000000b0041260816ceemr5178741pgm.246.1657323080529;
        Fri, 08 Jul 2022 16:31:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 oa15-20020a17090b1bcf00b001ef8bf3c29fsm2206704pjb.57.2022.07.08.16.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 16:31:20 -0700 (PDT)
Message-ID: <62c8be48.1c69fb81.3ddc2.384d@mx.google.com>
Date: Fri, 08 Jul 2022 16:31:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.251-cip77
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip smc: 4 runs, 2 regressions (v4.19.251-cip77)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Jul 2022 23:31:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8732

cip/linux-4.19.y-cip smc: 4 runs, 2 regressions (v4.19.251-cip77)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.251-cip77/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.251-cip77
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e634159f2620ade28a9251a9bc2cc23b84f527f2 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/62c8b08545ec5c16f5a39bf2

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.251=
-cip77/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/62c8b08545ec5c16f5=
a39bfe
        new failure (last pass: v4.19.249-cip76)

    2022-07-08T22:32:26.655154  <8>[   11.467073] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/62c8b08545ec5c16f5=
a39bff
        new failure (last pass: v4.19.249-cip76)

    2022-07-08T22:32:26.644343  <8>[   11.456246] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =20

