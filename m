Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517B7C7EE29
	for <webhook@archiver.kernel.org>; Sun,  4 Jun 2023 23:52:40 +0000 (UTC)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
 by mx.groups.io with SMTP id smtpd.web11.764.1685922758521769554
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 04 Jun 2023 16:52:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=P0hA5MId;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.47, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1a2c9f087f0so1713393fac.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 04 Jun 2023 16:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685922757; x=1688514757;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CdMMgynxryZJKUzvpz6hoxLAcWs9PL7V7o3qXwP+EtU=;
        b=P0hA5MIdtg9j1aMMUJoMx3Ic3GYDGpCWW54V2iNBMCAytkT5nn7VsGz83u1LNt/FNV
         BjLRlFWa33r/Y2t3AeSfRPMgQ6gEW85pfhOGkxQuZofvf7i98CFn9WbkRtfu9nNK0L37
         WPfjWKossw9Jbk/6A0Qx4k8DaXg/N9xFrkIy4Ln9alzFx0daHx8hj7lgC5WyCjmnt8m1
         w9f04uFqAwgSap47AsGBiGfpBKfLYJizU+aYKrvLTctYRr1APAaMwpRzFtB+jFWmMy8Y
         Ozdu8L5fqfuHueGiQ8r84yKCX8z8KbDaSZEcGsoyPpzhD8QH45p8NF8KAKDfXFzNbYck
         +FvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685922757; x=1688514757;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdMMgynxryZJKUzvpz6hoxLAcWs9PL7V7o3qXwP+EtU=;
        b=VfPAUU9Q1UKhm+jky7/5xvxbiIGLXwt3pmtB2Kme0+73b5psYfxAcl5q1435/Z1xkB
         LQTayxQ+9IZ0cnQyeCefffo0OjEqDlJdC4MfKSgas33lYb0W3PtSu4Cc5SpwcieaulO3
         tyiFzikHkgRqd92UXUo7UZgrp74Nrz2t1uxlMJG3re+P7i7yuf7M4G/0FX4qO3y821/V
         JaNy47LFfLtPbHaVbVfDxw4RU9kjvHS0/5Tb+3imFYmnr89T+62TEX6G3vV/uSxyyq6U
         xiTBCiayGprZf1SXFWZiWj4H75qCyprGqfygf6gwxw2r5F7BroZfwwgKysKojRhP3IXt
         pNfA==
X-Gm-Message-State: AC+VfDxKFTAFNdTPSmfNvnCvp6I6l3NXtASInz44b7mj7pvksdEm9XjS
	PUi/IGFCS4kHVLJV4Rv+OuI6IeJlJd5nHX5wQcI5Ig==
X-Google-Smtp-Source: ACHHUZ5XVoNL0PqD44S/x87C+6PozaxjJuQ8kQV62ZnO+bFkWn3RgRcAAXaQ0y9+vh7WOJKjKTO0NA==
X-Received: by 2002:a05:6808:3d4:b0:39a:9e60:1bd7 with SMTP id o20-20020a05680803d400b0039a9e601bd7mr3254004oie.27.1685922757294;
        Sun, 04 Jun 2023 16:52:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u24-20020a62ed18000000b00643355ff6a6sm4148414pfh.99.2023.06.04.16.52.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 16:52:36 -0700 (PDT)
Message-ID: <647d23c4.620a0220.27f7d.710e@mx.google.com>
Date: Sun, 04 Jun 2023 16:52:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1301-g6369cf0363211
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 33 runs,
 10 regressions (v6.1.26-1301-g6369cf0363211)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 04 Jun 2023 23:52:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11764

cip-gitlab/ci/pavel/linux-test baseline-nfs: 33 runs, 10 regressions (v6.1.=
26-1301-g6369cf0363211)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig            | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1301-g6369cf0363211/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1301-g6369cf0363211
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6369cf036321117aa7bd9be009c3b7107cea2007 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647d1894c63a015fc4f5de4f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647d1894c63a015fc4f5de58
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-04T23:04:40.204003  <8>[   18.049783] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10584295_1.5.2.3.1>

    2023-06-04T23:04:40.309724  / # #

    2023-06-04T23:04:40.412101  export SHELL=3D/bin/sh

    2023-06-04T23:04:40.412765  #

    2023-06-04T23:04:40.514094  / # export SHELL=3D/bin/sh. /lava-10584295/=
environment

    2023-06-04T23:04:40.514776  =


    2023-06-04T23:04:40.616384  / # . /lava-10584295/environment/lava-10584=
295/bin/lava-test-runner /lava-10584295/1

    2023-06-04T23:04:40.617509  =


    2023-06-04T23:04:40.622798  / # /lava-10584295/bin/lava-test-runner /la=
va-10584295/1

    2023-06-04T23:04:40.709810  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/647d18aa183efdcd3af5de26

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/at91_dt_defconfig/gcc-10/lab-broonie/basel=
ine-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/at91_dt_defconfig/gcc-10/lab-broonie/basel=
ine-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647d18aa183efdcd3=
af5de27
        new failure (last pass: v6.1.26-1281-g84d5372e0f31) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647d1ca5bc5ef1089ff5de25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647d1ca5bc5ef1089=
ff5de26
        failing since 19 days (last pass: v5.10.177-cip31-33-gd59f246891e73=
, first fail: v5.10.179-cip32-4-g580ea5dd85ae) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647d1d161771a4bb34f5de8b

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647d1d161771a4bb34f5de92
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-04T23:23:43.693702  + set +x
    2023-06-04T23:23:43.696944  [   44.257714] <LAVA_SIGNAL_ENDRUN 0_dmesg =
952217_1.6.2.4.1>
    2023-06-04T23:23:43.861179  #
    2023-06-04T23:23:43.963960  / # #export SHELL=3D/bin/sh
    2023-06-04T23:23:43.964649  =

    2023-06-04T23:23:44.066468  / # export SHELL=3D/bin/sh. /lava-952217/en=
vironment
    2023-06-04T23:23:44.067067  =

    2023-06-04T23:23:44.168808  / # . /lava-952217/environment/lava-952217/=
bin/lava-test-runner /lava-952217/1
    2023-06-04T23:23:44.169926  =

    2023-06-04T23:23:44.176321  / # /lava-952217/bin/lava-test-runner /lava=
-952217/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647d18bd91d94e9a1bf5de42

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647d18bd91d94e9a1bf5de4b
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-04T23:05:10.937791  + <8>[   19.186773] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10584294_1.5.2.3.1>

    2023-06-04T23:05:10.937874  set +x

    2023-06-04T23:05:11.042416  / # #

    2023-06-04T23:05:11.143095  export SHELL=3D/bin/sh

    2023-06-04T23:05:11.143282  #

    2023-06-04T23:05:11.243790  / # export SHELL=3D/bin/sh. /lava-10584294/=
environment

    2023-06-04T23:05:11.243987  =


    2023-06-04T23:05:11.344528  / # . /lava-10584294/environment/lava-10584=
294/bin/lava-test-runner /lava-10584294/1

    2023-06-04T23:05:11.344827  =


    2023-06-04T23:05:11.349650  / # /lava-10584294/bin/lava-test-runner /la=
va-10584294/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647d1895c63a015fc4f5de5b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647d1895c63a015fc4f5de64
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-04T23:04:47.867948  <8>[   17.882275] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10584276_1.5.2.3.1>

    2023-06-04T23:04:47.972915  / # #

    2023-06-04T23:04:48.073534  export SHELL=3D/bin/sh

    2023-06-04T23:04:48.073750  #

    2023-06-04T23:04:48.174323  / # export SHELL=3D/bin/sh. /lava-10584276/=
environment

    2023-06-04T23:04:48.174520  =


    2023-06-04T23:04:48.275052  / # . /lava-10584276/environment/lava-10584=
276/bin/lava-test-runner /lava-10584276/1

    2023-06-04T23:04:48.275358  =


    2023-06-04T23:04:48.280173  / # /lava-10584276/bin/lava-test-runner /la=
va-10584276/1

    2023-06-04T23:04:48.356390  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647d1914f66b63f2e3f5de49

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix=
/baseline-nfs-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix=
/baseline-nfs-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647d1914f66b63f2e=
3f5de4a
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647d1ae6980f42bab2f5de49

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647d1ae7980f42bab=
2f5de4a
        new failure (last pass: v6.1.26-1281-g84d5372e0f31) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647d1ac0980f42bab2f5de45

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647d1ac0980f42bab=
2f5de46
        new failure (last pass: v6.1.26-1281-g84d5372e0f31) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647d18bb91d94e9a1bf5de36

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647d18bb91d94e9a1bf5de3f
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-04T23:05:13.995469  + set<8>[   18.162753] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10584280_1.5.2.3.1>

    2023-06-04T23:05:13.995560   +x

    2023-06-04T23:05:14.099875  / # #

    2023-06-04T23:05:14.200665  export SHELL=3D/bin/sh

    2023-06-04T23:05:14.200936  #

    2023-06-04T23:05:14.301517  / # export SHELL=3D/bin/sh. /lava-10584280/=
environment

    2023-06-04T23:05:14.301707  =


    2023-06-04T23:05:14.402212  / # . /lava-10584280/environment/lava-10584=
280/bin/lava-test-runner /lava-10584280/1

    2023-06-04T23:05:14.402522  =


    2023-06-04T23:05:14.407475  / # /lava-10584280/bin/lava-test-runner /la=
va-10584280/1
 =

    ... (12 line(s) more)  =

 =20

