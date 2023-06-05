Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24A3C7EE24
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 23:10:46 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.1347.1686006640355807805
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 16:10:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=IMCQX7dP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1b039168ba0so47327905ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 16:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686006639; x=1688598639;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9nwVmkbykOfnlUL2lerX/tYjyVhbGOuV4EQMG9pvWk=;
        b=IMCQX7dPhz4GoQLve1yw4uaOYxSl5+UgyB7OCUx7Q3276j/O0L47bvzYndrRxpyvrF
         zTuEMTxA7KQx1uMT4irRNAIfRna1yEufeMB/U1gtJyAFFUH9edbRZzIz9P6bCU/WsXWR
         fFkTgzijq2dH/beAPtRqAp7V+IJhMKKRUBjKD6aaa2twDr9UoIGjZS8elr1JKU1all5+
         V6Tf7Z5vfGrmDq3QQP43y+yHQ9OKnvOJmhDYOWXB4FEWjvhPy3TQS9huv70Ky6R7ypLp
         ev+B+BntKRTyn8iauakpCIK4KFuVTu5vtEuOf0NCOG/3IN7aD3I14CulOwJK18w/4nHe
         ILaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686006639; x=1688598639;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q9nwVmkbykOfnlUL2lerX/tYjyVhbGOuV4EQMG9pvWk=;
        b=g7oGuFQiSMkpvaE+FSJhSJUnuoyfAdXtQZCslUSb75BeB9lioj+FuT/iyjeO7y+Ef+
         oJdVDvV3+s7XhYfDr2EZtSjcMqG9tVRvxnrw+RnPkupI3I1tycs75SgK+7TCT87s20aV
         53kf++URu7aGYnY6C3cssrfl61mn3zByXRQCeD39FfoPyn+tO7NDESCL2vyJvRjNtazo
         YlAbwzj9Gu7716kJmRBwEee2jKn0i6P9KCnhLPwkcy0U5KNgkrC69zLsra1gSO/YnUc3
         VTctF2CeNixDchu9Mkau9NLc2ThoK6n17f0Htv22slEi5BB5pNAwDYLrRjRRU+B057w0
         w3Eg==
X-Gm-Message-State: AC+VfDzKEH4k3NSI1VIGYZvQlCiT7ET+wKhZSc8c7Lj30MBiUzW+0sjZ
	FMvKfVpoYUDcXLFknZDoJYXYUuVGcXOgKs95Q+a76w==
X-Google-Smtp-Source: ACHHUZ4/sf/bAPZ5AaGG1rFRMGFg/Ie811sRr1phKXAGewxUXUDz6bVel/Vog6lLC+zUWvS2qB4+NQ==
X-Received: by 2002:a17:902:bd04:b0:1b0:4205:8501 with SMTP id p4-20020a170902bd0400b001b042058501mr403074pls.6.1686006638869;
        Mon, 05 Jun 2023 16:10:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jw19-20020a170903279300b00194d14d8e54sm7116221plb.96.2023.06.05.16.10.37
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 16:10:38 -0700 (PDT)
Message-ID: <647e6b6e.170a0220.8d56b.cb0b@mx.google.com>
Date: Mon, 05 Jun 2023 16:10:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1314-g1ab0ac1d7e2e3
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 51 runs,
 13 regressions (v6.1.26-1314-g1ab0ac1d7e2e3)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 23:10:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11828

cip-gitlab/ci/pavel/linux-test baseline-nfs: 51 runs, 13 regressions (v6.1.=
26-1314-g1ab0ac1d7e2e3)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig            | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1314-g1ab0ac1d7e2e3/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1314-g1ab0ac1d7e2e3
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1ab0ac1d7e2e3aeca50f8616b469772a5f010acc =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e5f53f5cf3305aaf5de2a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647e5f53f5cf3305aaf5de33
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-05T22:18:47.155905  + set +x

    2023-06-05T22:18:47.162705  <8>[   18.921355] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10597351_1.5.2.3.1>

    2023-06-05T22:18:47.266930  / # #

    2023-06-05T22:18:47.367534  export SHELL=3D/bin/sh

    2023-06-05T22:18:47.367720  #

    2023-06-05T22:18:47.468260  / # export SHELL=3D/bin/sh. /lava-10597351/=
environment

    2023-06-05T22:18:47.468502  =


    2023-06-05T22:18:47.569071  / # . /lava-10597351/environment/lava-10597=
351/bin/lava-test-runner /lava-10597351/1

    2023-06-05T22:18:47.569390  =


    2023-06-05T22:18:47.575497  / # /lava-10597351/bin/lava-test-runner /la=
va-10597351/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e5f376607e439ecf5de45

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647e5f376607e439ecf5de4e
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-05T22:18:25.136895  + <8>[   17.888430] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10597318_1.5.2.3.1>

    2023-06-05T22:18:25.136981  set +x

    2023-06-05T22:18:25.241071  / # #

    2023-06-05T22:18:25.341634  export SHELL=3D/bin/sh

    2023-06-05T22:18:25.341808  #

    2023-06-05T22:18:25.442319  / # export SHELL=3D/bin/sh. /lava-10597318/=
environment

    2023-06-05T22:18:25.442505  =


    2023-06-05T22:18:25.542998  / # . /lava-10597318/environment/lava-10597=
318/bin/lava-test-runner /lava-10597318/1

    2023-06-05T22:18:25.543313  =


    2023-06-05T22:18:25.548258  / # /lava-10597318/bin/lava-test-runner /la=
va-10597318/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e5f3484f24cf3ccf5de97

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647e5f3484f24cf3ccf5dea0
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-05T22:18:08.381303  <8>[   17.084056] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10597345_1.5.2.3.1>

    2023-06-05T22:18:08.384602  + set +x

    2023-06-05T22:18:08.488967  / # #

    2023-06-05T22:18:08.589534  export SHELL=3D/bin/sh

    2023-06-05T22:18:08.589715  #

    2023-06-05T22:18:08.690228  / # export SHELL=3D/bin/sh. /lava-10597345/=
environment

    2023-06-05T22:18:08.690374  =


    2023-06-05T22:18:08.790888  / # . /lava-10597345/environment/lava-10597=
345/bin/lava-test-runner /lava-10597345/1

    2023-06-05T22:18:08.791116  =


    2023-06-05T22:18:08.796310  / # /lava-10597345/bin/lava-test-runner /la=
va-10597345/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/647e60202bc5da3bc0f5de49

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/at91_dt_defconfig/gcc-10/lab-broonie/basel=
ine-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/at91_dt_defconfig/gcc-10/lab-broonie/basel=
ine-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647e60202bc5da3bc=
0f5de4a
        failing since 0 day (last pass: v6.1.26-1281-g84d5372e0f31, first f=
ail: v6.1.26-1301-g6369cf0363211) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647e5eb8a7a9eec4e3f5de42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/multi_v5_defconfig/gcc-10/lab-broonie/base=
line-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/multi_v5_defconfig/gcc-10/lab-broonie/base=
line-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647e5eb8a7a9eec4e=
3f5de43
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647e60107baad7e88bf5de27

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647e60107baad7e88=
bf5de28
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647e67311446246bc3f5de4b

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647e67311446246bc3f5de52
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31)

    2023-06-05T22:52:09.343929  / # #
    2023-06-05T22:52:09.447863  export SHELL=3D/bin/sh
    2023-06-05T22:52:09.448998  #
    2023-06-05T22:52:09.551543  / # export SHELL=3D/bin/sh. /lava-953765/en=
vironment
    2023-06-05T22:52:09.552689  =

    2023-06-05T22:52:09.655368  / # . /lava-953765/environment/lava-953765/=
bin/lava-test-runner /lava-953765/1
    2023-06-05T22:52:09.657156  =

    2023-06-05T22:52:09.669710  / # /lava-953765/bin/lava-test-runner /lava=
-953765/1
    2023-06-05T22:52:10.016237  + export TESTRUN_ID=3D1_bootrr
    2023-06-05T22:52:10.016905  + cd /lava-953765/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e5f3584f24cf3ccf5dea2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647e5f3584f24cf3ccf5deab
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31)

    2023-06-05T22:18:16.873885  + set<8>[   19.790791] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10597391_1.5.2.3.1>

    2023-06-05T22:18:16.873981   +x

    2023-06-05T22:18:16.978050  / # #

    2023-06-05T22:18:17.078626  export SHELL=3D/bin/sh

    2023-06-05T22:18:17.078815  #

    2023-06-05T22:18:17.179328  / # export SHELL=3D/bin/sh. /lava-10597391/=
environment

    2023-06-05T22:18:17.179516  =


    2023-06-05T22:18:17.280018  / # . /lava-10597391/environment/lava-10597=
391/bin/lava-test-runner /lava-10597391/1

    2023-06-05T22:18:17.280339  =


    2023-06-05T22:18:17.284972  / # /lava-10597391/bin/lava-test-runner /la=
va-10597391/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e5f33656eccfc99f5de5e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647e5f33656eccfc99f5de67
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-05T22:18:21.377062  + [   18.033831] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 10597376_1.5.2.3.1>

    2023-06-05T22:18:21.377151  set +x

    2023-06-05T22:18:21.481264  / # #

    2023-06-05T22:18:21.581917  export SHELL=3D/bin/sh

    2023-06-05T22:18:21.582127  #

    2023-06-05T22:18:21.682678  / # export SHELL=3D/bin/sh. /lava-10597376/=
environment

    2023-06-05T22:18:21.682929  =


    2023-06-05T22:18:21.783405  / # . /lava-10597376/environment/lava-10597=
376/bin/lava-test-runner /lava-10597376/1

    2023-06-05T22:18:21.783682  =


    2023-06-05T22:18:21.788790  / # /lava-10597376/bin/lava-test-runner /la=
va-10597376/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647e605ec29e17bbe1f5de31

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix=
/baseline-nfs-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix=
/baseline-nfs-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647e605ec29e17bbe=
1f5de32
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647e681abfd670761af5de71

  Results:     60 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm64/defconfig/gcc-10/lab-broonie/baseline-nf=
s-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm64/defconfig/gcc-10/lab-broonie/baseline-nf=
s-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647e681abfd670761af5deaf
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-05T22:56:11.197936  <8>[   58.780777] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 566039_1.6.2.4.1>
    2023-06-05T22:56:11.316862  / # #
    2023-06-05T22:56:11.419580  export SHELL=3D/bin/sh
    2023-06-05T22:56:11.420338  #
    2023-06-05T22:56:11.522217  / # export SHELL=3D/bin/sh. /lava-566039/en=
vironment
    2023-06-05T22:56:11.522949  =

    2023-06-05T22:56:11.625017  / # . /lava-566039/environment/lava-566039/=
bin/lava-test-runner /lava-566039/1
    2023-06-05T22:56:11.626296  =

    2023-06-05T22:56:11.645720  / # /lava-566039/bin/lava-test-runner /lava=
-566039/1
    2023-06-05T22:56:11.829432  + export TESTRUN_ID=3D1_bootrr =

    ... (40 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e5f3405879c1c01f5de25

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647e5f3405879c1c01f5de2e
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-05T22:18:14.205316  <8>[   17.211796] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10597365_1.5.2.3.1>

    2023-06-05T22:18:14.309782  / # #

    2023-06-05T22:18:14.410392  export SHELL=3D/bin/sh

    2023-06-05T22:18:14.410631  #

    2023-06-05T22:18:14.511136  / # export SHELL=3D/bin/sh. /lava-10597365/=
environment

    2023-06-05T22:18:14.511350  =


    2023-06-05T22:18:14.611899  / # . /lava-10597365/environment/lava-10597=
365/bin/lava-test-runner /lava-10597365/1

    2023-06-05T22:18:14.612186  =


    2023-06-05T22:18:14.617053  / # /lava-10597365/bin/lava-test-runner /la=
va-10597365/1

    2023-06-05T22:18:14.661219  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647e5c643be8b818a0f5dee7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm64/defconfig/gcc-10/lab-collabora/baseline-=
nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm64/defconfig/gcc-10/lab-collabora/baseline-=
nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647e5c643be8b818a0f5def0
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-05T22:06:13.125948  / # #

    2023-06-05T22:06:14.390620  export SHELL=3D/bin/sh

    2023-06-05T22:06:14.401631  #

    2023-06-05T22:06:16.143440  / # export SHELL=3D/bin/sh. /lava-10597180/=
environment

    2023-06-05T22:06:16.154554  =


    2023-06-05T22:06:16.155064  / # . /lava-10597180/environment

    2023-06-05T22:06:19.345377  /lava-10597180/bin/lava-test-runner /lava-1=
0597180/1

    2023-06-05T22:06:19.360555  / # /lava-10597180/bin/lava-test-runner /la=
va-10597180/1

    2023-06-05T22:06:19.512266  + export TESTRUN_ID=3D1_bootrr

    2023-06-05T22:06:19.512399  + cd /lava-10597180/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =20

