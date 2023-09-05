Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEF5CCF9E5
	for <webhook@archiver.kernel.org>; Tue,  5 Sep 2023 23:21:56 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.37291.1693956106280326047
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Sep 2023 16:21:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=EzMzeGKx;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1c0db66af1bso16375825ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 05 Sep 2023 16:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693956105; x=1694560905; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lJ4DcCp9T98PBAAy4dASgZcRNi9cKWXkKdslp3Tb6Mw=;
        b=EzMzeGKx6JiG/ePdAYy4zThWQjMqlH1MPZ9g9gL3L43X2igi6wRYJX2er/ACsGUmDI
         sgIcHpvGcycsO8SLnD0JcB7cmFiC70wFm3049lJWINU/izd6sVe7eaoySGEu/ngEvzmB
         I7C2T0XAL6zl5i/4k4rzQZTw2RvLwhQlOd24R9XVnFjm01187PX8HJ7j6/MXzJKxTKyr
         AZo/tK4NDA73uFp75d1XOMf1SA66gwPCkLQhKjz0bfzl1inAvsIC4OmKYHEPgvD1k+SG
         TvkfP1HzdpqfZoXxA3w61tjcpZtWI+wmWwhHABMFqxqCyz7EEjx1dw9ga3w1Kf+dtzli
         FZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693956105; x=1694560905;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJ4DcCp9T98PBAAy4dASgZcRNi9cKWXkKdslp3Tb6Mw=;
        b=Kx0/FfkuSoQEn02tSm8yrQQxYRwNCoXjnwbMuziIwL4dbQes4IT631wpGw624vcZuw
         L4PS3avz8Haf2/yOfFR8+9uPLgDbf5wAaJqQct9oT2YvNR7GXAifUIeoIBaoBOhTTB/H
         4Tu6KYDtJyMoDorVC6Qs3R6A3mSFCZ/LH2ZE7ssf2np0YvSH3vgbu8UsVszNVmUWHSef
         MJZPvmNX7y4WE+Jn+NXcg3qfPD8377VoWxVB3ov9k5dDy/FndLQguqacvbT6MXrTmvNL
         aTBhTHPeD2s/J0DdMka8K/TM+JF2VI5XCXse6vCvS8mWLnWth8IMb9COsmvepxYhV1qt
         9t5w==
X-Gm-Message-State: AOJu0Yy+NXsfID9T2dIeCRCE+vs50NUIcaAMkrSmfB0N3nOF8SChqUb0
	AmPh8M41iYuikB06oSOV6LY4tOgk6VgB0wlUsrg=
X-Google-Smtp-Source: AGHT+IFIXxajkiHHEzU2oz3rPs1I13hn25lGvJ7yhNjckXLbURBX5cWEODRo5yDwPJZrbEq4ePMT0g==
X-Received: by 2002:a17:902:c109:b0:1b8:c6:ec8f with SMTP id 9-20020a170902c10900b001b800c6ec8fmr10234811pli.46.1693956105189;
        Tue, 05 Sep 2023 16:21:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bd10-20020a170902830a00b001bd99fd1114sm9802560plb.288.2023.09.05.16.21.44
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 16:21:44 -0700 (PDT)
Message-ID: <64f7b808.170a0220.ce1c5.4d8d@mx.google.com>
Date: Tue, 05 Sep 2023 16:21:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.46-cip4-14-gb994de8f45440
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs,
 2 regressions (v6.1.46-cip4-14-gb994de8f45440)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Sep 2023 23:21:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12966

cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs, 2 regressions (v6.1.46-c=
ip4-14-gb994de8f45440)

Regressions Summary
-------------------

platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.46-cip4-14-gb994de8f45440/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.46-cip4-14-gb994de8f45440
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b994de8f45440fdf9186ead9b3a13945833c1547

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64f7ae731188222c88286d7b

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/riscv/defconfig/gcc-10/lab-broonie/ltp-time=
rs-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/riscv/defconfig/gcc-10/lab-broonie/ltp-time=
rs-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64f7ae73118=
8222c88286d80
        failing since 92 days (last pass: v6.1.26-1298-g61395b9756bd5, firs=
t fail: v5.10.180-cip34-26-gc198172c84b6a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64f7ae73118=
8222c88286d80
        failing since 92 days (last pass: v6.1.26-1298-g61395b9756bd5, firs=
t fail: v5.10.180-cip34-26-gc198172c84b6a) =

 =20

