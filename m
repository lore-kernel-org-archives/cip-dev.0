Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F6CC54798
	for <webhook@archiver.kernel.org>; Thu, 29 Feb 2024 09:27:01 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web10.20636.1709198815485144073
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 29 Feb 2024 01:26:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=opzw/DHh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e5760eeb7aso539462b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 29 Feb 2024 01:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709198814; x=1709803614; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QYlz8gmGlgxUUTDOuL96Ikn/cvBl9FeslWMGCKi3fSM=;
        b=opzw/DHhNFP1OVpmtvMjTlHU6oWjTHhZMSNT+kRPUSaO+HaUbwC0t+/mRNWD7zPVRd
         pgQ0nyg/7C5Ue8ho9eknsF8l3mXFW6HXRsnNIMsBxXUxV16X/ufohzLygwdDuMvOdgvJ
         KMxoP7n0LzTTU5iL30ywS1c0e6GryU+e4uufa/cBpjn3cZadB/GyWBfmwiudxk5I7MyV
         h2DTOUI3xfVkHR3lbOQOfOFvzq51DQi3YCHGfugQ+plDwrdw+lIcE1c15I8QU3hGYMjp
         s4irXKZJG5xRAaWd0KM89qrLtyyiyKyrWJw/tcWvgeUP2lfwaCTO0Jt4QAJTwmG6ZrO+
         zfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709198814; x=1709803614;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QYlz8gmGlgxUUTDOuL96Ikn/cvBl9FeslWMGCKi3fSM=;
        b=DkszXueJ4Gp5Dc07ZNaktRNDpeX9cqaGCmhXT/NL856ILvYRYuSGmLzyMi4y5gGAYc
         eBYO0it7LbhehdxP28LsBLqDFBCu7oT9dtgAXzZDiJrAn6uzuyIdtQvpf78tgcvwjF1D
         1ORCdFzCMd2LaBLIARHKkAZjtHGRJXrBhHL6lcH7akZdqb/wQkAkLsdL3GAjmdznIRHB
         srAqS0nOAPqlgMm123949ShoeS8Za28SBAYxNbHdhNDqR8SupJYsIcF7ko0H5gSqg/TL
         zQeNvwrDsJM4tLma9Bj9rWnvnONQgWFX8JMj7AQK4OiakEqXSKtyfDDXu/wTQGTzqmD0
         To8Q==
X-Gm-Message-State: AOJu0YwjAtxclMY34KAWUdZNrj7soxYg55sr9+7kIEBsD50hGc8yPdVv
	kpV4G78gDMSUy/yjTSvbivpf3jTgQeZv+UuT/bykn1fsfVGeYV6gS5O09FqBBlv6RUd3/oGjcfC
	bgC8=
X-Google-Smtp-Source: AGHT+IHPUyz+K/maIaQcyip++QAty2BOxR7qHH29RRQw1vAmezHYHVOzN2ZDzSu1RPolIsFoHNvDFw==
X-Received: by 2002:a05:6a20:6d24:b0:1a1:e74:1465 with SMTP id fv36-20020a056a206d2400b001a10e741465mr1514912pzb.24.1709198814129;
        Thu, 29 Feb 2024 01:26:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u10-20020a170903124a00b001dc944299acsm959805plh.217.2024.02.29.01.26.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 01:26:53 -0800 (PST)
Message-ID: <65e04ddd.170a0220.ab21c.2a60@mx.google.com>
Date: Thu, 29 Feb 2024 01:26:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-56-g55117716ac0fd
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 80 runs,
 7 regressions (v5.10.209-cip44-56-g55117716ac0fd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Feb 2024 09:27:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15103

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 80 runs, 7 regress=
ions (v5.10.209-cip44-56-g55117716ac0fd)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig+kse=
lftest          | 1          =

juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
                | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
...ok+kselftest | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest          | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest          | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-56-g55117716ac0fd/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-56-g55117716ac0fd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      55117716ac0fd541adb5a35e66eb21c45107b040 =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65e0454aed8b61b8cb637056

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e0454aed8b61b8cb637092
        new failure (last pass: v5.10.205-905-gb40421b142370)

    2024-02-29T08:49:46.331061  <8>[   55.295882] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 646843_1.6.2.4.1>
    2024-02-29T08:49:46.452699  / # #
    2024-02-29T08:49:46.554457  export SHELL=3D/bin/sh
    2024-02-29T08:49:46.554888  #
    2024-02-29T08:49:46.656332  / # export SHELL=3D/bin/sh. /lava-646843/en=
vironment
    2024-02-29T08:49:46.657109  =

    2024-02-29T08:49:46.759109  / # . /lava-646843/environment/lava-646843/=
bin/lava-test-runner /lava-646843/1
    2024-02-29T08:49:46.760430  =

    2024-02-29T08:49:46.778566  / # /lava-646843/bin/lava-test-runner /lava=
-646843/1
    2024-02-29T08:49:47.152133  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65e0468a212479352b637029

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e0468b212479352b637065
        failing since 118 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.194-cip39-915-g96fa7f16cf02)

    2024-02-29T08:55:08.309690  <8>[   43.639577] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 646885_1.6.2.4.1>
    2024-02-29T08:55:08.427702  / # #
    2024-02-29T08:55:08.529458  export SHELL=3D/bin/sh
    2024-02-29T08:55:08.530262  #
    2024-02-29T08:55:08.632117  / # export SHELL=3D/bin/sh. /lava-646885/en=
vironment
    2024-02-29T08:55:08.632925  =

    2024-02-29T08:55:08.734885  / # . /lava-646885/environment/lava-646885/=
bin/lava-test-runner /lava-646885/1
    2024-02-29T08:55:08.736306  =

    2024-02-29T08:55:08.741496  / # /lava-646885/bin/lava-test-runner /lava=
-646885/1
    2024-02-29T08:55:08.922253  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65e03e21d33edf5146637044

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e03e21d33edf514=
6637045
        failing since 216 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65e042fba74c31462a63713e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig+kselftest/gc=
c-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig+kselftest/gc=
c-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e042fba74c31462=
a63713f
        failing since 77 days (last pass: v5.10.201-cip41-197-g2d08925b44e5=
2, first fail: v5.10.201-cip41-473-gc43d7b7bbe83a) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65e04412acc1c775bc637081

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e04412acc1c775b=
c637082
        failing since 216 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65e04292992d024818637051

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig+kselftest/gc=
c-10/lab-collabora/baseline-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig+kselftest/gc=
c-10/lab-collabora/baseline-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e04292992d024818637056
        failing since 118 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.194-cip39-915-g96fa7f16cf02)

    2024-02-29T08:38:21.458373  / # #

    2024-02-29T08:38:22.714494  export SHELL=3D/bin/sh

    2024-02-29T08:38:22.724787  #

    2024-02-29T08:38:24.460907  / # export SHELL=3D/bin/sh. /lava-12894300/=
environment

    2024-02-29T08:38:24.471221  =


    2024-02-29T08:38:27.652473  / # . /lava-12894300/environment/lava-12894=
300/bin/lava-test-runner /lava-12894300/1

    2024-02-29T08:38:27.662881  =


    2024-02-29T08:38:27.666348  / # /lava-12894300/bin/lava-test-runner /la=
va-12894300/1

    2024-02-29T08:38:28.044767  + export TESTRUN_ID=3D1_bootrr

    2024-02-29T08:38:28.044916  + cd /lava-12894300/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65e0435aa49675e26063701b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e0435aa49675e260637020
        failing since 118 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.194-cip39-915-g96fa7f16cf02)

    2024-02-29T08:41:39.911599  / # #

    2024-02-29T08:41:41.165066  export SHELL=3D/bin/sh

    2024-02-29T08:41:41.175570  #

    2024-02-29T08:41:41.176018  / # export SHELL=3D/bin/sh

    2024-02-29T08:41:42.917277  . /lava-12894466/environment

    2024-02-29T08:41:42.927580  / # . /lava-12894466/environment

    2024-02-29T08:41:46.108850  / # /lava-12894466/bin/lava-test-runner /la=
va-12894466/1

    2024-02-29T08:41:46.119606  /lava-12894466/bin/lava-test-runner /lava-1=
2894466/1

    2024-02-29T08:41:46.290300  + export TESTRUN_ID=3D1_bootrr

    2024-02-29T08:41:46.290433  + cd /lava-12894466/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =20

