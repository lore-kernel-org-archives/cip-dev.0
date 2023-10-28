Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F12C4332F
	for <webhook@archiver.kernel.org>; Sat, 28 Oct 2023 20:11:09 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web11.29540.1698523864745683284
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 28 Oct 2023 13:11:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=meR7fu1r;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6b5e6301a19so3176153b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 28 Oct 2023 13:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698523864; x=1699128664; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n4bXBWn8f4jiivexTEyZrpc/a0g0HDJF6NW4MkPKel0=;
        b=meR7fu1r/GYwBmbIOsSvLJ3lneyqtjQ1xq7wT6nIM3Xwh13Xw2OnbLo4X/YMecrKbF
         aXTXQQDopQWte0Vtd2Npe0vJYSI96PGQUd0pwQ4XNF7IM4jn/wfr/7zEKgynIfFu41B6
         ToFVzh2SE5kJY+K26c/HHz8AksFPjanhUFTpV08i6QBjTEEBJ2Q2x1Q0fTvZiZxGwkNR
         Ok9lfj9dtcnlaZzIUXbm4ivL5a0QEWDkC98HABFnukHj0vC7mjkrFcjFok280vkiXmx/
         yhAJNxbfB+spr+onFhLvPtul0wencFVJDGMBCm4n5rJDEKxMG7NuCb9ANSyv69oEQVeG
         5FYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698523864; x=1699128664;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4bXBWn8f4jiivexTEyZrpc/a0g0HDJF6NW4MkPKel0=;
        b=sGAKH0StNvetLumpDeDcJAH8RHdE6MBvhRb5VWkfICUlB/2LdsesWDJy3fPWpHgpDK
         e4QhHCVZO15Bz0WwKDPgeRDia7PHqzsDTG0JDSRjn/0zvkv1houcOPt9Vxgq2OlyAzeJ
         ELdXm/wXNcxrRO3B0oneIDbywF2VO1aikq09jBDej+58XfatRafcos5c8+owj12PHnYW
         TvnImIk8EPkO4MoUnHVwn9jhaWgdkEBTRBAlZE0Tol9C8QMwJWWu2CiuOwI+6gDj/CLo
         h3VyFEsPoVmGInt4u5KF06bv29unOg/dWfFNlA1k+0sKIVg42Akbn5XSXUqFJPjp5grf
         DBPg==
X-Gm-Message-State: AOJu0YwJla3wlS7MnbVRmwxJHWpfCRTgsufBdXCKKqq0Df7AFDevR+vn
	DdWOl/Wa8eO7eAT/5fMR8eKWje9F3APmkfSjluo=
X-Google-Smtp-Source: AGHT+IEbotbP08jGeLAnn+k36Bs9cRnDa1KQD5JH9q9oY5X427esdQxDUHbf/ZyVklJ5C+Kd0IaAtQ==
X-Received: by 2002:a17:903:1385:b0:1cc:23ad:c2d5 with SMTP id jx5-20020a170903138500b001cc23adc2d5mr4830482plb.39.1698523863778;
        Sat, 28 Oct 2023 13:11:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e17-20020a17090301d100b001c0a4146961sm3587444plh.19.2023.10.28.13.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 13:11:02 -0700 (PDT)
Message-ID: <653d6ad6.170a0220.ad8a7.a8ce@mx.google.com>
Date: Sat, 28 Oct 2023 13:11:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4.302-cip80-rt46
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.4.y-cip-rt
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip-rt baseline: 151 runs,
 1 regressions (v4.4.302-cip80-rt46)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 28 Oct 2023 20:11:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13489

cip/linux-4.4.y-cip-rt baseline: 151 runs, 1 regressions (v4.4.302-cip80-rt=
46)

Regressions Summary
-------------------

platform          | arch | lab     | compiler | defconfig          | regres=
sions
------------------+------+---------+----------+--------------------+-------=
-----
r8a7743-iwg20d-q7 | arm  | lab-cip | gcc-10   | shmobile_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip-rt/ker=
nel/v4.4.302-cip80-rt46/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip-rt
  Describe: v4.4.302-cip80-rt46
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f468de833aa13aa639d147055db4edf9931b6811 =



Test Regressions
---------------- =



platform          | arch | lab     | compiler | defconfig          | regres=
sions
------------------+------+---------+----------+--------------------+-------=
-----
r8a7743-iwg20d-q7 | arm  | lab-cip | gcc-10   | shmobile_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/653d64f09f7b2669cfefcef5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip80-rt46/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-=
q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip80-rt46/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-=
q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653d64f09f7b2669cfefc=
ef6
        new failure (last pass: v4.4.302-cip78-rt45) =

 =20

