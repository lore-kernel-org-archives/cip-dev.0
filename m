Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2B5C4829D
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 04:28:29 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web11.13379.1707280103275857208
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Feb 2024 20:28:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=G3NaxEUQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-296c2b74448so156132a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Feb 2024 20:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707280102; x=1707884902; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KTD4ynbkd/Gk60EkQ+5K2P4CLvVIRAPzIvF5DnsB3FA=;
        b=G3NaxEUQ0+UtNrvNB1KBU3Si0DQ++sPC/++Lw4XF1RgNQ4hd+jmM4NRTeIpm4Iz4BH
         /+oWP7O+TjOr5KNxR4p76PDjruWkTyb23Fz9y5nw2rda8lFujo/im/DE+5Nwx+2+ZKj8
         rOWSIv0p2mjHrgj9uy2i2xbBPsk6P1NCAcjEDJheTK6a97gDOGKMtQG3Bkx7K05SwLCO
         2nBe6brkCz9EBSuCLo5klR97Ee+on0Hgg3MQg1vedoNosCSWK74/mfWmz64LEr5lt+/5
         3TAi2NwN4v1FhxeqVtFszpyBOXcxiaQmH2vwV6hXV86AB87o0mhrne/VE/2wObF7HAJE
         XB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707280102; x=1707884902;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KTD4ynbkd/Gk60EkQ+5K2P4CLvVIRAPzIvF5DnsB3FA=;
        b=LdtskDsJWoQc81MCtO3HIe15llvIr/DjIYkKPicMYrHpcSzTkfH2PGI+kpeC10g0Om
         FOLSyPU//Qlu35t6lFF6eZ2Vi4d1rbBowh+VizBed690h2O9qzGno0z3XNiHKz2m7yt3
         zx0qvQqdehKiJ5xoML+KsDc8/Y3nDH7TuGJHkxMmuykTqgjOzpJVubY/wUtL8fIutcEw
         kacHj982ombK2dftWnqiGqJ+aPvYVI81hNSS1e7Ehvc1hVHgkR/qXFOvVVp7+mAOI6Y8
         cFvM/H/ig6qkG72kzXJeiqirRPA4dRMRbTh2vQAUwuBampBXgOWa74ZUdzbQprh61/9U
         xPrw==
X-Gm-Message-State: AOJu0Yzj2Os0GlbNjS3sF6sjJLxdCUkLZd++NARXxhYPrpgIN28BlFmR
	h2+55o71jBeUbLbT2e4lJ+VJxvnd+8eiHfuEes7zFeiycRB0sv1cUhDrRn0v5ivqL7HdqKscwGX
	F
X-Google-Smtp-Source: AGHT+IGoN1TwvIhkMrZjYq58nM8T66H0L1PgR3KGNEoe7hBLvq+VSHVSUEf77J7yOgU56zOkCCrYWg==
X-Received: by 2002:a17:90b:19c6:b0:296:3cde:98a with SMTP id nm6-20020a17090b19c600b002963cde098amr1581166pjb.6.1707280100996;
        Tue, 06 Feb 2024 20:28:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id dj16-20020a17090ad2d000b00296e04442b8sm435970pjb.41.2024.02.06.20.28.19
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 20:28:19 -0800 (PST)
Message-ID: <65c306e3.170a0220.cad9f.1621@mx.google.com>
Date: Tue, 06 Feb 2024 20:28:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1250-g39ff255b75f5
Subject: cip-gitlab/ci/pavel/linux-test baseline: 68 runs,
 117 regressions (v4.4.302-cip72-1250-g39ff255b75f5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 04:28:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14861

cip-gitlab/ci/pavel/linux-test baseline: 68 runs, 117 regressions (v4.4.302=
-cip72-1250-g39ff255b75f5)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

acer-chromebox-cxi4-puff     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

acer-chromebox-cxi5-brask    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

acer-cp514-3wh-r0qs-guybrush | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig          | 10         =

bcm2835-rpi-b-rev2           | arm    | lab-broonie     | gcc-10   | bcm283=
5_defconfig          | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 13         =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig         | 13         =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig        | 15         =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig        | 15         =

dell-latitude...4305U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

dell-latitude...8665U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

imx28-duckbill               | arm    | lab-pengutronix | gcc-10   | mxs_de=
fconfig              | 1          =

qemu_arm-virt-gicv2          | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =

qemu_arm-virt-gicv2          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 1          =

qemu_arm-virt-gicv2-uefi     | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =

qemu_arm-virt-gicv2-uefi     | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 1          =

qemu_arm-virt-gicv3          | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =

qemu_arm-virt-gicv3          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 1          =

qemu_arm-virt-gicv3-uefi     | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =

qemu_arm-virt-gicv3-uefi     | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 1          =

qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig            | 1          =

qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig            | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defconfig           | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig           | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig         | 1          =

rk3288-rock2-square          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 2          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 20         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip72-1250-g39ff255b75f5/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip72-1250-g39ff255b75f5
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      39ff255b75f5caee714b345c0c47b1c44b88dbe0 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb1d998b3052258e1e87

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2fb1d998b3052258e1=
e88
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb1f998b3052258e1e90

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2fb1f998b3052258e1=
e91
        failing since 1 day (last pass: v6.1.75-cip14-132-g6e54756fbd6c2, f=
irst fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb1f9194736ef28e1e96

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2fb1f9194736ef28e1=
e97
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
acer-chromebox-cxi5-brask    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb27998b3052258e1e9e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-chromebox-cxi5-brask.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-chromebox-cxi5-brask.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2fb27998b3052258e1=
e9f
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
acer-cp514-3wh-r0qs-guybrush | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb159194736ef28e1e8a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-cp514-3wh-r0qs-guybrush.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-acer-cp514-3wh-r0qs-guybrush.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2fb159194736ef28e1=
e8b
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb283e9268596d8e1e96

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2fb283e9268596d8e1=
e97
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb1e998b3052258e1e8a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2fb1e998b3052258e1=
e8b
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb1f998b3052258e1e8d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2fb1f998b3052258e1=
e8e
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig          | 10         =


  Details:     https://kernelci.org/test/plan/id/65c2fa6a725221e59b8e1ead

  Results:     36 PASS, 11 FAIL, 2 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/65c=
2fa6a725221e59b8e1eb2
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-07T03:34:53.714925  /lava-551989/1/../bin/lava-test-case   =


  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/65c2fa6a7=
25221e59b8e1eb8
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-07T03:34:52.589831  random: nonblocking pool is initialized
    2024-02-07T03:34:53.348834  /lava-551989/1/../bin/lava-test-case   =


  * baseline.bootrr.audio-card-probed: https://kernelci.org/test/case/id/65=
c2fa6a725221e59b8e1eb9
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-07T03:34:52.270649  /lava-551989/1/../bin/lava-test-case   =


  * baseline.bootrr.wm8731-driver-present: https://kernelci.org/test/case/i=
d/65c2fa6a725221e59b8e1ebd
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-07T03:34:48.786473  /lava-551989/1/../bin/lava-test-case
    2024-02-07T03:34:48.854879  sh: /sys/bus/spi/drivers/wm8731: unknown op=
erand
    2024-02-07T03:34:49.872361  /lava-551989/1/../bin/lava-test-case   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
65c2fa6a725221e59b8e1ebe
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-07T03:34:47.700563  /lava-551989/1/../bin/lava-test-case   =


  * baseline.bootrr.i2c0-probed: https://kernelci.org/test/case/id/65c2fa6a=
725221e59b8e1ebf
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:34:46.622589  /lava-551989/1/../bin/lava-test-case   =


  * baseline.bootrr.atmel-nand-driver-present: https://kernelci.org/test/ca=
se/id/65c2fa6a725221e59b8e1ed4
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:34:39.739790  /lava-551989/1/../bin/lava-test-case
    2024-02-07T03:34:40.825864  /lava-551989/1/../bin/lava-test-case   =


  * baseline.bootrr.atmel-ebi-driver-present: https://kernelci.org/test/cas=
e/id/65c2fa6a725221e59b8e1ed5
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:34:38.653907  /lava-551989/1/../bin/lava-test-case   =


  * baseline.bootrr.atmel-usart-serial-driver-present: https://kernelci.org=
/test/case/id/65c2fa6a725221e59b8e1ed8
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:34:34.162084  /lava-551989/1/../bin/lava-test-case   =


  * baseline.bootrr.at91-usart-mode-driver-present: https://kernelci.org/te=
st/case/id/65c2fa6a725221e59b8e1ed9
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:34:33.076261  /lava-551989/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
bcm2835-rpi-b-rev2           | arm    | lab-broonie     | gcc-10   | bcm283=
5_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2f9ac95eb94e7118e1e79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/bcm2835_defconfig/gcc-10/lab-broonie=
/baseline-bcm2835-rpi-b-rev2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/bcm2835_defconfig/gcc-10/lab-broonie=
/baseline-bcm2835-rpi-b-rev2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2f9ac95eb94e7118e1=
e7a
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 13         =


  Details:     https://kernelci.org/test/plan/id/65c2fa88725221e59b8e1f11

  Results:     15 PASS, 21 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65c2fa887=
25221e59b8e1f14
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-07T03:35:30.661987  /lava-552003/1/../bin/lava-test-case
    2024-02-07T03:35:30.678900  [   57.719113] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2024-02-07T03:35:31.702270  /lava-552003/1/../bin/lava-test-case
    2024-02-07T03:35:31.717837  [   58.759318] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.simple-audio-driver-present: https://kernelci.org/test/=
case/id/65c2fa88725221e59b8e1f15
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:35:28.605017  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2024-02-07T03:35:29.620396  /lava-552003/1/../bin/lava-test-case
    2024-02-07T03:35:29.638163  [   56.677577] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/65c2fa88725221e59b8e1f16
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-07T03:35:27.537098  /lava-552003/1/../bin/lava-test-case
    2024-02-07T03:35:27.553565  [   54.594321] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-02-07T03:35:28.577954  /lava-552003/1/../bin/lava-test-case
    2024-02-07T03:35:28.597674  [   55.635296] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
65c2fa88725221e59b8e1f17
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-07T03:35:25.456029  /lava-552003/1/../bin/lava-test-case
    2024-02-07T03:35:25.472685  [   52.512777] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-02-07T03:35:26.495971  /lava-552003/1/../bin/lava-test-case
    2024-02-07T03:35:26.512696  [   53.553290] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/65c2fa88725221e59b8e1f18
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-07T03:35:23.374803  /lava-552003/1/../bin/lava-test-case
    2024-02-07T03:35:23.391422  [   50.431731] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-02-07T03:35:24.415124  /lava-552003/1/../bin/lava-test-case
    2024-02-07T03:35:24.432488  [   51.472074] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/65c2fa88725221e59b8e1f22
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:35:10.725902  /lava-552003/1/../bin/lava-test-case
    2024-02-07T03:35:10.743173  [   37.782416] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2024-02-07T03:35:11.766760  /lava-552003/1/../bin/lava-test-case
    2024-02-07T03:35:11.784438  [   38.823279] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/65c2fa88725221e59b8e1f23
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-07T03:35:09.684285  /lava-552003/1/../bin/lava-test-case
    2024-02-07T03:35:09.702060  [   36.740794] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.am335x-phy-driver-present: https://kernelci.org/test/ca=
se/id/65c2fa88725221e59b8e1f26
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:35:05.440903  /lava-552003/1/../bin/lava-test-case
    2024-02-07T03:35:05.458717  [   32.497408] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb0-musb-dsps-probed RESULT=3Dblocked>
    2024-02-07T03:35:06.482469  /lava-552003/1/../bin/lava-test-case
    2024-02-07T03:35:06.500097  [   33.538933] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb1-musb-dsps-probed RESULT=3Dblocked>
    2024-02-07T03:35:07.523590  /lava-552003/1/../bin/lava-test-case
    2024-02-07T03:35:07.541954  [   34.580416] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dam335x-phy-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.musb-dsps-driver-present: https://kernelci.org/test/cas=
e/id/65c2fa88725221e59b8e1f27
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:35:02.318619  /lava-552003/1/../bin/lava-test-case
    2024-02-07T03:35:02.334077  [   29.374679] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc0-probed RESULT=3Dblocked>
    2024-02-07T03:35:03.359283  /lava-552003/1/../bin/lava-test-case
    2024-02-07T03:35:03.376077  [   30.415617] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc1-probed RESULT=3Dblocked>
    2024-02-07T03:35:04.399457  /lava-552003/1/../bin/lava-test-case
    2024-02-07T03:35:04.417314  [   31.455978] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmusb-dsps-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sdhci-omap-driver-present: https://kernelci.org/test/ca=
se/id/65c2fa88725221e59b8e1f28
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:35:01.277229  /lava-552003/1/../bin/lava-test-case
    2024-02-07T03:35:01.294610  [   28.333307] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tps65217-driver-present: https://kernelci.org/test/case=
/id/65c2fa88725221e59b8e1f2e
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:34:56.979260  /lava-552003/1/../bin/lava-test-case
    2024-02-07T03:34:56.996794  [   24.035285] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtps65217-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/65c2fa88725221e59b8e1f32
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:34:54.777028  /lava-552003/1/../bin/lava-test-case
    2024-02-07T03:34:54.794405  [   21.833037] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/65c2fa88725221e5=
9b8e1f38
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)
        1 lines

    2024-02-07T03:34:52.440553  / # =

    2024-02-07T03:34:52.446677  =

    2024-02-07T03:34:52.550628  / # #
    2024-02-07T03:34:52.556591  #
    2024-02-07T03:34:52.658782  / # export SHELL=3D/bin/sh
    2024-02-07T03:34:52.664813  export SHELL=3D/bin/sh
    2024-02-07T03:34:52.766993  / # . /lava-552003/environment
    2024-02-07T03:34:52.773028  . /lava-552003/environment
    2024-02-07T03:34:52.875234  / # /lava-552003/bin/lava-test-runner /lava=
-552003/0
    2024-02-07T03:34:52.880781  /lava-552003/bin/lava-test-runner /lava-552=
003/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig         | 13         =


  Details:     https://kernelci.org/test/plan/id/65c30073ece5893d568e1e8b

  Results:     15 PASS, 21 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-cip/ba=
seline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65c30073e=
ce5893d568e1e8e
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-07T04:00:27.952989  /lava-1089707/1/../bin/lava-test-case
    2024-02-07T04:00:27.971312  [   48.748455] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2024-02-07T04:00:28.992767  /lava-1089707/1/../bin/lava-test-case
    2024-02-07T04:00:29.009491  [   49.788183] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.simple-audio-driver-present: https://kernelci.org/test/=
case/id/65c30073ece5893d568e1e8f
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T04:00:25.896007  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2024-02-07T04:00:26.912018  /lava-1089707/1/../bin/lava-test-case
    2024-02-07T04:00:26.930268  [   47.707031] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/65c30073ece5893d568e1e90
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-07T04:00:24.828584  /lava-1089707/1/../bin/lava-test-case
    2024-02-07T04:00:24.845396  [   45.624094] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-02-07T04:00:25.869910  /lava-1089707/1/../bin/lava-test-case
    2024-02-07T04:00:25.888765  [   46.664552] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
65c30073ece5893d568e1e91
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-07T04:00:22.748698  /lava-1089707/1/../bin/lava-test-case
    2024-02-07T04:00:22.764642  [   43.542483] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-02-07T04:00:23.788061  /lava-1089707/1/../bin/lava-test-case
    2024-02-07T04:00:23.805092  [   44.583075] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/65c30073ece5893d568e1e92
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-07T04:00:20.666152  /lava-1089707/1/../bin/lava-test-case
    2024-02-07T04:00:20.683328  [   41.460935] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-02-07T04:00:21.706659  /lava-1089707/1/../bin/lava-test-case
    2024-02-07T04:00:21.723860  [   42.501317] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/65c30073ece5893d568e1e9c
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T04:00:08.019591  /lava-1089707/1/../bin/lava-test-case
    2024-02-07T04:00:08.036415  [   28.813334] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2024-02-07T04:00:09.060082  /lava-1089707/1/../bin/lava-test-case
    2024-02-07T04:00:09.078611  [   29.854123] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/65c30073ece5893d568e1e9d
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-07T04:00:06.978982  /lava-1089707/1/../bin/lava-test-case
    2024-02-07T04:00:06.994857  [   27.772105] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.am335x-phy-driver-present: https://kernelci.org/test/ca=
se/id/65c30073ece5893d568e1ea0
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T04:00:02.735582  /lava-1089707/1/../bin/lava-test-case
    2024-02-07T04:00:02.753886  [   23.529137] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb0-musb-dsps-probed RESULT=3Dblocked>
    2024-02-07T04:00:03.777804  /lava-1089707/1/../bin/lava-test-case
    2024-02-07T04:00:03.794818  [   24.570747] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb1-musb-dsps-probed RESULT=3Dblocked>
    2024-02-07T04:00:04.818441  /lava-1089707/1/../bin/lava-test-case
    2024-02-07T04:00:04.835522  [   25.612052] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dam335x-phy-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.musb-dsps-driver-present: https://kernelci.org/test/cas=
e/id/65c30073ece5893d568e1ea1
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:59:59.614836  /lava-1089707/1/../bin/lava-test-case
    2024-02-07T03:59:59.630983  [   20.407651] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc0-probed RESULT=3Dblocked>
    2024-02-07T04:00:00.654338  /lava-1089707/1/../bin/lava-test-case
    2024-02-07T04:00:00.670307  [   21.447897] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc1-probed RESULT=3Dblocked>
    2024-02-07T04:00:01.694925  /lava-1089707/1/../bin/lava-test-case
    2024-02-07T04:00:01.710859  [   22.487889] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmusb-dsps-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sdhci-omap-driver-present: https://kernelci.org/test/ca=
se/id/65c30073ece5893d568e1ea2
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:59:58.572219  /lava-1089707/1/../bin/lava-test-case
    2024-02-07T03:59:58.590254  [   19.366275] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tps65217-driver-present: https://kernelci.org/test/case=
/id/65c30073ece5893d568e1ea8
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:59:54.272489  /lava-1089707/1/../bin/lava-test-case
    2024-02-07T03:59:54.290697  [   15.066164] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtps65217-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/65c30073ece5893d568e1eac
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:59:52.070419  /lava-1089707/1/../bin/lava-test-case
    2024-02-07T03:59:52.087516  [   12.863547] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/65c30073ece5893d=
568e1eb3
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)
        1 lines

    2024-02-07T03:59:49.728940  / # =

    2024-02-07T03:59:49.736488  =

    2024-02-07T03:59:49.840920  / # #
    2024-02-07T03:59:49.847777  #
    2024-02-07T03:59:49.949446  / # export SHELL=3D/bin/sh
    2024-02-07T03:59:49.956057  export SHELL=3D/bin/sh
    2024-02-07T03:59:50.057440  / # . /lava-1089707/environment
    2024-02-07T03:59:50.064614  . /lava-1089707/environment
    2024-02-07T03:59:50.166064  / # /lava-1089707/bin/lava-test-runner /lav=
a-1089707/0
    2024-02-07T03:59:50.173370  /lava-1089707/bin/lava-test-runner /lava-10=
89707/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig        | 15         =


  Details:     https://kernelci.org/test/plan/id/65c2f97de8ad84e39f8e1e91

  Results:     24 PASS, 17 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65c2f97de=
8ad84e39f8e1e94
        new failure (last pass: v5.10.209-cip44-rebase)

    2024-02-07T03:30:59.932918  /lava-551972/1/../bin/lava-test-case
    2024-02-07T03:30:59.977125  [   49.765430] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2024-02-07T03:31:01.042034  /lava-551972/1/../bin/lava-test-case
    2024-02-07T03:31:01.084578  [   50.873862] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.simple-audio-driver-present: https://kernelci.org/test/=
case/id/65c2f97de8ad84e39f8e1e95
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:30:57.622124  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2024-02-07T03:30:58.730016  /lava-551972/1/../bin/lava-test-case
    2024-02-07T03:30:58.809784  [   48.597283] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/65c2f97de8ad84e39f8e1e96
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:30:56.319319  /lava-551972/1/../bin/lava-test-case
    2024-02-07T03:30:56.396975  [   46.185399] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-02-07T03:30:57.521064  /lava-551972/1/../bin/lava-test-case
    2024-02-07T03:30:57.601250  [   47.389017] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
65c2f97de8ad84e39f8e1e97
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:30:54.046567  /lava-551972/1/../bin/lava-test-case
    2024-02-07T03:30:54.091127  [   43.879469] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-02-07T03:30:55.160699  /lava-551972/1/../bin/lava-test-case
    2024-02-07T03:30:55.239874  [   45.027891] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/65c2f97de8ad84e39f8e1e98
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:30:51.735471  /lava-551972/1/../bin/lava-test-case
    2024-02-07T03:30:51.813247  [   41.601749] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-02-07T03:30:52.934602  /lava-551972/1/../bin/lava-test-case
    2024-02-07T03:30:52.979586  [   42.767425] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tilcdc-driver-probed: https://kernelci.org/test/case/id=
/65c2f97de8ad84e39f8e1e99
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:30:50.528817  /lava-551972/1/../bin/lava-test-case
    2024-02-07T03:30:50.608081  [   40.396125] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtilcdc-driver-probed RESULT=3Dfail>   =


  * baseline.bootrr.omap-sham-driver-present: https://kernelci.org/test/cas=
e/id/65c2f97de8ad84e39f8e1e9e
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:30:47.831861  /lava-551972/1/../bin/lava-test-case
    2024-02-07T03:30:47.910037  [   37.697224] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap-aes-driver-present: https://kernelci.org/test/case=
/id/65c2f97de8ad84e39f8e1ea1
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:30:45.262469  /lava-551972/1/../bin/lava-test-case
    2024-02-07T03:30:45.339978  [   35.127122] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/65c2f97de8ad84e39f8e1ea4
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:30:41.533252  /lava-551972/1/../bin/lava-test-case
    2024-02-07T03:30:41.614397  [   31.401599] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2024-02-07T03:30:42.736221  /lava-551972/1/../bin/lava-test-case
    2024-02-07T03:30:42.817132  [   32.603766] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/65c2f97de8ad84e39f8e1ea5
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:30:40.326056  /lava-551972/1/../bin/lava-test-case
    2024-02-07T03:30:40.407239  [   30.193862] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sdhci-omap-driver-present: https://kernelci.org/test/ca=
se/id/65c2f97de8ad84e39f8e1ead
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:30:34.957223  /lava-551972/1/../bin/lava-test-case
    2024-02-07T03:30:35.038959  [   24.825460] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dbaseboard-eeprom-probed RESULT=3Dblocked>
    2024-02-07T03:30:36.163967  /lava-551972/1/../bin/lava-test-case
    2024-02-07T03:30:36.252587  [   26.039299] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
65c2f97de8ad84e39f8e1eae
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:30:33.753699  /lava-551972/1/../bin/lava-test-case
    2024-02-07T03:30:33.832176  [   23.619157] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dat24-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.pwrbutton-driver-present: https://kernelci.org/test/cas=
e/id/65c2f97de8ad84e39f8e1eb1
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:30:31.236958  /lava-551972/1/../bin/lava-test-case
    2024-02-07T03:30:31.316954  [   21.103321] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dpwrbutton-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/65c2f97de8ad84e39f8e1eb7
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:30:28.414480  /lava-551972/1/../bin/lava-test-case
    2024-02-07T03:30:28.495588  [   18.281900] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/65c2f97de8ad84e3=
9f8e1ebe
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)
        1 lines

    2024-02-07T03:30:25.297371  / # =

    2024-02-07T03:30:25.304985  =

    2024-02-07T03:30:25.411198  / # #
    2024-02-07T03:30:25.417461  #
    2024-02-07T03:30:25.520116  / # export SHELL=3D/bin/sh
    2024-02-07T03:30:25.525552  export SHELL=3D/bin/sh
    2024-02-07T03:30:25.636892  / # . /lava-551972/environment
    2024-02-07T03:30:25.645010  . /lava-551972/environment
    2024-02-07T03:30:25.747305  / # /lava-551972/bin/lava-test-runner /lava=
-551972/0
    2024-02-07T03:30:25.753149  /lava-551972/bin/lava-test-runner /lava-551=
972/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig        | 15         =


  Details:     https://kernelci.org/test/plan/id/65c2fbcf64bddcda018e1ead

  Results:     24 PASS, 17 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/omap2plus_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/65c2fbcf6=
4bddcda018e1eb0
        new failure (last pass: v5.10.209-cip44-rebase)

    2024-02-07T03:40:57.193985  /lava-1089693/1/../bin/lava-test-case
    2024-02-07T03:40:57.237334  [   44.003663] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2024-02-07T03:40:58.358259  /lava-1089693/1/../bin/lava-test-case
    2024-02-07T03:40:58.435849  [   45.203045] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.simple-audio-driver-present: https://kernelci.org/test/=
case/id/65c2fbcf64bddcda018e1eb1
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:40:55.026773  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2024-02-07T03:40:56.082162  /lava-1089693/1/../bin/lava-test-case
    2024-02-07T03:40:56.126219  [   42.891956] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/65c2fbcf64bddcda018e1eb2
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:40:53.766924  /lava-1089693/1/../bin/lava-test-case
    2024-02-07T03:40:53.845110  [   40.611614] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2024-02-07T03:40:54.968253  /lava-1089693/1/../bin/lava-test-case
    2024-02-07T03:40:55.012705  [   41.778476] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
65c2fbcf64bddcda018e1eb3
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:40:51.358685  /lava-1089693/1/../bin/lava-test-case
    2024-02-07T03:40:51.437849  [   38.204033] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2024-02-07T03:40:52.562100  /lava-1089693/1/../bin/lava-test-case
    2024-02-07T03:40:52.642290  [   39.408450] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/65c2fbcf64bddcda018e1eb4
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:40:48.950192  /lava-1089693/1/../bin/lava-test-case
    2024-02-07T03:40:49.028682  [   35.795047] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2024-02-07T03:40:50.151810  /lava-1089693/1/../bin/lava-test-case
    2024-02-07T03:40:50.233214  [   36.998874] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tilcdc-driver-probed: https://kernelci.org/test/case/id=
/65c2fbcf64bddcda018e1eb5
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:40:47.852131  /lava-1089693/1/../bin/lava-test-case
    2024-02-07T03:40:47.889837  [   34.655791] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtilcdc-driver-probed RESULT=3Dfail>   =


  * baseline.bootrr.omap-sham-driver-present: https://kernelci.org/test/cas=
e/id/65c2fbcf64bddcda018e1eba
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:40:45.195044  /lava-1089693/1/../bin/lava-test-case
    2024-02-07T03:40:45.225361  [   31.990960] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap-aes-driver-present: https://kernelci.org/test/case=
/id/65c2fbcf64bddcda018e1ebd
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:40:42.671574  /lava-1089693/1/../bin/lava-test-case
    2024-02-07T03:40:42.750348  [   29.515775] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/65c2fbcf64bddcda018e1ec0
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:40:38.947292  /lava-1089693/1/../bin/lava-test-case
    2024-02-07T03:40:39.026476  [   25.791911] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2024-02-07T03:40:40.150182  /lava-1089693/1/../bin/lava-test-case
    2024-02-07T03:40:40.187922  [   26.952941] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/65c2fbcf64bddcda018e1ec1
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:40:37.867771  /lava-1089693/1/../bin/lava-test-case
    2024-02-07T03:40:37.898367  [   24.663439] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sdhci-omap-driver-present: https://kernelci.org/test/ca=
se/id/65c2fbcf64bddcda018e1ec9
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:40:32.728013  /lava-1089693/1/../bin/lava-test-case
    2024-02-07T03:40:32.808292  [   19.573035] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dbaseboard-eeprom-probed RESULT=3Dblocked>
    2024-02-07T03:40:33.929317  /lava-1089693/1/../bin/lava-test-case
    2024-02-07T03:40:33.973891  [   20.738819] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
65c2fbcf64bddcda018e1eca
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:40:31.524721  /lava-1089693/1/../bin/lava-test-case
    2024-02-07T03:40:31.604535  [   18.369877] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dat24-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/65c2fbcf64bddcda018e1ecf
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:40:26.118554  /lava-1089693/1/../bin/lava-test-case
    2024-02-07T03:40:26.198475  [   12.963231] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.pwrbutton-driver-present: https://kernelci.org/test/cas=
e/id/65c2fbcf64bddcda018e1ed3
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:40:28.923720  /lava-1089693/1/../bin/lava-test-case
    2024-02-07T03:40:29.004618  [   15.769276] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dpwrbutton-driver-present RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/65c2fbcf64bddcda=
018e1eda
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)
        1 lines

    2024-02-07T03:40:22.970588  / # =

    2024-02-07T03:40:22.977233  =

    2024-02-07T03:40:23.080562  / # #
    2024-02-07T03:40:23.085989  #
    2024-02-07T03:40:23.187194  / # export SHELL=3D/bin/sh
    2024-02-07T03:40:23.192624  export SHELL=3D/bin/sh
    2024-02-07T03:40:23.293555  / # . /lava-1089693/environment
    2024-02-07T03:40:23.300992  . /lava-1089693/environment
    2024-02-07T03:40:23.402002  / # /lava-1089693/bin/lava-test-runner /lav=
a-1089693/0
    2024-02-07T03:40:23.407072  /lava-1089693/bin/lava-test-runner /lava-10=
89693/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb26998b3052258e1e9b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2fb26998b3052258e1=
e9c
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb113e9268596d8e1e7c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2fb113e9268596d8e1=
e7d
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb20998b3052258e1e93

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2fb20998b3052258e1=
e94
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb30092713896c8e1e7d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2fb30092713896c8e1=
e7e
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
imx28-duckbill               | arm    | lab-pengutronix | gcc-10   | mxs_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fa10687f36979c8e1eaa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: mxs_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/mxs_defconfig/gcc-10/lab-pengutronix=
/baseline-imx28-duckbill.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/mxs_defconfig/gcc-10/lab-pengutronix=
/baseline-imx28-duckbill.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2fa10687f36979c8e1=
eab
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_arm-virt-gicv2          | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2facd07bc61a34c8e1e9e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2facd07bc61a34c8e1=
e9f
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_arm-virt-gicv2          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fa4d71ec7d1a068e1e79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2fa4d71ec7d1a068e1=
e7a
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_arm-virt-gicv2-uefi     | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fbc3e3fb9243588e1e7d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-qemu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-qemu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2fbc3e3fb9243588e1=
e7e
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_arm-virt-gicv2-uefi     | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb3d4ef0f6438e8e1e7e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-qemu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-qemu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2fb3d4ef0f6438e8e1=
e7f
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb474ef0f6438e8e1e83

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2fb474ef0f6438e8e1=
e84
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fa92a5ba8b72d08e1eac

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2fa92a5ba8b72d08e1=
ead
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_arm-virt-gicv3-uefi     | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb95659ec511888e1f92

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-qemu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-qemu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2fb95659ec511888e1=
f93
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_arm-virt-gicv3-uefi     | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb51659ec511888e1e9e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-qemu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-qemu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2fb51659ec511888e1=
e9f
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2f98de8ad84e39f8e1ed1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/mips/malta_defconfig/gcc-10/lab-broonie/=
baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/mips/malta_defconfig/gcc-10/lab-broonie/=
baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2f98de8ad84e39f8e1=
ed2
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2f98ec5072a827b8e1e79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/mips/malta_defconfig/gcc-10/lab-collabor=
a/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/mips/malta_defconfig/gcc-10/lab-collabor=
a/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2f98ec5072a827b8e1=
e7a
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fa4174c594e6348e1eba

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig/gcc-10/lab-broon=
ie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig/gcc-10/lab-broon=
ie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2fa4174c594e6348e1=
ebb
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb1d9194736ef28e1e90

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2fb1d9194736ef28e1=
e91
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fa42980bbd9ade8e1e7f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig/gcc-10/lab-colla=
bora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig/gcc-10/lab-colla=
bora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2fa42980bbd9ade8e1=
e80
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fb1e9194736ef28e1e93

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2fb1e9194736ef28e1=
e94
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fae7ac2d652d408e1e7d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c2fae7ac2d652d408e1=
e7e
        failing since 1 day (last pass: v5.10.209-cip44-rebase, first fail:=
 v5.10.209-cip44-526-gbbb905888ca85) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
rk3288-rock2-square          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 2          =


  Details:     https://kernelci.org/test/plan/id/65c2fa31860d97eee98e1e95

  Results:     7 PASS, 2 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-rk3288-rock2-square.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-rk3288-rock2-square.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-pm-domain-driver-present: https://kernelci.org=
/test/case/id/65c2fa31860d97eee98e1e9a
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:41:24.825108  /lava-12711120/1/../bin/lava-test-case

    2024-02-07T03:41:24.862238  [   14.754117] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-probed RESULT=3Dblocked>

    2024-02-07T03:41:25.901103  /lava-12711120/1/../bin/lava-test-case

    2024-02-07T03:41:25.931633  [   15.823792] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pm-domain-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rk3288-crypto-driver-present: https://kernelci.org/test=
/case/id/65c2fa31860d97eee98e1e9b
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:41:23.729271  /lava-12711120/1/../bin/lava-test-case

    2024-02-07T03:41:23.770968  [   13.662635] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-driver-present RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 20         =


  Details:     https://kernelci.org/test/plan/id/65c2fa4574c594e6348e1ec0

  Results:     37 PASS, 22 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-pm-domain-driver-present: https://kernelci.org=
/test/case/id/65c2fa4574c594e6348e1ec5
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:41:57.302022  [   45.814520] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-driver-present RESULT=3Dfail>

    2024-02-07T03:41:58.355418  /lava-12711115/1/../bin/lava-test-case

    2024-02-07T03:41:58.393094  [   46.905910] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-probed RESULT=3Dblocked>

    2024-02-07T03:41:59.433070  /lava-12711115/1/../bin/lava-test-case
   =


  * baseline.bootrr.rk3288-crypto-driver-present: https://kernelci.org/test=
/case/id/65c2fa4574c594e6348e1ec6
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:41:56.243377  [   44.756314] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vopl-probed RESULT=3Dfail>

    2024-02-07T03:41:57.264034  /lava-12711115/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-vopl-probed: https://kernelci.org/test/case/id=
/65c2fa4574c594e6348e1ec7
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:41:55.135593  [   43.648464] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vopb-probed RESULT=3Dfail>

    2024-02-07T03:41:56.205779  /lava-12711115/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-vopb-probed: https://kernelci.org/test/case/id=
/65c2fa4574c594e6348e1ec8
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:41:54.078302  [   42.590858] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vop-driver-present RESULT=3Dpass>

    2024-02-07T03:41:55.097850  /lava-12711115/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb-phy-grf-probed: https://kernelci.org/test/=
case/id/65c2fa4574c594e6348e1eca
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:41:52.997222  [   41.509308] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb-phy-driver-present RESULT=3Dpass>

    2024-02-07T03:41:54.016479  /lava-12711115/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-pwm0-probed: https://kernelci.org/test/case/id=
/65c2fa4574c594e6348e1ed2
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:41:51.763924  [   40.276264] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pwm-driver-present RESULT=3Dpass>

    2024-02-07T03:41:52.783533  /lava-12711115/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-iodomain-driver-present: https://kernelci.org/=
test/case/id/65c2fa4574c594e6348e1ed4
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:41:48.508425  [   37.020757] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockcip-i2s-driver-present RESULT=3Dfail>

    2024-02-07T03:41:49.544164  /lava-12711115/1/../bin/lava-test-case

    2024-02-07T03:41:49.578832  [   38.091698] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-i2s-probed RESULT=3Dblocked>

    2024-02-07T03:41:50.595404  /lava-12711115/1/../bin/lava-test-case

    2024-02-07T03:41:50.621590  [   39.133816] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-iodomain-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rockcip-i2s-driver-present: https://kernelci.org/test/c=
ase/id/65c2fa4574c594e6348e1ed5
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:41:46.359251  [   34.871221] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-phy-driver-present RESULT=3Dfail>

    2024-02-07T03:41:47.379839  /lava-12711115/1/../bin/lava-test-case

    2024-02-07T03:41:47.417526  [   35.929629] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-phy-grf-probed RESULT=3Dblocked>

    2024-02-07T03:41:48.470386  /lava-12711115/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-dp-phy-driver-present: https://kernelci.org/te=
st/case/id/65c2fa4574c594e6348e1ed6
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:41:44.177325  [   32.689498] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-driver-present RESULT=3Dfail>

    2024-02-07T03:41:45.231430  /lava-12711115/1/../bin/lava-test-case

    2024-02-07T03:41:45.270257  [   33.782762] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-edp-probed RESULT=3Dblocked>

    2024-02-07T03:41:46.321717  /lava-12711115/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-dp-driver-present: https://kernelci.org/test/c=
ase/id/65c2fa4574c594e6348e1ed7
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:41:44.139559  /lava-12711115/1/../bin/lava-test-case
   =


  * baseline.bootrr.rk_iommu-vpu_mmu-probed: https://kernelci.org/test/case=
/id/65c2fa4574c594e6348e1ed8
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:41:43.062417  /lava-12711115/1/../bin/lava-test-case

    2024-02-07T03:41:43.099759  [   31.612541] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vpu_mmu-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rk_iommu-vopl_mmu-probed: https://kernelci.org/test/cas=
e/id/65c2fa4574c594e6348e1ed9
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:41:40.919064  [   29.431362] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vopb_mmu-probed RESULT=3Dfail>

    2024-02-07T03:41:41.957762  /lava-12711115/1/../bin/lava-test-case

    2024-02-07T03:41:41.995873  [   30.508568] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vopl_mmu-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rk_iommu-vopb_mmu-probed: https://kernelci.org/test/cas=
e/id/65c2fa4574c594e6348e1eda
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:41:39.862269  [   28.374708] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-driver-present RESULT=3Dpass>

    2024-02-07T03:41:40.881113  /lava-12711115/1/../bin/lava-test-case
   =


  * baseline.bootrr.ramoops-driver-present: https://kernelci.org/test/case/=
id/65c2fa4574c594e6348e1ee2
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:41:37.538060  [   26.049529] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dehci-platform-usb_host0_ehci-probed RESULT=3Dpass>

    2024-02-07T03:41:38.552258  /lava-12711115/1/../bin/lava-test-case

    2024-02-07T03:41:38.580919  [   27.093504] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dramoops-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/65c2fa4574c594e6348e1ee6
        failing since 1 day (last pass: v6.1.75-cip14-6-ga817aa655908, firs=
t fail: v5.10.209-cip44-rebase)

    2024-02-07T03:41:36.323032  [   24.831306] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dpass>

    2024-02-07T03:41:37.336963  /lava-12711115/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwhdmi-rockchip-probed: https://kernelci.org/test/case/=
id/65c2fa4574c594e6348e1eeb
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:41:36.162949  /lava-12711115/1/../bin/lava-test-case
   =


  * baseline.bootrr.dw_wdt-driver-present: https://kernelci.org/test/case/i=
d/65c2fa4574c594e6348e1ef0
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:41:32.848324  [   21.361169] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddw-apb-uart2-probed RESULT=3Dpass>

    2024-02-07T03:41:33.862815  /lava-12711115/1/../bin/lava-test-case

    2024-02-07T03:41:33.899961  [   22.412697] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddw_wdt-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.cros-ec-keyb-probed: https://kernelci.org/test/case/id/=
65c2fa4574c594e6348e1ef5
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:41:32.644753  /lava-12711115/1/../bin/lava-test-case
   =


  * baseline.bootrr.cros-ec-i2c-tunnel-driver-present: https://kernelci.org=
/test/case/id/65c2fa4574c594e6348e1ef7
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:41:28.301926  [   16.813546] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-dev-driver-present RESULT=3Dfail>

    2024-02-07T03:41:28.758077  [   17.267305] asix 3-1:1.0 eth0: register =
'asix' at usb-ff580000.usb-1, ASIX AX88772B USB 2.0 Ethernet, 00:6f:00:09:0=
8:66

    2024-02-07T03:41:28.779689  [   17.292523] dwmmc_rockchip ff0d0000.dwmm=
c: IDMAC supports 32-bit address mode.

    2024-02-07T03:41:28.787787  [   17.301123] dwmmc_rockchip ff0d0000.dwmm=
c: Using internal DMA controller.

    2024-02-07T03:41:28.794042  [   17.308198] dwmmc_rockchip ff0d0000.dwmm=
c: Version ID is 270a

    2024-02-07T03:41:28.803999  [   17.314217] dwmmc_rockchip ff0d0000.dwmm=
c: DW MMC controller at irq 30,32 bit host data width,256 deep fifo

    2024-02-07T03:41:29.354272  /lava-12711115/1/../bin/lava-test-case

    2024-02-07T03:41:29.370298  [   17.882922] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-dev-probed RESULT=3Dblocked>

    2024-02-07T03:41:30.404123  /lava-12711115/1/../bin/lava-test-case
   =


  * baseline.bootrr.cros-ec-dev-driver-present: https://kernelci.org/test/c=
ase/id/65c2fa4574c594e6348e1ef8
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85)

    2024-02-07T03:41:27.425540  [   15.940267] dwc2 ff580000.usb: DWC OTG C=
ontroller

    2024-02-07T03:41:27.432175  [   15.945052] dwc2 ff580000.usb: new USB b=
us registered, assigned bus number 3

    2024-02-07T03:41:27.437555  [   15.952156] dwc2 ff580000.usb: irq 43, i=
o mem 0x00000000

    2024-02-07T03:41:27.443015  [   15.959148] hub 3-0:1.0: USB hub found

    2024-02-07T03:41:27.447137  [   15.963042] hub 3-0:1.0: 1 port detected

    2024-02-07T03:41:27.460673  [   15.973368] dwmmc_rockchip ff0d0000.dwmm=
c: IDMAC supports 32-bit address mode.

    2024-02-07T03:41:27.467851  [   15.980914] dwmmc_rockchip ff0d0000.dwmm=
c: Using internal DMA controller.

    2024-02-07T03:41:27.473818  [   15.987799] dwmmc_rockchip ff0d0000.dwmm=
c: Version ID is 270a

    2024-02-07T03:41:27.483365  [   15.993642] dwmmc_rockchip ff0d0000.dwmm=
c: DW MMC controller at irq 30,32 bit host data width,256 deep fifo

    2024-02-07T03:41:27.746347  [   16.260035] usb 3-1: new high-speed USB =
device number 2 using dwc2
 =

    ... (1 line(s) more)  =

 =20

