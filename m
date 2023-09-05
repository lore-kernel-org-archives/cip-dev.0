Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63722EE49B7
	for <webhook@archiver.kernel.org>; Tue,  5 Sep 2023 22:51:56 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web11.36687.1693954307968033314
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Sep 2023 15:51:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Ygt7d1Ac;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1c34c9cc9b9so11125565ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 05 Sep 2023 15:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693954307; x=1694559107; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pxT7xvr9yrAvyA356K9f4npXWCtZedWrdnS49NVmAvc=;
        b=Ygt7d1AcxdavZBQwOXRdu56mQJqT7p2foxOvnrvzaisd2zxAaXAo1hInfu6OR54X7n
         ZDVyyMYjxcDzJQKRQ4aBxIgQmI9VG0lTtKdqjpSwhoOeRXkVUqrZlSY5C0LfH6ZTQyLp
         pAgrwLOZ50J0YG6eYw6sR/ZxUQlrOdxNegK3f0Us69umJ+jKF2U49KSsAGfb6bT0oYpi
         oWpBIGk36T1TLKTduOICInVlzZFj45mG6FhP6X/lw6+kNlsHWU7cUjT/8DCjozgdVqW5
         j7yR7XQSbM6U4KuaLjqv35WTAT6/zTgVs7XjMMnAzLep936uHaHkhzeDhBIYEpUjbE8n
         Bk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693954307; x=1694559107;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxT7xvr9yrAvyA356K9f4npXWCtZedWrdnS49NVmAvc=;
        b=WhZZDKc5/142HSZojBeB41UdW9vwy5ReiPINLD5LAYBMOhbuW/+QahLD1tXb31Z6Cw
         vCcpAoBSx/RHlF6Ri9E25c9f+1M0Y8HZ6rwnVsyic0HbY0oMuagonwP4exps+4+E7HUM
         p/rAjteTatLJXaDEqx6ND4nakpkLuKVehNmvYm3R15Y+nGavERPUN9RyrLL9wCKe2AS8
         AqlEs3TKUV3qgz/ptiNkk9tInnmSZ8cOYUeutvxVjDVm0BjErlHy2ke77typKVQwlaxe
         sGQijJRSgEncGHCjFjzjB4eCqbnI4qT3mUHbGV6eLl1AYM+/6U1rN0KbBYqJphPijDH1
         eiHw==
X-Gm-Message-State: AOJu0YxCLkqoSkxExrvjn31n6QYPWgAOujzf+R7ZYPHHGNlk2g16NWuZ
	N4JIHBkKZ1l91eazN7BBbhgOVmidG5kzbrJCVV0=
X-Google-Smtp-Source: AGHT+IF3onrWXFoPLRFTaWjOFR3TK2y5fVCLtbcm5WpO86KkpySdPWLOczRfGp+eksUhao3CzDIa5Q==
X-Received: by 2002:a17:902:9a43:b0:1b8:9552:ca with SMTP id x3-20020a1709029a4300b001b8955200camr11344040plv.45.1693954305879;
        Tue, 05 Sep 2023 15:51:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902ce9100b001bdc66478c1sm9767147plg.309.2023.09.05.15.51.45
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 15:51:45 -0700 (PDT)
Message-ID: <64f7b101.170a0220.ee3c2.55e4@mx.google.com>
Date: Tue, 05 Sep 2023 15:51:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.46-cip4-14-gb994de8f45440
Subject: cip-gitlab/ci/pavel/linux-test baseline: 128 runs,
 23 regressions (v6.1.46-cip4-14-gb994de8f45440)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Sep 2023 22:51:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12964

cip-gitlab/ci/pavel/linux-test baseline: 128 runs, 23 regressions (v6.1.46-=
cip4-14-gb994de8f45440)

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

fsl-ls1088a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =

fsl-ls2088a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =

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

imx8mp-evk                | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

r8a7743-iwg20d-q7         | arm    | lab-cip       | gcc-10   | shmobile_de=
fconfig           | 1          =

r8a774c0-ek874            | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

r8a774c0-ek874            | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 1          =

r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

rk3288-veyron-jaq         | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 2          =

rk3399-rock-pi-4b         | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.46-cip4-14-gb994de8f45440/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.46-cip4-14-gb994de8f45440
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b994de8f45440fdf9186ead9b3a13945833c1547 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
acer-chromebox-cxi4-puff  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a2c59150eb6735286db9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f7a2c59150eb6735286=
dba
        new failure (last pass: v5.10.191-cip38-2-g05fb42f86d06a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a2ba70b04a1fab286d92

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f7a2ba70b04a1fab286d97
        new failure (last pass: v5.10.191-cip38-2-g05fb42f86d06a)

    2023-09-05T21:50:39.323075  + set +x

    2023-09-05T21:50:39.329347  <8>[   12.367109] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11440150_1.4.2.3.1>

    2023-09-05T21:50:39.437514  / # #

    2023-09-05T21:50:39.539897  export SHELL=3D/bin/sh

    2023-09-05T21:50:39.540671  #

    2023-09-05T21:50:39.642205  / # export SHELL=3D/bin/sh. /lava-11440150/=
environment

    2023-09-05T21:50:39.642985  =


    2023-09-05T21:50:39.744455  / # . /lava-11440150/environment/lava-11440=
150/bin/lava-test-runner /lava-11440150/1

    2023-09-05T21:50:39.744827  =


    2023-09-05T21:50:39.749620  / # /lava-11440150/bin/lava-test-runner /la=
va-11440150/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-CM1400CXA-dalboz     | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a2a6bb14eeb100286dcd

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f7a2a6bb14eeb100286dd2
        new failure (last pass: v5.10.191-cip38-2-g05fb42f86d06a)

    2023-09-05T21:50:22.328647  + set<8>[   12.090045] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11440147_1.4.2.3.1>

    2023-09-05T21:50:22.328753   +x

    2023-09-05T21:50:22.433318  / # #

    2023-09-05T21:50:22.533925  export SHELL=3D/bin/sh

    2023-09-05T21:50:22.534105  #

    2023-09-05T21:50:22.634571  / # export SHELL=3D/bin/sh. /lava-11440147/=
environment

    2023-09-05T21:50:22.634730  =


    2023-09-05T21:50:22.735219  / # . /lava-11440147/environment/lava-11440=
147/bin/lava-test-runner /lava-11440147/1

    2023-09-05T21:50:22.735450  =


    2023-09-05T21:50:22.740000  / # /lava-11440147/bin/lava-test-runner /la=
va-11440147/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a29f1be67163a6286dc6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f7a29f1be67163a6286dcb
        new failure (last pass: v5.10.191-cip38-2-g05fb42f86d06a)

    2023-09-05T21:50:15.110837  <8>[   10.109454] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11440148_1.4.2.3.1>

    2023-09-05T21:50:15.113800  + set +x

    2023-09-05T21:50:15.215253  =


    2023-09-05T21:50:15.315792  / # #export SHELL=3D/bin/sh

    2023-09-05T21:50:15.316023  =


    2023-09-05T21:50:15.416551  / # export SHELL=3D/bin/sh. /lava-11440148/=
environment

    2023-09-05T21:50:15.416795  =


    2023-09-05T21:50:15.517362  / # . /lava-11440148/environment/lava-11440=
148/bin/lava-test-runner /lava-11440148/1

    2023-09-05T21:50:15.517686  =


    2023-09-05T21:50:15.522826  / # /lava-11440148/bin/lava-test-runner /la=
va-11440148/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
bcm2836-rpi-2-b           | arm    | lab-collabora | gcc-10   | bcm2835_def=
config            | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a3321d401e602a286d81

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm/bcm2835_defconfig/gcc-10/lab-collabora/=
baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm/bcm2835_defconfig/gcc-10/lab-collabora/=
baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f7a3331d401e602a286d86
        failing since 20 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-09-05T21:54:12.028617  / # #

    2023-09-05T21:54:12.129189  export SHELL=3D/bin/sh

    2023-09-05T21:54:12.129343  #

    2023-09-05T21:54:12.229819  / # export SHELL=3D/bin/sh. /lava-11440174/=
environment

    2023-09-05T21:54:12.229983  =


    2023-09-05T21:54:12.330461  / # . /lava-11440174/environment/lava-11440=
174/bin/lava-test-runner /lava-11440174/1

    2023-09-05T21:54:12.330696  =


    2023-09-05T21:54:12.342140  / # /lava-11440174/bin/lava-test-runner /la=
va-11440174/1

    2023-09-05T21:54:12.456871  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-05T21:54:12.456993  + cd /lava-11440174/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
bcm2836-rpi-2-b           | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a98773f19972a0286d8e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm/multi_v7_defconfig/gcc-10/lab-collabora=
/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm/multi_v7_defconfig/gcc-10/lab-collabora=
/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f7a98773f19972a0286=
d8f
        failing since 20 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
fsl-ls1088a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a8861de2b6301f286d95

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl=
-ls1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl=
-ls1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f7a8861de2b6301f286d98
        failing since 20 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-09-05T22:15:08.710391  [   18.161379] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1249620_1.5.2.4.1>
    2023-09-05T22:15:08.815646  =

    2023-09-05T22:15:08.916800  / # #export SHELL=3D/bin/sh
    2023-09-05T22:15:08.917209  =

    2023-09-05T22:15:09.018149  / # export SHELL=3D/bin/sh. /lava-1249620/e=
nvironment
    2023-09-05T22:15:09.018579  =

    2023-09-05T22:15:09.119589  / # . /lava-1249620/environment/lava-124962=
0/bin/lava-test-runner /lava-1249620/1
    2023-09-05T22:15:09.120308  =

    2023-09-05T22:15:09.124394  / # /lava-1249620/bin/lava-test-runner /lav=
a-1249620/1
    2023-09-05T22:15:09.142758  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
fsl-ls2088a-rdb           | arm64  | lab-nxp       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a84b1de2b6301f286d6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl=
-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl=
-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f7a84b1de2b6301f286d6f
        failing since 20 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-09-05T22:14:14.627203  + [   18.497464] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1249619_1.5.2.4.1>
    2023-09-05T22:14:14.627488  set +x
    2023-09-05T22:14:14.732497  =

    2023-09-05T22:14:14.833633  / # #export SHELL=3D/bin/sh
    2023-09-05T22:14:14.834024  =

    2023-09-05T22:14:14.934941  / # export SHELL=3D/bin/sh. /lava-1249619/e=
nvironment
    2023-09-05T22:14:14.935356  =

    2023-09-05T22:14:15.036304  / # . /lava-1249619/environment/lava-124961=
9/bin/lava-test-runner /lava-1249619/1
    2023-09-05T22:14:15.036962  =

    2023-09-05T22:14:15.041187  / # /lava-1249619/bin/lava-test-runner /lav=
a-1249619/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a5597c830559d6286d6f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f7a5597c830559d6286d74
        failing since 20 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-09-05T22:01:42.873797  + set +x

    2023-09-05T22:01:42.879972  <8>[   10.856401] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11440111_1.4.2.3.1>

    2023-09-05T22:01:42.987771  / # #

    2023-09-05T22:01:43.089953  export SHELL=3D/bin/sh

    2023-09-05T22:01:43.090120  #

    2023-09-05T22:01:43.190747  / # export SHELL=3D/bin/sh. /lava-11440111/=
environment

    2023-09-05T22:01:43.191059  =


    2023-09-05T22:01:43.291909  / # . /lava-11440111/environment/lava-11440=
111/bin/lava-test-runner /lava-11440111/1

    2023-09-05T22:01:43.293992  =


    2023-09-05T22:01:43.298765  / # /lava-11440111/bin/lava-test-runner /la=
va-11440111/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a2a79150eb6735286d6c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f7a2a79150eb6735286d71
        new failure (last pass: v5.10.191-cip38-2-g05fb42f86d06a)

    2023-09-05T21:50:17.682967  + set<8>[   11.298128] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11440158_1.4.2.3.1>

    2023-09-05T21:50:17.683054   +x

    2023-09-05T21:50:17.787246  / # #

    2023-09-05T21:50:17.887996  export SHELL=3D/bin/sh

    2023-09-05T21:50:17.888183  #

    2023-09-05T21:50:17.988711  / # export SHELL=3D/bin/sh. /lava-11440158/=
environment

    2023-09-05T21:50:17.988895  =


    2023-09-05T21:50:18.089432  / # . /lava-11440158/environment/lava-11440=
158/bin/lava-test-runner /lava-11440158/1

    2023-09-05T21:50:18.089740  =


    2023-09-05T21:50:18.094212  / # /lava-11440158/bin/lava-test-runner /la=
va-11440158/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6dl-udoo               | arm    | lab-broonie   | gcc-10   | imx_v6_v7_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a70091f8bf9e9f286d79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f7a70091f8bf9e9f286=
d7a
        failing since 14 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, fir=
st fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-udoo                | arm    | lab-broonie   | gcc-10   | imx_v6_v7_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a70291f8bf9e9f286d7f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f7a70291f8bf9e9f286=
d80
        failing since 14 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, fir=
st fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6ul-14x14-evk          | arm    | lab-nxp       | gcc-10   | imx_v6_v7_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a71e91f8bf9e9f286d88

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/base=
line-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/base=
line-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f7a71e91f8bf9e9f286=
d89
        new failure (last pass: v5.10.191-cip38-2-g05fb42f86d06a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx8mp-evk                | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a82d79990f65dc286d8f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm64/defconfig/gcc-10/lab-broonie/baseline=
-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm64/defconfig/gcc-10/lab-broonie/baseline=
-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f7a82d79990f65dc286d94
        failing since 14 days (last pass: v5.10.186-cip37-16-gf8567732a40d,=
 first fail: v6.1.45-cip3-31-gbae6b8e9a2cff)

    2023-09-05T22:13:54.516351  <8>[   20.302075] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-09-05T22:13:54.519967  + set<8>[   20.311412] <LAVA_SIGNAL_ENDRUN =
0_dmesg 88265_1.5.2.4.1>
    2023-09-05T22:13:54.520574   +x
    2023-09-05T22:13:54.629056  / # #
    2023-09-05T22:13:55.794926  export SHELL=3D/bin/sh
    2023-09-05T22:13:55.801077  #
    2023-09-05T22:13:57.244593  / # export SHELL=3D/bin/sh. /lava-88265/env=
ironment
    2023-09-05T22:13:57.250740  =

    2023-09-05T22:13:59.862651  / # . /lava-88265/environment/lava-88265/bi=
n/lava-test-runner /lava-88265/1
    2023-09-05T22:13:59.869316   =

    ... (18 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a282ab706c385e286d9c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f7a282ab706c385e286da1
        new failure (last pass: v5.10.191-cip38-2-g05fb42f86d06a)

    2023-09-05T21:50:01.105581  + <8>[   11.283419] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11440132_1.4.2.3.1>

    2023-09-05T21:50:01.106122  set +x

    2023-09-05T21:50:01.214427  / # #

    2023-09-05T21:50:01.317140  export SHELL=3D/bin/sh

    2023-09-05T21:50:01.317930  #

    2023-09-05T21:50:01.419417  / # export SHELL=3D/bin/sh. /lava-11440132/=
environment

    2023-09-05T21:50:01.420151  =


    2023-09-05T21:50:01.521674  / # . /lava-11440132/environment/lava-11440=
132/bin/lava-test-runner /lava-11440132/1

    2023-09-05T21:50:01.523035  =


    2023-09-05T21:50:01.528207  / # /lava-11440132/bin/lava-test-runner /la=
va-11440132/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a7743-iwg20d-q7         | arm    | lab-cip       | gcc-10   | shmobile_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a40e2b346de35f286dd4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm/shmobile_defconfig/gcc-10/lab-cip/basel=
ine-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm/shmobile_defconfig/gcc-10/lab-cip/basel=
ine-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f7a40e2b346de35f286=
dd5
        new failure (last pass: v5.10.191-cip38-2-g05fb42f86d06a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774c0-ek874            | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a80a2d4589983d286dab

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f7a80a2d4589983d286dae
        failing since 20 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-09-05T22:13:09.515383  / # #
    2023-09-05T22:13:10.975425  export SHELL=3D/bin/sh
    2023-09-05T22:13:10.995883  #
    2023-09-05T22:13:10.996019  / # export SHELL=3D/bin/sh
    2023-09-05T22:13:12.948895  / # . /lava-1005574/environment
    2023-09-05T22:13:16.542052  /lava-1005574/bin/lava-test-runner /lava-10=
05574/1
    2023-09-05T22:13:16.562637  . /lava-1005574/environment
    2023-09-05T22:13:16.562749  / # /lava-1005574/bin/lava-test-runner /lav=
a-1005574/1
    2023-09-05T22:13:16.604345  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-05T22:13:16.656719  + cd /lava-1005574/1/tests/1_bootrr =

    ... (26 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774c0-ek874            | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a8d3d5eac4e36b286d94

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm64/defconfig/gcc-10/lab-cip/baseline-r8a=
774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm64/defconfig/gcc-10/lab-cip/baseline-r8a=
774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f7a8d3d5eac4e36b286d97
        new failure (last pass: v6.1.46-cip4-rt2)

    2023-09-05T22:16:31.792647  / # #
    2023-09-05T22:16:33.254910  export SHELL=3D/bin/sh
    2023-09-05T22:16:33.275436  #
    2023-09-05T22:16:33.275641  / # export SHELL=3D/bin/sh
    2023-09-05T22:16:35.230615  / # . /lava-1005583/environment
    2023-09-05T22:16:38.824631  /lava-1005583/bin/lava-test-runner /lava-10=
05583/1
    2023-09-05T22:16:38.845224  . /lava-1005583/environment
    2023-09-05T22:16:38.845331  / # /lava-1005583/bin/lava-test-runner /lav=
a-1005583/1
    2023-09-05T22:16:38.935122  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-05T22:16:38.935254  + cd /lava-1005583/1/tests/1_bootrr =

    ... (26 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a81f2d4589983d286e1b

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm64/defconfig/gcc-10/lab-collabora/baseli=
ne-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm64/defconfig/gcc-10/lab-collabora/baseli=
ne-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f7a81f2d4589983d286e20
        failing since 48 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-09-05T22:15:13.059878  / # #

    2023-09-05T22:15:13.162081  export SHELL=3D/bin/sh

    2023-09-05T22:15:13.162782  #

    2023-09-05T22:15:13.264186  / # export SHELL=3D/bin/sh. /lava-11440317/=
environment

    2023-09-05T22:15:13.264922  =


    2023-09-05T22:15:13.366370  / # . /lava-11440317/environment/lava-11440=
317/bin/lava-test-runner /lava-11440317/1

    2023-09-05T22:15:13.367459  =


    2023-09-05T22:15:13.383903  / # /lava-11440317/bin/lava-test-runner /la=
va-11440317/1

    2023-09-05T22:15:13.432450  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-05T22:15:13.433006  + cd /lav<8>[   19.138725] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11440317_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a8430737cb9e1c286da4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm64/defconfig/gcc-10/lab-collabora/baseli=
ne-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm64/defconfig/gcc-10/lab-collabora/baseli=
ne-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f7a8430737cb9e1c286da9
        failing since 14 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v6.1.45-cip3-31-gbae6b8e9a2cff)

    2023-09-05T22:15:26.787007  / # #

    2023-09-05T22:15:27.865849  export SHELL=3D/bin/sh

    2023-09-05T22:15:27.867638  #

    2023-09-05T22:15:29.356497  / # export SHELL=3D/bin/sh. /lava-11440322/=
environment

    2023-09-05T22:15:29.358273  =


    2023-09-05T22:15:32.079081  / # . /lava-11440322/environment/lava-11440=
322/bin/lava-test-runner /lava-11440322/1

    2023-09-05T22:15:32.081232  =


    2023-09-05T22:15:32.093645  / # /lava-11440322/bin/lava-test-runner /la=
va-11440322/1

    2023-09-05T22:15:32.109593  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-05T22:15:32.152612  + cd /lava-114403<8>[   28.451074] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11440322_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/64f7a93859eecbfa8d286d87

  Results:     66 PASS, 4 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm/multi_v7_defconfig/gcc-10/lab-collabora=
/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm/multi_v7_defconfig/gcc-10/lab-collabora=
/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64f7a93859eecbfa8d286db7
        failing since 228 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-09-05T22:20:01.785511  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   19.616889] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-09-05T22:20:01.785889  ST

    2023-09-05T22:20:01.785946  =


    2023-09-05T22:20:01.791048  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-09-05T22:20:01.793478  FIRST, INC default to 1.

    2023-09-05T22:20:01.793854  =


    2023-09-05T22:20:01.797315  	-w	Pad to last with leading zeros

    2023-09-05T22:20:01.799909  	-s SEP	String separator

    2023-09-05T22:20:01.803636  /lava-11440341/1/../bin/lava-test-case

    2023-09-05T22:20:01.813836  Busy<8>[   19.644570] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64f7a93859eecbfa8d286db8
        failing since 228 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-09-05T22:20:01.771131  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-09-05T22:20:01.771355  =

   =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-rock-pi-4b         | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a843de5bc247c2286db1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm64/defconfig/gcc-10/lab-collabora/baseli=
ne-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm64/defconfig/gcc-10/lab-collabora/baseli=
ne-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f7a843de5bc247c2286db6
        failing since 14 days (last pass: v5.10.186-cip37-16-gf8567732a40d,=
 first fail: v6.1.45-cip3-31-gbae6b8e9a2cff)

    2023-09-05T22:14:33.621955  / # #

    2023-09-05T22:14:34.882364  export SHELL=3D/bin/sh

    2023-09-05T22:14:34.893203  #

    2023-09-05T22:14:34.893655  / # export SHELL=3D/bin/sh

    2023-09-05T22:14:36.636239  / # . /lava-11440318/environment

    2023-09-05T22:14:39.838802  /lava-11440318/bin/lava-test-runner /lava-1=
1440318/1

    2023-09-05T22:14:39.850158  . /lava-11440318/environment

    2023-09-05T22:14:39.850439  / # /lava-11440318/bin/lava-test-runner /la=
va-11440318/1

    2023-09-05T22:14:39.901746  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-05T22:14:39.902185  + cd /lava-11440318/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =20

