X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web09.7364.1647499442323489170
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Mar 2022 23:44:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ePQdlO4s;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id n18so3701914plg.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Mar 2022 23:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=HApUTLjZyLNSKuxmJ3wtPS/iRDMeoHHlolXS2byIfmk=;
        b=ePQdlO4s0X1zEr8eihS7Esh2cchoF3FoW2Hk5hKrg5j6kHUTe84mpxFyGHg/tsZh1H
         ZAtcxXjzTb+VSNjJz2m86wHQvrYXYKH2Xeje9gaEfLvPsp68D5rDf+k9HOBg4wnI4b67
         7F5cf5G2+t62UwhekQQAZwwVqQta8fxfPTt0U/XlCUTKn6NFfh23iVFmNLW1PF5uZq+X
         INf8VIncmc/VFO8sSwpVB5HMIdYczYuJGDxLHqfaTu4pgPW7jR6c+p5+Pot2lG73wrCy
         d5St1rAouMJUwF6PI178UzGqLHFKV6ujWopb05DYQZYOYXt5XBJfsUSEDWIQhpye1wcP
         TvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=HApUTLjZyLNSKuxmJ3wtPS/iRDMeoHHlolXS2byIfmk=;
        b=3vs9HLilPgfFokESB3OfXeqexJ4MXaOBgaQGCGtCazat3fOOOK9di9QapheWMrk1sC
         HnsI7VU1GIN/3vuz5JZE8mwGZ/2hQ0jTMAboKvdU0k0qluoJm+SLwhukZFABjCM5OlLF
         EvK4QI/JdYM3hZDdUP3jdzL0j3AZRsFawfS4VME1LaX8IekJDbNRpuViusZJ3YM6724k
         hi4e6c6KhqJ44kacLNqVzy9Va7HdpglKlCyeVBt6Gq+rNWLgHUeEHH8e/QCI1OrWnHcj
         RHEH0PW7/a3HzqmJK+CKlHLzKgjtMP4GTzmJE+T6S9/o0bSg26oA9GgHJTPRqCeSDXSv
         LDIw==
X-Gm-Message-State: AOAM531/EnSSy3kwMpUS9c8n8qjeLEt/9z1wvFBFDKU0lyoMKaSLx6SG
	9m9Uu8yDxOrdqkpw63edcmOiu1kt/eR34UCQhLc=
X-Google-Smtp-Source: ABdhPJwWKLYdQuZqnViOamGyX4YaCQBY7x/M40Eq/Z8v28H0MNe3B2fbmbinUFpzYNKx3HGA/fBR9g==
X-Received: by 2002:a17:902:d492:b0:151:86ac:bc7b with SMTP id c18-20020a170902d49200b0015186acbc7bmr3158222plg.52.1647499441507;
        Wed, 16 Mar 2022 23:44:01 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id my17-20020a17090b4c9100b001c5cc1e1e8fsm8777512pjb.43.2022.03.16.23.44.00
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 23:44:01 -0700 (PDT)
Message-ID: <6232d8b1.1c69fb81.be151.6a75@mx.google.com>
Date: Wed, 16 Mar 2022 23:44:01 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4.302-cip68-19-gcfdd1ea3a7ba
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 9 runs, 5 regressions (v4.4.302-cip68-19-gcfdd1ea3a7ba) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-nfs: 9 runs, 5 regressions (v4.4.30=
2-cip68-19-gcfdd1ea3a7ba)

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

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip68-19-gcfdd1ea3a7ba/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip68-19-gcfdd1ea3a7ba
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      cfdd1ea3a7bab80ea3e513f28e7aa423fedf5d61 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6232d049d41d2e7d84b7392d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220228.1/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6232d049d41d2e7d8=
4b7392e
        failing since 0 day (last pass: v4.19.233-cip69-1019-g2e5815777e975=
, first fail: v4.4.302-18-ga78419826225) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6232d3b147ebc35befb73935

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220228.1/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6232d3b147ebc35be=
fb73936
        failing since 0 day (last pass: v4.19.233-cip69-1019-g2e5815777e975=
, first fail: v4.4.302-18-ga78419826225) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6232d0d5b24fcff7a6b7391d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220228.1/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6232d0d5b24fcff7a=
6b7391e
        failing since 2 days (last pass: v5.10.100-cip2-319-g7182f5032311, =
first fail: v4.19.233-cip69-1019-g2e5815777e975) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6232d7f07e9cc2403db7391d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220228.1/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6232d7f07e9cc2403=
db7391e
        failing since 0 day (last pass: v4.19.233-cip69-1019-g2e5815777e975=
, first fail: v4.4.302-18-ga78419826225) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6232d6c4060fe8cef1b73943

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220228.1/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6232d6c4060fe8cef=
1b73944
        failing since 0 day (last pass: v4.19.233-cip69-1019-g2e5815777e975=
, first fail: v4.4.302-18-ga78419826225) =

 =20

