Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C969EE01FD
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 17:42:32 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web10.3538.1694626945920677127
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Sep 2023 10:42:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=WOqQ3JB1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1c336f3f449so179515ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Sep 2023 10:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694626945; x=1695231745; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4n3SCkUiJ2cqKiY5Wf4mrKcVIoBB1JNxTF+LLuPuPp4=;
        b=WOqQ3JB1wfRnU8zKFdkxu0ppL4/BwLAF61ZiSdXc+8LU5zYgwafL724bzpB8JuZkF7
         FHx2BF2YltKOECOGf46G0Qxk6vVR2wfErdI9bt8IJYwK+iQ8fdEdsXpuOk/TupyXG3VN
         ijzU3NYac3ea65Mqiuh/7rFIpxVGnp0TFXuFxl5K9ygJP+BWJBepc5YCmtLYCYvduUSx
         BosyI5oD5ODPyQy8C8dHIdPpbi7OisBJ2iw96NyPHDkHIlPuVfdQAE4cuAmuYyAkB3Vn
         5Y9iCuIwnjX1QGqIimnSLDU3Wmj1A7pmDyOYXl54Ak2RDoxhml3cPVpuMBsRutswaKde
         1EUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694626945; x=1695231745;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4n3SCkUiJ2cqKiY5Wf4mrKcVIoBB1JNxTF+LLuPuPp4=;
        b=tL0jIkI8RRXAA5QJYZnE9gWI9k62gtpSqQ4z7SVIn+Crvfpl79oOpSvoPKU+3qVwj/
         ZM1xxQQgp8xqXYtLYl7psjKU8VUQ6cJUtub37J/MwAS7Gz7oTan95Mh5rzb1ZNbMsyLI
         DsKZVedtRjL8eVqtZZLYoweEgtYk8lXDa1L7jxBWSZgSY+dSvCmSPRFrIp/SNF+94Hff
         Nw4ayIVCGHXeZgh3bm7VZxDtx6uby4JQPBYctAFqhZEuhAYuwuMKzgxVTlIIUh2YMpFy
         8XXei7IFXGLsaeCX6w5MzIPTc1L1vT9wRou1tnOOsZUsa56zRiPL6EdzfePDbdcetVyk
         oXdw==
X-Gm-Message-State: AOJu0Yw0wg4d6oXrYV+6lVogeIjyTvTkV2TEUeRIjWVMMibcUY/eiPDy
	2S7jaZJBR+PMqmn5MZNuEJxS3yTLtRZvpSgKtpE=
X-Google-Smtp-Source: AGHT+IGlkSbDWctvppXpsGOMmt2XpslDKfBNZcAYnTHXWAdd5fXYHfUt9o/Ngtde0D9Iw00nafApHQ==
X-Received: by 2002:a17:903:190:b0:1bf:826:9e30 with SMTP id z16-20020a170903019000b001bf08269e30mr4193072plg.16.1694626944679;
        Wed, 13 Sep 2023 10:42:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c20d00b001b8b73da7b1sm10103629pll.227.2023.09.13.10.42.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 10:42:24 -0700 (PDT)
Message-ID: <6501f480.170a0220.4bb3f.d975@mx.google.com>
Date: Wed, 13 Sep 2023 10:42:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v6.1.52-cip5-29-g9fee06894d496
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 84 runs,
 14 regressions (v6.1.52-cip5-29-g9fee06894d496)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 17:42:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13120

cip-gitlab/ci/pavel/linux-test baseline: 84 runs, 14 regressions (v6.1.52-c=
ip5-29-g9fee06894d496)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
acer-chromebox-cxi4-puff  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-CM1400CXA-dalboz     | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

bcm2836-rpi-2-b           | arm    | lab-collabora | gcc-10   | bcm2835_def=
config            | 1          =

bcm2836-rpi-2-b           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =

hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

imx6dl-udoo               | arm    | lab-broonie   | gcc-10   | imx_v6_v7_d=
efconfig          | 1          =

imx6q-udoo                | arm    | lab-broonie   | gcc-10   | imx_v6_v7_d=
efconfig          | 1          =

imx6ul-14x14-evk          | arm    | lab-nxp       | gcc-10   | imx_v6_v7_d=
efconfig          | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

rk3288-veyron-jaq         | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.52-cip5-29-g9fee06894d496/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.52-cip5-29-g9fee06894d496
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      9fee06894d496c0a873d78633ef74e3395d81c89 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
acer-chromebox-cxi4-puff  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501ead65eab2abf3c8a0a4e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6501ead65eab2abf3c8a0=
a4f
        new failure (last pass: v5.10.191-cip38-29-g9e1aa2001db86) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501ead92d8fc45d9c8a0a5d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501ead92d8fc45d9c8a0a66
        new failure (last pass: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-13T17:00:56.469621  + set +x

    2023-09-13T17:00:56.476680  <8>[   10.618359] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11517881_1.4.2.3.1>

    2023-09-13T17:00:56.587395  =


    2023-09-13T17:00:56.689060  / # #export SHELL=3D/bin/sh

    2023-09-13T17:00:56.689883  =


    2023-09-13T17:00:56.791238  / # export SHELL=3D/bin/sh. /lava-11517881/=
environment

    2023-09-13T17:00:56.792070  =


    2023-09-13T17:00:56.893566  / # . /lava-11517881/environment/lava-11517=
881/bin/lava-test-runner /lava-11517881/1

    2023-09-13T17:00:56.893887  =


    2023-09-13T17:00:56.900135  / # /lava-11517881/bin/lava-test-runner /la=
va-11517881/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-CM1400CXA-dalboz     | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501eacbdd664989b08a0a59

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501eacbdd664989b08a0a62
        new failure (last pass: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-13T17:00:54.029405  + <8>[    9.215373] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11517863_1.4.2.3.1>

    2023-09-13T17:00:54.029491  set +x

    2023-09-13T17:00:54.133841  / # #

    2023-09-13T17:00:54.234574  export SHELL=3D/bin/sh

    2023-09-13T17:00:54.234830  #

    2023-09-13T17:00:54.335326  / # export SHELL=3D/bin/sh. /lava-11517863/=
environment

    2023-09-13T17:00:54.335547  =


    2023-09-13T17:00:54.436083  / # . /lava-11517863/environment/lava-11517=
863/bin/lava-test-runner /lava-11517863/1

    2023-09-13T17:00:54.436389  =


    2023-09-13T17:00:54.441048  / # /lava-11517863/bin/lava-test-runner /la=
va-11517863/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501ea9d1f3dc0f6d68a0a53

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501ea9d1f3dc0f6d68a0a5c
        new failure (last pass: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-13T17:00:01.742760  <8>[   10.065298] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11517897_1.4.2.3.1>

    2023-09-13T17:00:01.746325  + set +x

    2023-09-13T17:00:01.852377  =


    2023-09-13T17:00:01.954031  / # #export SHELL=3D/bin/sh

    2023-09-13T17:00:01.954796  =


    2023-09-13T17:00:02.056373  / # export SHELL=3D/bin/sh. /lava-11517897/=
environment

    2023-09-13T17:00:02.057227  =


    2023-09-13T17:00:02.158762  / # . /lava-11517897/environment/lava-11517=
897/bin/lava-test-runner /lava-11517897/1

    2023-09-13T17:00:02.160012  =


    2023-09-13T17:00:02.165045  / # /lava-11517897/bin/lava-test-runner /la=
va-11517897/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
bcm2836-rpi-2-b           | arm    | lab-collabora | gcc-10   | bcm2835_def=
config            | 1          =


  Details:     https://kernelci.org/test/plan/id/6501ea08c256555b1b8a0a69

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/arm/bcm2835_defconfig/gcc-10/lab-collabora/=
baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/arm/bcm2835_defconfig/gcc-10/lab-collabora/=
baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501ea09c256555b1b8a0a72
        failing since 28 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-09-13T17:01:45.490208  / # #

    2023-09-13T17:01:45.592389  export SHELL=3D/bin/sh

    2023-09-13T17:01:45.593093  #

    2023-09-13T17:01:45.694532  / # export SHELL=3D/bin/sh. /lava-11517791/=
environment

    2023-09-13T17:01:45.695245  =


    2023-09-13T17:01:45.796765  / # . /lava-11517791/environment/lava-11517=
791/bin/lava-test-runner /lava-11517791/1

    2023-09-13T17:01:45.797931  =


    2023-09-13T17:01:45.799989  / # /lava-11517791/bin/lava-test-runner /la=
va-11517791/1

    2023-09-13T17:01:45.924104  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-13T17:01:45.924604  + cd /lava-11517791/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
bcm2836-rpi-2-b           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6501ea95549e24e4be8a0a98

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/arm/multi_v7_defconfig/gcc-10/lab-collabora=
/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/arm/multi_v7_defconfig/gcc-10/lab-collabora=
/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6501ea95549e24e4be8a0=
a99
        failing since 28 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501ea9b549e24e4be8a0a9d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501ea9b549e24e4be8a0aa6
        failing since 28 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-09-13T16:59:55.578556  <8>[   10.519685] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11517879_1.4.2.3.1>

    2023-09-13T16:59:55.581595  + set +x

    2023-09-13T16:59:55.682983  /#

    2023-09-13T16:59:55.783787   # #export SHELL=3D/bin/sh

    2023-09-13T16:59:55.783970  =


    2023-09-13T16:59:55.884491  / # export SHELL=3D/bin/sh. /lava-11517879/=
environment

    2023-09-13T16:59:55.884674  =


    2023-09-13T16:59:55.985156  / # . /lava-11517879/environment/lava-11517=
879/bin/lava-test-runner /lava-11517879/1

    2023-09-13T16:59:55.985456  =


    2023-09-13T16:59:55.990272  / # /lava-11517879/bin/lava-test-runner /la=
va-11517879/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501eab9f16c66ee3e8a0a71

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501eab9f16c66ee3e8a0a7a
        new failure (last pass: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-13T17:00:41.647425  + set<8>[   11.343927] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11517876_1.4.2.3.1>

    2023-09-13T17:00:41.648022   +x

    2023-09-13T17:00:41.755112  / # #

    2023-09-13T17:00:41.856535  export SHELL=3D/bin/sh

    2023-09-13T17:00:41.857320  #

    2023-09-13T17:00:41.958708  / # export SHELL=3D/bin/sh. /lava-11517876/=
environment

    2023-09-13T17:00:41.959313  =


    2023-09-13T17:00:42.060594  / # . /lava-11517876/environment/lava-11517=
876/bin/lava-test-runner /lava-11517876/1

    2023-09-13T17:00:42.061930  =


    2023-09-13T17:00:42.066290  / # /lava-11517876/bin/lava-test-runner /la=
va-11517876/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6dl-udoo               | arm    | lab-broonie   | gcc-10   | imx_v6_v7_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501eec82462d348a18a0a92

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6501eec82462d348a18a0=
a93
        failing since 22 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, fir=
st fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-udoo                | arm    | lab-broonie   | gcc-10   | imx_v6_v7_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501eec929ee6d62a48a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6501eec929ee6d62a48a0=
a43
        failing since 22 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, fir=
st fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6ul-14x14-evk          | arm    | lab-nxp       | gcc-10   | imx_v6_v7_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501eede38f077bbf48a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/base=
line-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/base=
line-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6501eede38f077bbf48a0=
a43
        new failure (last pass: v5.10.191-cip38-29-g9e1aa2001db86) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501eac804b0f83d168a0a4b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501eac804b0f83d168a0a54
        new failure (last pass: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-13T17:00:34.171344  + set +x<8>[   11.421701] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11517878_1.4.2.3.1>

    2023-09-13T17:00:34.171470  =


    2023-09-13T17:00:34.276182  / # #

    2023-09-13T17:00:34.377053  export SHELL=3D/bin/sh

    2023-09-13T17:00:34.377769  #

    2023-09-13T17:00:34.479109  / # export SHELL=3D/bin/sh. /lava-11517878/=
environment

    2023-09-13T17:00:34.479809  =


    2023-09-13T17:00:34.581247  / # . /lava-11517878/environment/lava-11517=
878/bin/lava-test-runner /lava-11517878/1

    2023-09-13T17:00:34.582318  =


    2023-09-13T17:00:34.587681  / # /lava-11517878/bin/lava-test-runner /la=
va-11517878/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/6501ea0ac256555b1b8a0a75

  Results:     66 PASS, 4 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/arm/multi_v7_defconfig/gcc-10/lab-collabora=
/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/arm/multi_v7_defconfig/gcc-10/lab-collabora=
/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6501ea0ac256555b1b8a0aa9
        failing since 236 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-09-13T17:02:00.848791  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   19.711982] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-09-13T17:02:00.849042  ST

    2023-09-13T17:02:00.849281  =


    2023-09-13T17:02:00.854241  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-09-13T17:02:00.856732  FIRST, INC default to 1.

    2023-09-13T17:02:00.857113  =


    2023-09-13T17:02:00.860553  	-w	Pad to last with leading zeros

    2023-09-13T17:02:00.863199  	-s SEP	String separator

    2023-09-13T17:02:00.866917  /lava-11517808/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6501ea0ac256555b1b8a0aaa
        failing since 236 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-09-13T17:02:00.819249  <8>[   19.688877] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>

    2023-09-13T17:02:00.834280  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-09-13T17:02:00.834507  =

   =

 =20

