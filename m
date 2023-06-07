Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91961C77B7A
	for <webhook@archiver.kernel.org>; Wed,  7 Jun 2023 15:24:35 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web11.1048.1686151467343193234
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Jun 2023 08:24:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=uTaluk/p;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-65314ee05c6so3559909b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Jun 2023 08:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686151466; x=1688743466;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IWNziOLG7vjLvjSEsQywhIAKa6M0vfgiEWXWRMr7o54=;
        b=uTaluk/pSrjooYHV/j/GyoPhW183G95GmPs4R5lgdgypaWmLKcsqyFWSA/U9kp4MFb
         h2pQyR/ZijhfqvdZ9Lr0xqubJObIuAnYZQz66EQcRXdfaRfFXbBgsxz3+vClLlWSuq4I
         NXP9c2mYObb3z7zCvm6NFMr0jbKA2m2PmhnkZ/SDcDbzN0JAGd44TfwmwoZpMLj5JDCY
         zThvD17kgLjA8vO7SXIMkstLJlVBw/FWrKJtlBmxTqpmqceSJzi2MIWmpA8XkOnTRj2E
         tyeOJVHBDixtu6W7xqucAclquH/NX/PtkhhaVnIKtt4jeEfyDaaeYcPtr2478gf4kuWY
         hlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151466; x=1688743466;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWNziOLG7vjLvjSEsQywhIAKa6M0vfgiEWXWRMr7o54=;
        b=Mr0pDl3h2nPWyiJGSFHtgRMh3MMZlOq/NUwLnJ7DWOiJzivv6oBGscY1sFMLaS7uQV
         pTdql1WutnZNx/rLbIHsV5s6TsQQq4+1ogIOGCx6mq90YyVJn2kNDRHrL8VdOLfZfLi7
         VoefzDdxse33unwyhrAY5shGvFBbYp3yNQmc7YE0xYF45+gAxJpca/JzYdsWAse/w2mV
         sKO6fl4uu10TVDRy4zF1zDr3gLZAWncupI4zGgchNiNvRBYIrwZURDkQepCuReAM/p04
         hrcnEUcp5lkAhtVb080SEbzNQjGwsfxGaGRGvM1D2HwU2lqWbajI584VNlGA5cI3mpYK
         5ZSg==
X-Gm-Message-State: AC+VfDy0xrkpBFRbZLs11Te3BqWsowbpQ5kcwT05gVIR6/Hhza044W9y
	fDuq8BifvpxcQvPp9oKpERvNnBq9bphhx3f6fEfFHQ==
X-Google-Smtp-Source: ACHHUZ6aluiWs+tNvY4eJZWA/d/IAkND/2sCsBpoY9GO/Xs57ZwuNqslYTrDRN4MowMxGLQS3RmyKQ==
X-Received: by 2002:a05:6a00:850:b0:646:59e4:94eb with SMTP id q16-20020a056a00085000b0064659e494ebmr3673900pfk.15.1686151466372;
        Wed, 07 Jun 2023 08:24:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x13-20020aa7918d000000b0064fd4a6b306sm8546427pfa.76.2023.06.07.08.24.21
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:24:25 -0700 (PDT)
Message-ID: <6480a129.a70a0220.de681.0721@mx.google.com>
Date: Wed, 07 Jun 2023 08:24:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip74-rt43-218-g246f4be89a77
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 4 runs,
 2 regressions (v4.4.302-cip74-rt43-218-g246f4be89a77)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jun 2023 15:24:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11927

cip-gitlab/ci/pavel/linux-test ltp-timers: 4 runs, 2 regressions (v4.4.302-=
cip74-rt43-218-g246f4be89a77)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip74-rt43-218-g246f4be89a77/plan/ltp-timers/

  Test:     ltp-timers
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


  Details:     https://kernelci.org/test/plan/id/6480910ef443e7b5ea306150

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6480910ef443e7b5ea3=
06151
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648093254d0cc4eecd306194

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/648093254d0cc4eecd3=
06195
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =20

