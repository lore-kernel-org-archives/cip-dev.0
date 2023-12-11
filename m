Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9850AC10F1D
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 10:52:52 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.5750.1702291967115065301
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 11 Dec 2023 02:52:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Xr2W/L3T;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d32c599e83so1315545ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 11 Dec 2023 02:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702291966; x=1702896766; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PgMe7yrHf+D7zbQYc1ARBroEKLHAp3jHfwsvJFQnaSc=;
        b=Xr2W/L3TX70qq26CxZjyd/NNa3eRABjvym7RNaQKJY5x+ubNfs2P8g+L1hFQzusn9p
         403dwAajDbO4uYyl7ikskFxZkOj7/dG52B9FvoDF1ocO+JEi1s/qVSMKwFfabK//DWw9
         VlbJuZGOtf0/WgsiWbJaE9X7omF3MYL+JY45DZ/N3jQJeVz9EPB7bTKQ7LzValR3nhxx
         VZg/bTbAIl6MHNDFVzWR3KGU3VKarcei+BnJm+NqQG4VaUabk/+cQgdb6O0CqUUfARpo
         uDlfLrWf1Bag9cza+CypZlldl4XZRiR5IrasPvdyc6ZNUHb0W6XKG4oQRHIoseWlqu0D
         QTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291966; x=1702896766;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgMe7yrHf+D7zbQYc1ARBroEKLHAp3jHfwsvJFQnaSc=;
        b=w/IBaukCBPckMCO2iXuDIjN3m+v9qQoKZjAsnm/3teRYLUsKYeBAQiY1J/3JvYQDkO
         Up0Xx//JPbVe4KxIsIwsdwEZsDCi+9biotDakPR+6oYNaY81Bqg+V8nplLM1YM4vx6zH
         +w7qN3YZLBr4pPdjg8hdcSsKkCwxo+wC7USMP/P6DwXpVzctq+lU8Agb0jutfgQ+wIvE
         hZQC3+deRosHW/6LXMDlTiSC/2knqXAyKEWw3EKCTZHiIVeXRrNSSieiMi4WEs/MxwVk
         dP2HJr8BfjnvbgOeQmNM0w4T6pBUSB1fQ7tyoxlqsXO8agtJuHx7s5BJ8KQzdyq/sdgL
         9L4w==
X-Gm-Message-State: AOJu0YxLvBzP3vXrWm6HaUg8g8oLuHxttID75LPYBFyHw9Q82ezaP7AO
	OE6HgwySXn8QDWvHjl285i7/1kIlimTGRtVbgRUpdQ==
X-Google-Smtp-Source: AGHT+IHyeWfU9BEM8z5AX1IyfO+JXC1l8OmBpXljdpij7bDoI1YXDW5EvR87U302nnPqmIJI12Llzg==
X-Received: by 2002:a17:902:e5c5:b0:1d0:91a0:a05 with SMTP id u5-20020a170902e5c500b001d091a00a05mr5011327plf.37.1702291965842;
        Mon, 11 Dec 2023 02:52:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090301c400b001d0c3328a63sm6308299plh.66.2023.12.11.02.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:52:43 -0800 (PST)
Message-ID: <6576e9fb.170a0220.4e2b2.11e8@mx.google.com>
Date: Mon, 11 Dec 2023 02:52:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-63-gfdfe1fbf93bc6
Subject: cip/linux-5.10.y-cip ltp-pty: 6 runs,
 2 regressions (v5.10.201-cip41-63-gfdfe1fbf93bc6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 10:52:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14011

cip/linux-5.10.y-cip ltp-pty: 6 runs, 2 regressions (v5.10.201-cip41-63-gfd=
fe1fbf93bc6)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-63-gfdfe1fbf93bc6/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-63-gfdfe1fbf93bc6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      fdfe1fbf93bc6fe6ed2708f11c2613bef556fdeb

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


  Details:     https://kernelci.org/test/plan/id/6576e1b44d6bbc15cee13493

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-colla=
bora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-colla=
bora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6576e1b44d6bbc15cee134=
94
        new failure (last pass: v5.10.201-cip41-46-g596f4c151d286) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/6576da24e0c6151fd2e13481

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hi=
hope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hi=
hope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6576da24e0c6151fd2e134=
82
        failing since 31 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.200-cip40) =

 =20

