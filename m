X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web09.5453.1649726076787054686
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 11 Apr 2022 18:14:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=DEhCRI7L;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id g12-20020a17090a640c00b001cb59d7a57cso790503pjj.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 11 Apr 2022 18:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=N14HctoIXkc/5iJBYsbdp7C43dVk5QE84+QmJp0bwmc=;
        b=DEhCRI7LnYY/SZc4gPy3ozUgOKbslGm0rjKm6G59T/2OjyUaARRbtgIyfz+Uxfbwm6
         QH8SEBWYkwRTikGoU3RE8inB3YhrLXILgwAQl7/WG9ioU9ynWMX9k3Qkb1oI81lr38R1
         wa2Re0aybrmIiZ6msIjvUzehALOsts7+aZTTz8nrEbRJIiSHnRrUl13ykxijl+l43WBj
         lIC6lbFe9PWoZiDXa/4EEQVoFZUBjS+6J39ydItUWmE+ISk0n2UcZmYGjoY9H+hIg05I
         Yj0uc/FCHHNY2Kd5YgHEqU8Fo1QlOrWa1108wPkCQIUfxRZoykrl7ow4ZKneEuCxFVPS
         pnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=N14HctoIXkc/5iJBYsbdp7C43dVk5QE84+QmJp0bwmc=;
        b=lWYdUHbetWKJJ5ih56Ffrib5UQx2JozzfrRNePBHABcAZjZdk2y6cAvl+ULYtsjBQR
         lj6J8W7mx/375KYrlNXWthOgrajCNxkiD7tqdGKiZ60wBo0uVV8GOSLvJAmqrcqsHBmn
         xWwbdzhcb/D3GT/3bc9ejZD9VUZf7S1WMPftTLHxx8WIn20cVPwDBN0k6fWExotOKFH1
         sEtTM0irc7QZQRSp4Dvi+KyYPVGlkZX+xseGx5Makalazks+M8dCxYKZIiUn21xSKn0A
         KpqdoKYasG0QQgqu0H8aggAokGDQg+Eg0WLcPGLZY3qC9yfkRHYy2BINcetNcJL+disc
         KTzQ==
X-Gm-Message-State: AOAM531bcRNDl6x97HNRdboObskX4LSLlyMT3rxgDhZdPMSC/BuKbXW1
	rKST3LyU1RQPda1FKSsYjRGo/7HflGvPY5zq
X-Google-Smtp-Source: ABdhPJy91fQKdoks+Zoc9xLPRzUceLZCibFInIuOOKF6Kr55XFTqkUqgB9fFKRteonRQ9vy234sHLg==
X-Received: by 2002:a17:902:cacb:b0:158:694f:240e with SMTP id y11-20020a170902cacb00b00158694f240emr7073824pld.153.1649726075904;
        Mon, 11 Apr 2022 18:14:35 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x193-20020a6286ca000000b00505fe80736csm125975pfd.2.2022.04.11.18.14.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 18:14:35 -0700 (PDT)
Message-ID: <6254d27b.1c69fb81.11cd.0a9b@mx.google.com>
Date: Mon, 11 Apr 2022 18:14:35 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-2498-g49524d978f8eb
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs, 3 regressions (v4.4-st5-2498-g49524d978f8eb) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs, 3 regressions (=
v4.4-st5-2498-g49524d978f8eb)

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
nux-test/kernel/v4.4-st5-2498-g49524d978f8eb/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
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


  Details:     https://kernelci.org/test/plan/id/6254c4105835770dc5ae067e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6254c41058=
35770dc5ae067f
        new failure (last pass: v5.10.106-cip4-69-g05f5682c2c593) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6254cd859ffe597ce2ae0682

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6254cd859f=
fe597ce2ae0683
        new failure (last pass: v5.10.106-cip4-69-g05f5682c2c593) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6254c5eb4ac618624fae069c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6254c5eb4a=
c618624fae069d
        new failure (last pass: v5.10.106-cip4-69-g05f5682c2c593) =

 =20

