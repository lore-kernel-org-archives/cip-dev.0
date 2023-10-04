Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBD8E7B601
	for <webhook@archiver.kernel.org>; Wed,  4 Oct 2023 12:23:11 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web10.16889.1696422181834119419
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 04 Oct 2023 05:23:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=TXU2VG6D;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1c87e55a6baso1083785ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 04 Oct 2023 05:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696422180; x=1697026980; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YmVK+dH1nDVG0XmPBzFCt+O/5stjL0N+2qEluZKtSIA=;
        b=TXU2VG6DllcXnm7uNl3sFqTcuyQFRor2VZKEf8Y3V8ICZw2zUgJmeh17JB7ZLaAvC8
         gYcCq6BoKn5CeOVe9/z3pkbVeqrPd1tkyD31Sh4txKelDLJpQO8U1pBAGwFupyIearP0
         nJnOXQCDOcN+odhbG7GxqHUCm7QRhpsnzJC8enX2szYo90hG9bGu0pCHbAVAgR13M9KD
         0XTAtC1abeHd6sRjHQ7HL+QFfd9x6JkfLWc9pvOP4WhxuMxIqgC82A5tYEVigqkXbOrB
         KuBSZitmACVLAsHlIqKlnOxaG9fO0lOw8XxozlNVEZ0QYC+TCD4o7Oqp5kPA6Q67otTH
         9iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696422180; x=1697026980;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YmVK+dH1nDVG0XmPBzFCt+O/5stjL0N+2qEluZKtSIA=;
        b=k6HYihcK8AtUwJmLOwQeqd4reuQa6Iw7w/LXgExv82adJzLSMoJiTS7OMRt9rTVaZl
         TkKrLG4bsDvw5e+/QRD7z24CBiPovzdmDm3CJppKf5D9GocqEK7Ak26uc72GavVz0x70
         vikYmrcWNAk+E15udJnwBxNWKoPwC2F2NdFhXk+r7Sy9DsSyKoKvRoPy48pkGSNAM8gx
         ckg8BPLZLypkCeB7a3AKwlIUgJLZMNQDMQ+1/pf24o23FEJeMRSvGTfEajpevovkoF7Q
         YLpIxliY3D0JJYpnfS+pzOLjNW2utw032FY3bgMemFTiM6Yz0gu/DCXbLJ0GJmV8CRVX
         K3dA==
X-Gm-Message-State: AOJu0Yy1tW0zxT52gWJPoXWMPRKOi3gAc/JIsKAq2kwPP5NvltLT9shL
	eGuVw1B7xwPilhqk3V7Kri4xpKATrHsdwDgF2s8upQ==
X-Google-Smtp-Source: AGHT+IG601mlAcGOrYglHAKnr6hivvXcgxUD/p87L9sgU/rnZOsqJB44OaZlPZif5pqNJLJwGfGMaQ==
X-Received: by 2002:a17:903:2788:b0:1c0:d5c6:748f with SMTP id jw8-20020a170903278800b001c0d5c6748fmr1805758plb.67.1696422180576;
        Wed, 04 Oct 2023 05:23:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d30400b001c62c9d7289sm3551410plc.104.2023.10.04.05.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 05:22:59 -0700 (PDT)
Message-ID: <651d5923.170a0220.c95d6.8f1a@mx.google.com>
Date: Wed, 04 Oct 2023 05:22:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.194-cip39-1-g53e59f50ca3ff
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 2 runs,
 2 regressions (v5.10.194-cip39-1-g53e59f50ca3ff)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Oct 2023 12:23:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13282

cip/linux-5.10.y-cip kselftest-seccomp: 2 runs, 2 regressions (v5.10.194-ci=
p39-1-g53e59f50ca3ff)

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
l/v5.10.194-cip39-1-g53e59f50ca3ff/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
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


  Details:     https://kernelci.org/test/plan/id/651d52b3f63419ce398a0a51

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselft=
est-seccomp-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselft=
est-seccomp-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/651d52b3f634=
19ce398a0a52
        failing since 116 days (last pass: v5.10.180-cip34-26-g462b2292d23e=
6, first fail: v5.10.182-cip35) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/651d50c662f9be762b8a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-=
seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-=
seccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/651d50c662f9=
be762b8a0a43
        new failure (last pass: v5.10.184-cip36) =

 =20

