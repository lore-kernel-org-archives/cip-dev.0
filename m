Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6771C3F6B0
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 14:34:26 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web12.11423.1660314862259232368
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Aug 2022 07:34:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=KB3uh15D;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id 13so887189plo.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Aug 2022 07:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=zWnfGkuQwhE7kP6cW0koG73pAg+7pc2gpKPaZCuJ/cU=;
        b=KB3uh15D8+naQXWnZjK3Le/dhUZOy2RXuOVnKsDn3ii/HNOp/UTet/4ISB+euzfqza
         wSD7E4kSucr4FFbF6etMq8a3gzSAluJPx2tKx7IdT79rTk/xAaQtAYyl9Pfc0OAFQMJ9
         UmsC0wGzRi8F1TMCjel5qlxZa2mFKrzG0oGol7hBd2mtuXs1UzN893rJ5NEgmNEsvefq
         BqTEmnIu89p3VQ7l9phA3V9dwKV9DmtwIRsw4zsAT7ul0G793m1GqBbWgDNekBQc/YBO
         lLIzlzerUPMuLjXeogoG1n2JbqAo+/1zwy9SvW5BVpeFOV5iEQp6ht2dLR9IVWv9WSVT
         V5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=zWnfGkuQwhE7kP6cW0koG73pAg+7pc2gpKPaZCuJ/cU=;
        b=x4ywk22C2rxy5Xdd0qQ5CzK9l6YiWLuAMYP1n2xao4BpCA9Jq6jH8AAzshBOecQyZT
         nEJ/pXEM/SG2rVFVRrxliQJnHO06Rbr2ukOX3zmU5tLc/TMLyveonTbhbTPLeFvPM3ys
         HHvckFlsr8H1CbNVWpGSU/1u3GwgpBlRxbLV+HvN8umRwhAMSgsyysCCcuzV7W6opU4J
         2pOe820Q4ja0AOXwpHZTSucfZMgtJrgIM009aDN3oecHdHdSaubwdgIR6vMmbVJ3BsV3
         FWmMaS6zbguve8d+NB3SWdp+Dd+Jq9JA9R1Eplu+wQSLTAkfg8PvAaYO4/pjrUlXs7Ec
         ePXw==
X-Gm-Message-State: ACgBeo1u1jJV5UbuLG7rUE21g07w8jxfU863v3DvbhTmUZNkDPW1WLrq
	kpS20xa8PU732prFSe0If7oKBWuy180RDDni
X-Google-Smtp-Source: 
 AA6agR4nZs6h4h2dfFUpaxx6gCLH4JxN0cnEk/c+iGteH1FRZ9ZAi2Id67ICAIkLNFN8KS+0f3auYg==
X-Received: by 2002:a17:90b:390f:b0:1f4:e394:8c18 with SMTP id
 ob15-20020a17090b390f00b001f4e3948c18mr4315645pjb.141.1660314861561;
        Fri, 12 Aug 2022 07:34:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 c6-20020a170902d48600b0016f057b88c9sm1846871plg.26.2022.08.12.07.34.20
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 07:34:21 -0700 (PDT)
Message-ID: <62f664ed.170a0220.8b84d.31a4@mx.google.com>
Date: Fri, 12 Aug 2022 07:34:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-35-gab58aa0904675
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 42 runs,
 6 regressions (v5.10.131-cip13-35-gab58aa0904675)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Aug 2022 14:34:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9199

cip-gitlab/ci/pavel/linux-test baseline-nfs: 42 runs, 6 regressions (v5.10.=
131-cip13-35-gab58aa0904675)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
imx6q-udoo                   | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig         | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm64-chromebook | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 3          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.131-cip13-35-gab58aa0904675/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.131-cip13-35-gab58aa0904675
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ab58aa0904675bdc00cf17ebe4f1b5aba242c1cd =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
imx6q-udoo                   | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/62f65e77ac9a488759daf057

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220805.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62f65e77ac9a48875=
9daf058
        new failure (last pass: v4.4-st20-96-g74ff989472f09) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62f65f3ba63f125a2cdaf080

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/arm64/defconfig/gcc-10/lab-baylibre/base=
line-nfs-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/arm64/defconfig/gcc-10/lab-baylibre/base=
line-nfs-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220805.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62f65f3ba63f125a2=
cdaf081
        failing since 8 days (last pass: v5.10.112-cip6, first fail: v5.10.=
131-cip13-24-ga6f4ea41fe167) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62f661e34fa231443ddaf05e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220805.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62f661e34fa231443=
ddaf05f
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 3          =


  Details:     https://kernelci.org/test/plan/id/62f65d55b86b09a67ddaf057

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220805.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.cros-ec-sensors-gyro0-probed: https://kernelci.org/=
test/case/id/62f65d55b86b09a67ddaf09a
        failing since 94 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a)

    2022-08-12T14:01:45.627865  /lava-7024586/1/../bin/lava-test-case
    2022-08-12T14:01:45.655858  <8>[   93.985265] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-gyro0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-sensors-accel1-probed: https://kernelci.org=
/test/case/id/62f65d55b86b09a67ddaf09b
        failing since 94 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a)

    2022-08-12T14:01:44.565368  /lava-7024586/1/../bin/lava-test-case
    2022-08-12T14:01:44.596369  <8>[   92.925793] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-accel1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-sensors-accel0-probed: https://kernelci.org=
/test/case/id/62f65d55b86b09a67ddaf09c
        failing since 94 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a)

    2022-08-12T14:01:43.502852  /lava-7024586/1/../bin/lava-test-case
    2022-08-12T14:01:43.532500  <8>[   91.861124] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-accel0-probed RESULT=3Dfail>   =

 =20

