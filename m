X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web09.33047.1649066564408386659
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Apr 2022 03:02:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ZpC8iahh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id ku13-20020a17090b218d00b001ca8fcd3adeso2581653pjb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 04 Apr 2022 03:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=B3GzERGNiMO3Spm+yrZF+WgIcdUP3+Hfr1fb7cTJytw=;
        b=ZpC8iahhb0a/gRjhFGqvR5Rokw1kSEgIdFl+nfLc7UvjmgKqbzEDNoPJv15jm55ak/
         gwCbZexnvWmyD+u50QGT+fM0LGKShS7m16mg2rKJzwL/DWIwoDZRtm4uGhRKDUyhWl78
         Ojspnstmldj8GJSR4mkEQyzNUsv0phYiKmzEdrFXVfGjulXU00r+b8Y8zrMw7+rq3uH0
         qXN4O/ASNjSfRrNLO4ZJNYSMpMB9ntpaI4srxX19AGNj8CczrzOjBSGWJajtcHm24YTV
         3ujyx88FGhjsaFSCqvF7BOyckgIyGok6hVo4xdewv9UJHer6g6a5YFTGmOe98zJh+KYj
         6SZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=B3GzERGNiMO3Spm+yrZF+WgIcdUP3+Hfr1fb7cTJytw=;
        b=Z7BUhc6OA0FKABanDFgQ1kRQQ87JKKlTR9/dLtd8mXL10C87Eqjr0vemSFWheC4+4q
         DhH7ttkkYQV+xfzFHLKAHayGhHzMHrryN1D+ZiZzi0+IObyDlUmkSy0Z2pXDawcNpYP1
         Xcf2JW6pGOJ5UzzWi4JOReHJSxWPbaQewT+62BLoWS9Ml6eV3lFbkVznrziQUpqWUpIj
         IlSpWOZy/VaGAZQzbqH9arcSxVK8x6aII36nKb2vQcuTJ/lvxDGC24R08qoap8Jzk4zg
         PNjadknNQbw8A23PepNPQVhQEh5vR+5ef4m+f8XOXilKWwL/e0Z8fsu9km674IYQie89
         8GMQ==
X-Gm-Message-State: AOAM533dCA3z747zHflVzEtrgteuI5KHKlhBYBIbe41Jmy3QF7H7v4jS
	FVKI9n4EaFDtpP/UM6srt+XWM9Uico3WG0l15Mw=
X-Google-Smtp-Source: ABdhPJzShW85GlxcemVuA2a/RKWaVe6xiTcsMvUkOrNJRJ5lG5Hz4LA1ztV43TrMuZr2IrVYZMjuRg==
X-Received: by 2002:a17:90b:3889:b0:1c7:a31f:2a50 with SMTP id mu9-20020a17090b388900b001c7a31f2a50mr25507198pjb.193.1649066563426;
        Mon, 04 Apr 2022 03:02:43 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k62-20020a17090a4cc400b001c7ea7f487asm10110122pjh.39.2022.04.04.03.02.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 03:02:43 -0700 (PDT)
Message-ID: <624ac243.1c69fb81.57ae0.953e@mx.google.com>
Date: Mon, 04 Apr 2022 03:02:43 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-1479-ga84d0db6dfc6
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 6 runs, 5 regressions (v4.4-st5-1479-ga84d0db6dfc6) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-ipc: 6 runs, 5 regressions (v4.4-st5-147=
9-ga84d0db6dfc6)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-1479-ga84d0db6dfc6/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-1479-ga84d0db6dfc6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a84d0db6dfc604c5de8b5446ea27ac9a039ae378

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
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62444e0e9677c01959ae06aa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62444e0e9677c01959ae06=
ab
        failing since 15 days (last pass: v5.10.100-cip2-319-g7182f5032311,=
 first fail: v4.19.233-cip69-1019-g2e5815777e975) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62449ada4c5ee46efdae06aa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-ipc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-ipc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62449ada4c5ee46efdae06=
ab
        failing since 14 days (last pass: v4.19.233-cip69-1019-g2e5815777e9=
75, first fail: v4.4.302-18-ga78419826225) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62444dbcb3bd3d6bb7ae0681

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-ipc-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-ipc-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62444dbcb3bd3d6bb7ae06=
82
        failing since 15 days (last pass: v5.10.100-cip2-319-g7182f5032311,=
 first fail: v4.19.233-cip69-1019-g2e5815777e975) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62444f6e47ea5390bfae06be

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-ipc-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-ipc-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62444f6e47ea5390bfae06=
bf
        failing since 13 days (last pass: v4.19.233-cip69-1019-g2e5815777e9=
75, first fail: v4.4.302-18-ga78419826225) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/624452bfc84731803bae0798

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-ipc-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-ipc-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/624452bfc84731803bae07=
99
        failing since 13 days (last pass: v4.19.233-cip69-1019-g2e5815777e9=
75, first fail: v4.4.302-18-ga78419826225) =

 =20

