Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF77C25B48
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 14:42:47 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.202189.1698331364167311416
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 26 Oct 2023 07:42:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=HP1pjgw9;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6b89ab5ddb7so983514b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 26 Oct 2023 07:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698331363; x=1698936163; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G5nxpfp7B1iBHnMddrEYMMrbEVxfXrShoanDg58ErQM=;
        b=HP1pjgw94LUWib0Vj+u+OYLNRdUZ9mycJKgxJC8Rdui7bTvo7z45nX9EmJXKq0mcNW
         ApsYJg76kdBptduGATumSseSV7dR1+CJw+cg1w1Pw9tco48yOHKqyi3B7MnUgVtVOLuV
         zKc3cOupcilyGYfquWxKAqUfwsA0TGZrwxuRO91oGl2zm8djdFop3WVVQwnG10EdHatJ
         +nuCJ6xXwoYNiSzdJ8M4Ezd5NPhSjQ/YjVSRtsU2hX5/fmYW2VVNnsasPzIc9M33IIos
         +yfylSlQVOxFpkz24mL7PgQZr+ecPpRVStPGLDdVkQV8cl3rF9adS6xxY3OKtB4q4gWB
         flIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698331363; x=1698936163;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5nxpfp7B1iBHnMddrEYMMrbEVxfXrShoanDg58ErQM=;
        b=jL9Kkb6cXyvKIGY6Uh3HFdfpqGgMspxScjX1hcZhqwziU9h2V3y4afSRcjbJ+J7c9h
         zLou+VyS5X+xi51RYkqFrn79T8j5pM4FQ0V93PnA/LLqHrthyoibrPXWl0oslxefdHyM
         o+ZHiWnnsriN5FJ7g/L/2JhRm+8mTSoSt0liv2mEbgVqmqHKgehMrLDFMFHu2VPn8i+O
         8QczvXCNz2uTVbIwLKEgqCPLy2zdzkln0NmFKgI/NbLcqDd3UHLMUaPwdb21Lfhc8RMv
         j+ab41C7cRt3z3nMZEZd5jov6KHsbqkPh/JEB1RcEfrFXlhdM0ZDshqsDet7xppricSd
         nhPQ==
X-Gm-Message-State: AOJu0Yyo1onj/eD64tU9Tg+3L4eWe5RJruEqXr1G8xEFdExxf1Xv9zoi
	8W2Lh/1RwRZhHoF1lZltBCGfUlJyT0ZpJqI5gEw=
X-Google-Smtp-Source: AGHT+IHXAvbI+1yIR6kSVyy+HpFIvxRhgE0+UZz+oh0qTSNSt6kBLlVVjxPncWUhQDRxbi3fl579Xw==
X-Received: by 2002:a05:6a00:194a:b0:690:1857:3349 with SMTP id s10-20020a056a00194a00b0069018573349mr21258056pfk.25.1698331362847;
        Thu, 26 Oct 2023 07:42:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x21-20020a63cc15000000b005b9288d51f0sm1474395pgf.48.2023.10.26.07.42.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 07:42:41 -0700 (PDT)
Message-ID: <653a7ae1.630a0220.751be.4c83@mx.google.com>
Date: Thu, 26 Oct 2023 07:42:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-3596-g73e7f2b880d98
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs,
 3 regressions (v4.4-st20-3596-g73e7f2b880d98)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Oct 2023 14:42:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13468

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs, 3 regressions (=
v4.4-st20-3596-g73e7f2b880d98)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-3596-g73e7f2b880d98/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-3596-g73e7f2b880d98
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      73e7f2b880d98bcbacb997959b6c7b220f7fe382

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6da5ba13f7038befcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/653a6da5ba=
13f7038befcef4
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6dee868d7366aeefcf0e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/653a6dee86=
8d7366aeefcf0f
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6ebfef17398d59efcef5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/653a6ebfef=
17398d59efcef6
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =20

