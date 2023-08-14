Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F13C001DB
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 11:46:13 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web10.105625.1692013564843302737
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Aug 2023 04:46:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=ykPL34w/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-26934bc3059so3603642a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Aug 2023 04:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692013564; x=1692618364;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LIkxx3o2OSsh1T8Y+tGtTBXZ0mFBDXZWJcMHqdIz0iQ=;
        b=ykPL34w/18IIyHjA6DXyLtk/7TtabR8ZYiUkh60YpV+FU0ivNfFju8C3JhoVIw7Wtu
         o6CixMQqwXxaxjyuNcmgzmZDxBE9H9hgFBpOa7clLdNLB1Wruvcx0gfxAUTyDKyyptr6
         IPGfVskB4qhUS3kyru/7RItLt7FMFjzdlycB8Pht7Cd2aA6kBE6kdkj3CCFaxjBgbj2T
         Hqc/mOcdbUzwjlmgStNleqQnxek6HFTqdQMUrLD0pwOwSzknKjl8HS1VM+yF/nsAH1GR
         DjMrxT+5odwMoJRVNe++BFGNnfZpHdHE/UTC+iP/cvbPWgiybblP26dMhqH4HPBiy9aZ
         i40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692013564; x=1692618364;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIkxx3o2OSsh1T8Y+tGtTBXZ0mFBDXZWJcMHqdIz0iQ=;
        b=lL4aQVznJvhA2vlj9OYv+7cmUjWRIFeV6PMitjMHx/XHoBhL7Kf6odw0TvqtHj9g4F
         /1CtV0P6wMT1vGp45Xmz89C/borq6ZS3hWy8KSwJtll7hD4i2s1xhjTXCN7s5gzTF+Jo
         jBqPDS7e3AfPZJHr5ntg8pDpmvcw/375ZDiafooh8HUXw3/pQdGI6kPaEjm4/o0biT9s
         eeznEHXms7dKcE0F79T902gwJx0YSCnRZX4A+4TZhklH15T7HDs8L5dx+dFNF3m1CpkL
         E5f71RrdqBxYkNCYZ82wX8YfEFs0wOGlOsK3PPmAZyMQBDINzF9ek3Uf1SiTcrRjTNJ5
         cgvg==
X-Gm-Message-State: AOJu0YyrZL9I3f4x2u2Xx/f/zCSiliIvMEne62eMsIZjvmBoP5Q3OAz9
	fsU5ojakHcCJhGlYi8m6diy/VQu0cE6/S9nFlKziWOCd
X-Google-Smtp-Source: AGHT+IHcVSTTkfC6JrjLh7danEEgJf8S2GZJMGx4SvLPA3KQPLaytfKO4DHHI1rmj0b4R17/GK+jVA==
X-Received: by 2002:a17:90a:fe4:b0:268:2f6:61c4 with SMTP id 91-20020a17090a0fe400b0026802f661c4mr11983088pjz.12.1692013563418;
        Mon, 14 Aug 2023 04:46:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090a31c600b00267eead2f16sm8402824pjf.36.2023.08.14.04.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 04:46:02 -0700 (PDT)
Message-ID: <64da13fa.170a0220.94ddf.da2c@mx.google.com>
Date: Mon, 14 Aug 2023 04:46:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.288-cip101-rt32
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip-rt
Subject: cip/linux-4.19.y-cip-rt baseline-nfs: 39 runs,
 17 regressions (v4.19.288-cip101-rt32)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 11:46:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12642

cip/linux-4.19.y-cip-rt baseline-nfs: 39 runs, 17 regressions (v4.19.288-ci=
p101-rt32)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 1          =

asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | defconfig+p=
reempt_rt         | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | defconfig  =
                  | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | defconfig+p=
reempt_rt         | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fc...g+preempt_rt | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fc...g+preempt_rt | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | defconfig+p=
reempt_rt         | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fc...g+preempt_rt | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.288-cip101-rt32/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.288-cip101-rt32
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1f3468542aa9e444da3a41472888366e97d515e2 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0d8293c3f2c1bc35b254

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baseli=
ne-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baseli=
ne-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64da0d8293c3f2c1bc35b259
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:18:02.584262  + set +x<8>[   16.197038] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11283489_1.5.2.3.1>

    2023-08-14T11:18:02.584345  =


    2023-08-14T11:18:02.694007  / # #

    2023-08-14T11:18:02.794689  export SHELL=3D/bin/sh

    2023-08-14T11:18:02.794898  #

    2023-08-14T11:18:02.895385  / # export SHELL=3D/bin/sh. /lava-11283489/=
environment

    2023-08-14T11:18:02.895646  =


    2023-08-14T11:18:02.996240  / # . /lava-11283489/environment/lava-11283=
489/bin/lava-test-runner /lava-11283489/1

    2023-08-14T11:18:02.996609  =


    2023-08-14T11:18:03.001352  / # /lava-11283489/bin/lava-test-runner /la=
va-11283489/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0da1213b594bf035b1ec

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/la=
b-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/la=
b-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64da0da1213b594bf035b1f1
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:18:45.703522  + set +x

    2023-08-14T11:18:45.710307  <8>[   19.266500] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11283539_1.5.2.3.1>

    2023-08-14T11:18:45.814442  / # #

    2023-08-14T11:18:45.916735  export SHELL=3D/bin/sh

    2023-08-14T11:18:45.917370  #

    2023-08-14T11:18:46.018935  / # export SHELL=3D/bin/sh. /lava-11283539/=
environment

    2023-08-14T11:18:46.019604  =


    2023-08-14T11:18:46.121147  / # . /lava-11283539/environment/lava-11283=
539/bin/lava-test-runner /lava-11283539/1

    2023-08-14T11:18:46.122418  =


    2023-08-14T11:18:46.128061  / # /lava-11283539/bin/lava-test-runner /la=
va-11283539/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0dc24721515ccb35b1e7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baseli=
ne-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baseli=
ne-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64da0dc24721515ccb35b1ec
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:19:17.925453  + <8>[   21.778773] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11283515_1.5.2.3.1>

    2023-08-14T11:19:17.925802  set +x

    2023-08-14T11:19:18.034961  / # #

    2023-08-14T11:19:18.137788  export SHELL=3D/bin/sh

    2023-08-14T11:19:18.138502  #

    2023-08-14T11:19:18.239979  / # export SHELL=3D/bin/sh. /lava-11283515/=
environment

    2023-08-14T11:19:18.240736  =


    2023-08-14T11:19:18.342152  / # . /lava-11283515/environment/lava-11283=
515/bin/lava-test-runner /lava-11283515/1

    2023-08-14T11:19:18.343333  =


    2023-08-14T11:19:18.348149  / # /lava-11283515/bin/lava-test-runner /la=
va-11283515/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0dca4721515ccb35b204

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/la=
b-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/la=
b-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64da0dca4721515ccb35b209
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:19:19.526839  + set +x

    2023-08-14T11:19:19.532485  <8>[   22.566957] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11283558_1.5.2.3.1>

    2023-08-14T11:19:19.643727  #

    2023-08-14T11:19:19.746600  / # #export SHELL=3D/bin/sh

    2023-08-14T11:19:19.747380  =


    2023-08-14T11:19:19.848876  / # export SHELL=3D/bin/sh. /lava-11283558/=
environment

    2023-08-14T11:19:19.849866  =


    2023-08-14T11:19:19.951546  / # . /lava-11283558/environment/lava-11283=
558/bin/lava-test-runner /lava-11283558/1

    2023-08-14T11:19:19.952759  =


    2023-08-14T11:19:19.954895  / # /lava-11283558/bin/lava-test-runner /la=
va-11283558/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0da2a4e5e2668235b1e6

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64da0da2a4e5e2668235b20f
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:18:06.231758  <8>[   46.794744] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 50996_1.6.2.4.1>
    2023-08-14T11:18:06.350373  / # #
    2023-08-14T11:18:06.453411  export SHELL=3D/bin/sh
    2023-08-14T11:18:06.454285  #
    2023-08-14T11:18:06.556374  / # export SHELL=3D/bin/sh. /lava-50996/env=
ironment
    2023-08-14T11:18:06.557342  =

    2023-08-14T11:18:06.659399  / # . /lava-50996/environment/lava-50996/bi=
n/lava-test-runner /lava-50996/1
    2023-08-14T11:18:06.660880  =

    2023-08-14T11:18:06.663788  / # /lava-50996/bin/lava-test-runner /lava-=
50996/1
    2023-08-14T11:18:06.871054  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | defconfig+p=
reempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0daea4e5e2668235b258

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-be=
aglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-nfs-be=
aglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64da0daea4e5e2668235b283
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:18:30.402358  <8>[   58.279492] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 51004_1.6.2.4.1>
    2023-08-14T11:18:30.519036  / # #
    2023-08-14T11:18:30.621215  export SHELL=3D/bin/sh
    2023-08-14T11:18:30.621965  #
    2023-08-14T11:18:30.723972  / # export SHELL=3D/bin/sh. /lava-51004/env=
ironment
    2023-08-14T11:18:30.724766  =

    2023-08-14T11:18:30.826980  / # . /lava-51004/environment/lava-51004/bi=
n/lava-test-runner /lava-51004/1
    2023-08-14T11:18:30.827940  =

    2023-08-14T11:18:30.832503  / # /lava-51004/bin/lava-test-runner /lava-=
51004/1
    2023-08-14T11:18:31.032998  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0f4e23d8acee5c35b1d9

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64da0f4e23d8acee5c35b1dc
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:25:24.803700  / # #
    2023-08-14T11:25:24.907174  export SHELL=3D/bin/sh
    2023-08-14T11:25:24.907630  #
    2023-08-14T11:25:25.009021  / # export SHELL=3D/bin/sh. /lava-997278/en=
vironment
    2023-08-14T11:25:25.010005  =

    2023-08-14T11:25:25.112326  / # . /lava-997278/environment/lava-997278/=
bin/lava-test-runner /lava-997278/1
    2023-08-14T11:25:25.114075  =

    2023-08-14T11:25:25.125676  / # /lava-997278/bin/lava-test-runner /lava=
-997278/1
    2023-08-14T11:25:25.355171  + export TESTRUN_ID=3D1_bootrr
    2023-08-14T11:25:25.355777  + cd /lava-997278/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | defconfig+p=
reempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/64da100221b51ac55435b1d9

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig+preempt_rt/gcc-10/lab-cip/baseline-nfs-beagle=
bone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig+preempt_rt/gcc-10/lab-cip/baseline-nfs-beagle=
bone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64da100221b51ac55435b1dc
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:28:25.242589  / # #
    2023-08-14T11:28:25.346231  export SHELL=3D/bin/sh
    2023-08-14T11:28:25.347293  #
    2023-08-14T11:28:25.450225  / # export SHELL=3D/bin/sh. /lava-997282/en=
vironment
    2023-08-14T11:28:25.451325  =

    2023-08-14T11:28:25.553689  / # . /lava-997282/environment/lava-997282/=
bin/lava-test-runner /lava-997282/1
    2023-08-14T11:28:25.555334  =

    2023-08-14T11:28:25.563416  / # /lava-997282/bin/lava-test-runner /lava=
-997282/1
    2023-08-14T11:28:25.828781  + export TESTRUN_ID=3D1_bootrr
    2023-08-14T11:28:25.829431  + cd /lava-997282/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0ce6a214e1b90a35b211

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64da0ce6a214e1b90a35b23c
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:15:03.198411  <8>[   46.108029] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 50949_1.6.2.4.1>
    2023-08-14T11:15:03.311780  / # #
    2023-08-14T11:15:03.414767  export SHELL=3D/bin/sh
    2023-08-14T11:15:03.415503  #
    2023-08-14T11:15:03.517781  / # export SHELL=3D/bin/sh. /lava-50949/env=
ironment
    2023-08-14T11:15:03.518519  =

    2023-08-14T11:15:03.621019  / # . /lava-50949/environment/lava-50949/bi=
n/lava-test-runner /lava-50949/1
    2023-08-14T11:15:03.622176  =

    2023-08-14T11:15:03.626186  / # /lava-50949/bin/lava-test-runner /lava-=
50949/1
    2023-08-14T11:15:03.800265  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0d7a93c3f2c1bc35b201

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-broonie/baseli=
ne-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-broonie/baseli=
ne-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64da0d7a93c3f2c1bc35b22c
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:17:35.378761  <8>[   52.828455] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 50969_1.6.2.4.1>
    2023-08-14T11:17:35.499732  / # #
    2023-08-14T11:17:35.602919  export SHELL=3D/bin/sh
    2023-08-14T11:17:35.603676  #
    2023-08-14T11:17:35.705431  / # export SHELL=3D/bin/sh. /lava-50969/env=
ironment
    2023-08-14T11:17:35.706096  =

    2023-08-14T11:17:35.807749  / # . /lava-50969/environment/lava-50969/bi=
n/lava-test-runner /lava-50969/1
    2023-08-14T11:17:35.808947  =

    2023-08-14T11:17:35.812365  / # /lava-50969/bin/lava-test-runner /lava-=
50969/1
    2023-08-14T11:17:36.021432  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0d30273d74a31f35b215

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebo=
ne-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebo=
ne-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64da0d30273d74a31f35b218
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:16:02.390527  <8>[   43.459707] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 997257_1.6.2.4.1>
    2023-08-14T11:16:02.658957  / # #
    2023-08-14T11:16:02.761724  export SHELL=3D/bin/sh
    2023-08-14T11:16:02.762429  #
    2023-08-14T11:16:02.864289  / # export SHELL=3D/bin/sh. /lava-997257/en=
vironment
    2023-08-14T11:16:02.865030  =

    2023-08-14T11:16:02.966908  / # . /lava-997257/environment/lava-997257/=
bin/lava-test-runner /lava-997257/1
    2023-08-14T11:16:02.968077  =

    2023-08-14T11:16:02.973452  / # /lava-997257/bin/lava-test-runner /lava=
-997257/1
    2023-08-14T11:16:03.228798  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0e5baa2017949035b1ea

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-cip/baseline-n=
fs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-cip/baseline-n=
fs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64da0e5baa2017949035b1ed
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:20:41.154156  <8>[   48.538461] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 997262_1.6.2.4.1>
    2023-08-14T11:20:41.390070  / # #
    2023-08-14T11:20:41.492529  export SHELL=3D/bin/sh
    2023-08-14T11:20:41.493167  #
    2023-08-14T11:20:41.594849  / # export SHELL=3D/bin/sh. /lava-997262/en=
vironment
    2023-08-14T11:20:41.595520  =

    2023-08-14T11:20:41.697323  / # . /lava-997262/environment/lava-997262/=
bin/lava-test-runner /lava-997262/1
    2023-08-14T11:20:41.698449  =

    2023-08-14T11:20:41.705008  / # /lava-997262/bin/lava-test-runner /lava=
-997262/1
    2023-08-14T11:20:42.023708  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0d08c97efdc09f35b206

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beagleb=
one-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beagleb=
one-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64da0d08c97efdc09f35b209
        new failure (last pass: v4.19.280-cip95-rt30)

    2023-08-14T11:15:42.007985  + set +x<8>[   49.784585] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 997256_1.6.2.4.1>
    2023-08-14T11:15:42.008469  =

    2023-08-14T11:15:42.198621  #
    2023-08-14T11:15:42.301608  / # #export SHELL=3D/bin/sh
    2023-08-14T11:15:42.302320  =

    2023-08-14T11:15:42.404114  / # export SHELL=3D/bin/sh. /lava-997256/en=
vironment
    2023-08-14T11:15:42.404918  =

    2023-08-14T11:15:42.506746  / # . /lava-997256/environment/lava-997256/=
bin/lava-test-runner /lava-997256/1
    2023-08-14T11:15:42.507890  =

    2023-08-14T11:15:42.514582  /lava-997256/bin/lava-test-runner /lava-997=
256/1/ #  =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0d460b00e0039635b1db

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64da0d460b00e0039635b1df
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:17:18.806075  / # #

    2023-08-14T11:17:18.907835  export SHELL=3D/bin/sh

    2023-08-14T11:17:18.908509  #

    2023-08-14T11:17:19.009831  / # export SHELL=3D/bin/sh. /lava-11283611/=
environment

    2023-08-14T11:17:19.010454  =


    2023-08-14T11:17:19.111886  / # . /lava-11283611/environment/lava-11283=
611/bin/lava-test-runner /lava-11283611/1

    2023-08-14T11:17:19.112958  =


    2023-08-14T11:17:19.115208  / # /lava-11283611/bin/lava-test-runner /la=
va-11283611/1

    2023-08-14T11:17:19.260758  + export TESTRUN_ID=3D1_bootrr

    2023-08-14T11:17:19.260900  + cd /lava-11283611/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | defconfig+p=
reempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0d600b00e0039635b287

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-nfs-=
imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-nfs-=
imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64da0d600b00e0039635b28c
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:18:28.859749  / # #

    2023-08-14T11:18:28.961805  export SHELL=3D/bin/sh

    2023-08-14T11:18:28.962470  #

    2023-08-14T11:18:29.063908  / # export SHELL=3D/bin/sh. /lava-11283646/=
environment

    2023-08-14T11:18:29.064628  =


    2023-08-14T11:18:29.166099  / # . /lava-11283646/environment/lava-11283=
646/bin/lava-test-runner /lava-11283646/1

    2023-08-14T11:18:29.167222  =


    2023-08-14T11:18:29.212255  / # /lava-11283646/bin/lava-test-runner /la=
va-11283646/1

    2023-08-14T11:18:29.343767  + export TESTRUN_ID=3D1_bootrr

    2023-08-14T11:18:29.344216  + cd /lava-11283646/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0cb4045d5c583735b29a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-im=
x6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-im=
x6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64da0cb4045d5c583735b29f
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:14:44.948829  / # #

    2023-08-14T11:14:45.051615  export SHELL=3D/bin/sh

    2023-08-14T11:14:45.052466  #

    2023-08-14T11:14:45.154124  / # export SHELL=3D/bin/sh. /lava-11283575/=
environment

    2023-08-14T11:14:45.154937  =


    2023-08-14T11:14:45.256886  / # . /lava-11283575/environment/lava-11283=
575/bin/lava-test-runner /lava-11283575/1

    2023-08-14T11:14:45.258151  =


    2023-08-14T11:14:45.272040  / # /lava-11283575/bin/lava-test-runner /la=
va-11283575/1

    2023-08-14T11:14:45.458846  + export TESTRUN_ID=3D1_bootrr

    2023-08-14T11:14:45.459068  + cd /lava-11283575/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0cf0a214e1b90a35b2d6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/base=
line-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
288-cip101-rt32/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/base=
line-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64da0cf0a214e1b90a35b2db
        failing since 207 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-08-14T11:15:37.467171  / # #

    2023-08-14T11:15:37.569763  export SHELL=3D/bin/sh

    2023-08-14T11:15:37.570484  #

    2023-08-14T11:15:37.672210  / # export SHELL=3D/bin/sh. /lava-11283593/=
environment

    2023-08-14T11:15:37.672934  =


    2023-08-14T11:15:37.774544  / # . /lava-11283593/environment/lava-11283=
593/bin/lava-test-runner /lava-11283593/1

    2023-08-14T11:15:37.775664  =


    2023-08-14T11:15:37.790675  / # /lava-11283593/bin/lava-test-runner /la=
va-11283593/1

    2023-08-14T11:15:37.934518  + export TESTRUN_ID=3D1_bootrr

    2023-08-14T11:15:37.986434  + cd /lava-11283593/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =20

