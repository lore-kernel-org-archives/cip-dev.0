Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF23CCA47E
	for <webhook@archiver.kernel.org>; Mon,  6 Jun 2022 08:52:23 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web08.29765.1654505535778367567
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 06 Jun 2022 01:52:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=o3kjxEy0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id g186so3512683pgc.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 06 Jun 2022 01:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=EZhwwc247xu7FVgbkigDmErmaKiEAntdUTMgTkrX+Zk=;
        b=o3kjxEy0mQZPTsjnKbpmQDD2ftiHhb9EL7rwDLK+9yArCz1K/J/U8SJS3UACY1vPR+
         j3V439VxLXKg5EYCdI+XXUUEmoV6NSEcnKDA05E/POOyS5Au+VFyzvrgqF2H47160/7B
         NNUH8gQnAaJLhEitCU2n5mDMmSASpAE540eKqs0xo09cBEHjjRg69ofa7wI8Y31ATV7B
         2U56Otk4lQ7UyOlXu2hIWC7Y5P4f/gGVS/4u8geP3isX9tZ8tbjmVpsj5HxlCxMwTRI1
         8CBIg6xI5XabDN9MBaDJV0hHC/POFbKFJFyyJcrJBUiwSpFWVXK0CTZkxaiw1/q6Bt47
         Y3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=EZhwwc247xu7FVgbkigDmErmaKiEAntdUTMgTkrX+Zk=;
        b=SulBx+JVd9cuxS5EKrdnPPjCFjD9UzNKnH3t1njVsfh2anUwNImXa8vC6ne5B4bQjj
         lGndlPSXWtfMt4WKJGUSN1oxKHWg5hzyqc0iH0773dqkIid17FoI6HvsLw6DNB27tPYX
         LKIXUh7bBx9vCbNYzp2urvln1CW4h91i77KcdisCSoT83FphnX58U7KoUtx8YEZE/0Cb
         x343cQjRZUxOLKfN72XQ+k/c49Y2ED3WLc+x8uLaZJL/LN4ZmmVVW7IKXGOPvrZTuP9f
         KFgXZHQLZP9+2E6nln1XENYF8/Lg4osKgACt+ls0TVvPf636VtoVWztZU6pTpH5EyWXq
         UE8w==
X-Gm-Message-State: AOAM530bFCkt31lhRJMqT1ue9oyUH6O8gsuWoj+/YqVASVUu3ZKhzrL/
	gBxz5x3dHpqsbixFG4aYCDj8hXcU/XJVKdIr
X-Google-Smtp-Source: 
 ABdhPJxyK7y1TV5Ciwd21l/59QNdPQ4oxHdwd/or5eop1mVgqKqdXL7BqLpjUMetTo0gkqSUeVxpdQ==
X-Received: by 2002:a63:cc09:0:b0:3fb:aae7:4964 with SMTP id
 x9-20020a63cc09000000b003fbaae74964mr19942720pgf.118.1654505535006;
        Mon, 06 Jun 2022 01:52:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 q10-20020a170902daca00b0016223016d79sm10226088plx.90.2022.06.06.01.52.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 01:52:13 -0700 (PDT)
Message-ID: <629dc03d.1c69fb81.4601.6e3e@mx.google.com>
Date: Mon, 06 Jun 2022 01:52:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.245-cip74-32-g2d021d7a9e637
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 39 runs,
 3 regressions (v4.19.245-cip74-32-g2d021d7a9e637)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Jun 2022 08:52:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8494

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 39 runs, 3 regress=
ions (v4.19.245-cip74-32-g2d021d7a9e637)

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
Flinux-4.19.y-cip-rc/kernel/v4.19.245-cip74-32-g2d021d7a9e637/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.245-cip74-32-g2d021d7a9e637
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2d021d7a9e637c95607b890c32ce5cbf91baec0d =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
jetson-tk1       | arm   | lab-baylibre  | gcc-10   | multi_v7_defconfig   =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/629dbc86d939830a95a39bef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.245-cip74-32-g2d021d7a9e637/arm/multi_v7_defconfig/gcc-1=
0/lab-baylibre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.245-cip74-32-g2d021d7a9e637/arm/multi_v7_defconfig/gcc-1=
0/lab-baylibre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/629dbc86d939830a9=
5a39bf0
        new failure (last pass: v4.19.239-cip72-68-g407458469172) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
jetson-tk1       | arm   | lab-baylibre  | gcc-10   | tegra_defconfig      =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/629dbe023744363a9da39bce

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.245-cip74-32-g2d021d7a9e637/arm/tegra_defconfig/gcc-10/l=
ab-baylibre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.245-cip74-32-g2d021d7a9e637/arm/tegra_defconfig/gcc-10/l=
ab-baylibre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/629dbe023744363a9=
da39bcf
        new failure (last pass: v4.19.239-cip72-68-g407458469172) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/629dba519ccc98103da39bf4

  Results:     82 PASS, 6 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.245-cip74-32-g2d021d7a9e637/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.245-cip74-32-g2d021d7a9e637/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/629dba519ccc98103da39c16
        failing since 84 days (last pass: v4.19.229-cip67-111-g5c3c0b39cf3b=
, first fail: v4.19.231-cip68-123-g92e3e7f3d4df)

    2022-06-06T08:26:51.983580  /lava-6550572/1/../bin/lava-test-case
    2022-06-06T08:26:52.007348  <8>[   37.697965] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

