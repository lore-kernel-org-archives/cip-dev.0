Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96153C46CA3
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 14:02:07 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web10.84741.1701957722035308842
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 06:02:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=OcUGUjNN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.182, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5c66e7eafabso727671a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 06:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701957720; x=1702562520; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YmdvXnx4thbrT4PjzIm/OSJnmm8HzuuVZyjrgIq0hkI=;
        b=OcUGUjNNo8+IE0IUQjbDNo86me2ye+WU5O6wEtrt3vsycZ5TLXholmcXu+3gBMpQ83
         XG2U6WvUuy5oCZ1gvUZ4enBGbuvuOEApeB3lPwCuOW/OD6sSRcIlKu2IBGX5C1XrF8Ts
         2fy89Ui63AMrJKPe6cOX0UXtjvkrPo3p+wlB4GwMaYtaj+9O9PxrY2GdD+24cduPI1VB
         my8rmwB/32GZXFXEI4KjZjDAW9xhRrbru6ORV+LGceFHKphhKGnhUvyziRG0vsgwM3wA
         wFR0hgDR40ZI7jhrDG4LMFKKKbEl7wtZoqDVisOnf6gZFOgHrNDVeHmC8/bxs3tAhInR
         nLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957720; x=1702562520;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YmdvXnx4thbrT4PjzIm/OSJnmm8HzuuVZyjrgIq0hkI=;
        b=DH2us1hlYtcT9zmnfruWdup3dzJhNfMps9PhlvEUHHlciiB0rdqEBSaWA0LUDKGCeB
         EeK7QCn+lu3emwNANxJTO/nvwqa2GSaoLoC2yxeAnBmHdFy5f3tW7LYdg53Ers1Po3bG
         fZXwR92w8RREOr9ndCVxCgyBmJ2/xoFF3ejUvIbTMhJDHC0RHKC/Iwrjrc/QvBzA5LZE
         W62uclAbTZvs3r6G37LHe9QgFNmqiMrJ5VG3Ve2Kx3Jn1cOzvxJQpTVocui3wAi8BB88
         08cABHbuuiv4bDkYdPzNmuugekS5bvYiKCBCTJgxyzNFlEKfQjnrNeWc/lritoxBvPcc
         Ox2g==
X-Gm-Message-State: AOJu0Yx3M5HsapmbDAJiPlyGvmgorBC0kDT/feasEYMxJRfwl6LGcHS3
	icU+FFGgq53OqAgauDBPvvBQJVaH0xOsEGJ+y3EW5w==
X-Google-Smtp-Source: AGHT+IEhMdfwO5bbztIKUi64T1Ns57CejxetGa0nrz49Sy2g6Kjfq9OBtX5dEqBuroJXrncIMBaxzg==
X-Received: by 2002:a17:90a:345:b0:286:dd9f:fe39 with SMTP id 5-20020a17090a034500b00286dd9ffe39mr2726423pjf.55.1701957720453;
        Thu, 07 Dec 2023 06:02:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l18-20020a170902eb1200b001d0a0ee28desm1438203plb.251.2023.12.07.06.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:01:58 -0800 (PST)
Message-ID: <6571d056.170a0220.8cc17.31c6@mx.google.com>
Date: Thu, 07 Dec 2023 06:01:58 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-16-g3c85fba3b6e5d
Subject: cip/linux-5.10.y-cip kselftest-futex: 9 runs,
 2 regressions (v5.10.201-cip41-16-g3c85fba3b6e5d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 14:02:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13869

cip/linux-5.10.y-cip kselftest-futex: 9 runs, 2 regressions (v5.10.201-cip4=
1-16-g3c85fba3b6e5d)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-16-g3c85fba3b6e5d/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-16-g3c85fba3b6e5d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3c85fba3b6e5da8b112e7ecd142649674648028f =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6571bd1cb8500937cde134d6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-broonie/kselftest-futex=
-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-broonie/kselftest-futex=
-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6571bd1cb85009=
37cde134d7
        failing since 13 days (last pass: v5.10.200-cip40, first fail: v5.1=
0.201-cip41-11-ga539098fe70dd) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6571bad9297c8bddc3e134d0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-cip/kselftest-futex-r8a=
774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-cip/kselftest-futex-r8a=
774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6571bad9297c8b=
ddc3e134d1
        failing since 13 days (last pass: v5.10.200-cip40, first fail: v5.1=
0.201-cip41-11-ga539098fe70dd) =

 =20

