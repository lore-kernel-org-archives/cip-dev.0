Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39216C4332F
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 22:07:24 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web12.206.1668031638513408938
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 09 Nov 2022 14:07:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=6rYJruQt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso3229500pjc.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 09 Nov 2022 14:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KRSOF7+VPb6SEPM2lAcsH59E+QFhr9ulnZBxS3btecM=;
        b=6rYJruQtAl0y4ffNFuoA2HDhwFM34dcbE2sfQU5Fd09tu2c3odB/+lTAezILrqd5eb
         lV5mFrB2rPFNj5N13Qz67ZuKx9b6pxTcGmZ6KwzWCZxtpfio7RBdDNgzc7PEM1fhIU8H
         5Jol6xEYaXKf/GyKS5XxyUCvXLHBR8hzpdeVVb8tgO6NkvKt9ZXnOBJHcTmb3AZkru1k
         GTyzE9D+obpMHSa48Ben0sxXaFGu2cr3H8fndK5PBmjf4DNXFADVXLErCHmoYkdGOPzS
         9uSV9avEnPcYuZxrKfxykEZN6IH7URwreja2bfcZCipGtgVwn5LpQVCdVDGNsE7hE11c
         rNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRSOF7+VPb6SEPM2lAcsH59E+QFhr9ulnZBxS3btecM=;
        b=axXsvrAQm6mES4C3ycu/ySHgQvKy666+6C7ocCH3EP1pdhfk88iGIew+FTbWN0bXPT
         DKxX5D7CwWZEd32sWp8GzRyRumwFyv2/FNMEcj17V+XAf9IZsfh2fPu+sk4rhl8FN7F7
         3zu17HPvZ0TkEOo8BRRmNXDRR2d6Q+yaogDZaTBUl6GAX4Sv/+0XswZBV9oP7ZB1pa3F
         HQg1MYDmcCVFXusGm9xcKK413ktI31Yvy5IWohUroE4klHn1AAJAvLTBhoCSS2dca1v8
         MMHfuTZitOCgjU0gxFIZvNCbHcYHoc8QyuJLbW6nFMJFVd6eAlFEIgK326QCthvunjQz
         BPdg==
X-Gm-Message-State: ACrzQf1hQHcRltlAMOPefwQjeGXJgxktjS0+VZW5UlnaQSdtPH5slAQ5
	b59iML5M5vhA7INbSvqB0DDffhN1z9QHFMrDbKw=
X-Google-Smtp-Source: AMsMyM418nbiVkYwzUlVYYfI1K6Z7EXcU/PQgRCjywikHaG9PA5Wa389HrL4frW0+DDj/NfOmLWcJg==
X-Received: by 2002:a17:902:b68b:b0:186:aee0:53ec with SMTP id c11-20020a170902b68b00b00186aee053ecmr63842979pls.90.1668031637785;
        Wed, 09 Nov 2022 14:07:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t13-20020a170902e84d00b0017849a2b56asm9699287plg.46.2022.11.09.14.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:07:17 -0800 (PST)
Message-ID: <636c2495.170a0220.43674.04ff@mx.google.com>
Date: Wed, 09 Nov 2022 14:07:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19-3-gc76f4e7e5c71
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline-nfs: 37 runs,
 4 regressions (v5.10.153-cip19-3-gc76f4e7e5c71)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 22:07:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9970

cip/linux-5.10.y-cip baseline-nfs: 37 runs, 4 regressions (v5.10.153-cip19-=
3-gc76f4e7e5c71)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.153-cip19-3-gc76f4e7e5c71/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.153-cip19-3-gc76f4e7e5c71
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c76f4e7e5c7160107c9b5d8ec188f61fe326cec3 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/636c1d694d62e1887de7db91

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19-3-gc76f4e7e5c71/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19-3-gc76f4e7e5c71/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221024.1/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/636c1d694d62e1887=
de7db92
        failing since 5 days (last pass: v5.10.145-cip17, first fail: v5.10=
.147-cip18-12-gcb2b164780be) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/636c1e8a4e090713cde7db59

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19-3-gc76f4e7e5c71/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meso=
n-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19-3-gc76f4e7e5c71/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meso=
n-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221024.1/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/636c1e8a4e090713c=
de7db5a
        new failure (last pass: v5.10.153-cip19) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/636c1e6508e224a25de7db81

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19-3-gc76f4e7e5c71/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19-3-gc76f4e7e5c71/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221024.1/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/636c1e6508e224a25de7dba3
        failing since 225 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2022-11-09T21:40:41.171498  =

    2022-11-09T21:40:42.218104  /lava-7922559/1/../bin/lava-test-case
    2022-11-09T21:40:42.243744  <8>[   96.661881] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/636c1d7b6aa3d62888e7db8d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19-3-gc76f4e7e5c71/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-rk=
3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19-3-gc76f4e7e5c71/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-rk=
3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221024.1/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/636c1d7b6aa3d6288=
8e7db8e
        new failure (last pass: v5.10.153-cip19) =

 =20

