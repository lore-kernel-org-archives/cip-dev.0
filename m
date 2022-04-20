X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web09.10242.1650473409499633661
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 20 Apr 2022 09:50:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=wUyuJAb8;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id bg24so2469749pjb.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 20 Apr 2022 09:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=YC60KtCVAGyzB9wok84SODhPxL4spkSUYNeqnvdz+Rs=;
        b=wUyuJAb82oy+cQOFhnO3x/1Qwwarg2waKCkpXJOixhsHIXkeoQTRFq3Bn5eJqfPgEE
         l532VszT4BAMRk1QZRS1pUYMZTF2ng8yzVmjm3Kmn3PS7g7vzGu2PIc5cvUieIAmaD/c
         5er7una+NCKar+UhvSNqh8go+CpQZg46BFlDcGWLwn0IpCGShauLSRbQOaNDrdDETCBY
         R+4I2zZw37/v7caaM13OmmyDItUKEBVWvpZWfokE3C+DkYUdzD8S9ojB3flkB0SqzuN7
         uac2Wx+vBPSObH9mqgN/qJxR3bAecOBKpQ0+w7eNWiUebUfT0D8yD50+DVwbeY0tWJCX
         Uxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=YC60KtCVAGyzB9wok84SODhPxL4spkSUYNeqnvdz+Rs=;
        b=i+YiX3BIptEZ/7Gnk2H3C9aMzq3USbgNW+/qQEH5QhSCsctQBFI8hECNyulKUHpuTJ
         dirSPro6zCDHqp11WYUVx/TEzpdGVr8xY6iNDVlksbQyGJlbja3mRHwuBOSNNU6s2rTU
         x/OExOWl5ljlPkueYeRlRsPxXGkrXrTraIE7Si87/DRCTa4pYtEW6xKozzNxRcqv7uL1
         B36YWhcddVyPT9kOxbytsT7NQB5p7qFmp0ugbt/S8izu4/SGntfp7yLy4mJZWry3YnfP
         LcrGyzB7l6Dm55DPFmW71ayOvmagbqx9OqkVzEEOwhaAJNf8mVdaZB3QTJJUhxyuRK06
         fFgw==
X-Gm-Message-State: AOAM5323niC57KjXDzTEkLX7pmZKmQh4HgnQgbUepwyirREs0FutR8Cr
	n3FB3/ev+wwaPzB1DaHRHNMzADvZxNSW6ijZ8bY=
X-Google-Smtp-Source: ABdhPJzyMqh620H8b5lIviyGmRaZp07rFFSQI97XHf49KKVx9uSq0yfuPlWW+UVzX/5M9ryAqOtptg==
X-Received: by 2002:a17:903:2487:b0:159:bce:4e1a with SMTP id p7-20020a170903248700b001590bce4e1amr11879952plw.4.1650473408787;
        Wed, 20 Apr 2022 09:50:08 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s7-20020aa78bc7000000b005082ddeb6f8sm20866565pfd.199.2022.04.20.09.50.08
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 09:50:08 -0700 (PDT)
Message-ID: <626039c0.1c69fb81.8ab19.1051@mx.google.com>
Date: Wed, 20 Apr 2022 09:50:08 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.109-cip5-875-g6ed0fe2c3e8b
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 5 runs, 4 regressions (v5.10.109-cip5-875-g6ed0fe2c3e8b) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 5 runs, 4 regressions (=
v5.10.109-cip5-875-g6ed0fe2c3e8b)

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

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.109-cip5-875-g6ed0fe2c3e8b/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.109-cip5-875-g6ed0fe2c3e8b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6ed0fe2c3e8b47b471924ff54d5cdb9d0afb1200

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  91fd818dbff1aa3bcefae3747f83e1dd5c1586dd =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62602c3ea89234557dae068f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-875-g6ed0fe2c3e8b/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-875-g6ed0fe2c3e8b/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220411.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62602c3ea89234557dae06=
90
        failing since 28 days (last pass: v5.10.104-cip3-132-g46c091c34fabb=
, first fail: v5.10.104-cip3-186-g758e0f22e236) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6260380f27f8eafbf9ae0693

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-875-g6ed0fe2c3e8b/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-875-g6ed0fe2c3e8b/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220411.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6260380f27f8eafbf9ae06=
94
        failing since 28 days (last pass: v5.10.104-cip3-132-g46c091c34fabb=
, first fail: v5.10.104-cip3-186-g758e0f22e236) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62602ec366eaf3055eae0688

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-875-g6ed0fe2c3e8b/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-875-g6ed0fe2c3e8b/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220411.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62602ec366eaf3055eae06=
89
        failing since 28 days (last pass: v5.10.104-cip3-132-g46c091c34fabb=
, first fail: v5.10.104-cip3-186-g758e0f22e236) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62602c8ed814bf50e0ae06af

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-875-g6ed0fe2c3e8b/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-875-g6ed0fe2c3e8b/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220411.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62602c8ed814bf50e0ae06=
b0
        failing since 29 days (last pass: v5.10.100-cip2-484-gede5006fb276,=
 first fail: v5.10.104-cip3-155-g4f07dbd2df49e) =

 =20

