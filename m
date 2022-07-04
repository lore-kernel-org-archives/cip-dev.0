Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E565C43334
	for <webhook@archiver.kernel.org>; Mon,  4 Jul 2022 07:52:49 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web08.69641.1656921165209930349
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 00:52:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=YDthZjZX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id
 o5-20020a17090a3d4500b001ef76490983so4246676pjf.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 00:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=qi0mfVoipceUN03E2syVA70Tsp3twbRpbeKwyX2fYQI=;
        b=YDthZjZX8AblCCTvhbMj394nhbSORrjF/Ryg63AebfM6Czbdgyz5WHJCrY8jVVGamn
         9fVj3BMu43bayral6r3qQEHYXTAmd3i5yHrjooEHeFJpzfduSVxv7PRt+p31dG00eWCy
         RBHe45e+K1AsL2OVjm9OT+fmFp0PoFvo8vUMlo4PriqGjojntpoYrmhIo4NMueAkTdy4
         ytB6pZ5KNPEGr4rXiuye6CyMPSeg3eHBIGcHVB1fHHtFVKKt1Y2AvmxCfNvD8eu4ixrp
         PjI0fr3Oz6DBzclBMjnk3OMYyHZJj1DV1jqxk4vUPzuBMTHiLOfJAgWygltat+r8DicU
         4bzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=qi0mfVoipceUN03E2syVA70Tsp3twbRpbeKwyX2fYQI=;
        b=79/n8oi6fes19QDq5QIu4wU+mePf9Yvub4IvLkK52rBxxnzghTlK4uaNRztBokjiVO
         5fN3sBXyp+RKIR6r1GPbDgQjW8VgoD7Rf7kz4yx1yvYkGWN/jQlbdNHWTFSAYll1NJ20
         0FumJpz2rt0W/vMjYNI/02veWHqbFwANZq0LZATwBicwDDf8koDdcpTlGHedlKZm5QsD
         079fGLwqdpptdaGNJKg94ygM5+Lh8P1Dz1Amxu6qzDR7qlvFHpY4gu5osRI7fjUosZtq
         ppib9I1TAvmyNvz2BSG9kWibyegyjTQN9fI07qnLc0nNwEA5JsIH9WrX8FpZPhmuNlRO
         Ifjg==
X-Gm-Message-State: AJIora8/yX9OYHCsRyxgm7+2Rw1btfLzECqYkdsGDTTPL8kffgESbdzV
	VS/rFNCfCatRIQuf9GrEWRnAvMedO+zrN15p
X-Google-Smtp-Source: 
 AGRyM1tCOtL8Cn9u9uoe3+ah8y5bC7qDCFQaHyilvSQEx05NXB3H/HJfowrUpRobX3IdByqBi6XQew==
X-Received: by 2002:a17:902:b087:b0:16b:d6f9:6bc0 with SMTP id
 p7-20020a170902b08700b0016bd6f96bc0mr9822609plr.34.1656921164586;
        Mon, 04 Jul 2022 00:52:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 n12-20020a654ccc000000b0041175e3ad46sm10349031pgt.32.2022.07.04.00.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 00:52:44 -0700 (PDT)
Message-ID: <62c29c4c.1c69fb81.57906.f006@mx.google.com>
Date: Mon, 04 Jul 2022 00:52:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.126-cip11
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline-nfs: 52 runs,
 4 regressions (v5.10.126-cip11)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Jul 2022 07:52:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8645

cip/linux-5.10.y-cip baseline-nfs: 52 runs, 4 regressions (v5.10.126-cip11)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
jetson-tk1                   | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =

jetson-tk1                   | arm   | lab-baylibre  | gcc-10   | tegra_def=
config            | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.126-cip11/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.126-cip11
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      400500e48ef52304feac8a819c6c911660ce59d8 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
jetson-tk1                   | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/62c291a32e1f80de00a39bce

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-nfs-jetson-tk1.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-nfs-jetson-tk1.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62c291a32e1f80de0=
0a39bcf
        failing since 23 days (last pass: v5.10.106-cip4, first fail: v5.10=
.121-cip9) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
jetson-tk1                   | arm   | lab-baylibre  | gcc-10   | tegra_def=
config            | 1          =


  Details:     https://kernelci.org/test/plan/id/62c28fc64d76c2feaea39bdc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/arm/tegra_defconfig/gcc-10/lab-baylibre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/arm/tegra_defconfig/gcc-10/lab-baylibre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62c28fc64d76c2fea=
ea39bdd
        failing since 23 days (last pass: v5.10.109-cip5, first fail: v5.10=
.121-cip9) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62c292a695fab52b25a39bec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson-gxl-s905x-lib=
retech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson-gxl-s905x-lib=
retech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62c292a695fab52b2=
5a39bed
        new failure (last pass: v5.10.125-cip10) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c29247f1d17ed930a39bcf

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.126=
-cip11/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/62c29247f1d17ed930a39bf1
        failing since 96 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.106-cip4)

    2022-07-04T07:09:49.754493  <8>[   96.644267] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-07-04T07:09:50.787002  /lava-6743767/1/../bin/lava-test-case
    2022-07-04T07:09:50.816822  <8>[   97.707311] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

