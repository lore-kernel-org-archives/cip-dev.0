Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D03C38147
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 21:20:56 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web10.29287.1674076848631798417
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 13:20:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=iS63LV3C;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id o13so384723pjg.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 13:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I3HTGHHiMrTKI7CoVG1hjVpBrUsI2eug83VzJGZXbus=;
        b=iS63LV3CZqhGoXh6sKOfTlgYsYjom70pjC8y/nHsT8NdK3FGi+4HnMITkM+alkVUHm
         C9qNdLXLE3fqySarBpLLYkcIoZ9YmKKXuQkAvuRjgsQtd2syWf0BNpGcdwvaS4YbSgam
         MjXaMYwlm4iQlLdOPwbKAgQEB4Dedr9dfrViV13fgRGqPENBlWZY9Z3MlOG7Mh7M5dRm
         U0CYfQLUgf3BD3snD+BIrZSyD4XEnWyJ+mfzF721aBI+wOCZj6lEkqrf91/c2SYt+3yg
         NDFqyXJGuLAz2la+MJ7OhW8pcyP4GlR9N+ymL93NqquGFbuaZ5l3XFGZjQvQstvcxOso
         KJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I3HTGHHiMrTKI7CoVG1hjVpBrUsI2eug83VzJGZXbus=;
        b=60z+LiqtDYrMRGfBA5C7f6R/jv/ZWDhhSw1nntYGKESLHTqahnbEk30OnfA55YwXZ3
         s0qbtvFmAla+fQngjaeVeN1um5h58WeNw+p+Xp9twK+corwAWBHPJh/VnoZ+gqV1gk/0
         7hI5HTtOUWlTLtMUgWDza0hmPQ7/+8Oho+PwKwmegyIVU0ovq81JepCIAqPbwMC0XcoA
         JL/xZiKI1A0arfkPVrMWYu6V1sfxtmQh7npGjGfYPxWDG9pxgQ2P/T5iPDeJMk3MxmG4
         pZY5e7kqBvVQ/w06pm9TPK4x70FmZMNwN36DLTS4QtAdtbw7csN7hP5N3oG954satInF
         QC8Q==
X-Gm-Message-State: AFqh2kr0Vh/ZgJ/BD2Trow6Xaomsyotf3xNubYGF/BnyFz4R+yL+uBpL
	75MinfwxymLUC/LD1Nk8y2FtV45xdqiba9W8UmHqQQ==
X-Google-Smtp-Source: AMrXdXsF5qcUdDyswXuGY89lQ9GzW4gL+t1MOPmP0bTFPBTpGt/3QgMb875hzcZPTa5mHZrunVO2Yw==
X-Received: by 2002:a17:902:e012:b0:193:3b4b:1a4d with SMTP id o18-20020a170902e01200b001933b4b1a4dmr7213320plo.63.1674076847855;
        Wed, 18 Jan 2023 13:20:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v7-20020a1709028d8700b00186bc66d2cbsm23660523plo.73.2023.01.18.13.20.47
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:20:47 -0800 (PST)
Message-ID: <63c862af.170a0220.ab10b.61d4@mx.google.com>
Date: Wed, 18 Jan 2023 13:20:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.269-rt119-1495-gc851fb1e222f
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test smc: 2 runs,
 1 regressions (v4.19.269-rt119-1495-gc851fb1e222f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 21:20:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10406

cip-gitlab/ci/pavel/linux-test smc: 2 runs, 1 regressions (v4.19.269-rt119-=
1495-gc851fb1e222f)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.269-rt119-1495-gc851fb1e222f/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.269-rt119-1495-gc851fb1e222f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c851fb1e222f4acf955da1ad9b020f3fc8a51c4b =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8593fe711b891e4915f05

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/smc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/smc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/63c8593fe711b891e4=
915f0b
        failing since 63 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b=
, first fail: v4.19.265-cip85-rt27)

    2023-01-18T20:40:14.650607  <8>[   19.276881] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =

 =20

