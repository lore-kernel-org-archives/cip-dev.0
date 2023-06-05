Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39EFC7EE32
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 23:40:48 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.133.1686008441353308677
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 16:40:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=JOXkNLmU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1b025d26f4fso47919985ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 16:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686008440; x=1688600440;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VEocG7ZsvLSEjRD1BhvUiNA/FJ11BFDLG/4CmsQNmNo=;
        b=JOXkNLmU8aXqUOvKfvRwVE8rl5rXRRJMcjq2akxmxLbG1jRTO37U0Gpix/HUS/itPV
         NeCr/D1nc54l1Kjd/WNpVDMZ6ePqdZBKFBCywaiBcL2UVFYzZUlsJIJ71uuimhk+k38q
         r2toiepmJgpDs8BsGnYMhGLEjyDcPH/XaTTvvZybUYhUB2NILljxPM5l+7xNVasfe42J
         /0wW5Onf9tU/Yi0Usvyd7ybCMEQIZ/Yp+NnhtQL7CkwxusE5ANjbfHkLaYhTKZ4/Y3Qb
         ZSuXDUoc/34gS4A5HktFwOvAN2IAspoScCyslAYhJpWuj1fSKUe2CuscfaNWICAl0C0T
         gEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686008440; x=1688600440;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VEocG7ZsvLSEjRD1BhvUiNA/FJ11BFDLG/4CmsQNmNo=;
        b=LgJbQq+fEzpEADoO6dnlPTebyda0JWYQ9GC6xsS9vNbrtawK1aO7l4fhMb421+8GTD
         IHn3nrsW+ohPRDk66CZX1epnSq1tnqxrVTLPsVOiFA2YugUgTTXs6Epj6tFwmya01scY
         RNkRkz43KHHOfmmvR1YiGJIJoEsksdX5zD34y/xdmkwrv3M3erXEuSAFG9zJrKm77mJb
         kKmdfPRemq9yAG24DfsRHgH/uUioay+4nPGIl/Wz5LcyBFmOjCLfukVkjQJ5PKrMhAFY
         T8DS2rC4LBT/YWK+ri+6xXKR/fz22WdaA2hhrKtLUg9BNCZ2PvulD2XZZBjIzxtjT6SD
         1NNQ==
X-Gm-Message-State: AC+VfDz5eUkyJASSzsKWbk8CQMMuTyRLNBJzecVPRbnSAui/rgqivd5O
	ifQm6KDdXVu0B6ijpoHdEROjT9Q8NeImYghSScwxxw==
X-Google-Smtp-Source: ACHHUZ7zlr+heGx/RifWP0tB7TulLiDWCpYwCtjYESad97QyTRDX9PmQjLVJM4PuMbduScM8cA9Ijw==
X-Received: by 2002:a17:902:7586:b0:1b1:78ba:f350 with SMTP id j6-20020a170902758600b001b178baf350mr390523pll.46.1686008440249;
        Mon, 05 Jun 2023 16:40:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902d2c700b001a4fecf79e4sm7100370plc.49.2023.06.05.16.40.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 16:40:39 -0700 (PDT)
Message-ID: <647e7277.170a0220.e43d2.d1d6@mx.google.com>
Date: Mon, 05 Jun 2023 16:40:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1314-g1ab0ac1d7e2e3
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 14 runs,
 1 regressions (v6.1.26-1314-g1ab0ac1d7e2e3)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 23:40:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11832

cip-gitlab/ci/pavel/linux-test ltp-ipc: 14 runs, 1 regressions (v6.1.26-131=
4-g1ab0ac1d7e2e3)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1314-g1ab0ac1d7e2e3/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1314-g1ab0ac1d7e2e3
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1ab0ac1d7e2e3aeca50f8616b469772a5f010acc

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/647e70535f79dda485f5de33

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/omap2plus_defconfig/gcc-10/lab-broonie/ltp=
-ipc-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/omap2plus_defconfig/gcc-10/lab-broonie/ltp=
-ipc-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/647e70535f79dda485f5de=
34
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a) =

 =20

