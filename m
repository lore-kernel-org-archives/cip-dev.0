Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701E0ECAAD5
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 12:52:31 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web11.25189.1661950347395885820
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 05:52:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=RnNfvqHp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id q15so8940710pfn.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 05:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=Yzhw995C8+j6v/gBP96ZUnJItGtgSx+LQ59s74d8GNg=;
        b=RnNfvqHpkJoWQxqzDQc+X8IYWLWo6bMIF5xNUYiQxDP5kAAwKBkLh1SkJar7FIlKDF
         UuAEFKCYsSvrphlvl33YG0HSwMVmjx5wGWXk6bCoStcSQZHKVpCepi3e0eSux6o2dMU0
         /7WxLDm9WhIETG9p3qHbZp6co29E9k4SJT1bAukfPIhJvPM6LN0cm8wnA8n3YXxh7zlJ
         AvZnc7HFRLfTp1Rwi0xCazw8tNhzWyK+UlS+rekTsUCbYRFMa04Y0vE71snhN806EYIM
         uTtJiPEVyZR5MDZU2mc6zzU6uavXzOsBZnVY5iA3H4f1URaYF0lRH/Azv2o2bwIUjkGh
         9YlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Yzhw995C8+j6v/gBP96ZUnJItGtgSx+LQ59s74d8GNg=;
        b=xNDY99y54yOu0QnE43HF+5Rp+dTQRW+tA51EvP5pgnizWEIrfcC7IE/UzlBN3Xn/UN
         d1CQ7kAp0bdD8WfZvtfH2aqPNAtnA/gAlrIJGyDAvQYYuBeRTm8qn4VWc1j3oK9sUz54
         Ny3emaDNNA07jJUPa2sRenMAHPEKQDZ6ppR0lWr3tVyEilDhhn6wirPS9iVnoDRTkGj+
         HDhPuJ/BZTxscpwgeXldd+gPEH8bYj6GgvbeRgqUVy0AVv+tmkV0FWcIWycFVJs4bawl
         KGIH2F1TTDQwKYx5qttjgVFs3LOnO3lNwEi9ft4ezedUWRBqCcvTqmjre5kmqgeRk6wq
         pkow==
X-Gm-Message-State: ACgBeo10Ez/yABK8MzE8uvn9dpt3v3giEDgmZYb56mS1tM+pqarbJhah
	u1slttstMwCdXF+LhhSvN36CpzRGS+4aZ1oB0OE=
X-Google-Smtp-Source: 
 AA6agR7FKbd/aH6nVEDFzXjuQAVObYjRwNWxVROyptmzV5SVCc5u/g6HY/tO/rT56PkfdrX7zgjFyw==
X-Received: by 2002:a62:1b12:0:b0:536:715c:4d96 with SMTP id
 b18-20020a621b12000000b00536715c4d96mr25851394pfb.77.1661950346600;
        Wed, 31 Aug 2022 05:52:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 a15-20020a1709027e4f00b0016ed20eacd2sm11498478pln.150.2022.08.31.05.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 05:52:26 -0700 (PDT)
Message-ID: <630f598a.170a0220.659c5.4436@mx.google.com>
Date: Wed, 31 Aug 2022 05:52:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.138-cip15
Subject: cip/linux-5.10.y-cip baseline-nfs: 43 runs,
 5 regressions (v5.10.138-cip15)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 12:52:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9337

cip/linux-5.10.y-cip baseline-nfs: 43 runs, 5 regressions (v5.10.138-cip15)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
bcm2711-rpi-4-b              | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =

jetson-tk1                   | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

meson-gxm-khadas-vim2        | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.138-cip15/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.138-cip15
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f2d94917db95e02bef61288aba5b06e0dfef3a73 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
bcm2711-rpi-4-b              | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/630f5011ca17bd35313556bc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-bcm2711-rpi-4-b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-bcm2711-rpi-4-b.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220826.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/630f5012ca17bd353=
13556bd
        new failure (last pass: v5.10.131-cip13-84-g3b53e4dbd9f41) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
jetson-tk1                   | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/630f50860fdb1c7e5935566d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-nfs-jetson-tk1.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-nfs-jetson-tk1.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220826.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/630f50860fdb1c7e5=
935566e
        new failure (last pass: v5.10.136-cip14) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/630f530343b1f1afe335567a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson-g12b-a311d-kh=
adas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson-g12b-a311d-kh=
adas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220826.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/630f530343b1f1afe=
335567b
        failing since 35 days (last pass: v5.10.129-cip12, first fail: v5.1=
0.129-cip12-36-g21d9d56f4de5a) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxm-khadas-vim2        | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/630f5110497dd90054355683

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson-gxm-khadas-vi=
m2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson-gxm-khadas-vi=
m2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220826.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/630f5110497dd9005=
4355684
        failing since 253 days (last pass: v5.10.8-8301-g3d6168cb89f6, firs=
t fail: v5.10.83-cip1-31-gdcbef6602957) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/630f5331fbeac9b2d335564d

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220826.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/630f5332fbeac9b2d335566f
        failing since 155 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2022-08-31T12:24:57.378031  /lava-7147870/1/../bin/lava-test-case
    2022-08-31T12:24:57.409270  <8>[   96.810874] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

