Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EBBC4707B
	for <webhook@archiver.kernel.org>; Wed,  3 Jan 2024 08:43:13 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.13769.1704271383407567768
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Jan 2024 00:43:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=EtoXJBry;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d4a2526a7eso17313435ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 03 Jan 2024 00:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704271382; x=1704876182; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BauMpHKzI3rTAEfxoeLbM/3u8yRI68xnrNH5RU77GSA=;
        b=EtoXJBrygoIrf0DzlpmOd4SwbBnYU3OCoqQOe7jHJ9QBgCbXY9+m5xY2+DDM7Wm8mS
         uzYGaL3ORlIXk4vJ7cx2gi9DUkGr/rL3eOYssdg1jLeYXl8QbWS1aogZaQ+kin83okY3
         CJFoaAj1iAggW8ZmGHAy9QzQT2RUcwj0UMeincLoxsg/8wDIlJM+7bA+De6hzbqm0oQi
         D6afXCxPxW0aXOi5YvU+VXgT6Qpub5izL1QNVtEaDsN5XY7wjyr20ZzjDjWnNcj+e+ng
         nFYvzbsZrNRi6Fvl4A8WKdLftbVO/SqV39fkiHR4/csgJVfh9a9VTvFZC1qPJR6bk37g
         kjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704271382; x=1704876182;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BauMpHKzI3rTAEfxoeLbM/3u8yRI68xnrNH5RU77GSA=;
        b=ihMNwc+JR8Z47mYaY9pZkJyGuYhJxOyVD/jhF/lWpT79QWrXeC1qdFEfDSmgNj3oKd
         Wu3GDCa8qnvTrRFb993ogqw1+1iT9Oc7gih8lMo8fO466D4fbFylfSgXdjSZTOa5iugi
         4K6tTWiKA9O9j7QbF5MolBAWJMXNmsw8THpojuY2tE+rxukNm8pqM3gkdfqQNSwtIBM7
         GU4UcJxsA4ymKBqib7TsyP10VWXBUDyvwrMjUvXeW50t8fFafLabsaPJ39jB3yVACdSS
         1GizuoZk1W00jalx8LUx8gr7jcRggquMgFU0M33LcsaZm/OculxfINzzza0GKzcd3tNp
         GkIQ==
X-Gm-Message-State: AOJu0YxcmNtUUQXOaUUN4Z2u3ad1BV6ieejih1U/Z6vDfxtu3yy4WIq1
	RsKwpTKK9po72MUMRjkiuwIbDI7KfksfdyK49T6sMdHYITU=
X-Google-Smtp-Source: AGHT+IE4bFFEJpaSokp9Q3fcV8bfYXteGald7uyBgRXUDZOx4Eow82cmGCM29I49NmRzNuPIu0Q+LQ==
X-Received: by 2002:a17:902:64d0:b0:1d3:f795:fb22 with SMTP id y16-20020a17090264d000b001d3f795fb22mr9221436pli.62.1704271382458;
        Wed, 03 Jan 2024 00:43:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x1-20020a1709029a4100b001d43d129c30sm18926630plv.200.2024.01.03.00.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 00:43:01 -0800 (PST)
Message-ID: <65951e15.170a0220.6d909.4e3f@mx.google.com>
Date: Wed, 03 Jan 2024 00:43:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1224-ga0ac575eeff8
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip ltp-pty: 3 runs,
 1 regressions (v4.4.302-cip72-1224-ga0ac575eeff8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Jan 2024 08:43:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14243

cip/linux-4.4.y-cip ltp-pty: 3 runs, 1 regressions (v4.4.302-cip72-1224-ga0=
ac575eeff8)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-1224-ga0ac575eeff8/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-1224-ga0ac575eeff8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a0ac575eeff89882d3aa16d67979a86e668f5d1d

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


  Details:     https://kernelci.org/test/plan/id/65951197a93cfc2b1577b5c9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1224-ga0ac575eeff8/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1224-ga0ac575eeff8/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65951197a93cfc2b1577b5=
ca
        new failure (last pass: v4.4.302-cip72-1187-g657481329b53c) =

 =20

