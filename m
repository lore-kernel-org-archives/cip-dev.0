Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D73C46CA3
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 17:19:15 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.41320.1702055946361981547
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Dec 2023 09:19:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=iqD4+iF2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d0521554ddso20137545ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 08 Dec 2023 09:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702055945; x=1702660745; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FgPCLKwfLp46BUCmqgo2VGqQIW2tjmVfXDcOy1Pm7fs=;
        b=iqD4+iF2zi3MZYjM4C5h4ZpnJndMFV0jW5sT5A47EVRNxzDjY7kqMzzPmn8n7bNE4H
         4rK88qYgj+mbpyinvxElI1g9uuY3DcsEzfb6K1T27lFNKyAjWeyIbfEjOjqhFcbCSPJo
         zyMPD02H/OIbseLhV2DXBtqdCguDzVLXLjUnl3BJXreeUgvIQXMWhQ+76ib+oyvhAtUO
         I8OME2vbTFHJl55dWDyVIjKrJxRZaN4rnjbVL4t+MAKhbRidM2C/YuzlaWKgZPgCz5Hf
         MmLSmjvOUsmrfalKJE47Y064azU8QXSgizyFgi/SyTFvyLJFkAIOxpWmSYpL6ZJfyG8v
         V9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702055945; x=1702660745;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgPCLKwfLp46BUCmqgo2VGqQIW2tjmVfXDcOy1Pm7fs=;
        b=bSi6BkbLsrDDSvMMhKjaJKeiy1skXfJtHevz5qNe6mS2/3sz06xqx6LQbX6X7EwQ1g
         s0a4qM90mBc4LYLT6ENgesnFgqMTXVr8Ackjf+4sJESZXwqGMdh8ILTht318WTraGssA
         NAOldiYbENYdvPEXZplXxHxwMX8vlfWOt2/RtjkoHflyos04YZfnHGZV0mXx7iLysE+i
         Dm2SOhePVaYcNBkqeTfjxLVtar3yo7y71FNy1MS2g/xgG7utNkt+ueg8XEVkrxdM/d/X
         kjKfD/qPnVQq55cBK47ruUkRDnYVBeASHdrYV6chjkQ6tH/iJnZBr0PkpEbhc9HsCqk+
         pEgw==
X-Gm-Message-State: AOJu0YyVM0KX7iz5f0GOsqaX+g2raWz68jJGxrd21jUZpNlPygxZQkcn
	CNkqeJ7dBhhdugpLjTCiAgVmutL+sfusXTMe3qVvuQ==
X-Google-Smtp-Source: AGHT+IH6pvMhJrwy/wDvHFXMc1qsGTs6qCrI8abKr8fQmMYyazfP2lfRc/n9CrhgEu2eSDUy3IM0yg==
X-Received: by 2002:a17:902:8696:b0:1cf:51f9:197b with SMTP id g22-20020a170902869600b001cf51f9197bmr380394plo.23.1702055944537;
        Fri, 08 Dec 2023 09:19:04 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t8-20020a1709027fc800b001cfcf430382sm1975125plb.220.2023.12.08.09.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:19:03 -0800 (PST)
Message-ID: <65735007.170a0220.1923a.71f9@mx.google.com>
Date: Fri, 08 Dec 2023 09:19:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-46-g596f4c151d286
Subject: cip/linux-5.10.y-cip baseline: 108 runs,
 19 regressions (v5.10.201-cip41-46-g596f4c151d286)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 17:19:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13975

cip/linux-5.10.y-cip baseline: 108 runs, 19 regressions (v5.10.201-cip41-46=
-g596f4c151d286)

Regressions Summary
-------------------

platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
at91sam9g20ek            | arm   | lab-broonie     | gcc-10   | multi_v5_de=
fconfig           | 1          =

bcm2836-rpi-2-b          | arm   | lab-collabora   | gcc-10   | bcm2835_def=
config            | 1          =

imx6q-sabrelite          | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig           | 1          =

imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_d=
efconfig          | 1          =

imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | multi_v7_de=
fconfig           | 1          =

juno-uboot               | arm64 | lab-broonie     | gcc-10   | cip://5.10.=
y-...64_defconfig | 1          =

juno-uboot               | arm64 | lab-broonie     | gcc-10   | defconfig  =
                  | 1          =

juno-uboot               | arm64 | lab-broonie     | gcc-10   | defconfig+k=
selftest          | 1          =

r8a7743-iwg20d-q7        | arm   | lab-cip         | gcc-10   | shmobile_de=
fconfig           | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig  =
                  | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig+k=
selftest          | 1          =

r8a774c0-ek874           | arm64 | lab-cip         | gcc-10   | defconfig  =
                  | 1          =

r8a77960-ulcb            | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =

rk3288-veyron-jaq        | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig           | 4          =

rk3399-rock-pi-4b        | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =

sun50i-h6-pine-h64       | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-46-g596f4c151d286/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-46-g596f4c151d286
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      596f4c151d286c71a3612a2120ab33f4ac885d2e =



Test Regressions
---------------- =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
at91sam9g20ek            | arm   | lab-broonie     | gcc-10   | multi_v5_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/657346395852e86459e134e7

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657346395852e86459e13520
        failing since 328 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-08T16:36:37.079005  + set +x
    2023-12-08T16:36:37.079522  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 326582_1.5.2=
.4.1>
    2023-12-08T16:36:37.192292  / # #
    2023-12-08T16:36:37.295433  export SHELL=3D/bin/sh
    2023-12-08T16:36:37.296233  #
    2023-12-08T16:36:37.398240  / # export SHELL=3D/bin/sh. /lava-326582/en=
vironment
    2023-12-08T16:36:37.399027  =

    2023-12-08T16:36:37.501068  / # . /lava-326582/environment/lava-326582/=
bin/lava-test-runner /lava-326582/1
    2023-12-08T16:36:37.502511  =

    2023-12-08T16:36:37.505984  / # /lava-326582/bin/lava-test-runner /lava=
-326582/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora   | gcc-10   | bcm2835_def=
config            | 1          =


  Details:     https://kernelci.org/test/plan/id/65734505a0ce62ba76e13484

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm/bcm2835_defconfig/gcc-10/lab-collabora/baselin=
e-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm/bcm2835_defconfig/gcc-10/lab-collabora/baselin=
e-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65734505a0ce62ba76e1348d
        failing since 135 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-12-08T16:39:22.011183  / # #

    2023-12-08T16:39:22.113390  export SHELL=3D/bin/sh

    2023-12-08T16:39:22.114094  #

    2023-12-08T16:39:22.215563  / # export SHELL=3D/bin/sh. /lava-12221368/=
environment

    2023-12-08T16:39:22.216276  =


    2023-12-08T16:39:22.317787  / # . /lava-12221368/environment/lava-12221=
368/bin/lava-test-runner /lava-12221368/1

    2023-12-08T16:39:22.318912  =


    2023-12-08T16:39:22.335499  / # /lava-12221368/bin/lava-test-runner /la=
va-12221368/1

    2023-12-08T16:39:22.399288  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-08T16:39:22.442363  + cd /lava-12221368/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
imx6q-sabrelite          | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6573495003aad03fd6e1348c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573495003aad03fd6e13495
        failing since 328 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-08T16:50:18.502078  / # #

    2023-12-08T16:50:18.604835  export SHELL=3D/bin/sh

    2023-12-08T16:50:18.605740  #

    2023-12-08T16:50:18.707507  / # export SHELL=3D/bin/sh. /lava-12221417/=
environment

    2023-12-08T16:50:18.708378  =


    2023-12-08T16:50:18.810140  / # . /lava-12221417/environment/lava-12221=
417/bin/lava-test-runner /lava-12221417/1

    2023-12-08T16:50:18.811788  =


    2023-12-08T16:50:18.825257  / # /lava-12221417/bin/lava-test-runner /la=
va-12221417/1

    2023-12-08T16:50:18.963220  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-08T16:50:18.963808  + cd /lava-12221417/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | imx_v6_v7_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/657347434e3eb1d344e1349b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657347434e3eb1d344e134a4
        failing since 328 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-08T16:41:13.733469  + set +x
    2023-12-08T16:41:13.733641  [   10.366530] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1015858_1.5.2.3.1>
    2023-12-08T16:41:13.841069  / # #
    2023-12-08T16:41:13.942403  export SHELL=3D/bin/sh
    2023-12-08T16:41:13.942919  #
    2023-12-08T16:41:14.043776  / # export SHELL=3D/bin/sh. /lava-1015858/e=
nvironment
    2023-12-08T16:41:14.044278  =

    2023-12-08T16:41:14.145077  / # . /lava-1015858/environment/lava-101585=
8/bin/lava-test-runner /lava-1015858/1
    2023-12-08T16:41:14.145732  =

    2023-12-08T16:41:14.148957  / # /lava-1015858/bin/lava-test-runner /lav=
a-1015858/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
imx6qp-wandboard-revd1   | arm   | lab-pengutronix | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6573493725ec3d8943e134c1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573493725ec3d8943e134ca
        failing since 328 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-08T16:49:35.551428  + set[    7.330412] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1015862_1.5.2.3.1>
    2023-12-08T16:49:35.551632   +x
    2023-12-08T16:49:35.656585  / # #
    2023-12-08T16:49:35.757626  export SHELL=3D/bin/sh
    2023-12-08T16:49:35.758116  #
    2023-12-08T16:49:35.858862  / # export SHELL=3D/bin/sh. /lava-1015862/e=
nvironment
    2023-12-08T16:49:35.859302  =

    2023-12-08T16:49:35.960059  / # . /lava-1015862/environment/lava-101586=
2/bin/lava-test-runner /lava-1015862/1
    2023-12-08T16:49:35.960633  =

    2023-12-08T16:49:35.963262  / # /lava-1015862/bin/lava-test-runner /lav=
a-1015862/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
juno-uboot               | arm64 | lab-broonie     | gcc-10   | cip://5.10.=
y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65734a5c14660cf43ce13494

  Results:     47 PASS, 13 FAIL, 1 SKIP
  Full config: cip://5.10.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/=
gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/=
gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65734a5c14660cf43ce134d3
        failing since 102 days (last pass: v5.10.186-cip37-27-gd6d928db0a62=
0, first fail: v5.10.191-cip38)

    2023-12-08T16:54:24.761406  / # #
    2023-12-08T16:54:24.864461  export SHELL=3D/bin/sh
    2023-12-08T16:54:24.865251  #
    2023-12-08T16:54:24.967284  / # export SHELL=3D/bin/sh. /lava-326671/en=
vironment
    2023-12-08T16:54:24.968051  =

    2023-12-08T16:54:25.070154  / # . /lava-326671/environment/lava-326671/=
bin/lava-test-runner /lava-326671/1
    2023-12-08T16:54:25.071556  =

    2023-12-08T16:54:25.084535  / # /lava-326671/bin/lava-test-runner /lava=
-326671/1
    2023-12-08T16:54:25.141304  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-08T16:54:25.141819  + cd /lava-326671/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
juno-uboot               | arm64 | lab-broonie     | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65734868530729218de134ed

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-u=
boot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-u=
boot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65734868530729218de1352d
        failing since 1 day (last pass: v5.10.201-cip41-11-ga539098fe70dd, =
first fail: v5.10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T16:46:00.108441  / # #
    2023-12-08T16:46:00.211186  export SHELL=3D/bin/sh
    2023-12-08T16:46:00.211934  #
    2023-12-08T16:46:00.313795  / # export SHELL=3D/bin/sh. /lava-326599/en=
vironment
    2023-12-08T16:46:00.314581  =

    2023-12-08T16:46:00.416492  / # . /lava-326599/environment/lava-326599/=
bin/lava-test-runner /lava-326599/1
    2023-12-08T16:46:00.417706  =

    2023-12-08T16:46:00.432521  / # /lava-326599/bin/lava-test-runner /lava=
-326599/1
    2023-12-08T16:46:00.490289  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-08T16:46:00.490792  + cd /lava-326599/1/tests/1_bootrr =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
juno-uboot               | arm64 | lab-broonie     | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6573496c0cfef381a8e134a1

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573496c0cfef381a8e134e1
        failing since 135 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-12-08T16:50:15.925834  <8>[   18.059231] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 326659_1.5.2.4.1>
    2023-12-08T16:50:16.035130  / # #
    2023-12-08T16:50:16.138134  export SHELL=3D/bin/sh
    2023-12-08T16:50:16.138955  #
    2023-12-08T16:50:16.240927  / # export SHELL=3D/bin/sh. /lava-326659/en=
vironment
    2023-12-08T16:50:16.241728  =

    2023-12-08T16:50:16.343719  / # . /lava-326659/environment/lava-326659/=
bin/lava-test-runner /lava-326659/1
    2023-12-08T16:50:16.345067  =

    2023-12-08T16:50:16.357282  / # /lava-326659/bin/lava-test-runner /lava=
-326659/1
    2023-12-08T16:50:16.538943  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a7743-iwg20d-q7        | arm   | lab-cip         | gcc-10   | shmobile_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/657342e1d52f12cd88e1348a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657342e1d52f12cd88e13=
48b
        failing since 0 day (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d, =
first fail: v5.10.201-cip41-28-ga386bc478aa6b) =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/657348679a22376201e13497

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-h=
ihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-h=
ihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657348679a22376201e134a0
        failing since 121 days (last pass: v5.10.182-cip35-1-g7cde3fba93966=
, first fail: v5.10.186-cip37-13-g260094841fe1a)

    2023-12-08T16:46:08.304691  + set +x
    2023-12-08T16:46:08.307906  <8>[   83.984134] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1054906_1.5.2.4.1>
    2023-12-08T16:46:08.416627  / # #
    2023-12-08T16:46:09.874446  export SHELL=3D/bin/sh
    2023-12-08T16:46:09.894974  #
    2023-12-08T16:46:09.895247  / # export SHELL=3D/bin/sh
    2023-12-08T16:46:11.843260  / # . /lava-1054906/environment
    2023-12-08T16:46:15.426797  /lava-1054906/bin/lava-test-runner /lava-10=
54906/1
    2023-12-08T16:46:15.447671  . /lava-1054906/environment
    2023-12-08T16:46:15.447881  / # /lava-1054906/bin/lava-test-runner /lav=
a-1054906/1 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip         | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/657349572d3de48388e1347b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657349572d3de48388e13484
        failing since 121 days (last pass: v5.10.182-cip35, first fail: v5.=
10.186-cip37-13-g260094841fe1a)

    2023-12-08T16:50:00.070812  + set +x
    2023-12-08T16:50:00.073966  <8>[   87.746601] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1054914_1.5.2.4.1>
    2023-12-08T16:50:00.186839  / # #
    2023-12-08T16:50:01.644809  export SHELL=3D/bin/sh
    2023-12-08T16:50:01.665561  #
    2023-12-08T16:50:01.665967  / # export SHELL=3D/bin/sh
    2023-12-08T16:50:03.615017  / # . /lava-1054914/environment
    2023-12-08T16:50:07.200012  /lava-1054914/bin/lava-test-runner /lava-10=
54914/1
    2023-12-08T16:50:07.221291  . /lava-1054914/environment
    2023-12-08T16:50:07.221632  / # /lava-1054914/bin/lava-test-runner /lav=
a-1054914/1 =

    ... (27 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a774c0-ek874           | arm64 | lab-cip         | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/657348f900b58d0710e134ac

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-e=
k874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-e=
k874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657348f900b58d0710e134b5
        failing since 135 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-12-08T16:48:31.899327  / # #
    2023-12-08T16:48:33.357963  export SHELL=3D/bin/sh
    2023-12-08T16:48:33.378968  #
    2023-12-08T16:48:33.379469  / # export SHELL=3D/bin/sh
    2023-12-08T16:48:35.328911  / # . /lava-1054904/environment
    2023-12-08T16:48:38.915079  /lava-1054904/bin/lava-test-runner /lava-10=
54904/1
    2023-12-08T16:48:38.936637  . /lava-1054904/environment
    2023-12-08T16:48:38.936994  / # /lava-1054904/bin/lava-test-runner /lav=
a-1054904/1
    2023-12-08T16:48:39.012788  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-08T16:48:39.013311  + cd /lava-1054904/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
r8a77960-ulcb            | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/657346a905c6bb1d56e13496

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7=
7960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7=
7960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657346a905c6bb1d56e1349f
        failing since 135 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-12-08T16:46:29.898860  / # #

    2023-12-08T16:46:29.999327  export SHELL=3D/bin/sh

    2023-12-08T16:46:29.999450  #

    2023-12-08T16:46:30.099894  / # export SHELL=3D/bin/sh. /lava-12221382/=
environment

    2023-12-08T16:46:30.100023  =


    2023-12-08T16:46:30.200531  / # . /lava-12221382/environment/lava-12221=
382/bin/lava-test-runner /lava-12221382/1

    2023-12-08T16:46:30.200735  =


    2023-12-08T16:46:30.212543  / # /lava-12221382/bin/lava-test-runner /la=
va-12221382/1

    2023-12-08T16:46:30.266144  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-08T16:46:30.266226  + cd /lav<8>[   16.401699] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12221382_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
rk3288-veyron-jaq        | arm   | lab-collabora   | gcc-10   | multi_v7_de=
fconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/6573495103aad03fd6e13499

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/6573495103aad03fd6e134cc
        failing since 326 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-08T16:57:36.591411  FIRST,<8>[   20.911909] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-12-08T16:57:36.593070   INC default to 1.

    2023-12-08T16:57:36.593876  =


    2023-12-08T16:57:36.596811  	-w	Pad to last with leading zeros

    2023-12-08T16:57:36.599318  	-s SEP	String separator

    2023-12-08T16:57:36.603228  /lava-12221412/1/../bin/lava-test-case

    2023-12-08T16:57:36.609218  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-12-08T16:57:36.609477  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6573495103aad03fd6e134cd
        failing since 326 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-08T16:57:36.568945  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   20.892946] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-12-08T16:57:36.570988   multi-call binary.

    2023-12-08T16:57:36.571041  =


    2023-12-08T16:57:36.575426  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-12-08T16:57:36.575513  =


    2023-12-08T16:57:36.580877  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6573495103aad03fd6e134ce
        failing since 326 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-08T16:57:36.550077  <8>[   20.875319] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6573495103aad03fd6e134e2
        failing since 326 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-08T16:57:24.501324  + <8>[    8.829134] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 12221412_1.5.2.3.1>

    2023-12-08T16:57:24.503929  set +x

    2023-12-08T16:57:24.607147  #

    2023-12-08T16:57:24.709107  / # #export SHELL=3D/bin/sh

    2023-12-08T16:57:24.709722  =


    2023-12-08T16:57:24.810801  / # export SHELL=3D/bin/sh. /lava-12221412/=
environment

    2023-12-08T16:57:24.811436  =


    2023-12-08T16:57:24.912513  / # . /lava-12221412/environment/lava-12221=
412/bin/lava-test-runner /lava-12221412/1

    2023-12-08T16:57:24.913545  =


    2023-12-08T16:57:24.914865  / # /lava-12221412/bin/lava-test-runner /la=
va-12221412/1
 =

    ... (18 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/657346eb1e2b7db320e1349a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-collabora/baseline-rk33=
99-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-collabora/baseline-rk33=
99-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657346eb1e2b7db320e134a3
        failing since 80 days (last pass: v5.10.191-cip38-29-g9e1aa2001db8,=
 first fail: v5.10.194-cip39)

    2023-12-08T16:39:42.711765  / # #

    2023-12-08T16:39:43.972512  export SHELL=3D/bin/sh

    2023-12-08T16:39:43.983484  #

    2023-12-08T16:39:43.983997  / # export SHELL=3D/bin/sh

    2023-12-08T16:39:45.728037  / # . /lava-12221380/environment

    2023-12-08T16:39:48.933139  /lava-12221380/bin/lava-test-runner /lava-1=
2221380/1

    2023-12-08T16:39:48.944550  . /lava-12221380/environment

    2023-12-08T16:39:48.946852  / # /lava-12221380/bin/lava-test-runner /la=
va-12221380/1

    2023-12-08T16:39:48.999814  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-08T16:39:49.000317  + cd /lava-12221380/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig  =
                  | regressions
-------------------------+-------+-----------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64       | arm64 | lab-collabora   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/657346bc05c6bb1d56e13510

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-collabora/baseline-sun5=
0i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-collabora/baseline-sun5=
0i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657346bd05c6bb1d56e13519
        failing since 135 days (last pass: v5.10.184-cip36-13-g8fae18103387=
, first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-12-08T16:46:45.416565  / # #

    2023-12-08T16:46:45.518687  export SHELL=3D/bin/sh

    2023-12-08T16:46:45.519400  #

    2023-12-08T16:46:45.620851  / # export SHELL=3D/bin/sh. /lava-12221378/=
environment

    2023-12-08T16:46:45.621561  =


    2023-12-08T16:46:45.722920  / # . /lava-12221378/environment/lava-12221=
378/bin/lava-test-runner /lava-12221378/1

    2023-12-08T16:46:45.724018  =


    2023-12-08T16:46:45.740935  / # /lava-12221378/bin/lava-test-runner /la=
va-12221378/1

    2023-12-08T16:46:45.784836  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-08T16:46:45.799730  + cd /lava-1222137<8>[   18.145670] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12221378_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

