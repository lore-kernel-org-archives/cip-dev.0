Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C67EE0200
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 18:08:32 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web10.4244.1694628506375551802
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Sep 2023 11:08:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=bA+O38Gt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-570a432468bso963723a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Sep 2023 11:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694628505; x=1695233305; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kZ2zeXdOQp5dTzVkreRTZ5V5uFduZJdBZHduVjI8z+s=;
        b=bA+O38Gtpn23p2+5v+xdYkUwpMkAyr70FR+DNBmMm1KgMa28/e+KgsSJlGU0Z5JJBx
         /LD/ynGD/j22s7K25CTCmfWF5+NPfy8elb38bOUsN7yCiRBaHVyULhn4uGzZLuVF8UiK
         GCUWrznSBpLiW/ikP0Ddhlufy1ENoluzbXNsbIDnSe8Q2xx7BtHUASi4DM+a8VoVhC8d
         KLn0Rnl+qA4QZ8pM3WeM8Ce6QYg+DDG0HkglZvghw5cLYMNsfjlD6B72gs+SMJRFyDZh
         k9Ok8nKlT6y3crO9M5gq7xYdUbNWBG0aORa3GTLxxijDJGcSnskYBQp5NhMcpbZsFOqi
         jtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694628505; x=1695233305;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZ2zeXdOQp5dTzVkreRTZ5V5uFduZJdBZHduVjI8z+s=;
        b=p+2G/rOSbFq3fBTxVevqIbQaU35L0nNMT1HPBqZvXhFubDbPO4sablbTuO6a4QGX50
         PFMcFK4BdI/SauitxWWKXRDad9XwSlNVxcZGdousWREEPVm+Dm5rqh5DjNPuVEWhAxwV
         jFvxliKeI3SwQ6Ap9/eZUeg+IZBN4wydRxa+6aRN84Mj5uI3D3Z6mvAVlXUcQaIHdgeQ
         +r8X2J2nnfnDxgVhZsnP/17Gf/UoI2+fxCOUpLEC7vsCmGzRrRpwq+LswEjj4BwPhwRl
         phP7yaCJ8/Q9MRD5ziZPx0uI30xYXKcAjdrb83KM9oZ6k9RthVdmY+O8xmkhKscQxTlF
         f5RA==
X-Gm-Message-State: AOJu0Yza0MfyXxNnBvrTsfmsu5//29siT7Yf5XHMFF8pnCEsgOiV9sB6
	luaw280FVTolwt8nvnZRcFQyI/2IWN5b5V87UbU=
X-Google-Smtp-Source: AGHT+IE2ws5eD7DwVWDPavnCNHTOB4cw+Geb8/pq1xUHTL7xUD2KpD2rTtp6bVsKOpWSDtORLJzjEg==
X-Received: by 2002:a17:90b:3e8c:b0:273:f10c:b6d2 with SMTP id rj12-20020a17090b3e8c00b00273f10cb6d2mr5011440pjb.18.1694628505156;
        Wed, 13 Sep 2023 11:08:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i3-20020a17090a3d8300b0026094c23d0asm1893644pjc.17.2023.09.13.11.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 11:08:24 -0700 (PDT)
Message-ID: <6501fa98.170a0220.3ca43.65a4@mx.google.com>
Date: Wed, 13 Sep 2023 11:08:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v6.1.52-cip5-29-g9fee06894d49
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip baseline: 124 runs,
 4 regressions (v6.1.52-cip5-29-g9fee06894d49)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 18:08:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13121

cip/linux-6.1.y-cip baseline: 124 runs, 4 regressions (v6.1.52-cip5-29-g9fe=
e06894d49)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
          | regressions
-------------------+-------+---------------+----------+--------------------=
----------+------------
juno-uboot         | arm64 | lab-broonie   | gcc-10   | cip://6.1.y-c...64_=
defconfig | 2          =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
          | 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.52-cip5-29-g9fee06894d49/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.52-cip5-29-g9fee06894d49
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      9fee06894d496c0a873d78633ef74e3395d81c89 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
          | regressions
-------------------+-------+---------------+----------+--------------------=
----------+------------
juno-uboot         | arm64 | lab-broonie   | gcc-10   | cip://6.1.y-c...64_=
defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/6501f20c1bec5e65cd8a0a58

  Results:     55 PASS, 5 FAIL, 1 SKIP
  Full config: cip://6.1.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.52-ci=
p5-29-g9fee06894d49/arm64/cip---6.1.y-cip-arm64-qemu_arm64_defconfig/gcc-10=
/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.52-ci=
p5-29-g9fee06894d49/arm64/cip---6.1.y-cip-arm64-qemu_arm64_defconfig/gcc-10=
/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case/id/=
6501f20d1bec5e65cd8a0a8a
        failing since 44 days (last pass: v6.1.31-65-ge66be31505fa, first f=
ail: v6.1.42-cip2)

    2023-09-13T17:31:39.293509  /lava-105548/1/../bin/lava-test-case
    2023-09-13T17:31:39.332260  <8>[   35.052424] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>
    2023-09-13T17:31:39.332796  /lava-105548/1/../bin/lava-test-case   =


  * baseline.bootrr.ethernet-probed: https://kernelci.org/test/case/id/6501=
f20d1bec5e65cd8a0a8c
        failing since 44 days (last pass: v6.1.31-65-ge66be31505fa, first f=
ail: v6.1.42-cip2)

    2023-09-13T17:31:38.239202  /lava-105548/1/../bin/lava-test-case
    2023-09-13T17:31:38.263264  <8>[   33.999134] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dethernet-probed RESULT=3Dfail>
    2023-09-13T17:31:38.263799  /lava-105548/1/../bin/lava-test-case   =

 =



platform           | arch  | lab           | compiler | defconfig          =
          | regressions
-------------------+-------+---------------+----------+--------------------=
----------+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501f3e3c43e0883728a0a7b

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.52-ci=
p5-29-g9fee06894d49/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.52-ci=
p5-29-g9fee06894d49/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501f3e3c43e0883728a0a84
        failing since 44 days (last pass: v6.1.31-46-g4cc1cc26e90f, first f=
ail: v6.1.42-cip2)

    2023-09-13T17:43:47.043693  / # #

    2023-09-13T17:43:47.145833  export SHELL=3D/bin/sh

    2023-09-13T17:43:47.146528  #

    2023-09-13T17:43:47.247911  / # export SHELL=3D/bin/sh. /lava-11518437/=
environment

    2023-09-13T17:43:47.248618  =


    2023-09-13T17:43:47.350058  / # . /lava-11518437/environment/lava-11518=
437/bin/lava-test-runner /lava-11518437/1

    2023-09-13T17:43:47.351121  =


    2023-09-13T17:43:47.368267  / # /lava-11518437/bin/lava-test-runner /la=
va-11518437/1

    2023-09-13T17:43:47.415623  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-13T17:43:47.416148  + cd /lav<8>[   19.084888] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11518437_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
          | regressions
-------------------+-------+---------------+----------+--------------------=
----------+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501f3e2c43e0883728a0a70

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.52-ci=
p5-29-g9fee06894d49/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.52-ci=
p5-29-g9fee06894d49/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501f3e2c43e0883728a0a79
        failing since 44 days (last pass: v6.1.31-53-g486caac40d06, first f=
ail: v6.1.42-cip2)

    2023-09-13T17:44:01.530824  / # #

    2023-09-13T17:44:01.631525  export SHELL=3D/bin/sh

    2023-09-13T17:44:01.632200  #

    2023-09-13T17:44:01.733326  / # export SHELL=3D/bin/sh. /lava-11518433/=
environment

    2023-09-13T17:44:01.733520  =


    2023-09-13T17:44:01.833970  / # . /lava-11518433/environment/lava-11518=
433/bin/lava-test-runner /lava-11518433/1

    2023-09-13T17:44:01.834205  =


    2023-09-13T17:44:01.844128  / # /lava-11518433/bin/lava-test-runner /la=
va-11518433/1

    2023-09-13T17:44:01.915161  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-13T17:44:01.915244  + cd /lava-1151843<8>[   18.801752] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11518433_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

