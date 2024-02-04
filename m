Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B840C48299
	for <webhook@archiver.kernel.org>; Sun,  4 Feb 2024 05:40:36 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.33493.1707025228665435116
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 03 Feb 2024 21:40:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=lv5MtjZ5;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d94b222a3aso27879665ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 03 Feb 2024 21:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707025227; x=1707630027; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K+aKeNwOzm+y087eInZLHHXs+jIg4nGELNd+AS9Oi3A=;
        b=lv5MtjZ5zZjW1VZDIeiwe9/OmdXdnC2pSpiY7F218eurCPi2RdxxHF8+JJVO5j0ayx
         GvgGlgQ9uiIZPhfSZjwynphjNzbELQ427Bhp7GOREcWiQCVtMau05Lm78NdeFscu/H1q
         RTGZ/r8mXHZEvXsdKQ/lC+ItUl6sqiUxOgirriL6rEYy4+lOwwrTaQdIcVHprwZboenm
         dqxg1AAc9d9wFfwqyH9YE4TGCUFQU1mdRoCzfdWuEKLAw1BriwvNV8x/HNZ59vo94Aco
         A58iCtDDL70VSzULclWc0N4/l/+7hWC9UrlI5yPQfhcEQufKEW07pL7LbRcjZBca1b4n
         wsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707025227; x=1707630027;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+aKeNwOzm+y087eInZLHHXs+jIg4nGELNd+AS9Oi3A=;
        b=mrYbHYJgWSVyaCtakUaG7qFYHmkhacJGpctbC9i/KuHmSKyYDNR845whbyxxsbRyfJ
         wl8FQ1UzHfc6ZdVRuhfBAXhw3hHtLArbr9llvnbMT320BUHShGAfouZqyZuA0n9r8ob0
         2ptLhti2RDyqBA2wis1bJHZdyGFY5gw0sZtNpf6/xuVBDUDdrbNEYGNaNfaPLqTH+Ov3
         9Y+Ou+Twv70hPFrAS74c9LoWUh7XPoXS8HxHjmMxPKuhL8Zs8rmVGfB64nP23CCfs5+J
         B+PkCzdIpJgRh2fMGas45loUo/ui9SyeBaPvcMSTsnMiV58T99AkmR223Eya8KQnBzP1
         mF2w==
X-Gm-Message-State: AOJu0YxR/5kDfgFpfQ4zhUWFx2yWXy8+rl9xxqFBf4w7c7tirJB8jhUc
	aTieGlXNQtchG45/acnArGlxSBeZl1qiIO4b2wgu43DQLFORh9C3dvhljCgpoirXtgrzH/JgRo+
	UlN0=
X-Google-Smtp-Source: AGHT+IEmdl6RNSyhFaP5DHaHVVOEpi/znBQkigPx1/8NELKt9FGzj9gC3R2p0PCsWYCE4MZipeGz9Q==
X-Received: by 2002:a17:902:e546:b0:1d8:d899:f1b with SMTP id n6-20020a170902e54600b001d8d8990f1bmr8930948plf.28.1707025227560;
        Sat, 03 Feb 2024 21:40:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090282c100b001d74502d261sm3933698plz.115.2024.02.03.21.40.25
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 21:40:25 -0800 (PST)
Message-ID: <65bf2349.170a0220.1d226.e370@mx.google.com>
Date: Sat, 03 Feb 2024 21:40:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.75-cip14-132-g6e54756fbd6c2
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 13 runs,
 2 regressions (v6.1.75-cip14-132-g6e54756fbd6c2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 04 Feb 2024 05:40:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14650

cip-gitlab/ci/pavel/linux-test ltp-pty: 13 runs, 2 regressions (v6.1.75-cip=
14-132-g6e54756fbd6c2)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
               | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.75-cip14-132-g6e54756fbd6c2/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.75-cip14-132-g6e54756fbd6c2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6e54756fbd6c2a85eb65a7be04700955d2e49b68

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


  Details:     https://kernelci.org/test/plan/id/65bf1b5984f3260ee500a060

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/x86_64/x86_64_defconfig+x86-board/gcc-10/=
lab-collabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/x86_64/x86_64_defconfig+x86-board/gcc-10/=
lab-collabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65bf1b5984f3260ee500a0=
61
        new failure (last pass: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
               | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf10cc5ca85681f300a10b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8=
a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8=
a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65bf10cc5ca85681f300a1=
0c
        failing since 3 days (last pass: v4.19.299-cip105-1134-gc868d5e4ada=
a, first fail: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =20

