Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172EBC19F28
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 11:43:33 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web10.7333.1659526998930870508
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 04:43:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=pNi/EZVh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id x23so7500264pll.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 04:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=lNEVmcSJbTVHcrXiBiLxOl9V2q7+XjqpJ0ryeWCKEEY=;
        b=pNi/EZVhBot5rVfVdNuCouZbOUnOXlK0iBrJd2sS6cImd0G2J6V14XVSPgDs1y87Ii
         CR8NBUyEmMDzty+QtHAT2cwI13Y4WvVTB8QnK3GSK7HOe2qVq1G1tt9ddq0XLiOYfAxM
         roFNzHkifj3e8cBP4KcxHWoeqq2z1S+ubyB1c9bqgMki3C9WjxYHl1VJmkowSA59QHjZ
         4CYG0/tD6taYqiJNtHdFiijpIjdORvmWKc+IbMp2X0xpf4+kOOEJoUIWFHvH+zOHHoie
         9FK+kKD9Ii+euD2NMNcCf+Wkn+Ktk5U5jJwsWV8CI79zuOOdbaZG5ixR50Y6lDHvjogI
         5D4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=lNEVmcSJbTVHcrXiBiLxOl9V2q7+XjqpJ0ryeWCKEEY=;
        b=dtB+z8+f6DJ6jgn11D/apWOSuK7V4Y8SvQk0+S54j8JSnyr1yUIUU2r78VSFu5Z062
         PbXmVomLo5HxDavcfR0rEqEm/1K/9pUrz5r79fresUWfZE/lmSDdT1U/m3Dg0WPFTDFs
         DA7TpNzXhL7IcDM2zRoj7zTsskI+ktFx4WJG4KQzNvPgkMjY5+2QNS47GvkKVo7s1DO3
         AD26AMiigyyiCof/Nsv6ov1fU0GEaxxpYMzsV6mw79UEUjelNOp6F4I6SUgiGWciwNFw
         k1reWnCk0VTrfnWEpP7s6g8AzpXoEC0gU5DH9h4IAkzcXCgVvCusgUliCHLuXGEui2i0
         HsAQ==
X-Gm-Message-State: ACgBeo0ZK5fs56zhYtP6L+gnpyZFVx7b5z1fGU6SAKw/J/3RxNg6JV3X
	SeKhNLBy11cHKTOEYuGOZtaWueYdFgZNLTJueb8=
X-Google-Smtp-Source: 
 AA6agR7HieS8rHzL+Bt17JFtaHNeKGlG89xysIaGn9kA+1V3VBK8Oc5gc+ApgqlbY4OkKY2YUS463Q==
X-Received: by 2002:a17:903:2292:b0:16f:9d2:f508 with SMTP id
 b18-20020a170903229200b0016f09d2f508mr6062773plh.77.1659526997912;
        Wed, 03 Aug 2022 04:43:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 o8-20020a17090a168800b001f24c08c3fesm1396093pja.1.2022.08.03.04.43.16
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 04:43:17 -0700 (PDT)
Message-ID: <62ea5f55.170a0220.edd5f.223e@mx.google.com>
Date: Wed, 03 Aug 2022 04:43:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-24-ga6f4ea41fe167
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 31 runs,
 7 regressions (v5.10.131-cip13-24-ga6f4ea41fe167)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 11:43:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9042

cip-gitlab/ci/pavel/linux-test baseline-nfs: 31 runs, 7 regressions (v5.10.=
131-cip13-24-ga6f4ea41fe167)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
at91sam9g20ek                | arm   | lab-broonie   | gcc-10   | multi_v5_=
defconfig         | 1          =

imx6q-udoo                   | arm   | lab-broonie   | gcc-10   | imx_v6_v7=
_defconfig        | 1          =

imx6q-udoo                   | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig         | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 3          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.131-cip13-24-ga6f4ea41fe167/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.131-cip13-24-ga6f4ea41fe167
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a6f4ea41fe167f956d4000eaf276a1e383603071 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
at91sam9g20ek                | arm   | lab-broonie   | gcc-10   | multi_v5_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea526e94b4cd1aa0daf085

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-24-ga6f4ea41fe167/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-24-ga6f4ea41fe167/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62ea526e94b4cd1aa=
0daf086
        new failure (last pass: v5.10.131-cip13) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
imx6q-udoo                   | arm   | lab-broonie   | gcc-10   | imx_v6_v7=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea58a30423f3a48ddaf059

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-24-ga6f4ea41fe167/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-24-ga6f4ea41fe167/arm/imx_v6_v7_defconfig/gcc-10/lab-broon=
ie/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62ea58a30423f3a48=
ddaf05a
        new failure (last pass: v4.4-st5-586-geb97410e0086c) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
imx6q-udoo                   | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea5a6f0c65b35c96daf06b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-24-ga6f4ea41fe167/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-24-ga6f4ea41fe167/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62ea5a6f0c65b35c9=
6daf06c
        new failure (last pass: v4.4-st5-585-gc99f2b257bde) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea5046644f11ba3edaf0ac

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-24-ga6f4ea41fe167/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-24-ga6f4ea41fe167/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62ea5046644f11ba3=
edaf0ad
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 3          =


  Details:     https://kernelci.org/test/plan/id/62ea57b0606c8668ccdaf099

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-24-ga6f4ea41fe167/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-24-ga6f4ea41fe167/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.cros-ec-sensors-gyro0-probed: https://kernelci.org/=
test/case/id/62ea57b0606c8668ccdaf0dc
        failing since 84 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a)

    2022-08-03T11:10:25.724343  <8>[   93.036909] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-accel1-probed RESULT=3Dfail>
    2022-08-03T11:10:26.754831  /lava-6959219/1/../bin/lava-test-case
    2022-08-03T11:10:26.783522  <8>[   94.096497] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-gyro0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-sensors-accel1-probed: https://kernelci.org=
/test/case/id/62ea57b0606c8668ccdaf0dd
        failing since 84 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a)

    2022-08-03T11:10:25.696469  /lava-6959219/1/../bin/lava-test-case   =


  * baseline-nfs.bootrr.cros-ec-sensors-accel0-probed: https://kernelci.org=
/test/case/id/62ea57b0606c8668ccdaf0de
        failing since 84 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a)

    2022-08-03T11:10:23.603251  <8>[   90.915717] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-driver-present RESULT=3Dpass>
    2022-08-03T11:10:24.637071  /lava-6959219/1/../bin/lava-test-case
    2022-08-03T11:10:24.665732  <8>[   91.978351] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-accel0-probed RESULT=3Dfail>   =

 =20

