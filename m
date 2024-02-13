Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9371FC4829F
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 19:06:26 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.22109.1707851176513113711
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 13 Feb 2024 11:06:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=G7ySkqS6;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d7431e702dso40664815ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 13 Feb 2024 11:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707851175; x=1708455975; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cO9CsS90sG1sgK77id2FvqFGHFSsX3Cu01VEebO6NYo=;
        b=G7ySkqS6m3Aw6Qzyi0tIrbh5mCTv4FyQaRxV7DAap+rbZZcbIfTrp2Bvg+ZSxYn2sV
         +dVxCA9y+h8PtONNa8u9lSfNUDCVLK27LRnec0gSXYi2bCpWjacCweiXFMKUPlRxTvB6
         TqwSD5f7R8p8AmMS1eU+ZFlC+f2Y9kOrdUbQmAuohCY88ysAdbZOOfx88SoXEQ7t9vKI
         z0eln59BLcBg6VqMDZDCat5drPXgMni+JAH0R1cZnl6cbEvpcf6gHEzmZz+gDrpoufZV
         gJFqL2GKV1fmxbyNShsc9dnucJm1UcT0PRIGVetwctP1HdrQOM9aZqSX3lgZJNQ1+cEd
         Q15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707851175; x=1708455975;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cO9CsS90sG1sgK77id2FvqFGHFSsX3Cu01VEebO6NYo=;
        b=r1opAYyoLviqbD6Zo/rF1Ojq6dhNEKpAbMr+uO/kZIe90EomyGDU0wQdKWpATg9Tdz
         Ucygm9X53cggDn2xGNmtUzFQHGQWpyDbXWCapUC0oJ12vvSIvOI4WLVkOLRgxee5Bn4I
         tmgNvNCU2SBUjRnHwUyyrHYQ9s0Iw4alMdDYUbZ9iHbr0aMo1O4gU5zdhGIxsdgpnCMx
         8h4UoYItQoxGUhQJMBUIOddZBRZUaVrYZ0y4FPZOw9M2YJG+RHAlte96FD3kk0FE+c9j
         hIBrT6sfXLibyEhzkenNY+cCsZG/r6msac1bj86YHQFGnyoS2SY3VUqYKa6/lzqK3YSp
         Ak5Q==
X-Gm-Message-State: AOJu0YwDeEJFpZGQuj4QiUoS5LJ5fACqzLWhlyQipMJJZeR1sc6/XTnY
	ttbHST6vYU5qBPGWBe6ldvjmx+6DaZYgxfH3ZmnrKC+LdhAvUZW+JP5rVGDTpJvTrrJaCW6m8k2
	/Iyw=
X-Google-Smtp-Source: AGHT+IHxnrpkN+WWc/J7zPAwygk+lYFg2cWaTIS3GQ73/Geic1J/m9jIYNOFnJfsmpQdsu96N17EOw==
X-Received: by 2002:a17:902:ea91:b0:1db:466d:f2fe with SMTP id x17-20020a170902ea9100b001db466df2femr476577plb.21.1707851175487;
        Tue, 13 Feb 2024 11:06:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXxmSn+MydV62RLm2selxPgDdPv4lWmMSYywk9QlNrTNmOU1CY5/PGPu0Le8MD2YbnS2Bal8i7av+hDXerw6vl33YA+TZuHXOAKrlVubApZbkSuXHaHGGvca4gR8qwKJ5hjj96mEUIvbgd3sgkOuMi3kw==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id kk11-20020a170903070b00b001d8a93fa5b1sm610917plb.131.2024.02.13.11.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 11:06:14 -0800 (PST)
Message-ID: <65cbbda6.170a0220.89e9f.300b@mx.google.com>
Date: Tue, 13 Feb 2024 11:06:14 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44-51-gdb99ac443b0da
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-pty: 11 runs,
 1 regressions (v5.10.209-cip44-51-gdb99ac443b0da)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Feb 2024 19:06:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14949

cip/linux-5.10.y-cip ltp-pty: 11 runs, 1 regressions (v5.10.209-cip44-51-gd=
b99ac443b0da)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44-51-gdb99ac443b0da/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44-51-gdb99ac443b0da
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      db99ac443b0da75f00a4fc49e0040ac5dfa47e72

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65cbb10031b110a051637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hi=
hope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hi=
hope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65cbb10031b110a0516370=
13
        failing since 95 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.200-cip40) =

 =20

