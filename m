X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web09.5186.1649724274856845230
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 11 Apr 2022 17:44:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Kos22K3G;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id bg24so4381557pjb.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 11 Apr 2022 17:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=159fckVh/TamVMUnYtbocTTBaLpbxgSsyWZ6Zq3IejY=;
        b=Kos22K3GmOj+aFxRbhLPA+ZhWw25GYjdiEHvwQC3i7OKwIk7I3voWhQcdY3+6XlXJG
         o7WL0Zuwjcd26+7l6k5aBQrEUF4cwQG88t9A6tDcoQrgtTbjljYRbvcH5aZvWMStAIhJ
         D4elVJ8KxlUiCvrpK9n2YErLcDQ/WBQhgYtHWGLf11RVTt3WLD3AMzIXst+Icapcf3QW
         sW5QGpgRv/q0d3Epcuz9aW8/8Z8GffL1Rc6cBrQD6YU291lxswHCbbUM/qhaWW0D5A8z
         LTkzgwDRn8i645dZMV4Id/V4+w6jr+pOzEZKlkxAiCKtIb3OoxgKUNSbewqgweJX7PE9
         HQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=159fckVh/TamVMUnYtbocTTBaLpbxgSsyWZ6Zq3IejY=;
        b=Tsa1r/3zufNe/XPPUm+Y2+KQaFclsKTx1RdEB12lOQ9zb6P7yD3jK265nsE5pQDbvs
         XPgsvDYWeBN4bhP+bgxvF6HukMGcNKvvzj7Dy/VRbjKfscPZ2kwZgGwZ5I1yDRZ7kV4Y
         xTcmO4EptXZfM3fUygQwPVgn3L4mzV0ETgNBgjyjn9mggq/t5T76kcJEVUG8UtXOzCDJ
         F5s324az8+44fct0XMd9g8bZKPm2UNaBH5oKZZYUyJxU4BrDXkWhp/xicDlAiLqnGiuu
         6AWTliJmYBOa/Jgyp9T4QXm7mfTwVvMxtBNhqZvJ2Si2pmDJ7AkFjQs7Ryn2Jztca+At
         RiIA==
X-Gm-Message-State: AOAM532MV3qBjqqJiLbo8Qqt9wRdJ3UMbxRD0aaF+RYHB322A/lJgLSJ
	/jhLPQFwCNaGfZUv8EfLOhptlk56rJFmnmeq
X-Google-Smtp-Source: ABdhPJxlfPPc1R7MXn1WA86EYE4KLxjXOuep8UkIbu1XTpqwlsVSPGGq0ltB8Q3kzFd8pjfOLZG1vA==
X-Received: by 2002:a17:902:ab43:b0:156:6f38:52b3 with SMTP id ij3-20020a170902ab4300b001566f3852b3mr34887054plb.135.1649724274116;
        Mon, 11 Apr 2022 17:44:34 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm36843839pfh.83.2022.04.11.17.44.33
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 17:44:33 -0700 (PDT)
Message-ID: <6254cb71.1c69fb81.98ec7.f72c@mx.google.com>
Date: Mon, 11 Apr 2022 17:44:33 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-2498-g49524d978f8eb
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 4 runs, 4 regressions (v4.4-st5-2498-g49524d978f8eb) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 4 runs, 4 regressions (v4.=
4-st5-2498-g49524d978f8eb)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-2498-g49524d978f8eb/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-2498-g49524d978f8eb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      49524d978f8eb9de24ce93fcca8d5a39522876c3 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6254c51171b8676856ae0684

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/arm/multi_v7_defconfig/gcc-10/lab-cip/baselin=
e-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/arm/multi_v7_defconfig/gcc-10/lab-cip/baselin=
e-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/6254c511=
71b8676856ae0687
        new failure (last pass: v5.10.106-cip4-69-g05f5682c2c593)
        1 lines

    2022-04-12T00:16:54.386026  / # =

    2022-04-12T00:16:54.393329  =

    2022-04-12T00:16:59.423682  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/661665/extract-nfsrootfs-p52gempt'
    2022-04-12T00:16:59.434641  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/661665/extract-nfsrootfs-</lib/lava/dispatcher/tmp/661665/extract-nf=
srootfs-p                         52gempt'
    2022-04-12T00:17:01.491434  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-04-12T00:17:01.502361  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-04-12T00:17:01.616728  / # #
    2022-04-12T00:17:01.623464  #
    2022-04-12T00:17:01.739463  / # export SHELL=3D/bin/sh
    2022-04-12T00:17:01.746844  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6254c5ed4ac618624fae06a2

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/6254c5ed=
4ac618624fae06a5
        new failure (last pass: v5.10.106-cip4-69-g05f5682c2c593)
        1 lines

    2022-04-12T00:20:42.459441  / # =

    2022-04-12T00:20:42.469441  =

    2022-04-12T00:20:47.506302  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/661669/extract-nfsrootfs-nvngr41i'
    2022-04-12T00:20:47.517220  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/661669/extract-nfsrootfs-</lib/lava/dispatcher/tmp/661669/extract-nf=
srootfs-n                         vngr41i'
    2022-04-12T00:20:49.591005  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-04-12T00:20:49.601843  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-04-12T00:20:49.731281  / # #
    2022-04-12T00:20:49.739022  #
    2022-04-12T00:20:49.868695  / # export SHELL=3D/bin/sh
    2022-04-12T00:20:49.876197  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6254c5a8a881238b11ae06ad

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/6254c5a8a8812=
38b11ae06ae
        new failure (last pass: v5.10.106-cip4-69-g05f5682c2c593) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6254c9e2644e98ab0eae0694

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-cip-nfs-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-cip-nfs-hp-x360-12b-n4000-octopus.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/6254c9e2644e9=
8ab0eae0695
        new failure (last pass: v5.10.106-cip4-69-g05f5682c2c593) =

 =20

