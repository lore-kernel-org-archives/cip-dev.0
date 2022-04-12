X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web12.4982.1649722249867939366
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 11 Apr 2022 17:10:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=XZE45i0O;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.176, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f176.google.com with SMTP id s137so12865046pgs.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 11 Apr 2022 17:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=34no2N4oqmFmiEaPE2tHzdQHxyvy/YRzQCRpTVrjGkU=;
        b=XZE45i0OPeFvNXz5oBho07S9z380QFsKqEXPpcrtmmvl+MTuze7DrsU1QGUJCaqFWS
         TpP94tBIH0uWeh1DC8hxVKweq5VqnGmZgBE4SaLKDQ01Lm7kzFTPeeejjp8zhRQQvxbi
         PIZK1JKX/ZlAJPpUokueH/Yhhqu8sYbybTOcMKXTsO3JoT/MUxbS6tDuXqT68W2kocNv
         wTJ/tvj89l8CAeS2eNLs3+epXF17MpTrBFoxXOSJkXnJq0b/UuWxclckkMSyH0V+zRFU
         MjgAvL137kIIOTArxStw/r6ZirbjSIHvcXBXGP4baUMJ4lmLVkyxQbkiYrpCxbH/FcZg
         lV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=34no2N4oqmFmiEaPE2tHzdQHxyvy/YRzQCRpTVrjGkU=;
        b=5l/fgaEQTVLq+u9I+xOQZGECbuwpWwtTdalmdeFR+L3CAX1z0IYvoatybi6smErfuq
         scolDslXswa2WgV52a7BdfmZ2a2pxylvQx3zKBBo5yHwSZF6ozjLJpMQq7pc16Vq3/Mu
         N2htW068VxRYcfbz5NIjiaBPOywQBd71biCDxjBB7oc9l4djOdE6KFLxlA9LKv5mXN7/
         4e4GJKJ3hVsPmQrA+Y1AtCujvrjobqtxGs2/W2wWLtV29ayw3ef4OwgU1lSEGx7DjXId
         HGaErHR+STqYLmx/nbj9AFh09NfOOE/RGuu3Su/mUGCtte7DrGETszq/wn8UUfXxIpOA
         dVag==
X-Gm-Message-State: AOAM532N1II8SBkLocaHSTU2YXKI5V42BqdMlubKTkOAPPO1Yg8eU9cP
	qGFTekdudpoJzN3n3jPEmMsxQO8DpcCmMU/O
X-Google-Smtp-Source: ABdhPJxW1O9FstLSdgq7+WhY2gN3wAVuaQLCDddUzpjpHLt4LsGu8+8dnnpJhH+bXtkRvD+Um6YQsQ==
X-Received: by 2002:a63:4549:0:b0:39d:8041:53a6 with SMTP id u9-20020a634549000000b0039d804153a6mr2856713pgk.501.1649722248803;
        Mon, 11 Apr 2022 17:10:48 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e10-20020a17090a630a00b001c685cfd9d1sm595948pjj.20.2022.04.11.17.10.48
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 17:10:48 -0700 (PDT)
Message-ID: <6254c388.1c69fb81.a6229.2424@mx.google.com>
Date: Mon, 11 Apr 2022 17:10:48 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.106-cip4-757-gd8c01ae8a4bc9
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 21 runs, 3 regressions (v5.10.106-cip4-757-gd8c01ae8a4bc9) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 21 runs, 3 regress=
ions (v5.10.106-cip4-757-gd8c01ae8a4bc9)

Regressions Summary
-------------------

platform            | arch  | lab           | compiler | defconfig         =
         | regressions
--------------------+-------+---------------+----------+-------------------=
---------+------------
beaglebone-black    | arm   | lab-cip       | gcc-10   | multi_v7_defconfig=
         | 1          =

r8a77950-salvator-x | arm64 | lab-baylibre  | gcc-10   | defconfig         =
         | 1          =

rk3399-gru-kevin    | arm64 | lab-collabora | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.106-cip4-757-gd8c01ae8a4bc9/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.106-cip4-757-gd8c01ae8a4bc9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d8c01ae8a4bc9d22111adb18d50f655db7432e10 =



Test Regressions
---------------- =



platform            | arch  | lab           | compiler | defconfig         =
         | regressions
--------------------+-------+---------------+----------+-------------------=
---------+------------
beaglebone-black    | arm   | lab-cip       | gcc-10   | multi_v7_defconfig=
         | 1          =


  Details:     https://kernelci.org/test/plan/id/6254ba301beddbf5e2ae06a1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.106-cip4-757-gd8c01ae8a4bc9/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.106-cip4-757-gd8c01ae8a4bc9/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220401.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6254ba301beddbf5e=
2ae06a2
        new failure (last pass: v5.10.104-cip3-224-gbc5581d50c4e) =

 =



platform            | arch  | lab           | compiler | defconfig         =
         | regressions
--------------------+-------+---------------+----------+-------------------=
---------+------------
r8a77950-salvator-x | arm64 | lab-baylibre  | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/6254bd8c4c55a5929eae067c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.106-cip4-757-gd8c01ae8a4bc9/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-nfs-r8a77950-salvator-x.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.106-cip4-757-gd8c01ae8a4bc9/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-nfs-r8a77950-salvator-x.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220401.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6254bd8c4c55a5929=
eae067d
        new failure (last pass: v5.10.104-cip3-224-gbc5581d50c4e) =

 =



platform            | arch  | lab           | compiler | defconfig         =
         | regressions
--------------------+-------+---------------+----------+-------------------=
---------+------------
rk3399-gru-kevin    | arm64 | lab-collabora | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6254bc6cf647994fabae06ac

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.106-cip4-757-gd8c01ae8a4bc9/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.106-cip4-757-gd8c01ae8a4bc9/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220401.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/6254bc6cf647994fabae06ce
        failing since 33 days (last pass: v5.10.100-cip2-319-gcbff87047566,=
 first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-04-11T23:40:01.571296  /lava-6067268/1/../bin/lava-test-case   =

 =20

