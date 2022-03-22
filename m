X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web12.6434.1647928252279623462
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 21 Mar 2022 22:50:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=RmII+LsP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id u17so17288911pfk.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 21 Mar 2022 22:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=sVXHYkV+lThH9R0m7aL8d3JEf5wtBzHbqU8SyCFntJY=;
        b=RmII+LsPLQW+xUI/izrAwPz87Ojhw0Ayd8EHNJbP3Fx0wWsZBoLPeFecjVTX8DlSby
         9wD1VlxPCB2OlFDvwjSiN7pFaAAya48WgFH3DroSv2xlZywdcSRmHx0mrNI2xFiWfNdZ
         GIKvV3/NXWIb84ZnH6utJwFdw7XmUk3OPiJFvJ5zWKqkhR3skAzitxvER1jVFLHUoCsW
         O6kA7PJiGLUxM0gaFrZcPGSEItb2X8Xla46/tA8RETIFdmKiPcgH8BlKtvIx3EzzYeUy
         nPQqkgPZaQcewfIknJekgJ6iIWZNkcXBnJHP1ps6VRtiFsz4cijrPKzbiUwJoM/3xK/5
         vxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=sVXHYkV+lThH9R0m7aL8d3JEf5wtBzHbqU8SyCFntJY=;
        b=DkbIP3VE/Hms/i9KEiAYZgG1NQZsP+noKieBmeCryHj11r0FIpvmxEi6T8TwxP7RE2
         manUdh0uujr8PvzyG8b7Jhr/tWr18C/ZoBU1bQ5n1N7D7KKoch7scla5YVWR2j9AlMv7
         oK0FrUQkgGgCApkQdf5AEpWbfFqkDdKu0LMVqWDadWfoxpcTpivmcoOwIO3ZkKbj37CH
         IxBifGq8a2hOC3n/yLoFONYlQASl/cBpVARuVRPoZXUMz9lB19l325q3cEmTs/68+3pX
         8qrW/GrCHxtLU0Fua0UOvsVJmUAEOebGdMGgJxu9lhkgQ3z6GeTB2o5SYssJA8mc9v9P
         lFLQ==
X-Gm-Message-State: AOAM532X9KU5asv14aPRuMuqt4G88KYE3T7gBnbkSP1zUunNrbugr4Ph
	JtDgbxywiJdYkCmOXGdSWTs41BABoWx/HjY53Hg=
X-Google-Smtp-Source: ABdhPJyR1PMcSbmhNdH5t7ym+5DIXBNUNrUFh5Kw1Z/ASPsnK9wFGmpvXOr/PMKsfEf8fOlFoMjCwA==
X-Received: by 2002:a05:6a00:2355:b0:4fa:9cae:b3c9 with SMTP id j21-20020a056a00235500b004fa9caeb3c9mr9448414pfj.82.1647928251540;
        Mon, 21 Mar 2022 22:50:51 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b0038085c0a9d7sm16026750pgo.49.2022.03.21.22.50.50
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 22:50:50 -0700 (PDT)
Message-ID: <623963ba.1c69fb81.5db8.b776@mx.google.com>
Date: Mon, 21 Mar 2022 22:50:50 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip68-128-g4031bdd82383
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 4 runs, 4 regressions (v4.4.302-cip68-128-g4031bdd82383) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-timers: 4 runs, 4 regressions (v4.4.302-=
cip68-128-g4031bdd82383)

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
nux-test/kernel/v4.4.302-cip68-128-g4031bdd82383/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip68-128-g4031bdd82383
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4031bdd8238386ea87c992b18bc65b684bddc2d7

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
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/623955ab645f634c43217323

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/623955ab645f634c432=
17324
        failing since 5 days (last pass: v4.19.233-cip69-1019-g2e5815777e97=
5, first fail: v4.4.302-18-ga78419826225) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/623956b7098088d2ad2172bf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/623956b7098088d2ad2=
172c0
        failing since 7 days (last pass: v5.10.100-cip2-319-g7182f5032311, =
first fail: v4.19.233-cip69-1019-g2e5815777e975) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6239562d027bc5158c2172c2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6239562d027bc5158c2=
172c3
        failing since 5 days (last pass: v4.19.233-cip69-1019-g2e5815777e97=
5, first fail: v4.4.302-18-ga78419826225) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62395630b9feca5ca82172c5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62395630b9feca5ca82=
172c6
        failing since 5 days (last pass: v4.19.233-cip69-1019-g2e5815777e97=
5, first fail: v4.4.302-18-ga78419826225) =

 =20

