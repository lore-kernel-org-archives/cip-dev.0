Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E38DC636D3
	for <webhook@archiver.kernel.org>; Fri, 10 Feb 2023 11:07:45 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web10.11984.1676027264448633429
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 10 Feb 2023 03:07:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Sb7Y3FbQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id r8so6127661pls.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 10 Feb 2023 03:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Es+mQP5Di1af0OeO0grj3icB35QonYSEt0VmEZ5HSqE=;
        b=Sb7Y3FbQucB6dc/H0Vuo8u/2DwiMXXnweLq8ojFM4z6JgdEl0ebQ0UD80QZjDz1GCV
         ikuPjnZbeirO5rPNfEeDVd6fA6eICCXdc8+q4Hzz++bcsuHMutIV02oBg0VCdIE21Fj4
         Setb3VR3ZRJZRKqpI8J8xyXopZNc9QI3a5Hc8DomHOWpGkO2VfcSqKghp3cAlprHhSg9
         /xaB0/DEiztBEI9QiqGwz08YvY+J4nOPmYE7x0BfBMaaZ1UtlCBsPvFY36vHBla+FVOL
         sovZYrK3zQq8vaZzECD3+cH+zVaorirx/rn38uSWGRcyvImwgWG8Al384uFwY0zt72de
         he4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Es+mQP5Di1af0OeO0grj3icB35QonYSEt0VmEZ5HSqE=;
        b=7lQfgqxkQe2TuMFPB2veygAqzYBp73j76/wfjm7NElMK1IvPwGlVdrmJVke1o3V3cj
         Wd+wK8Oi5M/VRaqR+9J+++mYYMgPSBykF4ZuMo9bWL8FnDE2XT/HGxNXmDofCMONQxaQ
         jWXn5nNtNoIDEfy+jOiY9WSlAAgW3L0qpKEFH1HU2qkSrQbOSJHaoEdrmCe+I6jfDHUy
         TCsJGucKMHoRRv21UEfCjicLWJRkytA835etiQFyXmFccSjuqqwI5+pGbrZ5iKfpC2wv
         lCmb5Rdx+UjGr+tEnWeNgskMsXhHLD0MBysqpt2095ygfkAdeuMZcEPB/aKYdy1n3/Ru
         hiow==
X-Gm-Message-State: AO0yUKUrDNWTrPVoHhYWqvykN4TWQfggEJH7YigB9mkgLywiFnT4w/SY
	yyWnSv7sCFt8n/Hqyq8wmixNwv27gs7r77iJL+ZdhQ==
X-Google-Smtp-Source: AK7set+KUUurNVV0Ibvb+6qoxMxeCHW32vfdV8LwCl34XBfgxFkUlkjN3HAVdBX9H9VfMhr91aQuJg==
X-Received: by 2002:a17:902:d10c:b0:199:50c9:61c6 with SMTP id w12-20020a170902d10c00b0019950c961c6mr6192886plw.39.1676027263010;
        Fri, 10 Feb 2023 03:07:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id io20-20020a17090312d400b0017f5ad327casm3138348plb.103.2023.02.10.03.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 03:07:42 -0800 (PST)
Message-ID: <63e6257e.170a0220.88dea.5824@mx.google.com>
Date: Fri, 10 Feb 2023 03:07:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.167-cip26
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline: 130 runs,
 24 regressions (v5.10.167-cip26)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Feb 2023 11:07:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10638

cip/linux-5.10.y-cip baseline: 130 runs, 24 regressions (v5.10.167-cip26)

Regressions Summary
-------------------

platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =

at91sam9g20ek             | arm    | lab-broonie     | gcc-10   | multi_v5_=
defconfig           | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig           | 1          =

beaglebone-black          | arm    | lab-cip         | gcc-10   | multi_v7_=
defconfig           | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | omap2plus=
_defconfig          | 1          =

beaglebone-black          | arm    | lab-cip         | gcc-10   | omap2plus=
_defconfig          | 1          =

imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig          | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig           | 1          =

mt8173-elm-hana           | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 1          =

r8a7743-iwg20d-q7         | arm    | lab-cip         | gcc-10   | shmobile_=
defconfig           | 1          =

rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 4          =

rk3399-gru-kevin          | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 5          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie     | gcc-10   | defconfig=
                    | 1          =

tegra124-nyan-big         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.167-cip26/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.167-cip26
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dd0dd3e572fd82c1c232ad1f089ca628d7dc16de =



Test Regressions
---------------- =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
acer-cb317-1h-c3z6-dedede | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e61a137b1f7882248c864a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e61a137b1f7882248c8653
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:18:29.508675  + set +x

    2023-02-10T10:18:29.515102  <8>[   10.765529] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9097429_1.4.2.3.1>

    2023-02-10T10:18:29.623239  / # #

    2023-02-10T10:18:29.724929  export SHELL=3D/bin/sh

    2023-02-10T10:18:29.725261  #

    2023-02-10T10:18:29.826454  / # export SHELL=3D/bin/sh. /lava-9097429/e=
nvironment

    2023-02-10T10:18:29.827267  =


    2023-02-10T10:18:29.929190  / # . /lava-9097429/environment/lava-909742=
9/bin/lava-test-runner /lava-9097429/1

    2023-02-10T10:18:29.930401  =


    2023-02-10T10:18:29.936108  / # /lava-9097429/bin/lava-test-runner /lav=
a-9097429/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e61a1c96175908618c862f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e61a1c96175908618c8638
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:18:49.218087  + set<8>[   11.980615] <LAVA_SIGNAL_ENDRUN =
0_dmesg 9097411_1.4.2.3.1>

    2023-02-10T10:18:49.218556   +x

    2023-02-10T10:18:49.326437  /#

    2023-02-10T10:18:49.429494   # #export SHELL=3D/bin/sh

    2023-02-10T10:18:49.430296  =


    2023-02-10T10:18:49.532098  / # export SHELL=3D/bin/sh. /lava-9097411/e=
nvironment

    2023-02-10T10:18:49.532952  =


    2023-02-10T10:18:49.634664  / # . /lava-9097411/environment/lava-909741=
1/bin/lava-test-runner /lava-9097411/1

    2023-02-10T10:18:49.635875  =


    2023-02-10T10:18:49.641200  / # /lava-9097411/bin/lava-test-runner /lav=
a-9097411/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e619d7bda04fcf848c862f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e619d7bda04fcf848c8638
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:17:46.150288  + set +x

    2023-02-10T10:17:46.156941  <8>[   10.289277] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9097399_1.4.2.3.1>

    2023-02-10T10:17:46.265272  / # #

    2023-02-10T10:17:46.368262  export SHELL=3D/bin/sh

    2023-02-10T10:17:46.369047  #

    2023-02-10T10:17:46.470889  / # export SHELL=3D/bin/sh. /lava-9097399/e=
nvironment

    2023-02-10T10:17:46.471809  =


    2023-02-10T10:17:46.573761  / # . /lava-9097399/environment/lava-909739=
9/bin/lava-test-runner /lava-9097399/1

    2023-02-10T10:17:46.574956  =


    2023-02-10T10:17:46.580363  / # /lava-9097399/bin/lava-test-runner /lav=
a-9097399/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
at91sam9g20ek             | arm    | lab-broonie     | gcc-10   | multi_v5_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e61ce7b8f8670eb98c86a4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e61ce7b8f8670eb98c86ad
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:30:48.837508  + set +x
    2023-02-10T10:30:48.842598  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 295965_1.5.2=
.4.1>
    2023-02-10T10:30:48.956245  / # #
    2023-02-10T10:30:49.059258  export SHELL=3D/bin/sh
    2023-02-10T10:30:49.060055  #
    2023-02-10T10:30:49.161967  / # export SHELL=3D/bin/sh. /lava-295965/en=
vironment
    2023-02-10T10:30:49.162772  =

    2023-02-10T10:30:49.264787  / # . /lava-295965/environment/lava-295965/=
bin/lava-test-runner /lava-295965/1
    2023-02-10T10:30:49.266141  =

    2023-02-10T10:30:49.272481  / # /lava-295965/bin/lava-test-runner /lava=
-295965/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e61f4d71188c65dd8c8630

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e61f4d71188c65dd8c8639
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:40:59.736169  <8>[   22.360772] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 296171_1.5.2.4.1>
    2023-02-10T10:40:59.847427  / # #
    2023-02-10T10:40:59.950303  export SHELL=3D/bin/sh
    2023-02-10T10:40:59.950995  #
    2023-02-10T10:41:00.052929  / # export SHELL=3D/bin/sh. /lava-296171/en=
vironment
    2023-02-10T10:41:00.053666  =

    2023-02-10T10:41:00.155514  / # . /lava-296171/environment/lava-296171/=
bin/lava-test-runner /lava-296171/1
    2023-02-10T10:41:00.156774  =

    2023-02-10T10:41:00.161035  / # /lava-296171/bin/lava-test-runner /lava=
-296171/1
    2023-02-10T10:41:00.254387  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-cip         | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e62117119d049b6c8c86a3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e62117119d049b6c8c86aa
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:48:42.123020  <8>[   15.544809] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 846670_1.5.2.4.1>
    2023-02-10T10:48:42.231166  / # #
    2023-02-10T10:48:42.332540  export SHELL=3D/bin/sh
    2023-02-10T10:48:42.332817  #
    2023-02-10T10:48:42.433897  / # export SHELL=3D/bin/sh. /lava-846670/en=
vironment
    2023-02-10T10:48:42.434176  =

    2023-02-10T10:48:42.535263  / # . /lava-846670/environment/lava-846670/=
bin/lava-test-runner /lava-846670/1
    2023-02-10T10:48:42.535733  =

    2023-02-10T10:48:42.541973  / # /lava-846670/bin/lava-test-runner /lava=
-846670/1
    2023-02-10T10:48:42.637178  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | omap2plus=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63e619fc4d222f8af98c8632

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e619fc4d222f8af98c863b
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:18:19.269492  <8>[   20.177518] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 295728_1.5.2.4.1>
    2023-02-10T10:18:19.380126  / # #
    2023-02-10T10:18:19.483142  export SHELL=3D/bin/sh
    2023-02-10T10:18:19.483897  #
    2023-02-10T10:18:19.586273  / # export SHELL=3D/bin/sh. /lava-295728/en=
vironment
    2023-02-10T10:18:19.587010  =

    2023-02-10T10:18:19.689512  / # . /lava-295728/environment/lava-295728/=
bin/lava-test-runner /lava-295728/1
    2023-02-10T10:18:19.690681  =

    2023-02-10T10:18:19.695746  / # /lava-295728/bin/lava-test-runner /lava=
-295728/1
    2023-02-10T10:18:19.799785  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-cip         | gcc-10   | omap2plus=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63e619f959b0d202e18c86c2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e619f959b0d202e18c86c9
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:18:20.923554  + set +x
    2023-02-10T10:18:20.925609  <8>[   14.055345] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 846579_1.5.2.4.1>
    2023-02-10T10:18:21.034460  / # #
    2023-02-10T10:18:21.136329  export SHELL=3D/bin/sh
    2023-02-10T10:18:21.136797  #
    2023-02-10T10:18:21.238180  / # export SHELL=3D/bin/sh. /lava-846579/en=
vironment
    2023-02-10T10:18:21.238644  =

    2023-02-10T10:18:21.340083  / # . /lava-846579/environment/lava-846579/=
bin/lava-test-runner /lava-846579/1
    2023-02-10T10:18:21.340820  =

    2023-02-10T10:18:21.343083  / # /lava-846579/bin/lava-test-runner /lava=
-846579/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e61ecc69e543bff68c864f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e61ecc69e543bff68c8658
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:38:52.957853  / # #

    2023-02-10T10:38:53.060862  export SHELL=3D/bin/sh

    2023-02-10T10:38:53.061688  #

    2023-02-10T10:38:53.163829  / # export SHELL=3D/bin/sh. /lava-9097917/e=
nvironment

    2023-02-10T10:38:53.164674  =


    2023-02-10T10:38:53.266729  / # . /lava-9097917/environment/lava-909791=
7/bin/lava-test-runner /lava-9097917/1

    2023-02-10T10:38:53.267999  =


    2023-02-10T10:38:53.281582  / # /lava-9097917/bin/lava-test-runner /lav=
a-9097917/1

    2023-02-10T10:38:53.385380  + export 'TESTRUN_ID=3D1_bootrr'

    2023-02-10T10:38:53.385940  + cd /lava-9097917/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63e61d48447a7ec7958c8644

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e61d48447a7ec7958c864d
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:32:17.077968  + set +x
    2023-02-10T10:32:17.078158  [   11.593851] <LAVA_SIGNAL_ENDRUN 0_dmesg =
902896_1.5.2.3.1>
    2023-02-10T10:32:17.186776  / # #
    2023-02-10T10:32:17.288322  export SHELL=3D/bin/sh
    2023-02-10T10:32:17.288781  #
    2023-02-10T10:32:17.390082  / # export SHELL=3D/bin/sh. /lava-902896/en=
vironment
    2023-02-10T10:32:17.390606  =

    2023-02-10T10:32:17.492088  / # . /lava-902896/environment/lava-902896/=
bin/lava-test-runner /lava-902896/1
    2023-02-10T10:32:17.492796  =

    2023-02-10T10:32:17.495862  / # /lava-902896/bin/lava-test-runner /lava=
-902896/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e61eb069e543bff68c863d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e61eb069e543bff68c8646
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:38:16.821568  + set[    7.220256] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 902910_1.5.2.3.1>
    2023-02-10T10:38:16.821761   +x
    2023-02-10T10:38:16.927376  / # #
    2023-02-10T10:38:17.029030  export SHELL=3D/bin/sh
    2023-02-10T10:38:17.029496  #
    2023-02-10T10:38:17.130656  / # export SHELL=3D/bin/sh. /lava-902910/en=
vironment
    2023-02-10T10:38:17.131062  =

    2023-02-10T10:38:17.232292  / # . /lava-902910/environment/lava-902910/=
bin/lava-test-runner /lava-902910/1
    2023-02-10T10:38:17.232920  =

    2023-02-10T10:38:17.235395  / # /lava-902910/bin/lava-test-runner /lava=
-902910/1 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
mt8173-elm-hana           | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63e61df1026fb34ebe8c8630

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt817=
3-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e61df1026fb34ebe8c8650
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:35:12.420638  + set +x

    2023-02-10T10:35:12.425463  <8>[   15.669716] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9097852_1.5.2.3.1>

    2023-02-10T10:35:12.534067  #

    2023-02-10T10:35:12.637553  / # #export SHELL=3D/bin/sh

    2023-02-10T10:35:12.638515  =


    2023-02-10T10:35:12.740372  / # export SHELL=3D/bin/sh. /lava-9097852/e=
nvironment

    2023-02-10T10:35:12.741323  =


    2023-02-10T10:35:12.843322  / # . /lava-9097852/environment/lava-909785=
2/bin/lava-test-runner /lava-9097852/1

    2023-02-10T10:35:12.844797  =


    2023-02-10T10:35:12.846914  / # /lava-9097852/bin/lava-test-runner /lav=
a-9097852/1
 =

    ... (16 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
r8a7743-iwg20d-q7         | arm    | lab-cip         | gcc-10   | shmobile_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e619e57e27a99e0d8c8633

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63e619e57e27a99e0d8c8=
634
        new failure (last pass: v5.10.165-cip25) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/63e61f5471188c65dd8c864b

  Results:     63 PASS, 8 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/63e61f5471188c65dd8c867e
        failing since 25 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:41:07.460877  FIRST,<8>[   21.463634] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-02-10T10:41:07.461925   INC default to 1.

    2023-02-10T10:41:07.462465  =


    2023-02-10T10:41:07.465505  	-w	Pad to last with leading zeros

    2023-02-10T10:41:07.468241  	-s SEP	String separator

    2023-02-10T10:41:07.472020  /lava-9097895/1/../bin/lava-test-case

    2023-02-10T10:41:07.477996  BusyBox v1.31.1 (2023-02-03 20:15:52 UTC) m=
ulti-call binary.

    2023-02-10T10:41:07.478574  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/63e61f5471188c65dd8c867f
        failing since 25 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:41:07.438646  BusyBox v1.31.1 (2023-02-03 20:15:52 UTC)<8=
>[   21.444921] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-02-10T10:41:07.439764   multi-call binary.

    2023-02-10T10:41:07.440357  =


    2023-02-10T10:41:07.444155  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-02-10T10:41:07.444761  =


    2023-02-10T10:41:07.449484  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/63e61f5471188c65dd8c8680
        failing since 25 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:41:07.419696  <8>[   21.427270] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e61f5471188c65dd8c8694
        failing since 25 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:40:55.372765  + <8>[    9.384199] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 9097895_1.5.2.3.1>

    2023-02-10T10:40:55.374729  set +x

    2023-02-10T10:40:55.480992  / #

    2023-02-10T10:40:55.583634  # #export SHELL=3D/bin/sh

    2023-02-10T10:40:55.584248  =


    2023-02-10T10:40:55.685976  / # export SHELL=3D/bin/sh. /lava-9097895/e=
nvironment

    2023-02-10T10:40:55.686609  =


    2023-02-10T10:40:55.788366  / # . /lava-9097895/environment/lava-909789=
5/bin/lava-test-runner /lava-9097895/1

    2023-02-10T10:40:55.789662  =


    2023-02-10T10:40:55.791704  / # /lava-9097895/bin/lava-test-runner /lav=
a-9097895/1
 =

    ... (18 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora   | gcc-10   | defconfig=
+arm64-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/63e61ed97b8a8a8eeb8c863b

  Results:     86 PASS, 6 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/63e61ed97b8a8a8eeb8c8661
        failing since 318 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2023-02-10T10:38:58.882205  /lava-9097845/1/../bin/lava-test-case

    2023-02-10T10:38:58.892625  <8>[   60.348865] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rk3399-gru-sound-driver-rt5514-present: https://kernelc=
i.org/test/case/id/63e61ed97b8a8a8eeb8c8676
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:38:57.162351  /la<8>[   58.615917] <LAVA_SIGNAL_TESTCASE =
TEST_CASE_ID=3Drk3399-gru-sound-driver-max98357A-present RESULT=3Dfail>

    2023-02-10T10:38:57.165796  va-9097845/1/../bin/lava-test-case

    2023-02-10T10:38:57.171455  BusyBox v1.31.1 (2023-02-03 20:35:48 UTC) m=
ulti-call binary.

    2023-02-10T10:38:57.172089  =


    2023-02-10T10:38:57.176283  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-02-10T10:38:57.176709  =


    2023-02-10T10:38:57.191013  Print numbers from FIRST to LAST, in steps =
of<8>[   58.644531] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-d=
river-rt5514-present RESULT=3Dfail>
   =


  * baseline.bootrr.rk3399-gru-sound-driver-max98357A-present: https://kern=
elci.org/test/case/id/63e61ed97b8a8a8eeb8c8677
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:38:57.132966  <8>[   58.584463] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>

    2023-02-10T10:38:57.136947  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-02-10T10:38:57.137517  =


    2023-02-10T10:38:57.142409  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-02-10T10:38:57.144880  FIRST, INC default to 1.

    2023-02-10T10:38:57.145140  =


    2023-02-10T10:38:57.148801  	-w	Pad to last with leading zeros

    2023-02-10T10:38:57.151071  	-s SEP	String separator
   =


  * baseline.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelci.or=
g/test/case/id/63e61ed97b8a8a8eeb8c8678
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:38:57.098938  ST

    2023-02-10T10:38:57.099409  =


    2023-02-10T10:38:57.104359  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-02-10T10:38:57.106991  FIRST, INC default to 1.

    2023-02-10T10:38:57.107073  =


    2023-02-10T10:38:57.110359  	-w	Pad to last with leading zeros

    2023-02-10T10:38:57.112753  	-s SEP	String separator

    2023-02-10T10:38:57.116555  /lava-9097845/1/../bin/lava-test-case

    2023-02-10T10:38:57.122643  BusyBox v1.31.1 (2023-02-03 20:35:48 UTC) m=
ulti-call binary.

    2023-02-10T10:38:57.122934  =

   =


  * baseline.bootrr.rk3399-gru-sound-driver-da7219-present: https://kernelc=
i.org/test/case/id/63e61ed97b8a8a8eeb8c8679
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:38:57.083912  BusyBox v1.31.1 (2023-02-03 20:35:48 UTC) m=
ulti-call binary.

    2023-02-10T10:38:57.084196  =


    2023-02-10T10:38:57.098421  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   58.548059] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-drive=
r-da7219-present RESULT=3Dfail>
   =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie     | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63e61b978417a459e08c86ae

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e61b978417a459e08c86b7
        failing since 27 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:25:13.304686  + set +x
    2023-02-10T10:25:13.308570  <8>[   17.067171] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 295876_1.5.2.4.1>
    2023-02-10T10:25:13.421126  / # #
    2023-02-10T10:25:13.525685  export SHELL=3D/bin/sh
    2023-02-10T10:25:13.526255  #
    2023-02-10T10:25:13.628126  / # export SHELL=3D/bin/sh. /lava-295876/en=
vironment
    2023-02-10T10:25:13.629049  =

    2023-02-10T10:25:13.730830  / # . /lava-295876/environment/lava-295876/=
bin/lava-test-runner /lava-295876/1
    2023-02-10T10:25:13.732816  =

    2023-02-10T10:25:13.735681  / # /lava-295876/bin/lava-test-runner /lava=
-295876/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
tegra124-nyan-big         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e61fa442155dc45a8c8638

  Results:     5 PASS, 2 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-tegra124-nyan-b=
ig.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-tegra124-nyan-b=
ig.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63e61fa442155dc45a8c8641
        failing since 25 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-02-10T10:42:18.018355  <8>[   17.515538] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-02-10T10:42:18.020181  + set +x

    2023-02-10T10:42:18.025386  <8>[   17.525856] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9097894_1.5.2.3.1>

    2023-02-10T10:42:18.133375  =


    2023-02-10T10:42:18.234864  / # #export SHELL=3D/bin/sh

    2023-02-10T10:42:18.235278  =


    2023-02-10T10:42:18.336559  / # export SHELL=3D/bin/sh. /lava-9097894/e=
nvironment

    2023-02-10T10:42:18.336997  =


    2023-02-10T10:42:18.438316  / # . /lava-9097894/environment/lava-909789=
4/bin/lava-test-runner /lava-9097894/1

    2023-02-10T10:42:18.439031  =

 =

    ... (16 line(s) more)  =

 =20

