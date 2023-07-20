Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D182FEB64DA
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 12:48:05 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.12025.1689857283559735399
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Jul 2023 05:48:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=BFZQEC/g;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1b9cd6a0051so4668575ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Jul 2023 05:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689857282; x=1690462082;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6yLTROPCbyJsPDqXWpKpK+EiGwZe5WwIptgbB4B9vuQ=;
        b=BFZQEC/gPbKgbfa3X8CKo1aQFmUxm9Q07waosEmRPWkh2IZ8PMdQwpjQb1TQkmA8GO
         rxyaK4GeADYHLte382yOEDGOawA7ez6VK8tJZc+q0yiGLRqU27EZir2PHJWDZSQoWTdz
         tttJXGr1O4eHm9sGj0q+Rs2aywOlS0slNSm8ZLP6nlW3BFESYgIZlrBA0YrBdlNnO+Tk
         NUZ0HBl/Yp3RlVrEU/ZNEPITrlXPl+tNBqYbHr7A6xYmGKGCxYBjIcBbGeqwdwHViKgl
         Mxh71isXPLCdGdFfQnO+r4M+x+bWBShXUq9N2ZZ5mcYizft45t/+AuW1r90+/MQeObc3
         Kmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689857282; x=1690462082;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6yLTROPCbyJsPDqXWpKpK+EiGwZe5WwIptgbB4B9vuQ=;
        b=Q5vVKVR5n9pryGCZ1zI+lDVdfxLU63dlAizZtn9UWiCVY3ytm/I4yz+xMlgQkUDBef
         UvlJ84sDTZkfyErMINbUwMcVmxLxY8BLgMcmIXYSU7AODTATgOT+SzlKkl3JTpdXLF3/
         J9OvVvL8K7+KBrbnaHu7eOwTWgtBCkDd99o9Fgoow66p31+zueaWAYb01ggk+23tbIwK
         kGs31gfidrLEZQrRJnPv9vo0lGkejKFhHy10JMpXZ/kThMETpyvjoysuiprYnWEf4op+
         zboGh3BBnLT1GbJWxBy9TbxKVsfkamgFo0MrVKtAwM7/x3t5HPG/BwOSA6mLQXqRVcmU
         G1Eg==
X-Gm-Message-State: ABy/qLbdY3zhMUwwC8QQrJ1W8FK8qz7fsLPBay+Ik8KaNzIFQ5YxUiY7
	vx2th/+Y5wryrECAvn/RlI2sbaJ6djVAhjM22Jy2Mw==
X-Google-Smtp-Source: APBJJlHwpT+NIhHsD9G7Cd53ecnnsicsSyo3funCVU6dnqPW6avqn/YQR6cyhsWr6wGt8NWwQmeX8A==
X-Received: by 2002:a17:902:9896:b0:1b7:e646:4cc4 with SMTP id s22-20020a170902989600b001b7e6464cc4mr6632974plp.28.1689857282528;
        Thu, 20 Jul 2023 05:48:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902bd0400b001ab2b4105ddsm1276620pls.60.2023.07.20.05.48.01
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 05:48:01 -0700 (PDT)
Message-ID: <64b92d01.170a0220.90e16.1b3e@mx.google.com>
Date: Thu, 20 Jul 2023 05:48:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.38-cip1-13-ga3621452a4fc
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 7 runs,
 3 regressions (v6.1.38-cip1-13-ga3621452a4fc)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 12:48:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12467

cip-gitlab/ci/pavel/linux-test baseline-nfs: 7 runs, 3 regressions (v6.1.38=
-cip1-13-ga3621452a4fc)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =

beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =

imx6q-udoo       | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.38-cip1-13-ga3621452a4fc/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.38-cip1-13-ga3621452a4fc
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a3621452a4fc3c78df12c07b61aa0b03d9af5fec =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/64b9227df0053f023f8ace39

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/omap2plus_defconfig/gcc-10/lab-broonie/b=
aseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/omap2plus_defconfig/gcc-10/lab-broonie/b=
aseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b9227df0053f023f8ace69
        failing since 35 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-20T12:02:55.156548  <8>[   46.269820] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 2891_1.6.2.4.1>
    2023-07-20T12:02:55.275698  / # #
    2023-07-20T12:02:55.378328  export SHELL=3D/bin/sh
    2023-07-20T12:02:55.378969  #
    2023-07-20T12:02:55.481041  / # export SHELL=3D/bin/sh. /lava-2891/envi=
ronment
    2023-07-20T12:02:55.481727  =

    2023-07-20T12:02:55.583801  / # . /lava-2891/environment/lava-2891/bin/=
lava-test-runner /lava-2891/1
    2023-07-20T12:02:55.584942  =

    2023-07-20T12:02:55.588588  / # /lava-2891/bin/lava-test-runner /lava-2=
891/1
    2023-07-20T12:02:55.882909  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/64b923927f9d7d6c638ace23

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/omap2plus_defconfig/gcc-10/lab-cip/basel=
ine-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/omap2plus_defconfig/gcc-10/lab-cip/basel=
ine-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b923927f9d7d6c638ace26
        failing since 35 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-20T12:07:30.839343  + set +x
    2023-07-20T12:07:30.841434  <8>[   40.119992] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 987847_1.6.2.4.1>
    2023-07-20T12:07:30.955876  #
    2023-07-20T12:07:31.057219  / # #export SHELL=3D/bin/sh
    2023-07-20T12:07:31.057438  =

    2023-07-20T12:07:31.158251  / # export SHELL=3D/bin/sh. /lava-987847/en=
vironment
    2023-07-20T12:07:31.158461  =

    2023-07-20T12:07:31.259490  / # . /lava-987847/environment/lava-987847/=
bin/lava-test-runner /lava-987847/1
    2023-07-20T12:07:31.260037  =

    2023-07-20T12:07:31.262062  / # /lava-987847/bin/lava-test-runner /lava=
-987847/1 =

    ... (12 line(s) more)  =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
imx6q-udoo       | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/64b9236d7f9d7d6c638ace1c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/b=
aseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-13-ga3621452a4fc/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/b=
aseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64b9236d7f9d7d6c6=
38ace1d
        failing since 8 days (last pass: v6.1.31-65-geef5a19d48f6, first fa=
il: v5.10.184-cip36-13-g8201543bbc8b6) =

 =20

