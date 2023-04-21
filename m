Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAF9C7EE22
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 12:50:12 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.10625.1682081409178236743
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 21 Apr 2023 05:50:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=f7Mvo4Dv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1a67bcde3a7so23719985ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 21 Apr 2023 05:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682081408; x=1684673408;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N99BhuCuMkdXanFjG+SMfukyM0boCleCp2NnbcjNFwU=;
        b=f7Mvo4DvVXxujnT60G4t9j/tLfAEhpBffxNirM+/xG7m6sR2lUOj2dBLYzLfUofksR
         mOrV1LfJ1bReXjiQ280ibgGXcL6bbHB+bRm0gtMbYtbo5dNbyOZUpW+6ncTVR32Tr+A4
         6HOV4ic1WSU7uMLsVmn7PbtACv6g0DQB5Y/AffgXvyNWSycZnOcex+c0cg9GTUQmzN34
         ATYJHli5KU+ddpfu4HN3ty/2DnqiOGAYb61Nyz+v3/fdMJZq/+MqWHerqlwWjBkYHXyW
         JulRbQywuFERnK6ElMID3IX7RmzBtKv0Y7JpKOhse9By9HsOwaxi38Jv4uHKwb5oPx0O
         CKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682081408; x=1684673408;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N99BhuCuMkdXanFjG+SMfukyM0boCleCp2NnbcjNFwU=;
        b=daBi0QEA2HH+pGc1OPEO7alBLKWe7Ae80+VTr2OPhsZwj+/9bmsheoSgEL7IS6tWap
         fJAna13EtzqPIXvvBdJ2gexbkVfOHg6vFolMvXSPJOFf2G3uImlYGCfWz400ww4WY6v5
         kAiV8Rqe/nq+zQyHaV93ICm6tslQhrJVd8+xkTXVzgQQrlMqxMYLfJsp4y8IZomWyNC6
         RSO0dMgss72NEGZzEuBIwwijdPfx5AMV/ZogIg7W97KuJ4ZnU0J3c1WgGOQYXOXTlFGU
         FYxwV55hF0DGcQWju7V8xoA8ICGtfLoaZVuiAumG5j5cADE7Q8ayALXS727wmPiBsdbv
         prFg==
X-Gm-Message-State: AAQBX9dja7w1U4s8aNqEYtfedTUUA23K9z8ZDYItgUKup5rxQ8VSNjc5
	PjT4ILxCkPeETt/jHcLgoKu4pDVhYbAmY1V3iW39iRvD
X-Google-Smtp-Source: AKy350bMIU4KeJu1+lhNhJe0CaHGsQxATYz5080xYvBvA9ufcahprnVUF54iXPaw+iINF2AMNPsJ+A==
X-Received: by 2002:a17:903:11c4:b0:1a6:9104:2047 with SMTP id q4-20020a17090311c400b001a691042047mr5409122plh.38.1682081408278;
        Fri, 21 Apr 2023 05:50:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jf19-20020a170903269300b001a2806ae2f7sm2742963plb.83.2023.04.21.05.50.07
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 05:50:08 -0700 (PDT)
Message-ID: <64428680.170a0220.725b3.60ad@mx.google.com>
Date: Fri, 21 Apr 2023 05:50:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.177-cip31-33-gd59f246891e73
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 45 runs,
 7 regressions (v5.10.177-cip31-33-gd59f246891e73)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 12:50:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11312

cip-gitlab/ci/pavel/linux-test baseline-nfs: 45 runs, 7 regressions (v5.10.=
177-cip31-33-gd59f246891e73)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
imx6dl-udoo                  | arm   | lab-broonie   | gcc-10   | imx_v6_v7=
_defconfig        | 1          =

imx6dl-udoo                  | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig         | 1          =

imx6q-udoo                   | arm   | lab-broonie   | gcc-10   | imx_v6_v7=
_defconfig        | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.177-cip31-33-gd59f246891e73/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.177-cip31-33-gd59f246891e73
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d59f246891e73b9c221f394dd91c309755c3e8ce =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
imx6dl-udoo                  | arm   | lab-broonie   | gcc-10   | imx_v6_v7=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/64428197df9de286372e85f0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64428197df9de2863=
72e85f1
        new failure (last pass: v4.4-st20-1100-ga8cadce4b9649) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
imx6dl-udoo                  | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/64428365fe3041d45d2e8616

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64428365fe3041d45=
d2e8617
        new failure (last pass: v4.4-st20-1100-ga8cadce4b9649) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
imx6q-udoo                   | arm   | lab-broonie   | gcc-10   | imx_v6_v7=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/64427f986ea8f495082e8601

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64427f986ea8f4950=
82e8602
        new failure (last pass: v4.4-st20-1100-ga8cadce4b9649) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64428227255a660b172e85f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64428227255a660b1=
72e85f2
        new failure (last pass: v5.10.175-cip29-rt12) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64427fbc226259a82e2e85fc

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64427fbc226259a82e2e8602
        failing since 30 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-04-21T12:21:04.150048  /lava-10074827/1/../bin/lava-test-case

    2023-04-21T12:21:04.179750  <8>[   96.702841] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64427fbc226259a82e2e8603
        failing since 30 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-04-21T12:21:03.078557  /lava-10074827/1/../bin/lava-test-case

    2023-04-21T12:21:03.106536  <8>[   95.629197] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/644283b60d46f229d92e85ec

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.177-cip31-33-gd59f246891e73/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230414.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/644283b60d46f229d92e8614
        failing since 92 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-04-21T12:37:06.466890  [   40.964877] <LAVA_SIGNAL_ENDRUN 0_dmesg =
366493_1.6.2.4.1>
    2023-04-21T12:37:06.590869  #
    2023-04-21T12:37:06.693005  / # #export SHELL=3D/bin/sh
    2023-04-21T12:37:06.693526  =

    2023-04-21T12:37:06.794982  / # export SHELL=3D/bin/sh. /lava-366493/en=
vironment
    2023-04-21T12:37:06.795446  =

    2023-04-21T12:37:06.896901  / # . /lava-366493/environment/lava-366493/=
bin/lava-test-runner /lava-366493/1
    2023-04-21T12:37:06.897908  =

    2023-04-21T12:37:06.902195  / # /lava-366493/bin/lava-test-runner /lava=
-366493/1
    2023-04-21T12:37:07.068283  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

