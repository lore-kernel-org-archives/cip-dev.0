Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A2CE706F6
	for <webhook@archiver.kernel.org>; Thu, 21 Sep 2023 08:59:38 +0000 (UTC)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
 by mx.groups.io with SMTP id smtpd.web11.11674.1695286777601661120
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Sep 2023 01:59:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=2/ieUypS;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.52, mailfrom: bot@kernelci.org)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6c0f4ad9eb1so468355a34.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 21 Sep 2023 01:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695286776; x=1695891576; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S2MHsthF+ltw/4p4XH8ab5dSHnMKiBlfg5tQdNCYpIU=;
        b=2/ieUypSQMsp4wk9ihZoTQ1w0aFf+o7TK1hcU9n6vTLegFlfAdwtqK3y0II+asYifI
         s4mBIRMT+JcqVcNxGVAvU1wMd/PvOPbR+spCM6BV7r6Xx1gmtVAyM8Z0h59rCvtKxKFH
         Uasi+EFbs8V3O3exREy0VuCcS2UPGRw8OwBEa14tXrE1NiNpdkxJUKNg+mBcLkBLlnlZ
         p3y/4/IQn2YGg4wXz0l/y1UwjN++0GdPQfDfX3QjU6Pm264bZ+vSzIeYPQDaPB3tyvsE
         7pVk78u9FpoHxUqbiq+CZWuui0dc/ofyb3R0orznRRr/mnMLj7dNrc34l2IBrojrDVG+
         fIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695286776; x=1695891576;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S2MHsthF+ltw/4p4XH8ab5dSHnMKiBlfg5tQdNCYpIU=;
        b=r5+XyNG7jdO/bC2vp44YL+VbuT0S/xsv8XxQBP2Q5s6kqzFFD5fB+innrzQJetaUGr
         fCx4bSM7fJDTbVuKsb+X9+TNQl+T6F8zG1a6t7owzOQfxfjWFkelxXQMjtb6YNa6Gase
         fe6jtcjOvaBRp6lJeE9LgQelamZ0agfSyCn0OrdSl5E950fq/K47Bz/yU/2qpA0VLff0
         cgU2X8iQfaZyGSssjkISwtLhuYfz6rnivqvwacMouaVNJjPsfEV48RnLv4vkmT4x+YYa
         PHxw3P/LHSWhvyQvX4ZYs0Y2SJKPSz7SzI5OiOSOqVGrThsobCgj03+fOZUWNMfi6XNy
         rawg==
X-Gm-Message-State: AOJu0YztGwp4wPI/Ag4oHZ7nk1Y4ewtriit3+rcTdVYRx9khAa2cvM/I
	0eSGO+YehvO88UwFP9JQWGRDDITVa3kytJbwCr++Lw==
X-Google-Smtp-Source: AGHT+IHo/la43+ty9F2tyNt7qKQZ9Szzo2wH6rvLVuV9eKn6TrWVgOqnNCtnwmddJ1mm7RNRDA1tsg==
X-Received: by 2002:a9d:738c:0:b0:6c0:9e10:90b8 with SMTP id j12-20020a9d738c000000b006c09e1090b8mr4944895otk.18.1695286776387;
        Thu, 21 Sep 2023 01:59:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y5-20020aa78045000000b0069048fe6c8esm842576pfm.203.2023.09.21.01.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 01:59:35 -0700 (PDT)
Message-ID: <650c05f7.a70a0220.266b4.23f2@mx.google.com>
Date: Thu, 21 Sep 2023 01:59:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v6.1.54-cip6
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip baseline: 134 runs, 4 regressions (v6.1.54-cip6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Sep 2023 08:59:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13188

cip/linux-6.1.y-cip baseline: 134 runs, 4 regressions (v6.1.54-cip6)

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
/v6.1.54-cip6/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.54-cip6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      5f8461a2ec855187b1bab7e4aa419338772fe9bc =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
          | regressions
-------------------+-------+---------------+----------+--------------------=
----------+------------
juno-uboot         | arm64 | lab-broonie   | gcc-10   | cip://6.1.y-c...64_=
defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/650bf708e44b17876b8a0a47

  Results:     55 PASS, 5 FAIL, 1 SKIP
  Full config: cip://6.1.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.54-ci=
p6/arm64/cip---6.1.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie/base=
line-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.54-ci=
p6/arm64/cip---6.1.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie/base=
line-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case/id/=
650bf708e44b17876b8a0a7e
        failing since 52 days (last pass: v6.1.31-65-ge66be31505fa, first f=
ail: v6.1.42-cip2)

    2023-09-21T07:55:36.867681  /lava-121888/1/../bin/lava-test-case
    2023-09-21T07:55:36.906491  <8>[   35.115413] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>
    2023-09-21T07:55:36.907014  /lava-121888/1/../bin/lava-test-case   =


  * baseline.bootrr.ethernet-probed: https://kernelci.org/test/case/id/650b=
f708e44b17876b8a0a80
        failing since 52 days (last pass: v6.1.31-65-ge66be31505fa, first f=
ail: v6.1.42-cip2)

    2023-09-21T07:55:35.814571  /lava-121888/1/../bin/lava-test-case
    2023-09-21T07:55:35.838647  <8>[   34.062378] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dethernet-probed RESULT=3Dfail>
    2023-09-21T07:55:35.839162  /lava-121888/1/../bin/lava-test-case   =

 =



platform           | arch  | lab           | compiler | defconfig          =
          | regressions
-------------------+-------+---------------+----------+--------------------=
----------+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/650bfad3f396ee7a318a0a6a

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.54-ci=
p6/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.54-ci=
p6/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650bfad3f396ee7a318a0a73
        failing since 52 days (last pass: v6.1.31-46-g4cc1cc26e90f, first f=
ail: v6.1.42-cip2)

    2023-09-21T08:16:07.586185  / # #

    2023-09-21T08:16:07.686657  export SHELL=3D/bin/sh

    2023-09-21T08:16:07.686775  #

    2023-09-21T08:16:07.787245  / # export SHELL=3D/bin/sh. /lava-11586015/=
environment

    2023-09-21T08:16:07.787350  =


    2023-09-21T08:16:07.887828  / # . /lava-11586015/environment/lava-11586=
015/bin/lava-test-runner /lava-11586015/1

    2023-09-21T08:16:07.888043  =


    2023-09-21T08:16:07.899632  / # /lava-11586015/bin/lava-test-runner /la=
va-11586015/1

    2023-09-21T08:16:07.952845  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-21T08:16:07.952922  + cd /lav<8>[   19.151378] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11586015_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
          | regressions
-------------------+-------+---------------+----------+--------------------=
----------+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/650bfad20446a6a9d68a0aad

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.54-ci=
p6/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.54-ci=
p6/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650bfad20446a6a9d68a0ab6
        failing since 52 days (last pass: v6.1.31-53-g486caac40d06, first f=
ail: v6.1.42-cip2)

    2023-09-21T08:16:14.618401  / # #

    2023-09-21T08:16:14.720429  export SHELL=3D/bin/sh

    2023-09-21T08:16:14.721039  #

    2023-09-21T08:16:14.822024  / # export SHELL=3D/bin/sh. /lava-11586003/=
environment

    2023-09-21T08:16:14.822146  =


    2023-09-21T08:16:14.922733  / # . /lava-11586003/environment/lava-11586=
003/bin/lava-test-runner /lava-11586003/1

    2023-09-21T08:16:14.923051  =


    2023-09-21T08:16:14.925881  / # /lava-11586003/bin/lava-test-runner /la=
va-11586003/1

    2023-09-21T08:16:15.005873  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-21T08:16:15.006014  + cd /lava-11586003/1/tests/1_boot<8>[   16=
.970973] <LAVA_SIGNAL_STARTRUN 1_bootrr 11586003_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

