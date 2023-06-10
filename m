Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616CAC7EE2F
	for <webhook@archiver.kernel.org>; Sat, 10 Jun 2023 11:24:59 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web10.15728.1686396291256471166
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 10 Jun 2023 04:24:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Mm0MJZ05;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1b0314f057cso13966415ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 10 Jun 2023 04:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686396290; x=1688988290;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nln9h8LbUzJzy3VoOObRmICxeKtE265HPRrsSrxwzv0=;
        b=Mm0MJZ05WFS5Ahwp4hZaLiYjKgGr/oMAa5zrbYr9umGvD5g0JlRKdMWF9+V0I0hRrS
         le19rZP8BI3jmjZnasdMGb+MsFgbjRZOH2lfLydHWnhII5tmgmDQkF/3Q8F4So0gvR7q
         mXEoFIXLHqaUNVFUioDka//uM0kHCI2p/kECMiTn1+79S2HW1JwmvRBC4vdb1UrSRkOS
         OLxCyz0uo/exaFmiluia2xQ4TE0nUzVlwyju21UrKWlIVXjwDvLSo7hwctIoQ25Sxzdp
         Ku76StXNYB5eqR26icXHI+XdmuuAxx6nMVKEOJ7cFekUj8IY19UpN06pHCHKNRLWy2TE
         jKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686396290; x=1688988290;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nln9h8LbUzJzy3VoOObRmICxeKtE265HPRrsSrxwzv0=;
        b=NxS98NEcjiwP2Tn6Q/VJm59lhxnTaHXEyxqilCx1Oi2Or/BtnnXkRaxo84rZ3ybx2u
         /D4MJwZ+fXJjBWWu3x3C/ouYCTrgzv9g6Qtli3nzIW3ceXjGyY7+TCtihPz//7k1qede
         4j076SUGlIIw23jbV1X5QClIomqDI7irYmBr8QasGU8QJe7jyjKqTKZHFbDVLOUUkbOc
         S7wOR7mxkI1bKUQaPQ1e8XFd0M1KlY3CiKBjyXZL69QMOmt2UCf3F2j6m0pkBOIEcJyq
         JT3t0FxCcmN/SDlwCS7Bg6QLbkMatqBJJrv88U5Cjt+arh7u+5GrKVu1YdLDveNLPLHL
         zZnw==
X-Gm-Message-State: AC+VfDwSm5pH3ougUpA20/iS3aa9tBZICpK15QIzTw25f/7bnBHkOL69
	OLaiwBkW/zhzWF/LhknGghNsqUoE1okd0LIeiuGZ7g==
X-Google-Smtp-Source: ACHHUZ4jFeaT+Rs1E1fLJ2k7cWGxIK7Ye8QJDg6q0MUOu3cMlQCuIYo4Eui8YbTgk+jBzUUZc8N2QA==
X-Received: by 2002:a17:902:8c84:b0:1b1:a2c3:29c0 with SMTP id t4-20020a1709028c8400b001b1a2c329c0mr1450024plo.24.1686396290199;
        Sat, 10 Jun 2023 04:24:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z20-20020a170902ee1400b00194d14d8e54sm4775440plb.96.2023.06.10.04.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 04:24:49 -0700 (PDT)
Message-ID: <64845d81.170a0220.65f40.9611@mx.google.com>
Date: Sat, 10 Jun 2023 04:24:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.31-45-gce658d9231044
Subject: cip/linux-6.1.y-cip ltp-timers: 14 runs,
 4 regressions (v6.1.31-45-gce658d9231044)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 10 Jun 2023 11:24:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11967

cip/linux-6.1.y-cip ltp-timers: 14 runs, 4 regressions (v6.1.31-45-gce658d9=
231044)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 2          =

qemu_x86_64            | x86_64 | lab-collabora | gcc-10   | x86_64_defconf=
ig             | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.31-45-gce658d9231044/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.31-45-gce658d9231044
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      ce658d9231044091c42896a08fbbfad40ebc58ce

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64844eadf2910171e4306201

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-45=
-gce658d9231044/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-45=
-gce658d9231044/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64844eadf29=
10171e4306206
        failing since 4 days (last pass: v6.1.26-1281-g84d5372e0f314, first=
 fail: v6.1.26-1314-g1ab0ac1d7e2e3) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64844eadf29=
10171e4306206
        failing since 4 days (last pass: v6.1.26-1281-g84d5372e0f314, first=
 fail: v6.1.26-1314-g1ab0ac1d7e2e3) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
qemu_x86_64            | x86_64 | lab-collabora | gcc-10   | x86_64_defconf=
ig             | 2          =


  Details:     https://kernelci.org/test/plan/id/64844ca372a4e8e4a630616d

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-45=
-gce658d9231044/x86_64/x86_64_defconfig/gcc-10/lab-collabora/ltp-timers-qem=
u_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-45=
-gce658d9231044/x86_64/x86_64_defconfig/gcc-10/lab-collabora/ltp-timers-qem=
u_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64844ca372a=
4e8e4a6306172
        failing since 4 days (last pass: v6.1.26-1281-g84d5372e0f314, first=
 fail: v6.1.26-1298-g61395b9756bd5) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64844ca372a=
4e8e4a6306172
        failing since 4 days (last pass: v6.1.26-1281-g84d5372e0f314, first=
 fail: v6.1.26-1298-g61395b9756bd5) =

 =20

