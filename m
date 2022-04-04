X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web12.33128.1649066564797770640
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Apr 2022 03:02:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=wGu1TOzp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id o10so1802966ple.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 04 Apr 2022 03:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=3hdAmRv2sem9RVJtfdBGLrULggo8fdNKiuXzOJoNlQQ=;
        b=wGu1TOzp8TA2CBgTJDr9CU4fFH4PboOsM1IhKhs+Nq22W8dv8UQXn6JjEbFe43cX7k
         jOljNAjRcBf0ka9LiUJO9QOsXpxOow/NmdrsMNPXZKUfY3Dto9E9OuejN4lAhJlxcOYK
         0/K+PZ22tvo8NVl3N79OrVhnYETKGZZLFJoflJNLNJ60BlcABKLhN+DYyLseQihC4wEH
         A87vsxfbKWggWMMTzVCYWCMntmOR0q9I6xas0+MmSL6ZdwDFnDOhsRkpLpEGwGaUIJv8
         cyM0RBSUZFKfmr15O6bYoPZ0k4tdU/PJkoPn7qJZAGaWwrOMLDFeeUFCgMLjQhlUkNW3
         WGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=3hdAmRv2sem9RVJtfdBGLrULggo8fdNKiuXzOJoNlQQ=;
        b=buqC3R5d9BV4GrUxUfWeJWRq3sPSCjSDAW4bQtsPLwmroHwQ7w5dr8rVx+re6v6BPH
         blNG9EjDoRP1+Csrs/5Yf9MVIxpZpECT1hioRv8Zzmgb42jbePPzfC7O3Oaa7qMTI0Rh
         KYFJDSfIV1uAP40jwD3doJJPrSXZ+hQuBN8VlolhHdKpY5UGK27JxPs5D9XKGiyzIcXg
         yENgkmvjFwvDHOwIm6avJ1Olm0SxT792pdCb17bqbE2ge4Iw7jipkTrkpW9NsSuZBanp
         lfL7UTodpN6t1hNgdOhRDMDJQ635NC9kFn21DFDlPrnrj8XDz+3QlHeYJWp7nCo0wuBy
         2DIg==
X-Gm-Message-State: AOAM533o+VO5wQmNbZ2IZdmK/xkbPVhYkxoekgPTklOmqGkEpl+HzTjO
	ROr0Sp+vh5M9QPQzn8k05XhxJH9YTbc153d+Zrs=
X-Google-Smtp-Source: ABdhPJymrf5Qm4lJGg+X+pqC6uts23f3TTxdC1V63ccImdBTFFGU3NbpXDQYN4+x16qzL6dtZDWo2g==
X-Received: by 2002:a17:90b:164f:b0:1c7:8d20:ff6d with SMTP id il15-20020a17090b164f00b001c78d20ff6dmr25619487pjb.64.1649066564057;
        Mon, 04 Apr 2022 03:02:44 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bg13-20020a17090b0d8d00b001caa8f51098sm1641484pjb.9.2022.04.04.03.02.43
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 03:02:43 -0700 (PDT)
Message-ID: <624ac243.1c69fb81.61da8.3b6d@mx.google.com>
Date: Mon, 04 Apr 2022 03:02:43 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-1479-ga84d0db6dfc6
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 4 runs, 4 regressions (v4.4-st5-1479-ga84d0db6dfc6) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-mm: 4 runs, 4 regressions (v4.4-st5-1479=
-ga84d0db6dfc6)

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

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-1479-ga84d0db6dfc6/plan/ltp-mm/

  Test:     ltp-mm
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


  Details:     https://kernelci.org/test/plan/id/62444efc47ea5390bfae067f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62444efc47ea5390bfae0680
        failing since 15 days (last pass: v5.10.100-cip2-319-g7182f5032311,=
 first fail: v4.19.233-cip69-1019-g2e5815777e975) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/624499fc0606c9c71cae0687

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/624499fc0606c9c71cae0688
        failing since 14 days (last pass: v4.19.233-cip69-1019-g2e5815777e9=
75, first fail: v4.4.302-18-ga78419826225) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/624456be519a02a39bae067e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/624456be519a02a39bae067f
        failing since 14 days (last pass: v4.19.233-cip69-1019-g2e5815777e9=
75, first fail: v4.4.302-18-ga78419826225) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/624453a63f24dded2fae071f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/624453a63f24dded2fae0720
        failing since 13 days (last pass: v4.19.233-cip69-1019-g2e5815777e9=
75, first fail: v4.4.302-18-ga78419826225) =

 =20

