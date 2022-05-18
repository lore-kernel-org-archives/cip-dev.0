X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web11.1588.1652853231952610970
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 17 May 2022 22:53:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=DD3HZ+zw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id w200so1159417pfc.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 17 May 2022 22:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=nbUO5UilWB7gtRB+7OqRJrvcXxdXtZFNq93xIyEklrE=;
        b=DD3HZ+zwA9GTaA0VXz5ridwQGGckyrpv45BsxGMengxBpBQQmcpuwPRdzAMjHUHl3i
         tg31bKbnDyrM4TNX4RYbu1eiyfCQvaVLS8QkzklWNADNDmYpYQs7Bg0jhCK9ebb1sc0h
         IwiGyfcXbmCN9a5bmltBPVc522xdQt0uxPDqQIl5UzyYIJuxQ0/rdNs8uLzinVcIyM4I
         21j4jzwfmh8yQ8lJWxjSiUmcp+fpeACr88mtmlvWU1zBprb0PL+5uuMV7xlEx/Yy40L9
         5kuzWwCtkkZ1lZiWnxYw6t7AMbb5ulliKkxDQ4mI6A9HkmCqGHvUIzHNGsNnvrTtMb4o
         N8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=nbUO5UilWB7gtRB+7OqRJrvcXxdXtZFNq93xIyEklrE=;
        b=4+2GfKz7j0ZyM9y4MUQIQeu+jVImze+JTen8PXCvS0DsNCxzSBf3Fledh1tdV8Ufp0
         OViSiKF2WSaa6wQxcbkjA+FqtL23vrOoIARNWKd5vYDgr5xAsSjIqO45yiyidlLzwZ21
         UcrOIXnvOKQkp0aMw+2aVSg6EtA9I8ksHPiwxZELHE232cEORsngTPtAdc9i1DqEzZJu
         QDRO7qsrWx42clUt9gMS6tq/i1GG6zZaekadPMkbgaTUom3u/nePyVPeamLxMxBad+np
         RkNL4XNe4lgb58wRbTwNu/0GQGaNwn+437tVa80owKXAKhaHhRKvgduzDTmKZT2jSfHn
         +BiQ==
X-Gm-Message-State: AOAM532PJgJJoZTAEilTm9X+GJSK4vl9hKOQqmFV4ISyRKFGa1Srr4W9
	i/GEuvoE+/4gbDeEDXEHqTogHlHTIqz21pc742U=
X-Google-Smtp-Source: ABdhPJx2x3Y2v5j31VrOlhy+goaj1weAt2ZgMuJqyy3YpGqwVSv7mxAxnExUWQaNJitXdtN7/Kv3eQ==
X-Received: by 2002:a63:5b01:0:b0:3c6:4935:589 with SMTP id p1-20020a635b01000000b003c649350589mr22128699pgb.314.1652853230961;
        Tue, 17 May 2022 22:53:50 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m9-20020a1709026bc900b0015e8d4eb23bsm645240plt.133.2022.05.17.22.53.50
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 22:53:50 -0700 (PDT)
Message-ID: <628489ee.1c69fb81.eb11c.1fd9@mx.google.com>
Date: Tue, 17 May 2022 22:53:50 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip69-296-g52de9431d314
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 14 runs, 11 regressions (v4.4.302-cip69-296-g52de9431d314) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-nfs: 14 runs, 11 regressions (v4.4.=
302-cip69-296-g52de9431d314)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

juno-uboot                | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =

rk3288-veyron-jaq         | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip69-296-g52de9431d314/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip69-296-g52de9431d314
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      52de9431d314a28c4aa66d8f81144c9958c11168 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6284172b4ed9831461a39beb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6284172b4ed983146=
1a39bec
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6284183fc932216991a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6284183fc93221699=
1a39bce
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/628417d5ffda056b60a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/628417d5ffda056b6=
0a39bce
        failing since 1 day (last pass: v4.4.302-cip69-50-gba851b77071ca, f=
irst fail: v4.4-st5-208-g5e70bc68d09e) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62841855c932216991a39bda

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62841855c93221699=
1a39bdb
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62841913f6c34ac1e3a39bcd

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/arm/multi_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/62841913f6c3=
4ac1e3a39bd2
        failing since 7 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-17T21:52:06.174676  / # =

    2022-05-17T21:52:06.181719  =

    2022-05-17T21:52:11.197221  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/153193/extract-nfsrootfs-cusocwyp'
    2022-05-17T21:52:11.208221  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/153193/extract-nfsrootfs-cusocwyp'
    2022-05-17T21:52:13.499386  / # export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-17T21:52:13.510380  export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-17T21:52:13.615450  / # #
    2022-05-17T21:52:13.622439  #
    2022-05-17T21:52:13.724783  / # export SHELL=3D/bin/sh
    2022-05-17T21:52:13.731635  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6284187c0bcce907faa39bcd

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/arm/multi_v7_defconfig/gcc-10/lab-cip/bas=
eline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/arm/multi_v7_defconfig/gcc-10/lab-cip/bas=
eline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/6284187c0bcc=
e907faa39bd0
        failing since 7 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-17T21:49:28.331017  / # =

    2022-05-17T21:49:28.333371  =

    2022-05-17T21:49:33.342810  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/681706/extract-nfsrootfs-ns96vxfq'
    2022-05-17T21:49:33.353508  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/681706/extract-nfsrootfs-ns96vxfq'
    2022-05-17T21:49:35.520106  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-17T21:49:35.530796  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-17T21:49:35.634099  / # #
    2022-05-17T21:49:35.636440  #
    2022-05-17T21:49:35.739689  / # export SHELL=3D/bin/sh
    2022-05-17T21:49:35.741964  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/628417641ed878445aa39c02

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/628417641ed878445=
aa39c03
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62841ffa41800bea33a39bcf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62841ffa41800bea3=
3a39bd0
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62841e4407ba143c45a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62841e4407ba143c4=
5a39bce
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
juno-uboot                | arm64  | lab-broonie   | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62841adf1c7bd08e52a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62841adf1c7bd08e5=
2a39bce
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-261-g4f0b5ddda6cf) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/628479b90522bf094aa39bd0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/arm/multi_v7_defconfig/gcc-10/lab-collabo=
ra/baseline-nfs-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/arm/multi_v7_defconfig/gcc-10/lab-collabo=
ra/baseline-nfs-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220513.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/628479b90522bf094=
aa39bd1
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-260-gb0fe64f485ff) =

 =20

