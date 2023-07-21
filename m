Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C3BEB64DD
	for <webhook@archiver.kernel.org>; Fri, 21 Jul 2023 03:05:58 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.2913.1689908749402406367
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Jul 2023 20:05:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=yeN5fPCF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-668711086f4so1019335b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Jul 2023 20:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689908748; x=1690513548;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w+x1JC5IypzHhPib5I5sMbXo/39UA9iV8hUjWhk7yX4=;
        b=yeN5fPCFMsdxWXgM79wMF23qjQxASJOnnsqPdSF5lHaqlQu07oujBnH3UnugTSRHek
         iiPYnt506JMh1Y/CAd89audGDX5i5m7jGAXTRJF9wJHCPs5xJOCNx/Mbgzw72zrWaJmm
         p64aKPP14ces+VzbpJIEiArTjAHuca2u4ksFWuFNRgPGjxmyny4zX/liDAfEHuDt4BBT
         bmGQBF8EqlHd8YHW9tktyQ5BZs110D3raFfTobILVgLGjB5CQKsridXrXRCu0velIUkE
         1Km2DZ/i5uNvnpQ40FFe8ee6hcej1HzOI+EC4OpU5la0dslQG8zVirVVID7uP3N1t8Re
         3tUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689908748; x=1690513548;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+x1JC5IypzHhPib5I5sMbXo/39UA9iV8hUjWhk7yX4=;
        b=EOjSkhAivkKAuNqV3exmb4Yjkoxk70YUm/akgZClt//Ir5jLii6pMNTOP4hvCllmgv
         kYiBnnLPixBC2Wn472jhnVDFKXIYWkKMX2zoyIp5v8vh6wXOOGN3yYi0ysPqLKojQFxg
         4ZQGWHFoof+2g5F6qjZjHev9e9LCXzokpCufMy3mKxNzbMHn7dLRK5+kwZJSTExttgGt
         dJvfN9Nr3xOwP/a+1YKrjjWFzeKaYvUAZunJJbC9cOEsF7XJYDwdDHTjcgbbGxfytj3o
         BEHV0VXKuZf9h1bySvzQp1NjJNfU3cCWTzYSs38IPK4Pe3NIQItzh/w0qvcCLEdOabjd
         1SNg==
X-Gm-Message-State: ABy/qLaRXg35eKr3Xft12dfYcpLZ9LErfmZN+H+6T2pFaO7C1Y5IqV/7
	8rjRyl2ai4k6bjNXvsGgu29AuqHzo0TnrHMnsXwQ7w==
X-Google-Smtp-Source: APBJJlFuzJuhxS1rqfn7Wl97VuT5sFQnbW93Nl97zEyTrAlCSGiv0kvE0sUYuxnvL51Etd4MqzqvNw==
X-Received: by 2002:a05:6a00:27ab:b0:65e:1d92:c0cc with SMTP id bd43-20020a056a0027ab00b0065e1d92c0ccmr8683096pfb.10.1689908748339;
        Thu, 20 Jul 2023 20:05:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x48-20020a056a000bf000b00666b012baedsm1852240pfu.158.2023.07.20.20.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 20:05:47 -0700 (PDT)
Message-ID: <64b9f60b.050a0220.6a8bf.3bb3@mx.google.com>
Date: Thu, 20 Jul 2023 20:05:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.186-cip37-11-g2b3c22dc0633
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline: 9 runs,
 3 regressions (v5.10.186-cip37-11-g2b3c22dc0633)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Jul 2023 03:05:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12490

cip/linux-5.10.y-cip baseline: 9 runs, 3 regressions (v5.10.186-cip37-11-g2=
b3c22dc0633)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
at91sam9g20ek    | arm  | lab-broonie | gcc-10   | multi_v5_defconfig  | 1 =
         =

beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =

beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.186-cip37-11-g2b3c22dc0633/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.186-cip37-11-g2b3c22dc0633
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2b3c22dc06337fb4c486cdf00b4182c35f61bb58 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
at91sam9g20ek    | arm  | lab-broonie | gcc-10   | multi_v5_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/64b9de6cbae419e7c48ace25

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-11-g2b3c22dc0633/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-=
at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-11-g2b3c22dc0633/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-=
at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b9de6dbae419e7c48ace5a
        failing since 187 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-21T01:24:26.242172  + set +x
    2023-07-21T01:24:26.247227  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 4298_1.5.2.4=
.1>
    2023-07-21T01:24:26.361260  / # #
    2023-07-21T01:24:26.464312  export SHELL=3D/bin/sh
    2023-07-21T01:24:26.465154  #
    2023-07-21T01:24:26.567152  / # export SHELL=3D/bin/sh. /lava-4298/envi=
ronment
    2023-07-21T01:24:26.567998  =

    2023-07-21T01:24:26.669993  / # . /lava-4298/environment/lava-4298/bin/=
lava-test-runner /lava-4298/1
    2023-07-21T01:24:26.671428  =

    2023-07-21T01:24:26.677885  / # /lava-4298/bin/lava-test-runner  =

    ... (11 line(s) more)  =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/64b9e14667cdb872c88ace1d

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-11-g2b3c22dc0633/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-11-g2b3c22dc0633/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b9e14667cdb872c88ace51
        failing since 187 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-21T01:36:50.336378  + set +x
    2023-07-21T01:36:50.340117  <8>[   18.957093] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 4302_1.5.2.4.1>
    2023-07-21T01:36:50.450919  / # #
    2023-07-21T01:36:50.553947  export SHELL=3D/bin/sh
    2023-07-21T01:36:50.554695  #
    2023-07-21T01:36:50.657161  / # export SHELL=3D/bin/sh. /lava-4302/envi=
ronment
    2023-07-21T01:36:50.657906  =

    2023-07-21T01:36:50.760339  / # . /lava-4302/environment/lava-4302/bin/=
lava-test-runner /lava-4302/1
    2023-07-21T01:36:50.761504  =

    2023-07-21T01:36:50.766408  / # /lava-4302/bin/lava-test-runner /lava-4=
302/1 =

    ... (12 line(s) more)  =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/64b9e1464c0667bcf18ace1c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-11-g2b3c22dc0633/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-11-g2b3c22dc0633/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b9e1464c0667bcf18ace1f
        failing since 187 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-21T01:36:55.430014  <8>[   12.977545] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 988098_1.5.2.4.1>
    2023-07-21T01:36:55.539213  / # #
    2023-07-21T01:36:55.641248  export SHELL=3D/bin/sh
    2023-07-21T01:36:55.641802  #
    2023-07-21T01:36:55.743081  / # export SHELL=3D/bin/sh. /lava-988098/en=
vironment
    2023-07-21T01:36:55.743527  =

    2023-07-21T01:36:55.844804  / # . /lava-988098/environment/lava-988098/=
bin/lava-test-runner /lava-988098/1
    2023-07-21T01:36:55.845395  =

    2023-07-21T01:36:55.852010  / # /lava-988098/bin/lava-test-runner /lava=
-988098/1
    2023-07-21T01:36:55.956438  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20

