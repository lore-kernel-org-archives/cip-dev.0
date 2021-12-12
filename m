X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.589.1639330483924290682
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 12 Dec 2021 09:34:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=t58YzbFT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id y7so9680114plp.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 12 Dec 2021 09:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=RoANLb+OgFpD6LUqL/gjjN4eSf+fi2l05vEg+gXnbyM=;
        b=t58YzbFTYhGubQ61jzD6DFovswHyELwiwbRNAAf9XhKtDKdS7ohxOlH+KyLMOzy6Mv
         GgQpI41tOBojT/4IxuNDkVsEXZJzwmYGXjuUUhiv5VXs88aeZjH5Sokqf6TtOfPexQ0m
         gKjvrk9NoYzaWDq+zFj3GdINNsSldgcZEZ3lifOS6i6SeCqC991ejMcRYWpGuTAcTMPP
         KKNuzrL/N5wQmjxw6lirCm4aXPVp3qmjUeQ7a40WKYEucLQ+CPO5Qh/lc2GkI0wdRK1B
         y3h3qdDfo5DdyMOo8zQFHun1jSR7ElOV4BFQRToqSfaB/U4ECR8MS68mzSWG1KEbdqoh
         iFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=RoANLb+OgFpD6LUqL/gjjN4eSf+fi2l05vEg+gXnbyM=;
        b=T1NXMgCtVi60eHRQcuelN4DxQGK3/nK9n/Y+p0N+HNHw9zAFp7xq1Sy3hEIUHaG8mG
         AUuxRFhdvDm9fQq+FLVKJ7OJ7dGLQ08LOX0jdgYqR9fW8N4FfWXNMh7f5mvWoJN2Qros
         gPm4m/Aju9yLeZToNNSwqnIxvrfjwMHq9wbz1DI1aNu6fmi4OaKe4JdJ4LLhd3ZBx/no
         iLFPprDmOgWJ9ghyiDLI/inlErnBmeL3z9OoRQHaGNdXukTRgFw5gnclfH57z22nTAr3
         sdH70vRnRoaMDsgBjgrazQNwAcUYxK4KdM8OhKjN6o+o3X9aqwhTt+obLACkTlUez3dE
         FYCA==
X-Gm-Message-State: AOAM53130tH8VWG/vQkMjwCcHoT4AeGJO1cPoq5Q8VwTJB9kIXHXcK+T
	GSHB+XS740SyRcN4qOZD+2ukThKDPKL9YwGU
X-Google-Smtp-Source: ABdhPJzKKo5dxH6yvJMTxToJ+uLY6QOb5b5s+sJmgWaR3QEqFsJrlCy4cmWn5xbiR3TS7aPbBRWRHw==
X-Received: by 2002:a17:902:d34d:b0:143:c927:dc48 with SMTP id l13-20020a170902d34d00b00143c927dc48mr90397682plk.71.1639330483283;
        Sun, 12 Dec 2021 09:34:43 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f8sm9631181pfv.135.2021.12.12.09.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 09:34:43 -0800 (PST)
Message-ID: <61b632b3.1c69fb81.e673b.b195@mx.google.com>
Date: Sun, 12 Dec 2021 09:34:43 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Kernel: v4.4.294-cip66
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip baseline: 102 runs, 2 regressions (v4.4.294-cip66) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.4.y-cip baseline: 102 runs, 2 regressions (v4.4.294-cip66)

Regressions Summary
-------------------

platform  | arch | lab          | compiler | defconfig           | regressi=
ons
----------+------+--------------+----------+---------------------+---------=
---
beagle-xm | arm  | lab-baylibre | gcc-10   | omap2plus_defconfig | 2       =
   =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.294-cip66/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.294-cip66
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f8a9792915e8ad9f417a6431735e953e944713c7 =



Test Regressions
---------------- =



platform  | arch | lab          | compiler | defconfig           | regressi=
ons
----------+------+--------------+----------+---------------------+---------=
---
beagle-xm | arm  | lab-baylibre | gcc-10   | omap2plus_defconfig | 2       =
   =


  Details:     https://kernelci.org/test/plan/id/61b624d88cf5d87a1b397160

  Results:     3 PASS, 2 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.294-c=
ip66/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.294-c=
ip66/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/61b624d88cf5d87a=
1b397163
        new failure (last pass: v4.4.291-cip65)
        1 lines

    2021-12-12T16:35:17.876920  / # =

    2021-12-12T16:35:17.877955  #
    2021-12-12T16:35:17.982598  / # #
    2021-12-12T16:35:17.983497  =

    2021-12-12T16:35:18.085106  / # #export SHELL=3D/bin/sh
    2021-12-12T16:35:18.085643  =

    2021-12-12T16:35:18.186941  / # export SHELL=3D/bin/sh. /lava-1231327/e=
nvironment
    2021-12-12T16:35:18.187444  =

    2021-12-12T16:35:18.288967  / # . /lava-1231327/environment/lava-123132=
7/bin/lava-test-runner /lava-1231327/0
    2021-12-12T16:35:18.290631   =

    ... (10 line(s) more)  =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/61b624d88cf5d87=
a1b397165
        new failure (last pass: v4.4.291-cip65)
        29 lines

    2021-12-12T16:35:18.752528  [   49.458831] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dalert RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2021-12-12T16:35:18.807403  kern  :emerg : Internal error: Oops - BUG: =
0 [#1] SMP ARM
    2021-12-12T16:35:18.810742  kern  :emerg : Process udevd (pid: 110, sta=
ck limit =3D 0xcb942218)
    2021-12-12T16:35:18.815236  kern  :emerg : Stack: (0xcb943cf8 to 0xcb94=
4000)
    2021-12-12T16:35:18.823759  kern  :emerg : 3ce0:                       =
                                bf02bdc4 60000013   =

 =20

