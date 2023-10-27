Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73D2C25B47
	for <webhook@archiver.kernel.org>; Fri, 27 Oct 2023 13:38:36 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.7143.1698413911039571083
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 27 Oct 2023 06:38:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=p5EtaKwJ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1bdf4752c3cso16325155ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 27 Oct 2023 06:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698413910; x=1699018710; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3u6TgyamNWLXoe6aQTDBp4JtmwZ0lY8IIjUq1VVQGQc=;
        b=p5EtaKwJ+hQwaDvfmed+85C8Yrdr6KPVnaeGU5z+jjLJLpxqLaq8KVYrpctJJYZEji
         HYGfWOsSzntx3sO/fdZUIJVc511zADpitSCdiG1fmPIgYbPuOjbdW9Sxtha2YaLoa5ZN
         qdWcJmsc8bpo3LKttvs/VakbTS8ZoVsb6Z7xJXxAn9KhYwBHXV3Ev/zWKmcGkJ3+anGl
         a9K/lxl+uZFgomTBZdoS1MGgB+QN/4FXZT4XGazzpBEhy+Pons2tHBhGZ3XOripGFhDy
         cMIrFx5Q8ROKUHvFFp8gBTPmxLVfp1veEp+lYMSUJxdP07uBMio7L62yCMSoVg6qqjVn
         wiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698413910; x=1699018710;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3u6TgyamNWLXoe6aQTDBp4JtmwZ0lY8IIjUq1VVQGQc=;
        b=FuHkdET+GAGK6pLpE3bl8rGl1Dgij4WY7xnVODoLFSjFiN+wnkovA7zb5L7tYCU0WP
         X9/m9hISDjMicySkUZbYd74JotVq4y7Rc+TzRpKp+3Z7FQ1toFBvcY5croLGieBPomeH
         ZNq3OJf8StVWnWk5keUaqaGMqR+i+1NnmP1mwcEM3r0AcDMl9e+4Cq3uTiNw7sseaht9
         vSZSqZYR6sf4xqeAQnJsJNZ+mAEoUFCmxfLOCmh3hjFrucYKjjJ7TgrC8EYVQw6qJXJT
         480JjhBajx2ccq+vVrk0fQK895Zn90MyvCZVaNtKBtuK9HxcLB8slUoLxFlQMhRIRaqL
         XABg==
X-Gm-Message-State: AOJu0YzKbSfXcyY67o89EN0NNyKAFdeJ5TJ6Wx31YQFrS3zEi4It6Vj4
	7S4VaCjU+IiLCDXLxutz/4nuaX8P+oz5ArFmT5w=
X-Google-Smtp-Source: AGHT+IEdB7QOyOIdAv5C8PbwZL2/vVfL9pm3LCCvNtzp89UqIJm+6uqWZrjXW9b/mBtRCPEKQ1eYFA==
X-Received: by 2002:a17:902:e80a:b0:1c4:13cd:b85f with SMTP id u10-20020a170902e80a00b001c413cdb85fmr2935648plg.5.1698413909868;
        Fri, 27 Oct 2023 06:38:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 9-20020a170902c14900b001cc0f6028b8sm1556183plj.106.2023.10.27.06.38.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 06:38:28 -0700 (PDT)
Message-ID: <653bbd54.170a0220.63b83.4578@mx.google.com>
Date: Fri, 27 Oct 2023 06:38:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.58-cip7-132-gb38ea1474c159
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 16 runs,
 3 regressions (v6.1.58-cip7-132-gb38ea1474c159)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Oct 2023 13:38:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13479

cip-gitlab/ci/pavel/linux-test ltp-timers: 16 runs, 3 regressions (v6.1.58-=
cip7-132-gb38ea1474c159)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =

qemu_riscv64             | riscv  | lab-broonie   | gcc-10   | defconfig   =
               | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.58-cip7-132-gb38ea1474c159/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.58-cip7-132-gb38ea1474c159
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b38ea1474c1591eafe6d4659c33713917887c7a2

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653bb3a0b5d38fe459efcf0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/653bb3a0b5d38fe459e=
fcf0c
        failing since 0 day (last pass: v5.10.194-915-g33f52aa14b957, first=
 fail: v4.4-st20-3596-g73e7f2b880d98) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
qemu_riscv64             | riscv  | lab-broonie   | gcc-10   | defconfig   =
               | 2          =


  Details:     https://kernelci.org/test/plan/id/653bad722a5d8b5ed3efcef7

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/riscv/defconfig/gcc-10/lab-broonie/ltp-tim=
ers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/riscv/defconfig/gcc-10/lab-broonie/ltp-tim=
ers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/653bad722a5=
d8b5ed3efcefc
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/653bad722a5=
d8b5ed3efcefc
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =20

