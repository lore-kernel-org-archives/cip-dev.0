Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2714CC77B7A
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 13:06:01 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web10.8202.1686056755607052061
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Jun 2023 06:05:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=whXM/y+x;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-65540715b4bso1717635b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Jun 2023 06:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686056754; x=1688648754;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sWHNvcpAxPAbNEwYkSKblMDmGffZH98dpRRjorXzk0g=;
        b=whXM/y+xAxHtwyNax/z4lZp/u+SJB9tr+CQmGvewrafVgvbWCU/n0DwnHzgv53Dynq
         JfirMxciuhANQII/6135ysH7xgqGgs5c3qeuOVIC6ycPXPkOtxUqhnOtq15WZ69P8nDb
         eNilmWSHO55STVyQb/uwfIK8fGNH1t3LbGQOxOajjKRvq5eETvMdruOnYZq7LZp9oCIa
         y57An5is9p9oaxYa0FyKUbJzMCB6zqYUCGkFdixlrIpVT4M4sthsmS2omYoLbR9cRXyQ
         1pn/myCf9BCyXP6t5AkxtHpAICRsSqQVnZczOXUviouITqJUjtOZNIW3XWYgHhNTs8MP
         B9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686056754; x=1688648754;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWHNvcpAxPAbNEwYkSKblMDmGffZH98dpRRjorXzk0g=;
        b=lhNwqawUffBDacnjqP4XjwB/dhRDNgLnrMzbcUYEfdLonYQZrv7Joqnm4TU0mZ9UnN
         3vmJP/I4w8BQT6GAI51FkszJAQt9aKlZ7zI/fQWOCEIfUwakVG4QtnPTQlrOFmpez8cj
         25wpABXs1YMdjeJhmi7DWcjAXUvwSYQVxEphocIaC1867WJYCu2gdAsT+DMVtJKHBRHi
         TF/oy5G2DnBccleP/12iDInqzWuBtWe49EQKTw4EI/V4W7yqQUys5htQdilvaSs/qQ//
         rUqhmg4aR1J9DWOLdfJSu7J5skSn/GW2nR9tKyFsJ3LybsQgnWFkY1Od2T63Tte3PWe2
         9jDQ==
X-Gm-Message-State: AC+VfDxQAalWveBbZjg/d6QI+XMEW7OqkikW5VXj/zcqUxTCQjLbnQQd
	lYZ0IVPtwzq91+FfWjdWe7EQArBQRVHRcb+PsoJM0A==
X-Google-Smtp-Source: ACHHUZ4et7dhSraXCbHqZ513cb5A663JW5Zz2nQmNhCsGDMLmkMwGuxz+RkhXzXcZgsLonT06JQoYw==
X-Received: by 2002:a05:6a20:394f:b0:10d:5390:eadb with SMTP id r15-20020a056a20394f00b0010d5390eadbmr1191968pzg.2.1686056754135;
        Tue, 06 Jun 2023 06:05:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c21-20020a631c55000000b0051b7d83ff22sm7438045pgm.80.2023.06.06.06.05.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 06:05:53 -0700 (PDT)
Message-ID: <647f2f31.630a0220.c88c3.d17c@mx.google.com>
Date: Tue, 06 Jun 2023 06:05:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1320-g1ddf4b637f785
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 41 runs,
 11 regressions (v6.1.26-1320-g1ddf4b637f785)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 13:06:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11883

cip-gitlab/ci/pavel/linux-test baseline-nfs: 41 runs, 11 regressions (v6.1.=
26-1320-g1ddf4b637f785)

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

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

dell-latitude...4305U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1320-g1ddf4b637f785/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1320-g1ddf4b637f785
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1ddf4b637f7858373296265fe09135a077008de6 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f21b38cef7c8947f5de6f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647f21b38cef7c8947f5de78
        failing since 0 day (last pass: v5.10.180-cip34-26-gc198172c84b6a, =
first fail: v6.1.26-1321-g3152fb7c8d2d6)

    2023-06-06T12:07:54.663588  + set +x

    2023-06-06T12:07:54.669942  <8>[   19.910196] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10605264_1.5.2.3.1>

    2023-06-06T12:07:54.779587  #

    2023-06-06T12:07:54.882407  / # #export SHELL=3D/bin/sh

    2023-06-06T12:07:54.883269  =


    2023-06-06T12:07:54.984779  / # export SHELL=3D/bin/sh. /lava-10605264/=
environment

    2023-06-06T12:07:54.985722  =


    2023-06-06T12:07:55.087380  / # . /lava-10605264/environment/lava-10605=
264/bin/lava-test-runner /lava-10605264/1

    2023-06-06T12:07:55.088820  =


    2023-06-06T12:07:55.095302  / # /lava-10605264/bin/lava-test-runner /la=
va-10605264/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f218f156b68448ff5de82

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647f218f156b68448ff5de8b
        failing since 0 day (last pass: v5.10.180-cip34-26-gc198172c84b6a, =
first fail: v6.1.26-1321-g3152fb7c8d2d6)

    2023-06-06T12:07:36.401087  <8>[   18.269887] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10605217_1.5.2.3.1>

    2023-06-06T12:07:36.510619  / # #

    2023-06-06T12:07:36.613071  export SHELL=3D/bin/sh

    2023-06-06T12:07:36.613903  #

    2023-06-06T12:07:36.715471  / # export SHELL=3D/bin/sh. /lava-10605217/=
environment

    2023-06-06T12:07:36.716247  =


    2023-06-06T12:07:36.817712  / # . /lava-10605217/environment/lava-10605=
217/bin/lava-test-runner /lava-10605217/1

    2023-06-06T12:07:36.818956  =


    2023-06-06T12:07:36.824276  / # /lava-10605217/bin/lava-test-runner /la=
va-10605217/1

    2023-06-06T12:07:36.931375  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f218e156b68448ff5de77

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647f218e156b68448ff5de80
        failing since 0 day (last pass: v5.10.180-cip34-26-gc198172c84b6a, =
first fail: v6.1.26-1321-g3152fb7c8d2d6)

    2023-06-06T12:07:36.117657  + set +x

    2023-06-06T12:07:36.124670  [   17.699981] <LAVA_SIGNAL_ENDRUN 0_dmesg =
10605233_1.5.2.3.1>

    2023-06-06T12:07:36.229125  / # #

    2023-06-06T12:07:36.331696  export SHELL=3D/bin/sh

    2023-06-06T12:07:36.332484  #

    2023-06-06T12:07:36.433923  / # export SHELL=3D/bin/sh. /lava-10605233/=
environment

    2023-06-06T12:07:36.434767  =


    2023-06-06T12:07:36.536206  / # . /lava-10605233/environment/lava-10605=
233/bin/lava-test-runner /lava-10605233/1

    2023-06-06T12:07:36.537576  =


    2023-06-06T12:07:36.542676  / # /lava-10605233/bin/lava-test-runner /la=
va-10605233/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647f2327c4550a5e90f5e173

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647f2327c4550a5e90f5e1ad
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31)

    2023-06-06T12:14:15.290135  + set +x
    2023-06-06T12:14:15.294261  <8>[   48.417753] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 568858_1.6.2.4.1>
    2023-06-06T12:14:15.416188  / # #
    2023-06-06T12:14:15.518924  export SHELL=3D/bin/sh
    2023-06-06T12:14:15.519686  #
    2023-06-06T12:14:15.622088  / # export SHELL=3D/bin/sh. /lava-568858/en=
vironment
    2023-06-06T12:14:15.622810  =

    2023-06-06T12:14:15.725258  / # . /lava-568858/environment/lava-568858/=
bin/lava-test-runner /lava-568858/1
    2023-06-06T12:14:15.726407  =

    2023-06-06T12:14:15.731278  / # /lava-568858/bin/lava-test-runner /lava=
-568858/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647f25725193b2bb07f5de41

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647f25725193b2bb07f5de48
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31)

    2023-06-06T12:23:51.551693  / # #
    2023-06-06T12:23:51.655360  export SHELL=3D/bin/sh
    2023-06-06T12:23:51.656458  #
    2023-06-06T12:23:51.758743  / # export SHELL=3D/bin/sh. /lava-954667/en=
vironment
    2023-06-06T12:23:51.759865  =

    2023-06-06T12:23:51.862368  / # . /lava-954667/environment/lava-954667/=
bin/lava-test-runner /lava-954667/1
    2023-06-06T12:23:51.864066  =

    2023-06-06T12:23:51.877811  / # /lava-954667/bin/lava-test-runner /lava=
-954667/1
    2023-06-06T12:23:52.225384  + export TESTRUN_ID=3D1_bootrr
    2023-06-06T12:23:52.226142  + cd /lava-954667/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f2298f533d70690f5de29

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647f2298f533d7069=
0f5de2a
        new failure (last pass: v6.1.26-1321-g3152fb7c8d2d6) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f21a0f106f669a2f5de30

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647f21a0f106f669a2f5de39
        failing since 2 days (last pass: v4.19.280-cip95-rt30, first fail: =
v6.1.26-1281-g84d5372e0f31)

    2023-06-06T12:07:42.013355  + set +x

    2023-06-06T12:07:42.019779  <8>[   19.634573] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10605267_1.5.2.3.1>

    2023-06-06T12:07:42.124385  / # #

    2023-06-06T12:07:42.225031  export SHELL=3D/bin/sh

    2023-06-06T12:07:42.225195  #

    2023-06-06T12:07:42.325671  / # export SHELL=3D/bin/sh. /lava-10605267/=
environment

    2023-06-06T12:07:42.325894  =


    2023-06-06T12:07:42.426425  / # . /lava-10605267/environment/lava-10605=
267/bin/lava-test-runner /lava-10605267/1

    2023-06-06T12:07:42.426778  =


    2023-06-06T12:07:42.431641  / # /lava-10605267/bin/lava-test-runner /la=
va-10605267/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f2189f8edafb574f5de9a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647f2189f8edafb574f5dea3
        failing since 0 day (last pass: v5.10.180-cip34-26-gc198172c84b6a, =
first fail: v6.1.26-1321-g3152fb7c8d2d6)

    2023-06-06T12:07:28.237828  + <8>[   17.754748] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10605206_1.5.2.3.1>

    2023-06-06T12:07:28.237950  set +x

    2023-06-06T12:07:28.342424  / # #

    2023-06-06T12:07:28.443085  export SHELL=3D/bin/sh

    2023-06-06T12:07:28.443306  #

    2023-06-06T12:07:28.543896  / # export SHELL=3D/bin/sh. /lava-10605206/=
environment

    2023-06-06T12:07:28.544156  =


    2023-06-06T12:07:28.644799  / # . /lava-10605206/environment/lava-10605=
206/bin/lava-test-runner /lava-10605206/1

    2023-06-06T12:07:28.645120  =


    2023-06-06T12:07:28.650418  / # /lava-10605206/bin/lava-test-runner /la=
va-10605206/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647f239e77b08c9d6bf5de26

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix=
/baseline-nfs-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix=
/baseline-nfs-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647f239e77b08c9d6=
bf5de27
        failing since 0 day (last pass: v5.10.180-cip34-26-gc198172c84b6a, =
first fail: v6.1.26-1314-g1ab0ac1d7e2e3) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647f2688d5cfca2fd2f5dfc9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647f2688d5cfca2fd=
2f5dfca
        new failure (last pass: v6.1.26-1321-g3152fb7c8d2d6) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f21909d346092d5f5de3a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647f21909d346092d5f5de43
        failing since 0 day (last pass: v5.10.180-cip34-26-gc198172c84b6a, =
first fail: v6.1.26-1321-g3152fb7c8d2d6)

    2023-06-06T12:07:24.825666  + <8>[   18.266886] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10605235_1.5.2.3.1>

    2023-06-06T12:07:24.825751  set +x

    2023-06-06T12:07:24.929730  / # #

    2023-06-06T12:07:25.030263  export SHELL=3D/bin/sh

    2023-06-06T12:07:25.030489  #

    2023-06-06T12:07:25.131013  / # export SHELL=3D/bin/sh. /lava-10605235/=
environment

    2023-06-06T12:07:25.131214  =


    2023-06-06T12:07:25.231719  / # . /lava-10605235/environment/lava-10605=
235/bin/lava-test-runner /lava-10605235/1

    2023-06-06T12:07:25.232019  =


    2023-06-06T12:07:25.237266  / # /lava-10605235/bin/lava-test-runner /la=
va-10605235/1
 =

    ... (12 line(s) more)  =

 =20

