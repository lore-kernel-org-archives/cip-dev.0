X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web09.7520.1647501245606384931
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 17 Mar 2022 00:14:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=I1Wiwgz8;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id e3so4125790pjm.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 17 Mar 2022 00:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Od8YIVw7cbFcBiK6ocw0/97kDV7CiUdLJdHzvmP2Fik=;
        b=I1Wiwgz8cyahCoBBvLPtPX5ZkURHKTJ1bZDRB5oXta+RjbFJ/0pN865taf1USlVyfB
         paCRvFusvrTTFBLebEbvpH4A3SxiVAIcN636NNC0KteuvZD6G1hkljqkc8FnR0V8F3Tr
         pIfDmkbYUsymm71V5of+YWVkwJKElg7C8bhGXdyISBhvGduSCWGGx2qaeOeml1gaPECJ
         PwEWIt3oNCFQdrK5xPkCcdizpuNvu6mZNJc2/eElG0LIASIdDkodzbxlcSDcHxBwhEgv
         ifa1vdUQdXpcyMXewmwh2o92NP3aA09SWvq9aMcb4opkDqSJveNgFfiXbUvSaYxKmKTF
         ZPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Od8YIVw7cbFcBiK6ocw0/97kDV7CiUdLJdHzvmP2Fik=;
        b=ifGnFQIfaIuo8UTGYs9yfgxVM4M9ALKyMdBn5c79jcRKjmpkLswwnpWWKknx36kuzC
         mA4K0g7sc+foq3ixO1DLI+3d87F0u2eNwpZ+o4zotk85iUx3+NPLB3nlFkYlkEpJkSNT
         oy+4aQdeGkmcgQdWaWlOj7a74q/8/qP9XiKt6a8BfbGNTZmwkKFPA51/Cf89Zh0Qw1Hu
         OBwNfZJzavA3j0x2hBGjIaWpaa9ORinUe73WPg2loh7KeEGGqSQSuXG7RuY48mtt2r0D
         MOe1g1Mi7AWud5pEdnhHmu522CW/x/rm2iUAPu31XA+2JWfwUuXdBCozlsL4g3TBnvc8
         qyjw==
X-Gm-Message-State: AOAM530pvhqRTyrSU0ERmXgux/aV6HCRanczkxHJACaTMmywHaCdHAXL
	n1WJO5adgFSSW+/dCPYMMsz/POdbeEgFasB7J1g=
X-Google-Smtp-Source: ABdhPJw7hTlWKNrt5vIfOGbnC/SB4bE9ZimWQvFFutwM3oan19pRKfMfBIQ2pAToGQu0hEKfl6xDAQ==
X-Received: by 2002:a17:903:2405:b0:153:31a5:d027 with SMTP id e5-20020a170903240500b0015331a5d027mr3665001plo.122.1647501244948;
        Thu, 17 Mar 2022 00:14:04 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id on15-20020a17090b1d0f00b001bfa3e36086sm9248557pjb.54.2022.03.17.00.14.04
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 00:14:04 -0700 (PDT)
Message-ID: <6232dfbc.1c69fb81.e8dc7.74a1@mx.google.com>
Date: Thu, 17 Mar 2022 00:14:04 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4.302-cip68-19-gcfdd1ea3a7ba
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 4 runs, 4 regressions (v4.4.302-cip68-19-gcfdd1ea3a7ba) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-timers: 4 runs, 4 regressions (v4.4.302-=
cip68-19-gcfdd1ea3a7ba)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip68-19-gcfdd1ea3a7ba/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip68-19-gcfdd1ea3a7ba
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      cfdd1ea3a7bab80ea3e513f28e7aa423fedf5d61

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  67eccca54eb68a1bc91cf1f140fc43fa8085d8ed =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6232cfe2ea6c267af8b73942

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6232cfe2ea6c267af8b=
73943
        failing since 0 day (last pass: v4.19.233-cip69-1019-g2e5815777e975=
, first fail: v4.4.302-18-ga78419826225) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6232d0e5a2724309b5b73934

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6232d0e5a2724309b5b=
73935
        failing since 2 days (last pass: v5.10.100-cip2-319-g7182f5032311, =
first fail: v4.19.233-cip69-1019-g2e5815777e975) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6232d3efa2c1e855dbb7392c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6232d3efa2c1e855dbb=
7392d
        failing since 0 day (last pass: v4.19.233-cip69-1019-g2e5815777e975=
, first fail: v4.4.302-18-ga78419826225) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6232d6f0948d3c846fb7392c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6232d6f0948d3c846fb=
7392d
        failing since 0 day (last pass: v4.19.233-cip69-1019-g2e5815777e975=
, first fail: v4.4.302-18-ga78419826225) =

 =20

