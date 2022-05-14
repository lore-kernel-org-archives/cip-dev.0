X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web09.3825.1652514671988268852
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 14 May 2022 00:51:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=bRK0dBvL;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id n18so9989645plg.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 14 May 2022 00:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=SbdQ+uuWKANWgODnay77qDDnKUA2UP2e55CnBcM1qgc=;
        b=bRK0dBvL4w14t0IQXUaA0TYOmnmn2xlgX4pBuE4zL1xZZ0mwJXlpQIdezuxZUWR7Y/
         ptuzQ734r5I5hDnENQJOjTC1WnLtsxSuE7rO3WWG0IGDgaBdJqErtmc3BXV1BQseC2Lk
         69qEVnz8wQ4IkddUOoHdIAUg4y16sPgXOb64c1SY0cPNr5QXK1gGdt8D5rzBZTX4HyOi
         4lcbTQQMJILFeOjvCC6vbhsrKbHdfASjdHeD1skQddBuDdghwP16btS4P7EAS15Kcm3W
         KmeyxL7r3/wT2nRGJW7+ztI8R6ERVnUK5wiZ+YZqChqO4jqEcNdzea+Ly5MEl6rmmBsJ
         Qgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=SbdQ+uuWKANWgODnay77qDDnKUA2UP2e55CnBcM1qgc=;
        b=cHwISHw1wJbZMLerqMPgVpCEgIqZZGFPAgvgL8IuxToc0mewngFXyrrSBd2cD8jbKL
         4e5N5S6TImVLRHwE1S97ZQkLdTFFPOJ2vVmH9aWcNRdneDY/iN7NkV+7RrOczZvxxaTs
         CwQQ2yutlTOwhrKIlVSnM3C9BvCkYaAeV0tpHlvTU/dn0IW772Q6RWQ3K3kEOogsdcOI
         wU0VMA2KKabxtYWllXgBMoOjGQdrpFNx0yP16rnS2vxTTOS1Sgp21oNbVPRL1uVL7HWR
         nuddy8zB/gWlg05CjiP4Wb+2QePvaVfYIJ/MOlIcKPIMI3j4qR66pYl+utqBG8JtiOBU
         tdsw==
X-Gm-Message-State: AOAM530BPURsKK3vhWmfZ68PbAAzC+otpRJWC45qM8FY3b+sOIzg26DZ
	JTqZkxzIUb04xMj6L/Jx0X+UlaXkHA/8enFLRQI=
X-Google-Smtp-Source: ABdhPJxM2DO8kS3X4g0yyXCgHba3IXh4izhKWsap0zBa4wLMuI2A/2kiEGAcaGyYMQ7Q1y8XcZogUw==
X-Received: by 2002:a17:902:e054:b0:15c:ed0d:f13f with SMTP id x20-20020a170902e05400b0015ced0df13fmr8425322plx.76.1652514671293;
        Sat, 14 May 2022 00:51:11 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a6-20020a624d06000000b0050dc76281e2sm2917855pfb.188.2022.05.14.00.51.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 00:51:10 -0700 (PDT)
Message-ID: <627f5f6e.1c69fb81.c7918.7bef@mx.google.com>
Date: Sat, 14 May 2022 00:51:10 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4.302-cip69-50-gba851b77071ca
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 7 runs, 5 regressions (v4.4.302-cip69-50-gba851b77071ca) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-ipc: 7 runs, 5 regressions (v4.4.302-cip=
69-50-gba851b77071ca)

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
nux-test/kernel/v4.4.302-cip69-50-gba851b77071ca/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip69-50-gba851b77071ca
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ba851b77071ca2f6d6a35b5758aa276c8af6306d

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
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627f52d62fcc54117b8f5717

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/627f52d62fcc54117b8f57=
18
        failing since 2 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627f5121255e90895f8f5786

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-ipc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-ipc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/627f5121255e90895f8f57=
87
        failing since 2 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627f5159cfd3c3a2858f5717

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-ipc-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-ipc-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/627f5159cfd3c3a2858f57=
18
        failing since 2 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627f5066ee2cd98d3c8f573e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-ipc-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-ipc-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/627f5066ee2cd98d3c8f57=
3f
        failing since 2 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627f517bcfd3c3a2858f5734

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-ipc-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-ipc-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/627f517bcfd3c3a2858f57=
35
        failing since 2 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

