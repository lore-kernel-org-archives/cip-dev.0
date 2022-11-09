Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB94C4332F
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 11:14:00 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web08.2045.1667992437668288746
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 09 Nov 2022 03:13:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ZgsPmAOA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id g62so16368951pfb.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 09 Nov 2022 03:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GRCpp++PefqeQL/IUX6WQczdt5xvvU0Rs5wybizqOh4=;
        b=ZgsPmAOAyHRBYgrPx1Gl/1hkYOBtptxHs5tvp8p/qPR1opcqX4ONGOIsVXLVwQyvF+
         rzq2626BGgIJbmB56FMvsdkr1RVAP1rTKv7+inFYjYT9QrwP9tauC9x4IBHkRjlbVaxn
         iO40hSTIZDS4F0t2OqrBt6wYAA1vzUcr9We+1D3TzbvZr9PvR8ivPtZncjIQUV6ovSe9
         TxkCa2tDkrG6cTLPZLauZdctCrKiYJyP4dTarwZFUlqa9icy+mrpK/T+fvy8hXyIhz3G
         kfF1stZI3I/6aV8XyBndcSUBfqXtLSlKDxoqnts08ESbx4JMeVOSFXQyRQUg0/wlZynI
         niPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRCpp++PefqeQL/IUX6WQczdt5xvvU0Rs5wybizqOh4=;
        b=au/kdjYgFk4CqprmBjWno+sLk2BZUWpReaOfLDTTEGZhKXEFXcUl2SO61IK+d5v+M7
         3e6knsjt6oXnXhx2G3C5f7heakIrfpfR49VJFvxMpN3W2TvWGRYZqdJYme9sI/irbV6b
         qkyGouPH8LcoaLQmXDUW6iUYcLFMNDknB4GWxbHOMFDsjcPCuE8Rx7zBMxo8pj7sfpbu
         6n3rvdsAQrDyxMWxTQyz/mH+JcpiLmdPslRaAyJ5/05Y0s8M1cu6SBGLZjlNiMin0dqu
         OWMlQNxCE0ZGfIXwu8YPZ/P2oaZuDFJKhGDrrhF1mLB2x/OR5vDzfJ0NaD66BLcNI2p+
         34Sw==
X-Gm-Message-State: ACrzQf1miiBlIKL+4NZYdQF/NIqDfnNyKV0qutR1qEKdInIxQ/JtX0GQ
	Kn4VYwniwZpuYosjcw8dtqwT8A2s2kr0mGD9
X-Google-Smtp-Source: AMsMyM4Dv+XGULdKOYZa5ocWs/zYzwBMJmEP29L7LFKU5fqdaxupxOFfXWzKjviWHN1Bs0gEHPBS2Q==
X-Received: by 2002:a63:e14c:0:b0:439:2e24:e014 with SMTP id h12-20020a63e14c000000b004392e24e014mr50903898pgk.173.1667992436897;
        Wed, 09 Nov 2022 03:13:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m21-20020a170902d19500b0018862bb3976sm8716258plb.308.2022.11.09.03.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:13:56 -0800 (PST)
Message-ID: <636b8b74.170a0220.6f565.e27b@mx.google.com>
Date: Wed, 09 Nov 2022 03:13:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline: 123 runs,
 2 regressions (v5.10.153-cip19)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 11:14:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9958

cip/linux-5.10.y-cip baseline: 123 runs, 2 regressions (v5.10.153-cip19)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
at91-sama5d4_xplained | arm   | lab-baylibre  | gcc-10   | multi_v7_defconf=
ig         | 1          =

rk3399-gru-kevin      | arm64 | lab-collabora | gcc-10   | defconfig+arm64-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.153-cip19/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.153-cip19
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0f7fc281d55b27b299e8388c7d44809289ba8b99 =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
at91-sama5d4_xplained | arm   | lab-baylibre  | gcc-10   | multi_v7_defconf=
ig         | 1          =


  Details:     https://kernelci.org/test/plan/id/636b85981684cf5cefe7db5a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xpl=
ained.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xpl=
ained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/636b85981684cf5cefe7d=
b5b
        new failure (last pass: v5.10.147-cip18) =

 =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
rk3399-gru-kevin      | arm64 | lab-collabora | gcc-10   | defconfig+arm64-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/636b82d244178a9a86e7dbb6

  Results:     90 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/636b82d244178a9a86e7dbd8
        failing since 225 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2022-11-09T10:36:44.247971  /lava-7914663/1/../bin/lava-test-case
    2022-11-09T10:36:44.258499  <8>[   31.851243] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

