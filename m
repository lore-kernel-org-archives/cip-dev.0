Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A002C636D6
	for <webhook@archiver.kernel.org>; Mon,  6 Feb 2023 12:18:14 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web11.51865.1675685891104115989
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 06 Feb 2023 04:18:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=c1ZrDwxh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.171, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f171.google.com with SMTP id n2so5463291pgb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 06 Feb 2023 04:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aq8+Iopz+wDMGyfZ33ClZiig89vMOxP/vOTEg3WI9kk=;
        b=c1ZrDwxhn3kHk9vKflUlwA/qgSG4UFn/IF/Ze/luG4NajitxfU6vaIF9RsHGFZt52G
         aAfuj7YIm+lavRBm38UjmQkYdZJVrqCyNtdbakW6PpLvanjU511oIEMflUIWFBVqjRvz
         k2KbyRq4O03VaoKWHRxDFeNfOX2kGEH0p1t2FSjyQUPkaFNTKD3/ZboHl18A+UhOUKf3
         s70H7w94A2epvgJpHQD5fvFKtcDa/OnbQr8NaVg/grH3D9lhQ0D465FELODSUZdmpri/
         8Xs7muDBQ8rk+dzPTtxph9aoMLFNrwQFshGkO1xm9fmdQ8PAIYNnrgW7QV7Ou9Ov/4jq
         4w5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aq8+Iopz+wDMGyfZ33ClZiig89vMOxP/vOTEg3WI9kk=;
        b=EpjGHWxwQNDw2UAJPzSiZgwqdKKIxyzPOs35KQdkFk3bpiEOOW296132pdnWxZcCqE
         cQ8iweG55FsrY1OZykWDx892rOxQK1Xu9ADS9ibDIZF5BWcGbAT7kv/muX/UxlYARkkO
         +O7VnNlXnYt5nQo3F7+u79miCM6hSk8C3kvwWYbPNxMvCUsoLKbO6QoSfhQdKRS19ULc
         i40RSjfltHP5Bg4putokT0lDUQgdWh3t9a5cGpvUlTX4aQ5nVkHFz+CidkuVi1LJ9hDn
         QW8ScbIXkzDolUuCitR9lqtAW8ZbErgQKzOdAx1g3XIbnLO/gwEFXrougfPPuqJ/PTEt
         d63Q==
X-Gm-Message-State: AO0yUKXJnrQnLsVMRvl42eADcbGVSleLgoSaELTQDRvgnm42kwAfMpyM
	xeh2jL9yBNYfjNwgOJ6cbi2jaQZwXqzZZ9NOoqar5w==
X-Google-Smtp-Source: AK7set94j+8VureDAWlv6dCBSaLn1AqnszUbEP1S1FyNgokkPsgl87AeDB8Nzy78fdvZSXneZwpLbQ==
X-Received: by 2002:a62:1b8a:0:b0:593:b37c:c7ad with SMTP id b132-20020a621b8a000000b00593b37cc7admr16507084pfb.22.1675685889891;
        Mon, 06 Feb 2023 04:18:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a23-20020a62bd17000000b00598c2fa856dsm4691394pff.68.2023.02.06.04.18.09
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 04:18:09 -0800 (PST)
Message-ID: <63e0f001.620a0220.bb06d.67ca@mx.google.com>
Date: Mon, 06 Feb 2023 04:18:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.165-cip25-154-gb7e05ba4f61a2
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 210 runs,
 4 regressions (v5.10.165-cip25-154-gb7e05ba4f61a2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Feb 2023 12:18:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10600

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 210 runs, 4 regression=
s (v5.10.165-cip25-154-gb7e05ba4f61a2)

Regressions Summary
-------------------

platform               | arch  | lab          | compiler | defconfig       =
    | regressions
-----------------------+-------+--------------+----------+-----------------=
----+------------
beaglebone-black       | arm   | lab-broonie  | gcc-10   | omap2plus_defcon=
fig | 1          =

cubietruck             | arm   | lab-baylibre | gcc-10   | multi_v7_defconf=
ig  | 1          =

sun50i-a64-pine64-plus | arm64 | lab-baylibre | gcc-10   | defconfig       =
    | 1          =

sun50i-a64-pine64-plus | arm64 | lab-broonie  | gcc-10   | defconfig       =
    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.165-cip25-154-gb7e05ba4f61a2/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.165-cip25-154-gb7e05ba4f61a2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b7e05ba4f61a238b39854406f0889bab2b4fb757 =



Test Regressions
---------------- =



platform               | arch  | lab          | compiler | defconfig       =
    | regressions
-----------------------+-------+--------------+----------+-----------------=
----+------------
beaglebone-black       | arm   | lab-broonie  | gcc-10   | omap2plus_defcon=
fig | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e73f5fcbdabcf2915ebb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-154-gb7e05ba4f61a2/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-154-gb7e05ba4f61a2/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e0e73f5fcbdabcf2915ec0
        failing since 32 days (last pass: v5.10.155-cip21-405-g26d566555c3d=
e, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-02-06T11:40:36.330631  <8>[   15.749880] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 260485_1.5.2.4.1>
    2023-02-06T11:40:36.438707  / # #
    2023-02-06T11:40:36.540592  export SHELL=3D/bin/sh
    2023-02-06T11:40:36.541254  #
    2023-02-06T11:40:36.642698  / # export SHELL=3D/bin/sh. /lava-260485/en=
vironment
    2023-02-06T11:40:36.643163  =

    2023-02-06T11:40:36.744446  / # . /lava-260485/environment/lava-260485/=
bin/lava-test-runner /lava-260485/1
    2023-02-06T11:40:36.745119  =

    2023-02-06T11:40:36.748468  / # /lava-260485/bin/lava-test-runner /lava=
-260485/1
    2023-02-06T11:40:36.840980  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform               | arch  | lab          | compiler | defconfig       =
    | regressions
-----------------------+-------+--------------+----------+-----------------=
----+------------
cubietruck             | arm   | lab-baylibre | gcc-10   | multi_v7_defconf=
ig  | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e8a0e490114f90915ee5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-154-gb7e05ba4f61a2/arm/multi_v7_defconfig/gcc-=
10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-154-gb7e05ba4f61a2/arm/multi_v7_defconfig/gcc-=
10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e0e8a0e490114f90915eea
        failing since 18 days (last pass: v5.10.155-cip21-405-g26d566555c3d=
e, first fail: v5.10.162-cip24-853-g709bb3738fde)

    2023-02-06T11:46:22.290708  + set +x<8>[   11.067615] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3295692_1.5.2.4.1>
    2023-02-06T11:46:22.291308  =

    2023-02-06T11:46:22.401486  / # #
    2023-02-06T11:46:22.505053  export SHELL=3D/bin/sh
    2023-02-06T11:46:22.505736  #
    2023-02-06T11:46:22.607441  / # export SHELL=3D/bin/sh. /lava-3295692/e=
nvironment
    2023-02-06T11:46:22.607836  =

    2023-02-06T11:46:22.608119  / # . /lava-3295692/environment<3>[   11.37=
4159] Bluetooth: hci0: command 0xfc18 tx timeout
    2023-02-06T11:46:22.709584  /lava-3295692/bin/lava-test-runner /lava-32=
95692/1
    2023-02-06T11:46:22.710076   =

    ... (13 line(s) more)  =

 =



platform               | arch  | lab          | compiler | defconfig       =
    | regressions
-----------------------+-------+--------------+----------+-----------------=
----+------------
sun50i-a64-pine64-plus | arm64 | lab-baylibre | gcc-10   | defconfig       =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e7de1bd15dfdb7915eba

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-154-gb7e05ba4f61a2/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-154-gb7e05ba4f61a2/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e0e7de1bd15dfdb7915ebf
        failing since 5 days (last pass: v5.10.153-cip19-122-g149fbc7cd21d,=
 first fail: v5.10.165-cip25-144-g43e1d8dfbb26)

    2023-02-06T11:43:06.220458  + set +x
    2023-02-06T11:43:06.224389  <8>[   17.122524] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3295608_1.5.2.4.1>
    2023-02-06T11:43:06.345440  / # #
    2023-02-06T11:43:06.451547  export SHELL=3D/bin/sh
    2023-02-06T11:43:06.453084  #
    2023-02-06T11:43:06.556497  / # export SHELL=3D/bin/sh. /lava-3295608/e=
nvironment
    2023-02-06T11:43:06.558112  =

    2023-02-06T11:43:06.661866  / # . /lava-3295608/environment/lava-329560=
8/bin/lava-test-runner /lava-3295608/1
    2023-02-06T11:43:06.667682  =

    2023-02-06T11:43:06.670115  / # /lava-3295608/bin/lava-test-runner /lav=
a-3295608/1 =

    ... (12 line(s) more)  =

 =



platform               | arch  | lab          | compiler | defconfig       =
    | regressions
-----------------------+-------+--------------+----------+-----------------=
----+------------
sun50i-a64-pine64-plus | arm64 | lab-broonie  | gcc-10   | defconfig       =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e75327d4f67764915f4f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-154-gb7e05ba4f61a2/arm64/defconfig/gcc-10/lab-=
broonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-154-gb7e05ba4f61a2/arm64/defconfig/gcc-10/lab-=
broonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e0e75327d4f67764915f54
        failing since 5 days (last pass: v5.10.153-cip19-122-g149fbc7cd21d,=
 first fail: v5.10.165-cip25-144-g43e1d8dfbb26)

    2023-02-06T11:40:59.534247  + set +x
    2023-02-06T11:40:59.538264  <8>[   17.225631] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 260435_1.5.2.4.1>
    2023-02-06T11:40:59.649045  / # #
    2023-02-06T11:40:59.750906  export SHELL=3D/bin/sh
    2023-02-06T11:40:59.751483  #
    2023-02-06T11:40:59.853033  / # export SHELL=3D/bin/sh. /lava-260435/en=
vironment
    2023-02-06T11:40:59.853479  =

    2023-02-06T11:40:59.954924  / # . /lava-260435/environment/lava-260435/=
bin/lava-test-runner /lava-260435/1
    2023-02-06T11:40:59.955593  =

    2023-02-06T11:40:59.960037  / # /lava-260435/bin/lava-test-runner /lava=
-260435/1 =

    ... (12 line(s) more)  =

 =20

