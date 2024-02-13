Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A33C4829A
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 19:46:06 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web11.23147.1707853558062752151
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 13 Feb 2024 11:45:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=fZMY0OOg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e0fc87fc2dso516037b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 13 Feb 2024 11:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707853557; x=1708458357; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=efW8NpicNNIvzIRWIwkkh6KZg6XAMieS3ofSdcUV9bs=;
        b=fZMY0OOgEABxicMbm327Sf3Pfkbw3eb+Mftzhiq6m+z9GjFCKu2aYDIe4SaEtAaCH3
         5nSTEfFgDUV7r084ecWXglpgHoissbTHKaN2q4CKMlITx/sVT4TCQ09mURT6aGxZHNii
         yDlvMrRUQhISDdKSmP9vhbFCeAcJWlxfiflDjHwUfjqGocEAkqvGxE3Ax73llAH7kXdC
         UsEUuXwikHGxPVKyCqAsoIlJmGlg6HaBX9kHPRVvj6lE2O1wA2y+hFg1d+iOLCDn/mkh
         WpnhP5nHpbWi+Nr9SVrAlVmnZ3j/Vzz6lr/J8cntVrtOf4rTuUJRYDMzBJhrmYeaador
         25Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707853557; x=1708458357;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=efW8NpicNNIvzIRWIwkkh6KZg6XAMieS3ofSdcUV9bs=;
        b=HbOiVVC0HG0cbpFaT5qjjB7D8ACMIq/Izh5YLQOy3itfi7rzc0gf8z+p7MfkVG+Pge
         T60II+ePFlyFzBJmMiU4LGUCGpAfY/2SaGHdahpbGRX72DWkb6I9A49pfw/dVsA+timY
         xTSRXHic5yz1r/4mqrYXgjL2lLSMz6aj52u0PkTXE4ALPLe3S3QkQH22Pghy6/++gtsK
         yB/FsUJw4foe5guj7B0HtR6WnBrnWo2D8PUMb4/mHIe5jgsssjxBY4lLsMKoDrc2JF30
         yTH2mAWsrgxxLvUE3KjEUOqxjMDL5qgJ1evmYhcJ19d53rbD1SkKl85dxvby9uyLRQnN
         ai7A==
X-Gm-Message-State: AOJu0Ywwb5r39CE4HC0bRF/L173Z4l3h3Aib/s6FoabfPd8d/2d3gaBG
	fclendLRwSY092XIb45pShbKnLwSIYfipzYQqWrNJjKrAH78YIIqEF4xnVWCEdwdQyB/LdrRNCL
	jcZY=
X-Google-Smtp-Source: AGHT+IE1kVn0bkVgXHiyti43Lf2AH4rGJIxsJ3TVyej9eShsQYdka0K03kN7WsR+BVpTCMtHUgDztg==
X-Received: by 2002:a17:902:be0b:b0:1d9:9921:504a with SMTP id r11-20020a170902be0b00b001d99921504amr575568pls.33.1707853556948;
        Tue, 13 Feb 2024 11:45:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a17-20020a170902ecd100b001d8f251c8b2sm2425563plh.221.2024.02.13.11.45.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 11:45:53 -0800 (PST)
Message-ID: <65cbc6f1.170a0220.a90d4.8ac1@mx.google.com>
Date: Tue, 13 Feb 2024 11:45:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.209-cip44-51-gdb99ac443b0da
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 7 runs,
 1 regressions (v5.10.209-cip44-51-gdb99ac443b0da)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Feb 2024 19:46:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14960

cip-gitlab/ci/pavel/linux-test ltp-mm: 7 runs, 1 regressions (v5.10.209-cip=
44-51-gdb99ac443b0da)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.209-cip44-51-gdb99ac443b0da/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.209-cip44-51-gdb99ac443b0da
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      db99ac443b0da75f00a4fc49e0040ac5dfa47e72

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


  Details:     https://kernelci.org/test/plan/id/65cbbb4c4ba5ef26aa63701b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-51-gdb99ac443b0da/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65cbbb4c4ba5ef26aa63701c
        new failure (last pass: v4.4.302-cip72-1251-g57b839f015944) =

 =20

