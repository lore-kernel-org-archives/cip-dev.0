Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3BEC5478C
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 21:13:36 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.35397.1709327613988800950
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 13:13:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=n9OtEc44;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc75972f25so23711305ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 13:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709327613; x=1709932413; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y8WtlPKss9S06ks7Yz/Hn7zzioMZ36t6kUmZICEKAoU=;
        b=n9OtEc44eTfwZXVpLMQoZr803YZ9n9vESf618FR0rUNobuSO5jBGMvpq074xYMM+ai
         Sv6va0Q0urXpirLkSad6nvF7DGfojlTdis8f7QOXkmZSWMUBHCK/3I13kGg8UMqOwmcK
         bb3y0BZcRUZIn9FZGsCsLFPjtF6YXPjms5pOekxCPTIC8T83poEUo6RbyvWkyusKYk74
         tRFOHw9A5sP359yJ8rvzVn4OD6PNY0FtuPrOpwGc7lWAMvSv5WzbIFF+y2nCwbSITxm5
         akfnQEo9BmxZzBzYIf1CkO//A4eV98pf6RcVAO7TnzEmQ/JVfGLsIC+MDFAjCq3nmGSw
         Kg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709327613; x=1709932413;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y8WtlPKss9S06ks7Yz/Hn7zzioMZ36t6kUmZICEKAoU=;
        b=lXwkUGN5C6jUEUpNHJa6QsG1Dn98lpYtdb6O9ttNwcqquHgbBkTq5UiszI6Fe8Hb1e
         I/2HGnSBsq9S0AISp7M/ASp1KH8OvI1vZJjvxK6znSXgeqihTCOpm2+Nv//BxBVYJKof
         e2OCS9VrjVWeEn/PdvYIRavZX9Vb4vh+gnZbPbqDV/y7v5eq3f5fJgxoQtiN/tj/87Uh
         jDGNpwlQtqIdJ3jNKeGZ73lm5sBmJ5aHlJDOGMDnXXkKmBv+IjRz8qC6BKS3H14BPRcU
         MqxuLZF2UO0kOAx+F5UOXNPnYdH4dzi5kyFwR6/Z7HQ8fr8EXkWPgqbM2wKF9icLPcj3
         OCyg==
X-Gm-Message-State: AOJu0Yx1MIHkxLs3CnSm0Fy+BzwQOy+SgXUiSKT7YKcD6F5n8yUx69Aq
	nFrY5jm4O1vp7Az0AMczyJOC5TwzvQB1VDvrTO//ArTxJcPJDKdxKHx+QdEt8QZOebRxem2foz2
	04YY=
X-Google-Smtp-Source: AGHT+IHRQV4JY6aMw12lyCfRRV9zC+cjt6mnwdOdJINaSPz7wdRsBlpgsvN0+m/s56Bea8E5TRBtEw==
X-Received: by 2002:a17:902:cecc:b0:1dc:f7d1:a5c with SMTP id d12-20020a170902cecc00b001dcf7d10a5cmr553038plg.34.1709327612928;
        Fri, 01 Mar 2024 13:13:32 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902b58800b001d9b537ad0bsm3892312pls.275.2024.03.01.13.13.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 13:13:29 -0800 (PST)
Message-ID: <65e244f9.170a0220.ade06.3d87@mx.google.com>
Date: Fri, 01 Mar 2024 13:13:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-552-gc0460fb20fc00
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 6 runs,
 2 regressions (v5.10.209-cip44-552-gc0460fb20fc00)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 21:13:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15144

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 6 runs, 2 reg=
ressions (v5.10.209-cip44-552-gc0460fb20fc00)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-552-gc0460fb20fc00/plan/kselfte=
st-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-552-gc0460fb20fc00
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c0460fb20fc000a52548daa693788068d4fc9a8e =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65e2356feef40fda1c637032

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-broonie/kselftest-seccomp-meson-gxl-s905x-libret=
ech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-broonie/kselftest-seccomp-meson-gxl-s905x-libret=
ech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65e2356feef4=
0fda1c637033
        new failure (last pass: v5.10.209-cip44-56-g55117716ac0fd) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65e2345a78fabfe908637066

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.t=
xt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65e2345a78fa=
bfe908637067
        failing since 48 days (last pass: v5.10.205-897-gcc9858ae2881, firs=
t fail: v5.10.205-905-gb40421b142370) =

 =20

