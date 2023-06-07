Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEACC7EE2F
	for <webhook@archiver.kernel.org>; Wed,  7 Jun 2023 15:24:35 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web11.1046.1686151465618617685
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Jun 2023 08:24:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=sPD7WDpl;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2562cc85d3dso6072285a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Jun 2023 08:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686151464; x=1688743464;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j1eYJkqJW3ISEWu98iuRKeDgbVXDIoOdHTgR7EuG8Eo=;
        b=sPD7WDpltbGpiDYPt8uKbrd8EttcHezg8uwnqzSvJthaoe9hJlgbvJp6w4Sh53YJpZ
         L4AMb3EwDTmsbB6uecmxM23KZcb6mJhaCqjqrmTR4QS3yHDMf4eBNXstaEI/9MJrPSgt
         bQNMH+LSGp/BJpCAQU0SwZ99hkc96mEGyl0b4yPIJjfIu0iT/i+MWSdj93JfIsTkq1fJ
         XDRnCMODpC3qxk1kGEqgmJjrDY3c0U80YcMKyASX/d6SeYY7lLep/Z5UsGJW8mcQdIQ0
         u6uVwYsZK7I1qb6OQelYx6K1t321DGshZGINk5zrOLNZQbn0OQVH+R7uwrQJ7GRShM1z
         XsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151464; x=1688743464;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1eYJkqJW3ISEWu98iuRKeDgbVXDIoOdHTgR7EuG8Eo=;
        b=lTjk/6GVyhzMdIj7bfKvOOVc3T2bjNNU3C5H0fX97pBTaMBiVYPgg7Fw6I1u3lfQA4
         NEVa9+/FcaHHbQidAxDEjRgd6WEpYvUp9j47ydnvYlu/EfgsR0Cqc5Fs6xiSyiXgVqXg
         RZXlkMONbV4cwxSg3yq+g3QhB/ejf+5/eIH+bT8g8bGPRTPBuJUQoEc8UR+Relw6Dh30
         r3FKnRYgb8AtF7znDEO/9mkTvwGVXQMMFcfO/UbbD3bu2E8+LmEZC6IyrYp+k1Mx81xS
         K+QYNOFJHpG+5acd4M23KWjVMr9DMmQceG/LlGxZDRVJeX4qM3F7aF92o0u7cFU3hP3F
         bi7Q==
X-Gm-Message-State: AC+VfDxzxZIxegcxfcC0WYdG6gjh8gUFIogEgXTVcKaXUnWllkfbjyXl
	4h2Rwm8PD9SyYVTDiJHhigi1XrhRiUeyRSeKFQWmXQ==
X-Google-Smtp-Source: ACHHUZ4lLCbiYCR5TaavLSK+UDtu+bSyhMgElK5bkLm6xZEPoPnwgHug0toZ9CoB0/8urp9wcyyWqg==
X-Received: by 2002:a17:90a:4d:b0:255:b07a:3d55 with SMTP id 13-20020a17090a004d00b00255b07a3d55mr5691166pjb.28.1686151464348;
        Wed, 07 Jun 2023 08:24:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o8-20020a654588000000b00502ecb91940sm7614048pgq.55.2023.06.07.08.24.21
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:24:21 -0700 (PDT)
Message-ID: <6480a125.650a0220.598bf.e6b9@mx.google.com>
Date: Wed, 07 Jun 2023 08:24:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip74-rt43-218-g246f4be89a77
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 1 runs,
 1 regressions (v4.4.302-cip74-rt43-218-g246f4be89a77)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jun 2023 15:24:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11925

cip-gitlab/ci/pavel/linux-test ltp-pty: 1 runs, 1 regressions (v4.4.302-cip=
74-rt43-218-g246f4be89a77)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip74-rt43-218-g246f4be89a77/plan/ltp-pty/

  Test:     ltp-pty
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


  Details:     https://kernelci.org/test/plan/id/6480915ba0edd132fa306149

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6480915ba0edd132fa3061=
4a
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =20

