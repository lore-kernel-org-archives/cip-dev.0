X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web10.6620.1652791561638469255
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 17 May 2022 05:46:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=nZXPwcBX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id bo5so16778120pfb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 17 May 2022 05:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=UcQff9g9AyVRpBN6isE4WlASMfLg097CfHSsISX3WM4=;
        b=nZXPwcBX21b85APb+GelsAV6s/0/t5/898TGMnkwYJkN+QMqh+A8eDpOqw5x/jpins
         VxyNZulO+n4e93/IQitRyh+A6yBin6KQtN//dXqX4IFNThuVzjOkue8IBeCT/s3dRNBc
         jxttIt18YokIXGMJNYYu20chY2kUuF9IpIGiVtzdXCcGCIx/QQvBSq0QHIkdSFelbfWK
         gGlqhqk0tk6rghKZ6jIrenoB0MY2+SQmbuFMpDBTr/WBqnMwL8mhr96pYejs8+N9ueNR
         LQt0TI+4nPRvVlpQBDYCGmqEePKzLdbzX+wEr3X0s0M9U46koVwzyuG4ooZdDsIcVduN
         bBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=UcQff9g9AyVRpBN6isE4WlASMfLg097CfHSsISX3WM4=;
        b=GY5HVTjsxGJ1hXez0YImVylf0OYZ8yoxKbdo6QZLURJduFSrdcvQbWIptNZPyiq3qT
         LUjubnuwGjXDjgBNzGiZsDDa6XWeog5YIGIweefWzGZ+vZPpPC55OulvDzP+mlQhqpq4
         A0y/FNDhIMKCjaAoTtjVPgxLRVVf/+5w7OXlgReTfHEep2Dp+jrOW9gXW2YtfTWXg8Gn
         1gccfZMqfY01vZaI+zf8iUiFYpPBFOxh3x/QwUMwWpEOaIjDMM1k00Y6ijOnT3Hxk+Wg
         N3KV3UxlufUM2/jZhLFbKfsBcQJQCmKR+Ej7xTuBVsHPOydhFERLzE0QQzNCwvAF+Fxn
         ioBg==
X-Gm-Message-State: AOAM530n6BfoABR3LVay4qn0WfVOXpe4dfXeOCougIxIbGQwporEIlun
	PxdMnF7oqvw9J1YzxjzTBvwKeXpLXNpJLHNDqxg=
X-Google-Smtp-Source: ABdhPJwbdOXVFs1exS/5gbyGXGtV+jbuVeqKzh3HYN4vIQtkj4KW41HFKhABCi45K43x9+bdxZ0Umw==
X-Received: by 2002:a63:c10:0:b0:3da:fb56:648d with SMTP id b16-20020a630c10000000b003dafb56648dmr19273931pgl.590.1652791560654;
        Tue, 17 May 2022 05:46:00 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090add4500b001dcf9fe5cddsm1542811pjv.38.2022.05.17.05.46.00
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 05:46:00 -0700 (PDT)
Message-ID: <62839908.1c69fb81.57d9b.3d62@mx.google.com>
Date: Tue, 17 May 2022 05:46:00 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-293-gbfc4bd11718e1
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 3 runs, 3 regressions (v4.4-st5-293-gbfc4bd11718e1) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 3 runs, 3 regressions (v4.=
4-st5-293-gbfc4bd11718e1)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
beaglebone-black   | arm    | lab-cip       | gcc-10   | multi_v7_defconfig=
           | 1          =

beaglebone-black   | arm    | lab-cip       | gcc-10   | omap2plus_defconfi=
g          | 1          =

hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-293-gbfc4bd11718e1/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-293-gbfc4bd11718e1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      bfc4bd11718e111c2344c45b9237855beb947e3c =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
beaglebone-black   | arm    | lab-cip       | gcc-10   | multi_v7_defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/62838d7ec07191b6a7a39bee

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/62838d7e=
c07191b6a7a39bf1
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-17T11:56:21.925822  / # =

    2022-05-17T11:56:21.928187  =

    2022-05-17T11:56:26.958800  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/681637/extract-nfsrootfs-pxl6qtit'
    2022-05-17T11:56:26.969499  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/681637/extract-nfsrootfs-</lib/lava/dispatcher/tmp/681637/extract-nf=
srootfs-p                         xl6qtit'
    2022-05-17T11:56:29.158210  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-17T11:56:29.168934  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-17T11:56:29.277973  / # #
    2022-05-17T11:56:29.280403  #
    2022-05-17T11:56:29.395747  / # export SHELL=3D/bin/sh
    2022-05-17T11:56:29.398047  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
beaglebone-black   | arm    | lab-cip       | gcc-10   | omap2plus_defconfi=
g          | 1          =


  Details:     https://kernelci.org/test/plan/id/62838f4a35f789fb56a39bed

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/62838f4a=
35f789fb56a39bf0
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-260-gb0fe64f485ff)
        1 lines

    2022-05-17T12:04:08.660523  / # =

    2022-05-17T12:04:08.665906  =

    2022-05-17T12:04:13.708616  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/681643/extract-nfsrootfs-jipcdlnk'
    2022-05-17T12:04:13.719358  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/681643/extract-nfsrootfs-</lib/lava/dispatcher/tmp/681643/extract-nf=
srootfs-j                         ipcdlnk'
    2022-05-17T12:04:15.896383  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-17T12:04:15.907077  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-17T12:04:16.031523  / # #
    2022-05-17T12:04:16.034782  #
    2022-05-17T12:04:16.163855  / # export SHELL=3D/bin/sh
    2022-05-17T12:04:16.166995  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62839358d532be7cc2a39be2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62839358d532b=
e7cc2a39be3
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

