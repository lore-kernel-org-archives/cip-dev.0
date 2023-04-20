Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DACCC7EE22
	for <webhook@archiver.kernel.org>; Thu, 20 Apr 2023 15:30:19 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.11411.1682004617447122040
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Apr 2023 08:30:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=DVW8yRtL;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1a6c5acf6ccso10072065ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Apr 2023 08:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682004616; x=1684596616;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vNmSffAExmGgKr+QmoNQbg8MZQfdZmIWKL2eqgbq6pg=;
        b=DVW8yRtLCgBTseFYkb3ADhcx6SgiCzrs/Pc0f7rMW1sZTgHNn91a+K9VEMk+fkzCAl
         uyBo7v1pmSwQp80TpotsTUZTL0kIxOQThKj69azgdZQVLuxC84XQBlMAmNr+gVu+J0kp
         NRD3vNxf8n6CRPu7TIqouf0/5W854AivozE3zDx0mg+5fad87ukAicbgZFgaGcDIHeVn
         3Ve0gtaipoCcV9n9cUAKUEmBwo9bdTqRbfOUpakwGRl6DRBVxWDaFk4S5dg+1Oh0HJYN
         SGkR0kRKzvQ6K25ISr0EjIs3YdjJtUZPKMgNEvRj5WYZw2YtduVzqp1eKouG2Z5aIkPP
         nI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682004616; x=1684596616;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vNmSffAExmGgKr+QmoNQbg8MZQfdZmIWKL2eqgbq6pg=;
        b=huh6r1YyvaN52DabfKvQ1+EZgW6xb9FjcvS87YdHQULkw6sFW6aIwxweJJc8rCzJNx
         pVPiEK5vKdxoPZyEVZgR0h4j0qL54SqwQzGCaTv63Znn95HAlZ2RxeBL1a206YCB+iOR
         mgUxuqUT7cgHKlfDsqeuG/vZHKCs/yzHQYagRQF9tKDHOeFujqPqe3DoABykcba3TLKA
         ood1vKITjK/zO/L2MImMDpHxgBJzbOQl2eu5f04uiDa49jHbwQFtHAjZ4inmVhm6HfBo
         PZnRS7UWRCA4U0uVt6tO9vPcIPQrJgUKLiytDEjvL70CNo6wvzRoK9lHAcBSkg2pLiuT
         oLnA==
X-Gm-Message-State: AAQBX9fcMavFnot+nSXHMAHYLjOV+v/qjxcWn29p/KlanT/8PoalnX8u
	5FTAhL+DjV8Agr5XyGjZL2q6trsadT2szExR3LRY8GlJ
X-Google-Smtp-Source: AKy350a4pQsb3lIpSqVRslBvkittuo9wHq7VeYDhf6v5ekj4e2bfgw8KFzrgpTNN/5DV83qx9mRrBQ==
X-Received: by 2002:a17:902:ec90:b0:1a6:d774:339a with SMTP id x16-20020a170902ec9000b001a6d774339amr2578150plg.4.1682004616598;
        Thu, 20 Apr 2023 08:30:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x14-20020a1709027c0e00b0019a70a85e8fsm1300189pll.220.2023.04.20.08.30.15
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 08:30:16 -0700 (PDT)
Message-ID: <64415a88.170a0220.139a7.2aa4@mx.google.com>
Date: Thu, 20 Apr 2023 08:30:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.4-st20-1099-g7b2580e1565dd
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test smc: 3 runs,
 1 regressions (v4.4-st20-1099-g7b2580e1565dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Apr 2023 15:30:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11260

cip-gitlab/ci/pavel/linux-test smc: 3 runs, 1 regressions (v4.4-st20-1099-g=
7b2580e1565dd)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-1099-g7b2580e1565dd/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-1099-g7b2580e1565dd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7b2580e1565ddf95b5123aaa9a1f4c33e354e397 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64414fb7da12280bb42e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1099-g7b2580e1565dd/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/64414fb7da12280bb42e85e7
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43) =

 =20

