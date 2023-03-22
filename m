Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA71C74A5B
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 14:26:24 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.44459.1679495175397772354
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 07:26:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=xTH9Pkew;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id k2so19428154pll.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 07:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679495174;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MkuZjR6SZTm0FYk/LOA1A27xa0e9XcDtB8GLwhOV/J4=;
        b=xTH9Pkewc1n3z4Uu8Qe6LaNDTE72yrGOsWXQbWkrFDISz09CqOFjDxZh9calDaMq9P
         bc1boE4zRLhYt5q0CTc6kwLTgV7xoCiZ2wsLkwabrXsZMGdW3ztFe0fAauEIfFduHGet
         Bp98DKje1C2JuhsmTUbIFvXqbBM29eK4Yt9zm6gFryCV9r9RrfM1JImiLjbUnNGaqUlF
         zn2F+MLWiV3K3xPkeCuPy8rhJpwNjXrR+oR48vlEUWpgqf1mcc4nX6sU26t0cS9tyYYa
         CcVqbx4FDquUojVI3BO8yrBWAr6iDGAe9iIYVJ8sXe59yMM8Aa8lmeLxzrbqhVeFiaQO
         WAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679495174;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MkuZjR6SZTm0FYk/LOA1A27xa0e9XcDtB8GLwhOV/J4=;
        b=wRmo3+AGANDbYMOH/dVm/C4b/JDAq/hIMOSIdeE23em18qyWMiP47byh2YBUfaDFLX
         vsSEKP2ATPJ1Ho5nQjsJh0R3H3kc+V/ogO8KnkZYweTtaWhpilQSs0WqkmumuOx4cDSP
         GO21u8jyc5+UVwj20bOBpIoMH6Wmir/VdSWCsGnfJVO/bgH8D/ZcDq2zaV3rWyUYF1A6
         2hltl5LhOEVG1gvg3OWYKyjJRdYcnqPk1nsAqnTKgCZG1q1FzWTThxPdg6VdfVRM/q0Q
         frp8kdH7rL/MkkQpVc9bJ9VGSXuuApKnjXny2gSnjfxlvEWy6xKOTknbMe+Iz3Ww3FWM
         K88A==
X-Gm-Message-State: AO0yUKXSska0gk1Es4lajXG1mcEIJckdIi+Ge7vOSNxI/O/BHousanh0
	ow1sNZ/9qbwWYZawMoc1iBZJ+1s0OHKoJqKFo2ylCg==
X-Google-Smtp-Source: AK7set+t6ch3xAZnFiTPDPyxSKFGgYcPC8b67iva5Qso9fYYch/+e+lZP5+lmJAtRpnPBO9tmboWAg==
X-Received: by 2002:a17:90b:1e4c:b0:23d:31c3:c9a4 with SMTP id pi12-20020a17090b1e4c00b0023d31c3c9a4mr3947257pjb.26.1679495174524;
        Wed, 22 Mar 2023 07:26:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 90-20020a17090a0fe300b0023b4d33bedbsm9822462pjz.21.2023.03.22.07.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:26:14 -0700 (PDT)
Message-ID: <641b1006.170a0220.833b8.115f@mx.google.com>
Date: Wed, 22 Mar 2023 07:26:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.175-cip29-rt12
Subject: cip/linux-5.10.y-cip-rt ltp-fcntl-locktests: 15 runs,
 2 regressions (v5.10.175-cip29-rt12)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 14:26:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11091

cip/linux-5.10.y-cip-rt ltp-fcntl-locktests: 15 runs, 2 regressions (v5.10.=
175-cip29-rt12)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 1          =

asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.175-cip29-rt12/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.175-cip29-rt12
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0a6a8df2de5a8e8f024b47926cff286c6ec0e31f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  f3463a347c37b44bafdf4e882cfb932f6888905d =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/641afd6ba93124b2259c951b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-fcn=
tl-locktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-fcn=
tl-locktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/641afd6ba9=
3124b2259c951c
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641afc3f8420653add9c95af

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/641afc3f84=
20653add9c95b0
        new failure (last pass: v5.10.162-cip24-rt10) =

 =20

