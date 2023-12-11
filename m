Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A45DC46CC6
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 10:52:52 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web11.5749.1702291966548516336
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 11 Dec 2023 02:52:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=etsIX96x;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ce934e9d51so2601830b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 11 Dec 2023 02:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702291965; x=1702896765; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WS6DVJKvpf7hCwW9PbJuxRkKJ/ahcSTiSFGRQdasFOQ=;
        b=etsIX96xR05l/YAEgb7UbRE3L0m5x31wi6MKW23pHuZyMWCAZSGbiYEkEZUtLDIX0N
         uZWWcgICP9c+6eC5S1Y4w8XtIyKv4BnzUTVL5ReRuEs53RP1E3TYbxrMrf+Iu4EjSZPZ
         nD9b2PkafAI3JR8fEPPpkVlGg7wxR05oUU5lyHTitStz3Wfu0W8XA6gvrQrvw64fS9FD
         LpbCHk2klEJQJZuPA5fNZ0+Un/P5q7llhZ4xG6HfB+DUAAjzWe4FWlWjvScekTsuvX6l
         WuXklGgxSpUVXEea2WosoAIcL6YpaAupkUlPjNjXc7t+SiEoo9sJbINxJv/O95j0vm35
         2qhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291965; x=1702896765;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WS6DVJKvpf7hCwW9PbJuxRkKJ/ahcSTiSFGRQdasFOQ=;
        b=tch4frGF/z//RlgOEeO5oca81flXKJJ0aplkhOMpBzKY56km21ofe9mtqsOlrGaLS3
         xL9q0oMNinVag10BE5R3BC/KJl9UojV9p+JbJMmA3bsgtkWnx1KPpX5qTpuhoLMgKAiv
         njoZixBHDAgzuqAZFvGsATeBHSwOEqVD4AMa0hrCL8ZQk5gxEECLccILslxi+Yukb4MV
         NVld0yG2pHHTEiqqVjGq4HuD2zCjevlGFSsDwstzT14gC2IPbeof/Fg1WcH69dx+dfPm
         V4g3xSlaSnFlbPMFNlGmPUIV7r9xXsX4gCEogXJ59mizJY05vciM5eVR/jyGpW/tJob3
         oxZQ==
X-Gm-Message-State: AOJu0YwPjBVf07LL2hwM6T1ZSSHBde6iPjU5PfIuQATwvSLyMXbDWjEm
	nyMd7naHCR/gZH8nw9zOypMHKufJNQJWvM4DqUxAXg==
X-Google-Smtp-Source: AGHT+IHJro2D/k8kLshZHxXj2cW/n2rvKBV80/ILbMoQp9n5RuJ1pvVTL5MXyxz+odduD2jSpsUi7A==
X-Received: by 2002:a05:6a20:7fa0:b0:18c:92f0:69c2 with SMTP id d32-20020a056a207fa000b0018c92f069c2mr1999188pzj.39.1702291965465;
        Mon, 11 Dec 2023 02:52:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l15-20020a170902f68f00b001c9c5a1b477sm6347172plg.169.2023.12.11.02.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:52:43 -0800 (PST)
Message-ID: <6576e9fb.170a0220.2e27a.0ac2@mx.google.com>
Date: Mon, 11 Dec 2023 02:52:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-63-gfdfe1fbf93bc6
Subject: cip/linux-5.10.y-cip ltp-fcntl-locktests: 8 runs,
 2 regressions (v5.10.201-cip41-63-gfdfe1fbf93bc6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 10:52:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14010

cip/linux-5.10.y-cip ltp-fcntl-locktests: 8 runs, 2 regressions (v5.10.201-=
cip41-63-gfdfe1fbf93bc6)

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
l/v5.10.201-cip41-63-gfdfe1fbf93bc6/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
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



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6576dc5dc7408f469ae13492

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-broonie/ltp-fcntl-lockt=
ests-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-broonie/ltp-fcntl-lockt=
ests-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6576dc5dc7=
408f469ae13493
        failing since 1 day (last pass: v5.10.201-cip41-28-ga386bc478aa6b, =
first fail: v5.10.201-cip41-46-g596f4c151d286) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6576dac16c67a63d62e13476

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests=
-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests=
-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6576dac16c=
67a63d62e13477
        failing since 179 days (last pass: v5.10.182-cip35-1-g7cde3fba93966=
, first fail: v5.10.182-cip35-8-gdba81ae6f2be) =

 =20

