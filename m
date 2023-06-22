Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6202DEB64D8
	for <webhook@archiver.kernel.org>; Thu, 22 Jun 2023 11:15:16 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.8761.1687432516007156964
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 22 Jun 2023 04:15:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=sCYsRdit;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1b52bf6e659so34552895ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 22 Jun 2023 04:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687432515; x=1690024515;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WBzufd2RWWjjfQjU5A/FABjtoRmHrVeDi13DtBIgKns=;
        b=sCYsRditUJlQrm7tnRjlTAJ69LoIvtAiO3I+Z5+TMTg+x4K8jPzVQMg8ByfJyOmSRX
         RAE5MzQc6nqSYweD/jC+unq2RRoo+tbuTM+bYw9f/0K+hlKjcA/z7J35sFfaN+tc1cAt
         0P2awkfeSf/VNoGNU+7sHcQ1rcM8kW+dVOB8svDKaH9eLZk183nLH3DZDQ3WffAC87Hc
         KcMqddgHwtmv7M9BMXmIyavUT9o1MSYUbWSJWXwYdaDyRQGXc96R5oExWubOoiQNj6sx
         RJn523O/1exwfY2Ed9zwAnGbE7nnwc06BltLA0CFGsSOoN2S9qsrTX2T0cTPihkIDfDy
         VQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687432515; x=1690024515;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBzufd2RWWjjfQjU5A/FABjtoRmHrVeDi13DtBIgKns=;
        b=OkrnA6zgJ/8yEK/DaiYYIt3jS6fYfWlvChHMTHmjrrE0ALiM26iP+hlq0DGc+cAlBG
         wBRPR0eVN7Nw2+SH5N5GQ3XEFtPWzlHXwKxV3BXAEbYdRdJxda66FhdtyuDwRjvw0xPO
         3G3e5sCAmGlz5maJvqjlh+AQ8Kxdp8AB1HtsnX32jbSI68XC4u+fp4jQIX1ERg2mtUbo
         Z9hJ710FOQE2OV0XcjF9Ciu/4bThoHDgyKg/MA6DQG+lq7CAvEGfZMc88+Nwttav4mpr
         ebDpFOa2Su3myoM4dFSQBRwMi09OLKan5oNOc7PTR2XKS0xufRdWBq49sOiHMetT/P2X
         cIgQ==
X-Gm-Message-State: AC+VfDzNThjx0QwcYNIc0iTSlN5bX6Gj+SQRu/hPIJNBO+lKLyxZyWQG
	paXH3yB6GKV28O3X5hTsuRwqO9XkZEuwbYnR0H/b8Q==
X-Google-Smtp-Source: ACHHUZ6DeFgYl1v5/8/oZZcl807piyb61VnXuKef/JutKCVHiO+h7066SIbT1ZAreGd58gwmRVJrUw==
X-Received: by 2002:a17:902:ed41:b0:1b3:d6c8:7008 with SMTP id y1-20020a170902ed4100b001b3d6c87008mr11865456plb.57.1687432514038;
        Thu, 22 Jun 2023 04:15:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709028a8900b001afa7040a70sm5078329plo.276.2023.06.22.04.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 04:15:13 -0700 (PDT)
Message-ID: <64942d41.170a0220.29260.bf82@mx.google.com>
Date: Thu, 22 Jun 2023 04:15:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.184-cip36-rt14
Subject: cip/linux-5.10.y-cip-rt baseline: 150 runs,
 21 regressions (v5.10.184-cip36-rt14)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jun 2023 11:15:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12119

cip/linux-5.10.y-cip-rt baseline: 150 runs, 21 regressions (v5.10.184-cip36=
-rt14)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 4          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.184-cip36-rt14/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.184-cip36-rt14
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1b650b4c826dc15118c34e6c891e42858f3367e0 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/64942245f6ef2fcbcf306133

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64942245f6ef2fcbcf30613c
        failing since 146 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-06-22T10:28:07.606096  + set +x

    2023-06-22T10:28:07.612797  <8>[    9.523998] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10859001_1.4.2.3.1>

    2023-06-22T10:28:07.714562  / ##

    2023-06-22T10:28:07.815246  export SHELL=3D/bin/sh

    2023-06-22T10:28:07.815453   #

    2023-06-22T10:28:07.915949  / # export SHELL=3D/bin/sh. /lava-10859001/=
environment

    2023-06-22T10:28:07.916152  =


    2023-06-22T10:28:08.016704  / # . /lava-10859001/environment/lava-10859=
001/bin/lava-test-runner /lava-10859001/1

    2023-06-22T10:28:08.017005  =


    2023-06-22T10:28:08.021798  / # /lava-10859001/bin/lava-test-runner /la=
va-10859001/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/6494214bb18e0dd36130613f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6494214bb18e0dd361306148
        failing since 146 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-06-22T10:23:51.126479  + set +x

    2023-06-22T10:23:51.133291  <8>[    8.039262] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10858910_1.4.2.3.1>

    2023-06-22T10:23:51.235162  #

    2023-06-22T10:23:51.235478  =


    2023-06-22T10:23:51.336058  / # #export SHELL=3D/bin/sh

    2023-06-22T10:23:51.336268  =


    2023-06-22T10:23:51.436788  / # export SHELL=3D/bin/sh. /lava-10858910/=
environment

    2023-06-22T10:23:51.436988  =


    2023-06-22T10:23:51.537510  / # . /lava-10858910/environment/lava-10858=
910/bin/lava-test-runner /lava-10858910/1

    2023-06-22T10:23:51.537801  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/64942259af4ddd18a530614f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64942259af4ddd18a5306158
        failing since 146 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-06-22T10:28:30.326363  + set +x

    2023-06-22T10:28:30.332475  <8>[    9.571258] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10858986_1.4.2.3.1>

    2023-06-22T10:28:30.436921  / # #

    2023-06-22T10:28:30.537568  export SHELL=3D/bin/sh

    2023-06-22T10:28:30.537760  #

    2023-06-22T10:28:30.638245  / # export SHELL=3D/bin/sh. /lava-10858986/=
environment

    2023-06-22T10:28:30.638470  =


    2023-06-22T10:28:30.739038  / # . /lava-10858986/environment/lava-10858=
986/bin/lava-test-runner /lava-10858986/1

    2023-06-22T10:28:30.739388  =


    2023-06-22T10:28:30.744285  / # /lava-10858986/bin/lava-test-runner /la=
va-10858986/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64942187947f83664d306130

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64942187947f83664d306139
        failing since 146 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-06-22T10:25:08.967471  + set +x

    2023-06-22T10:25:08.973892  <8>[    8.680541] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10858915_1.4.2.3.1>

    2023-06-22T10:25:09.078099  / # #

    2023-06-22T10:25:09.178721  export SHELL=3D/bin/sh

    2023-06-22T10:25:09.178936  #

    2023-06-22T10:25:09.279492  / # export SHELL=3D/bin/sh. /lava-10858915/=
environment

    2023-06-22T10:25:09.279719  =


    2023-06-22T10:25:09.380238  / # . /lava-10858915/environment/lava-10858=
915/bin/lava-test-runner /lava-10858915/1

    2023-06-22T10:25:09.380572  =


    2023-06-22T10:25:09.385326  / # /lava-10858915/bin/lava-test-runner /la=
va-10858915/1
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64941f626de557ff5630612e

  Results:     45 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g=
20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g=
20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64941f626de557ff5630615f
        failing since 146 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-06-22T10:14:55.371080  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 651461_1.5.2=
.4.1>
    2023-06-22T10:14:55.482919  / # #
    2023-06-22T10:14:55.585796  export SHELL=3D/bin/sh
    2023-06-22T10:14:55.586555  #
    2023-06-22T10:14:55.688479  / # export SHELL=3D/bin/sh. /lava-651461/en=
vironment
    2023-06-22T10:14:55.689227  =

    2023-06-22T10:14:55.791172  / # . /lava-651461/environment/lava-651461/=
bin/lava-test-runner /lava-651461/1
    2023-06-22T10:14:55.792446  =

    2023-06-22T10:14:55.798944  / # /lava-651461/bin/lava-test-runner /lava=
-651461/1
    2023-06-22T10:14:55.964426  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649421b015ce1cc26c30613d

  Results:     31 PASS, 14 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649421b015ce1cc26c30616d
        failing since 146 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-06-22T10:25:18.761635  / # #
    2023-06-22T10:25:18.864928  export SHELL=3D/bin/sh
    2023-06-22T10:25:18.865847  <8>[   18.572922] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 651546_1.5.2.4.1>
    2023-06-22T10:25:18.866284  #
    2023-06-22T10:25:18.968404  / # export SHELL=3D/bin/sh. /lava-651546/en=
vironment
    2023-06-22T10:25:18.969370  =

    2023-06-22T10:25:19.071473  / # . /lava-651546/environment/lava-651546/=
bin/lava-test-runner /lava-651546/1
    2023-06-22T10:25:19.072944  =

    2023-06-22T10:25:19.076370  / # /lava-651546/bin/lava-test-runner /lava=
-651546/1
    2023-06-22T10:25:19.169833  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/649423921d113ed42b30613e

  Results:     30 PASS, 15 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649423921d113ed42b306144
        failing since 146 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-06-22T10:33:09.055749  + set +x
    2023-06-22T10:33:09.056794  / # <8>[   16.703994] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-06-22T10:33:09.057258  <8>[   16.705797] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 971130_1.5.2.4.1>
    2023-06-22T10:33:09.161039  #
    2023-06-22T10:33:09.264925  export SHELL=3D/bin/sh
    2023-06-22T10:33:09.265916  #
    2023-06-22T10:33:09.368091  / # export SHELL=3D/bin/sh. /lava-971130/en=
vironment
    2023-06-22T10:33:09.369049  =

    2023-06-22T10:33:09.471387  / # . /lava-971130/environment/lava-971130/=
bin/lava-test-runner /lava-971130/1
    2023-06-22T10:33:09.472938   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6494232135312b1b11306241

  Results:     30 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebon=
e-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebon=
e-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6494232135312b1b11306271
        failing since 146 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-06-22T10:31:29.607689  + set +x
    2023-06-22T10:31:29.712548  / # <8>[   23.694934] <LAVA_S#
    2023-06-22T10:31:29.814965  export SHELL=3D/bin/sh
    2023-06-22T10:31:29.815555  IGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=
=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-06-22T10:31:29.815780  <8>[   23.696713] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 651674_1.5.2.4.1>
    2023-06-22T10:31:29.816122  #
    2023-06-22T10:31:29.918541  / # export SHELL=3D/bin/sh. /lava-651674/en=
vironment
    2023-06-22T10:31:29.919242  =

    2023-06-22T10:31:30.021428  / # . /lava-651674/environment/lava-651674/=
bin/lava-test-runner /lava-651674/1
    2023-06-22T10:31:30.022377   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6494287e542f91afcd306142

  Results:     30 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-bl=
ack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6494287e542f91afcd306148
        failing since 146 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-06-22T10:54:09.046364  + set +x
    2023-06-22T10:54:09.047290  / # <8>[   16.685131] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-06-22T10:54:09.047613  <8>[   16.686940] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 971157_1.5.2.4.1>
    2023-06-22T10:54:09.153392  #
    2023-06-22T10:54:09.256779  export SHELL=3D/bin/sh
    2023-06-22T10:54:09.257874  #
    2023-06-22T10:54:09.360238  / # export SHELL=3D/bin/sh. /lava-971157/en=
vironment
    2023-06-22T10:54:09.361249  =

    2023-06-22T10:54:09.463555  / # . /lava-971157/environment/lava-971157/=
bin/lava-test-runner /lava-971157/1
    2023-06-22T10:54:09.465081   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6494219fe089a349a2306180

  Results:     50 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebo=
ne-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebo=
ne-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6494219fe089a349a23061b9
        failing since 91 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.175-cip29-rt12)

    2023-06-22T10:25:11.801980  + set +x
    2023-06-22T10:25:11.906855  / # <8>[   19.828147] <LAVA_S#
    2023-06-22T10:25:12.009450  export SHELL=3D/bin/sh
    2023-06-22T10:25:12.010090  IGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=
=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-06-22T10:25:12.010545  <8>[   19.830434] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 651535_1.5.2.4.1>
    2023-06-22T10:25:12.010751  #
    2023-06-22T10:25:12.112256  / # export SHELL=3D/bin/sh. /lava-651535/en=
vironment
    2023-06-22T10:25:12.112830  =

    2023-06-22T10:25:12.214981  / # . /lava-651535/environment/lava-651535/=
bin/lava-test-runner /lava-651535/1
    2023-06-22T10:25:12.216308   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64942206b09af8bd7830619f

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-b=
lack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-b=
lack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64942206b09af8bd783061a6
        failing since 91 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.175-cip29-rt12)

    2023-06-22T10:27:05.262564  <8>[   14.104805] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 971124_1.5.2.4.1>
    2023-06-22T10:27:05.369684  / # #
    2023-06-22T10:27:05.471602  export SHELL=3D/bin/sh
    2023-06-22T10:27:05.472050  #
    2023-06-22T10:27:05.573474  / # export SHELL=3D/bin/sh. /lava-971124/en=
vironment
    2023-06-22T10:27:05.573934  =

    2023-06-22T10:27:05.675395  / # . /lava-971124/environment/lava-971124/=
bin/lava-test-runner /lava-971124/1
    2023-06-22T10:27:05.676150  =

    2023-06-22T10:27:05.678251  / # /lava-971124/bin/lava-test-runner /lava=
-971124/1
    2023-06-22T10:27:05.788477  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/6494228bfd389423f230615a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6494228bfd389423f2306163
        failing since 34 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v5.10.179-cip32-rt13)

    2023-06-22T10:29:29.242196  <8>[    8.884306] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10859024_1.4.2.3.1>

    2023-06-22T10:29:29.344347  / ##

    2023-06-22T10:29:29.445091  export SHELL=3D/bin/sh

    2023-06-22T10:29:29.445278   #

    2023-06-22T10:29:29.545831  / # export SHELL=3D/bin/sh. /lava-10859024/=
environment

    2023-06-22T10:29:29.546090  =


    2023-06-22T10:29:29.646638  / # . /lava-10859024/environment/lava-10859=
024/bin/lava-test-runner /lava-10859024/1

    2023-06-22T10:29:29.646913  =


    2023-06-22T10:29:29.651861  / # /lava-10859024/bin/lava-test-runner /la=
va-10859024/1

    2023-06-22T10:29:29.667697  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64942145db3bd9840430612f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64942145db3bd98404306138
        failing since 34 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v5.10.179-cip32-rt13)

    2023-06-22T10:23:59.638844  =


    2023-06-22T10:23:59.638941  <8>[   11.480262] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10858911_1.4.2.3.1>

    2023-06-22T10:23:59.739540  / # #export SHELL=3D/bin/sh

    2023-06-22T10:23:59.739831  =


    2023-06-22T10:23:59.840389  / # export SHELL=3D/bin/sh. /lava-10858911/=
environment

    2023-06-22T10:23:59.840590  =


    2023-06-22T10:23:59.941171  / # . /lava-10858911/environment/lava-10858=
911/bin/lava-test-runner /lava-10858911/1

    2023-06-22T10:23:59.941576  =


    2023-06-22T10:23:59.946126  / # /lava-10858911/bin/lava-test-runner /la=
va-10858911/1

    2023-06-22T10:23:59.966031  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64942156b2d2d36d17306152

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64942156b2d2d36d1730615b
        failing since 146 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-06-22T10:24:14.921562  / # #

    2023-06-22T10:24:15.024173  export SHELL=3D/bin/sh

    2023-06-22T10:24:15.024949  #

    2023-06-22T10:24:15.126783  / # export SHELL=3D/bin/sh. /lava-10858922/=
environment

    2023-06-22T10:24:15.127528  =


    2023-06-22T10:24:15.229467  / # . /lava-10858922/environment/lava-10858=
922/bin/lava-test-runner /lava-10858922/1

    2023-06-22T10:24:15.230632  =


    2023-06-22T10:24:15.244878  / # /lava-10858922/bin/lava-test-runner /la=
va-10858922/1

    2023-06-22T10:24:15.356842  + export 'TESTRUN_ID=3D1_bootrr'

    2023-06-22T10:24:15.357387  + cd /lava-10858922/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/649423085e1e558071306130

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-s=
abrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-s=
abrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649423085e1e558071306139
        failing since 146 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-06-22T10:31:32.544310  / # #

    2023-06-22T10:31:32.646858  export SHELL=3D/bin/sh

    2023-06-22T10:31:32.647598  #

    2023-06-22T10:31:32.749493  / # export SHELL=3D/bin/sh. /lava-10859046/=
environment

    2023-06-22T10:31:32.750237  =


    2023-06-22T10:31:32.852083  / # . /lava-10859046/environment/lava-10859=
046/bin/lava-test-runner /lava-10859046/1

    2023-06-22T10:31:32.853311  =


    2023-06-22T10:31:32.868528  / # /lava-10859046/bin/lava-test-runner /la=
va-10859046/1

    2023-06-22T10:31:32.916586  + export 'TESTRUN_ID=3D1_bootrr'

    2023-06-22T10:31:32.966506  + cd /lava-10859046/1/tests/1_bootrr
 =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64941f56d6fac1f8d0306147

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20=
d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20=
d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64941f56d6fac1f8d0306=
148
        failing since 34 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v5.10.179-cip32-rt13) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/6494230535312b1b11306136

  Results:     59 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-=
veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-=
veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/6494230535312b1b11306164
        failing since 146 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-06-22T10:32:02.138876  BusyBox v1.31.1 (2023-06-<8>[   21.204435] =
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RES=
ULT=3Dfail>

    2023-06-22T10:32:02.142345  09 10:32:04 UTC) multi-call binary.

    2023-06-22T10:32:02.142565  =


    2023-06-22T10:32:02.146846  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-06-22T10:32:02.147062  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6494230535312b1b11306165
        failing since 146 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-06-22T10:32:02.122714  /<8>[   21.198340] <LAVA_SIGNAL_TESTCASE TE=
ST_CASE_ID=3Ddwhdmi-rockchip-driver-audio-present RESULT=3Dfail>

    2023-06-22T10:32:02.126378  lava-10859047/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6494230535312b1b11306166
        failing since 146 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-06-22T10:32:02.091833  BusyBox v1.31.1 (2023-06-09 10:32:04 UTC)<8=
>[   21.170258] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed=
 RESULT=3Dpass>

    2023-06-22T10:32:02.093807   multi-call binary.

    2023-06-22T10:32:02.094051  =


    2023-06-22T10:32:02.098277  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-06-22T10:32:02.098665  =


    2023-06-22T10:32:02.103746  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-06-22T10:32:02.106057  FIRST, INC default to 1.

    2023-06-22T10:32:02.106444  =


    2023-06-22T10:32:02.109845  	-w	Pad to last with leading zeros

    2023-06-22T10:32:02.112379  	-s SEP	String separator
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6494230535312b1b1130617a
        failing since 146 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-06-22T10:31:49.515059  / # =


    2023-06-22T10:31:49.515306  <6>[    8.016094] dwmmc_rockchip ff0d0000.m=
mc: Version ID is 270a

    2023-06-22T10:31:49.515359  <6>[    8.016108] dwmmc_rockchip ff0d0000.m=
mc: DW MMC controller at irq 39,32 bit host data width,256 deep fifo

    2023-06-22T10:31:49.515406  <6>[    8.016287] dwmmc_rockchip ff0c0000.m=
mc: Using internal DMA controller.

    2023-06-22T10:31:49.515451  <6>[    8.016293] dwmmc_rockchip ff0c0000.m=
mc: Version ID is 270a

    2023-06-22T10:31:49.515495  <6>[    8.016301] dwmmc_rockchip ff0c0000.m=
mc: DW MMC controller at irq 38,32 bit host data width,256 deep fifo

    2023-06-22T10:31:49.557571  <6>[    8.020060] tpm_i2c_infineon 1-0020: =
1.2 TPM (device-id 0x1A)

    2023-06-22T10:31:49.557646  =


    2023-06-22T10:31:49.658712  / # #

    2023-06-22T10:31:49.658896  <3>[    8.029619] reg-fixed-voltage vcc18-l=
cd: Failed to register regulator: -517
 =

    ... (105 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/64942368dd9196c15130614e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-sun50=
i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-sun50=
i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64942368dd9196c151306=
14f
        new failure (last pass: v5.10.175-cip29-rt12) =

 =20

