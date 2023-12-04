Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58BCC10DC3
	for <webhook@archiver.kernel.org>; Mon,  4 Dec 2023 00:34:37 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.53223.1701650071894823528
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 03 Dec 2023 16:34:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=hSitk3ro;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1cfc9c4acb6so13034565ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 03 Dec 2023 16:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701650070; x=1702254870; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/+7sC00pjyDiJVAm6vZMngw7cofgbiWJSA3jRYbBL78=;
        b=hSitk3roW26Seu65xbRMGLYAZR7u+cXXpXVtCH1CnOurwIucF0DC3PmE5F7FP2HPcI
         iJvZSnRS4fJqM7n4ipyhJTd9JwIx5ywhfO9I/H+9WfW7gs9BFJqBFB2CuIpKNRshl8x9
         ZOM7HbNMYoHfAkNxws4LEuFSJ5J7F+CtnKz1+KyQEWHqDrTR/NrktW6gl0bdkonY+CG4
         EoRFjdU42a13TRO/AOTuljsQBhHBlUQiKbQMGTo/cgX3FqSIZ9EKj3LAE4GG4ygiBPX1
         24jGJ4UFtYpEOl8neGN5R9X4pnr1AKsdgFuthJ/jZTSWcRx5BJc71y5fUWWQZmGAMXsC
         Aihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701650070; x=1702254870;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+7sC00pjyDiJVAm6vZMngw7cofgbiWJSA3jRYbBL78=;
        b=DvtHSAaOEuUF9e8N30QGqhTBoGbX0tmNv4qtvvuo5p0AYTkRqS7R6GlWoysS+2XRLq
         aDs8yPM0QPVrLjVPDtgGVF5aIgaXNeHS5Xynp2PKDQ+LnoyVru+1eNXrDnVTJQN5cgtS
         8vqg9JxbGsS4tyNWElUoPmgBbheMc8QbqXi9Qs2E7gn9eb0sM7i7a53xaWYcHuuFcHYI
         ptJSyEVXkCDd9ZYrKjvqBVyi6VC60VbhSiHoN8K1NsRxMKgO30Ab5YLZlfVJp9fJHrZq
         EY3G5X6R/mCKS1wW84rDQMfmdykQihj29zgJKpYazDV+rae8xwGEWLhanaZk+0uZurgQ
         dX9A==
X-Gm-Message-State: AOJu0YykeUWeabcCvlARSW5ckAr1Dsf8/YJF3XOVfML4JisueEeTQSWJ
	rwso9fhi6IXHVQc5jEGeprKgPFtRK6O8UljmQdRrcw==
X-Google-Smtp-Source: AGHT+IHXuFcfBXit6WVGN+NPEzMOuQN2xf/nBTfnhqOGDxsXjDfu8tSrRudJZCKRLicLcnbJ/a0sqg==
X-Received: by 2002:a17:902:e5cb:b0:1d0:6ffd:6e7c with SMTP id u11-20020a170902e5cb00b001d06ffd6e7cmr1191965plf.116.1701650070463;
        Sun, 03 Dec 2023 16:34:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ay8-20020a1709028b8800b001cfc44aac0fsm7163765plb.111.2023.12.03.16.34.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 16:34:30 -0800 (PST)
Message-ID: <656d1e96.170a0220.539ae.3eb1@mx.google.com>
Date: Sun, 03 Dec 2023 16:34:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.64-cip10-rt5
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 15 runs,
 2 regressions (v6.1.64-cip10-rt5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Dec 2023 00:34:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13784

cip-gitlab/ci/pavel/linux-test ltp-timers: 15 runs, 2 regressions (v6.1.64-=
cip10-rt5)

Regressions Summary
-------------------

platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.64-cip10-rt5/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.64-cip10-rt5
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b0295fc12bdaf65b61b93e18a316c8e20c1f2507

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/656d0a5cbe808597cce134aa

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_riscv=
64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_riscv=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/656d0a5cbe8=
08597cce134af
        failing since 9 days (last pass: v6.1.62-cip9-13-g34c303883a305, fi=
rst fail: v5.10.201-rt98-828-g27523c64bc5dd) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/656d0a5cbe8=
08597cce134af
        failing since 9 days (last pass: v6.1.62-cip9-13-g34c303883a305, fi=
rst fail: v5.10.201-rt98-828-g27523c64bc5dd) =

 =20

