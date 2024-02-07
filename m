Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C568C4829E
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 01:39:38 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web10.11061.1707269975571794831
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Feb 2024 17:39:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=zfs8eRk6;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e063dc2cfbso117768b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Feb 2024 17:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707269974; x=1707874774; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mdkCteaoXV/4ROPijGyg9ZW5EXzNu5x6kfT2Fw0yU2U=;
        b=zfs8eRk6tKIFy+2Fv6rOwkKbgIIylVQM1jewo0Sm4YgFLEWVK81Q9TnFmUeDIch245
         gmRbkvYckhTeRnubkPqi2mDMPHMG1NnbbfU4GJ4daHhqhrOiDV1/jbdC/idZmTKO8SCI
         53uZhpLhlt8/VeDJ9s+rsgyo1FNcfUHu2rK2LCTYbyZm02BZONUQElZ1RRHB4lifWUM3
         gdfes92Alh9oY/uZFl1/+wFAU5u8gb+5sYwak6IP8INultMbviGuhlm3hJODm8NoexWu
         ceYe6r25TihZ8PNCdZpDbtH+SksUquUuM1wzQMpQEijSeZz+ZG8QX2k7KlCAneyEXmT4
         Q7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707269974; x=1707874774;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdkCteaoXV/4ROPijGyg9ZW5EXzNu5x6kfT2Fw0yU2U=;
        b=V/CaQfuOiOJHmbY4FNWeR+MI65wkbRTp737KfHccTnuYHJB720yuFXZMyb3zGePY/u
         /aW0TOpy2JzDF+PCkxlRsINE0eAUHkVh7ZPRmrqqSUGbtnS2LjM+/XCJ9pkXUwGZoRsF
         OQ5Ej7Cho7plkXETIG0lMlrNKwUYkQ9aOF+muVk0L2I2LCWdtrukIPSI9qc6TSMoziYQ
         Tk5TsikT7uMNoUWDQXAPlgkKjEFD9hsissPQ4EOlUdpWK4eYdKwRxzfuYxqtDHV0WyfU
         a3FzlOGnLwWqOzYQVolxIkXK6hsj+xM2Cb4ifF6iInbYy2yfgy4vYM8PaX8Ok50mZxK4
         mkkQ==
X-Gm-Message-State: AOJu0Yz9951MNScdbkwwCQzSLXKUBybUCCZCau5VgyDtPG/zLkB0Bp18
	vCxeRqMV9wfIujGx/hjYAfx85coTE4JPt2VLdOcpOJTHRKT6hnMuqp+z5SXNhCo7VeeylvSTarf
	W
X-Google-Smtp-Source: AGHT+IE19FzoSUULfP2wyTVf/gLSk57BeMF7IzwM7eSJU+IBFonTy/MfgJ7NLiiQGGuO3vdcaeHTpQ==
X-Received: by 2002:a05:6a21:3a44:b0:19e:a3da:7199 with SMTP id zu4-20020a056a213a4400b0019ea3da7199mr814694pzb.57.1707269974502;
        Tue, 06 Feb 2024 17:39:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXwDR09e4eJiE27h2lYfO8OlqJmqXz3SfKizrZBKeq0OhP0Vb7S/PSgN7Uo13l6A/W871UxDG7DKW2vg8k8b1I+DjjALhRzEF5qImkN5uoSkIt7ClSO6f01+5ryiusQjXpZ6Yiy+xWOVjBTH/3sJoO0ew==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n21-20020a638f15000000b005d6c208fbd2sm150717pgd.35.2024.02.06.17.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 17:39:30 -0800 (PST)
Message-ID: <65c2df52.630a0220.35f96.0918@mx.google.com>
Date: Tue, 06 Feb 2024 17:39:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.209-cip44-50-ga624abaa85d7
Subject: cip/linux-5.10.y-cip ltp-timers: 13 runs,
 5 regressions (v5.10.209-cip44-50-ga624abaa85d7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 01:39:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14856

cip/linux-5.10.y-cip ltp-timers: 13 runs, 5 regressions (v5.10.209-cip44-50=
-ga624abaa85d7)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
qemu_riscv64             | riscv | lab-broonie   | gcc-10   | defconfig    =
              | 2          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44-50-ga624abaa85d7/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44-50-ga624abaa85d7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a624abaa85d7f3ff289eb2e257db5c4485d11d18

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
qemu_riscv64             | riscv | lab-broonie   | gcc-10   | defconfig    =
              | 2          =


  Details:     https://kernelci.org/test/plan/id/65c2cf09d9a1b0f0078e1eef

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_=
riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_=
riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65c2cf09d9a=
1b0f0078e1ef4
        new failure (last pass: v5.10.209-cip44) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65c2cf09d9a=
1b0f0078e1ef4
        new failure (last pass: v5.10.209-cip44) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d19e28cf721de38e1e88

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-=
hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-=
hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c2d19e28cf721de38=
e1e89
        failing since 5 days (last pass: v5.10.201-cip41-69-g8f7b450fc28ed,=
 first fail: v5.10.208-cip43-4-g1c63c70fb18b8) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d4d28d404108178e1edb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c2d4d28d404108178=
e1edc
        failing since 125 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d9d5daec9dba7e8e1e7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c2d9d5daec9dba7e8=
e1e7b
        failing since 1 day (last pass: v5.10.208-cip43-4-g1c63c70fb18b8, f=
irst fail: v5.10.209-cip44) =

 =20

