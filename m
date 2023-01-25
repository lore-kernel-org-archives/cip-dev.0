Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E30C54E94
	for <webhook@archiver.kernel.org>; Wed, 25 Jan 2023 03:54:03 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web10.37495.1674618833630682937
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 24 Jan 2023 19:53:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=LiFlX9hk;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so782009pjl.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 24 Jan 2023 19:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Np9w1RKuKqW7GHFwCE5Wfo5cZAF79n1gsEgqO8sXYL4=;
        b=LiFlX9hk3XFk46lAEDRUclJ/KX0n8bRDm47cyJOb4QWEq6eE0Xr2TEXyJbl/Yhd+cu
         IV1mKWcn7FF3Qs2DKz+QqDn3NQOJliiMpwWnxIdZGxgskLUMyPkNkfXNnzgAciQLlz0S
         C4wuIBVBOj6sJCdIjLPrwbmv7MM3sDWMSX4Lthth67SwAgOjxSG4aXUMNFB5lrfQ+l1W
         kY+BVF1zXRdFt9rS2eRW05KDH/1VOd5RHxF34utbbCc6IF2sKbtDeRwTIu7q/MFR432b
         /oSTmgTlTXDl2rHs8kYvHyb6xTO3ZrUnaBwF1aZuRLIeKGRY8yqURVWz5qCT/ZNKq1TW
         ARdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Np9w1RKuKqW7GHFwCE5Wfo5cZAF79n1gsEgqO8sXYL4=;
        b=0QmJxYkec5xpFy6VuIOkJudcbXOEVeDBHm0VFi5Tn5+e97q7IsZE5AmoeYiHRZCs53
         bNlKxPZMqhaj7wdLoDkqoD15g658smLIHpcIjNCvjYPX7KnvcSFo4AgJ7QDbFLQStCgf
         601dYc1Ls8cxiVGiqgBmdETJSjol9UsjGbMC2xA+ObjOWZpRx624nokm+b/Hm3o89DuY
         3hzwCs0qp5Xp/Qvc//naQNh6cv2rjY/uPStT4XL4MV9IfKERtz8bLBbEeUip0bdpe405
         J/W5wFIPPvdQPkKH5F27EM1HGPDNTRPgqCeGeFwHko7xqHUOF8MkIEirZi0y7CSN3lLS
         ZuEA==
X-Gm-Message-State: AFqh2koaEPyMbnT3DQQt717xgHBqbGXqdMGVZprhBwYozn5OWttRicSf
	jYMTdKsJWx6ARAMaFV/ahf42k8YInsEhHl+V
X-Google-Smtp-Source: AMrXdXv+F52ioDK3mD107Oh46j0q4BRazzXvrd+CjTydVYWvawqTCJU6BG6JwrPflcTF3DynLqpZyQ==
X-Received: by 2002:a17:902:e88e:b0:192:b2d3:4fc8 with SMTP id w14-20020a170902e88e00b00192b2d34fc8mr39821720plg.1.1674618832868;
        Tue, 24 Jan 2023 19:53:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902db0300b001949b915188sm2474221plx.12.2023.01.24.19.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 19:53:52 -0800 (PST)
Message-ID: <63d0a7d0.170a0220.6e731.4bef@mx.google.com>
Date: Tue, 24 Jan 2023 19:53:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip71-590-g22fc523bf881
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-cip baseline: 74 runs,
 1 regressions (v4.4.302-cip71-590-g22fc523bf881)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Jan 2023 03:54:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10475

cip/linux-4.4.y-cip baseline: 74 runs, 1 regressions (v4.4.302-cip71-590-g2=
2fc523bf881)

Regressions Summary
-------------------

platform          | arch | lab     | compiler | defconfig          | regres=
sions
------------------+------+---------+----------+--------------------+-------=
-----
r8a7743-iwg20d-q7 | arm  | lab-cip | gcc-10   | shmobile_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip71-590-g22fc523bf881/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip71-590-g22fc523bf881
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      22fc523bf88173aa7805c4360b6581696228b140 =



Test Regressions
---------------- =



platform          | arch | lab     | compiler | defconfig          | regres=
sions
------------------+------+---------+----------+--------------------+-------=
-----
r8a7743-iwg20d-q7 | arm  | lab-cip | gcc-10   | shmobile_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/63d097ae347799d530915ec7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71-590-g22fc523bf881/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a77=
43-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71-590-g22fc523bf881/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a77=
43-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63d097ae347799d530915=
ec8
        new failure (last pass: v4.4.302-cip71-1-g61333eee4869) =

 =20

