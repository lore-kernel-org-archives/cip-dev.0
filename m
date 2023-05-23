Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F09EC77B73
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 01:41:26 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web11.10935.1684806081556942079
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 May 2023 18:41:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Pwo3x5fu;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.179, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5208be24dcbso4767709a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 22 May 2023 18:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684806080; x=1687398080;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OAXm+f2Xax5oHWnfrP99oZzKiDcn1xa3okZTz3B2E48=;
        b=Pwo3x5fuB354smt28vKM6goAxNLAdgVJ8jRU67mtGjP/fj9J01Ap/z3xrujVtl4O4I
         hTZvfSrzeaC5Q/WUD3YCwJXqmV6ynynoC3cMHH61TrUmMgiaHUFwenHjiZwgu8SM86Cl
         5rQBJkpYE15K9VPgFCnnYjkG/RwoGkNVmp7xY6mNanI+d6252IarsgPPs0ajCufIlU7+
         oLA3lte3m8WpZFT20Zoj31y+dT3q0tzf6o2GQtPVoJ4SZoIv5FEbY8sa7DKw6ZGRCP/e
         O4vPuxs8xuJdjfAo6Ynj/U9YCpeE+BIWDVEWyI+WXyW9T8XLlmwfkNinD559MnJ71I95
         6y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684806080; x=1687398080;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OAXm+f2Xax5oHWnfrP99oZzKiDcn1xa3okZTz3B2E48=;
        b=jozX7WdN5QiNaSYqlsr1WfREhSoAp9g0/olgnmONv8RWoX74RYqE1ypmjKY6wI7T0U
         wc2ljEGtUX652uz3HHwS+uDUot78JJqz77iaB7vdvKLBH8Gi0I9bs8EA3JZldSBAbkrq
         UhJqOZggE6A9d45e8mAyiPiJE3yUa6K7O3qM1oqI4/6QMmoqR6toa7JxaNBLcHKZ+mma
         Fl8kgQFUIhSJ//sq9jVDHgSm5p8K7Ef5Hl7eS3z6+r6vj41+a7YzIn7FEVcbIGHOhYOl
         KKVclrXSOLynZJ7ZDikd9Q+b127brE9cvOraavjCTJZiqGnIFBZES6DUEUaSnmxufyWX
         fwvw==
X-Gm-Message-State: AC+VfDwdn/MHQLw8yTGY1bsJ2QTFJ6uEDIlNhSpoiBNeprivByLIsRAW
	82KwZWxhejd2yAvqEWkHzn8cUfJ1HDHxGv2mkMRgcQ==
X-Google-Smtp-Source: ACHHUZ7OWmECbrL09oaJNgjOcHsQ7UJRh6+1PlIY82PI1UnCx+OGX4ABW0reBCjvDjUwVNBgrioo0Q==
X-Received: by 2002:a17:903:18b:b0:1ac:82bb:ebdf with SMTP id z11-20020a170903018b00b001ac82bbebdfmr13601522plg.58.1684806079193;
        Mon, 22 May 2023 18:41:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902e88800b001a6dc4f4a8csm5465800plg.73.2023.05.22.18.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 18:41:18 -0700 (PDT)
Message-ID: <646c19be.170a0220.7fd49.9ed1@mx.google.com>
Date: Mon, 22 May 2023 18:41:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.280-cip95-rt30
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip-rt baseline: 188 runs,
 39 regressions (v4.19.280-cip95-rt30)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 01:41:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11596

cip/linux-4.19.y-cip-rt baseline: 188 runs, 39 regressions (v4.19.280-cip95=
-rt30)

Regressions Summary
-------------------

platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora   | gcc-10   | defconfig+=
x86-chromebook     | 1          =

at91sam9g20ek            | arm    | lab-broonie     | gcc-10   | multi_v5_d=
efconfig           | 1          =

beaglebone-black         | arm    | lab-broonie     | gcc-10   | defconfig =
                   | 1          =

beaglebone-black         | arm    | lab-broonie     | gcc-10   | defconfig+=
preempt_rt         | 1          =

beaglebone-black         | arm    | lab-broonie     | gcc-10   | multi_v7_d=
efc...g+preempt_rt | 1          =

beaglebone-black         | arm    | lab-broonie     | gcc-10   | multi_v7_d=
efconfig           | 1          =

dove-cubox               | arm    | lab-pengutronix | gcc-10   | mvebu_v7_d=
efconfig           | 1          =

hip07-d05                | arm64  | lab-collabora   | gcc-10   | defconfig+=
preempt_rt         | 1          =

hp-x360-14-G1-sona       | x86_64 | lab-collabora   | gcc-10   | x86_64_def=
con...k+preempt_rt | 1          =

imx6q-sabrelite          | arm    | lab-collabora   | gcc-10   | defconfig =
                   | 1          =

imx6q-sabrelite          | arm    | lab-collabora   | gcc-10   | defconfig+=
preempt_rt         | 1          =

imx6q-sabrelite          | arm    | lab-collabora   | gcc-10   | multi_v7_d=
efc...g+preempt_rt | 1          =

imx6q-sabrelite          | arm    | lab-collabora   | gcc-10   | multi_v7_d=
efconfig           | 1          =

imx6qp-wandboard-revd1   | arm    | lab-pengutronix | gcc-10   | defconfig =
                   | 1          =

imx6qp-wandboard-revd1   | arm    | lab-pengutronix | gcc-10   | defconfig+=
preempt_rt         | 1          =

imx6qp-wandboard-revd1   | arm    | lab-pengutronix | gcc-10   | imx_v6_v7_=
defconfig          | 1          =

imx6qp-wandboard-revd1   | arm    | lab-pengutronix | gcc-10   | multi_v7_d=
efc...g+preempt_rt | 1          =

imx6qp-wandboard-revd1   | arm    | lab-pengutronix | gcc-10   | multi_v7_d=
efconfig           | 1          =

imx7d-sdb                | arm    | lab-nxp         | gcc-10   | defconfig =
                   | 1          =

imx7d-sdb                | arm    | lab-nxp         | gcc-10   | defconfig+=
preempt_rt         | 1          =

r8a774b1-hihope-rzg2n-ex | arm64  | lab-cip         | gcc-10   | defconfig+=
preempt_rt         | 1          =

rk3288-veyron-jaq        | arm    | lab-collabora   | gcc-10   | defconfig =
                   | 3          =

rk3288-veyron-jaq        | arm    | lab-collabora   | gcc-10   | defconfig+=
preempt_rt         | 3          =

rk3288-veyron-jaq        | arm    | lab-collabora   | gcc-10   | multi_v7_d=
efc...g+preempt_rt | 3          =

rk3288-veyron-jaq        | arm    | lab-collabora   | gcc-10   | multi_v7_d=
efconfig           | 3          =

sun50i-a64-pine64-plus   | arm64  | lab-broonie     | gcc-10   | defconfig+=
preempt_rt         | 1          =

sun50i-a64-pine64-plus   | arm64  | lab-broonie     | gcc-10   | defconfig =
                   | 1          =

sun50i-h6-pine-h64       | arm64  | lab-collabora   | gcc-10   | defconfig+=
preempt_rt         | 1          =

sun50i-h6-pine-h64       | arm64  | lab-collabora   | gcc-10   | defconfig =
                   | 1          =

zynqmp-zcu102            | arm64  | lab-cip         | gcc-10   | defconfig+=
preempt_rt         | 1          =

zynqmp-zcu102            | arm64  | lab-cip         | gcc-10   | defconfig =
                   | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.280-cip95-rt30/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.280-cip95-rt30
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dcee20e65677ab5d0e0d47c572f2c71dae6074a1 =



Test Regressions
---------------- =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora   | gcc-10   | defconfig+=
x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0d92eb5c47c8222e8600

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0d92eb5c47c8222e8605
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T00:49:06.493643  + set +x

    2023-05-23T00:49:06.499740  <8>[   12.720361] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10419501_1.4.2.3.1>

    2023-05-23T00:49:06.607847  / # #

    2023-05-23T00:49:06.710100  export SHELL=3D/bin/sh

    2023-05-23T00:49:06.710860  #

    2023-05-23T00:49:06.812238  / # export SHELL=3D/bin/sh. /lava-10419501/=
environment

    2023-05-23T00:49:06.813035  =


    2023-05-23T00:49:06.914416  / # . /lava-10419501/environment/lava-10419=
501/bin/lava-test-runner /lava-10419501/1

    2023-05-23T00:49:06.915680  =


    2023-05-23T00:49:06.920986  / # /lava-10419501/bin/lava-test-runner /la=
va-10419501/1
 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
at91sam9g20ek            | arm    | lab-broonie     | gcc-10   | multi_v5_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646c12785ebfd124d62e85ff

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g=
20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g=
20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c12795ebfd124d62e8631
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:09:33.591639  + set +x
    2023-05-23T01:09:33.596775  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 498982_1.5.2=
.4.1>
    2023-05-23T01:09:33.709970  / # #
    2023-05-23T01:09:33.812848  export SHELL=3D/bin/sh
    2023-05-23T01:09:33.813618  #
    2023-05-23T01:09:33.915586  / # export SHELL=3D/bin/sh. /lava-498982/en=
vironment
    2023-05-23T01:09:33.916388  =

    2023-05-23T01:09:34.018432  / # . /lava-498982/environment/lava-498982/=
bin/lava-test-runner /lava-498982/1
    2023-05-23T01:09:34.019789  =

    2023-05-23T01:09:34.026107  / # /lava-498982/bin/lava-test-runner /lava=
-498982/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
beaglebone-black         | arm    | lab-broonie     | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0ed2595dee7a9a2e85e6

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0ed3595dee7a9a2e8610
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T00:54:01.857583  <8>[   15.371614] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 498903_1.5.2.4.1>
    2023-05-23T00:54:01.966981  / # #
    2023-05-23T00:54:02.069669  export SHELL=3D/bin/sh
    2023-05-23T00:54:02.070304  #
    2023-05-23T00:54:02.172095  / # export SHELL=3D/bin/sh. /lava-498903/en=
vironment
    2023-05-23T00:54:02.172787  =

    2023-05-23T00:54:02.274640  / # . /lava-498903/environment/lava-498903/=
bin/lava-test-runner /lava-498903/1
    2023-05-23T00:54:02.275889  =

    2023-05-23T00:54:02.279587  / # /lava-498903/bin/lava-test-runner /lava=
-498903/1
    2023-05-23T00:54:02.346812  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
beaglebone-black         | arm    | lab-broonie     | gcc-10   | defconfig+=
preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/646c1347397d1c14412e85ed

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-beagleb=
one-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-beagleb=
one-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c1347397d1c14412e8618
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:13:00.420967  <8>[   16.257778] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 499082_1.5.2.4.1>
    2023-05-23T01:13:00.532271  / # #
    2023-05-23T01:13:00.634988  export SHELL=3D/bin/sh
    2023-05-23T01:13:00.635718  #
    2023-05-23T01:13:00.738232  / # export SHELL=3D/bin/sh. /lava-499082/en=
vironment
    2023-05-23T01:13:00.739028  =

    2023-05-23T01:13:00.841592  / # . /lava-499082/environment/lava-499082/=
bin/lava-test-runner /lava-499082/1
    2023-05-23T01:13:00.842951  =

    2023-05-23T01:13:00.847025  / # /lava-499082/bin/lava-test-runner /lava=
-499082/1
    2023-05-23T01:13:00.929815  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
beaglebone-black         | arm    | lab-broonie     | gcc-10   | multi_v7_d=
efc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/646c118ffbaa30fac32e861d

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-broonie/baselin=
e-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-broonie/baselin=
e-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c118ffbaa30fac32e8648
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:05:40.197031  <8>[   17.978353] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 498999_1.5.2.4.1>
    2023-05-23T01:05:40.308595  / # #
    2023-05-23T01:05:40.411546  export SHELL=3D/bin/sh
    2023-05-23T01:05:40.412332  #
    2023-05-23T01:05:40.514712  / # export SHELL=3D/bin/sh. /lava-498999/en=
vironment
    2023-05-23T01:05:40.515459  =

    2023-05-23T01:05:40.617818  / # . /lava-498999/environment/lava-498999/=
bin/lava-test-runner /lava-498999/1
    2023-05-23T01:05:40.618996  =

    2023-05-23T01:05:40.622713  / # /lava-498999/bin/lava-test-runner /lava=
-498999/1
    2023-05-23T01:05:40.706403  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
beaglebone-black         | arm    | lab-broonie     | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646c11f38d934da0332e85f2

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebon=
e-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebon=
e-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c11f38d934da0332e861d
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:07:17.626396  <8>[   15.331382] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 499057_1.5.2.4.1>
    2023-05-23T01:07:17.734729  / # #
    2023-05-23T01:07:17.837794  export SHELL=3D/bin/sh
    2023-05-23T01:07:17.838544  #
    2023-05-23T01:07:17.940743  / # export SHELL=3D/bin/sh. /lava-499057/en=
vironment
    2023-05-23T01:07:17.941572  =

    2023-05-23T01:07:18.043970  / # . /lava-499057/environment/lava-499057/=
bin/lava-test-runner /lava-499057/1
    2023-05-23T01:07:18.045413  =

    2023-05-23T01:07:18.049320  / # /lava-499057/bin/lava-test-runner /lava=
-499057/1
    2023-05-23T01:07:18.116584  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
dove-cubox               | arm    | lab-pengutronix | gcc-10   | mvebu_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0fbe040cf306e62e85f2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: mvebu_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/mvebu_v7_defconfig/gcc-10/lab-pengutronix/baseline-dove-=
cubox.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/mvebu_v7_defconfig/gcc-10/lab-pengutronix/baseline-dove-=
cubox.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0fbe040cf306e62e85f7
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T00:58:21.049263  + set +x
    2023-05-23T00:58:21.049421  [    4.297655] <LAVA_SIGNAL_ENDRUN 0_dmesg =
956997_1.5.2.3.1>
    2023-05-23T00:58:21.155943  / # #
    2023-05-23T00:58:21.257833  export SHELL=3D/bin/sh
    2023-05-23T00:58:21.258442  #
    2023-05-23T00:58:21.359862  / # export SHELL=3D/bin/sh. /lava-956997/en=
vironment
    2023-05-23T00:58:21.360350  =

    2023-05-23T00:58:21.461605  / # . /lava-956997/environment/lava-956997/=
bin/lava-test-runner /lava-956997/1
    2023-05-23T00:58:21.462279  =

    2023-05-23T00:58:21.465184  / # /lava-956997/bin/lava-test-runner /lava=
-956997/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
hip07-d05                | arm64  | lab-collabora   | gcc-10   | defconfig+=
preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/646c1115694404f19c2e85ee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-hip=
07-d05.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-hip=
07-d05.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c1115694404f19c2e8=
5ef
        new failure (last pass: v4.19.269-cip88-rt28) =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
hp-x360-14-G1-sona       | x86_64 | lab-collabora   | gcc-10   | x86_64_def=
con...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0f7133179043a52e8696

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0f7133179043a52e8=
697
        failing since 61 days (last pass: v4.19.269-cip88-rt28, first fail:=
 v4.19.277-cip94-rt29) =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
imx6q-sabrelite          | arm    | lab-collabora   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0ea9344cebf80a2e8616

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0ea9344cebf80a2e861b
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T00:53:50.813978  / # #

    2023-05-23T00:53:50.916337  export SHELL=3D/bin/sh

    2023-05-23T00:53:50.917068  #

    2023-05-23T00:53:51.018924  / # export SHELL=3D/bin/sh. /lava-10419644/=
environment

    2023-05-23T00:53:51.019664  =


    2023-05-23T00:53:51.121235  / # . /lava-10419644/environment/lava-10419=
644/bin/lava-test-runner /lava-10419644/1

    2023-05-23T00:53:51.122407  =


    2023-05-23T00:53:51.136933  / # /lava-10419644/bin/lava-test-runner /la=
va-10419644/1

    2023-05-23T00:53:51.243005  + export 'TESTRUN_ID=3D1_bootrr'

    2023-05-23T00:53:51.243540  + cd /lava-10419644/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
imx6q-sabrelite          | arm    | lab-collabora   | gcc-10   | defconfig+=
preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/646c130a9d9d75b6462e8642

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-imx6q=
-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-imx6q=
-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c130a9d9d75b6462e8647
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:12:31.629312  / # #

    2023-05-23T01:12:31.731233  export SHELL=3D/bin/sh

    2023-05-23T01:12:31.731936  #

    2023-05-23T01:12:31.833792  / # export SHELL=3D/bin/sh. /lava-10419833/=
environment

    2023-05-23T01:12:31.834573  =


    2023-05-23T01:12:31.936472  / # . /lava-10419833/environment/lava-10419=
833/bin/lava-test-runner /lava-10419833/1

    2023-05-23T01:12:31.937652  =


    2023-05-23T01:12:31.951987  / # /lava-10419833/bin/lava-test-runner /la=
va-10419833/1

    2023-05-23T01:12:32.065885  + export 'TESTRUN_ID=3D1_bootrr'

    2023-05-23T01:12:32.066397  + cd /lava-10419833/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
imx6q-sabrelite          | arm    | lab-collabora   | gcc-10   | multi_v7_d=
efc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/646c1152852a75b22f2e85ee

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/basel=
ine-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/basel=
ine-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c1152852a75b22f2e85f3
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:04:53.723049  / # #

    2023-05-23T01:04:53.825248  export SHELL=3D/bin/sh

    2023-05-23T01:04:53.825984  #

    2023-05-23T01:04:53.927855  / # export SHELL=3D/bin/sh. /lava-10419788/=
environment

    2023-05-23T01:04:53.928569  =


    2023-05-23T01:04:54.030495  / # . /lava-10419788/environment/lava-10419=
788/bin/lava-test-runner /lava-10419788/1

    2023-05-23T01:04:54.031768  =


    2023-05-23T01:04:54.046314  / # /lava-10419788/bin/lava-test-runner /la=
va-10419788/1

    2023-05-23T01:04:54.168296  + export 'TESTRUN_ID=3D1_bootrr'

    2023-05-23T01:04:54.168828  + cd /lava-10419788/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
imx6q-sabrelite          | arm    | lab-collabora   | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646c11a176d8cb42232e8659

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-s=
abrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-s=
abrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c11a176d8cb42232e865e
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:06:29.972012  / # #

    2023-05-23T01:06:30.073654  export SHELL=3D/bin/sh

    2023-05-23T01:06:30.074380  #

    2023-05-23T01:06:30.176106  / # export SHELL=3D/bin/sh. /lava-10419806/=
environment

    2023-05-23T01:06:30.176891  =


    2023-05-23T01:06:30.278610  / # . /lava-10419806/environment/lava-10419=
806/bin/lava-test-runner /lava-10419806/1

    2023-05-23T01:06:30.279801  =


    2023-05-23T01:06:30.294663  / # /lava-10419806/bin/lava-test-runner /la=
va-10419806/1

    2023-05-23T01:06:30.403483  + export 'TESTRUN_ID=3D1_bootrr'

    2023-05-23T01:06:30.404023  + cd /lava-10419806/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
imx6qp-wandboard-revd1   | arm    | lab-pengutronix | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0ebaac3a9184122e85ec

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboa=
rd-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboa=
rd-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0ebaac3a9184122e85f1
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T00:54:06.896393  + set +x
    2023-05-23T00:54:06.896571  [    4.916576] <LAVA_SIGNAL_ENDRUN 0_dmesg =
956990_1.5.2.3.1>
    2023-05-23T00:54:07.002386  / # #
    2023-05-23T00:54:07.103970  export SHELL=3D/bin/sh
    2023-05-23T00:54:07.104420  #
    2023-05-23T00:54:07.205667  / # export SHELL=3D/bin/sh. /lava-956990/en=
vironment
    2023-05-23T00:54:07.206090  =

    2023-05-23T00:54:07.307375  / # . /lava-956990/environment/lava-956990/=
bin/lava-test-runner /lava-956990/1
    2023-05-23T00:54:07.308009  =

    2023-05-23T00:54:07.310329  / # /lava-956990/bin/lava-test-runner /lava=
-956990/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
imx6qp-wandboard-revd1   | arm    | lab-pengutronix | gcc-10   | defconfig+=
preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/646c12df58b6686e432e860c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig+preempt_rt/gcc-10/lab-pengutronix/baseline-imx=
6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig+preempt_rt/gcc-10/lab-pengutronix/baseline-imx=
6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c12df58b6686e432e8611
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:11:50.905420  + set +x
    2023-05-23T01:11:50.905582  [    6.816959] <LAVA_SIGNAL_ENDRUN 0_dmesg =
957023_1.5.2.3.1>
    2023-05-23T01:11:51.012207  / # #
    2023-05-23T01:11:51.113909  export SHELL=3D/bin/sh
    2023-05-23T01:11:51.114375  #
    2023-05-23T01:11:51.215624  / # export SHELL=3D/bin/sh. /lava-957023/en=
vironment
    2023-05-23T01:11:51.216083  =

    2023-05-23T01:11:51.317437  / # . /lava-957023/environment/lava-957023/=
bin/lava-test-runner /lava-957023/1
    2023-05-23T01:11:51.318056  =

    2023-05-23T01:11:51.320597  / # /lava-957023/bin/lava-test-runner /lava=
-957023/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
imx6qp-wandboard-revd1   | arm    | lab-pengutronix | gcc-10   | imx_v6_v7_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/646c114e6db7c205a92e8615

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c114e6db7c205a92e861a
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:05:07.102638  + set +x[    7.220278] <LAVA_SIGNAL_ENDRUN =
0_dmesg 957008_1.5.2.3.1>
    2023-05-23T01:05:07.102841  =

    2023-05-23T01:05:07.209569  / # #
    2023-05-23T01:05:07.311369  export SHELL=3D/bin/sh
    2023-05-23T01:05:07.311781  #
    2023-05-23T01:05:07.412976  / # export SHELL=3D/bin/sh. /lava-957008/en=
vironment
    2023-05-23T01:05:07.413394  =

    2023-05-23T01:05:07.514903  / # . /lava-957008/environment/lava-957008/=
bin/lava-test-runner /lava-957008/1
    2023-05-23T01:05:07.515476  =

    2023-05-23T01:05:07.517887  / # /lava-957008/bin/lava-test-runner /lava=
-957008/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
imx6qp-wandboard-revd1   | arm    | lab-pengutronix | gcc-10   | multi_v7_d=
efc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/646c111231914162182e85f9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c111231914162182e85fe
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:04:08.855897  + set +x[    6.596722] <LAVA_SIGNAL_ENDRUN =
0_dmesg 957001_1.5.2.3.1>
    2023-05-23T01:04:08.856159  =

    2023-05-23T01:04:08.962703  / # #
    2023-05-23T01:04:09.064455  export SHELL=3D/bin/sh
    2023-05-23T01:04:09.064878  #
    2023-05-23T01:04:09.166087  / # export SHELL=3D/bin/sh. /lava-957001/en=
vironment
    2023-05-23T01:04:09.166583  =

    2023-05-23T01:04:09.268022  / # . /lava-957001/environment/lava-957001/=
bin/lava-test-runner /lava-957001/1
    2023-05-23T01:04:09.268631  =

    2023-05-23T01:04:09.271577  / # /lava-957001/bin/lava-test-runner /lava=
-957001/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
imx6qp-wandboard-revd1   | arm    | lab-pengutronix | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646c118ced38a02c272e85f8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6q=
p-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6q=
p-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c118ced38a02c272e85fd
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:06:08.704215  + set +x
    2023-05-23T01:06:08.704398  [    4.887332] <LAVA_SIGNAL_ENDRUN 0_dmesg =
957019_1.5.2.3.1>
    2023-05-23T01:06:08.809987  / # #
    2023-05-23T01:06:08.911473  export SHELL=3D/bin/sh
    2023-05-23T01:06:08.911901  #
    2023-05-23T01:06:09.013188  / # export SHELL=3D/bin/sh. /lava-957019/en=
vironment
    2023-05-23T01:06:09.013728  =

    2023-05-23T01:06:09.115114  / # . /lava-957019/environment/lava-957019/=
bin/lava-test-runner /lava-957019/1
    2023-05-23T01:06:09.115770  =

    2023-05-23T01:06:09.118689  / # /lava-957019/bin/lava-test-runner /lava=
-957019/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
imx7d-sdb                | arm    | lab-nxp         | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0f5a33179043a52e85e7

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0f5a33179043a52e85ea
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T00:56:38.934516  / # #
    2023-05-23T00:56:40.092425  export SHELL=3D/bin/sh
    2023-05-23T00:56:40.097821  #
    2023-05-23T00:56:40.097947  / # export SHELL=3D/bin/sh
    2023-05-23T00:56:41.642561  / # . /lava-1226978/environment
    2023-05-23T00:56:44.465692  /lava-1226978/bin/lava-test-runner /lava-12=
26978/1
    2023-05-23T00:56:44.471356  . /lava-1226978/environment
    2023-05-23T00:56:44.476245  / # /lava-1226978/bin/lava-test-runner /lav=
a-1226978/1
    2023-05-23T00:56:44.577256  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-23T00:56:44.577696  + cd /lava-1226978/1/tests/1_bootrr =

    ... (15 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
imx7d-sdb                | arm    | lab-nxp         | gcc-10   | defconfig+=
preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/646c152fe485c73b4a2e866b

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-imx7d-sdb.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-imx7d-sdb.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c152fe485c73b4a2e866e
        failing since 124 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:21:15.600948  <8>[   14.322131] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1226995_1.5.2.4.1>
    2023-05-23T01:21:15.706503  / # #
    2023-05-23T01:21:16.866870  export SHELL=3D/bin/sh
    2023-05-23T01:21:16.872565  #
    2023-05-23T01:21:18.420317  / # export SHELL=3D/bin/sh. /lava-1226995/e=
nvironment
    2023-05-23T01:21:18.426015  =

    2023-05-23T01:21:21.248894  / # . /lava-1226995/environment/lava-122699=
5/bin/lava-test-runner /lava-1226995/1
    2023-05-23T01:21:21.255008  =

    2023-05-23T01:21:21.260905  / # /lava-1226995/bin/lava-test-runner /lav=
a-1226995/1
    2023-05-23T01:21:21.324948  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (17 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
r8a774b1-hihope-rzg2n-ex | arm64  | lab-cip         | gcc-10   | defconfig+=
preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0fa2f4350516632e862e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-r8a774b1-=
hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-r8a774b1-=
hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0fa2f4350516632e8=
62f
        new failure (last pass: v4.19.277-cip94-rt29) =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
rk3288-veyron-jaq        | arm    | lab-collabora   | gcc-10   | defconfig =
                   | 3          =


  Details:     https://kernelci.org/test/plan/id/646c0ed1ac3a9184122e85fe

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-ja=
q.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-ja=
q.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0ed1ac3a9184122e862c
        failing since 122 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T00:54:18.997766  <8>[    6.634597] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-05-23T00:54:19.006831  + <8>[    6.646731] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10419641_1.5.2.3.1>

    2023-05-23T00:54:19.007848  set +x

    2023-05-23T00:54:19.113244  /#

    2023-05-23T00:54:19.215652   # #export SHELL=3D/bin/sh

    2023-05-23T00:54:19.216356  =


    2023-05-23T00:54:19.317645  / # export SHELL=3D/bin/sh. /lava-10419641/=
environment

    2023-05-23T00:54:19.318339  =


    2023-05-23T00:54:19.419686  / # . /lava-10419641/environment/lava-10419=
641/bin/lava-test-runner /lava-10419641/1

    2023-05-23T00:54:19.420757  =

 =

    ... (17 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/646c0ed1ac3a9184122e8632
        failing since 122 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T00:54:22.846895  BusyBox v1.31.1 (2023-05-12 17:02:46 UTC)<8=
>[   10.482120] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-05-23T00:54:22.848666   multi-call binary.

    2023-05-23T00:54:22.848883  =


    2023-05-23T00:54:22.853353  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-05-23T00:54:22.853593  =


    2023-05-23T00:54:22.858832  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-05-23T00:54:22.868822  FIRST,<8>[   10.500921] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/646c0ed1ac3a9184122e8633
        failing since 122 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28) =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
rk3288-veyron-jaq        | arm    | lab-collabora   | gcc-10   | defconfig+=
preempt_rt         | 3          =


  Details:     https://kernelci.org/test/plan/id/646c12f89d9d75b6462e85ed

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-rk328=
8-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-rk328=
8-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/646c12f89d9d75b6462e861d
        failing since 122 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:12:01.398185  <8>[   11.596193] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-driver-audio-present RESULT=3Dfail>

    2023-05-23T01:12:01.398243  =


    2023-05-23T01:12:01.402620  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-05-23T01:12:01.403047  =


    2023-05-23T01:12:01.407872  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-05-23T01:12:01.410438  FIRST, INC default to 1.

    2023-05-23T01:12:01.410662  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/646c12f89d9d75b6462e861e
        failing since 122 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:12:01.376768  =


    2023-05-23T01:12:01.387878  BusyBox v1.31.1 (2023-05-12 17:02:46 UTC) m=
ulti-call binary.
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c12f89d9d75b6462e8631
        failing since 122 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:11:57.524557  + <8>[    7.727789] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10419836_1.5.2.3.1>

    2023-05-23T01:11:57.524957  set +x

    2023-05-23T01:11:57.631080  =


    2023-05-23T01:11:57.732656  / # #export SHELL=3D/bin/sh

    2023-05-23T01:11:57.733373  =


    2023-05-23T01:11:57.834843  / # export SHELL=3D/bin/sh. /lava-10419836/=
environment

    2023-05-23T01:11:57.835551  =


    2023-05-23T01:11:57.937042  / # . /lava-10419836/environment/lava-10419=
836/bin/lava-test-runner /lava-10419836/1

    2023-05-23T01:11:57.938113  =


    2023-05-23T01:11:57.939660  / # /lava-10419836/bin/lava-test-runner /la=
va-10419836/1
 =

    ... (16 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
rk3288-veyron-jaq        | arm    | lab-collabora   | gcc-10   | multi_v7_d=
efc...g+preempt_rt | 3          =


  Details:     https://kernelci.org/test/plan/id/646c1129ca9d0b503d2e8603

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/basel=
ine-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/basel=
ine-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/646c1129ca9d0b503d2e8633
        failing since 122 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:04:22.560503  <8>[   10.731558] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-driver-audio-present RESULT=3Dfail>

    2023-05-23T01:04:22.564718  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-05-23T01:04:22.564946  =


    2023-05-23T01:04:22.569824  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-05-23T01:04:22.572497  FIRST, INC default to 1.

    2023-05-23T01:04:22.572717  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/646c1129ca9d0b503d2e8634
        failing since 122 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:04:22.538795  /lava-10419785/1/../bin/lava-test-case<8>[ =
  10.712828] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed RE=
SULT=3Dpass>

    2023-05-23T01:04:22.538846  =


    2023-05-23T01:04:22.549969  BusyBox v1.31.1 (2023-05-12 17:02:46 UTC) m=
ulti-call binary.

    2023-05-23T01:04:22.550194  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c1129ca9d0b503d2e8647
        failing since 122 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:04:18.670883  <8>[    6.844310] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-05-23T01:04:18.679880  + <8>[    6.856531] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10419785_1.5.2.3.1>

    2023-05-23T01:04:18.680514  set +x

    2023-05-23T01:04:18.787444  =


    2023-05-23T01:04:18.889101  / # #export SHELL=3D/bin/sh

    2023-05-23T01:04:18.889900  =


    2023-05-23T01:04:18.991333  / # export SHELL=3D/bin/sh. /lava-10419785/=
environment

    2023-05-23T01:04:18.992114  =


    2023-05-23T01:04:19.093583  / # . /lava-10419785/environment/lava-10419=
785/bin/lava-test-runner /lava-10419785/1

    2023-05-23T01:04:19.094807  =

 =

    ... (16 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
rk3288-veyron-jaq        | arm    | lab-collabora   | gcc-10   | multi_v7_d=
efconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/646c118e7a98a7ce062e85f7

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-=
veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-=
veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c118e7a98a7ce062e8617
        failing since 122 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:05:57.678872  <8>[    6.523567] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-05-23T01:05:57.688051  + <8>[    6.535766] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10419810_1.5.2.3.1>

    2023-05-23T01:05:57.688433  set +x

    2023-05-23T01:05:57.794682  #

    2023-05-23T01:05:57.795643  =


    2023-05-23T01:05:57.897060  / # #export SHELL=3D/bin/sh

    2023-05-23T01:05:57.897712  =


    2023-05-23T01:05:57.999032  / # export SHELL=3D/bin/sh. /lava-10419810/=
environment

    2023-05-23T01:05:57.999754  =


    2023-05-23T01:05:58.101214  / # . /lava-10419810/environment/lava-10419=
810/bin/lava-test-runner /lava-10419810/1
 =

    ... (19 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/646c118e7a98a7ce062e8621
        failing since 122 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:06:01.529656  BusyBox v1.31.1 (2023-05-12 17:02:46 UTC)<8=
>[   10.373050] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-05-23T01:06:01.531567   multi-call binary.

    2023-05-23T01:06:01.531787  =


    2023-05-23T01:06:01.536129  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-05-23T01:06:01.536491  =


    2023-05-23T01:06:01.541373  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/646c118e7a98a7ce062e8622
        failing since 122 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28) =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
sun50i-a64-pine64-plus   | arm64  | lab-broonie     | gcc-10   | defconfig+=
preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0f5d33179043a52e85f4

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-sun50=
i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-sun50=
i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0f5d33179043a52e861a
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T00:56:16.110583  + set<8>[   16.933242] <LAVA_SIGNAL_ENDRUN =
0_dmesg 498894_1.5.2.4.1>
    2023-05-23T00:56:16.110904   +x
    2023-05-23T00:56:16.218240  / # #
    2023-05-23T00:56:16.320809  export SHELL=3D/bin/sh
    2023-05-23T00:56:16.321711  #
    2023-05-23T00:56:16.423903  / # export SHELL=3D/bin/sh. /lava-498894/en=
vironment
    2023-05-23T00:56:16.425413  =

    2023-05-23T00:56:16.527445  / # . /lava-498894/environment/lava-498894/=
bin/lava-test-runner /lava-498894/1
    2023-05-23T00:56:16.528496  =

    2023-05-23T00:56:16.532338  / # /lava-498894/bin/lava-test-runner /lava=
-498894/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
sun50i-a64-pine64-plus   | arm64  | lab-broonie     | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/646c11ff8e5299d77f2e8600

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine6=
4-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine6=
4-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c11ff8e5299d77f2e8626
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:07:43.539942  <8>[   15.936716] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 499021_1.5.2.4.1>
    2023-05-23T01:07:43.646266  / # #
    2023-05-23T01:07:43.747624  export SHELL=3D/bin/sh
    2023-05-23T01:07:43.748233  #
    2023-05-23T01:07:43.849557  / # export SHELL=3D/bin/sh. /lava-499021/en=
vironment
    2023-05-23T01:07:43.850308  =

    2023-05-23T01:07:43.951986  / # . /lava-499021/environment/lava-499021/=
bin/lava-test-runner /lava-499021/1
    2023-05-23T01:07:43.952888  =

    2023-05-23T01:07:43.956096  / # /lava-499021/bin/lava-test-runner /lava=
-499021/1
    2023-05-23T01:07:43.988304  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
sun50i-h6-pine-h64       | arm64  | lab-collabora   | gcc-10   | defconfig+=
preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0e961f374a55fd2e8606

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-sun=
50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-sun=
50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0e961f374a55fd2e860b
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T00:53:21.116299  / # #

    2023-05-23T00:53:21.218472  export SHELL=3D/bin/sh

    2023-05-23T00:53:21.219171  #

    2023-05-23T00:53:21.320427  / # export SHELL=3D/bin/sh. /lava-10419637/=
environment

    2023-05-23T00:53:21.321198  =


    2023-05-23T00:53:21.422639  / # . /lava-10419637/environment/lava-10419=
637/bin/lava-test-runner /lava-10419637/1

    2023-05-23T00:53:21.423664  =


    2023-05-23T00:53:21.440909  / # /lava-10419637/bin/lava-test-runner /la=
va-10419637/1

    2023-05-23T00:53:21.506923  + export 'TESTRUN_ID=3D1_bootrr'

    2023-05-23T00:53:21.507458  + cd /lava-10419637/1/te<8>[   16.436895] <=
LAVA_SIGNAL_STARTRUN 1_bootrr 10419637_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
sun50i-h6-pine-h64       | arm64  | lab-collabora   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/646c1166b64afa23442e85f7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine=
-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine=
-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c1166b64afa23442e85fc
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:05:20.203271  / # #

    2023-05-23T01:05:20.305399  export SHELL=3D/bin/sh

    2023-05-23T01:05:20.306097  #

    2023-05-23T01:05:20.407267  / # export SHELL=3D/bin/sh. /lava-10419798/=
environment

    2023-05-23T01:05:20.407954  =


    2023-05-23T01:05:20.509226  / # . /lava-10419798/environment/lava-10419=
798/bin/lava-test-runner /lava-10419798/1

    2023-05-23T01:05:20.510386  =


    2023-05-23T01:05:20.516954  / # /lava-10419798/bin/lava-test-runner /la=
va-10419798/1

    2023-05-23T01:05:20.584187  + export 'TESTRUN_ID=3D1_bootrr'

    2023-05-23T01:05:20.584731  + cd /lava-1041979<8>[   15.596515] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 10419798_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
zynqmp-zcu102            | arm64  | lab-cip         | gcc-10   | defconfig+=
preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0e87581b9864a72e8630

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-zynqmp-zc=
u102.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-zynqmp-zc=
u102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0e87581b9864a72e8633
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T00:53:05.882297  + set +x
    2023-05-23T00:53:05.883376  <8>[    4.431941] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 940821_1.5.2.4.1>
    2023-05-23T00:53:05.990958  / # #
    2023-05-23T00:53:06.092860  export SHELL=3D/bin/sh
    2023-05-23T00:53:06.093329  #
    2023-05-23T00:53:06.194729  / # export SHELL=3D/bin/sh. /lava-940821/en=
vironment
    2023-05-23T00:53:06.195360  =

    2023-05-23T00:53:06.296823  / # . /lava-940821/environment/lava-940821/=
bin/lava-test-runner /lava-940821/1
    2023-05-23T00:53:06.297569  =

    2023-05-23T00:53:06.300323  / # /lava-940821/bin/lava-test-runner /lava=
-940821/1 =

    ... (13 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
zynqmp-zcu102            | arm64  | lab-cip         | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/646c11e4aae7234b7c2e8609

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c11e4aae7234b7c2e860c
        failing since 124 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-05-23T01:07:32.023878  <8>[    3.768655] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 940891_1.5.2.4.1>
    2023-05-23T01:07:32.129857  / # #
    2023-05-23T01:07:32.231814  export SHELL=3D/bin/sh
    2023-05-23T01:07:32.232273  #
    2023-05-23T01:07:32.333665  / # export SHELL=3D/bin/sh. /lava-940891/en=
vironment
    2023-05-23T01:07:32.334116  =

    2023-05-23T01:07:32.435526  / # . /lava-940891/environment/lava-940891/=
bin/lava-test-runner /lava-940891/1
    2023-05-23T01:07:32.436255  =

    2023-05-23T01:07:32.439169  / # /lava-940891/bin/lava-test-runner /lava=
-940891/1
    2023-05-23T01:07:32.476172  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =20

