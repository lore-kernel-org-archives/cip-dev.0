X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web08.6483.1651122965643164566
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 27 Apr 2022 22:16:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=uHDYwOyA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id n18so3381088plg.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 27 Apr 2022 22:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Vkbty0+0Hj40UX41ecx4+RYWhZMZcP6RJsjqHU7QByc=;
        b=uHDYwOyAgHey3wllhAJvte9N4usEfXwMHtO7b4hqt37T58IK7hHa5Y+Fy5zhWUSG/r
         T3mQN6Lt4snqLK9n0XLKge0O9VUOM+Mnwzn1xUR7BHTIDjJ+G2LNPno1oQLRklXQD7z2
         eLzFou351VkDnuhjNdvHB4LnbuHCACksO/s3zeUWc0pcBGBH2AZphlTYqOgH2MDc6dAQ
         SNw4mEJZIXBfGAM8PAXoXKJ0lPQ+BUVV3xmCarLCwctgNtudTU30h84LOwHPbJj8fuLI
         RoQHJ/hY6vxRN/sBoMCy+s+cGE6vvG503KCGKM8YR7hrc9QuUEkBpSHcklvKkadfQeJp
         xAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Vkbty0+0Hj40UX41ecx4+RYWhZMZcP6RJsjqHU7QByc=;
        b=uB2+iWpnG8S0er5aVQRUd5DZlrRT5e2Bn6OBDhA6v+iRRcLtxQzFHDS1wfRAVAS2Tr
         cf58hcq80ZPoa1OLXMxa8nyjEXLaeMaJwpFMsatT4RZ/XZM4s+XRQAeT10pSNiUafAFi
         SmTHi3VHXjToxCP2HSZ+7Hs6zftCYba7MV5V1BQpAlD0H6tTPv8Ql6j6wr5bfs8gef74
         Qdpg1i4D/6qQDlhLeJZkXcOnL0HlBzgcxNSSNq+7eIox97WlQ+9lsQDaXJkjehUwD+fp
         4qHd8dqP3Yf4SFMKF8Dy2+g3eJc68pQG+9nNpOT1zJdoCC0lUxUHiIPvIbFEiUZHofmf
         tN3w==
X-Gm-Message-State: AOAM530hwogvmZpADIo3vbsO1CM2RMlVDDQtFqyi5hDj5hTYDXNMjeWb
	u93hzQqpqT0Lo0HDPFWXp3OIpmeQ0nens9vwpqU=
X-Google-Smtp-Source: ABdhPJykvbBjq4GrDHO1c2Zn9CdBvUgK5sjL0/PkSKmeUvV//Aw59YftCibibO69kTvFGmvbzCdoTg==
X-Received: by 2002:a17:902:c411:b0:15c:e82a:e854 with SMTP id k17-20020a170902c41100b0015ce82ae854mr25122326plk.18.1651122964962;
        Wed, 27 Apr 2022 22:16:04 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n10-20020a62970a000000b0050da02088e7sm447551pfe.122.2022.04.27.22.16.04
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 22:16:04 -0700 (PDT)
Message-ID: <626a2314.1c69fb81.6ecbc.1077@mx.google.com>
Date: Wed, 27 Apr 2022 22:16:04 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.112-cip6-88-gf3397cadb2dd6
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 5 runs, 4 regressions (v5.10.112-cip6-88-gf3397cadb2dd6) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 5 runs, 4 regressions (=
v5.10.112-cip6-88-gf3397cadb2dd6)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.112-cip6-88-gf3397cadb2dd6/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.112-cip6-88-gf3397cadb2dd6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f3397cadb2dd665a16905355cbc6717f52d196a3

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  4e132c1f9e14f9eaeb4f9875eee3f97a4a1ac987 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/626a14c112bdb7ba4bff947a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-88-gf3397cadb2dd6/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-88-gf3397cadb2dd6/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220422.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/626a14c112bdb7ba4bff94=
7b
        failing since 35 days (last pass: v5.10.104-cip3-132-g46c091c34fabb=
, first fail: v5.10.104-cip3-186-g758e0f22e236) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/626a1618f619161240ff9471

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-88-gf3397cadb2dd6/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-88-gf3397cadb2dd6/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220422.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/626a1618f619161240ff94=
72
        failing since 36 days (last pass: v5.10.100-cip2-484-gede5006fb276,=
 first fail: v5.10.104-cip3-155-g4f07dbd2df49e) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/626a1fb6ab8383e894ff9459

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-88-gf3397cadb2dd6/arm64/defconfig/gcc-10/lab-ci=
p/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-88-gf3397cadb2dd6/arm64/defconfig/gcc-10/lab-ci=
p/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220422.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/626a1fb6ab8383e894ff94=
5a
        failing since 37 days (last pass: v5.10.104-cip3-132-g46c091c34fabb=
, first fail: v5.10.104-cip3-155-g4f07dbd2df49e) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/626a185bf02cb027d8ff9464

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-88-gf3397cadb2dd6/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-88-gf3397cadb2dd6/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220422.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/626a185bf02cb027d8ff94=
65
        failing since 36 days (last pass: v5.10.100-cip2-484-gede5006fb276,=
 first fail: v5.10.104-cip3-155-g4f07dbd2df49e) =

 =20

