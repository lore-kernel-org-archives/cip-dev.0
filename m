Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B64C61DA4
	for <webhook@archiver.kernel.org>; Mon,  6 Feb 2023 11:54:44 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web10.51365.1675684474292333153
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 06 Feb 2023 03:54:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=mqVfJv38;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id o16-20020a17090ad25000b00230759a8c06so8072059pjw.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 06 Feb 2023 03:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wqpDqJi8JvnqDlCjeqqumfS+0EIYl7+Zy0F9ZCepP4M=;
        b=mqVfJv38NqdopE7KTCadO5TPvLdJxShjLOkYsp0uqypGJzPDvgjZo/hffED2UE8qAp
         WZPubLecVRdCKKLS5uLYQHBAA19nXpPqi8BlSpa2a7zhB0hq4S1FtPWrzhBkcNCdy06s
         8JEtGcGgJtKObqWS2unYQ6dSGVfql2wSFFyFjvbY4ZWKgKeQ5gM+xihTuY84doaBmWGc
         oJKZysdVMT637MtO1hhJUV3uwKtMS8xAkzfx/UQ3EmsZINxotDZTMNVUXiP1roCqlGe4
         s5ujUIFclYTLu43TpnvaYwcSF4bSW+ytxjslkFMHG7xtPkP+DU9/bfNMaSLFIevIZXvu
         BVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqpDqJi8JvnqDlCjeqqumfS+0EIYl7+Zy0F9ZCepP4M=;
        b=cWbf7FBXe7sG81AnWHGgafiXAyioP+MZvfN3+sRm3/L/a0Fh7kvFQxZrjQx/if+4ap
         3XlGDpDQ3NZnq1mB7ijzXaniwTYiYY9sGWFYbKPn1VDsox+6zDl59+pX2PtWEVJmIj6o
         1JkRM9lp7/7umfkEEtFYwZUbTp0QZGfGIFA9RTe6Ie727I3D6jhRDMqDzsnV8As5S5iU
         +Ay+/V4xrulECH6WMaOr1nKXNSFcJgLqZv0zzOr2FVZDOhdm+1SvqNOirsUrgHqxYLyI
         60uJfo/YsE15ThvY1vhPU7gENXtwwLlRG97XAgkIb0u8ScNvVobr1C3mHD47O9O6VtTM
         N54g==
X-Gm-Message-State: AO0yUKWzAURFpzvb9H3Y9hn6SuTl/UFVYWr9JTt4O2f7aydIdautDvYQ
	2rGVfhXXjQt9KrUtg9z9Ho6qat1qdiGgwiwE/NXI/A==
X-Google-Smtp-Source: AK7set9kN+F4qKBXb98rluTirD6ZS0+7C9MhELlJcmAhn2DC2x3pmTsdoRvb2eGiijbWmp/EMDIw6A==
X-Received: by 2002:a05:6a20:1603:b0:be:9b65:1f82 with SMTP id l3-20020a056a20160300b000be9b651f82mr26557917pzj.25.1675684473254;
        Mon, 06 Feb 2023 03:54:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b24-20020a639318000000b004a052e93b77sm4012592pge.7.2023.02.06.03.54.32
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 03:54:32 -0800 (PST)
Message-ID: <63e0ea78.630a0220.9c049.54c6@mx.google.com>
Date: Mon, 06 Feb 2023 03:54:32 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.271-cip90-81-g5d0e00d43751
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 38 runs,
 13 regressions (v4.19.271-cip90-81-g5d0e00d43751)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Feb 2023 11:54:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10596

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 38 runs, 13 regres=
sions (v4.19.271-cip90-81-g5d0e00d43751)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =

jetson-tk1                | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =

rk3288-veyron-jaq         | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 3          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 4          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.271-cip90-81-g5d0e00d43751/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.271-cip90-81-g5d0e00d43751
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      5d0e00d43751ec5f81c621ca2b1747e2e34d4528 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e1a2be642ed055915ed1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230127.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63e0e1a2be642ed055915ed6
        failing since 18 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:16:42.500475  + set<8>[   14.431432] <LAVA_SIGNAL_ENDRUN =
0_dmesg 9033920_1.5.2.3.1>

    2023-02-06T11:16:42.500585   +x

    2023-02-06T11:16:42.605443  / # #

    2023-02-06T11:16:42.706464  export SHELL=3D/bin/sh

    2023-02-06T11:16:42.706690  #

    2023-02-06T11:16:42.807586  / # export SHELL=3D/bin/sh. /lava-9033920/e=
nvironment

    2023-02-06T11:16:42.807823  =


    2023-02-06T11:16:42.908750  / # . /lava-9033920/environment/lava-903392=
0/bin/lava-test-runner /lava-9033920/1

    2023-02-06T11:16:42.909062  =


    2023-02-06T11:16:42.914610  / # /lava-9033920/bin/lava-test-runner /lav=
a-9033920/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e1b56b01d281a8915ec6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230127.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63e0e1b56b01d281a8915ecb
        failing since 18 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:16:49.838632  + set<8>[   19.685442] <LAVA_SIGNAL_ENDRUN =
0_dmesg 9033932_1.5.2.3.1>

    2023-02-06T11:16:49.839053   +x

    2023-02-06T11:16:49.947262  / # #

    2023-02-06T11:16:50.050128  export SHELL=3D/bin/sh

    2023-02-06T11:16:50.051011  #

    2023-02-06T11:16:50.152827  / # export SHELL=3D/bin/sh. /lava-9033932/e=
nvironment

    2023-02-06T11:16:50.153738  =


    2023-02-06T11:16:50.255678  / # . /lava-9033932/environment/lava-903393=
2/bin/lava-test-runner /lava-9033932/1

    2023-02-06T11:16:50.257114  =


    2023-02-06T11:16:50.262208  / # /lava-9033932/bin/lava-test-runner /lav=
a-9033932/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e37d610aa3ffec915ed4

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/multi_v7_defconfig/gcc-10=
/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230127.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63e0e37d610aa3ffec915ed9
        failing since 18 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:24:37.897346  [   48.662849] <LAVA_SIGNAL_ENDRUN 0_dmesg =
260365_1.6.2.4.1>
    2023-02-06T11:24:38.012504  / # #
    2023-02-06T11:24:38.115387  export SHELL=3D/bin/sh
    2023-02-06T11:24:38.116093  #
    2023-02-06T11:24:38.217937  / # export SHELL=3D/bin/sh. /lava-260365/en=
vironment
    2023-02-06T11:24:38.218533  =

    2023-02-06T11:24:38.320016  / # . /lava-260365/environment/lava-260365/=
bin/lava-test-runner /lava-260365/1
    2023-02-06T11:24:38.321359  =

    2023-02-06T11:24:38.325076  / # /lava-260365/bin/lava-test-runner /lava=
-260365/1
    2023-02-06T11:24:38.511953  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e2f4296d64429b915ed7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230127.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63e0e2f4296d64429b915edc
        failing since 18 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:22:16.423579  / # #

    2023-02-06T11:22:16.526635  export SHELL=3D/bin/sh

    2023-02-06T11:22:16.527510  #

    2023-02-06T11:22:16.629640  / # export SHELL=3D/bin/sh. /lava-9034043/e=
nvironment

    2023-02-06T11:22:16.630571  =


    2023-02-06T11:22:16.732693  / # . /lava-9034043/environment/lava-903404=
3/bin/lava-test-runner /lava-9034043/1

    2023-02-06T11:22:16.734014  =


    2023-02-06T11:22:16.735070  / # /lava-9034043/bin/lava-test-runner /lav=
a-9034043/1

    2023-02-06T11:22:16.907623  + export TESTRUN_ID=3D1_bootrr

    2023-02-06T11:22:16.907827  + cd /lava-9034043/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
jetson-tk1                | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e4565418d01941915f0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/multi_v7_defconfig/gcc-10=
/lab-baylibre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/multi_v7_defconfig/gcc-10=
/lab-baylibre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230127.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63e0e4565418d0194=
1915f0c
        failing since 12 days (last pass: v4.19.269-cip88-479-g3f9e11225caa=
5, first fail: v4.19.270-cip89-39-g43ce130174aa) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/63e0e4079043bfecb3915eca

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-nfs-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm/multi_v7_defconfig/gcc-10=
/lab-collabora/baseline-nfs-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230127.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelc=
i.org/test/case/id/63e0e4079043bfecb3915efa
        failing since 16 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:26:24.333575  <8>[   25.210019] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-driver-audio-present RESULT=3Dfail>

    2023-02-06T11:26:24.351374  seq: invalid floating point argument: =E2=
=80=98ff980000.hdmi/dw-hdmi-cec.*=E2=80=99

    2023-02-06T11:26:24.355157  Try 'seq --help' for more information.

    2023-02-06T11:26:24.358838  /lava-9034040/1/../bin/lava-test-case

    2023-02-06T11:26:24.370327  <8>[   25.248143] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.dwhdmi-rockchip-driver-audio-present: https://kerne=
lci.org/test/case/id/63e0e4079043bfecb3915efb
        failing since 16 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:26:24.311979  seq: invalid floating point argument: =E2=
=80=98ff980000.hdmi/dw-hdmi-audio-*=E2=80=99

    2023-02-06T11:26:24.316079  Try 'seq --help' for more information.

    2023-02-06T11:26:24.319599  /lava-9034040/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63e0e4079043bfecb3915f0e
        failing since 16 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:26:19.836234  + <8>[   20.715172] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 9034040_1.6.2.3.1>

    2023-02-06T11:26:19.836523  set +x

    2023-02-06T11:26:19.941529  =


    2023-02-06T11:26:20.042990  / # #export SHELL=3D/bin/sh

    2023-02-06T11:26:20.043373  =


    2023-02-06T11:26:20.144634  / # export SHELL=3D/bin/sh. /lava-9034040/e=
nvironment

    2023-02-06T11:26:20.145025  =


    2023-02-06T11:26:20.246320  / # . /lava-9034040/environment/lava-903404=
0/bin/lava-test-runner /lava-9034040/1

    2023-02-06T11:26:20.246950  =


    2023-02-06T11:26:20.249030  / # /lava-9034040/bin/lava-test-runner /lav=
a-9034040/1
 =

    ... (16 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/63e0e20b2cc3677eb5915ec7

  Results:     79 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230127.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rk3399-gru-sound-driver-rt5514-present: https://ker=
nelci.org/test/case/id/63e0e20b2cc3677eb5915efe
        failing since 18 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:18:06.044109  seq: invalid floating point argument: =E2=
=80=98sound/RT5514=E2=80=99

    2023-02-06T11:18:06.047647  Try 'seq --help' for more information.

    2023-02-06T11:18:06.051332  /lava-9034009/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-max98357A-present: https://=
kernelci.org/test/case/id/63e0e20b2cc3677eb5915eff
        failing since 18 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:18:05.982353  <8>[   36.303642] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>

    2023-02-06T11:18:06.008034  seq: invalid floating point argument: =E2=
=80=98sound/MAX98357A=E2=80=99

    2023-02-06T11:18:06.011184  Try 'seq --help' for more information.

    2023-02-06T11:18:06.015160  /lava-9034009/1/../bin/lava-test-case

    2023-02-06T11:18:06.026274  <8>[   36.347574] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-max98357A-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelc=
i.org/test/case/id/63e0e20b2cc3677eb5915f00
        failing since 18 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:18:05.947525  <8>[   36.268279] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>

    2023-02-06T11:18:05.962937  seq: invalid floating point argument: =E2=
=80=98sound/DP=E2=80=99

    2023-02-06T11:18:05.967076  Try 'seq --help' for more information.

    2023-02-06T11:18:05.970353  /lava-9034009/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rk3399-gru-sound-driver-da7219-present: https://ker=
nelci.org/test/case/id/63e0e20b2cc3677eb5915f01
        failing since 18 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:18:05.912013  <8>[   36.233834] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-present RESULT=3Dpass>

    2023-02-06T11:18:05.928403  seq: invalid floating point argument: =E2=
=80=98sound/DA7219=E2=80=99

    2023-02-06T11:18:05.932019  Try 'seq --help' for more information.

    2023-02-06T11:18:05.936369  /lava-9034009/1/../bin/lava-test-case
   =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e28ea135ac0286915f07

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-nfs-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig/gcc-10/lab-br=
oonie/baseline-nfs-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230127.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63e0e28ea135ac0286915f0c
        failing since 18 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576,=
 first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-02-06T11:20:33.975410  <8>[   26.165089] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 260332_1.6.2.4.1>
    2023-02-06T11:20:34.103743  / # #
    2023-02-06T11:20:34.205934  export SHELL=3D/bin/sh
    2023-02-06T11:20:34.206698  #
    2023-02-06T11:20:34.308608  / # export SHELL=3D/bin/sh. /lava-260332/en=
vironment
    2023-02-06T11:20:34.309094  =

    2023-02-06T11:20:34.411435  / # . /lava-260332/environment/lava-260332/=
bin/lava-test-runner /lava-260332/1
    2023-02-06T11:20:34.412712  =

    2023-02-06T11:20:34.419020  / # /lava-260332/bin/lava-test-runner /lava=
-260332/1
    2023-02-06T11:20:34.518862  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

