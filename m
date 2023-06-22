Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D4CEB64DA
	for <webhook@archiver.kernel.org>; Thu, 22 Jun 2023 11:15:16 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web11.8687.1687432515257120926
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 22 Jun 2023 04:15:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=PXjfPhck;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-666eef03ebdso3110767b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 22 Jun 2023 04:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687432514; x=1690024514;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F/LJKDvEafPNP2sQNoNuadhLj57P10a+aei6TVvo2O0=;
        b=PXjfPhckOHNRV5DkJMrqD2pRWuLERSFYVVaMrM1BsaOPlqmWjbShM+Xh1yVJShmj55
         nFnG/oBZ73cIFndQ6FTgBDJh6GZLK7F6e8AOWdJ03DFhXCvBvdX2q1CCskBkckOmHYuH
         oELMDbWnORcljrZMDy2fvHQOZFPjMUVxE1oOYOJ8CHXVm10XV3xOiM1BG+HQyL+/K0YR
         eQ9kBL1qZfpt/DmZzsbKdfiDSELRtX1ki413f16ZurTXl2dx1GnWVHTseG2XOKmXooXd
         eGXfcA7LOHXItpuhYC4MCC3j7yDjCL13feh3FQfjLKh5uhkOiAFO+oEjSTMQ8piTYzXb
         8s9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687432514; x=1690024514;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/LJKDvEafPNP2sQNoNuadhLj57P10a+aei6TVvo2O0=;
        b=iUGDP24qrbL6VKaTtSAH1/+EelxpytWdLWihq8sBAeGzu44hh3xefpfCm/qrxss2Ui
         XrpekwuCurSzD997If4C6FG3/zN/gGfRIbKnCgUAxMaYzEANqgWIS9fOxR8T0v1fxDWp
         yEmisSU/BQt3Gyq7LQ5V2bDSk4by8LPE4qKL617BiHQkSV6oTZRmsd0BwlWZWgmxqZWI
         G/8IhkWN7yH0JxWzh7+RmbxFj2qVyr2RddBrlaVfvQAHPcOKGbrS7Nsh9CkD+/zdHDiY
         j6fr1UZFtOfzG3SDSYlIctNU4F35yhkR3ZbPf/Ii/ZywZmWjo77VkkQGpdjvasuzBmOH
         LNXA==
X-Gm-Message-State: AC+VfDwAeQCyI/iDBtBG2YSRtrbInDjSsgiF2FFjs569hqqMFOUWZIjJ
	OOP0+N/L7b5UxUqEVTA67wiHMumcWQE/G9bZWjBTjA==
X-Google-Smtp-Source: ACHHUZ4aKtj+W1wChOYvq1deWMLAj3xX6lm0dZdR+G41Nvht/rOcicvwRaLwGZK/krKSsMaDRslJRg==
X-Received: by 2002:a05:6a00:1351:b0:66a:5c68:8a03 with SMTP id k17-20020a056a00135100b0066a5c688a03mr1167822pfu.12.1687432513420;
        Thu, 22 Jun 2023 04:15:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j26-20020aa7801a000000b0065980654baasm4364794pfi.130.2023.06.22.04.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 04:15:12 -0700 (PDT)
Message-ID: <64942d40.a70a0220.8587a.9a6a@mx.google.com>
Date: Thu, 22 Jun 2023 04:15:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.184-cip36-rt14
Subject: cip/linux-5.10.y-cip-rt baseline-nfs: 63 runs,
 15 regressions (v5.10.184-cip36-rt14)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jun 2023 11:15:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12118

cip/linux-5.10.y-cip-rt baseline-nfs: 63 runs, 15 regressions (v5.10.184-ci=
p36-rt14)

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

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+preempt_rt         | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.184-cip36-rt14/plan/baseline-nfs/

  Test:     baseline-nfs
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


  Details:     https://kernelci.org/test/plan/id/649422655c4cb17693306178

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/649422655c4cb17693306181
        failing since 146 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-06-22T10:28:29.833315  <8>[   16.577073] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10859026_1.5.2.3.1>

    2023-06-22T10:28:29.934912  / #

    2023-06-22T10:28:30.035696  # #export SHELL=3D/bin/sh

    2023-06-22T10:28:30.035895  =


    2023-06-22T10:28:30.136413  / # export SHELL=3D/bin/sh. /lava-10859026/=
environment

    2023-06-22T10:28:30.136658  =


    2023-06-22T10:28:30.237182  / # . /lava-10859026/environment/lava-10859=
026/bin/lava-test-runner /lava-10859026/1

    2023-06-22T10:28:30.237505  =


    2023-06-22T10:28:30.242483  / # /lava-10859026/bin/lava-test-runner /la=
va-10859026/1

    2023-06-22T10:28:30.305317  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/6494214bd1f93512e530613c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6494214bd1f93512e5306145
        failing since 146 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-06-22T10:24:02.178929  <8>[   14.711317] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10858887_1.5.2.3.1>

    2023-06-22T10:24:02.280584  / ##

    2023-06-22T10:24:02.381310  export SHELL=3D/bin/sh

    2023-06-22T10:24:02.381571   #

    2023-06-22T10:24:02.482139  / # export SHELL=3D/bin/sh. /lava-10858887/=
environment

    2023-06-22T10:24:02.482353  =


    2023-06-22T10:24:02.582904  / # . /lava-10858887/environment/lava-10858=
887/bin/lava-test-runner /lava-10858887/1

    2023-06-22T10:24:02.583285  =


    2023-06-22T10:24:02.589077  / # /lava-10858887/bin/lava-test-runner /la=
va-10858887/1

    2023-06-22T10:24:02.711351  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/64942279ed948c44693061fa

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64942279ed948c4469306203
        failing since 146 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-06-22T10:28:48.999585  <8>[   15.990674] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-06-22T10:28:49.000180  + set +x

    2023-06-22T10:28:49.006787  <8>[   16.000789] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10859009_1.5.2.3.1>

    2023-06-22T10:28:49.115684  #

    2023-06-22T10:28:49.216528  / # #export SHELL=3D/bin/sh

    2023-06-22T10:28:49.216745  =


    2023-06-22T10:28:49.317261  / # export SHELL=3D/bin/sh. /lava-10859009/=
environment

    2023-06-22T10:28:49.317466  =


    2023-06-22T10:28:49.418024  / # . /lava-10859009/environment/lava-10859=
009/bin/lava-test-runner /lava-10859009/1

    2023-06-22T10:28:49.418379  =

 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/6494219be089a349a230614f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6494219be089a349a2306158
        failing since 146 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-06-22T10:25:11.230833  + set +x

    2023-06-22T10:25:11.237297  <8>[   18.609320] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10858892_1.5.2.3.1>

    2023-06-22T10:25:11.340597  #

    2023-06-22T10:25:11.441467  / # #export SHELL=3D/bin/sh

    2023-06-22T10:25:11.441708  =


    2023-06-22T10:25:11.542279  / # export SHELL=3D/bin/sh. /lava-10858892/=
environment

    2023-06-22T10:25:11.542496  =


    2023-06-22T10:25:11.643064  / # . /lava-10858892/environment/lava-10858=
892/bin/lava-test-runner /lava-10858892/1

    2023-06-22T10:25:11.643377  =


    2023-06-22T10:25:11.645869  / # /lava-10858892/bin/lava-test-runner /la=
va-10858892/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64942472555ca4d8a330615a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64942472555ca4d8a=
330615b
        new failure (last pass: v5.10.179-cip32-rt13) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/649423fde7d050dbfd306140

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beagl=
ebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beagl=
ebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/649423fde7d050dbfd306171
        failing since 146 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-06-22T10:34:38.637279  [   58.574332] <LAVA_SIGNAL_ENDRUN 0_dmesg =
651675_1.6.2.4.1>
    2023-06-22T10:34:38.828474  / # #
    2023-06-22T10:34:38.930453  export SHELL=3D/bin/sh
    2023-06-22T10:34:38.930992  #
    2023-06-22T10:34:39.032538  / # export SHELL=3D/bin/sh. /lava-651675/en=
vironment
    2023-06-22T10:34:39.032975  =

    2023-06-22T10:34:39.134656  / # . /lava-651675/environment/lava-651675/=
bin/lava-test-runner /lava-651675/1
    2023-06-22T10:34:39.135433  =

    2023-06-22T10:34:39.139042  / # /lava-651675/bin/lava-test-runner /lava=
-651675/1
    2023-06-22T10:34:39.449470  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64942901a5fa7e0f3c306161

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebon=
e-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebon=
e-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64942901a5fa7e0f3c306168
        failing since 146 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-06-22T10:56:08.895870  <8>[   46.283706] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 971158_1.6.2.4.1>
    2023-06-22T10:56:09.057492  / # #
    2023-06-22T10:56:09.158862  export SHELL=3D/bin/sh
    2023-06-22T10:56:09.159177  #
    2023-06-22T10:56:09.260285  / # export SHELL=3D/bin/sh. /lava-971158/en=
vironment
    2023-06-22T10:56:09.260615  =

    2023-06-22T10:56:09.361750  / # . /lava-971158/environment/lava-971158/=
bin/lava-test-runner /lava-971158/1
    2023-06-22T10:56:09.362244  =

    2023-06-22T10:56:09.369028  / # /lava-971158/bin/lava-test-runner /lava=
-971158/1
    2023-06-22T10:56:09.712055  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/649422645c4cb1769330612e

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/649422645c4cb17693306168
        failing since 91 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.175-cip29-rt12)

    2023-06-22T10:28:28.231576  [   51.889619] <LAVA_SIGNAL_ENDRUN 0_dmesg =
651531_1.6.2.4.1>
    2023-06-22T10:28:28.337093  #
    2023-06-22T10:28:28.439523  / # #export SHELL=3D/bin/sh
    2023-06-22T10:28:28.440281  =

    2023-06-22T10:28:28.542196  / # export SHELL=3D/bin/sh. /lava-651531/en=
vironment
    2023-06-22T10:28:28.542908  =

    2023-06-22T10:28:28.644839  / # . /lava-651531/environment/lava-651531/=
bin/lava-test-runner /lava-651531/1
    2023-06-22T10:28:28.646109  =

    2023-06-22T10:28:28.650036  / # /lava-651531/bin/lava-test-runner /lava=
-651531/1
    2023-06-22T10:28:28.877865  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64942162dc06acbfa530612e

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebo=
ne-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebo=
ne-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64942162dc06acbfa5306135
        failing since 91 days (last pass: v5.10.158-cip22-rt9, first fail: =
v5.10.175-cip29-rt12)

    2023-06-22T10:24:08.055858  / # #
    2023-06-22T10:24:08.159566  export SHELL=3D/bin/sh
    2023-06-22T10:24:08.161242  #
    2023-06-22T10:24:08.263802  / # export SHELL=3D/bin/sh. /lava-971120/en=
vironment
    2023-06-22T10:24:08.264880  =

    2023-06-22T10:24:08.367403  / # . /lava-971120/environment/lava-971120/=
bin/lava-test-runner /lava-971120/1
    2023-06-22T10:24:08.369083  =

    2023-06-22T10:24:08.382081  / # /lava-971120/bin/lava-test-runner /lava=
-971120/1
    2023-06-22T10:24:08.699583  + export TESTRUN_ID=3D1_bootrr
    2023-06-22T10:24:08.700229  + cd /lava-971120/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/649422d4a001ba3850306160

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baselin=
e-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/649422d4a001ba3850306169
        failing since 34 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v5.10.179-cip32-rt13)

    2023-06-22T10:30:24.685939  + set +x

    2023-06-22T10:30:24.692188  <8>[   21.421300] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10859033_1.5.2.3.1>

    2023-06-22T10:30:24.797299  / # #

    2023-06-22T10:30:24.897928  export SHELL=3D/bin/sh

    2023-06-22T10:30:24.898124  #

    2023-06-22T10:30:24.998665  / # export SHELL=3D/bin/sh. /lava-10859033/=
environment

    2023-06-22T10:30:24.998856  =


    2023-06-22T10:30:25.099348  / # . /lava-10859033/environment/lava-10859=
033/bin/lava-test-runner /lava-10859033/1

    2023-06-22T10:30:25.099615  =


    2023-06-22T10:30:25.104342  / # /lava-10859033/bin/lava-test-runner /la=
va-10859033/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/649421afbf8c1bd0c83061e1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/649421afbf8c1bd0c83061ea
        failing since 34 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v5.10.179-cip32-rt13)

    2023-06-22T10:25:52.645554  + set +x

    2023-06-22T10:25:52.652574  <8>[   23.339421] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10858872_1.5.2.3.1>

    2023-06-22T10:25:52.756749  / # #

    2023-06-22T10:25:52.857384  export SHELL=3D/bin/sh

    2023-06-22T10:25:52.857596  #

    2023-06-22T10:25:52.958104  / # export SHELL=3D/bin/sh. /lava-10858872/=
environment

    2023-06-22T10:25:52.958354  =


    2023-06-22T10:25:53.058934  / # . /lava-10858872/environment/lava-10858=
872/bin/lava-test-runner /lava-10858872/1

    2023-06-22T10:25:53.059383  =


    2023-06-22T10:25:53.064491  / # /lava-10858872/bin/lava-test-runner /la=
va-10858872/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64942178dc06acbfa53061cb

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabrel=
ite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabrel=
ite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64942178dc06acbfa53061d3
        failing since 146 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-06-22T10:24:41.020564  + set +x

    2023-06-22T10:24:41.123435  / # <8>[   26.132654#

    2023-06-22T10:24:41.224269  export SHELL=3D/bin/sh

    2023-06-22T10:24:41.224550  ] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Demer=
g RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-06-22T10:24:41.224672  <8>[   26.133578] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10858923_1.6.2.4.1>

    2023-06-22T10:24:41.224779  #

    2023-06-22T10:24:41.325355  / # export SHELL=3D/bin/sh. /lava-10858923/=
environment

    2023-06-22T10:24:41.325620  =


    2023-06-22T10:24:41.426231  / # . /lava-10858923/environment/lava-10858=
923/bin/lava-test-runner /lava-10858923/1

    2023-06-22T10:24:41.426639  =

 =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/649423165e1e558071306149

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx=
6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx=
6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/649423165e1e558071306152
        failing since 146 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-06-22T10:31:54.266865  / # #

    2023-06-22T10:31:54.369384  export SHELL=3D/bin/sh

    2023-06-22T10:31:54.370127  #

    2023-06-22T10:31:54.471719  / # export SHELL=3D/bin/sh. /lava-10859041/=
environment

    2023-06-22T10:31:54.472494  =


    2023-06-22T10:31:54.574173  / # . /lava-10859041/environment/lava-10859=
041/bin/lava-test-runner /lava-10859041/1

    2023-06-22T10:31:54.575328  =


    2023-06-22T10:31:54.580043  / # /lava-10859041/bin/lava-test-runner /la=
va-10859041/1

    2023-06-22T10:31:54.721265  + export TESTRUN_ID=3D1_bootrr

    2023-06-22T10:31:54.721452  + cd /lava-10859041/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/649423559310959377306186

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-m=
eson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-m=
eson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64942355931095937=
7306187
        failing since 91 days (last pass: v5.10.162-cip24-rt10, first fail:=
 v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/649424b9860297932e306195

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-s=
un50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-s=
un50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/649424b9860297932e3061be
        failing since 146 days (last pass: v5.10.158-cip22-rt9, first fail:=
 v5.10.162-cip24-rt10)

    2023-06-22T10:38:15.703479  [   65.876487] <LAVA_SIGNAL_ENDRUN 0_dmesg =
651555_1.6.2.4.1>
    2023-06-22T10:38:15.838582  #
    2023-06-22T10:38:15.941551  / # #export SHELL=3D/bin/sh
    2023-06-22T10:38:15.942118  =

    2023-06-22T10:38:16.044236  / # export SHELL=3D/bin/sh. /lava-651555/en=
vironment
    2023-06-22T10:38:16.044827  =

    2023-06-22T10:38:16.146414  / # . /lava-651555/environment/lava-651555/=
bin/lava-test-runner /lava-651555/1
    2023-06-22T10:38:16.147385  =

    2023-06-22T10:38:16.151233  / # /lava-651555/bin/lava-test-runner /lava=
-651555/1
    2023-06-22T10:38:16.331360  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

