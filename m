Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F034C001B0
	for <webhook@archiver.kernel.org>; Wed,  9 Aug 2023 00:46:33 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web11.78231.1691541983641392897
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 08 Aug 2023 17:46:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=1xJNbQgO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6873a30d02eso4293100b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 08 Aug 2023 17:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691541982; x=1692146782;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IIhAiwAprZjF6D7HdYovCQOLnEWfCU3yPnabam6LKoY=;
        b=1xJNbQgOM7pdr+5TEoceSPVYZid+ra4snDAWJTeh4RAakCVVayDK3yEQz3H8pswLIQ
         sDqKoJlzP55SneQNE0Y3rUkuI/Ntw6e6eFJ3fee9Al/8JuFzAf7AiwBz8B4j57ik80MY
         7VYZ911Zp/RCtiR/GAHUlAwwI0zrgSZb/i1OHu7kRYFH/S3zNYO/zrh/cb+bIXIGmyJb
         Zfzdf/N5Gbay63yaXXr5REmd9QyxJfzXN4bWkH5jlvyDfHzKjfhsG/IRwEmdEFL0cnva
         tzKSzMwTSpNF+OtV5nMFs2hq4nbgQGgcDTPPXbyV52JvSyhuulbClWw5TjKuvXcdRElD
         LLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691541982; x=1692146782;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IIhAiwAprZjF6D7HdYovCQOLnEWfCU3yPnabam6LKoY=;
        b=L4U8t0djSbPCW4wOSSBU93QEMBN/SnIVQzstcfLpY/fLyKsDpskCCcR8NU55yQtKTC
         2ZIX20mQ8LQQlZGVEGIWQn52L7jAbNqy3cvzB8FTXK3W9cU3aIXn4CMr1W1zFlbCWkLZ
         T2Sc66eJ2aWipqCQFOvggSZfAv9ivhdPOdxwpMnG+d2qhjNhgboUCRuMlL9B6UjHyBL2
         SNi89C0fMJGVxP6lEGe0ti5f8Gk2oE3ZkuxWfy0mYamXupzSufR/nfdU8UqnM/tJNEGX
         t+sS3TdNmvy/gKZ9FIU+J5hAVyaqBsCb0hgi/8o4/IRfw35fnF/RGmiBqfHw+0ZaZEaE
         3yOA==
X-Gm-Message-State: AOJu0YykkwF++o+N0uS4biR400JTqRlNIy76C49A2n6nKsqKScPQiI5r
	f7iIk9cfXeNFB6uGoLUzDvgGY5UKywC3UFeC7h/YZw==
X-Google-Smtp-Source: AGHT+IGGbPTVU233G0PbKelDGEGBfgdhskuGTWf1M2urmvYB6cbenWROIJmIi+jeRo6BijB+xREYJA==
X-Received: by 2002:a05:6a20:914d:b0:13d:d5bd:6985 with SMTP id x13-20020a056a20914d00b0013dd5bd6985mr1207577pzc.12.1691541982386;
        Tue, 08 Aug 2023 17:46:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902c38500b001bbd1562e75sm9610499plg.55.2023.08.08.17.46.21
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 17:46:21 -0700 (PDT)
Message-ID: <64d2e1dd.170a0220.5b63e.1a16@mx.google.com>
Date: Tue, 08 Aug 2023 17:46:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.288-cip101-29-g16cdb005f330
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 19 runs,
 7 regressions (v4.19.288-cip101-29-g16cdb005f330)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Aug 2023 00:46:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12569

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 19 runs, 7 regress=
ions (v4.19.288-cip101-29-g16cdb005f330)

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

beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =

imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.288-cip101-29-g16cdb005f330/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.288-cip101-29-g16cdb005f330
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      16cdb005f330d8d819ec34feac5d718b6d169dcb =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2da0bae63dfaafd35b214

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64d2da0bae63dfaafd35b219
        failing since 201 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-09T00:12:38.585423  + set<8>[   18.433928] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11238367_1.5.2.3.1>

    2023-08-09T00:12:38.586130   +x

    2023-08-09T00:12:38.697550  #

    2023-08-09T00:12:38.798320  / # #export SHELL=3D/bin/sh

    2023-08-09T00:12:38.798492  =


    2023-08-09T00:12:38.899004  / # export SHELL=3D/bin/sh. /lava-11238367/=
environment

    2023-08-09T00:12:38.899201  =


    2023-08-09T00:12:38.999741  / # . /lava-11238367/environment/lava-11238=
367/bin/lava-test-runner /lava-11238367/1

    2023-08-09T00:12:39.000009  =


    2023-08-09T00:12:39.001649  / # /lava-11238367/bin/lava-test-runner /la=
va-11238367/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2da0c9eed9a268135b1e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64d2da0c9eed9a268135b1eb
        failing since 201 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-09T00:13:20.798798  + set<8>[   21.326516] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11238396_1.5.2.3.1>

    2023-08-09T00:13:20.799278   +x

    2023-08-09T00:13:20.907298  / # #

    2023-08-09T00:13:21.009889  export SHELL=3D/bin/sh

    2023-08-09T00:13:21.010714  #

    2023-08-09T00:13:21.112206  / # export SHELL=3D/bin/sh. /lava-11238396/=
environment

    2023-08-09T00:13:21.112987  =


    2023-08-09T00:13:21.214486  / # . /lava-11238396/environment/lava-11238=
396/bin/lava-test-runner /lava-11238396/1

    2023-08-09T00:13:21.215713  =


    2023-08-09T00:13:21.221038  / # /lava-11238396/bin/lava-test-runner /la=
va-11238396/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2db56f2d323d2d235b1eb

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/multi_v7_defconfig/gcc-1=
0/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/multi_v7_defconfig/gcc-1=
0/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64d2db57f2d323d2d235b214
        failing since 201 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-09T00:17:51.833755  <8>[   43.994576] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 39603_1.6.2.4.1>
    2023-08-09T00:17:51.949462  / # #
    2023-08-09T00:17:52.052503  export SHELL=3D/bin/sh
    2023-08-09T00:17:52.053310  #
    2023-08-09T00:17:52.155832  / # export SHELL=3D/bin/sh. /lava-39603/env=
ironment
    2023-08-09T00:17:52.156858  =

    2023-08-09T00:17:52.259680  / # . /lava-39603/environment/lava-39603/bi=
n/lava-test-runner /lava-39603/1
    2023-08-09T00:17:52.261301  =

    2023-08-09T00:17:52.264315  / # /lava-39603/bin/lava-test-runner /lava-=
39603/1
    2023-08-09T00:17:52.439583  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2db61f2d323d2d235b2aa

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64d2db61f2d323d2d235b2ad
        failing since 201 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-09T00:17:53.815797  / # #
    2023-08-09T00:17:53.919785  export SHELL=3D/bin/sh
    2023-08-09T00:17:53.920854  #
    2023-08-09T00:17:54.023273  / # export SHELL=3D/bin/sh. /lava-994554/en=
vironment
    2023-08-09T00:17:54.024337  =

    2023-08-09T00:17:54.127032  / # . /lava-994554/environment/lava-994554/=
bin/lava-test-runner /lava-994554/1
    2023-08-09T00:17:54.128735  =

    2023-08-09T00:17:54.137798  / # /lava-994554/bin/lava-test-runner /lava=
-994554/1
    2023-08-09T00:17:54.345540  + export TESTRUN_ID=3D1_bootrr
    2023-08-09T00:17:54.361355  + cd /lava-994554/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-sabrelite           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2db2576ee404e2935b260

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/multi_v7_defconfig/gcc-1=
0/lab-collabora/baseline-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm/multi_v7_defconfig/gcc-1=
0/lab-collabora/baseline-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64d2db2576ee404e2935b265
        failing since 201 days (last pass: v4.19.265-cip85-36-gf1ffb3de9576=
, first fail: v4.19.269-cip88-479-g3f9e11225caa5)

    2023-08-09T00:17:42.230073  / # #

    2023-08-09T00:17:42.332092  export SHELL=3D/bin/sh

    2023-08-09T00:17:42.332771  #

    2023-08-09T00:17:42.434146  / # export SHELL=3D/bin/sh. /lava-11238443/=
environment

    2023-08-09T00:17:42.434868  =


    2023-08-09T00:17:42.536306  / # . /lava-11238443/environment/lava-11238=
443/bin/lava-test-runner /lava-11238443/1

    2023-08-09T00:17:42.537349  =


    2023-08-09T00:17:42.539091  / # /lava-11238443/bin/lava-test-runner /la=
va-11238443/1

    2023-08-09T00:17:42.688729  + export TESTRUN_ID=3D1_bootrr

    2023-08-09T00:17:42.688877  + cd /lava-11238443/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64d2db0b263a2720be35b21c

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.288-cip101-29-g16cdb005f330/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64d2db0b263a2720be35b24f
        failing since 147 days (last pass: v4.19.273-cip92-277-g507c8d80b9e=
20, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-08-09T00:17:03.496037  /lava-11238419/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64d2db0b263a2720be35b250
        failing since 147 days (last pass: v4.19.273-cip92-277-g507c8d80b9e=
20, first fail: v4.19.276-cip93-5-g2eb2a953ab59)

    2023-08-09T00:17:02.426974  /lava-11238419/1/../bin/lava-test-case

    2023-08-09T00:17:02.455067  <8>[   39.214168] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

