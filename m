Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B3FEB64DA
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 16:45:19 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web10.2177.1689871511201250503
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Jul 2023 09:45:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=KvGBqia/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.170, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-55ae51a45deso531542a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Jul 2023 09:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689871510; x=1690476310;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qW5k6A+wI+GP9eYVO3D8gEpptC27o4j7eVVNDaP7tZ0=;
        b=KvGBqia/MMISOr6Yq8VO6PVzWIvKcFig+q1+sdRGlr3D93wxtJA8yfxEbhxiJaK77S
         qDqxpJHBiGA+dEdoC0ADIQpSbeuANGrGjsE7mLQE3jF+YqaEBc0RBqHNqEmtsSMbyzDN
         rp53M1wBBobwkktCnUDrlBioYfXw7NQKo0zfnRkq+t88U7oTElMIrwBsUgm4pXl3LqGC
         75snzQHLwvVPiTWubkzvq7xMySaeXBh5YkBedM9noeEnTNbV9ZOxLZuc64cGkaDcKlW0
         weuS5EcIthMaArR+AnuhZu+6eg8/YwESHpVbWLpiEjpAnzT5bO+ZZk6PrdkByUgxwHXK
         5OrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689871510; x=1690476310;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qW5k6A+wI+GP9eYVO3D8gEpptC27o4j7eVVNDaP7tZ0=;
        b=lsI6tF3KUWIQhQZ7uMm+rl3WDiqrYmKpXUCLe4CzeZb3g4z7Un4JoC88GWb9pltRdE
         08S3uzKQzgDlASu4RLYSoVyNmnxXhnUZooTyyYIHDPu+bDZx2UnJ0GJBTdOVTh1ta3Z2
         1PYuE2F7YaUHRbXYZYLlRS/nJmz7bhsTrUQmceiYhmu9+z6/lG1DVMpEInxAukqxryj7
         2VIro7zOFzKbA3bRpRIELV+ulAVt6RN7Wiln1r00vXTTR80Ug1CY8xDLVIzw5aETtQKO
         VD27phAO53vjUbnFqUMXbhYmVtNLB3HrDfA+VAm/uNmpr1z0SwANh/xC9KvxznR0CHDF
         cy9w==
X-Gm-Message-State: ABy/qLamFbbZzh1egAIRORkvvp3VY2K3+pAawh/YfEcyfopkr99+j6yT
	A0ql3RiIPznVQHKUruYVrHBpttfyvWkkZIQlPPIOcQ==
X-Google-Smtp-Source: APBJJlHSdLVVWF3MR7ffaQCiCiRsj/a1w4LOFqQtt6sioJD23X4IdZx4fIGTv/su8KgMhZlfYrvBWw==
X-Received: by 2002:a17:90a:51e6:b0:262:d19c:4fee with SMTP id u93-20020a17090a51e600b00262d19c4feemr28639pjh.19.1689871510029;
        Thu, 20 Jul 2023 09:45:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id mr1-20020a17090b238100b002676e973274sm2902810pjb.0.2023.07.20.09.45.08
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 09:45:09 -0700 (PDT)
Message-ID: <64b96495.170a0220.ee7a9.5b26@mx.google.com>
Date: Thu, 20 Jul 2023 09:45:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.186-cip37-12-gf8c9ce666de7b
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 4 runs,
 1 regressions (v5.10.186-cip37-12-gf8c9ce666de7b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 16:45:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12479

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 4 runs, 1 regressions (=
v5.10.186-cip37-12-gf8c9ce666de7b)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.186-cip37-12-gf8c9ce666de7b/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.186-cip37-12-gf8c9ce666de7b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f8c9ce666de7b69f842e25063054c803ff45d06d

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/64b941c916ac259f2d8ace1d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/riscv/defconfig/gcc-10/lab-collabora/ltp=
-fcntl-locktests-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/riscv/defconfig/gcc-10/lab-collabora/ltp=
-fcntl-locktests-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/64b941c916=
ac259f2d8ace1e
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc) =

 =20

