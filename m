X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web10.4591.1642228861247275138
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 14 Jan 2022 22:41:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=X9ubSfr4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.174, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f174.google.com with SMTP id c5so4629226pgk.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 14 Jan 2022 22:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=MOjXblB6yw61bzrbE+6nZ6tse4T75mqqs1FALG+lueY=;
        b=X9ubSfr4c7Y67OsaFACZBQOFurwCm5WRDWLHZINdZWiBMwqjmA+d4BGypNLhe2NdFy
         sVExwUruwGyBomZ7qYAFeoN9x41rCn0oFHEiKXKoMANTywOl9xh3pLwkUuspXJKT5fjK
         QQP6oHTYBRxbOoMQ3QgCAUtrCfOIDOWK2GwVjWOunTVzc5awMcdpQA7IZuwKnMls87WI
         hpNvLNE8UtvZBiEuhOzNQTGY66XBl4LUQLQRpeif2FsyGU1JHz1NYLy6hb5T9vMQTPgv
         rMvPRzgG2OSm27WSRybqOfNMwc1pqB5WpiylMVPqZb3Y+ma96UrAoHDSlYtue76M47Wl
         Lwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=MOjXblB6yw61bzrbE+6nZ6tse4T75mqqs1FALG+lueY=;
        b=XrtRTJ3kQ0NGyp8WFAnk8fxuL+7IboBCeHVBjiTacdsub3JmG2eBbvQUGwU+N6FZwx
         yoNKV1/gRH2B36z6fOflMWJEJ11vaInCdSrDSy0/bK1PzIoAUwitYhX2uFz7d8erXZSP
         X8NJgRHLmLkmZyFhKerYaTwQMnyBnAE7R4MOxotWr0ERjxoCH5V/rJZVkpPhOS20dzyw
         I3T0M8sCF1GdUJt65MFt54IXJQJoC4XiHvc/OzVddJw51SRLj0aFHo08uU5L6VnZMMvp
         RsWgLh51Twx5jPLVxDe/OrsPb4sMu2+/xACerRfjifjJPahaEOasTAyUWH0arfdFaOBV
         +FAg==
X-Gm-Message-State: AOAM533QaYg7dB4DqWyfEfnnSemMzyy0Pe8HvAU8BP02HwVT5TjWH8YN
	vIStbOrHayD3KROu2tuKFzm326HxhbsK2ArY
X-Google-Smtp-Source: ABdhPJyQorcMXsL5hL7eo0Pzq3OWuHbcPcZL624ZPHfXWcjph5DJlYNo0FToUyC7XwoYYYhRVSbccQ==
X-Received: by 2002:aa7:84c1:0:b0:4bf:379:1d85 with SMTP id x1-20020aa784c1000000b004bf03791d85mr12133824pfn.5.1642228860548;
        Fri, 14 Jan 2022 22:41:00 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n14sm5992992pgd.80.2022.01.14.22.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 22:41:00 -0800 (PST)
Message-ID: <61e26c7c.1c69fb81.45414.1637@mx.google.com>
Date: Fri, 14 Jan 2022 22:41:00 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.225-cip65
X-Kernelci-Branch: linux-4.19.y-cip
Subject: cip/linux-4.19.y-cip baseline: 158 runs, 3 regressions (v4.19.225-cip65) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.19.y-cip baseline: 158 runs, 3 regressions (v4.19.225-cip65)

Regressions Summary
-------------------

platform   | arch | lab           | compiler | defconfig             | regr=
essions
-----------+------+---------------+----------+-----------------------+-----=
-------
da850-lcdk | arm  | lab-baylibre  | gcc-10   | davinci_all_defconfig | 2   =
       =

panda      | arm  | lab-collabora | gcc-10   | omap2plus_defconfig   | 1   =
       =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.225-cip65/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.225-cip65
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      def5c8e4375baf1ae9c6421ce39f5cad2f3f2052 =



Test Regressions
---------------- =



platform   | arch | lab           | compiler | defconfig             | regr=
essions
-----------+------+---------------+----------+-----------------------+-----=
-------
da850-lcdk | arm  | lab-baylibre  | gcc-10   | davinci_all_defconfig | 2   =
       =


  Details:     https://kernelci.org/test/plan/id/61e261596d1ee9be27ef6761

  Results:     4 PASS, 2 FAIL, 0 SKIP
  Full config: davinci_all_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.225=
-cip65/arm/davinci_all_defconfig/gcc-10/lab-baylibre/baseline-da850-lcdk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.225=
-cip65/arm/davinci_all_defconfig/gcc-10/lab-baylibre/baseline-da850-lcdk.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20211210.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/61e261596d1ee9b=
e27ef6765
        new failure (last pass: v4.19.222-cip64)
        6 lines

    2022-01-15T05:53:23.187233  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3000
    2022-01-15T05:53:23.188003  kern  :alert : raw: 00000000 00000100 00000=
200 00000000 00000004 0000000a ffffff7f 00000000
    2022-01-15T05:53:23.188516  kern  :alert : page dumped because: nonzero=
 mapcount
    2022-01-15T05:53:23.189059  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3400
    2022-01-15T05:53:23.189520  kern  :alert : raw: 00000000 00000100 00000=
200 00000000 00000004 0000000a ffffff7f 00000000
    2022-01-15T05:53:23.190023  kern  :alert : page dumped because: nonzero=
 mapcount
    2022-01-15T05:53:23.224146  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dale=
rt RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D6>   =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/61e261596d1ee9b=
e27ef6766
        new failure (last pass: v4.19.222-cip64)
        4 lines

    2022-01-15T05:53:23.361361  kern  :emerg : page:c6f49000 count:0 mapcou=
nt:-128 mapping:00000000 index:0x4
    2022-01-15T05:53:23.362193  kern  :emerg : flags: 0x0()
    2022-01-15T05:53:23.362748  kern  :emerg : page:c6f51000 count:0 mapcou=
nt:-128 mapping:00000000 index:0x4
    2022-01-15T05:53:23.363245  kern  :emerg : flags: 0x0()
    2022-01-15T05:53:23.429603  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Deme=
rg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D4>
    2022-01-15T05:53:23.430410  + set +x
    2022-01-15T05:53:23.432988  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 1403132_1.5.=
2.4.1>   =

 =



platform   | arch | lab           | compiler | defconfig             | regr=
essions
-----------+------+---------------+----------+-----------------------+-----=
-------
panda      | arm  | lab-collabora | gcc-10   | omap2plus_defconfig   | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/61e261dfb25b8f465cef6764

  Results:     5 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.225=
-cip65/arm/omap2plus_defconfig/gcc-10/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.225=
-cip65/arm/omap2plus_defconfig/gcc-10/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20211210.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/61e261dfb25b8f4=
65cef6767
        failing since 46 days (last pass: v4.19.216-cip61, first fail: v4.1=
9.217-cip62)
        2 lines

    2022-01-15T05:55:31.022706  <8>[   21.212860] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dalert RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2022-01-15T05:55:31.071942  kern  :emerg : BUG: spinlock bad magic on C=
PU#0, udevd/105
    2022-01-15T05:55:31.081038  kern  :emerg :  lock: emif_lock+0x0/0xffffe=
cfc [emif], .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0   =

 =20

