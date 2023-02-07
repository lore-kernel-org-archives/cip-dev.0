Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D721CC636D4
	for <webhook@archiver.kernel.org>; Tue,  7 Feb 2023 07:45:59 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.78552.1675755954638553088
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 06 Feb 2023 23:45:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ZOgdtC9a;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id 203so10152540pfx.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 06 Feb 2023 23:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZOmRcJI80XRRWkq24DUoNjdIHw5Ee4rgTiWCsPJxLY=;
        b=ZOgdtC9abxFwffhzqtiqSPaAY+d4z77P2LPXTvE7N2StCkjRSL6l19K2lxuUs2KjB+
         vEpBQ00yBnqwxR30+6bThbzfz4822PYAeC86xPts03KHAt8sWHASEkmu+F1y8YI7R5wM
         yfwm2dPqhRqWGjkSgDota6x+Jqi0pBgEi5bJ8EfRH1O5S58Isg3virLoLR6U9xFjao+A
         b34vyLwgea/qNGmvvrdEGtshXZh7sWka//9OXTOdNuUAQlg9t7sOUqe2B/pPXgz1W4qQ
         LPZbYlgk/81HigGytabwtKYD9v0hiLPt2Gsz6Ud6lVwtyMlpwbLbGqYFTL/5zbIRqTIx
         1zOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ZOmRcJI80XRRWkq24DUoNjdIHw5Ee4rgTiWCsPJxLY=;
        b=nbJWsKlh/b8JrWoTHs7heqrQ0t1AGoHAchmliJ9BRkLvmcJVizoIRHJZyqS1HacNxK
         9dvo2UuBM8TZWNGE7mKA5HDxcGjYrN7yPkr8W2NSsEWYJ1l4aux7/O8BYW3sgirfcQBI
         +RGSaOLd5oNda3iEmKRDhWuyS3UhXLA61fa2xKtn7p5MYZnOzFsgyy8W8i9VMHQVFSUR
         4OGFseiuD9ZlteX6yMYasAkYn5PpwiFFMpeGiSBuEOmZWLHAGodAucOxzoHkZM33uEm1
         QB9Sbe9IYcn9dyWyobGjmQ7DEDIE3WXFZXBbmDUjbJKnpGwW9eNQfYi2jZM7RnJnGtqt
         Zo0A==
X-Gm-Message-State: AO0yUKV326t5zAWtToDApHJrV28qw6L7y73WSVA0rry/F/tGcuB8FJ12
	XUvdopkgDbDYc2LpBLWz9IWg9oTBbt9OZG3zYFnQ3Q==
X-Google-Smtp-Source: AK7set8IJVgiNAbQ336lTZMO2DPLqDfEjqChmQ8P3BRB09U2yd/9Bow6PXzN3wI7jBhIRtvxVcqDyg==
X-Received: by 2002:a62:6dc7:0:b0:593:e5fc:9dba with SMTP id i190-20020a626dc7000000b00593e5fc9dbamr2059085pfc.26.1675755953295;
        Mon, 06 Feb 2023 23:45:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j7-20020aa78007000000b00593baab06dcsm3034418pfi.198.2023.02.06.23.45.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 23:45:52 -0800 (PST)
Message-ID: <63e201b0.a70a0220.a7402.598b@mx.google.com>
Date: Mon, 06 Feb 2023 23:45:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.4.302-cip72-rt42
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 15 runs,
 32 regressions (v4.4.302-cip72-rt42)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Feb 2023 07:45:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10616

cip-gitlab/ci/pavel/linux-test baseline-nfs: 15 runs, 32 regressions (v4.4.=
302-cip72-rt42)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 21         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip72-rt42/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip72-rt42
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      fe1cf8ef6e9d76107c4a6e1bf8cc27263abe6698 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1f94474b2272bdc8c8636

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230203.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63e1f94474b2272bd=
c8c8637
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1f8f4c3dd370d008c863d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230203.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63e1f8f4c3dd370d0=
08c863e
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1f959f96106a06e8c8644

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230203.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63e1f959f96106a06=
e8c8645
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1f94254f4de6c538c86a3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230203.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63e1f94254f4de6c5=
38c86a4
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1f94354f4de6c538c86a9

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230203.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/63e1f94354f4=
de6c538c86ae
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)
        1 lines

    2023-02-07T07:09:29.001542  / # =

    2023-02-07T07:09:29.007103  =

    2023-02-07T07:09:34.023405  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/266443/extract-nfsrootfs-2e03gilu'
    2023-02-07T07:09:34.034183  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/266443/extract-nfsrootfs-2e03gilu'
    2023-02-07T07:09:36.264353  / # export NFS_SERVER_IP=3D'192.168.56.75'
    2023-02-07T07:09:36.275276  export NFS_SERVER_IP=3D'192.168.56.75'
    2023-02-07T07:09:36.378826  / # #
    2023-02-07T07:09:36.385385  #
    2023-02-07T07:09:36.487076  / # export SHELL=3D/bin/sh
    2023-02-07T07:09:36.493189  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1f70ed0651145738c86b1

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nf=
s-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nf=
s-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230203.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/63e1f70ed065=
1145738c86b6
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)
        1 lines

    2023-02-07T07:00:11.075382  / # =

    2023-02-07T07:00:11.080997  =

    2023-02-07T07:00:16.106796  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/266161/extract-nfsrootfs-vag_6tdt'
    2023-02-07T07:00:16.117858  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/266161/extract-nfsrootfs-vag_6tdt'
    2023-02-07T07:00:18.409986  / # export NFS_SERVER_IP=3D'192.168.56.123'
    2023-02-07T07:00:18.420545  export NFS_SERVER_IP=3D'192.168.56.123'
    2023-02-07T07:00:18.525331  / # #
    2023-02-07T07:00:18.530140  #
    2023-02-07T07:00:18.639086  / # export SHELL=3D/bin/sh
    2023-02-07T07:00:18.643933  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1f95af96106a06e8c8647

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230203.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63e1f95af96106a06=
e8c8648
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1f95cf96106a06e8c8658

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230203.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63e1f95cf96106a06=
e8c8659
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1f8c1f7cb4503db8c862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230203.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63e1f8c1f7cb4503d=
b8c8630
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1fa53396419abe48c865f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230203.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63e1fa53396419abe=
48c8660
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1f996567bdeeb048c862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230203.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63e1f996567bdeeb0=
48c8630
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 21         =


  Details:     https://kernelci.org/test/plan/id/63e1fa74e125d431818c862f

  Results:     37 PASS, 22 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-n=
fs-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-n=
fs-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230203.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-vopl-probed: https://kernelci.org/test/cas=
e/id/63e1fa74e125d431818c8638
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:14:36.372121  [   67.398171] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vopb-probed RESULT=3Dfail>

    2023-02-07T07:14:37.425917  /lava-9045536/1/../bin/lava-test-case

    2023-02-07T07:14:37.504605  [   68.531377] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vopl-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-vopb-probed: https://kernelci.org/test/cas=
e/id/63e1fa74e125d431818c8639
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:14:35.256180  [   66.281183] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vop-driver-present RESULT=3Dpass>

    2023-02-07T07:14:36.303666  /lava-9045536/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb-phy-grf-probed: https://kernelci.org/t=
est/case/id/63e1fa74e125d431818c863b
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:14:34.045693  [   65.070418] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb-phy-driver-present RESULT=3Dpass>

    2023-02-07T07:14:35.096042  /lava-9045536/1/../bin/lava-test-case

    2023-02-07T07:14:35.159786  [   66.185945] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb-phy-grf-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-pwm0-probed: https://kernelci.org/test/cas=
e/id/63e1fa74e125d431818c8643
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:14:33.537535  /lava-9045536/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-pm-domain-driver-present: https://kernelci=
.org/test/case/id/63e1fa74e125d431818c8645
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:14:29.045578  [   60.069821] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-iodomain-driver-present RESULT=3Dfail>

    2023-02-07T07:14:30.102150  /lava-9045536/1/../bin/lava-test-case

    2023-02-07T07:14:30.184692  [   61.209276] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-iodomain-grf-probed RESULT=3Dblocked>

    2023-02-07T07:14:31.222503  /lava-9045536/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-iodomain-driver-present: https://kernelci.=
org/test/case/id/63e1fa74e125d431818c8646
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:14:26.799363  [   57.824594] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockcip-i2s-driver-present RESULT=3Dfail>

    2023-02-07T07:14:27.856608  /lava-9045536/1/../bin/lava-test-case

    2023-02-07T07:14:27.920789  [   58.947327] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-i2s-probed RESULT=3Dblocked>

    2023-02-07T07:14:28.992754  /lava-9045536/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockcip-i2s-driver-present: https://kernelci.org/te=
st/case/id/63e1fa74e125d431818c8647
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:14:25.622028  /lava-9045536/1/../bin/lava-test-case

    2023-02-07T07:14:25.698086  [   56.723025] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-phy-grf-probed RESULT=3Dblocked>

    2023-02-07T07:14:26.729102  /lava-9045536/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-dp-phy-driver-present: https://kernelci.or=
g/test/case/id/63e1fa74e125d431818c8648
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:14:22.379489  [   53.404623] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-driver-present RESULT=3Dfail>

    2023-02-07T07:14:23.425984  /lava-9045536/1/../bin/lava-test-case

    2023-02-07T07:14:23.498003  [   54.522904] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-edp-probed RESULT=3Dblocked>

    2023-02-07T07:14:24.528509  /lava-9045536/1/../bin/lava-test-case

    2023-02-07T07:14:24.575199  [   55.600750] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-phy-driver-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-dp-driver-present: https://kernelci.org/te=
st/case/id/63e1fa74e125d431818c8649
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:14:22.323648  /lava-9045536/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rk_iommu-vpu_mmu-probed: https://kernelci.org/test/=
case/id/63e1fa74e125d431818c864a
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:14:20.125109  [   51.150545] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vopl_mmu-probed RESULT=3Dfail>

    2023-02-07T07:14:21.192053  /lava-9045536/1/../bin/lava-test-case

    2023-02-07T07:14:21.255657  [   52.279852] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vpu_mmu-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rk_iommu-vopl_mmu-probed: https://kernelci.org/test=
/case/id/63e1fa74e125d431818c864b
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:14:20.053348  /lava-9045536/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rk_iommu-vopb_mmu-probed: https://kernelci.org/test=
/case/id/63e1fa74e125d431818c864c
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:14:17.868975  [   48.894427] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-driver-present RESULT=3Dpass>

    2023-02-07T07:14:18.918492  /lava-9045536/1/../bin/lava-test-case

    2023-02-07T07:14:18.999305  [   50.025553] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vopb_mmu-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rk3288-crypto-driver-present: https://kernelci.org/=
test/case/id/63e1fa74e125d431818c8654
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:14:14.103157  [   45.128545] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dramoops-driver-present RESULT=3Dfail>

    2023-02-07T07:14:15.149384  /lava-9045536/1/../bin/lava-test-case

    2023-02-07T07:14:15.215870  [   46.241827] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dramoops-probed RESULT=3Dblocked>

    2023-02-07T07:14:16.251198  /lava-9045536/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.ramoops-driver-present: https://kernelci.org/test/c=
ase/id/63e1fa74e125d431818c8655
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:14:14.052287  /lava-9045536/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelc=
i.org/test/case/id/63e1fa74e125d431818c865c
        failing since 17 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-07T07:14:11.478726  seq: invalid floating point argument: =E2=
=80=98ff980000.hdmi/dw-hdmi-cec.*=E2=80=99

    2023-02-07T07:14:11.482140  Try 'seq --help' for more information.

    2023-02-07T07:14:11.485552  /lava-9045536/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.dwhdmi-rockchip-driver-audio-present: https://kerne=
lci.org/test/case/id/63e1fa74e125d431818c865d
        failing since 17 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-02-07T07:14:11.430423  seq: invalid floating point argument: =E2=
=80=98ff980000.hdmi/dw-hdmi-audio-*=E2=80=99

    2023-02-07T07:14:11.433901  Try 'seq --help' for more information.

    2023-02-07T07:14:11.437303  /lava-9045536/1/../bin/lava-test-case

    2023-02-07T07:14:11.456567  [   42.481738] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-driver-audio-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.dwhdmi-rockchip-probed: https://kernelci.org/test/c=
ase/id/63e1fa74e125d431818c865e
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:14:11.313152  /lava-9045536/1/../bin/lava-test-case

    2023-02-07T07:14:11.380713  [   42.407077] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.dw_wdt-driver-present: https://kernelci.org/test/ca=
se/id/63e1fa74e125d431818c8663
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:14:08.834249  /lava-9045536/1/../bin/lava-test-case

    2023-02-07T07:14:08.896359  [   39.922615] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddw_wdt-driver-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.cros-ec-keyb-probed: https://kernelci.org/test/case=
/id/63e1fa74e125d431818c8668
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:14:06.386898  [   37.411498] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-keyb-driver-present RESULT=3Dpass>

    2023-02-07T07:14:07.430672  /lava-9045536/1/../bin/lava-test-case

    2023-02-07T07:14:07.495714  [   38.522058] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-keyb-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.cros-ec-i2c-tunnel-driver-present: https://kernelci=
.org/test/case/id/63e1fa74e125d431818c866a
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:14:02.989815  [   34.014373] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-dev-driver-present RESULT=3Dfail>

    2023-02-07T07:14:04.028645  /lava-9045536/1/../bin/lava-test-case

    2023-02-07T07:14:04.078594  [   35.104588] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-dev-probed RESULT=3Dblocked>

    2023-02-07T07:14:05.111826  /lava-9045536/1/../bin/lava-test-case

    2023-02-07T07:14:05.175431  [   36.200367] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-i2c-tunnel-driver-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.cros-ec-dev-driver-present: https://kernelci.org/te=
st/case/id/63e1fa74e125d431818c866b
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752)

    2023-02-07T07:14:01.835946  [   32.861615] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtpm-chip-is-online RESULT=3Dskip>

    2023-02-07T07:14:02.916169  /lava-9045536/1/../bin/lava-test-case
   =

 =20

