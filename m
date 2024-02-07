Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DC2C48BC3
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 01:39:38 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web11.10755.1707269971563101264
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Feb 2024 17:39:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Ucz4TVVX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29026523507so99802a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Feb 2024 17:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707269970; x=1707874770; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w8KqP5PjEC2WfgV4ENF7APLy4X4nEcBsXOC996VRXHg=;
        b=Ucz4TVVXCgMWIB7MAlXBcn5wlKaRF1wgvPKwPpKTkqrZsrrcKc3iSqPx5LHgO1KiAI
         05hfU76Z3PyUxvMU5rUMyjsZq0aGHsICkoQ0YNiBREPCXIYBnVdu88d4vIQqZ5oaMBBn
         +tzKvWIftuDpDeuHdvD/+TXwCDGEfO3zJOGxX8WE2l2B5+LdmptGdZ4i/CTMq8W9CKm+
         o47t36Zaz7qzDM/LOTVK+U+6U/95a1eXYsab5AioCY+h6CNK9XD5XbIfR/mG2NGFEMfo
         U5VexCivEVf/tm6qLHsYU2HOD+2T6H6liu5EPRL6aB+7lbN4rq6QtVti+Zj9tw09VAZX
         GArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707269970; x=1707874770;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8KqP5PjEC2WfgV4ENF7APLy4X4nEcBsXOC996VRXHg=;
        b=VmRcGAQWIcUSp10jpXpRr1Yh7LyADT6K2xr4vzgDGOkuLaUrWEdQ2QiU1ou4nD+pMc
         jU8X3IqDG/xdUmPhs1mcDCWShbrbQFKq1ROzJs1RkSLnqClNQDIaKaA3FVd7d78OpS85
         rMnRO2KyDmA8pe+u2/fpFMeWAJF4H/yCdXeXEeqohABd9hGGvHh5qHwth2qEigN5aszn
         bWKZvN6XS/Kx7X637oBzE76Za+JCJXkAO5qiOv0Yqk7mOMVZUAn/cHeUyOCf0vVdFJ3u
         chuHSmQosuXjl05xQ03HDZ6sOMaa+3MilRenHVa8BgWG0SrUVPY4pu0iaY2cRv31uB33
         EPXQ==
X-Gm-Message-State: AOJu0YxkzX7ZlMBLwkifzmGkx6717aYMbXWyrjM0suciXGep8XgO9zZb
	R2YAAjWN8wPKYQfJaY4BP3X1qUJxNyDf6p01UidM8cv+WEZIRVfazEAvR7QDLqXA/mI1AnCR7bi
	L
X-Google-Smtp-Source: AGHT+IF5wpd0WBDrcktjMErue+PvINg2wQ7IA5jIVcSfACXWgD+xCGRYAPmDOcAuqPBZaKgLreS7Cw==
X-Received: by 2002:a17:90a:2f44:b0:296:a428:e068 with SMTP id s62-20020a17090a2f4400b00296a428e068mr1230957pjd.19.1707269970381;
        Tue, 06 Feb 2024 17:39:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZgwvMU8Ko3J+yTsSDsJNlt//vb2l0Q6Bc24Yr5qkjV9F9bY4JjR7IhhTKTiZD+zjLGTWfIwwa6bKI4VujvF9iHipn2NOb8jbuU8y8DFtJx09M/TC1V2/GGULW4Vx9Mlkznrq0rRgWCj1n5eAG3F6V8Q==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id sj6-20020a17090b2d8600b00296b42b8501sm235999pjb.12.2024.02.06.17.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 17:39:29 -0800 (PST)
Message-ID: <65c2df51.170a0220.e5fd9.0f38@mx.google.com>
Date: Tue, 06 Feb 2024 17:39:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.209-cip44-50-ga624abaa85d7
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 1 runs,
 1 regressions (v5.10.209-cip44-50-ga624abaa85d7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 01:39:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14851

cip/linux-5.10.y-cip kselftest-lkdtm: 1 runs, 1 regressions (v5.10.209-cip4=
4-50-ga624abaa85d7)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44-50-ga624abaa85d7/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44-50-ga624abaa85d7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a624abaa85d7f3ff289eb2e257db5c4485d11d18 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d3229f0b7d74528e1e89

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-=
lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-=
lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65c2d3229f0b7d=
74528e1e8a
        failing since 125 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =20

