X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web09.6462.1647928251783004265
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 21 Mar 2022 22:50:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=b6C60Srj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.174, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f174.google.com with SMTP id bc27so11882247pgb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 21 Mar 2022 22:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=0o+2xjSFrmhb9NtO8m5uQjWzl8MCA3ahn1lo/r+Po60=;
        b=b6C60Srjp3JS7scvlua3cOa2veUFQouDvmV5qb7+iJ0E37G7pNDzdsEDT7FfhKyis+
         LrBptcJX72VlT2q+h3BXQNNGeecDTUr6cGPYcgh/J/EHguljRbJu8AJ0wi8aos6qXrPL
         O3z+X89Oz2npq+OH+B8R8sDLhefXBNkpDIC4Uh3JitbzkVlR+Qbtg/lhKpctK5UpPr6N
         azBYeAVmUQeeyvylezr+p6QkN1B9UCu+lKGsiIRnpoQ/S0C1TqmlH9MJEM5rsCaLZpn4
         8bcqOTzFp6p9GMuegAA5E2tThAMVqDO7HOdDZ/aYL3nKAdTRb4ktPhlbnEd0nNUb7n6c
         jdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=0o+2xjSFrmhb9NtO8m5uQjWzl8MCA3ahn1lo/r+Po60=;
        b=X82d8iBSR/JN6xtxGm4jQ9xbX0VhHd0S2B+6TrwXMVWkLbc/kw2meOSVYbsJ3qg8i5
         6q7vdeE7HKk3A+/42ba7CNq7U23UIspFUhkiOictkMcBJ/1dL6uSCMP1Uscibcl0orYD
         0FMhnt1zPTEmW5ftphma4eaWQAlFyMSA5//z7dY4B7gMzpkEauLRYFEE3RhFLmElqvXy
         yb0UJ7DzXh6DJ77eZPxefDPWE+Xoc5GGqHc4faLP02ji7gDjUvLfIDfQ/8R5vXw0uVD5
         mUJs/YcEOX6y3nm02ismHxxmJPQDBviTm9yFFoeOL0m+m4iUHhEawN6HXwD8DH7q/TcA
         NMvw==
X-Gm-Message-State: AOAM532mWZK3psn5rchhspt80xrGaxETVxhwVcItlJk+lrVhwE42kO+m
	FH/FecqgvzZWB+1PDCG2ov8rVoMnForehNRS0BI=
X-Google-Smtp-Source: ABdhPJz4pohY+YA7O0E8mKzUWknRBMGsV+MpZa2AXTE7cu/5U1fj1L0dCR9k3/KxlJ8DZjhmCfCwRw==
X-Received: by 2002:a63:511d:0:b0:381:7f41:a4f0 with SMTP id f29-20020a63511d000000b003817f41a4f0mr20256606pgb.265.1647928251106;
        Mon, 21 Mar 2022 22:50:51 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g24-20020a17090a579800b001c60f919656sm1247757pji.18.2022.03.21.22.50.50
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 22:50:50 -0700 (PDT)
Message-ID: <623963ba.1c69fb81.7e4f0.4899@mx.google.com>
Date: Mon, 21 Mar 2022 22:50:50 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip68-128-g4031bdd82383
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs, 3 regressions (v4.4.302-cip68-128-g4031bdd82383) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs, 3 regressions (v4.4.302-cip=
68-128-g4031bdd82383)

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
nux-test/kernel/v4.4.302-cip68-128-g4031bdd82383/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip68-128-g4031bdd82383
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4031bdd8238386ea87c992b18bc65b684bddc2d7

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dc836ec4cd4e02e1346001f828c1f1988a8d7d54 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/623955ba645f634c43217355

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/623955ba645f634c432173=
56
        failing since 5 days (last pass: v4.19.233-cip69-1019-g2e5815777e97=
5, first fail: v4.4.302-18-ga78419826225) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/623955b3645f634c43217334

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/623955b3645f634c432173=
35
        failing since 5 days (last pass: v4.19.233-cip69-1019-g2e5815777e97=
5, first fail: v4.4.302-18-ga78419826225) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/623955d42579fed1b32172cf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/623955d42579fed1b32172=
d0
        failing since 5 days (last pass: v4.19.233-cip69-1019-g2e5815777e97=
5, first fail: v4.4.302-18-ga78419826225) =

 =20

