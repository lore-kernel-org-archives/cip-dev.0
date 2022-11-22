Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C235BC4321E
	for <webhook@archiver.kernel.org>; Tue, 22 Nov 2022 12:01:39 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web11.17113.1669118493153974510
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 22 Nov 2022 04:01:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=KCMbTQuw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id x66so5552427pfx.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 22 Nov 2022 04:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Sb5S58dL2qWWO6u8pvE5EGz1GPqoHvANqLYsSjfCgBA=;
        b=KCMbTQuw2uvuwvedevc1HTC3SvkaYFsbMbUKg5LejsZV+IRL/r4HmN5whk7ie+dtNn
         8bBe72knolQ9wd5TAKzvkoxvEWCSG5PefOcxNFVpD3W52X9cDq6LTdxMSE8lYM66qxtF
         lSHvgodOC1PfwszduDGpuZ+BfOrFAl3HhVkIOzVv0A22LjoHZPA8K03DfLG74QHQKqYR
         ovKoKUsWRvg2vRQ+MfnCDyM9po2Ga48tF+m5a7mn8U5Y+d0Ua5yofryF4Do5fye8lXZ2
         y9cd1nwmoRp2wPxmjostkf8Z9KMDG1lElhiEWPRI7b7CMb2Fzb4AE84tzZNWKt4ws5tK
         Susw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sb5S58dL2qWWO6u8pvE5EGz1GPqoHvANqLYsSjfCgBA=;
        b=qzWgah4s74KluhmBJaE7wJMXSSqdRjMvY+enF74ICOEfVKF3toGnpg1xNXtVKinEbm
         /dsK7BklddF5wHfphKCy+wD4/vQ0I4FatEE53y1Aon4Kk2/FgG9rbkGNqd0VOnjrYPic
         ofNT9GVGBa/D+S1h6VQb+c04sjD36zaqj91bnO1u6TjaV4i43Iran0PAeNXpBNLcfx00
         MqfDKC1Pe4epTZgTi1CYSxEQDSA77XbvKHtl3TRU9ZeWCLGg0+Lh2oqPc2kDgLA+1y+o
         EPfLoFW/fxXZOY9oUwgHyitxqlSSUmENkSD6BWjueH389CQw4zJOTtfpKgTmf7FFqiJ7
         RkYQ==
X-Gm-Message-State: ANoB5pk9wx9XQpuK8PIz7wGkET+RLEq3soId61eujrGn/IXlaQowMx12
	ill+RgIXg/3OiQrDpTKFpJOHMIArwABKZWuAfmY=
X-Google-Smtp-Source: AA0mqf4XLCVaByuGBaZk3TD7ghkNNBqtcLSOsBZJqmVrH40j90DFVgAVzgw0ef/kOtes4rBFgsDkSA==
X-Received: by 2002:a63:ea17:0:b0:477:9a46:f57b with SMTP id c23-20020a63ea17000000b004779a46f57bmr3303252pgi.319.1669118492115;
        Tue, 22 Nov 2022 04:01:32 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c8-20020a170902b68800b00188b5d25438sm11811393pls.35.2022.11.22.04.01.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 04:01:30 -0800 (PST)
Message-ID: <637cba1a.170a0220.55546.1951@mx.google.com>
Date: Tue, 22 Nov 2022 04:01:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4.302-cip70-236-g69445bc0d4209
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs,
 3 regressions (v4.4.302-cip70-236-g69445bc0d4209)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Nov 2022 12:01:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10083

cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs, 3 regressions (v4.4.302-cip=
70-236-g69445bc0d4209)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip70-236-g69445bc0d4209/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip70-236-g69445bc0d4209
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      69445bc0d4209b0634d1f43657fd58f708cadf81

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  a15eb3cdfa3556203167572e15754f1f59ba26bf =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637cab402874c5c4a72abd6e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/637cab402874c5c4a72abd=
6f
        new failure (last pass: v4.19.265-cip85-rt27) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637cb0cc21916fd92e2abd45

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/637cb0cc21916fd92e2abd=
46
        new failure (last pass: v4.19.265-cip85-rt27) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637cab558203cd1c372abd1c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/637cab558203cd1c372abd=
1d
        new failure (last pass: v4.19.265-cip85-rt27) =

 =20

