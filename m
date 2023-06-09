Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DD8C83003
	for <webhook@archiver.kernel.org>; Fri,  9 Jun 2023 12:10:38 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.11643.1686312632703695144
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Jun 2023 05:10:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=I3qA7+E9;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1b05e96dabbso5182205ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Jun 2023 05:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686312632; x=1688904632;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6iWy3g6lkhz4MY7/2Y6ao7cjt37wq0XRTkQwjiGYwPA=;
        b=I3qA7+E9Kgxpz5C3RN47gvyTROLne+PxXvoqSzSVQMHEXGF++zFVvHlF54tN82FNAy
         qHvg/UWqTLwJx0JXaCo+FLKA8/5j8ezqaq7OBgp70F8n8iNM+PS1FxZ+Y2F6y+/cPf/Q
         4s3+4oGRa6w9AX0AxPOgkB2L8Kn9fFm/+lMsF3q5rkygOJMQnPnrFi1Y69D6la5h19rr
         P/02bHxOTqY1n2oA6AZB+2hups6pSj6DLlqMuvBPh3PBBVeqOZzXh33rRaUy9CixXtc1
         VZ2PcHxvTG4tezA8B004C0fWHm1BZUxHGkaeNqnRgplqaFWLEVMa2/pjQbsxDPTRLrF4
         2gIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686312632; x=1688904632;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6iWy3g6lkhz4MY7/2Y6ao7cjt37wq0XRTkQwjiGYwPA=;
        b=enr58iA6sBT3Q7/Jf4adTJe8lPNQRmOBS5cpBErqgu0Z0T4A1YGVb5xE9igo6CaMYd
         vJn7si/ItvWtCTp+ZX6sa6KmOZhPdNFm9jHI3hEIqX6FJ07OAX9NFSWIdDJXEr69bk1N
         17GQpHLwoiYrb2aLvlwaqlFOiiMr5+7Q48aCNeRJXa8MYT2ZXA39bHq5bc4anA7k0Dyk
         bmQ4gjFL/YnDTZT5MjdPG9qUEc9L9wasCtkegb/TlwuY9kQG8PrHoSYqABhGEwAG6a4Y
         uPpPArvS86NDks2fiSeW0rKgWoW9co/I+v3GbIxIFzkbdTbZCFQsph8nfcjMc2GBwGhg
         kfGg==
X-Gm-Message-State: AC+VfDx9y4R9wTqWUPGBnpZoVTXRAB3X8NW2BiD36g0gGhaWw2YBcPwE
	VmcuZtt6uIrgdJJ/C+mowd3KnPxGIGX10Mqy1iu6UQ==
X-Google-Smtp-Source: ACHHUZ7RduHtsx8j9b+x4wMlRbAMmRWpCjwzELK6Se3e0Uf7ewIxuLol3bi26Gah5fZw/HVWOjtGoQ==
X-Received: by 2002:a17:902:ed41:b0:1ae:4bbb:e958 with SMTP id y1-20020a170902ed4100b001ae4bbbe958mr799719plb.14.1686312631311;
        Fri, 09 Jun 2023 05:10:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f16-20020a170902ce9000b001a52c38350fsm3125299plg.169.2023.06.09.05.10.30
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 05:10:30 -0700 (PDT)
Message-ID: <648316b6.170a0220.90125.6215@mx.google.com>
Date: Fri, 09 Jun 2023 05:10:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.283-cip98-224-g5f5303d7920a9
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 36 runs,
 8 regressions (v4.19.283-cip98-224-g5f5303d7920a9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jun 2023 12:10:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11935

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 36 runs, 8 regress=
ions (v4.19.283-cip98-224-g5f5303d7920a9)

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
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.283-cip98-224-g5f5303d7920a9/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.283-cip98-224-g5f5303d7920a9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      5f5303d7920a98db8e84681ee6f1318ae918ab84 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64830d0d7018d8570b30612e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64830d0d7018d8570b306133
        failing since 141 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-09T11:28:55.184325  + set +x

    2023-06-09T11:28:55.189911  <8>[   18.126451] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10657565_1.5.2.3.1>

    2023-06-09T11:28:55.302777  #

    2023-06-09T11:28:55.405504  / # #export SHELL=3D/bin/sh

    2023-06-09T11:28:55.406291  =


    2023-06-09T11:28:55.507876  / # export SHELL=3D/bin/sh. /lava-10657565/=
environment

    2023-06-09T11:28:55.508677  =


    2023-06-09T11:28:55.610097  / # . /lava-10657565/environment/lava-10657=
565/bin/lava-test-runner /lava-10657565/1

    2023-06-09T11:28:55.611416  =


    2023-06-09T11:28:55.613294  / # /lava-10657565/bin/lava-test-runner /la=
va-10657565/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64830d04173c7756e7306170

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64830d04173c7756e7306175
        failing since 141 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-09T11:28:49.287275  + <8>[   21.197094] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10657511_1.5.2.3.1>

    2023-06-09T11:28:49.287768  set +x

    2023-06-09T11:28:49.394216  / # #

    2023-06-09T11:28:49.494931  export SHELL=3D/bin/sh

    2023-06-09T11:28:49.495197  #

    2023-06-09T11:28:49.595818  / # export SHELL=3D/bin/sh. /lava-10657511/=
environment

    2023-06-09T11:28:49.596169  =


    2023-06-09T11:28:49.696828  / # . /lava-10657511/environment/lava-10657=
511/bin/lava-test-runner /lava-10657511/1

    2023-06-09T11:28:49.697190  =


    2023-06-09T11:28:49.702551  / # /lava-10657511/bin/lava-test-runner /la=
va-10657511/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6483092b0b88a370f3306143

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6483092b0b88a370f330616e
        failing since 141 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-09T11:12:00.946838  [   51.239321] <LAVA_SIGNAL_ENDRUN 0_dmesg =
585804_1.6.2.4.1>
    2023-06-09T11:12:01.068987  / # #
    2023-06-09T11:12:01.171739  export SHELL=3D/bin/sh
    2023-06-09T11:12:01.172325  #
    2023-06-09T11:12:01.274267  / # export SHELL=3D/bin/sh. /lava-585804/en=
vironment
    2023-06-09T11:12:01.274915  =

    2023-06-09T11:12:01.377184  / # . /lava-585804/environment/lava-585804/=
bin/lava-test-runner /lava-585804/1
    2023-06-09T11:12:01.378240  =

    2023-06-09T11:12:01.382423  / # /lava-585804/bin/lava-test-runner /lava=
-585804/1
    2023-06-09T11:12:01.929102  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64830ba31d4d515ad3306155

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm/multi_v7_defconfig/gcc-=
10/lab-cip/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm/multi_v7_defconfig/gcc-=
10/lab-cip/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64830ba31d4d515ad3306158
        failing since 141 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-09T11:22:23.434622  + set +x
    2023-06-09T11:22:23.436468  [   42.930849] <LAVA_SIGNAL_ENDRUN 0_dmesg =
957985_1.6.2.4.1>
    2023-06-09T11:22:23.551245  / # #
    2023-06-09T11:22:23.653174  export SHELL=3D/bin/sh
    2023-06-09T11:22:23.653628  #
    2023-06-09T11:22:23.755012  / # export SHELL=3D/bin/sh. /lava-957985/en=
vironment
    2023-06-09T11:22:23.755493  =

    2023-06-09T11:22:23.856904  / # . /lava-957985/environment/lava-957985/=
bin/lava-test-runner /lava-957985/1
    2023-06-09T11:22:23.857641  =

    2023-06-09T11:22:23.859135  / # /lava-957985/bin/lava-test-runner /lava=
-957985/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/648307cfa798def740306147

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/648307cfa798def74030614a
        new failure (last pass: v4.19.283-cip98-135-g4ed206c5dc11)

    2023-06-09T11:06:20.448086  + set +x
    2023-06-09T11:06:20.449803  [   45.507288] <LAVA_SIGNAL_ENDRUN 0_dmesg =
957968_1.6.2.4.1>
    2023-06-09T11:06:20.578388  #
    2023-06-09T11:06:20.680514  / # #export SHELL=3D/bin/sh
    2023-06-09T11:06:20.680974  =

    2023-06-09T11:06:20.782364  / # export SHELL=3D/bin/sh. /lava-957968/en=
vironment
    2023-06-09T11:06:20.782810  =

    2023-06-09T11:06:20.884304  / # . /lava-957968/environment/lava-957968/=
bin/lava-test-runner /lava-957968/1
    2023-06-09T11:06:20.885172  =

    2023-06-09T11:06:20.887119  / # /lava-957968/bin/lava-test-runner /lava=
-957968/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648308936deb65a99e3061ae

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm/multi_v7_defconfig/gcc-=
10/lab-collabora/baseline-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/648308936deb65a99e3061b3
        failing since 141 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-06-09T11:10:09.109638  / # #

    2023-06-09T11:10:09.212459  export SHELL=3D/bin/sh

    2023-06-09T11:10:09.213240  #

    2023-06-09T11:10:09.315206  / # export SHELL=3D/bin/sh. /lava-10657164/=
environment

    2023-06-09T11:10:09.316051  =


    2023-06-09T11:10:09.417681  / # . /lava-10657164/environment/lava-10657=
164/bin/lava-test-runner /lava-10657164/1

    2023-06-09T11:10:09.418943  =


    2023-06-09T11:10:09.433895  / # /lava-10657164/bin/lava-test-runner /la=
va-10657164/1

    2023-06-09T11:10:09.593475  + export TESTRUN_ID=3D1_bootrr

    2023-06-09T11:10:09.593927  + cd /lava-10657164/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6483090098b6b3a25d306134

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/6483090098b6b3a25d30613a
        failing since 87 days (last pass: v4.19.273-cip92-277-g507c8d80b9e2=
0, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-06-09T11:12:08.191829  /lava-10657175/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/6483090098b6b3a25d30613b
        failing since 87 days (last pass: v4.19.273-cip92-277-g507c8d80b9e2=
0, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-06-09T11:12:07.124063  /lava-10657175/1/../bin/lava-test-case

    2023-06-09T11:12:07.151309  <8>[   39.881943] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

