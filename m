Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B43CC433FE
	for <webhook@archiver.kernel.org>; Tue, 11 Oct 2022 14:32:41 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web10.8018.1665498755749036842
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 07:32:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=cm5cdmwC;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id b2so13347406plc.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 07:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mZJ5/gAwMt/KEqBFfteBsRd2dAEhttCMh58ez8pDMwg=;
        b=cm5cdmwCghQrQMwfetH2q4DUe03vZai2K04oTC5YxRDHZqwTImxvy32Szva5jTv0Gh
         f/kVaqbtyLbPdd+81VO7OwoREJ9vtbPvO2ujqA8CVx5LKvWenGZJ/a7f/1YO6kZHc1iX
         fMvJQE8x+ocEfcjTkK37cZz/7FlzpH1enSZMh4GsaWe+llpc/SA+IEVBJHetVnrAtl3P
         qScH+ycVbWsFfIUe7hUA4NClObcqZ/59k+q+oqsfZfNV+afYA+9uOVaqC+hxpq/LRg+1
         gYksAmUl2vwHGGNDU7vJSHVg5yrYbtzLG1hvcEb7GlYJzmIlaWXjFzufPutOZopnGznh
         xYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZJ5/gAwMt/KEqBFfteBsRd2dAEhttCMh58ez8pDMwg=;
        b=4A7H9buwhcZWb8hkXR65oyvahWFCFYj0myC1pjQdPvMoIKJTMoWQfxGLABsvQrkg91
         wcVLcqHxb2iVe6jw2WmurfRZaOVLFU03d17Rh5vVem9hMbugHIsAqbwMjSb3Z+qhNj9o
         Wh6kgbScpxcDtwrMvPU329XOtCx61gN/yAigOcDVluJk/0+u0ImQh4owD5a7G1CKGEPd
         h+LNzdkVZSZUaBxaVJQfWACnKp2HZ8CSekSkcOBJsoxV93YEcuFcVomgDJ8c99WsaT6u
         SlIj/EyLC3yStITt/QmBDeW5AWtyRE4Qq+laOsgu2dXosKnNtPsvJqarYDt1v9ravSpL
         OKtg==
X-Gm-Message-State: ACrzQf29YSRXfsCZcX2EZq8amA3oUrEVfifajWfD3Zphl2ffyfBB17/T
	B9v1hhQccy165fhdFABB4hrjuBCECQAxp4BmJGo=
X-Google-Smtp-Source: 
 AMsMyM42awpadLKPH7Of0XShB5fgSUU3yEjzziqzmVoFTB6ON/CErrUvnZm9QgVkyFWCZbaGm7BJHQ==
X-Received: by 2002:a17:90b:1891:b0:20a:daaf:75e0 with SMTP id
 mn17-20020a17090b189100b0020adaaf75e0mr38125329pjb.109.1665498754814;
        Tue, 11 Oct 2022 07:32:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 z1-20020aa79901000000b00561b02e3118sm9106291pff.106.2022.10.11.07.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 07:32:34 -0700 (PDT)
Message-ID: <63457e82.a70a0220.ad568.fa3c@mx.google.com>
Date: Tue, 11 Oct 2022 07:32:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.145-cip17-1-ge85493c8cea0
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-nfs: 25 runs,
 2 regressions (v5.10.145-cip17-1-ge85493c8cea0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 14:32:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9721

cip/linux-5.10.y-cip baseline-nfs: 25 runs, 2 regressions (v5.10.145-cip17-=
1-ge85493c8cea0)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =

sun4i-a10-olinuxino-lime | arm   | lab-baylibre  | gcc-10   | sunxi_defconf=
ig            | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.145-cip17-1-ge85493c8cea0/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.145-cip17-1-ge85493c8cea0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e85493c8cea0c5b53ef511efe088b0749b4d5aa0 =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6345764fa0a393b76acab642

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/6345764fa0a393b76acab664
        failing since 196 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2022-10-11T13:57:17.101264  /lava-7551980/1/../bin/lava-test-case
    2022-10-11T13:57:17.130345  <8>[   96.715965] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
sun4i-a10-olinuxino-lime | arm   | lab-baylibre  | gcc-10   | sunxi_defconf=
ig            | 1          =


  Details:     https://kernelci.org/test/plan/id/634579a25afca108d2cab5f4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-nfs=
-sun4i-a10-olinuxino-lime.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-nfs=
-sun4i-a10-olinuxino-lime.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/634579a25afca108d=
2cab5f5
        new failure (last pass: v5.10.138-cip15) =

 =20

