Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D49EB64DC
	for <webhook@archiver.kernel.org>; Fri, 14 Jul 2023 16:26:15 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web10.3310.1689351973007079445
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 14 Jul 2023 09:26:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=lzbMrsfK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6686c74183cso2036356b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 14 Jul 2023 09:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689351972; x=1691943972;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nuGkJbOSjWlvrTMNoJypWJn6MBmKqdJMdJ/4KlK+aZU=;
        b=lzbMrsfK55owGBh8ZZQabAdm1rqPotLm4OL+40rC19YiHHEVy6ZhYiXX2SVEkpAJGk
         UhYDIOXvWAUg5PWQRl7hjDvMQxVGyq9WnIHJFCodzj9bCc3oWAV7RWs+T20KbIN7aH8o
         kjT8i2KWEvqeDMfjHojuaamw+MbP7Kx/c7xolB9APiL5WvgkPgwCZ44rLEbQ18aEAjwl
         ZSxxCVgc06Dv2PnxAzk9T6uitiaoT2t/afBP0A+ABvNTvNi2MTaK2CZO8MimyzQ5ctQp
         M0XzuiXzfVwxw5BUT1CQL1oOFGE7cGeujHgOIifjw62QM58CmJQJTshLhOVZBRt1MJON
         lkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689351972; x=1691943972;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nuGkJbOSjWlvrTMNoJypWJn6MBmKqdJMdJ/4KlK+aZU=;
        b=MoHwiMqrOZts5F8ZHEHc4+yCzOzC+j//l+f7i4NzZPdRSj5BQzWC+LPTsiiQIzL4Ei
         ztcLOPq9ZCtHFyaVwxb39Vb518lXkPque6ZVa4iyip4qZ3BjRBwXfVZEnHg8plGCHUdX
         NeJxMwTetqOi33EFwVb+WMqowGz1O7Bv5/fc9Xzew3mVt+vZCNBZSF3mDwIlGvuJl4mc
         cndbAwMOO6moFQChhNuAYRdk1JQDDvOSSKKdOAUAOKAQDLPr6abRhTywBop6/uhckcwh
         P5EvYfl5mO5VDPl0g2J9yGIjHL1aA4sB49gPV9TnwrTuf9xin4/bCFd5qLSRJW87vEDh
         joBQ==
X-Gm-Message-State: ABy/qLZi/XkHb5WcuQKi9RkOl1q/CUG0OLrdpb4LGun9HV3LStuKvkOu
	+tZEJBUo2G3dHywcVHQaJYLMeKZGFZClCj0gsCcEpg==
X-Google-Smtp-Source: APBJJlEsrLPgny9XXfgt79VWid1PRSflUiZvI2Xt83mJEK96pIm329iJgiAp31HYJet5VPq/PIKWmA==
X-Received: by 2002:a05:6a20:13c6:b0:132:bdba:5518 with SMTP id ho6-20020a056a2013c600b00132bdba5518mr4395200pzc.54.1689351971909;
        Fri, 14 Jul 2023 09:26:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fe23-20020a056a002f1700b0066ebaeb149dsm7363461pfb.88.2023.07.14.09.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 09:26:11 -0700 (PDT)
Message-ID: <64b17723.050a0220.5c361.01e8@mx.google.com>
Date: Fri, 14 Jul 2023 09:26:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.288-cip101
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip smc: 3 runs, 2 regressions (v4.19.288-cip101)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Jul 2023 16:26:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12352

cip/linux-4.19.y-cip smc: 3 runs, 2 regressions (v4.19.288-cip101)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.288-cip101/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.288-cip101
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      9c3f27ca919fea575a3a1c378bd95bcbf2c33ca7 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64b168d42307fb3cd48ace33

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.288=
-cip101/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.288=
-cip101/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/64b168d42307fb3cd4=
8ace3f
        failing since 370 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-07-14T15:25:11.381434  <8>[   12.075994] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/64b168d42307fb3cd4=
8ace40
        failing since 370 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-07-14T15:25:11.371359  <8>[   12.066430] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

