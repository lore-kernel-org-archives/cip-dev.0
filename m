X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web09.30983.1653327441971893646
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 23 May 2022 10:37:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=q6vXXGTI;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id c2so13747577plh.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 23 May 2022 10:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=spV1w8VWvc3KK3U7ZuDjRD4Z+K4CVj3eEArFB5UKZTs=;
        b=q6vXXGTI7bwoEdKEgsyk+l6Wl+lU1sLufks+UVpBiWX+1d9fV4TmGrhC9hER9LAgTk
         ChOMg6jA55WWY8yz3Im/LBrkuAnboLuMpr4qaq1OeZe19d6FhpUdzlVTzwH4a4JpTz70
         JOESAOZTj5kV7gVPA9xOfBGtMMPhm8WLkXPYq0O8RT7+A26LAr7VSJ2PSMkx/Oi6pSvg
         vkg+0cVcyALRexp1g1v33Wnebpb+7+On8s+Zyr8zIgQ2qTFmzSIvfRtBzzQNZxGiLP84
         l9GnBkBFCDZgYMlF+CaIg3rgS7qQ78ZsxGJIBvLHFsqtIUJzow0N6g4clR8MUVvIk2bO
         b3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=spV1w8VWvc3KK3U7ZuDjRD4Z+K4CVj3eEArFB5UKZTs=;
        b=r27KU5L9I5VEFZyXl+dAJtY3no0nN0c32EHeuZvkJmwTEV5158jjyF5FwkJaMFLU62
         zeMN9YHspPFJ/MqrRmfL+lqZ6w4hPzezQGHkA0Mo7sLHSZ7G9hgfS5PPBYOLnt+GHJz1
         gR3aR+9gtnYNnzAyoDmfRvqAnG+j+dzwf0bXhZE+et+Fj5vWqMxyi7OqgI3FcnbyxVHv
         jhg33emOlMpaTlLzKk2HaaN3Y0ji267dH6ze0TRMhI5JibYHFa2mJwLVLvQMjsgWjkos
         NNjrKn/f8r8NlupaRFGOC2R77TXX60oOaDcq054WGUjik7P51ZPdTIEbdsUeF8vGEBKX
         /v5g==
X-Gm-Message-State: AOAM531C4/wAo/ylmzWbQmbKM+MULT3caOA8zHyML4AMQ9IpjnFXey1z
	kEJvzUnILg6TLKJhUy+q/reJL2qQjFOuI1SMtEo=
X-Google-Smtp-Source: ABdhPJxMWqVetMpR0bUz7wkSlSCSmICUgEF95Dfj/SexOARIDDXc4BUGm0nw+Emx01TdNqb8eOoU4w==
X-Received: by 2002:a17:90a:c7c5:b0:1df:45ca:ef8b with SMTP id gf5-20020a17090ac7c500b001df45caef8bmr118152pjb.15.1653327441116;
        Mon, 23 May 2022 10:37:21 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902f11500b0015e8d4eb1c6sm5430953plb.16.2022.05.23.10.37.20
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 10:37:20 -0700 (PDT)
Message-ID: <628bc650.1c69fb81.a360a.cdeb@mx.google.com>
Date: Mon, 23 May 2022 10:37:20 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-1797-gb2b8419761095
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 5 runs, 5 regressions (v4.4-st5-1797-gb2b8419761095) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 5 runs, 5 regressions (v4.=
4-st5-1797-gb2b8419761095)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
beaglebone-black   | arm    | lab-broonie   | gcc-10   | multi_v7_defconfig=
           | 1          =

beaglebone-black   | arm    | lab-cip       | gcc-10   | multi_v7_defconfig=
           | 1          =

beaglebone-black   | arm    | lab-broonie   | gcc-10   | omap2plus_defconfi=
g          | 1          =

beaglebone-black   | arm    | lab-cip       | gcc-10   | omap2plus_defconfi=
g          | 1          =

hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-1797-gb2b8419761095/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-1797-gb2b8419761095
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b2b8419761095643d782c4cb4a982131b3efb6b8 =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
beaglebone-black   | arm    | lab-broonie   | gcc-10   | multi_v7_defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/628bba26b13ceb0ff1a39bef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/628bba26b13ce=
b0ff1a39bf0
        failing since 12 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
beaglebone-black   | arm    | lab-cip       | gcc-10   | multi_v7_defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/628bb6ef9fd4928edba39c08

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/arm/multi_v7_defconfig/gcc-10/lab-cip/baselin=
e-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/arm/multi_v7_defconfig/gcc-10/lab-cip/baselin=
e-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/628bb6ef=
9fd4928edba39c0b
        failing since 13 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-23T16:31:10.211882  / # =

    2022-05-23T16:31:10.219333  =

    2022-05-23T16:31:15.248851  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/684347/extract-nfsrootfs-gekwtr0m'
    2022-05-23T16:31:15.259775  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/684347/extract-nfsrootfs-</lib/lava/dispatcher/tmp/684347/extract-nf=
srootfs-g                         ekwtr0m'
    2022-05-23T16:31:17.316277  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-05-23T16:31:17.327149  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-05-23T16:31:17.442246  / # #
    2022-05-23T16:31:17.449069  #
    2022-05-23T16:31:17.564017  / # export SHELL=3D/bin/sh
    2022-05-23T16:31:17.571526  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
beaglebone-black   | arm    | lab-broonie   | gcc-10   | omap2plus_defconfi=
g          | 1          =


  Details:     https://kernelci.org/test/plan/id/628bbc1a9c0d3d4daaa39bd7

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/arm/omap2plus_defconfig/gcc-10/lab-broonie/ba=
seline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/arm/omap2plus_defconfig/gcc-10/lab-broonie/ba=
seline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/628bbc1a=
9c0d3d4daaa39bdc
        failing since 13 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-23T16:53:16.014155  / # =

    2022-05-23T16:53:16.022900  =

    2022-05-23T16:53:21.109307  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/164530/extract-nfsrootfs-qjdwy51x'
    2022-05-23T16:53:21.120371  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/164530/extract-nfsrootfs-</lib/lava/dispatcher/tmp/164530/extract-nf=
srootfs-q                         jdwy51x'
    2022-05-23T16:53:23.483314  / # export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-23T16:53:23.494325  export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-23T16:53:23.642843  / # #
    2022-05-23T16:53:23.647627  #
    2022-05-23T16:53:23.792773  / # export SHELL=3D/bin/sh
    2022-05-23T16:53:23.797619  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
beaglebone-black   | arm    | lab-cip       | gcc-10   | omap2plus_defconfi=
g          | 1          =


  Details:     https://kernelci.org/test/plan/id/628bb7dfbb4f3066c7a39bcd

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/628bb7df=
bb4f3066c7a39bd0
        failing since 13 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-23T16:35:22.827021  / # =

    2022-05-23T16:35:22.836071  =

    2022-05-23T16:35:27.850248  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/684352/extract-nfsrootfs-9l78wzcz'
    2022-05-23T16:35:27.861259  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/684352/extract-nfsrootfs-</lib/lava/dispatcher/tmp/684352/extract-nf=
srootfs-9                         l78wzcz'
    2022-05-23T16:35:29.930374  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-05-23T16:35:29.940926  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-05-23T16:35:30.066979  / # #
    2022-05-23T16:35:30.073832  #
    2022-05-23T16:35:30.201863  / # export SHELL=3D/bin/sh
    2022-05-23T16:35:30.209070  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/628bc31ac3a82d6c0aa39c55

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1797-gb2b8419761095/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/628bc31ac3a82=
d6c0aa39c56
        failing since 12 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

