Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B79C77B73
	for <webhook@archiver.kernel.org>; Thu, 18 May 2023 22:55:54 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web10.6598.1684450549392696721
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 18 May 2023 15:55:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=GpsH70YP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.178, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-528cdc9576cso1792408a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 18 May 2023 15:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684450548; x=1687042548;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A/4171HmJqCox8x/WtgjPCpWs0Pe19SUayeWmohGZP8=;
        b=GpsH70YPCZPvxlINhN2uHL5vhFfU/ND0dhpPmhn+TEFGjmTBnJCleOLSs0lVF8hqve
         ZXixHgfDaWmj8vz8EOOynKd+SgzKEi/2asnDWPEHCypl3h21vx+XOcMMnWu+al/EvXGx
         /7/DgCRDTbONoSLOjP5IjMCIFJ5OuC+za9kme58kVzN3W+AK5WiW0FzUfTDjnJni57In
         T6Hx9oOg7IWj8/rO3ECRrU1a6swJ/mQNm8txCmNG6K/vo12J6mlnApqU2jRr+dFZKMu2
         Yz94vfK5OTGXUUu9kaAQVjJ5lmRHiPjXXPWu1fph9MxCkULhuo5N4riSSzn3fiHgW7G1
         UFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684450548; x=1687042548;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/4171HmJqCox8x/WtgjPCpWs0Pe19SUayeWmohGZP8=;
        b=h8inEtbPQZ9kG0B3Wx1swuymPlYvceh+w6PCguadwUMW6t+k/X2osfQG8uONrfcAbK
         2wawfve3ZZvaPKD1IeH4U6v6vdu6efm9f1/0bnRjiwrDfkmdANbHYUxRRAStEl9GfqaZ
         VaLJNbjuUUbMI4gJib2aSOvlkGYD5G0lH/n5SnMp9TrdQ7jXd9zTCXn+jfd+knuL6oe5
         WWvEWDfznzFbxuA+6d6pmtQML5rlLX6Yv8KzAP3CiIsUxGcUizL3ey7hfNhRFn/h+I5e
         k0f9vKOg8NrpMOMWK+hOl9kt2IBZswTI9RVaeWlhI7HQMWmRq+VMV5g8+pF7DFwU7+tQ
         rLaw==
X-Gm-Message-State: AC+VfDwV0hf42OLANHgFL6bTzXouWsh69rImPiyBsl4nSqJSwXCE4xDT
	4gWsFcFJPiYKAZ2MbdK4H25OYBhbXhwCxkyVYvDvEA==
X-Google-Smtp-Source: ACHHUZ6zEFQ5b8rH/4QU3blznn2BAZY8NNSOyvadxRZlDqI2xxKtmZvi9CyewSYy4UY4iAreo2iuTA==
X-Received: by 2002:a05:6a20:5499:b0:f4:ac2d:8ea0 with SMTP id i25-20020a056a20549900b000f4ac2d8ea0mr1713541pzk.32.1684450547737;
        Thu, 18 May 2023 15:55:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l1-20020a62be01000000b006466f0be263sm1816188pff.73.2023.05.18.15.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 15:55:46 -0700 (PDT)
Message-ID: <6466acf2.620a0220.6e91c.39db@mx.google.com>
Date: Thu, 18 May 2023 15:55:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.179-cip32-rt13
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt baseline: 139 runs,
 23 regressions (v5.10.179-cip32-rt13)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 May 2023 22:55:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11526

cip/linux-5.10.y-cip-rt baseline: 139 runs, 23 regressions (v5.10.179-cip32=
-rt13)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =

acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig+preempt_rt         | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =

imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | defcon=
fig                    | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | defcon=
fig                    | 4          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.179-cip32-rt13/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.179-cip32-rt13
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1f0aef82759c2eef50bcbfaab1bad1aaa64a721c =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/6466ac8fefa3807b082e8609

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6466ac8fefa3807b082e860e
        failing since 111 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-05-18T22:53:46.838678  / # <8>[  #

    2023-05-18T22:53:46.940853  export SHELL=3D/bin/sh

    2023-05-18T22:53:46.941623    9.897026] <LAVA_SIGNAL_ENDRUN 0_dmesg 103=
80102_1.4.2.3.1>

    2023-05-18T22:53:46.942005  #

    2023-05-18T22:53:47.043253  / # export SHELL=3D/bin/sh. /lava-10380102/=
environment

    2023-05-18T22:53:47.043910  =


    2023-05-18T22:53:47.145211  / # . /lava-10380102/environment/lava-10380=
102/bin/lava-test-runner /lava-10380102/1

    2023-05-18T22:53:47.146433  =


    2023-05-18T22:53:47.152172  / # /lava-10380102/bin/lava-test-runner /la=
va-10380102/1

    2023-05-18T22:53:47.167786  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/6466ac3fc0bafeb1c12e85f7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6466ac3fc0bafeb1c12e85fc
        failing since 111 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-05-18T22:52:40.832692  + cat uuid

    2023-05-18T22:52:40.832777  + UUID=3D10379791_1.4.2.3.1

    2023-05-18T22:52:40.835828  + set +x

    2023-05-18T22:52:40.842535  + KERNELCI_<8>[    9.160332] <LAVA_SIGNAL_E=
NDRUN 0_dmesg 10379791_1.4.2.3.1>

    2023-05-18T22:52:40.845533  LAVA=3Dy /bin/sh /opt/kernelci/dmesg.sh

    2023-05-18T22:52:40.845643  + set +x

    2023-05-18T22:52:40.950800  / # #

    2023-05-18T22:52:41.051468  export SHELL=3D/bin/sh

    2023-05-18T22:52:41.051721  #

    2023-05-18T22:52:41.152316  / # export SHELL=3D/bin/sh. /lava-10379791/=
environment
 =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/6466a1eba56892d1972e868e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6466a1eba56892d1972e8693
        failing since 111 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-05-18T22:08:28.298416  + set +x

    2023-05-18T22:08:28.304504  <8>[    8.579193] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10380089_1.4.2.3.1>

    2023-05-18T22:08:28.406940  #

    2023-05-18T22:08:28.509483  / # #export SHELL=3D/bin/sh

    2023-05-18T22:08:28.510159  =


    2023-05-18T22:08:28.611463  / # export SHELL=3D/bin/sh. /lava-10380089/=
environment

    2023-05-18T22:08:28.612110  =


    2023-05-18T22:08:28.713697  / # . /lava-10380089/environment/lava-10380=
089/bin/lava-test-runner /lava-10380089/1

    2023-05-18T22:08:28.714733  =


    2023-05-18T22:08:28.720596  / # /lava-10380089/bin/lava-test-runner /la=
va-10380089/1
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64669d556ed4e06aba2e8629

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64669d566ed4e06aba2e862e
        failing since 111 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-05-18T21:49:02.741034  + set +x

    2023-05-18T21:49:02.747760  <8>[    8.921200] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10379759_1.4.2.3.1>

    2023-05-18T21:49:02.856219  / # #

    2023-05-18T21:49:02.958577  export SHELL=3D/bin/sh

    2023-05-18T21:49:02.959340  #

    2023-05-18T21:49:03.060858  / # export SHELL=3D/bin/sh. /lava-10379759/=
environment

    2023-05-18T21:49:03.061634  =


    2023-05-18T21:49:03.163186  / # . /lava-10379759/environment/lava-10379=
759/bin/lava-test-runner /lava-10379759/1

    2023-05-18T21:49:03.164547  =


    2023-05-18T21:49:03.169867  / # /lava-10379759/bin/lava-test-runner /la=
va-10379759/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6466a013763158bc492e85f9

  Results:     30 PASS, 15 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6466a013763158bc492e8626
        failing since 111 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-05-18T22:00:15.582200  + set +x
    2023-05-18T22:00:15.687908  / # <8>[   22.426744] <LAVA_S#
    2023-05-18T22:00:15.791116  export SHELL=3D/bin/sh
    2023-05-18T22:00:15.791825  IGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=
=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-05-18T22:00:15.792297  <8>[   22.428562] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 482985_1.5.2.4.1>
    2023-05-18T22:00:15.792596  #
    2023-05-18T22:00:15.894824  / # export SHELL=3D/bin/sh. /lava-482985/en=
vironment
    2023-05-18T22:00:15.895523  =

    2023-05-18T22:00:15.997690  / # . /lava-482985/environment/lava-482985/=
bin/lava-test-runner /lava-482985/1
    2023-05-18T22:00:15.998950   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6466a1d6a56892d1972e8626

  Results:     30 PASS, 15 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6466a1d6a56892d1972e8629
        failing since 111 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-05-18T22:07:36.729471  + set +x
    2023-05-18T22:07:36.764250  / # <8>[   16.696272] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-05-18T22:07:36.764937  <8>[   16.698085] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 936520_1.5.2.4.1>
    2023-05-18T22:07:36.874134  #
    2023-05-18T22:07:36.978675  export SHELL=3D/bin/sh
    2023-05-18T22:07:36.979895  #
    2023-05-18T22:07:37.082122  / # export SHELL=3D/bin/sh. /lava-936520/en=
vironment
    2023-05-18T22:07:37.083173  =

    2023-05-18T22:07:37.185493  / # . /lava-936520/environment/lava-936520/=
bin/lava-test-runner /lava-936520/1
    2023-05-18T22:07:37.187180   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64669f8aa9e45a8e262e85fb

  Results:     50 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebo=
ne-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebo=
ne-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64669f8aa9e45a8e262e862f
        failing since 57 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.175-cip29-rt12)

    2023-05-18T21:58:15.368915  + set +x
    2023-05-18T21:58:15.473242  / # <8>[   21.447281] <LAVA_S#
    2023-05-18T21:58:15.575250  export SHELL=3D/bin/sh
    2023-05-18T21:58:15.575712  IGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=
=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-05-18T21:58:15.576009  <8>[   21.449552] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 482972_1.5.2.4.1>
    2023-05-18T21:58:15.576302  #
    2023-05-18T21:58:15.677733  / # export SHELL=3D/bin/sh. /lava-482972/en=
vironment
    2023-05-18T21:58:15.678197  =

    2023-05-18T21:58:15.779968  / # . /lava-482972/environment/lava-482972/=
bin/lava-test-runner /lava-482972/1
    2023-05-18T21:58:15.781268   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64669f9291ec073ddc2e8615

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-b=
lack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-b=
lack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64669f9291ec073ddc2e8618
        failing since 57 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.175-cip29-rt12)

    2023-05-18T21:58:15.058999  / # #
    2023-05-18T21:58:15.162758  export SHELL=3D/bin/sh
    2023-05-18T21:58:15.163950  #
    2023-05-18T21:58:15.266250  / # export SHELL=3D/bin/sh. /lava-936510/en=
vironment
    2023-05-18T21:58:15.267321  =

    2023-05-18T21:58:15.369658  / # . /lava-936510/environment/lava-936510/=
bin/lava-test-runner /lava-936510/1
    2023-05-18T21:58:15.371333  =

    2023-05-18T21:58:15.380758  / # /lava-936510/bin/lava-test-runner /lava=
-936510/1
    2023-05-18T21:58:15.509684  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-18T21:58:15.510260  + cd /lava-936510/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6466a27e319e37421d2e85fc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6466a27e319e37421d2e85ff
        failing since 57 days (last pass: v5.10.153-cip19-rt8, first fail: =
v5.10.175-cip29-rt12)

    2023-05-18T22:08:06.087703  + set +x
    2023-05-18T22:08:06.191361  / # [   21.511858] <LAVA_SIGNAL_E#
    2023-05-18T22:08:06.293387  export SHELL=3D/bin/sh
    2023-05-18T22:08:06.293817  NDRUN 0_dmesg 1224774_1.5.2.4.1>
    2023-05-18T22:08:06.294013  #
    2023-05-18T22:08:06.395204  / # export SHELL=3D/bin/sh. /lava-1224774/e=
nvironment
    2023-05-18T22:08:06.395681  =

    2023-05-18T22:08:06.497061  / # . /lava-1224774/environment/lava-122477=
4/bin/lava-test-runner /lava-1224774/1
    2023-05-18T22:08:06.497829  =

    2023-05-18T22:08:06.499721  / # /lava-1224774/bin/lava-test-runner /lav=
a-1224774/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/6466a14b8db7a826072e85e8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm64/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-fsl-ls108=
8a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm64/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-fsl-ls108=
8a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6466a14b8db7a826072e85eb
        failing since 111 days (last pass: v5.10.153-cip19-rt8, first fail:=
 v5.10.162-cip24-rt10)

    2023-05-18T22:04:39.744144  XIT>
    2023-05-18T22:05:40.364698  / # #
    2023-05-18T22:05:40.466364  export SHELL=3D/bin/sh
    2023-05-18T22:05:40.466830  #
    2023-05-18T22:05:40.568188  / # export SHELL=3D/bin/sh. /lava-1224771/e=
nvironment
    2023-05-18T22:05:40.568670  =

    2023-05-18T22:05:40.670070  / # . /lava-1224771/environment/lava-122477=
1/bin/lava-test-runner /lava-1224771/0
    2023-05-18T22:05:40.670828  =

    2023-05-18T22:05:40.672705  / # /lava-1224771/bin/lava-test-runner /lav=
a-1224771/0
    2023-05-18T22:05:40.687884  mv: can't rename '/lava-1224771/0/lava-test=
-runner.conf': No such file or directory =

    ... (23 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6466a2835a823529502e85fe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6466a2835a823529502e8601
        failing since 111 days (last pass: v5.10.153-cip19-rt8, first fail:=
 v5.10.162-cip24-rt10)

    2023-05-18T22:08:35.373045  [   15.403146] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1224775_1.5.2.4.1>
    2023-05-18T22:08:35.480059  / # #
    2023-05-18T22:08:35.581944  export SHELL=3D/bin/sh
    2023-05-18T22:08:35.582414  #
    2023-05-18T22:08:35.683827  / # export SHELL=3D/bin/sh. /lava-1224775/e=
nvironment
    2023-05-18T22:08:35.684302  =

    2023-05-18T22:08:35.785720  / # . /lava-1224775/environment/lava-122477=
5/bin/lava-test-runner /lava-1224775/1
    2023-05-18T22:08:35.786500  =

    2023-05-18T22:08:35.788500  / # /lava-1224775/bin/lava-test-runner /lav=
a-1224775/1
    2023-05-18T22:08:35.806345  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | defcon=
fig+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/6466ab6301e9cfc0ce2e861e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6466ab6301e9cfc0ce2e8623
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-05-18T22:48:49.591711  <#

    2023-05-18T22:48:49.592025  8>[    8.967013] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 10380119_1.4.2.3.1>

    2023-05-18T22:48:49.692652  / # #export SHELL=3D/bin/sh

    2023-05-18T22:48:49.692858  =


    2023-05-18T22:48:49.793407  / # export SHELL=3D/bin/sh. /lava-10380119/=
environment

    2023-05-18T22:48:49.793655  =


    2023-05-18T22:48:49.894250  / # . /lava-10380119/environment/lava-10380=
119/bin/lava-test-runner /lava-10380119/1

    2023-05-18T22:48:49.894600  =


    2023-05-18T22:48:49.899574  / # /lava-10380119/bin/lava-test-runner /la=
va-10380119/1

    2023-05-18T22:48:49.915879  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/6466a90ac480d41f332e8620

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6466a90ac480d41f332e8625
        new failure (last pass: v5.10.175-cip29-rt12)

    2023-05-18T22:38:52.716144  + set +x

    2023-05-18T22:38:52.722383  <8>[   11.556677] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10379788_1.4.2.3.1>

    2023-05-18T22:38:52.829204  /#

    2023-05-18T22:38:52.930154   # #export SHELL=3D/bin/sh

    2023-05-18T22:38:52.930449  =


    2023-05-18T22:38:53.031227  / # export SHELL=3D/bin/sh. /lava-10379788/=
environment

    2023-05-18T22:38:53.031943  =


    2023-05-18T22:38:53.133286  / # . /lava-10379788/environment/lava-10379=
788/bin/lava-test-runner /lava-10379788/1

    2023-05-18T22:38:53.134428  =


    2023-05-18T22:38:53.139174  / # /lava-10379788/bin/lava-test-runner /la=
va-10379788/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64669fdc482fd49d842e863a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64669fdc482fd49d842e863f
        failing since 111 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-05-18T21:59:48.601941  / # #

    2023-05-18T21:59:48.704329  export SHELL=3D/bin/sh

    2023-05-18T21:59:48.705077  #

    2023-05-18T21:59:48.806909  / # export SHELL=3D/bin/sh. /lava-10379959/=
environment

    2023-05-18T21:59:48.807664  =


    2023-05-18T21:59:48.909251  / # . /lava-10379959/environment/lava-10379=
959/bin/lava-test-runner /lava-10379959/1

    2023-05-18T21:59:48.910503  =


    2023-05-18T21:59:48.925777  / # /lava-10379959/bin/lava-test-runner /la=
va-10379959/1

    2023-05-18T21:59:49.035550  + export 'TESTRUN_ID=3D1_bootrr'

    2023-05-18T21:59:49.036068  + cd /lava-10379959/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64669fb07fb04c51162e85eb

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboa=
rd-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandboa=
rd-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64669fb07fb04c51162e85f0
        failing since 111 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-05-18T21:59:03.463454  + set +x
    2023-05-18T21:59:03.575746  / # [    7.029863] <LAVA_SIGNAL_TESTCASE TE=
ST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dl#
    2023-05-18T21:59:03.677301  export SHELL=3D/bin/sh
    2023-05-18T21:59:03.677735  ines MEASUREMENT=3D0>
    2023-05-18T21:59:03.677860  [    7.031167] <LAVA_SIGNAL_ENDRUN 0_dmesg =
954220_1.5.2.3.1>
    2023-05-18T21:59:03.677965  #
    2023-05-18T21:59:03.779302  / # export SHELL=3D/bin/sh. /lava-954220/en=
vironment
    2023-05-18T21:59:03.779742  =

    2023-05-18T21:59:03.881003  / # . /lava-954220/environment/lava-954220/=
bin/lava-test-runner /lava-954220/1
    2023-05-18T21:59:03.881622   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6466a1ba83c3d279ef2e8637

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6466a1ba83c3d279ef2e863c
        failing since 111 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-05-18T22:07:43.383423  + set +x
    2023-05-18T22:07:43.497949  / # [    8.915728] <LAVA_SIGNAL_TESTCASE TE=
ST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dl#
    2023-05-18T22:07:43.599775  export SHELL=3D/bin/sh
    2023-05-18T22:07:43.600271  ines MEASUREMENT=3D0>
    2023-05-18T22:07:43.600413  [    8.918231] <LAVA_SIGNAL_ENDRUN 0_dmesg =
954229_1.5.2.3.1>
    2023-05-18T22:07:43.600532  #
    2023-05-18T22:07:43.701902  / # export SHELL=3D/bin/sh. /lava-954229/en=
vironment
    2023-05-18T22:07:43.702399  =

    2023-05-18T22:07:43.803728  / # . /lava-954229/environment/lava-954229/=
bin/lava-test-runner /lava-954229/1
    2023-05-18T22:07:43.804371   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6466a3a4e8f63b0f162e85ec

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6466a3a4e8f63b0f162e85ef
        failing since 111 days (last pass: v5.10.153-cip19-rt8, first fail:=
 v5.10.162-cip24-rt10)

    2023-05-18T22:13:42.319612  / # <8>[   17.269100] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 12247#
    2023-05-18T22:13:43.479837  export SHELL=3D/bin/sh
    2023-05-18T22:13:43.485315  64_1.5.2.4.1>
    2023-05-18T22:13:43.485532  #
    2023-05-18T22:13:45.032738  / # export SHELL=3D/bin/sh. /lava-1224764/e=
nvironment
    2023-05-18T22:13:45.038204  =

    2023-05-18T22:13:47.858010  / # . /lava-1224764/environment/lava-122476=
4/bin/lava-test-runner /lava-1224764/1
    2023-05-18T22:13:47.864417  =

    2023-05-18T22:13:47.875540  / # /lava-1224764/bin/lava-test-runner /lav=
a-1224764/1
    2023-05-18T22:13:47.955482  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6466aa54736e56c9962e862a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6466aa54736e56c9962e862d
        failing since 57 days (last pass: v5.10.153-cip19-rt8, first fail: =
v5.10.175-cip29-rt12)

    2023-05-18T22:42:11.720271  <8>[   29.055114] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1224763_1.5.2.4.1>
    2023-05-18T22:42:11.828578  / # #
    2023-05-18T22:42:12.988605  export SHELL=3D/bin/sh
    2023-05-18T22:42:12.994280  #
    2023-05-18T22:42:12.994598  / # export SHELL=3D/bin/sh
    2023-05-18T22:42:14.542123  / # . /lava-1224763/environment
    2023-05-18T22:42:17.369908  /lava-1224763/bin/lava-test-runner /lava-12=
24763/1
    2023-05-18T22:42:17.375513  . /lava-1224763/environment
    2023-05-18T22:42:17.375623  / # /lava-1224763/bin/lava-test-runner /lav=
a-1224763/1
    2023-05-18T22:42:17.465382  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64669f082b4d1aa90a2e861e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20=
d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20=
d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64669f082b4d1aa90a2e8=
61f
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | defcon=
fig                    | 4          =


  Details:     https://kernelci.org/test/plan/id/64669fc3c96ee4ba5e2e8609

  Results:     61 PASS, 7 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-ja=
q.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
179-cip32-rt13/arm/defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-ja=
q.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/64669fc3c96ee4ba5e2e8637
        failing since 111 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-05-18T21:59:22.153743  FIRST,<8>[   18.398452] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-05-18T21:59:22.155784   INC default to 1.

    2023-05-18T21:59:22.155844  =


    2023-05-18T21:59:22.159276  	-w	Pad to last with leading zeros
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64669fc3c96ee4ba5e2e8638
        failing since 111 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-05-18T21:59:22.137617  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   18.385791] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-05-18T21:59:22.138052  ST

    2023-05-18T21:59:22.138109  =


    2023-05-18T21:59:22.143292  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64669fc3c96ee4ba5e2e8639
        failing since 111 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-05-18T21:59:22.123568   multi-call binary.

    2023-05-18T21:59:22.123628  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64669fc3c96ee4ba5e2e864d
        failing since 111 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-05-18T21:59:10.173832  <8>[    6.437228] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dalert RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-05-18T21:59:10.174855  + set +x

    2023-05-18T21:59:10.278542  #

    2023-05-18T21:59:10.278828  =


    2023-05-18T21:59:10.278893  / # <8>[    6.445790] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-05-18T21:59:10.278953  <8>[    6.447439] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10379965_1.5.2.3.1>

    2023-05-18T21:59:10.379526  #export SHELL=3D/bin/sh

    2023-05-18T21:59:10.379705  =


    2023-05-18T21:59:10.480218  / # export SHELL=3D/bin/sh. /lava-10379965/=
environment

    2023-05-18T21:59:10.480385  =

 =

    ... (22 line(s) more)  =

 =20

