X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web10.6288.1647926448357514208
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 21 Mar 2022 22:20:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=m00K3B32;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id o13so11844161pgc.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 21 Mar 2022 22:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=3Mavk2U6FIrDAtl6V925k7TGdlhYKrsb4vW54Lbd1Ug=;
        b=m00K3B32EqorCtU0G5vJE8VEwcFd4kWLUm0FupNXx/Kxgfl99wUdIaY5iS6P1I1RN6
         U0aIAULs1LiOwnm7Zdkrt1az9vp9d+6donCFVE5mt5sb5yFGzGEaQkxHNcY2jWSDLujE
         0J0QeNKRZd9kvH8GV43QroyAGqzAIKhKCiLTLKX9J73yUuiIyV12/ngOkt7CS5PjT6ZN
         9GeVuwQF8YOKheJpVcxhjoq+VKYVnpwKtydg7KFB1bNiJn08SoFrh0H5VZmBQ/NP+Pp5
         N6Co+b821tSQaNPIJ4cE1ENT+4RSkxAMibm6Dxgr2uieMdFfVP9Dp7DL6CkAWg9nyBI8
         qwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=3Mavk2U6FIrDAtl6V925k7TGdlhYKrsb4vW54Lbd1Ug=;
        b=WwnPV1QkvBCbv+9dzAtk1Un4rFFfywYVaq6dyPIClD4MpAAxRv4+PCDr5fN4coZsZB
         hV0dXx0zHai/k4LKjGBSbEZ3pEvm4B99mouT9iMUne9JjStKBlTT52scg9g9+9jW8xb7
         SjQWP0mx9dMWVqczw54U6x4c3qrjJcRSfgWN6/PU8MA3CZ6hPAEPWZLCQkvx+AnYOH6v
         aCMhNWlCiK1NtCmosdM/giC/KcCwrrRG2SqwINg2fAeFN9yIJAawJKYHxfb/1dAI8sH8
         BBMhMVoKZiu4WsS6AXjI+w0QctyQ/mYMZqh+N/9C1JFd+Zr5b2SM19XXcSDNQf/tKAIm
         Qr8g==
X-Gm-Message-State: AOAM530PR4+3/fv9XBdDUOczJiifT2xOeHgiKBDQoRBqpWfVioFdxGp2
	562gDYqhWcSiCSK5dEM1FeONkvUyDqL3Ws1FcIg=
X-Google-Smtp-Source: ABdhPJz4INWOmnY3zGAzk0UXTSftMT0vTEYU1s7KXiOx//+0Sv7Q/sZH1dSpRAsCDz/htRI76L0b+Q==
X-Received: by 2002:a63:6685:0:b0:381:b709:4e20 with SMTP id a127-20020a636685000000b00381b7094e20mr20352441pgc.24.1647926447749;
        Mon, 21 Mar 2022 22:20:47 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y34-20020a056a00182200b004f71c56a7e8sm21402323pfa.213.2022.03.21.22.20.47
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 22:20:47 -0700 (PDT)
Message-ID: <62395caf.1c69fb81.ebc84.b35c@mx.google.com>
Date: Mon, 21 Mar 2022 22:20:47 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip68-128-g4031bdd82383
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 4 runs, 2 regressions (v4.4.302-cip68-128-g4031bdd82383) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 4 runs, 2 regressions (v4.=
4.302-cip68-128-g4031bdd82383)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip68-128-g4031bdd82383/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip68-128-g4031bdd82383
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4031bdd8238386ea87c992b18bc65b684bddc2d7 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/623955b8fb2965ce2f2172cf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/623955b8fb296=
5ce2f2172d0
        failing since 5 days (last pass: v4.19.233-cip69-1019-g2e5815777e97=
5, first fail: v4.4.302-18-ga78419826225) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/623956c4098088d2ad2172c6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-cip-nfs-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-cip-nfs-hp-x360-12b-n4000-octopus.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/623956c409808=
8d2ad2172c7
        failing since 5 days (last pass: v4.19.233-cip69-1019-g2e5815777e97=
5, first fail: v4.4.302-18-ga78419826225) =

 =20

