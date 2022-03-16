X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web10.25433.1647439054406667092
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Mar 2022 06:57:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ifVvx8IG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id e6so323217pgn.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Mar 2022 06:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=tHgRiKMlbqbQw5SdA8jVTyrW6Nx2301FLi+BO/47A3w=;
        b=ifVvx8IGztb3DOis0F+pMYp8VBIgUJrLIWtD9QG66QRSRtY8XxzvaAc5YeGmzeuCg7
         b7mbl/BszmWbRb2VfMUnBKvlGKh6k6ECBOhS6sSYQ0VOnlOxlL+cUb0xeZrId+kOXYrt
         6ypA2Oe/lmqq8ASVWDHtjFPflosMhQCj/ORU6v4mNt5aBV1Tn3xPX5ggpVwVxKBTvU40
         yfS+A+xebZzZ4EMtydgHNxmvUwIJMoCImz3IV2Rhw38n7eJHS4oBT4WRlTKFyrx6yZr9
         7Gkr9ZkFTpZmlPYemTAzHxmSvsKjT95cf51XbPA45Ym4S+Pu3u9//9nh48k0myEBzd/Y
         is1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=tHgRiKMlbqbQw5SdA8jVTyrW6Nx2301FLi+BO/47A3w=;
        b=f5eKZNG0/J9J7JuTbHN8nj1PC/4uchl9ZHyGs+/MlC5wpErZ/PM73nIGRblopm77+c
         LK0N2uTzcg0le+GVtaQ/cv5lbhUN0qQlqN3wsbfKdE3QJMtHd99UsZAwU45cu5B+DwKX
         zHULCIBMmjvEnQ+cvkEwcT4WpKHT+7xt+xguojgy23vuUZvBxK3XWiAB+3G+Zdds8mAS
         w+q+GNWt/NIH5ttSBVujPeypEe+wAs69R1cfNaq9acyAoJmvDM9x4NxLvIuUQwY0kAkX
         +rmzgeYl2Y2QNj9O5OEIwN8d2pYVYNgiFnuhZDNf0dtV+i/x2Vltq1RkEGJuaAorZIyt
         XfsQ==
X-Gm-Message-State: AOAM5326EAlR6OQDTqt9nZcWN5GRnWsxx6xDPEUtDHVEMkHipy1/VW1M
	1bmJ+pJBGA3aD7PaWpvIfWPrlSH5k2QYWiI2J8k=
X-Google-Smtp-Source: ABdhPJwlM/5ob53Uiu6bdoTKcUdMJPu8mdaK2wvwn+35GdoWa55wFFJBGq4jwVZ6QAhNMD+fXAdGwg==
X-Received: by 2002:a63:388:0:b0:37c:8577:c8f3 with SMTP id 130-20020a630388000000b0037c8577c8f3mr29171933pgd.148.1647439053706;
        Wed, 16 Mar 2022 06:57:33 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m14-20020a637d4e000000b00380b83e2e1fsm2745232pgn.70.2022.03.16.06.57.33
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 06:57:33 -0700 (PDT)
Message-ID: <6231eccd.1c69fb81.a2d24.6328@mx.google.com>
Date: Wed, 16 Mar 2022 06:57:33 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4.302-18-ga78419826225
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 4 runs, 2 regressions (v4.4.302-18-ga78419826225) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 4 runs, 2 regressions (v4.=
4.302-18-ga78419826225)

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
nux-test/kernel/v4.4.302-18-ga78419826225/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-18-ga78419826225
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a7841982622594475c87d82372d03c2cd9a4786c =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6231df7d07c1b04e3ec6299b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-18-ga78419826225/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-18-ga78419826225/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/baseline-cip-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/6231df7d07c1b=
04e3ec6299c
        new failure (last pass: v4.19.233-cip69-1019-g2e5815777e975) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6231e475b009121f33c62968

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-18-ga78419826225/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/baseline-cip-nfs-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-18-ga78419826225/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/baseline-cip-nfs-hp-x360-12b-n4000-octopus.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/6231e475b0091=
21f33c62969
        new failure (last pass: v4.19.233-cip69-1019-g2e5815777e975) =

 =20

