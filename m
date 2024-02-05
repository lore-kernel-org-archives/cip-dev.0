Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EBBC4828D
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 13:43:57 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web10.63106.1707140636052500103
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 05:43:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=N51tQ35F;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso3640190a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 05:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707140635; x=1707745435; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TafAH7wFXk48UwmLHYVHIEzW3O7H7z+7kVi+sT3ItFI=;
        b=N51tQ35FeHGDEtRteZUVO7NsVvLv6GH2fXp9qWg7XjTm+SiU0KajdCiF2LxSNJfG3o
         MnEYjBkx/w+jpobQuo+iMoWTwK1p/S+Hj8NRX+SatFanA3s1h3j8AQI0o1mtJEg/O4bY
         2RgX8ysHmTxYbQI1KMB+9jDQz/4YGzK1A1rsPpLLeSB9dRHIXNbC1SN4+B5Est+iaqtp
         Uy+uWYjj6Taz90EkfgCPiRziefJEctExp5fS41VOVd1+/in7QCtiOiX/ZsIlYdVrooPe
         uGVxbLcd8AkYJrtGZ8FkcVw29Osu300E2S46B5hupMFRqveYsUbs6rLiNDG4MuA79MN4
         MV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707140635; x=1707745435;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TafAH7wFXk48UwmLHYVHIEzW3O7H7z+7kVi+sT3ItFI=;
        b=OHh4UHAem29Ho7QVzsNPg5jE1xb7jhTGnKKMW0rA4pmOTh2W4TAUqV4wMw6VUjjgMz
         MdJoUVwPQW+nUC9iv3xUXKmE7giC1sJWywwBVky2rjn3LuabYQEVkqudQUEElxN2vPiX
         FJ6X7hmrcp4nWDvB/xJzs9vhzwG/xmO3vB3DkrL4z1HELEOD8QU7p7Ifq2azXWm8rRz6
         u+++BC6Kne8iBaMB94yI4H/1IBP8wDsnC8SSYxL3kqEYehbyVQk1HMwSNOF6y3QeLQ53
         3sPYgHX9mMC7EA110s2UUn+8dB5Bcx3ri13MNwoKq2z2D1sMT5slku3xJx5Ced0t0d+y
         X5KA==
X-Gm-Message-State: AOJu0YzI+TwCcli/ghbTqVZrDDcIBD5uOXtfkgKTdLuwlTjMaqvB2wEX
	6FnFhf1zCaFATxwQt/YaJM2dPgKQz7R4Vr4TPMYm7gfv1oWKIeugQtULCZMAyBEch7ebb4kEjMQ
	j
X-Google-Smtp-Source: AGHT+IGYx/AJIEkKKy/97d/389n03BJMY/245vhQR6G7elmDiDwig+CYVGjq1/rqltelSMHGEuhvdw==
X-Received: by 2002:a05:6a21:920b:b0:19e:5c91:1f6d with SMTP id tl11-20020a056a21920b00b0019e5c911f6dmr7723152pzb.37.1707140634801;
        Mon, 05 Feb 2024 05:43:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h9-20020a656389000000b005ca0ae17983sm6120473pgv.8.2024.02.05.05.43.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 05:43:54 -0800 (PST)
Message-ID: <65c0e61a.650a0220.a5be0.3292@mx.google.com>
Date: Mon, 05 Feb 2024 05:43:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.75-cip14-6-ga817aa655908
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 11 runs,
 1 regressions (v6.1.75-cip14-6-ga817aa655908)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 13:43:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14723

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 11 runs, 1 regression=
s (v6.1.75-cip14-6-ga817aa655908)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.75-cip14-6-ga817aa655908/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.75-cip14-6-ga817aa655908
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a817aa655908e54b6999ed3d0663c3f370d059ec =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65c0db46763622bbe000a055

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/arm64/defconfig/gcc-10/lab-cip/kselftest-fil=
esystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/arm64/defconfig/gcc-10/lab-cip/kselftest-fil=
esystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/65c0db46=
763622bbe000a056
        failing since 5 days (last pass: v4.19.299-cip105-1134-gc868d5e4ada=
a, first fail: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =20

