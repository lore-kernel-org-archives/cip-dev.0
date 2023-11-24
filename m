Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E030C61DF7
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 12:59:47 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.134884.1700830781734669499
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Nov 2023 04:59:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=jSwY/0Df;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-27ff83feb29so1584330a91.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Nov 2023 04:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700830780; x=1701435580; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MiYTsxsyCFym9OQcNXVqb8k32GPJmIhMllzsrV6nM1I=;
        b=jSwY/0Df2X7smomz0zZngMjmNJ8jYRf4SNRgEd4zvWDutnbL+vJHSD1X12zLqjsxnJ
         l/m5QMoXVDJOY44E2jTp9+aXXGnEb6MMu9JYyNYWLrbNZTKBhiFdE+fFiWQsrx2BETlU
         khiBe3mCPe5oa0bny67gBdErvhEM2AcmlmFLHCHQJpoxXTUQHd9JVwPBVfjBjCjj+zOf
         GP35e7fNsnAFLdZ7pbZh1NMrkJjT2txj1A4QBV2Es56QKT13LmwbGuI6gh4L83dNl9Sh
         d46JLo2+uM+L4rVzZeqrs0KgcXDBXGiuH5atKY3VjHprZTNBCIn1+wNtOS96o1Mk4+7X
         1iTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700830780; x=1701435580;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MiYTsxsyCFym9OQcNXVqb8k32GPJmIhMllzsrV6nM1I=;
        b=pT82B2vpwS4t11oU42P4rW/Am0L0CRGtnyFr40xLue2fM2OWVtX1eC6G1IuyBK9Ly6
         DzPbAozRX3GpdKke5NEeWcW396zFMgU66kereXOIG/sC6NGACo8p2VxCNRy1NS+2N7Db
         otYmDc37QVh+47ju6kbm3myJw4x8DHWIONQCap7V6IJtobKjDWB9ycKc8TBVDOU7vrDM
         675MKOi9MOc0C3w2o8hGaDiG9a0sXHSC5waOP1FKkSkvDqydAnY+6asAsfEtP35E4ttA
         uh0Wat01nlauC8/2q04w/D+La0EJRPHPvZslGGO+GIQ7moEZGxf+MYOW7x0P7MLUWVcN
         Z5fA==
X-Gm-Message-State: AOJu0YwiIuPLQ5JZ9Y35Veop9y+H/jQKUmadb2EFIGzWwjNyVjAGKdxl
	mslq4DUFPv2s/2rSdpMYtemozwZNr4eHGqKfIZA=
X-Google-Smtp-Source: AGHT+IGuQUxOfhbGnLqtDKPLiayCm/f+T4k7z4VGUT9n8rkX676SVQVnHrYU4QeZvbgsdKH8HfCsAA==
X-Received: by 2002:a17:90b:4d8b:b0:280:65ed:df9 with SMTP id oj11-20020a17090b4d8b00b0028065ed0df9mr3053343pjb.31.1700830780202;
        Fri, 24 Nov 2023 04:59:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z15-20020a17090abd8f00b00285771a0086sm2041608pjr.13.2023.11.24.04.59.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 04:59:39 -0800 (PST)
Message-ID: <65609e3b.170a0220.85b26.4964@mx.google.com>
Date: Fri, 24 Nov 2023 04:59:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v6.1.62-cip9-12-g3a5321f469b07
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 12 runs,
 2 regressions (v6.1.62-cip9-12-g3a5321f469b07)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 12:59:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13742

cip-gitlab/ci/pavel/linux-test kselftest-futex: 12 runs, 2 regressions (v6.=
1.62-cip9-12-g3a5321f469b07)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =

beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.62-cip9-12-g3a5321f469b07/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.62-cip9-12-g3a5321f469b07
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3a5321f469b07e6124d325d7faaa2f8f1993f67c =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/656090755fffa02b337e4a88

  Results:     24 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm/multi_v7_defconfig/gcc-10/lab-broonie/k=
selftest-futex-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm/multi_v7_defconfig/gcc-10/lab-broonie/k=
selftest-futex-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-futex.futex_run_sh: https://kernelci.org/test/case/id/6560907=
55fffa02b337e4a8a
        new failure (last pass: v5.10.201-rt98-828-g27523c64bc5dd) =

 =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/6560937a6c7e60990b7e4a6f

  Results:     24 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm/multi_v7_defconfig/gcc-10/lab-cip/kself=
test-futex-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm/multi_v7_defconfig/gcc-10/lab-cip/kself=
test-futex-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-futex.futex_run_sh: https://kernelci.org/test/case/id/6560937=
a6c7e60990b7e4a71
        new failure (last pass: v5.10.201-rt98-828-g27523c64bc5dd) =

 =20

