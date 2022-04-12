X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web11.5562.1649726078972337632
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 11 Apr 2022 18:14:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=NkgcjXdV;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.182, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f182.google.com with SMTP id k14so15756550pga.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 11 Apr 2022 18:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=yXGBBgSohSLoE8zzj8+hwNx1biiv3JMl25Cg9zt4wAM=;
        b=NkgcjXdVFTZifznOgFdgLZt3eszXBff6u0xnDxpveWP9dNLjLCegMDDNFHvE6O3hYV
         nD2Cwyt/YX5RrXXdYn1gFLAkfvG4YC4JbT3WT+fYUuo0zRyt9/pzbg5uAshVV4ZSzPaR
         JIxn+qyMxxww/jgzdC9eRwyAUKdLHNFRYlcfW4r8d1mUziElTGEcOsRe8arW78XlVjJ7
         pC0gP+vu5L0bVQHw8TIkW/GFqQwEog4uEH8WWpL0PzzsOwpZR1PTlf6KhYUw8kt1cLx0
         oh9W51Oql0Lfw+Ui9BeOY8Ojj1izlvLH0Nto54X1MnTUkNlgDWse+rI6GGWEulv1VtVA
         L48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=yXGBBgSohSLoE8zzj8+hwNx1biiv3JMl25Cg9zt4wAM=;
        b=IvuIJx2Ra7nF+kFLNJNgwV7ElfLA2kaz8/pq9XJ9M3rRQ/6FYm6yQwDIZx9q5g5UIP
         JAIPelMc082zhkSt1OgDMeRU+TQrCIPP+BY+jauFg8KSVuKlKnteULpf1MfEYdVkX3/L
         Z0Fn4D2pSX7eM2bSjnUIbMWzUK6PttYKPSWdcv0kbUMSwVPsc9I2vUyjQe3Rfav+N3cv
         KeoeZlH+NVLQWTxLaml6YV2DIklk5AfbKtqhCEloLmzLMap5ixuNdoV/4Qk5H0Y/oCxx
         FUzvdrXdRwgs2G3ytmCil9+LCbt4wA4yEVqi00rZcp8d2KpfehinbmcZH4OvHvctOKf9
         r/Dw==
X-Gm-Message-State: AOAM531PS7olB3uXlUxKdoJwXQaxBQOG6wTAFOwAB8cxOFkwTD96Equx
	gRHNysXlGHZKFIadDgJSYlv9VIZOFKiePL14
X-Google-Smtp-Source: ABdhPJzt4c3xGUcnxpDB75QByPXmUCU8io3mXJn+et84TpDGOYGnSU7dYdARQjqdNwc0MAbSAUfzOw==
X-Received: by 2002:a63:5f42:0:b0:39d:4f86:2f59 with SMTP id t63-20020a635f42000000b0039d4f862f59mr6680045pgb.181.1649726078350;
        Mon, 11 Apr 2022 18:14:38 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q13-20020a056a00088d00b004e1bea9c582sm36781012pfj.43.2022.04.11.18.14.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 18:14:37 -0700 (PDT)
Message-ID: <6254d27d.1c69fb81.26c77.001f@mx.google.com>
Date: Mon, 11 Apr 2022 18:14:37 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-2498-g49524d978f8eb
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs, 3 regressions (v4.4-st5-2498-g49524d978f8eb) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs, 3 regressions (v4.4-st5-249=
8-g49524d978f8eb)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-2498-g49524d978f8eb/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-2498-g49524d978f8eb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      49524d978f8eb9de24ce93fcca8d5a39522876c3

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  163cca9acb71d06492836a667a53554ceec37639 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6254c407497b6ac732ae069a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6254c407497b6ac732ae06=
9b
        failing since 26 days (last pass: v4.19.233-cip69-1019-g2e5815777e9=
75, first fail: v4.4.302-18-ga78419826225) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6254ce4668db932654ae067c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6254ce4668db932654ae06=
7d
        failing since 26 days (last pass: v4.19.233-cip69-1019-g2e5815777e9=
75, first fail: v4.4.302-18-ga78419826225) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6254c64d6bc4004c79ae080a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6254c64d6bc4004c79ae08=
0b
        failing since 26 days (last pass: v4.19.233-cip69-1019-g2e5815777e9=
75, first fail: v4.4.302-18-ga78419826225) =

 =20

