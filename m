Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01A7C6FA83
	for <webhook@archiver.kernel.org>; Fri, 23 Sep 2022 18:41:48 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.331.1663958501168129751
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Sep 2022 11:41:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=AHI2nltT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d24so956182pls.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Sep 2022 11:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=Ote0KwEeZrojRyfBPo/SehtBUuSfB2HMzO822zq0X/s=;
        b=AHI2nltThHqr6s9dO9crsFxdjpHhZATuBHw6p4eORdeyxc2GMr9z0uzuls5gtujFnA
         JlNvZCrQG+m3lTWhOWXvheYD1OVibPltXgIPAgWtMWbGd7RZs5++kMNnipil8tY80SVF
         JLIH4Pf8A/mO6jaPxS9OaGwuolW8tN0joCB21HzVWDbmfw0C1wkNwAT+bWetUQLpnnJs
         8Cfb2jrTlkDPGWJeOSBn8HJxvt7aupz3Na6NAuoVR5YXpOaB3UGSMUVhl1/vam+VAhiR
         nn3LhlyC6m7BAUpx7JVE/n4pqVkOrkoJ5PHyk1WuO7+kIuKi5tQzsCHSDXwQMyu9OtP6
         GykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Ote0KwEeZrojRyfBPo/SehtBUuSfB2HMzO822zq0X/s=;
        b=pYrB39G24ACRp/KdV5A7xWGCVl7L8gjrPmeS4TSiBkdgVNjaQAtWMi0fnj185GpbY7
         dxWEOm1cMW9OtwokFaGCYXeoOlY8wfN7YCWbPLvd8C51RATczyu2IvTHlkG0KjxOD9sk
         TbGXEOudAhFcbCmIsd+umbe6ujm5cQY8EN8Qf1q+KoJC8rrkykq0B2Y0H1Sl1D6el+2M
         d9nnvzNB5vH3gEoS6+oliCFYVc8fvvVhSPn2yGMNmZufzpGIZvj78t4pXjUvFFXA9Wp1
         AmdT+HXyiI/MdAxXex3zkgG7xePy6iS8Gjo847w/kA01ySTRwk4RSf8hBnvzzQ5n/crk
         /PMQ==
X-Gm-Message-State: ACrzQf1/P0wdnsHHoVrUKiox1t8myzhSBz/p+L/RMPrMIbPAoMp9qEHb
	cQiBapyzf2YNsDSBgYI5Np0MtekqhsDGGk3Kb6o=
X-Google-Smtp-Source: 
 AMsMyM6Fm4kt48pSLDVyKHbAa9zMSeQChnBkurntBP+7CEvbxpAPjeOuu9AxrA62kvBsfxHfErUGjw==
X-Received: by 2002:a17:90b:1bc4:b0:202:fbd0:8e86 with SMTP id
 oa4-20020a17090b1bc400b00202fbd08e86mr11120357pjb.52.1663958500205;
        Fri, 23 Sep 2022 11:41:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 e23-20020aa79817000000b00540b35628a4sm6844724pfl.123.2022.09.23.11.41.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 11:41:39 -0700 (PDT)
Message-ID: <632dfde3.a70a0220.ecbd0.ec26@mx.google.com>
Date: Fri, 23 Sep 2022 11:41:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.140-cip16-261-g8fa62effa305f
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 107 runs,
 6 regressions (v5.10.140-cip16-261-g8fa62effa305f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Sep 2022 18:41:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9538

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 107 runs, 6 regression=
s (v5.10.140-cip16-261-g8fa62effa305f)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
panda                      | arm   | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig        | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

rk3399-gru-kevin           | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.140-cip16-261-g8fa62effa305f/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.140-cip16-261-g8fa62effa305f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      8fa62effa305f81a2f52692a14ee690927819830 =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
panda                      | arm   | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/632df8319ede6c11d6355685

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/arm/omap2plus_defconfig/gcc=
-10/lab-baylibre/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/arm/omap2plus_defconfig/gcc=
-10/lab-baylibre/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/632df8319ede6c11d6355=
686
        failing since 22 days (last pass: v5.10.136-cip14-542-g97767707d3d0=
, first fail: v5.10.138-cip15-90-gd4130d0ee3c7) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/632df4b492dbf64eba35564d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/632df4b492dbf64eba355=
64e
        failing since 134 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6=
, first fail: v5.10.112-cip6-289-g2969e096d186) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/632df50465cac726f4355642

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/632df50465cac726f4355=
643
        failing since 134 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6=
, first fail: v5.10.112-cip6-289-g2969e096d186) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/632df48bee4d2491433556a8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/632df48cee4d249143355=
6a9
        failing since 134 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6=
, first fail: v5.10.112-cip6-289-g2969e096d186) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/632df49f90187b5c8435568b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/632df49f90187b5c84355=
68c
        failing since 134 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6=
, first fail: v5.10.112-cip6-289-g2969e096d186) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
rk3399-gru-kevin           | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/632df86d35e267bb4b3556a4

  Results:     90 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/632df86d35e267bb4b3556ca
        failing since 198 days (last pass: v5.10.100-cip2-319-gcbff87047566=
, first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-09-23T18:18:07.992187  /lava-7362451/1/../bin/lava-test-case   =

 =20

