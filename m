Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC4BC7EE23
	for <webhook@archiver.kernel.org>; Wed,  7 Jun 2023 15:24:25 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web10.1003.1686151464835749969
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Jun 2023 08:24:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=R2/cAkii;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-256712e2be3so6419230a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Jun 2023 08:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686151463; x=1688743463;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8J697c+wwHR00QmHDUTRqyZo52HO1/VGRXIAt0HrEDk=;
        b=R2/cAkiiisWtKOcKwnbs5bzagLTJuJf7gohU8mrY1q5WUNYceQoe1skItBtMBwuQRG
         QF2cUgkikp1CFmAOviEpQtecguhJBOBlewkrJJe7c7AYXM2bU0WldNetNtuImLuaA3SL
         SUdhbO6tj8hCtrxlaFZ2yZBzBlx5MISUUe6dpj/NwjV+vRwSLS8eaHCOu3ZvSFdldgRc
         KreTtEKvrmL1ZEUTxoRrrVOWVJ3yVyG0aY1rOUgFo5k2zXemRyH/45tUJwxMqBjKaOb8
         laPGx+eYCdB8YTb16fLedM5au2QjgQYvrAZs8R7aalwh6gpjKUDV0eApKpVqmfMrQuTn
         x3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151463; x=1688743463;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8J697c+wwHR00QmHDUTRqyZo52HO1/VGRXIAt0HrEDk=;
        b=YVWI3DP7ygZOoAAIyeftSJsp/mFAViRGmAljSem1V4BczmB96V3So1P3i/0NLBdOIO
         0mtZAx6kvx+A6Y6moTvtprosqV7gGE0CQoL5rbiZnyES2De/cYNtXE9PZguD4jFkV4OT
         0arLSL6aShsULVryt536kSdFG/yx/3jbDPmHmAqVlfQgaA6kU3F+p3HMJxcwc0LMi4KF
         dIxheEo8ZW06Rr6Oovxm+3h0AT4pSk1FyxgIiw9AEvA2a5hd9sDylp6Y7ET+ZLS/tbsy
         4XXNinO/6AeI7HVnMZcMaYPyvrvmqN6c9R4dd47s4oovkZOnsA9f9im7FZoy8+VaQlfy
         ed8w==
X-Gm-Message-State: AC+VfDy+LDWeuNpBs2a49c2I1ZvHdjljIcQ3mplShoIypHmpoQkEPhm4
	TbhMsSPHB9BJtfJYlbSXSiyvG+PYAAeeCrwAHr+QSw==
X-Google-Smtp-Source: ACHHUZ4FA5EBtSS6LbFq/5EqwaBYGDjKD/XQnltzGcgYeprRhnx64bkSI4kqrOf0aexYB1b/PifrEw==
X-Received: by 2002:a17:90a:9bca:b0:255:8fd0:fbf4 with SMTP id b10-20020a17090a9bca00b002558fd0fbf4mr5641968pjw.5.1686151463465;
        Wed, 07 Jun 2023 08:24:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f2-20020a635102000000b0053efc8ac7e9sm3587305pgb.29.2023.06.07.08.24.21
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:24:21 -0700 (PDT)
Message-ID: <6480a125.630a0220.bf4c0.85cf@mx.google.com>
Date: Wed, 07 Jun 2023 08:24:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip74-rt43-218-g246f4be89a77
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs,
 3 regressions (v4.4.302-cip74-rt43-218-g246f4be89a77)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jun 2023 15:24:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11924

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs, 3 regressions (=
v4.4.302-cip74-rt43-218-g246f4be89a77)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip74-rt43-218-g246f4be89a77/plan/ltp-fcntl-lockte=
sts/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip74-rt43-218-g246f4be89a77
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      246f4be89a7760f90649094cbfabcccfce7dafd1

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64809100e24641cc2d30614a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/64809100e2=
4641cc2d30614b
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6480922cbbf37f0679306155

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6480922cbb=
f37f0679306156
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648093f348397a0624306150

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/648093f348=
397a0624306151
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =20

