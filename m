Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE836C6FD1D
	for <webhook@archiver.kernel.org>; Tue,  4 Apr 2023 16:26:32 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web10.106512.1680625591856403658
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 04 Apr 2023 09:26:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ifqkp0ab;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so34552473pjb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 04 Apr 2023 09:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680625591;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lbz38Dv+cHt+jzi1pQe6mRYoj+ysHwCVeMzLM42dN7c=;
        b=ifqkp0abETEMKfySpAMlMsraSHDpJTvSlJhSF+bzmKJJ1R6OfyzHTGJSAzOtIbdS0N
         3/pBoEMxRYBJwG8kKtdMzcoHmI7W4qDrkrBMD/b2kgTF6uB+s2lkg/dxwKbgnpcmEg4I
         BoM1dX7Ppj0QQi2fVhW0RLNY2Ju9JF/6fjRdBkKhnxbcEPYCFOqIiH6/lzv6Ldtu0ODc
         3ZSjycdgM4IWb8Fqz9oN9vDN+m+OtvYaMxZCyJhzFg1VELh35/E5bKk/Ei0o0tkAY/3e
         HR6tbtD6dGwHucsSm7MSKA6u65QOKeKGYwAZrDhjDYWSWFWvG5rZPszSf/Rsvw7NgeLy
         oY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680625591;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lbz38Dv+cHt+jzi1pQe6mRYoj+ysHwCVeMzLM42dN7c=;
        b=YQAHqhc4ID+nB2P80R9dmPMuPDIRvqdQV8xExIVHItzW7zNg8JmeBN717i0vlDkKvB
         FZuccul0P0d1uXfZC4s67+iLzCDf/9rLBHjmsACDQ/3PH9mkQyZJarAIddnXT1HVAy2G
         nCWHVhAW4X3WAoc6RIVGOaJtQyaq4HrbDLOHh0uaCt1nfdxVHE4GNGgsd1HqozWZrm3m
         fbGiP2265ZEhZgbBhyHEaJsc4njDnlU2rIqqg0a+8JOPJ30r7LOs9rVGzHCoYeXCDEzJ
         jHCarlB1NP8ecjw+VhQZbRAUS5Qj6pc5JwgZbBlC0bX4pc6JrPQlPgBAWueJ+eCF+XXN
         koaA==
X-Gm-Message-State: AAQBX9dq75CJh56nyh9bEJ/b6gpZWVUyN1tJgCtjg5y/OMyOAVvxSZiA
	AVsrwE61AeRcZBOXgBNCA+bbf1RhLfiMAuKIRLhn2w==
X-Google-Smtp-Source: AKy350a/LnnSG0pB6ryGun1Pcs+ETKIe599EIxW4tFNfOXm1VSwC+LGEJnS9ysAALKfQ73Jqp/glLg==
X-Received: by 2002:a17:902:e412:b0:19c:f8c5:d504 with SMTP id m18-20020a170902e41200b0019cf8c5d504mr2704766ple.59.1680625591000;
        Tue, 04 Apr 2023 09:26:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bf12-20020a170902b90c00b001a1ed2fce9asm8512840plb.235.2023.04.04.09.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 09:26:30 -0700 (PDT)
Message-ID: <642c4fb6.170a0220.d9e67.1394@mx.google.com>
Date: Tue, 04 Apr 2023 09:26:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip74-rt43
Subject: cip/linux-4.4.y-cip-rt baseline-nfs: 36 runs,
 3 regressions (v4.4.302-cip74-rt43)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Apr 2023 16:26:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11173

cip/linux-4.4.y-cip-rt baseline-nfs: 36 runs, 3 regressions (v4.4.302-cip74=
-rt43)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fc...g+preempt_rt | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip-rt/ker=
nel/v4.4.302-cip74-rt43/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-cip-rt
  Describe: v4.4.302-cip74-rt43
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      22456e8b8d35c6bd1313511bfa4dd945ce7a0c1e =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/642c42d12bf844838479e93b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-c=
ollabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-c=
ollabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230331.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/642c42d12bf844838=
479e93c
        new failure (last pass: v4.4.302-cip72-rt42) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/642c42a8c2445aa03d79e94f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip74-rt43/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/baselin=
e-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip74-rt43/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/baselin=
e-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230331.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/642c42a8c2445aa03=
d79e950
        new failure (last pass: v4.4.302-cip72-rt42) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/642c42828f00992a0179e92d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-c=
ollabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-c=
ollabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230331.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/642c42828f00992a0=
179e92e
        failing since 56 days (last pass: v4.4.302-cip71-rt41, first fail: =
v4.4.302-cip72-rt42) =

 =20

