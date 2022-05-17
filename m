X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web11.7133.1652793362092708185
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 17 May 2022 06:16:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ievAEAoW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.179, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f179.google.com with SMTP id q76so16890798pgq.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 17 May 2022 06:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=XgOPWnCNSTqxU0Oh/nqsRutCNFO1uOG/hJCbWRXQgos=;
        b=ievAEAoW37nJNblVc4lSTKXRqdYJ+5lTbc01teuB/GUdCYElp4mwLM46lAElVFVUhC
         AJ/UEFe6iyg902GnaeCz0N9cczKHCdZ8pVf4HuLiIe+xqxWiXL0CNWPvz8A5smG/SVHt
         maP3DMchhhKF4z3lVlWfbCyc+emYKNfC17yiFcQssA5qmSwLD+dIbxs7hV1bYAABGauX
         8qhjBm9NC8Gwd/D/XZPP5bv7IKCLSHYHTL544WG5kyW8Jki97TdtXD5z3fWo5qQ1zyC7
         MTS/bbzzgCFMw6K2zAsk7nhF8ozfQcXQoKySmzKKe8QQd0jWglSA/4WXA/xqXvsLrsW1
         hDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=XgOPWnCNSTqxU0Oh/nqsRutCNFO1uOG/hJCbWRXQgos=;
        b=WNsEp2KPJDu7lgGu4fjvFO7aLUUh77CgaknY+mAKFtPKTLzWrwze8Dprw9b/3RXnvX
         k7B67iK4LshM7Ww5aR8fjut+bfuCPdYpNZLHFf1CLJIImgfWZ8vIyMiSHIOnEZJpQILV
         s9DXVTnlQB9WSsQOcYYBESsL4O4X4x9Fm8RvDJg9P0/HrB1IPcCNmvhNNkLeh9304KQ1
         oBd9Mb9pyuOpLjrKTVSVT6UV3B1HcEFr35x+wtLglIZsHYOxJscVNPOrzlAzIGTtEcxS
         usDbLHNJgeWIQEiQBOLFmMEVugmIVMna8XMQfnPvOvse/NAoROpjJtzfGPt93eeRLptN
         DMTg==
X-Gm-Message-State: AOAM530h3YLJKAGuI/szODQsQ45LDNto0+ydbMwTU40DlhcTJ99rCvZL
	mMAPeROOjhJH2i6kuws1v/mekNs72inBccaj7AU=
X-Google-Smtp-Source: ABdhPJzdqCxpJv8U9gnKnMRGOM59g9KCEvLBd3W4VTJ87pbcK917H4kf2a6xsWWhMzxFDQigGJnSmw==
X-Received: by 2002:a63:e5d:0:b0:3aa:3c53:537e with SMTP id 29-20020a630e5d000000b003aa3c53537emr19547121pgo.622.1652793361342;
        Tue, 17 May 2022 06:16:01 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k14-20020a170902ce0e00b0015e8d4eb2e4sm9032312plg.302.2022.05.17.06.16.00
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 06:16:01 -0700 (PDT)
Message-ID: <6283a011.1c69fb81.6e154.652b@mx.google.com>
Date: Tue, 17 May 2022 06:16:01 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-293-gbfc4bd11718e1
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 4 runs, 3 regressions (v4.4-st5-293-gbfc4bd11718e1) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 4 runs, 3 regressions=
 (v4.4-st5-293-gbfc4bd11718e1)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-293-gbfc4bd11718e1/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-293-gbfc4bd11718e1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      bfc4bd11718e111c2344c45b9237855beb947e3c =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62839e5e18d6a1e3f5a39c02

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220513.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62839e5e=
18d6a1e3f5a39c03
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62839e22816b4249bca39bfe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220513.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62839e22=
816b4249bca39bff
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/628392daf67b5f55f2a39bcf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-293-gbfc4bd11718e1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220513.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/628392da=
f67b5f55f2a39bd0
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

