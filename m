Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E744C47422
	for <webhook@archiver.kernel.org>; Fri, 19 Jan 2024 01:32:24 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web10.11641.1705627942802296967
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 18 Jan 2024 17:32:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Jd649qEg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d9c2db82b0so293786b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 18 Jan 2024 17:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705627942; x=1706232742; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HFnGio7UIl/syQMnvUFk6+AVbmj5m5TLxpvM//c7mbM=;
        b=Jd649qEgscLi1ymghxI5LWc6zAjedjt44tyd6MX6S95B7mV84CCSSEcoFkdg12Xkyk
         GyF9766di8km1AbCNRFSI6PoZNq1hJzlI1xQWHXZD3ot3tHTaCKvdShXgFsZ2cOVR8ya
         tzgNb4yYZHKfH/I0pKOjk24RU5ic6p+nliXR2dZjYrc2afcnZCYpmL5wlIxkLFNV3aXe
         Q+oPoYPJKnyEutD70SBK5R3JH8ByRO1WAON2wuLuLEpxGoJKXtv38bcRCHZnhjoLWrGK
         D3cF2B5zW/QQSP8YC+KPAu8MTv1m+3TOieMll05Y0gVAhHOigqf/888csR79Ml5P3I7d
         URdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705627942; x=1706232742;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HFnGio7UIl/syQMnvUFk6+AVbmj5m5TLxpvM//c7mbM=;
        b=p+ReRBmxfosijX5S91NGeXRw2+TdjsRCel/gsTQQ3R4XqmXiU8KJrfesAjX5UCJY76
         AQ2WrI9ji14h6xu48XnoWbI/BnTBv4fKFi3Pyxbv++xVuLIRZx2breuoPppO3Tz9hnxL
         7iipW54EkqkiJehSF6CLEGx7tJfdgSwzw02OJ3sY70uBEemjdP7Y8KrrNjhulfYfaoyz
         AaB81g39XJlTo2ha1SkVla6WEM6glQvj2p8ma+tMWEVUCHw0xkZ/YFxfhcmYb6P5y+mw
         XLA2m02AjX+DNeNzStq205jew08aTihnUGUspfGem7sKr29JRPbOWcOFu4wGXL1hcwxq
         hMKQ==
X-Gm-Message-State: AOJu0Yx6DvaropG8Ovm2Q/4eY0dliS5aj76WFep7G+Ak3JS43G8pUtuF
	xXtsW0aruAaqmoEIqUfRRvJzZeS7O9J4huUhf5GzfntGXz9dLJgR1d80ZnQkFOzmFHCRDi1C3TX
	nn1I=
X-Google-Smtp-Source: AGHT+IGL1anqjAp/i6SX0CovY7egTcfK59pCasOKAeqGT8GDr3/SKDgb4SvKHT/1C9Xuhlnxlu50wA==
X-Received: by 2002:a05:6a00:2441:b0:6d9:d506:3afa with SMTP id d1-20020a056a00244100b006d9d5063afamr1715993pfj.60.1705627941798;
        Thu, 18 Jan 2024 17:32:21 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ei25-20020a056a0080d900b006d9361fcfc8sm4050763pfb.177.2024.01.18.17.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 17:32:21 -0800 (PST)
Message-ID: <65a9d125.050a0220.2f804.2b99@mx.google.com>
Date: Thu, 18 Jan 2024 17:32:21 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v6.1.72-cip13-30-g79e2886a5da69
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip baseline-nfs: 49 runs,
 4 regressions (v6.1.72-cip13-30-g79e2886a5da69)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jan 2024 01:32:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14416

cip/linux-6.1.y-cip baseline-nfs: 49 runs, 4 regressions (v6.1.72-cip13-30-=
g79e2886a5da69)

Regressions Summary
-------------------

platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
imx6dl-riotboard             | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig         | 1          =

kontron-pitx-imx8m           | arm64 | lab-kontron     | gcc-10   | defconf=
ig                  | 2          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.72-cip13-30-g79e2886a5da69/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.72-cip13-30-g79e2886a5da69
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      79e2886a5da69a8a86ec82215b5e9e0748943546 =



Test Regressions
---------------- =



platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
imx6dl-riotboard             | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65a9c4579f7924077f52a406

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-30-g79e2886a5da69/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baselin=
e-nfs-imx6dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-30-g79e2886a5da69/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baselin=
e-nfs-imx6dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65a9c4579f7924077f52a40f
        failing since 55 days (last pass: v6.1.59-cip8, first fail: v6.1.62=
-cip9-12-g3a5321f469b07)

    2024-01-19T00:37:35.481240  + set[   30.807065] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1020431_1.6.2.3.1>
    2024-01-19T00:37:35.481421   +x
    2024-01-19T00:37:35.595274  / # #
    2024-01-19T00:37:35.696384  export SHELL=3D/bin/sh
    2024-01-19T00:37:35.696824  #
    2024-01-19T00:37:35.797806  / # export SHELL=3D/bin/sh. /lava-1020431/e=
nvironment
    2024-01-19T00:37:35.798290  =

    2024-01-19T00:37:35.899123  / # . /lava-1020431/environment/lava-102043=
1/bin/lava-test-runner /lava-1020431/1
    2024-01-19T00:37:35.899695  =

    2024-01-19T00:37:35.902463  / # /lava-1020431/bin/lava-test-runner /lav=
a-1020431/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
kontron-pitx-imx8m           | arm64 | lab-kontron     | gcc-10   | defconf=
ig                  | 2          =


  Details:     https://kernelci.org/test/plan/id/65a9c48f658a2c3f8d52a411

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-30-g79e2886a5da69/arm64/defconfig/gcc-10/lab-kontron/baseline-nfs-kontr=
on-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-30-g79e2886a5da69/arm64/defconfig/gcc-10/lab-kontron/baseline-nfs-kontr=
on-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65a9c48f658a2c3f8d52a418
        new failure (last pass: v6.1.67-cip12)

    2024-01-19T00:38:11.460485  / # #
    2024-01-19T00:38:11.562557  export SHELL=3D/bin/sh
    2024-01-19T00:38:11.563283  #
    2024-01-19T00:38:11.664518  / # export SHELL=3D/bin/sh. /lava-418449/en=
vironment
    2024-01-19T00:38:11.665285  =

    2024-01-19T00:38:11.766626  / # . /lava-418449/environment/lava-418449/=
bin/lava-test-runner /lava-418449/1
    2024-01-19T00:38:11.766982  =

    2024-01-19T00:38:11.774857  / # /lava-418449/bin/lava-test-runner /lava=
-418449/1
    2024-01-19T00:38:12.020586  + export TESTRUN_ID=3D1_bootrr
    2024-01-19T00:38:12.023637  + cd /lava-418449/1/tests/1_bootrr =

    ... (10 line(s) more)  =


  * baseline-nfs.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id=
/65a9c48f658a2c3f8d52a428
        new failure (last pass: v6.1.67-cip12)

    2024-01-19T00:38:16.111410  /lava-418449/1/../bin/lava-test-case
    2024-01-19T00:38:16.173323  <8>[   21.902308] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65a9ca2eef6c3dc19052a3f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-30-g79e2886a5da69/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/b=
aseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-30-g79e2886a5da69/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/b=
aseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65a9ca2eef6c3dc19=
052a3f2
        new failure (last pass: v6.1.67-cip12) =

 =20

