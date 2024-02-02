Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A594C4828E
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 22:34:47 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web11.5941.1706913285003178458
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 02 Feb 2024 14:34:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=J4ebJ83W;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6de2f8d6fb9so1931402b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 02 Feb 2024 14:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706913284; x=1707518084; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t9TPuL0CAD6GGBpmedqlYTEPK9fHFUVH5sWQaUGRFkE=;
        b=J4ebJ83WlOHg/x4J4LVVyvZP4iC43WC5eHLxYz0QuAKWvxlxucrOuc+mpI1IZ5xsSb
         PeG3h5wMVnJKy3Brp3CJZtlzkcx5dngzJz8S4xkI9CAU9XVJTG5vwYNX0Yf2KRwxiKMb
         eOGiuKLXRFFCuaXjJmYT5yu0q/wP/b++++2x7IPYmCGYVSwYmQ16UZQxuMB9WRgnuy4t
         87/WSSHcPMLs30ZvZ9jHPvVAG5atAseUGI7OQE5lIL0ikQPS/HcxfLrpgFkmeBAN/LC4
         EstWowJT5tuexHNo1ie6DhACMvGcd5HVwuUu07ZDVl/xK1MRtVECBVz6Y8uIwaj7/iZD
         LvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706913284; x=1707518084;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9TPuL0CAD6GGBpmedqlYTEPK9fHFUVH5sWQaUGRFkE=;
        b=coizl6BDAVEdME6tJdnM4K/8PjT7ttdzbzy7uzecv8ZIf5hGHMJdDNtViZmqJtvZIJ
         ov2ZRaW5Orlv3/HqT/zsrlJpEUYuPtux2y+VrP+Uh4/AM2lgZAWKdP4fi1avPgXd184O
         djTy81Frm9w405z+82eo3ePsWtR1K3TwAWOLP1hPl+KlTc7gMrWa079WnLXwKEEhD2Np
         LQopW36RI63qXxk408lQqTeR65MuwSavyChEbN4fvRynElPiG0lWFuUexhi5FYOUMNJO
         2LnZGlT8DBZ3YJkbMrv1dWucDI0dH1yoblGq59Bf538iPgX+eLgBlYXaY7TI9JToTiWF
         Wsbg==
X-Gm-Message-State: AOJu0Yx0vpvevg+Fz6TtgR5h7NJNOxglQauZqzDsZHwZmL9pMbC0B160
	QyanwIQfy5bR5zHMbHEQfreZjVTN5aZIHu7dhiMPQr8RFBYlJGs7c6scoc6QyZun7UyYLs5xGI4
	nqei/wA==
X-Google-Smtp-Source: AGHT+IF3YnFBXYpzBYnFAWJ63EyvvmJYkR2AGxxAyRz+0V8dULSLGh+dqzRvZP6w55G6xyOVFxpWlQ==
X-Received: by 2002:a05:6a00:2295:b0:6db:ca49:9ce3 with SMTP id f21-20020a056a00229500b006dbca499ce3mr8674431pfe.6.1706913284112;
        Fri, 02 Feb 2024 14:34:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWQa9GkAgCyzhUzUoN4BNl2veyvEhJdRJKd5a/PIxLRHSbxo4rVUBopmKsozabLuMh/8H7XkZP4Dw7/d3hSXBT1OkauRa9otLhhe2rXiAz6NKocKxxIDAn2RdUUjOMkM9uRcI7YUF1kGPns34auo0Xflw==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i63-20020a62c142000000b006dff2eb3a59sm2227903pfg.126.2024.02.02.14.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:34:43 -0800 (PST)
Message-ID: <65bd6e03.620a0220.f826d.9c1b@mx.google.com>
Date: Fri, 02 Feb 2024 14:34:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Kernel: v4.4-st20-2045-g32c8d563e356f
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st baseline-nfs: 28 runs,
 1 regressions (v4.4-st20-2045-g32c8d563e356f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Feb 2024 22:34:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14637

cip/linux-4.4.y-st baseline-nfs: 28 runs, 1 regressions (v4.4-st20-2045-g32=
c8d563e356f)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
hp-x360-14-G1-sona | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig+x=
86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st/kernel/=
v4.4-st20-2045-g32c8d563e356f/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st
  Describe: v4.4-st20-2045-g32c8d563e356f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      32c8d563e356f1b156afc0ba28f0aee7561dd2b6 =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
hp-x360-14-G1-sona | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig+x=
86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65bd698c6fb0721cac00a052

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-2=
045-g32c8d563e356f/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-2=
045-g32c8d563e356f/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65bd698c6fb0721ca=
c00a053
        failing since 30 days (last pass: v4.4-st20-1988-gdf21aeeacf3cd, fi=
rst fail: v4.4-st20-2023-g7107c2a794ba) =

 =20

