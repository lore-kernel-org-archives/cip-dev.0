Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E958AC4167B
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 07:16:52 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.22843.1699600608475291566
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 09 Nov 2023 23:16:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=sbbmiALp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1cc9b626a96so14408165ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 09 Nov 2023 23:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699600607; x=1700205407; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6CoQtHvpirZ7SRd3G2Suyfyy7a5fT22ZqElGSUGOZkE=;
        b=sbbmiALpHS+H+O3eFk0VGJJg+oA5A0zpG015eD03vV951mBG1YHSwrlfTO+soQ7L34
         uxUTA+SORIe41CajKLW13iQfde9vZep6WLloPYyJP8M57DAtMkqLbXdRwIVycYghjzDJ
         1/UmNzkNT+DqFdQUxZ3TOpsVkABvPNka0Oak7LbI/BSb8aEF2+G/daoLph7rhotkuxNa
         tKpkkoU/01tAkgyWKL/kkRVfPb17yci8PLnbCExnAyZRxondm8u204t6I/NO1RH54qbL
         jv/Metyvx4/ro84YGjsxQCzYJxB/G/Wk+HcTOMWTaC/gmGlWysOejoKYoh9CW0kNbggy
         do2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699600607; x=1700205407;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CoQtHvpirZ7SRd3G2Suyfyy7a5fT22ZqElGSUGOZkE=;
        b=IgA3694xfNsqRYxrAgeksMN7tzXRSbeJb1rZlkFccCYEuQN8oI8LgFKJs7pO8aSU+x
         8bmlBLFeeRmp2/PN4sHquTAWJ1iZqEO+t/wJ58bjHdSqPmAqrEG3+KNIohEGYCJEAzwT
         YcwaKNCmz4tSQKn6GJPnO0Y36ENlqRInzEAVZr+VA5TrqHL2wgGvPhwfeP+318BU9qpq
         zgwJuJn64iajEaCRfyvLRPBOfC+UhMAvusssv5FtHM2ZGNGjRfywPtWW3Q+lgmNvbx16
         vm4scO0My/gz7DdvvoWgm7s1L/pSoLPrMhXvCV6Pb3sxfVjXxKWolO6Gyn66vxwcskvD
         kwjg==
X-Gm-Message-State: AOJu0YzidJhVbaJXJJ9S5NkQ2j5P/b3VkeAlgNDwfPKPciU9+OyCBaZq
	GJEfgqJhjjC2dl8En5jSBNEq4IyZbFEEWfkecHOAxQ==
X-Google-Smtp-Source: AGHT+IEBxU2IQBVNMR1n/uy3T3RFUgUIkZ4yQjAoYb05rsdXw1dxLl6SkgUJELUO9P/k1n+TvHWURw==
X-Received: by 2002:a17:902:8c83:b0:1ca:8169:e853 with SMTP id t3-20020a1709028c8300b001ca8169e853mr6803664plo.4.1699600607246;
        Thu, 09 Nov 2023 23:16:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b001b9da42cd7dsm4669520pld.279.2023.11.09.23.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 23:16:40 -0800 (PST)
Message-ID: <654dd8d8.170a0220.407c.e82e@mx.google.com>
Date: Thu, 09 Nov 2023 23:16:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.200-cip40
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-filesystems: 5 runs,
 1 regressions (v5.10.200-cip40)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Nov 2023 07:16:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13563

cip/linux-5.10.y-cip kselftest-filesystems: 5 runs, 1 regressions (v5.10.20=
0-cip40)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.200-cip40/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.200-cip40
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      166400a23a22e665f5d880a99149b73abede402d =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/654dcb5863df20d352efcef5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-cip/kselftest-filesystems-r8a774a1-hihope=
-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-cip/kselftest-filesystems-r8a774a1-hihope=
-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/654dcb58=
63df20d352efcef6
        failing since 36 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

