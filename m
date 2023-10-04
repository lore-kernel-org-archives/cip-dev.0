Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A63DE7B604
	for <webhook@archiver.kernel.org>; Wed,  4 Oct 2023 12:23:11 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web11.16794.1696422182180487303
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 04 Oct 2023 05:23:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=NBfHw2Yv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1c62d61dc96so14510025ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 04 Oct 2023 05:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696422181; x=1697026981; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BJ4zBghj5AIciac4uaOeB25oYpluItSQirQxflJpTdY=;
        b=NBfHw2YvsT978QZ6u9x8CtQ36AFlIzSuaznjs7rgadJbkoEq84cH7VMi5Rvse1sZAk
         WCVn365P+apBJEC7kkw+5Xa0J0jGu0iCZGH50wGi1TdzOealwXU6KizPIPOXlxnTQ7sb
         akgd00LFu+8V/Mkb0Tc4l8h4plru8CBjlULKA3zikxUFRFbAF6pdOQFwOgCO52+8RKqm
         0Lp9njQJwI4E9wzQt1Xx1E5545lpiq0hCf3YhwXLFVxwzO7QeE3RxTH9+3ol+cyFy31D
         eEzAZaM3GMV2zPde0MC3t9ccBe7G8D+uLItnmNHYDiBaqh1h6+B+yfAlfk3QHGneD7n0
         zCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696422181; x=1697026981;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJ4zBghj5AIciac4uaOeB25oYpluItSQirQxflJpTdY=;
        b=Y9DbIY5ECAoVW80vCipL5Gpd4d3YwnyfRoDrVmObMtcYBhxyUHj447dW+nw/FNL3qw
         aTZpVx5YpZN5uFjBM2RF8OlSY0t4pvWSY+X6rsI3SvbosYIaxeApwo36Qx3XuiuxbOv7
         Yr6K5pX2OBBQqIw2mE6C5ElDo55/8aWQe4Q7FPOV7OIqTBa7O4g9XKRBtBZ9numE9vYB
         8DjLNDPvQXQANmdUPzgek+Hc5rDpyzG7UN79DYd9fEwyViErtR3Za+vQPiTnyr0sLXc0
         CoQtn9c0702L2RbfNzkZwbx6yk8zlDpIfrWy3cGVo5KOG07wtBZCftOBrnFZmGnpws4i
         4lHQ==
X-Gm-Message-State: AOJu0YyDDlLSbEzJ1QVWvS1WJh6zhKoNHsrdV9BVfEZc/dhikFqgT53T
	JvAEThxTVNHl8n/GLi7xaIuK+DzVYlSCedWVnb5rig==
X-Google-Smtp-Source: AGHT+IEj8RAs8+Uxzri2xsuEompeddKkN1oPHFfNtyIOuFYj5clqnz+9HCkgluEil/yzpKmOD8YE2A==
X-Received: by 2002:a17:903:2287:b0:1c5:ff18:98af with SMTP id b7-20020a170903228700b001c5ff1898afmr2627896plh.4.1696422181259;
        Wed, 04 Oct 2023 05:23:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jc4-20020a17090325c400b001b53953f306sm3559113plb.178.2023.10.04.05.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 05:22:59 -0700 (PDT)
Message-ID: <651d5923.170a0220.862a9.8cb3@mx.google.com>
Date: Wed, 04 Oct 2023 05:22:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.194-cip39-1-g53e59f50ca3ff
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-lib: 3 runs,
 2 regressions (v5.10.194-cip39-1-g53e59f50ca3ff)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Oct 2023 12:23:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13283

cip/linux-5.10.y-cip kselftest-lib: 3 runs, 2 regressions (v5.10.194-cip39-=
1-g53e59f50ca3ff)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.194-cip39-1-g53e59f50ca3ff/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.194-cip39-1-g53e59f50ca3ff
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      53e59f50ca3ff023b612a48397ad7e057a9fd408 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/651d53d21de29cbb558a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselft=
est-lib-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselft=
est-lib-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/651d53d21de29cbb=
558a0a43
        new failure (last pass: v5.10.184-cip36) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4ed74fff4160528a0a65

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-=
lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-=
lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/651d4ed74fff4160=
528a0a66
        new failure (last pass: v5.10.184-cip36) =

 =20

