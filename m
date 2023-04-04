Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BE5C6FD1D
	for <webhook@archiver.kernel.org>; Tue,  4 Apr 2023 11:18:21 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.98639.1680607092161018927
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 04 Apr 2023 04:18:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=DpKZrRRI;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id ix20so30951985plb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 04 Apr 2023 04:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680607091;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BbqZUlpAedeUY74ETK9prw/px4buaprEL7BY0+eq4aQ=;
        b=DpKZrRRIwaECaoV71ZKEbOeZXB0pswgfgUrqaREiJrQtdl80tSO6KgPxog28OUCo+b
         EhgMKyavKE/5284dlu+S2TTPucNTi7wLYr3xzNyFv+PMeZZVRiSlC4BAZmP1VV0XC1cc
         CouVVvAFY3tSfxqgOT/BW3aVLOwRj/Rct/tm+icFvF98My7VBSE7x04kIn3kDfnO+16W
         pgGNdyZRqCrPywKalUvdJq4vUUZHhlJn3Brnc6yTEioRtjs4ynsUyTOe5rxbbqeKMyT+
         2ovF5dVasx6hKRJpnI8hSvtp+kskcZMdEzaQzrSsmzP5NIms/3ZGo5qrF0vqjlPDWHbT
         T/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680607091;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BbqZUlpAedeUY74ETK9prw/px4buaprEL7BY0+eq4aQ=;
        b=Vd0u1Pv6Cz0uAqgOrzlaOVIdih3xoQsWjfnXSEkGoTsOHj5tz1+Z8jxsOkqcqc8ham
         v/Lmao8+eJVLPfzGRN3dUgLFMSgPZ1CBeAUoQcXQsVwNU8i6ov7IUX0Qr27TkBJkpTGU
         Il9zWPpycvmltlNM8XyetNgOVq6xvfmOCV5TOHfX7QDkdHgVOixMzYLuouXu7jWnppXY
         7kgfoEeGb79PhRjEooqe7xHCD6omQfZii3iYOd0ELWC7xy7BQHn3IkTFqoUkngfJYBio
         58NVH3ljruPL5JgBOxA7tBW80iCcevNMZhGU0IVq9M9zpd4ABshPoyibPA/InLS9Yptl
         oUug==
X-Gm-Message-State: AAQBX9dLduMrn0IzQ1oN651Y35yeVLrv8bv/Gztp9x+QeZK/cembxcfZ
	PNenrZ6fKWuleKE5HC5ofijZHff0yHVZ9eeTrqbXYg==
X-Google-Smtp-Source: AKy350ZIm+oFSabu5lQLoBj1c467d1K2jORr0J70ALoaNRXnKU82xCGB3J+FBoa68hkuUwBw0blU2Q==
X-Received: by 2002:a17:903:27cc:b0:1a2:8940:6daa with SMTP id km12-20020a17090327cc00b001a289406daamr2094954plb.36.1680607091449;
        Tue, 04 Apr 2023 04:18:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902c21100b0019719f752c5sm8177359pll.59.2023.04.04.04.18.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 04:18:11 -0700 (PDT)
Message-ID: <642c0773.170a0220.1c06c.ffa9@mx.google.com>
Date: Tue, 04 Apr 2023 04:18:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip74-rt43
Subject: cip-gitlab/ci/pavel/linux-test smc: 2 runs,
 1 regressions (v4.4.302-cip74-rt43)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Apr 2023 11:18:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11170

cip-gitlab/ci/pavel/linux-test smc: 2 runs, 1 regressions (v4.4.302-cip74-r=
t43)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip74-rt43/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip74-rt43
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      22456e8b8d35c6bd1313511bfa4dd945ce7a0c1e =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642c014f53944b222179ea60

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/642c014f53944b222179ea61
        new failure (last pass: v5.10.175-cip29-rt12) =

 =20

