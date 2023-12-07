Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5504C10F05
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 13:27:56 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web10.83927.1701955673928216758
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 05:27:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=1wVFqUGN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1cf7a8ab047so6416865ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 05:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701955673; x=1702560473; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cnuxEB7QpP23FddNKoKPtJGgHPDTSyxqJ150R1OuWVI=;
        b=1wVFqUGNt0b3VFOANVGkNPrCppoKP9KFM4axK8MXXMiWm31OJwbGwxLyu0XzewSjNv
         3y2xkMKLfdNwzNEZHYzf6FPsffTYg0jXJO7Q+H1Wo9LNXouCf2qgP7yPzK4qdevb1FNh
         UFCv7sqPje3MrGdVp0wzPPC0usMhFFkLPLROK4D1vKa/w1bFMxYudaiJMeCRI843nLo7
         pC6IZR5UWTbQAxH23pgo+rt0MHxy63fmsj4y8rJ5KC9aHeOd8znPUHUYk1xEFHfCbhoS
         jEdZVjpqbW9lY8wJBZzt6zz1TFsPx/ghWwaWqmgYr0l9SqvdVBxnnJbT4YheN399tKkH
         GvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701955673; x=1702560473;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnuxEB7QpP23FddNKoKPtJGgHPDTSyxqJ150R1OuWVI=;
        b=unX6CXDgKEa/rhBqf3/ShDQQ7imlkHVoNYqfVRXMCCc2xu9BUgIRQpi96DP9XrnVPD
         W+RUZUV7sMxa7zfoGwxkn8BT7LqUlP9bEBGiax+6XIYuji0V1aMva/UsjIGJLVoYFP/d
         Fv13meTZb4qjLP8ZMoivtUlNsUnRaZz5paNqX2Uko+R1tHpToYM8rdL+PrFxVLlacRfN
         ci7BWfAcYZjpRdeKyYOtE2/hzv/Lu0jgU8RPrGR+zPm7ecB4glM1pWgMd6WfRS9gww+0
         GvsoPPzWegyXAw+mOXD6RWqarkwxJN5PxFW7d0uhUr7w16Cxt2genT7RBMmBtRsRlV3o
         KmpQ==
X-Gm-Message-State: AOJu0YyzqAi5K0ZyH7Jk6ZmVgXqeFy3oHAf05tMNWAWoTZdqc0LuVlog
	OfytNGJu+5zldjT3ElQANubnMH++FLN2+aHMt/V/bg==
X-Google-Smtp-Source: AGHT+IEZBxLB70ZTqQGoELcCEL/ARePsj3RU9aCGzyxf2v5Tzyjqb64+ZSHRHoWuQye/L9luVtBKXQ==
X-Received: by 2002:a17:902:ab5e:b0:1d0:c228:560e with SMTP id ij30-20020a170902ab5e00b001d0c228560emr1597267plb.48.1701955672976;
        Thu, 07 Dec 2023 05:27:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m4-20020a170902db0400b001d078445059sm1382637plx.143.2023.12.07.05.27.49
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:27:52 -0800 (PST)
Message-ID: <6571c858.170a0220.28058.2eb3@mx.google.com>
Date: Thu, 07 Dec 2023 05:27:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-28-g38e219eb6aa85
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 13 runs,
 3 regressions (v5.10.201-cip41-28-g38e219eb6aa85)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 13:27:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13838

cip-gitlab/ci/pavel/linux-test ltp-timers: 13 runs, 3 regressions (v5.10.20=
1-cip41-28-g38e219eb6aa85)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

qemu_riscv64              | riscv  | lab-broonie   | gcc-10   | defconfig  =
                | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-cip41-28-g38e219eb6aa85/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-cip41-28-g38e219eb6aa85
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      38e219eb6aa85cc3be6dec326b24dcf8cf438d01

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


  Details:     https://kernelci.org/test/plan/id/6571bc7dbf7843ac76e13491

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6571bc7dbf7843ac76e=
13492
        new failure (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
qemu_riscv64              | riscv  | lab-broonie   | gcc-10   | defconfig  =
                | 2          =


  Details:     https://kernelci.org/test/plan/id/6571b66d05bb774fe2e1347a

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/riscv/defconfig/gcc-10/lab-broonie/ltp-t=
imers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/riscv/defconfig/gcc-10/lab-broonie/ltp-t=
imers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6571b66d05b=
b774fe2e1347e
        new failure (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6571b66d05b=
b774fe2e1347e
        new failure (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d) =

 =20

