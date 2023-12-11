Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E000C46CA3
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 10:52:52 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.5751.1702291968791838714
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 11 Dec 2023 02:52:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=PKo/Jgzt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d2e6e14865so17555135ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 11 Dec 2023 02:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702291968; x=1702896768; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WL6sXU1xlVjDAFv82NirY5AgBCH1C/8rY9qgHwAXP+Q=;
        b=PKo/JgztGc3Dx3edAf3WMnKl1bsReUjmIaKmbE+ziPIWqFoyAJWfaoQVYHlW+n9fSF
         6qC7lD58je3tJbc/X6xCm8Wd0aCIJMEa1XpIRJUUlfDni1Y2FMqxyYN0c9S8UriK6//5
         np+Hfn9xWJL1ZnzdYogcwB22njuvQBv0OxPHZOlYPPjKh92HLcBQFuJJ0rXbwqNMWt6U
         3dUETlGGoKhLwg0eb52KXylUgMVyV2E7ICbPpXaW3Uc9JFoA1Ath0K0nxz5/AzGJBU39
         8ZYgQN+cYws2pZ1a/GH7yB6u9//YrDoU6y6JX64VinFC4Ips3GEeZDBK6cnMgxqKJsfU
         8k8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291968; x=1702896768;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WL6sXU1xlVjDAFv82NirY5AgBCH1C/8rY9qgHwAXP+Q=;
        b=OVU4vpUPtDsJ6DnfCVSeXTCASt6JMprSrR12CWCuV5xzd9vZBLI3CgEGd8qfWCyEOQ
         fwlJCBK+ZR7P/CKx9pqZGT7z8Q5v/vzcoxz6WVHakIDBGojhnngW+rA4VDetdThTCSUd
         yhi3Mvl0077Sn/5+RsnL907ZoUV6ZCKnL9YJ304oVVsg+U5UdcyBRoixHTGIKWhZggSe
         5tXUCD6rX0q+GYoQ3o2NnK7Ix82TxlC5kHGGomhYDo04RV3DxuLi/cLqY5hXZYuNp0Qn
         stlEwOvtkTc4ukRBAgNTVSwyq86DNXcoFQtFrYaKz7QPrznKDNrJn2tzJjJ7YqUoQYsl
         LYtw==
X-Gm-Message-State: AOJu0Yya81IkuEemrhZsMbU8joqN1eNTmjNSDyaKLkCUstMur+xC02W4
	pbmSw0ZqLBaDCkq7XGKOJwSL2hmChNBoCR12cjqmjA==
X-Google-Smtp-Source: AGHT+IH40dAz/o7yRvAAZcf7B2wRK88hth1MeqiudbTPkDcb27kU2iWOhMcM9kcIh3nW3QbqOFC+hA==
X-Received: by 2002:a17:902:a9c4:b0:1cf:b14d:8939 with SMTP id b4-20020a170902a9c400b001cfb14d8939mr1768684plr.63.1702291967727;
        Mon, 11 Dec 2023 02:52:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j21-20020a170902759500b001d326103500sm1066908pll.277.2023.12.11.02.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:52:44 -0800 (PST)
Message-ID: <6576e9fc.170a0220.d482e.213a@mx.google.com>
Date: Mon, 11 Dec 2023 02:52:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-63-gfdfe1fbf93bc6
Subject: cip/linux-5.10.y-cip ltp-ipc: 12 runs,
 2 regressions (v5.10.201-cip41-63-gfdfe1fbf93bc6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 10:52:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14013

cip/linux-5.10.y-cip ltp-ipc: 12 runs, 2 regressions (v5.10.201-cip41-63-gf=
dfe1fbf93bc6)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig | r=
egressions
-------------------------+-------+---------------+----------+-----------+--=
----------
qemu_smp8_riscv64        | riscv | lab-collabora | gcc-10   | defconfig | 1=
          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig | 1=
          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-63-gfdfe1fbf93bc6/plan/ltp-ipc/

  Test:     ltp-ipc
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



platform                 | arch  | lab           | compiler | defconfig | r=
egressions
-------------------------+-------+---------------+----------+-----------+--=
----------
qemu_smp8_riscv64        | riscv | lab-collabora | gcc-10   | defconfig | 1=
          =


  Details:     https://kernelci.org/test/plan/id/6576db40d5a4193735e1353e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/riscv/defconfig/gcc-10/lab-collabora/ltp-ipc-qemu_=
smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/riscv/defconfig/gcc-10/lab-collabora/ltp-ipc-qemu_=
smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6576db40d5a4193735e135=
3f
        new failure (last pass: v5.10.201-cip41-46-g596f4c151d286) =

 =



platform                 | arch  | lab           | compiler | defconfig | r=
egressions
-------------------------+-------+---------------+----------+-----------+--=
----------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig | 1=
          =


  Details:     https://kernelci.org/test/plan/id/6576dcf36037895c82e134ad

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hi=
hope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hi=
hope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6576dcf36037895c82e134=
ae
        failing since 67 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

