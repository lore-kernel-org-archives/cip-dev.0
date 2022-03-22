X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web09.6461.1647928251486642346
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 21 Mar 2022 22:50:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=vp0n+E7x;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id s8so17283341pfk.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 21 Mar 2022 22:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Y5bWBzk/Lwa3C9jFPEKIQzrqmdPzq3/JyjD5+spl1NU=;
        b=vp0n+E7xF6ReEuuLaeoicbGkOm/qdXHqp45D3yMsnlmxwgm3OCH7wwy3oiaBzcpOjW
         LL739Bx440K4mh7dOW7ZVbrPs/yNPOV4jvwvwkcKHHMd10FYaw4y+8eMtqG+eBPajVi7
         iYxWqtLivYdGyT0JsYe5IfNLVxMrCxVZFCbpK3z7WM9m/tGNAduU8RpgkIYv6WQFAr3Y
         C9C64qty4/QR/05+8kmAjBiPz9UgTFdeRSInuQZYaHW8h7xZos9lQMBZCJlWBsXMyEJb
         gJujM9JH/oNpu5FRIa8wh4ssHGXpCIa9a0yP7xBQkz0rjsCqSYpi21kSJW0mULhahXDR
         co1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Y5bWBzk/Lwa3C9jFPEKIQzrqmdPzq3/JyjD5+spl1NU=;
        b=mC1yaI1LdvdAqScUstqCGOSdiyL+hvrs5IhrujDF5fG5wfbjdF4/GHVnID/CzH/Mkf
         xrvCQdwRmnuaoPe7exJdNFCOgbIG5xkkNZzV4w0NziIDPa0jejcP4gXGU/HJHs6rqurd
         P5hGrlcpVj9DbvqRpXOTJ2HWA89s+diRWW39LDHsoF5ELXV+o1NV0e2BR7v9csLXPvYw
         p8uVTbhI2mmbkenixI3ghUWLqpz7umtppRVeFQF1t0NXS/ShJ/xNIeAZUJg3aXP+d673
         WcdbI73Rwz7yomrA1lCCPQp52D8KM9sU0oIb6ecCB4MSi4p+J4+vQICW8oZl0v9xbSz+
         oHWA==
X-Gm-Message-State: AOAM533yM3rNmDF/dm9UVUmQe1jC89q5Gvon5cqHMC/bckTqwwWl+qan
	x06yxllzProuZ91cANaIW/gxi61MEypfDTPP31M=
X-Google-Smtp-Source: ABdhPJyZbpmEUX/w0x1iKFVmJ62gWAffgz3mmnIreb/l6fKhsKMfqBY8ApoNOa7mcy1V4g6hl7mDTw==
X-Received: by 2002:a62:5343:0:b0:4f7:baad:5c22 with SMTP id h64-20020a625343000000b004f7baad5c22mr27217344pfb.30.1647928250826;
        Mon, 21 Mar 2022 22:50:50 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090a2b8a00b001c6594e5ddcsm1197209pjd.15.2022.03.21.22.50.50
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 22:50:50 -0700 (PDT)
Message-ID: <623963ba.1c69fb81.b8537.49b5@mx.google.com>
Date: Mon, 21 Mar 2022 22:50:50 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip68-128-g4031bdd82383
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 4 runs, 4 regressions (v4.4.302-cip68-128-g4031bdd82383) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-mm: 4 runs, 4 regressions (v4.4.302-cip6=
8-128-g4031bdd82383)

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
nux-test/kernel/v4.4.302-cip68-128-g4031bdd82383/plan/ltp-mm/

  Test:     ltp-mm
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
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/623956b3209e24e7992172d7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/623956b3209e24e7992172d8
        failing since 7 days (last pass: v5.10.100-cip2-319-g7182f5032311, =
first fail: v4.19.233-cip69-1019-g2e5815777e975) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62395636e29546bd582172d1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62395636e29546bd582172d2
        failing since 5 days (last pass: v4.19.233-cip69-1019-g2e5815777e97=
5, first fail: v4.4.302-18-ga78419826225) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/623955ccfb2965ce2f2172fc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/623955ccfb2965ce2f2172fd
        failing since 5 days (last pass: v4.19.233-cip69-1019-g2e5815777e97=
5, first fail: v4.4.302-18-ga78419826225) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/623956e36fd7d24de0217337

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-mm-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-mm-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/623956e36fd7d24de0217338
        failing since 5 days (last pass: v4.19.233-cip69-1019-g2e5815777e97=
5, first fail: v4.4.302-18-ga78419826225) =

 =20

