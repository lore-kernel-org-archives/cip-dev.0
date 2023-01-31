Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E57DC636D4
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 13:41:34 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.12174.1675172486387643611
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 31 Jan 2023 05:41:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=hx/OX3pt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so19079267pjq.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 31 Jan 2023 05:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6JCHuWXQRq5uF26CtT4YLxHC99p9rxJGyqSg2ByjvWU=;
        b=hx/OX3ptwY29G/Y8TvTge4EZmh8vkv/R2IFgqFZDKXyNoe4uP5M26aDIXqY1MJFKe7
         cCfOgs21bDWZL3f9120Ii4XQPKGGrtAkbc4il4/NhS63irJ9+AXYYNcZ1FwV1/eQzJqQ
         evKluJGmpdD1qwAbqwLaxS9jMNsovI+DHWwn3NyyLQAf3KxlN1C5BfdU6hcR82VagyJE
         eBmySLNSO5zCpk4foi6AhNTqYz6kuS4AiO2kpSIOloexFZHnveCxwZdb5vT8byNyzj4J
         Fjdxw+/Mk4/EWYYsjmsJ9kTZkCpL9QbKxdL860peVo4Rsme2VpWGsoFNzvXWUfsrqlre
         eg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JCHuWXQRq5uF26CtT4YLxHC99p9rxJGyqSg2ByjvWU=;
        b=jOAUmjYhZxBltMUWloxbnrT81B32KzGyIFKBjmdFZU1zvHS87ps4fquZdhUeLXqk7v
         sNmReqlP9JdL9YOnq9Hl9psZbWGXMx7+nB4fS5jeLWIUj06allhcivPV+C5xc+34+khz
         X7s+TmCJsyJ6UlkY0SoltwLl7NgzjCiRWLZLQOapc4Z9POxp0ddmx2gmkCUaB70UxXup
         QQh6e70Gbj2We6w9yhZGEmNjjBS7PgEhyp2O3Rf8gQGw3BGpTLmi8lCNxihJ2W2rGuP1
         EYP9FPSQK9shhqXph3ynZpe0DTD9zLwcJ0QmsVR1dZRALFk8BbNDrLgjgDFZOjQV0ShA
         T1QQ==
X-Gm-Message-State: AFqh2koRIsQX7cGP8Tr3o3lN+VXMKHGTweRdY6Vjf8f0ig4UtSJfNi0x
	U6pHIk4ZoSqn2APmsbn1xLaNLhjs2J8C8pcYq6K+vQ==
X-Google-Smtp-Source: AMrXdXsEJYOzvI7MSXAjakaSFHtdRwrF+LxKgI5BAny2hy8sUDvPEm5C5SyaANhzXadjjXy6xbgu7g==
X-Received: by 2002:a17:903:1c6:b0:195:e590:c7c6 with SMTP id e6-20020a17090301c600b00195e590c7c6mr52664602plh.22.1675172485168;
        Tue, 31 Jan 2023 05:41:25 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902d70900b00192fb119eb2sm1870964ply.54.2023.01.31.05.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:41:24 -0800 (PST)
Message-ID: <63d91a84.170a0220.7a101.3ab0@mx.google.com>
Date: Tue, 31 Jan 2023 05:41:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.165-cip25
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-nfs: 55 runs,
 16 regressions (v5.10.165-cip25)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 13:41:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10534

cip/linux-5.10.y-cip baseline-nfs: 55 runs, 16 regressions (v5.10.165-cip25)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

at91sam9g20ek             | arm    | lab-broonie   | gcc-10   | multi_v5_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =

rk3288-veyron-jaq         | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 4          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 5          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.165-cip25/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.165-cip25
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      52aae1dc6afe62fedb14c89fd4feca1d8bb13416 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d90b6cee07e99c71915eca

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230127.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d90b6cee07e99c71915ecf
        failing since 17 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:36:43.870544  <8>[   17.621137] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8948443_1.5.2.3.1>
    2023-01-31T12:36:43.873897  + set +x
    2023-01-31T12:36:43.979029  / # #
    2023-01-31T12:36:44.080058  export SHELL=3D/bin/sh
    2023-01-31T12:36:44.080244  #
    2023-01-31T12:36:44.181260  / # export SHELL=3D/bin/sh. /lava-8948443/e=
nvironment
    2023-01-31T12:36:44.181894  =

    2023-01-31T12:36:44.283518  / # . /lava-8948443/environment/lava-894844=
3/bin/lava-test-runner /lava-8948443/1
    2023-01-31T12:36:44.284745  =

    2023-01-31T12:36:44.289711  / # /lava-8948443/bin/lava-test-runner /lav=
a-8948443/1 =

    ... (14 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d90afe95719a2d5f915ecd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230127.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d90afe95719a2d5f915ed2
        failing since 17 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:34:53.388488  + <8>[   18.332607] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 8948440_1.5.2.3.1>
    2023-01-31T12:34:53.391800  set +x
    2023-01-31T12:34:53.496629  / # #
    2023-01-31T12:34:53.597692  export SHELL=3D/bin/sh
    2023-01-31T12:34:53.597908  #
    2023-01-31T12:34:53.698822  / # export SHELL=3D/bin/sh. /lava-8948440/e=
nvironment
    2023-01-31T12:34:53.699050  =

    2023-01-31T12:34:53.799957  / # . /lava-8948440/environment/lava-894844=
0/bin/lava-test-runner /lava-8948440/1
    2023-01-31T12:34:53.800281  =

    2023-01-31T12:34:53.804830  / # /lava-8948440/bin/lava-test-runner /lav=
a-8948440/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d90afb000222c4fc915eda

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230127.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d90afb000222c4fc915edf
        failing since 17 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:34:55.049670  + set +x
    2023-01-31T12:34:55.055951  <8>[   18.157541] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8948432_1.5.2.3.1>
    2023-01-31T12:34:55.162325  / # #
    2023-01-31T12:34:55.263413  export SHELL=3D/bin/sh
    2023-01-31T12:34:55.263647  #
    2023-01-31T12:34:55.364576  / # export SHELL=3D/bin/sh. /lava-8948432/e=
nvironment
    2023-01-31T12:34:55.364829  =

    2023-01-31T12:34:55.465776  / # . /lava-8948432/environment/lava-894843=
2/bin/lava-test-runner /lava-8948432/1
    2023-01-31T12:34:55.466110  =

    2023-01-31T12:34:55.470759  / # /lava-8948432/bin/lava-test-runner /lav=
a-8948432/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
at91sam9g20ek             | arm    | lab-broonie   | gcc-10   | multi_v5_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d9136fe7ce2c470d915eee

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20ek=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20ek=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230127.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d9136fe7ce2c470d915ef3
        failing since 17 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T13:10:59.332375  + set +x
    2023-01-31T13:10:59.462712  #
    2023-01-31T13:10:59.565712  / # #export SHELL=3D/bin/sh
    2023-01-31T13:10:59.566482  =

    2023-01-31T13:10:59.668485  / # export SHELL=3D/bin/sh. /lava-219652/en=
vironment
    2023-01-31T13:10:59.669268  =

    2023-01-31T13:10:59.771346  / # . /lava-219652/environment/lava-219652/=
bin/lava-test-runner /lava-219652/1
    2023-01-31T13:10:59.772615  =

    2023-01-31T13:10:59.778863  / # /lava-219652/bin/lava-test-runner /lava=
-219652/1
    2023-01-31T13:11:00.184493  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d9171d86ad6ddb1f915eec

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230127.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d9171d86ad6ddb1f915ef1
        failing since 17 days (last pass: v5.10.158-cip22, first fail: v5.1=
0.162-cip24)

    2023-01-31T13:26:30.976855  <8>[   55.179297] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 219771_1.6.2.4.1>
    2023-01-31T13:26:31.103655  / # #
    2023-01-31T13:26:31.205431  export SHELL=3D/bin/sh
    2023-01-31T13:26:31.205844  #
    2023-01-31T13:26:31.307040  / # export SHELL=3D/bin/sh. /lava-219771/en=
vironment
    2023-01-31T13:26:31.307460  =

    2023-01-31T13:26:31.409025  / # . /lava-219771/environment/lava-219771/=
bin/lava-test-runner /lava-219771/1
    2023-01-31T13:26:31.410067  =

    2023-01-31T13:26:31.414195  / # /lava-219771/bin/lava-test-runner /lava=
-219771/1
    2023-01-31T13:26:31.629813  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63d91668a711126cf3915eba

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-b=
lack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-b=
lack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230127.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d91668a711126cf3915ebf
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b)

    2023-01-31T13:23:40.381074  + set +x
    2023-01-31T13:23:40.385081  <8>[   44.727750] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 219665_1.6.2.4.1>
    2023-01-31T13:23:40.501291  / # #
    2023-01-31T13:23:40.604300  export SHELL=3D/bin/sh
    2023-01-31T13:23:40.605216  #
    2023-01-31T13:23:40.707404  / # export SHELL=3D/bin/sh. /lava-219665/en=
vironment
    2023-01-31T13:23:40.708238  =

    2023-01-31T13:23:40.810603  / # . /lava-219665/environment/lava-219665/=
bin/lava-test-runner /lava-219665/1
    2023-01-31T13:23:40.811892  =

    2023-01-31T13:23:40.816189  / # /lava-219665/bin/lava-test-runner /lava=
-219665/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d90faa870bc55039915ec6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230127.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d90faa870bc55039915ecb
        failing since 17 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:54:58.843763  / # #
    2023-01-31T12:54:58.946734  export SHELL=3D/bin/sh
    2023-01-31T12:54:58.947558  #
    2023-01-31T12:54:59.049642  / # export SHELL=3D/bin/sh. /lava-8948799/e=
nvironment
    2023-01-31T12:54:59.050440  =

    2023-01-31T12:54:59.152557  / # . /lava-8948799/environment/lava-894879=
9/bin/lava-test-runner /lava-8948799/1
    2023-01-31T12:54:59.153799  =

    2023-01-31T12:54:59.167940  / # /lava-8948799/bin/lava-test-runner /lav=
a-8948799/1
    2023-01-31T12:54:59.337736  + export TESTRUN_ID=3D1_bootrr
    2023-01-31T12:54:59.338226  + cd /lava-8948799/1/tests/1_bootrr =

    ... (14 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/63d910512ad3712699915ebc

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-rk3288-veyr=
on-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-rk3288-veyr=
on-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230127.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelc=
i.org/test/case/id/63d910512ad3712699915eeb
        failing since 15 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:57:27.438508  seq: invalid floating point argument: =E2=
=80=98ff980000.hdmi/i2c-*=E2=80=99
    2023-01-31T12:57:27.439236  =

    2023-01-31T12:57:27.442415  Try 'seq --help' for more information.
    2023-01-31T12:57:27.446540  /lava-8948778/1/../bin/lava-test-case
    2023-01-31T12:57:27.447318  =

    2023-01-31T12:57:27.457685  <8>[   19.101319] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-driver-i2c-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelc=
i.org/test/case/id/63d910512ad3712699915eec
        failing since 15 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:57:27.353207  <8>[   18.995015] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-driver-audio-present RESULT=3Dfail>
    2023-01-31T12:57:27.369420  seq: invalid floating point argument: =E2=
=80=98ff980000.hdmi/dw-hdmi-cec.*=E2=80=99
    2023-01-31T12:57:27.373052  Try 'seq --help' for more information.
    2023-01-31T12:57:27.373779  =

    2023-01-31T12:57:27.377194  /lava-8948778/1/../bin/lava-test-case
    2023-01-31T12:57:27.388832  <8>[   19.032184] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.dwhdmi-rockchip-driver-audio-present: https://kerne=
lci.org/test/case/id/63d910512ad3712699915eed
        failing since 15 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:57:27.333230  seq: invalid floating point argument: =E2=
=80=98ff980000.hdmi/dw-hdmi-audio-*=E2=80=99
    2023-01-31T12:57:27.336692  Try 'seq --help' for more information.
    2023-01-31T12:57:27.340441  /lava-8948778/1/../bin/lava-test-case   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d910512ad3712699915f01
        failing since 15 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:57:24.813455  <8>[   16.456181] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-01-31T12:57:24.821192  + <8>[   16.466256] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 8948778_1.6.2.3.1>
    2023-01-31T12:57:24.821784  set +x
    2023-01-31T12:57:25.028598  / #
    2023-01-31T12:57:25.133732  # #export SHELL=3D/bin/sh
    2023-01-31T12:57:25.134536  =

    2023-01-31T12:57:25.235998  / # export SHELL=3D/bin/sh. /lava-8948778/e=
nvironment
    2023-01-31T12:57:25.236826  =

    2023-01-31T12:57:25.338296  / # . /lava-8948778/environment/lava-894877=
8/bin/lava-test-runner /lava-8948778/1
    2023-01-31T12:57:25.339105   =

    ... (24 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/63d90d10032da23c9f915f2f

  Results:     86 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230127.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/63d90d10032da23c9f915f51
        failing since 308 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2023-01-31T12:43:52.439724  <8>[   92.278927] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2023-01-31T12:43:52.439993  =

    2023-01-31T12:43:53.487111  /lava-8948551/1/../bin/lava-test-case
    2023-01-31T12:43:53.512982  <8>[   93.352157] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-rt5514-present: https://ker=
nelci.org/test/case/id/63d90d10032da23c9f915f66
        failing since 17 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:43:51.255153  seq: invalid floating point argument: =E2=
=80=98sound/RT5514=E2=80=99
    2023-01-31T12:43:51.258172  Try 'seq --help' for more information.
    2023-01-31T12:43:51.261715  /lava-8948551/1/../bin/lava-test-case
    2023-01-31T12:43:51.282050  <8>[   91.119645] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-rt5514-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-max98357A-present: https://=
kernelci.org/test/case/id/63d90d10032da23c9f915f67
        failing since 17 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:43:51.205730  seq: invalid floating point argument: =E2=
=80=98sound/MAX98357A=E2=80=99
    2023-01-31T12:43:51.209491  Try 'seq --help' for more information.
    2023-01-31T12:43:51.213036  /lava-8948551/1/../bin/lava-test-case
    2023-01-31T12:43:51.231448  <8>[   91.068630] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-max98357A-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelc=
i.org/test/case/id/63d90d10032da23c9f915f68
        failing since 17 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:43:51.130031  <8>[   90.967088] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>
    2023-01-31T12:43:51.151780  seq: invalid floating point argument: =E2=
=80=98sound/DP=E2=80=99
    2023-01-31T12:43:51.156556  Try 'seq --help' for more information.
    2023-01-31T12:43:51.160258  /lava-8948551/1/../bin/lava-test-case
    2023-01-31T12:43:51.179184  <8>[   91.017348] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-da7219-present: https://ker=
nelci.org/test/case/id/63d90d10032da23c9f915f69
        failing since 17 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-01-31T12:43:51.073213  <8>[   90.911326] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-present RESULT=3Dpass>
    2023-01-31T12:43:51.102354  seq: invalid floating point argument: =E2=
=80=98sound/DA7219=E2=80=99
    2023-01-31T12:43:51.105548  Try 'seq --help' for more information.
    2023-01-31T12:43:51.106238  =

    2023-01-31T12:43:51.109560  /lava-8948551/1/../bin/lava-test-case   =

 =20

