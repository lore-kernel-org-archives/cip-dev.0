Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB392C38142
	for <webhook@archiver.kernel.org>; Tue, 24 Jan 2023 13:06:29 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web10.14129.1674565581195406145
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 24 Jan 2023 05:06:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=qdhmv17C;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id g205so11150386pfb.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 24 Jan 2023 05:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KN6Aa/TfZO5iGVHgZwdra96eEuWM3cL12N4iiXscNx8=;
        b=qdhmv17C2PRcUbHqWsmLRd21Y5GTqHjfcqRfFRCMgznIJZ/p1pL9Cu0uMK7yOzWgFC
         8g3/QAtH4oLfbFM6GZ6F4PE9VtaZUiR3gHbY7myzV9tVDpwVh2Va7ceYpEdwOPTNDKQD
         l2Ioy/D59FlieHzNErH9A4i2u1/4Ac7ckgFLmUhnzamueVv+MHXpICAUiGx8EQHSNGyD
         lrL6Xc6u3ORk3vXo5zgjAEXBcFpKcKKGokPnptrdTcgPe+v9FgVdJIHq68UnjxXLYVF+
         1ieGidc/BcDZ8jHT+IqpVSzACDK3BXYUyUYebFDcxKcq0LCe2OcZ0nK0CgelmXudduft
         YHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KN6Aa/TfZO5iGVHgZwdra96eEuWM3cL12N4iiXscNx8=;
        b=KNQDp2B7cOVe0PgJ1MFcu2dpvEQuVWgh0XDi5mX1ktb/MbYKqydbQkCYg9S9HQ1FaN
         vrloQX6U8N7Xx09TeJNaeTuQ9H8AZ8x47zXl/wt5+xwukfLyoMNOwiAl4u9zoZNrH9MX
         42jRhhWLXYYMQxnsbm0yESX87tnYFRZ3Upe858coRFBHDeJh6m6ajfCnlwr0R/h1BF1K
         ZocI2lcyc23aLd/hbH+ohkdci53s9NmO00unY2C46q1LV0zNasZ+YcaDxLZoyTor/72c
         BzAoZSD1ZXs1u+lF40GDuU1VYH5IYdkOJzJWMH5BjVT/fItbGU7nd6jkrPygMW2xFWf5
         JSYw==
X-Gm-Message-State: AFqh2kpW3jfXcjUEEM2hwQwnj1qRLVF+HfR4CFi0vUV7crg9EAK+6QgE
	buhV/Bi9Au9J7JVWFO9yyAKPNlxcS8qEPV91uEQ=
X-Google-Smtp-Source: AMrXdXtAFZNBEq8Rye7WnUn+gU46mZd81LMDqzhtkLKjMz62ay2IhRUqljovi0iAJEI9B7BCSRtlPA==
X-Received: by 2002:a62:5bc1:0:b0:58d:ac19:8950 with SMTP id p184-20020a625bc1000000b0058dac198950mr33043489pfb.33.1674565579945;
        Tue, 24 Jan 2023 05:06:19 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r29-20020aa7989d000000b00581172f7456sm1543403pfl.56.2023.01.24.05.06.19
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 05:06:19 -0800 (PST)
Message-ID: <63cfd7cb.a70a0220.87646.27ff@mx.google.com>
Date: Tue, 24 Jan 2023 05:06:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.270-cip89-39-g43ce130174aa
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 32 runs,
 11 regressions (v4.19.270-cip89-39-g43ce130174aa)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Jan 2023 13:06:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10464

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 32 runs, 11 regres=
sions (v4.19.270-cip89-39-g43ce130174aa)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 4          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.270-cip89-39-g43ce130174aa/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.270-cip89-39-g43ce130174aa
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      43ce130174aa6b725d4f63d43ad3736296ef2736 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfca370d3c410268915ed3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63cfca380d3c410268915ed8
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:08:02.197421  + set +x
    2023-01-24T12:08:02.204101  <8>[   18.478370] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8853728_1.5.2.3.1>
    2023-01-24T12:08:02.308548  / # #
    2023-01-24T12:08:02.409519  export SHELL=3D/bin/sh
    2023-01-24T12:08:02.409718  #
    2023-01-24T12:08:02.510603  / # export SHELL=3D/bin/sh. /lava-8853728/e=
nvironment
    2023-01-24T12:08:02.510811  =

    2023-01-24T12:08:02.611748  / # . /lava-8853728/environment/lava-885372=
8/bin/lava-test-runner /lava-8853728/1
    2023-01-24T12:08:02.612088  =

    2023-01-24T12:08:02.616591  / # /lava-8853728/bin/lava-test-runner /lav=
a-8853728/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfca34588bea9b99915f46

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63cfca34588bea9b99915f4b
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:07:59.929711  + <8>[   19.915663] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 8853703_1.5.2.3.1>
    2023-01-24T12:07:59.930486  set +x
    2023-01-24T12:08:00.037328  =

    2023-01-24T12:08:00.138305  / # #export SHELL=3D/bin/sh
    2023-01-24T12:08:00.138534  =

    2023-01-24T12:08:00.239427  / # export SHELL=3D/bin/sh. /lava-8853703/e=
nvironment
    2023-01-24T12:08:00.239638  =

    2023-01-24T12:08:00.340548  / # . /lava-8853703/environment/lava-885370=
3/bin/lava-test-runner /lava-8853703/1
    2023-01-24T12:08:00.340890  =

    2023-01-24T12:08:00.342416  / # /lava-8853703/bin/lava-test-runner /lav=
a-8853703/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcca9746140afd1915eb9

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63cfcca9746140afd1915ebe
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:18:43.723643  [   52.089328] <LAVA_SIGNAL_ENDRUN 0_dmesg =
165245_1.6.2.4.1>
    2023-01-24T12:18:43.852976  / # #
    2023-01-24T12:18:43.955428  export SHELL=3D/bin/sh
    2023-01-24T12:18:43.956554  #
    2023-01-24T12:18:44.058483  / # export SHELL=3D/bin/sh. /lava-165245/en=
vironment
    2023-01-24T12:18:44.059658  =

    2023-01-24T12:18:44.161737  / # . /lava-165245/environment/lava-165245/=
bin/lava-test-runner /lava-165245/1
    2023-01-24T12:18:44.162938  =

    2023-01-24T12:18:44.166785  /lava-165245/bin/lava-test-runner /lava-165=
245/1
    2023-01-24T12:18:44.531244  / # + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcc81376217181b915eed

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/multi_v7_defconfig/gcc-10=
/lab-cip/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/multi_v7_defconfig/gcc-10=
/lab-cip/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63cfcc81376217181b915ef0
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:17:57.934529  + set +x
    2023-01-24T12:17:57.936608  <8>[   40.577125] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 831960_1.6.2.4.1>
    2023-01-24T12:17:58.051673  / # #
    2023-01-24T12:17:58.153667  export SHELL=3D/bin/sh
    2023-01-24T12:17:58.154132  #
    2023-01-24T12:17:58.255537  / # export SHELL=3D/bin/sh. /lava-831960/en=
vironment
    2023-01-24T12:17:58.255996  =

    2023-01-24T12:17:58.357415  / # . /lava-831960/environment/lava-831960/=
bin/lava-test-runner /lava-831960/1
    2023-01-24T12:17:58.358155  =

    2023-01-24T12:17:58.359748  / # /lava-831960/bin/lava-test-runner /lava=
-831960/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfc9c56bde38fd1b916013

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/omap2plus_defconfig/gcc-1=
0/lab-cip/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/omap2plus_defconfig/gcc-1=
0/lab-cip/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63cfc9c56bde38fd1b916016
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:06:14.868114  + set +x
    2023-01-24T12:06:14.870058  <8>[   46.591670] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 831915_1.6.2.4.1>
    2023-01-24T12:06:14.990547  #
    2023-01-24T12:06:15.092678  / # #export SHELL=3D/bin/sh
    2023-01-24T12:06:15.093238  =

    2023-01-24T12:06:15.194614  / # export SHELL=3D/bin/sh. /lava-831915/en=
vironment
    2023-01-24T12:06:15.195104  =

    2023-01-24T12:06:15.296534  / # . /lava-831915/environment/lava-831915/=
bin/lava-test-runner /lava-831915/1
    2023-01-24T12:06:15.297411  =

    2023-01-24T12:06:15.299466  / # /lava-831915/bin/lava-test-runner /lava=
-831915/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfcb945360d0bfa0915ede

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63cfcb945360d0bfa0915ee3
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:13:50.459926  + set +x
    2023-01-24T12:13:50.464802  [   30.680509] <LAVA_SIGNAL_ENDRUN 0_dmesg =
8853791_1.6.2.4.1>
    2023-01-24T12:13:50.574469  #
    2023-01-24T12:13:50.676540  / # #export SHELL=3D/bin/sh
    2023-01-24T12:13:50.677035  =

    2023-01-24T12:13:50.778438  / # export SHELL=3D/bin/sh. /lava-8853791/e=
nvironment
    2023-01-24T12:13:50.778979  =

    2023-01-24T12:13:50.880458  / # . /lava-8853791/environment/lava-885379=
1/bin/lava-test-runner /lava-8853791/1
    2023-01-24T12:13:50.881311  =

    2023-01-24T12:13:50.882652  / # /lava-8853791/bin/lava-test-runner /lav=
a-8853791/1 =

    ... (15 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/63cfcc80db537dc11c915ec6

  Results:     79 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rk3399-gru-sound-driver-rt5514-present: https://ker=
nelci.org/test/case/id/63cfcc80db537dc11c915efd
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:17:43.496623  seq: invalid floating point argument: =E2=
=80=98sound/RT5514=E2=80=99
    2023-01-24T12:17:43.497408  =

    2023-01-24T12:17:43.500738  Try 'seq --help' for more information.
    2023-01-24T12:17:43.504581  /lava-8853777/1/../bin/lava-test-case
    2023-01-24T12:17:43.521348  <8>[   35.402167] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-rt5514-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-max98357A-present: https://=
kernelci.org/test/case/id/63cfcc80db537dc11c915efe
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:17:43.460779  seq: invalid floating point argument: =E2=
=80=98sound/MAX98357A=E2=80=99
    2023-01-24T12:17:43.464107  Try 'seq --help' for more information.
    2023-01-24T12:17:43.468315  /lava-8853777/1/../bin/lava-test-case
    2023-01-24T12:17:43.479432  <8>[   35.360358] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-max98357A-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelc=
i.org/test/case/id/63cfcc80db537dc11c915eff
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:17:43.425382  seq: invalid floating point argument: =E2=
=80=98sound/DP=E2=80=99
    2023-01-24T12:17:43.429157  Try 'seq --help' for more information.
    2023-01-24T12:17:43.432416  /lava-8853777/1/../bin/lava-test-case
    2023-01-24T12:17:43.432670  =

    2023-01-24T12:17:43.444537  <8>[   35.326020] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-da7219-present: https://ker=
nelci.org/test/case/id/63cfcc80db537dc11c915f00
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:17:43.366447  =

    2023-01-24T12:17:43.383055  seq: invalid floating point argument: =E2=
=80=98sound/DA7219=E2=80=99
    2023-01-24T12:17:43.386755  Try 'seq --help' for more information.
    2023-01-24T12:17:43.390962  /lava-8853777/1/../bin/lava-test-case
    2023-01-24T12:17:43.402260  <8>[   35.283424] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>   =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/63cfccd52211a978d5915ee0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-nfs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.270-cip89-39-g43ce130174aa/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-nfs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63cfccd52211a978d5915ee5
        failing since 5 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576, =
first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-01-24T12:19:11.288584  <8>[   22.206663] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 165267_1.6.2.4.1>
    2023-01-24T12:19:11.401879  / # #
    2023-01-24T12:19:11.504155  export SHELL=3D/bin/sh
    2023-01-24T12:19:11.504729  #
    2023-01-24T12:19:11.606304  / # export SHELL=3D/bin/sh. /lava-165267/en=
vironment
    2023-01-24T12:19:11.606784  =

    2023-01-24T12:19:11.709151  / # . /lava-165267/environment/lava-165267/=
bin/lava-test-runner /lava-165267/1
    2023-01-24T12:19:11.709990  =

    2023-01-24T12:19:11.714488  / # /lava-165267/bin/lava-test-runner /lava=
-165267/1
    2023-01-24T12:19:11.789812  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

