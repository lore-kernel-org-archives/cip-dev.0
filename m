Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13AEC6379F
	for <webhook@archiver.kernel.org>; Sat, 14 Jan 2023 13:47:22 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.115932.1673704038331419077
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 14 Jan 2023 05:47:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Gw3D9ugS;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id v23so21224342plo.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 14 Jan 2023 05:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hTrKEAqHEKDWyPLb8/0+fB08e4hyRKciXrJ4aYeqgGs=;
        b=Gw3D9ugSMwR5Qkon1AlU26AQDmIEQrhsn+Iex3UyModrK3PkXv9Dpl8Wo2nis9mf22
         EfHI987ZeNbsg9JxfaM+ifAYMliOgK/wAq6judTrF5AfEHYHpQbPTt4akVfGIZj3Nf55
         YiLeoihqDiYVroFZXm/5nhZmJxzrpkYBGvlicAjXSO5EiVzlSS9lzoZyvMwhI9rvZQ08
         ABmFHtViqOx8PkQyRQYhXx+0/4ISv3zsWswIKvmsQ4o+v1gLdgnaaXaIYwlb8t7ivBit
         TZAYOAwYOeREBQS8x5EjsuOVbAkJPmUGemumyFbu2lj2HtYPE5uOqdGUK684NZvUnmka
         bkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hTrKEAqHEKDWyPLb8/0+fB08e4hyRKciXrJ4aYeqgGs=;
        b=T0GGL29DBOgbohi5madnwD2qTFeo528p8GdRrVOMKD4YR1FFvP8w1MHsCyyqQd1DYm
         yhtamYxbFsh38YQbWC8DG/g4cTKppn1S+DW8y1QQnJ9+V81RvcxuraHcBa6/S2mmSFiH
         MpQ2Vr8NzeVQ6UxapbGrKI16bNqNME/iTMBU+t6RHyuWgaNluu0ZA3LRALNLmlSgUDZg
         0SNBHKQWDcTGWFN8fOleX/3V7Jo/pEppYrD6ZrOSW+HIkF1ILHyfrjjmIO81PlNo0I+b
         nnVuxTvZao4e/ArUxrlSqneyMsz7sKG5eMu/9HAdMu3U6eS/IMPz1TOeMBeUmh5gutyq
         cfaA==
X-Gm-Message-State: AFqh2kojsUyrc5zkh76Mp3hCLhFp3Zl9enfjrC8wAVPKgzu+UaHfi1eS
	+LRL6BbQRcDgOUTwgpHv6AooDj98acjJO4vNE4dR/g==
X-Google-Smtp-Source: AMrXdXsbvHKHMuxUnPVBjdMEaOELOi9HFHQMu7fbaSd41iJjS03S/iSfY5RbdB1CBdhj973XEQ06DQ==
X-Received: by 2002:a17:903:22c7:b0:192:ee6c:e28d with SMTP id y7-20020a17090322c700b00192ee6ce28dmr52498483plg.38.1673704037386;
        Sat, 14 Jan 2023 05:47:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m15-20020a170902db0f00b00189393ab02csm16060498plx.99.2023.01.14.05.47.16
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 05:47:16 -0800 (PST)
Message-ID: <63c2b264.170a0220.ae2e4.9f7e@mx.google.com>
Date: Sat, 14 Jan 2023 05:47:16 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.162-cip24-788-g63c30712099cf
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 99 runs,
 3 regressions (v5.10.162-cip24-788-g63c30712099cf)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 14 Jan 2023 13:47:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10362

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 99 runs, 3 regressions=
 (v5.10.162-cip24-788-g63c30712099cf)

Regressions Summary
-------------------

platform          | arch | lab         | compiler | defconfig           | r=
egressions
------------------+------+-------------+----------+---------------------+--=
----------
beaglebone-black  | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1=
          =

beaglebone-black  | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1=
          =

r8a7743-iwg20d-q7 | arm  | lab-cip     | gcc-10   | shmobile_defconfig  | 1=
          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.162-cip24-788-g63c30712099cf/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.162-cip24-788-g63c30712099cf
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      63c30712099cff890a9fa023533c2971e6a4f87e =



Test Regressions
---------------- =



platform          | arch | lab         | compiler | defconfig           | r=
egressions
------------------+------+-------------+----------+---------------------+--=
----------
beaglebone-black  | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1=
          =


  Details:     https://kernelci.org/test/plan/id/63c2aa9ffd4717cfaa1d3a57

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-788-g63c30712099cf/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-788-g63c30712099cf/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230109.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c2aa9ffd4717cfaa1d3a5c
        failing since 10 days (last pass: v5.10.155-cip21-405-g26d566555c3d=
e, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-01-14T13:13:52.086282  <8>[   21.040637] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 112150_1.5.2.4.1>
    2023-01-14T13:13:52.196447  / # #
    2023-01-14T13:13:52.298828  export SHELL=3D/bin/sh
    2023-01-14T13:13:52.299278  #
    2023-01-14T13:13:52.400594  / # export SHELL=3D/bin/sh. /lava-112150/en=
vironment
    2023-01-14T13:13:52.401165  =

    2023-01-14T13:13:52.502875  / # . /lava-112150/environment/lava-112150/=
bin/lava-test-runner /lava-112150/1
    2023-01-14T13:13:52.503586  =

    2023-01-14T13:13:52.507409  / # /lava-112150/bin/lava-test-runner /lava=
-112150/1
    2023-01-14T13:13:52.609773  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform          | arch | lab         | compiler | defconfig           | r=
egressions
------------------+------+-------------+----------+---------------------+--=
----------
beaglebone-black  | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1=
          =


  Details:     https://kernelci.org/test/plan/id/63c2abf3b2c148b1d61d39cf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-788-g63c30712099cf/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-788-g63c30712099cf/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230109.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c2abf3b2c148b1d61d39d2
        failing since 10 days (last pass: v5.10.155-cip21-405-g26d566555c3d=
e, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-01-14T13:19:33.938377  <8>[   13.159893] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 825149_1.5.2.4.1>
    2023-01-14T13:19:34.048863  / # #
    2023-01-14T13:19:34.151411  export SHELL=3D/bin/sh
    2023-01-14T13:19:34.152188  #
    2023-01-14T13:19:34.254078  / # export SHELL=3D/bin/sh. /lava-825149/en=
vironment
    2023-01-14T13:19:34.254863  =

    2023-01-14T13:19:34.356834  / # . /lava-825149/environment/lava-825149/=
bin/lava-test-runner /lava-825149/1
    2023-01-14T13:19:34.358122  =

    2023-01-14T13:19:34.365102  / # /lava-825149/bin/lava-test-runner /lava=
-825149/1
    2023-01-14T13:19:34.467536  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform          | arch | lab         | compiler | defconfig           | r=
egressions
------------------+------+-------------+----------+---------------------+--=
----------
r8a7743-iwg20d-q7 | arm  | lab-cip     | gcc-10   | shmobile_defconfig  | 1=
          =


  Details:     https://kernelci.org/test/plan/id/63c2a52226bf2bcdcc1d3aed

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-788-g63c30712099cf/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-788-g63c30712099cf/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230109.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c2a52226bf2bcdcc1d3=
aee
        failing since 80 days (last pass: v5.10.147-cip18-56-g87bd4289362be=
, first fail: v5.10.147-cip18-12-g7bc9523ecfb7f) =

 =20

