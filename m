Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5B0C4828D
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 06:05:29 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web11.14566.1707285928535072562
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Feb 2024 22:05:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=bDvq9SmQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.182, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so153829a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Feb 2024 22:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707285927; x=1707890727; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jkvXukoabGAMlRbEiFjffLlAjAf84WJ4BqnvyHeoWbQ=;
        b=bDvq9SmQSlxD79+6norm4d3CgkmuwouIPsugMRXaiuXm+sQJeMPbsAgsHqOUOhFRO3
         NL/fKghrCdFowW6LcVdtGeHnMt7HkqgaBx/Qdf3uqdmLup/Fpf+G7eXv4B1yRSqCU36c
         LTh92o+S4uFNWPeo9zTZIHq1V5mw08apbgYI2dZ+khMCELwSB8BaOQqjJ4cZv37g4iuT
         enFRUvuKWcKkY7cMebop79mxrc6wB2iWDx6070jg39WyZF3X+PbQZ282hbaprSQT7PO3
         ehJOC12vY1KFslwcgdwzd7uALSI6rsbBb6anwi6KE13X5/Mb5CoEvuLFkb5lRJgwMbVO
         c/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707285927; x=1707890727;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkvXukoabGAMlRbEiFjffLlAjAf84WJ4BqnvyHeoWbQ=;
        b=EB81HALNDwPqu6aJz+c987Cs7tTnc1vvCraqFfWiK816znsXeg3EuiBsa/I31alRYt
         2aUVxfEonqn5FKEGjvOwfU6KBDMXe8rXwxEc0Ozz3ATqdH674VVKP8JFJ+bAt/8t6ynC
         Lp3G3AV+GoBINnS3HN1GovQn89oaU/zlrcWLcJ1fpXIDUfsR/JI7bdm+kiqZYX8/hLoD
         bRBoWz1wezYEZn6xLtQELepQt6T7z9FEBMe6DWn6+sJbsrkf/EN6j43k62l00qM7r/L9
         1IDfe05TFKObH5OpVWtyFPsdTUUKBhNPw41dkmI2/+zGWC3SKTWTkheudVKC/QjhB9/l
         2XUA==
X-Gm-Message-State: AOJu0Yzhy+pJC+ZZkpzFMk53nDAW0ixAYUIyoaJwNL2yocO4lmdiXtxU
	+Au+V7I36WcVqYV04GOLuBL/8G6+y/Y4Fudi3LRYLcV4XFOoH71YGGP0v17mWRuCdpEdpz8uCdP
	2
X-Google-Smtp-Source: AGHT+IG7YJDR5JioFgfkKn2kx7LWCJldKBTI3Diy+kF1V2xkOBnNEHC/61hHWCh9sAd4exR0aPBf4w==
X-Received: by 2002:a05:6a21:348b:b0:19e:9a10:5871 with SMTP id yo11-20020a056a21348b00b0019e9a105871mr4214567pzb.32.1707285927497;
        Tue, 06 Feb 2024 22:05:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVIaEZ8V4k4njzKPuxoTKjV2+UYeDwrRXFlo+ZCGwXJ/tMbsPzm2s7b7RS/2Tx7H392QLDhCfofycGMYQ4LOdj95vneYOSMWkHwtaEOqFX6yrLf4zMep/Tm9zhT00hD0DY8e5atCUFlHjDb9l8jpQ3P1w==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g23-20020aa78757000000b006d99f930607sm579945pfo.140.2024.02.06.22.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 22:05:26 -0800 (PST)
Message-ID: <65c31da6.a70a0220.e26f0.18f2@mx.google.com>
Date: Tue, 06 Feb 2024 22:05:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1250-gd530578b1386
Subject: cip/linux-4.4.y-cip ltp-pty: 3 runs,
 1 regressions (v4.4.302-cip72-1250-gd530578b1386)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 06:05:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14873

cip/linux-4.4.y-cip ltp-pty: 3 runs, 1 regressions (v4.4.302-cip72-1250-gd5=
30578b1386)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-1250-gd530578b1386/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-1250-gd530578b1386
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d530578b1386a94e84c4ef7993e59fd028af441d

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


  Details:     https://kernelci.org/test/plan/id/65c310e0877a816bca8e1e87

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1250-gd530578b1386/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1250-gd530578b1386/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65c310e0877a816bca8e1e=
88
        failing since 34 days (last pass: v4.4.302-cip72-1187-g657481329b53=
c, first fail: v4.4.302-cip72-1224-ga0ac575eeff8) =

 =20

