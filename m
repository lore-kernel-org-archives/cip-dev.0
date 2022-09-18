Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE247C54EE9
	for <webhook@archiver.kernel.org>; Sun, 18 Sep 2022 15:17:01 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web12.9642.1663514213384389494
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 18 Sep 2022 08:16:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=XKmm/j6W;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id
 i15-20020a17090a4b8f00b0020073b4ac27so3875244pjh.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 18 Sep 2022 08:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=6vQ43oIL1vGyodiJPTkskeBdbxgybdWu1sJvwwvqhyc=;
        b=XKmm/j6WUT+ZL3fiH9f2ws84Qtr4aAHKXLB9Mw6NoLo1Pd6VX38Il2snWJZpxWvhTO
         z83Wgg48fRXksVf0NzV1mxG4lGwPH+5ftz4n1rdutoDzDAtS37BAxHRRblXoFlN9epij
         CJbQ7XXoTGbsKpCZTjrgTO87ho2/ST1Sb/VtMiXo7RoKzPi7npp8SRaFoc1viioBZApu
         qnePYIHSvyv0Eombm+yY6ghfwT0DtXDzIj8YbZgJ6wB+hCBvA1bWFrFDv9NRzXHMw3vA
         OaIQrKtuYnQff1WgRHpEdM7xoy4ckb5cATTskDRD1L/KARbDcI6aHKuYMCxwdyMlNFVZ
         Vs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=6vQ43oIL1vGyodiJPTkskeBdbxgybdWu1sJvwwvqhyc=;
        b=qQFknJGxaZZx/YChX+CCWh7D8rK0/groWYTofz0rdZT+UVJMlABUnP5fTpFePIs/ra
         3kDcE35uakVVY7W7EgD5AhB33QLiLR3OLV8lIx2rJusfPIfKmPR1RvE7CYMrlbJ9N3Tq
         6zJlPRQKHjh0JfsdYXohoKIG2dZX13VUdVthZvNnY8IOi+ObDs43UChVH1zaMmNUA9u5
         FlZv9o2/MF6fefMSd45Jfm0dAkR8EozJ4TPQ6w28UX/wbzPk0X/BMeBR1DNgegQShuze
         7HnXXV9EP+gZvpTBv5HPTynPJ20pKMqHVMp+AndZaJuR0564QYHdfgky7sXYCdf+SCrn
         Sz+A==
X-Gm-Message-State: ACrzQf2T9tEborT40ojpCcG/Cn2mCzigRMOwkSkCoTC90EqW6k9vXKIn
	gpczU1IOq8JYePxJHGrHdqZOv2cOybAeDPCjO9U=
X-Google-Smtp-Source: 
 AMsMyM7xwiJ7icH6QZ8emQA30Gu1GKRmLD0kXtj1bcMsuLnxkGsPkJ/s3TLpwrOqDgVk3bO33k9ecA==
X-Received: by 2002:a17:90a:bf18:b0:200:8a12:d7ad with SMTP id
 c24-20020a17090abf1800b002008a12d7admr15059662pjs.243.1663514212542;
        Sun, 18 Sep 2022 08:16:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 d7-20020a170902cec700b00176ea6ce0efsm18615319plg.109.2022.09.18.08.16.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 08:16:51 -0700 (PDT)
Message-ID: <63273663.170a0220.1db92.05db@mx.google.com>
Date: Sun, 18 Sep 2022 08:16:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-231-g7349cef09ddd2
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 25 runs,
 9 regressions (v4.4-st20-231-g7349cef09ddd2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 18 Sep 2022 15:17:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9513

cip-gitlab/ci/pavel/linux-test baseline-nfs: 25 runs, 9 regressions (v4.4-s=
t20-231-g7349cef09ddd2)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-231-g7349cef09ddd2/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-231-g7349cef09ddd2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7349cef09ddd27c4d55cc11d23fdf232c9184ccc =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63272eeecbc36d5a0f355675

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220826.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63272eeecbc36d5a0=
f355676
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63272fe114aec066c4355695

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220826.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63272fe114aec066c=
4355696
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63272eeb45624967eb35567d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220826.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63272eeb45624967e=
b35567e
        new failure (last pass: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63272ff8b3730f4785355646

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220826.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63272ff8b3730f478=
5355647
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6327311de13cd32000355647

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-cip/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-cip/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220826.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/6327311de13c=
d3200035564c
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)
        1 lines

    2022-09-18T14:53:48.738564  / # =

    2022-09-18T14:53:48.747174  =

    2022-09-18T14:53:53.764972  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/744983/extract-nfsrootfs-zl0rg034'
    2022-09-18T14:53:53.775995  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/744983/extract-nfsrootfs-zl0rg034'
    2022-09-18T14:53:55.825690  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-09-18T14:53:55.836603  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-09-18T14:53:55.941658  / # #
    2022-09-18T14:53:55.950217  #
    2022-09-18T14:53:56.052634  / # export SHELL=3D/bin/sh
    2022-09-18T14:53:56.060965  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/632733743620684fb4355642

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220826.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/632733743620=
684fb4355647
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250)
        1 lines

    2022-09-18T15:03:57.807355  / # =

    2022-09-18T15:03:57.815701  =

    2022-09-18T15:04:02.840236  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/744991/extract-nfsrootfs-fr7b6mvd'
    2022-09-18T15:04:02.851145  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/744991/extract-nfsrootfs-fr7b6mvd'
    2022-09-18T15:04:04.911830  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-09-18T15:04:04.922656  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-09-18T15:04:05.036577  / # #
    2022-09-18T15:04:05.044322  #
    2022-09-18T15:04:05.158249  / # export SHELL=3D/bin/sh
    2022-09-18T15:04:05.166070  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63272eeacbc36d5a0f355656

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220826.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63272eeacbc36d5a0=
f355657
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/632731480e783a6518355642

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220826.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/632731480e783a651=
8355643
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/632733a2225f273c9f355644

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-nfs-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-nfs-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220826.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/632733a2225f273c9=
f355645
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =20

