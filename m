Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C3DC46467
	for <webhook@archiver.kernel.org>; Sat, 14 Jan 2023 03:30:19 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web10.109131.1673667017755139227
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 13 Jan 2023 19:30:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=BBrJZ05v;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id gz9-20020a17090b0ec900b002290bda1b07so2533526pjb.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 13 Jan 2023 19:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cM7P4kXtf9X9fqbcfm4L+hsl90jem3NdM6A8Ad3SWOc=;
        b=BBrJZ05vODUi39+9ETNA7pw444J0Bqblof0uJspHzmIGx0G3Tg5j24UF6b3QrwpwGg
         Lz2n02clx9wWzP66Id6WGOGJwE1TRHAZiotadm+qWAk1e0PansBh6950R60LFnVdSAZS
         ygpoB6doGl/lNyZVMKvHF+xzrkc5JmubBY3wv7mOR6ThtHxpIrs5l7bhw595FmJaS1Fi
         DUUukCGAAisjk1j97JoCbApDeAADt0m7muFRq4n3iyxywop3JDcF1rakx1pyHQ4mY8aY
         O1g5jkFY4psuiJegIhMEJuFEqtzGWH63G0dbjzp17pu+TBxO8K17d0ULsbckYq/H61yx
         kpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cM7P4kXtf9X9fqbcfm4L+hsl90jem3NdM6A8Ad3SWOc=;
        b=r/OVKWFByOIMIb9sjqSlbVGLM5uc4ktDSuAFGoDfO7zNF3LK/nP1uiMlHqf3SmjTxd
         GfBFNVzDuVLCiaALnpSYKkmrClcrlpSfrjQg+ArauG2eIpdugQVHE89lVSUlQiRmLUjy
         wt47T4fuba9snxwKinHPEVJn9IPuSYcT47n+tVppwO0pFDvZgxAaFYMxLEVx1gCTdvn/
         SDOIANu+1o/1yegv8xT91jsr9uXNO9Y+S777qSYo+lwAUUOjtZhymFfTRv9fgRn3fEVd
         WdLqNQGgGTX7XNnWEm0Wb30iuadVH3xDi05ROvYjRTsjZ8TLoGdUmk8hRMS/+cTaD/oc
         Bw0Q==
X-Gm-Message-State: AFqh2kpLVupZuzpNJIOh3kUipCxtvuBlKhek7vaXTUSxZR3yz7wJM5ov
	5O4g2eCmi5/14NlUNqYPMR5a2gaDqrYxc5crDPw=
X-Google-Smtp-Source: AMrXdXt+J0TeK97Y9lzerM3K4IOku7rA2bXLTS/2x01NvHiDui9x41Sw+KXfy2GWXkxyEKlvuBHNUw==
X-Received: by 2002:a17:902:c24c:b0:194:7696:b0f9 with SMTP id 12-20020a170902c24c00b001947696b0f9mr3356036plg.66.1673667016843;
        Fri, 13 Jan 2023 19:30:16 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b00192e0f0e021sm14842921plg.257.2023.01.13.19.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 19:30:16 -0800 (PST)
Message-ID: <63c221c8.170a0220.41774.93b4@mx.google.com>
Date: Fri, 13 Jan 2023 19:30:16 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.162-cip24
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-lib: 9 runs,
 1 regressions (v5.10.162-cip24)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 14 Jan 2023 03:30:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10353

cip/linux-5.10.y-cip kselftest-lib: 9 runs, 1 regressions (v5.10.162-cip24)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.162-cip24/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.162-cip24
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7ef5f1fda52a95426084959dac09acdb3c81327b =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63c2155a59db99c3161d39dd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meson-gxl=
-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meson-gxl=
-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230109.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63c2155a59db99c3=
161d39de
        new failure (last pass: v5.10.158-cip22-7-g92462fd9830b) =

 =20

