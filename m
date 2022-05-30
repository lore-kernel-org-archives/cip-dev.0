X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web08.38927.1653929489819336498
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 30 May 2022 09:51:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ozA5VijH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id y199so10986941pfb.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 30 May 2022 09:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=9ckm8ggdlI3lW+wkA0gghFZKy2x6vpMx1N2841F+A0o=;
        b=ozA5VijHaLc8j4u2uyKFWWknh0FTA7gevDSt/IcRMp852oljNKd4CPetqsH+Q2kRJR
         l15tFDdUWRZBb0QXBBog7EKuR93ffbpv2MWtrHED0+g+LL6y865qcTlyF6WLEMovLPz2
         IqQix3GSry133je9eia+oPIP7BmpbXx6D+A9XgCyFWRDaZcNN3dbq8KU5DcBO11tPV5h
         GzOG2E8PVwp6YyJ3XBlZ73PIN1QyVUlY2S3KM9AvqmTwOHNC7gdt+OC9Jou+NrD0jPah
         2YO1rvTHcfbQ4gIAGkHAnfdREXV0hk+ZZ6sC4qXGy2QU7wymlmDcOeamUsW0x+dawIu7
         2Lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=9ckm8ggdlI3lW+wkA0gghFZKy2x6vpMx1N2841F+A0o=;
        b=BpMlEp4IBBsPswx7yHpaQ1QDeoqYFtHGT43cn6gR+cvM84uZ+gL+FxL32MtDqfj3q1
         3xryIFiX1XAXT1CrQ3RJv8Ovi01fsdiAtz9l1zxunFtuwNO3Tf5ozIaeQ8r57ss6TS1Z
         jcA3eNC2KzaDsEHEvsLwvvtyCX4U4jQe7N3VX5ZplESzYGAwYI5aeycdkjuEaMxXYgzZ
         1b7L3ZadRQLulcwimUOECzrrE5t1VcnHZ3fL7C+9AUOiwEsi8LQslx+VDPN4l5DwhlNe
         X7t9bx0QiAfJqEEfaWgnAaw6fmU4yNtbFEH1JnD0J92+wWtQ8RHaxu4JPFGzPK+8+O0H
         1LUQ==
X-Gm-Message-State: AOAM533Kja3l46qWLu2sSVOsYIuSGeJbxspWlKc5ZgA8HqrUsXf6ryOT
	vNF2hQaapSn41EyphIehjNoZwYZQPxd56P/bxU0=
X-Google-Smtp-Source: ABdhPJyNz7rtkoMPVhAKlM7R+q2GgMpcXdrMkTl6ImSr/MWxvNeJg1glEL8+8YScaJPsK25tFmEybg==
X-Received: by 2002:a05:6a00:2310:b0:4fa:7eb1:e855 with SMTP id h16-20020a056a00231000b004fa7eb1e855mr58362431pfh.14.1653929489064;
        Mon, 30 May 2022 09:51:29 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902e54900b001634d581adfsm9526643plf.157.2022.05.30.09.51.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 09:51:28 -0700 (PDT)
Message-ID: <6294f610.1c69fb81.fbc20.4e80@mx.google.com>
Date: Mon, 30 May 2022 09:51:28 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.118-465-g0af29783a3c9
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 7 runs, 1 regressions (v5.10.118-465-g0af29783a3c9) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 7 runs, 1 regressions (=
v5.10.118-465-g0af29783a3c9)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.118-465-g0af29783a3c9/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.118-465-g0af29783a3c9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0af29783a3c96b3caf71bb01eb38e07102566f10

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  83978df41846c88a0d491b9cef3e8cecae02bef4 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6294e8d5b3da0b6e7ba39be0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.118-465-g0af29783a3c9/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220527.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6294e8d5b3da0b6e7ba39b=
e1
        new failure (last pass: v5.10.115-cip7-81-gd05f72e501084) =

 =20

