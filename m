Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A82C43334
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 01:02:49 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web10.1399.1658797360115650219
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Jul 2022 18:02:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=FOgC+9+B;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id y141so11877588pfb.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Jul 2022 18:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=RDODXLkxTL8XYALP2MnaAINieNLMMLMv7dPebPdURSM=;
        b=FOgC+9+BeTGtzt64PdWR8UqzxCDdjBC4MK5qPQaLh+vMkY1zqostIoGIKZVyNBRJjO
         S/xfuWGcSv3wIq+FuEu2gnRVlC5xdtMuht+8w78BnNGM1JjGBsJDpqgZL5bip9/yBWmq
         uTY5nDN5FqL0Zxyb7vAvW5gu5Mb/gOtxeq7PuMRru7yAPy8A0xe4PgpZY4MAXX1y/fbQ
         JvmPBJegC1VyJv1d7cD0yqiQnHrjFWWfGAu7+thPKeZRodRATQbg+W4zUu0L3B0LlqBa
         NUyVUWkTAAi+AD4riTgGyLKTYkadEjoJ5IUOMUA8qdDUKzuI/RwuCmsnjW/RNL9BvndC
         rEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=RDODXLkxTL8XYALP2MnaAINieNLMMLMv7dPebPdURSM=;
        b=OE4JW9mB8fU/BJnzo3KSyDHpRQAvF1IQN40jT7/e1C8KmtTY5wGdyuwg9kNh0xPoUa
         511SygofvIviXCMcXRcZ9TbQJWmzzlvpaanjQpzNMtB1Z3wt4WqM40ovyQpTU2Q16+dd
         7IoDMajFpDbRW6x/GppVLKi9CwQH24MTFnSYWPd/C0Bz/zTKVao03eNr1IkFVSsWSxEz
         oBxyy9mp1ndbLR558WXbDAZIGvAWEiL0Z0A7qWC5BW1gnD+mZdXOFlbRk9+Fdv9uuC2h
         OvoS2Gr5H+WR4ZuaaY07VWPXRCWinVnQk3RSyU99y63/yQAe/dpE13e2nse2GlYYhvGg
         j3mA==
X-Gm-Message-State: AJIora8S8zn9Mpug3bQOzvFDdcnoP2ep7jS5vEIQET/+voqKYU7KKfVz
	+3wR04FoX1LAH5nBOpMpoYJ+0MXy30WlTUO1
X-Google-Smtp-Source: 
 AGRyM1sAu+n0vEQCFRc99PRob6z7FdfkbfpDP68HmFozj1MdAYVO3GHiVwu1VX6rUyOzejkbFn72qQ==
X-Received: by 2002:a62:1cc8:0:b0:52a:ee9e:b735 with SMTP id
 c191-20020a621cc8000000b0052aee9eb735mr15065003pfc.42.1658797359453;
        Mon, 25 Jul 2022 18:02:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 z28-20020aa7949c000000b0052516db7123sm10227443pfk.35.2022.07.25.18.02.38
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 18:02:39 -0700 (PDT)
Message-ID: <62df3d2f.1c69fb81.c13f3.038f@mx.google.com>
Date: Mon, 25 Jul 2022 18:02:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-36-g21d9d56f4de5a
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 47 runs,
 5 regressions (v5.10.129-cip12-36-g21d9d56f4de5a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 01:02:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8911

cip-gitlab/ci/pavel/linux-test baseline-nfs: 47 runs, 5 regressions (v5.10.=
129-cip12-36-g21d9d56f4de5a)

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
ebook | 3          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.129-cip12-36-g21d9d56f4de5a/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.129-cip12-36-g21d9d56f4de5a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      21d9d56f4de5acd415b12aecf82f754e9e6065fb =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
jetson-tk1       | arm   | lab-baylibre  | gcc-10   | multi_v7_defconfig   =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/62df38e34afd43e11adaf06a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.129-cip12-36-g21d9d56f4de5a/arm/multi_v7_defconfig/gcc-10/lab-baylib=
re/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.129-cip12-36-g21d9d56f4de5a/arm/multi_v7_defconfig/gcc-10/lab-baylib=
re/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62df38e34afd43e11=
adaf06b
        new failure (last pass: v4.4-st5-312-g3a12bf5207d81) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
jetson-tk1       | arm   | lab-baylibre  | gcc-10   | tegra_defconfig      =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/62df35c5cc04f0204fdaf056

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.129-cip12-36-g21d9d56f4de5a/arm/tegra_defconfig/gcc-10/lab-baylibre/=
baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.129-cip12-36-g21d9d56f4de5a/arm/tegra_defconfig/gcc-10/lab-baylibre/=
baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62df35c5cc04f0204=
fdaf057
        new failure (last pass: v4.4-st5-1797-gb2b8419761095) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 3          =


  Details:     https://kernelci.org/test/plan/id/62df34ee0f9565468ddaf078

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.129-cip12-36-g21d9d56f4de5a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.129-cip12-36-g21d9d56f4de5a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.cros-ec-sensors-gyro0-probed: https://kernelci.org/=
test/case/id/62df34ee0f9565468ddaf0bb
        failing since 76 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a)

    2022-07-26T00:27:11.109641  /lava-6887576/1/../bin/lava-test-case
    2022-07-26T00:27:11.138392  <8>[   93.803093] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-gyro0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-sensors-accel1-probed: https://kernelci.org=
/test/case/id/62df34ee0f9565468ddaf0bc
        failing since 76 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a)

    2022-07-26T00:27:10.046812  /lava-6887576/1/../bin/lava-test-case
    2022-07-26T00:27:10.074768  <8>[   92.739214] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-accel1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-sensors-accel0-probed: https://kernelci.org=
/test/case/id/62df34ee0f9565468ddaf0bd
        failing since 76 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a)

    2022-07-26T00:27:07.952118  <8>[   90.615932] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-driver-present RESULT=3Dpass>
    2022-07-26T00:27:08.985879  /lava-6887576/1/../bin/lava-test-case
    2022-07-26T00:27:09.015396  <8>[   91.679950] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-accel0-probed RESULT=3Dfail>   =

 =20

