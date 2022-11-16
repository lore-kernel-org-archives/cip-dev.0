Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB87CC43219
	for <webhook@archiver.kernel.org>; Wed, 16 Nov 2022 14:14:54 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web10.7557.1668608090385930159
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Nov 2022 06:14:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=QtHoUNIa;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so2420939pjk.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Nov 2022 06:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1/V2t6ErBMV4ySpKGRnnGr3VQUpOOQe2REEoUjhHaVs=;
        b=QtHoUNIaag2vasEbIRVxKT8yrCGuYIPAp4K5AqAT+9YILEMk5Vx/iVdtQ23mN2LPeT
         6lWtTfjYFXrsAVpeCrk2NJPBqYTM/PFqSQESPrb5bCskprYnD8WysL9OUex5fvP2SHaE
         eDvgLMMIKZCIjHuql6m62mYCuLHcLpMIlHdd8nqdHCu4QybkiG08MAICMlaJDPfVEbZ7
         CimRJ1z4Fy3zLAq2T8f9ZAaUBgoRG4TRratnscDqS5UrS24v4cEEgw+4+7jTIYqy3BvK
         nHKsxQ29lfm/ayLVQ784jc/Yc8Jr9tIwTLFyxeHA8QI1KyR1gtm6ZIDFilg/U6EXgmHa
         eUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1/V2t6ErBMV4ySpKGRnnGr3VQUpOOQe2REEoUjhHaVs=;
        b=06KJOEk5jVxAOJJPOZ5tpqHoDsZod5YAKlJotUFz7HmTa7gKJvaqjzdcmzbLDi17y5
         V4/PehZvTksh06zmpm3jclYVYZ2lF+4VhCzGenPQsn7h/PIAzRSXaV/05jAMdcusptNI
         zs3dZXCDUpZoGRd50uc8aUiu8xnusAdDKc0D8cxMupSdFSiTuv35JBJXU0UsVa+4y8KJ
         jfxdlLrvXxfUSZIoFMLrsTcWm/QDuvI72J20nwYBCdZHeoWev24cQuIEGigL0Rcz1qdk
         59m1R3a4dPILu4RoujK/kW8+u+7miqRPZhIfOi6MSdl4D7G8q5lEh1sGJpyYUt+DDzvZ
         9pyw==
X-Gm-Message-State: ANoB5pmiylb4BpHLN2Iif/auR3d/p6dMPi5N3s4SlK/7r0DQalntQkPY
	knO8m4emQBw+4mU6+NJ/S1Pjw+vXGg1GGQufv/0=
X-Google-Smtp-Source: AA0mqf6r+tAXAm77x3Nql8PmHvEw0GNgR9d4GFfZhbe2y5EAu73N59Vpg3KogmzBcYQogXP1IbpVhw==
X-Received: by 2002:a17:902:cf03:b0:186:9295:2012 with SMTP id i3-20020a170902cf0300b0018692952012mr9023148plg.19.1668608089537;
        Wed, 16 Nov 2022 06:14:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n4-20020a170903110400b001865c298588sm12298041plh.258.2022.11.16.06.14.49
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:14:49 -0800 (PST)
Message-ID: <6374f059.170a0220.2ace0.2d8d@mx.google.com>
Date: Wed, 16 Nov 2022 06:14:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.154-cip20-99-g0e320e4d37e4
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 95 runs,
 2 regressions (v5.10.154-cip20-99-g0e320e4d37e4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Nov 2022 14:14:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10046

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 95 runs, 2 regressions=
 (v5.10.154-cip20-99-g0e320e4d37e4)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
r8a7743-iwg20d-q7 | arm   | lab-cip       | gcc-10   | shmobile_defconfig  =
       | 1          =

rk3399-gru-kevin  | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.154-cip20-99-g0e320e4d37e4/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.154-cip20-99-g0e320e4d37e4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0e320e4d37e4f142f91e122ae645a9aea854c7a1 =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
r8a7743-iwg20d-q7 | arm   | lab-cip       | gcc-10   | shmobile_defconfig  =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/6374e0de2613d1190e2abd08

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.154-cip20-99-g0e320e4d37e4/arm/shmobile_defconfig/gcc-10=
/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.154-cip20-99-g0e320e4d37e4/arm/shmobile_defconfig/gcc-10=
/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6374e0de2613d1190e2ab=
d09
        failing since 21 days (last pass: v5.10.147-cip18-56-g87bd4289362be=
, first fail: v5.10.147-cip18-12-g7bc9523ecfb7f) =

 =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
rk3399-gru-kevin  | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6374e050d6b36532cf2abd18

  Results:     90 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.154-cip20-99-g0e320e4d37e4/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.154-cip20-99-g0e320e4d37e4/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/6374e050d6b36532cf2abd3a
        failing since 252 days (last pass: v5.10.100-cip2-319-gcbff87047566=
, first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-11-16T13:06:16.226187  /lava-8000102/1/../bin/lava-test-case
    2022-11-16T13:06:16.226658  =

    2022-11-16T13:06:16.237900  <8>[   34.060749] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

