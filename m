Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C520C636CB
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 11:21:56 +0000 (UTC)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
 by mx.groups.io with SMTP id smtpd.web11.133513.1700824909746922834
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Nov 2023 03:21:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=1qtar1xn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.171, mailfrom: bot@kernelci.org)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-35930447ae9so5777585ab.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Nov 2023 03:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700824908; x=1701429708; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+r4EFzxW+Q/5pakDP2RTBnNH09GatbhFTUotlZkiPkw=;
        b=1qtar1xnxYm8zdDtz40RA8TORfWkeBxeBnmjkXwd5GY3KJgB+Nxju9tYzacIfGZCtl
         r3GWyc4dES6JhPIRwcs/1ssmoAxEbYpvWbQVS2vmjGYs0oCM+PedLjGR65Fo4cltEgzm
         3mB4ns5TLg174KZg4LLQ8L5WzWcQqRPkuXD+uL93QXYz4MeLW/6qA9btw1u2ERkpGgzu
         TYtaRUz6fdqaa82MUhDKPkC5xPjzuvqRGSlAqR/zHPWaLLVJMaw8Nt86a7RJQd30nj+q
         m0XijLsKtwenSgW30qa8/eqSlowAmHRGEPm1sHp2ThE/TQaVmDUOiavdn1tu+NHRej8C
         Q3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700824908; x=1701429708;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+r4EFzxW+Q/5pakDP2RTBnNH09GatbhFTUotlZkiPkw=;
        b=UCaXQb0DhkeQ2J/lyGk7nBFrvYfZ0H7Ys5ESfBXgYHu1rgOdadsqaXr7CbyINrCwCZ
         MzEMuFspcA4D/RhHZEqzxmJS9WjqrGNAD83u3j9wargFGHwQe8OR06my5/CQd5F2DS8j
         iJUKuzFNTxJ81200TahV3uaNGvqMptsZGQqjeRq3VsBoc5HPvK4AS7FaKLu0URJnfWJD
         NE2o0Iq9H2XN4SDFW0fr6sz2em/1Szr2RMaaMcHYgVONYVMHBOWO1gpFLMWUsW+keJsg
         q3JwxxwFu8lUo5Zrm3LvgeMlssbst8lxgRPNrvPvMMDqn8AKmxI4ShwiHyC/j0aaK1sO
         YRJg==
X-Gm-Message-State: AOJu0Yy5m5afHocnsT/U8zZQWz0SyLzMHQvWWKLylY0+LerI9SOlZc8M
	BvP9hVwI9JR+kfD5ebnLktTZNA3rkb/MBH3od4s=
X-Google-Smtp-Source: AGHT+IEssKY56bxMd3wzqmGi3vG8LRujdCfduAKd7Mny85dajb5Q14ICtIDlPiq+Hi7yuy/oxTSOYA==
X-Received: by 2002:a92:cd88:0:b0:359:30de:eb42 with SMTP id r8-20020a92cd88000000b0035930deeb42mr3202526ilb.17.1700824908335;
        Fri, 24 Nov 2023 03:21:48 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d10-20020a656b8a000000b0056b27af8715sm2530900pgw.43.2023.11.24.03.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 03:21:47 -0800 (PST)
Message-ID: <6560874b.650a0220.51982.5957@mx.google.com>
Date: Fri, 24 Nov 2023 03:21:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v6.1.62-cip9-12-g3a5321f469b07
Subject: cip/linux-6.1.y-cip ltp-timers: 11 runs,
 1 regressions (v6.1.62-cip9-12-g3a5321f469b07)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 11:21:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13722

cip/linux-6.1.y-cip ltp-timers: 11 runs, 1 regressions (v6.1.62-cip9-12-g3a=
5321f469b07)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.62-cip9-12-g3a5321f469b07/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.62-cip9-12-g3a5321f469b07
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3a5321f469b07e6124d325d7faaa2f8f1993f67c

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


  Details:     https://kernelci.org/test/plan/id/65607aa0ea4f2ba0bf7e4b04

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.62-ci=
p9-12-g3a5321f469b07/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora=
/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.62-ci=
p9-12-g3a5321f469b07/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora=
/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65607aa0ea4f2ba0bf7=
e4b05
        new failure (last pass: v6.1.59-cip8) =

 =20

