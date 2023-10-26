Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54AFC25B72
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 14:42:47 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web11.72574.1698331366122996800
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 26 Oct 2023 07:42:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=sTnBV4FG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1c9bf22fe05so7452485ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 26 Oct 2023 07:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698331365; x=1698936165; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WH/ad5Ci91MUKnMn8M7hDvYL3mcKQx9ClW7qwfgvysk=;
        b=sTnBV4FGbLuBGrqChdRwdZYiMuCc5wG8I7/f3oaXHOz+B5Lfr+Nizln/nbso3MuToZ
         OYFwYIMtNmw3X9sDTVsHjTp091MsGC6oMa5P+NRHT+X3x2pl/byPqnXayXDcH+b8hUyr
         rwusShlWodtFOdkZgVRfz4hLhoyohFRo/RsqcZ6OtrujuzV/k+D27YDMZxn5Mnq1sVv6
         wwbhObjY2+mY+XjGNkQ6U9hgV1VwXfhTrKq1DYZZiTh9spBRraGid0T4Nk0tYeo4YdL5
         ilpRF0j2pKVVGpDCdVcW2O3uwJZ6IjMnZKJt1pI4bpe04y+vliDZDOwqDRSwYgN10zWa
         jsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698331365; x=1698936165;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WH/ad5Ci91MUKnMn8M7hDvYL3mcKQx9ClW7qwfgvysk=;
        b=QUJ8blgxDrNesotm4DTbfhwCJLyevYY/aAEhUWoDP+PyFAxIb/9IQ6mtbBbiurU8zq
         3yg/6BjOlkZehNw1gAGPJ5mFaNhwfOcGw0ymhxnW81a2kEXdtaA5G9L7pFJrY8dS86aL
         MPJs67lv5HbN1eT33v09/4YI1zuFGiAwlUWhtHFwUtkx3qbrVEm7t5AVnYO8niTVMIR4
         hDh2RZs0VJLn2IRASAgp+NjlwvhfnW3BXGWgxR8wro8/qBpMRarvatpYFHW+Bbepk1BN
         qXIJk/3zeZSmzOGT+ib8+gVFObZoTH9A2iQi4oRJd4Q6LK8LrC+1fRUN3Ghk8Eygdp7V
         dAVw==
X-Gm-Message-State: AOJu0YwnUTTmRhKdBx9XHj8eY2IGcNkNyQMdFf2TJcr5/77mnZfMvfQx
	uGboym5lT0u88M2eVO4SpGz3huS7bn81h/v1MPc=
X-Google-Smtp-Source: AGHT+IFpe5ZxNvYMKL3ebpbemGMenOn5BO9yyEU/khdDm1hXjm9JKm+C0CUR26OQDOnvcgaLVSEnnA==
X-Received: by 2002:a17:902:c950:b0:1c9:9e33:3a7d with SMTP id i16-20020a170902c95000b001c99e333a7dmr17172090pla.20.1698331365009;
        Thu, 26 Oct 2023 07:42:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y3-20020a170902ed4300b001b9dab0397bsm11090480plb.29.2023.10.26.07.42.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 07:42:42 -0700 (PDT)
Message-ID: <653a7ae2.170a0220.4fa05.5463@mx.google.com>
Date: Thu, 26 Oct 2023 07:42:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-3596-g73e7f2b880d98
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs,
 3 regressions (v4.4-st20-3596-g73e7f2b880d98)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Oct 2023 14:42:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13470

cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs, 3 regressions (v4.4-st20-35=
96-g73e7f2b880d98)

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
nux-test/kernel/v4.4-st20-3596-g73e7f2b880d98/plan/ltp-pty/

  Test:     ltp-pty
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


  Details:     https://kernelci.org/test/plan/id/653a6d582390348f80efcf14

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/653a6d582390348f80efcf=
15
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e7ebc7956decfefcf0f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/653a6e7ebc7956decfefcf=
10
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a70716259dcd859efcef7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/ltp-pty-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/ltp-pty-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/653a70716259dcd859efce=
f8
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =20

