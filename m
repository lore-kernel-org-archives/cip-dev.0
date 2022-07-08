Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D24C433EF
	for <webhook@archiver.kernel.org>; Fri,  8 Jul 2022 23:57:42 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web11.1438.1657324658882330152
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Jul 2022 16:57:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=X4IDM8ZB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.172,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f172.google.com with SMTP id q82so229166pgq.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Jul 2022 16:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Z4R68ai4gfx8mWkQWzzdjp77PZJnBV171jxYEAcMe6Y=;
        b=X4IDM8ZBcWYXrnFl2JFRvjPV5FlbqlYraHKD1+fV6kptwUQLrcoaZYWRy8m39j4bQ1
         //KeV/dNUhDFVxrYXYZEF9WLf9nzHpcoGhlRtDNxYQJfaQDrYARGMGcPQyKZAlOZ14pq
         343lK1TpfY3IHVqto+j8K+dWkN6sXYynjAba4dz3zpxLqs2YU1ZfXF3IL9tg4wJnDd6B
         Xy83VI1ODJZQxuTyxbgtuIkmkU9uw+EoM7FSNz/GJ+2pESSQP3neZqovzhqboZbQsqaM
         hVu2qqi8nOovu9mbVXnka8JdJoEdJinu2HD0VrLMKYUF+5zlWIzms6QrT0v7UFDDBlUy
         uGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Z4R68ai4gfx8mWkQWzzdjp77PZJnBV171jxYEAcMe6Y=;
        b=VFQz9lrL1ajyuD/fTs6UzhVq+NbNndIky9ul8T6dAnzEpWi6by+N/L3OZoznd8BstL
         /nEEAGthv/Q0WoJ6e3p8+3DFuiN8jetnYXYmBhyYx1CybnE4VKBwzJjyIZ6LVRmSOVxQ
         uSaRYk/3TsJkTxHYa/L/GdS2VvdigS9vWSCQ6ACkjnisXWZRfLNK2ea+yQRd+s9C3y5r
         9+XfKty+KaVk7ydhC1Ax9fcA2zfb5mNq7xlpk0H2mjIbkh6GaoHh97hQwMvmJW7enpjm
         vSFQAjRXnGHZInd7PKXwOJYnZ0HKxspg+bF9+X26EH2S6gvkDnP9+/fPV9WlLZ2N1GoM
         L/4w==
X-Gm-Message-State: AJIora+58PpBZw8SZ4GIsLucMd7A6UqVABWXAsT70P1FNhftjr5+PDru
	3jYSqDaFZNiJH0Y4VgJBCXWiU8S7fsrIjEnB
X-Google-Smtp-Source: 
 AGRyM1vWVzqX+UnqJ77NHKXLW3A3UzpMNKN9acxbT07l2C676QQAjT0OSr4J5q0W5SR6De+JB28RXQ==
X-Received: by 2002:a63:5d52:0:b0:412:6eec:7f90 with SMTP id
 o18-20020a635d52000000b004126eec7f90mr5407749pgm.417.1657324658016;
        Fri, 08 Jul 2022 16:57:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 y16-20020a17090264d000b0015e8d4eb26esm87218pli.184.2022.07.08.16.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 16:57:37 -0700 (PDT)
Message-ID: <62c8c471.1c69fb81.b8e0d.02f8@mx.google.com>
Date: Fri, 08 Jul 2022 16:57:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline-nfs: 37 runs,
 3 regressions (v5.10.129-cip12)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Jul 2022 23:57:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8733

cip/linux-5.10.y-cip baseline-nfs: 37 runs, 3 regressions (v5.10.129-cip12)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
jetson-tk1                   | arm   | lab-baylibre  | gcc-10   | tegra_def=
config            | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.129-cip12/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.129-cip12
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      19dd4538e81e4019bc96ac6521af3a4ec93e110c =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
jetson-tk1                   | arm   | lab-baylibre  | gcc-10   | tegra_def=
config            | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8b8622914fdbbbda39bd0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12/arm/tegra_defconfig/gcc-10/lab-baylibre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12/arm/tegra_defconfig/gcc-10/lab-baylibre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62c8b8622914fdbbb=
da39bd1
        failing since 28 days (last pass: v5.10.109-cip5, first fail: v5.10=
.121-cip9) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8bc7c9ce5640cb1a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libr=
etech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libr=
etech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62c8bc7c9ce5640cb=
1a39bce
        new failure (last pass: v5.10.126-cip11) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8bee16327741804a39c08

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/62c8bee16327741804a39c2e
        failing since 101 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2022-07-08T23:33:38.553320  <4>[   37.479445] cdn-dp fec00000.dp: Direc=
t firmware load for rockchip/dptx.bin failed with error -2
    2022-07-08T23:33:38.562580  <4>[   37.489894] cdn-dp fec00000.dp: Falli=
ng back to sysfs fallback for: rockchip/dptx.bin
    2022-07-08T23:33:39.133740  /lava-6783413/1/../bin/lava-test-case
    2022-07-08T23:33:39.172549  <8>[   38.099816] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

