X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web12.12885.1641929844941305016
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Jan 2022 11:37:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=gbn7ZY1d;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id e19so304784plc.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 11 Jan 2022 11:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ewXk3LeaHR1dKeEOz2p8SaIdsEHYvcwx61aU+aEnhK4=;
        b=gbn7ZY1d4bD813pQxYj8T8xb0Y07J55LJyGCS41HyUvi9vpKiEFm7i1/JqyB0C53N2
         orifMLFucnwrUENcUdxVrNomt1fAfWGCGdDr7nMrIkgMLQEqPfxmzBk7TQMHHHrP3yK+
         306d9mLV17yFU/nFsMNUB4Fe0b1V/ywv1tm3hwe2Hll9VAV3Y3F7mWJNECFoIpzL9ddD
         pthmVf7OE4q0Rkb6nDdJKfitIbBybP5SHEDJJjB0NnYhcidQVLaSVGzdIy+XWULj5hjx
         J+80dZYUynRRkcalmleEsM7AIL7Z7inaqplMnHYKkK8v81lmOHapD5DD5UzkdZKEHn4W
         jraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ewXk3LeaHR1dKeEOz2p8SaIdsEHYvcwx61aU+aEnhK4=;
        b=07i2/QC9++jVpKM7fJYeV2338vhyjjZ3umYpfrHT2WJ7M/kS85uqGa8xthcbbI0gND
         58fHKtm1v7PDLaTuuCKZOqTNF6pBnz/UknxISo+3kfEca+UVCtI58JZjZD9rM782f01z
         nxnEZGZf8UGqpSRvx065gUO3MEP6KCamaGoPpmQk8wgFxXd4Jb5oRcDvZJ98SoJ3MCpI
         H7k1eWXa/pKmxbuks/3PbnqHk2jjeklt0RfxbM6sekFcJgSw8xOYQMzFYLbBx8ADX/qO
         CnnAmMq+o/bA+6tbu3y79yoIaQzMMKGx5kU/XAn/a2ilVL/MxxRvcpHa1o6j5BNY7eg2
         QHeg==
X-Gm-Message-State: AOAM531mIYCoQjQHxXgywldOmvgE98Um+KcWnbStj9suCE0mUaJgR4g1
	9GGz26/KbIDME9pNh2sEehHDiRvb1GSM7hBw
X-Google-Smtp-Source: ABdhPJyKMKXfXHFtyAcBzWizMzarLphYm6vVPzJDVaxp50kUeC4ZqBJbQsRtRFg37qERpMUmyFM4hw==
X-Received: by 2002:a17:903:110c:b0:149:9004:4e7c with SMTP id n12-20020a170903110c00b0014990044e7cmr5855180plh.167.1641929844081;
        Tue, 11 Jan 2022 11:37:24 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c6sm3066751pjo.39.2022.01.11.11.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 11:37:23 -0800 (PST)
Message-ID: <61dddc73.1c69fb81.aa77b.82c8@mx.google.com>
Date: Tue, 11 Jan 2022 11:37:23 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.83-cip1-89-ga7f9ee34265b
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip sleep: 8 runs, 1 regressions (v5.10.83-cip1-89-ga7f9ee34265b) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip sleep: 8 runs, 1 regressions (v5.10.83-cip1-89-ga7f9ee=
34265b)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.83-cip1-89-ga7f9ee34265b/plan/sleep/

  Test:     sleep
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.83-cip1-89-ga7f9ee34265b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a7f9ee34265bcc306fd450f83524d631b74b6dbb =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/61ddca78c82187ca29ef673e

  Results:     21 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1-89-ga7f9ee34265b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/sleep-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1-89-ga7f9ee34265b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/sleep-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
211224.1/amd64/rootfs.cpio.gz =



  * sleep.rtcwake-freeze-1: https://kernelci.org/test/case/id/61ddca78c8218=
7ca29ef6749
        failing since 16 days (last pass: v5.10.83-cip1-53-g2f788040f8b6, f=
irst fail: v5.10.83-cip1-74-g842fbb4554b8)

    2022-01-11T18:19:25.131632  rtcwake: assuming RTC uses UTC ...
    2022-01-11T18:19:25.138241  rtcwake: wakeup from \"freeze\" using rtc0 =
at Tue Jan 11 18:19:30 2022
    2022-01-11T18:19:25.141693  <6>[   30.746151] PM: suspend entry (deep)
    2022-01-11T18:19:25.148639  <6>[   30.751377] Filesystems sync: 0.000 s=
econds
    2022-01-11T18:19:25.155096  <6>[   30.755996] Freezing user space proce=
sses ... (elapsed 0.001 seconds) done.
    2022-01-11T18:19:25.158451  <6>[   30.764489] OOM killer disabled.
    2022-01-11T18:19:26.223093  <6>[   30.767974] Freezing remaining freeza=
ble tasks ... (elapsed 1.055 seconds) done.
    2022-01-11T18:19:26.229740  <6>[   31.831235] printk: Suspending consol=
e(s) (use no_console_suspend to debug)
    2022-01-11T18:19:26.338676  =

    2022-01-11T18:19:26.339246   =

    ... (1151 line(s) more)  =

 =20

