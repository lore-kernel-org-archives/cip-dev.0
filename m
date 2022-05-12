X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web12.2251.1652348951578505822
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 12 May 2022 02:49:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=csuw2oxL;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id o69so4674955pjo.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 12 May 2022 02:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Wehi59aumbwVgFC4/OETxUrpxS+EvoPMXtcaWW4LvwA=;
        b=csuw2oxLEO3UK6IWiz42sCVqaBDEpmGW4BdRFOO4XaojhTm+G5KRvMMpOuk0bcLThf
         AKDEcKMKRGUeZNyGIKT/RUTwhPJC2n+Q2tg6Q1cUsLQxBWeH1MgwkDAt2v/vFmAzCDKr
         YaDf94eT4adjESMaVNBtp294s+kTIHTxeZvLfUoqbICWwmTwkTguYZf26rFuPAqRdSTv
         0mOoD0U2WuVzDWdZQvEAAKV2zKtrPClCDxz4ntKror92ZRZYgog1/HoFd+Q7WiD82rD+
         Hx/OyFLjEriFIgXLOuxuuxsHvF0tQCwYYbrPXfGaW/AgbEJeaAbQ4Trf4yysEjxxTqyT
         preQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Wehi59aumbwVgFC4/OETxUrpxS+EvoPMXtcaWW4LvwA=;
        b=JJa1tnJFY4zc1sRQ2AQH/P4nEnJSSPx/sfZAqQ6rjrFDhmmJOUKzjQ6s6zxh8/7Rvh
         CLAC9tJ/YgXMrtRpQla5Zq/hSoBLHfoOgKnzCkZUpMSWUg4mUpq0Pnjoi21Hpkgthy8H
         9RB0m/Diy1CfGKNUb/ThDc7UFFe1TS1+iVPM+3QTKFCkPhK4ESXT3r0VBV3uf3ArDXzU
         ObZ+cRGptDaGhTKRwT0ogCpWGnhZRnAkhJOvgub7FFDiHLdYy4TWYip2XaU7iHGGZ/ku
         RMtYakEl6gmfjyl7bNy92LipVm5Fn+701Pxksy7GkNzSzLPA80Afd36iQ5hTY1v43G3m
         0Ylw==
X-Gm-Message-State: AOAM532u16jfg8WrTS1zWWfnASdqCCM2oZFlQNouAljO8vuzdxfOngTV
	1X29q9ZMriYUyArzYIsynFvi918amaNWdlAu0VA=
X-Google-Smtp-Source: ABdhPJwnn2LGkoXxBjwXvnUMXvPZ50dg97WlzDsd9PNzNFbP1UrVRUoiYyLB1WVNLSyIcul2RrMPTA==
X-Received: by 2002:a17:90b:4c09:b0:1dc:6c30:f230 with SMTP id na9-20020a17090b4c0900b001dc6c30f230mr10096539pjb.110.1652348950804;
        Thu, 12 May 2022 02:49:10 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z14-20020a17090a8b8e00b001cd4989ff41sm1448781pjn.8.2022.05.12.02.49.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 02:49:10 -0700 (PDT)
Message-ID: <627cd816.1c69fb81.387a5.3bba@mx.google.com>
Date: Thu, 12 May 2022 02:49:10 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-49-g02cbcd6511d4
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs, 3 regressions (v4.4-st5-49-g02cbcd6511d4) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs, 3 regressions (=
v4.4-st5-49-g02cbcd6511d4)

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
nux-test/kernel/v4.4-st5-49-g02cbcd6511d4/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-49-g02cbcd6511d4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      02cbcd6511d490bde09277489d0cd57e67cd1d77

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  0f67c9851a9043d0ad68cef4648d103ba7908480 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627ccfed9669d54a2b8f5731

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/627ccfed96=
69d54a2b8f5732
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627cd2395e7428ec888f5727

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/627cd2395e=
7428ec888f5728
        new failure (last pass: v4.4-st5-17-g04a3c17cb526f) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627ccead1f2876db738f5717

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-49-g02cbcd6511d4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/627ccead1f=
2876db738f5718
        failing since 0 day (last pass: v5.10.109-cip5-384-g722204542e8a, f=
irst fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

