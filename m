X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web08.38560.1653927686574590527
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 30 May 2022 09:21:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Xtp3O/dc;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.175, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f175.google.com with SMTP id r71so10583233pgr.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 30 May 2022 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=AL1gBMWm+WZDivH3HSgYRmYT96eTLoY40FVDJ/VJ4yc=;
        b=Xtp3O/dcs3p64U0xAYsFg/xO7i4qoEJgHncitsPVw7x00/mnelv+o/caRk2UCEduP6
         HH86F3WPgIOZzZQivleh2jLJJilpNQH5BW1WHYS5vlbSNsG1n9KEjqthcqUKTv4UmE+d
         QGbOYOpjwizeg50cUZnqGjtI3HMyG+Mo0y2J3D8UcqnBAMM9/ywbnA7kveajxhgSl0m2
         7J4mhvRfaqEy4TGbljiT+O+XKHxDApwgkaAIIw6Z3vhVLECVItNykGwpWSpGFOWeWYkw
         LdeHOiol6vUwvIrM39doajV0w+0E0noJXnobjhx1U1FQcjPWWYnOZBslr19fEJ381tNu
         ycyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=AL1gBMWm+WZDivH3HSgYRmYT96eTLoY40FVDJ/VJ4yc=;
        b=7eSLgR5KBlEpiUsGqvaGbOfU3kxf/4yhOIwOCAX8KASzh10p5vtpnCjIlNfH5Dr25r
         YoFBhJD6Or3MH+v5c75HvU2j5wEbujTpjtyH/fJylKvfKw0uInASFWUHwq0/FHZjoHk4
         d/YAStJ6vL/K67rlWu9QxFaMI1Nhvy/T3V1llerqvQfqrdniklqN7lGdSxlPeWl4roAO
         i7IiAT8rGWlsO4m7KkPZu4nP2ivBbuwMsjFx31G0/oLyt4C85HtpD9Of+DCt4TN//ts5
         zEShCi1ybi4GWV6o79E+7BDG2JN17wsCE5mzFMxNa16NVOdzqE7x2dt72jqu4L4h3Hiq
         JMPg==
X-Gm-Message-State: AOAM531xWy3BQ6lHem2aa1Qnzbjvna/Kv1YnX/RG+RYNl06XLKvXCeoX
	dL5KC2HvB/0MxbjhPWguClgDNEIOAzshpfX5Asg=
X-Google-Smtp-Source: ABdhPJz1KD5a9YRsIFa4X1TBMTu8AQ0TfQdG+rI2Rr2HPJjmFRiy5jaCZj5UnBebNRcJdOZJ0/b/JA==
X-Received: by 2002:a62:ed0e:0:b0:4fa:11ed:2ad1 with SMTP id u14-20020a62ed0e000000b004fa11ed2ad1mr57939278pfh.34.1653927685748;
        Mon, 30 May 2022 09:21:25 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902aa8c00b00163b65c9de2sm5118864plr.170.2022.05.30.09.21.25
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 09:21:25 -0700 (PDT)
Message-ID: <6294ef05.1c69fb81.ac9c1.ac4e@mx.google.com>
Date: Mon, 30 May 2022 09:21:25 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.118-465-g0af29783a3c9
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 41 runs, 3 regressions (v5.10.118-465-g0af29783a3c9) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 41 runs, 3 regress=
ions (v5.10.118-465-g0af29783a3c9)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
jetson-tk1       | arm   | lab-baylibre  | gcc-10   | multi_v7_defconfig   =
      | 1          =

jetson-tk1       | arm   | lab-baylibre  | gcc-10   | tegra_defconfig      =
      | 1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.118-465-g0af29783a3c9/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.118-465-g0af29783a3c9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0af29783a3c96b3caf71bb01eb38e07102566f10 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
jetson-tk1       | arm   | lab-baylibre  | gcc-10   | multi_v7_defconfig   =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/6294ee32f172f53074a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm/multi_v7_defconfig/gcc-10/lab-=
baylibre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm/multi_v7_defconfig/gcc-10/lab-=
baylibre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6294ee32f172f5307=
4a39bce
        new failure (last pass: v5.10.112-cip6-289-g2969e096d186) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
jetson-tk1       | arm   | lab-baylibre  | gcc-10   | tegra_defconfig      =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/6294ebf7ffd05c874aa39bd7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm/tegra_defconfig/gcc-10/lab-bay=
libre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm/tegra_defconfig/gcc-10/lab-bay=
libre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6294ebf7ffd05c874=
aa39bd8
        new failure (last pass: v5.10.112-cip6-289-g2969e096d186) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6294e45dd989476bb5a39bec

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/6294e45dd989476bb5a39c0e
        failing since 82 days (last pass: v5.10.100-cip2-319-gcbff87047566,=
 first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-05-30T15:35:46.491222  <4>[   37.226948] cdn-dp fec00000.dp: Direc=
t firmware load for rockchip/dptx.bin failed with error -2
    2022-05-30T15:35:46.500624  <4>[   37.237394] cdn-dp fec00000.dp: Falli=
ng back to sysfs fallback for: rockchip/dptx.bin
    2022-05-30T15:35:46.874108  /lava-6503501/1/../bin/lava-test-case
    2022-05-30T15:35:46.905012  <8>[   37.643332] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

