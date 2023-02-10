Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F6DC636D3
	for <webhook@archiver.kernel.org>; Fri, 10 Feb 2023 11:48:25 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.12623.1676029703194124141
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 10 Feb 2023 03:48:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=cf/WYQmi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id k13so6256432plg.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 10 Feb 2023 03:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DtAw8u6gfwj++O1sUvRvatq1skVmOdUXMQ2iEzKi0TA=;
        b=cf/WYQmimE0+y9+URUqJ7/4e8Tf7gp9o48a7g+N6iP66zXFj2aUoSK0f/f7h6P0lsM
         pF0DVswqMeWs9X8nEVIw9+TCY7ZE4L2O6ybi+6RMIIYcgCvxDuKPhBRJ1QXzftm9OxWP
         o9+6IhhNedvXfGV6gqMOcva+uz4Heh6GGQzNHFS0xtFaDdcHgcgODlB/3qzn3rmAYd1g
         8FiismC+ENGWzUV2nIFKPHg2y6yF4guTfLNfE2OBwVtr1sgSneGAijUEmIt4KTOnXZG/
         WQipTyIFc8X7/in2N47qVqm2YK+Z4X+xeuF6TBoPPCN69xNIgi8xLK3qsc9LZKe3GIFu
         POwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DtAw8u6gfwj++O1sUvRvatq1skVmOdUXMQ2iEzKi0TA=;
        b=hvM01x2f3T3vh4lkUBTgXkvLpcS5uHqqaOXzgWzpkHyClNURF6vKs9E7aWmjSfrzCr
         eGtjtjPu45bGmNxxcDfZOI3TSgax8pyTDgESK2+NxCPSY+2t4utbml4NDNdXKg0o+P5n
         UpqBdaUf3f8N5QuZwbyA/wo0C6N01kklob6xc5J0cojPoHYNA2m/tz2UyTKF4kSBUeeE
         +cm4BpFdIVaBq2zS5ago3Ek0MBq0+bTF/Z9GUWB/Yi30K2c7qgVzQEqHaU7sz95f8TYf
         CX29m5Bu5W5WKYXVDrOlWW7PSii/uPuxdFCfg8QiHU0HcnMBALLLslCg/DnbvUeksGsZ
         LNeQ==
X-Gm-Message-State: AO0yUKWpPBlFrU5bEffdoFuspGskLcxcYBGQCWQIXiw7AAGALTgXc8ar
	keIXhV+Q2XFGMriCrC7FkOGm+YRaDT37U8yZ5uQ=
X-Google-Smtp-Source: AK7set+V32ndrraJ6guIEm9mahwP5QBM7TTtScwk1Aq1txn3WJbqQPt6mzABf2pcjqR/elabeuY4pw==
X-Received: by 2002:a05:6a20:3d18:b0:c3:801b:4259 with SMTP id y24-20020a056a203d1800b000c3801b4259mr5808815pzi.60.1676029702512;
        Fri, 10 Feb 2023 03:48:22 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x14-20020aa784ce000000b00593ce42db6bsm3129784pfn.59.2023.02.10.03.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 03:48:21 -0800 (PST)
Message-ID: <63e62f05.a70a0220.c1998.56ee@mx.google.com>
Date: Fri, 10 Feb 2023 03:48:21 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.272-cip91
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip smc: 4 runs, 2 regressions (v4.19.272-cip91)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Feb 2023 11:48:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10648

cip/linux-4.19.y-cip smc: 4 runs, 2 regressions (v4.19.272-cip91)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.272-cip91/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.272-cip91
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a308535fd0f82d23c6acc4bb20c69066ca01bdd6 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63e62bbec0587285de8c8646

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.272=
-cip91/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/63e62bbec0587285de=
8c8652
        failing since 216 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-02-10T11:34:13.271280  <8>[   11.345472] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/63e62bbec0587285de=
8c8653
        failing since 216 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-02-10T11:34:13.261265  <8>[   11.335677] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

