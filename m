Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D210FEB8FDC
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 14:16:13 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.10216.1694009770923507212
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 06 Sep 2023 07:16:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=I+Rr2Ki/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1c1f7f7151fso21221305ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 06 Sep 2023 07:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694009769; x=1694614569; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jcA87f7IDYxz7y3I45FXG8AorIU9MANnxA2ejhiG8bA=;
        b=I+Rr2Ki/V0wK7vDHvLq7Fnekwnlm0dFSd6uNKaZS0fPa/qfNvXpS9Rlpk4nHXt/UUA
         UqPrmWZQZGQs56rWZsyHUjLuBIxCDlnf5n8xU6JE1Ecs70izDwmpqvD7HmYdBLeiXSiL
         Inuebf2RSCoDc/JfBR0kejc1t2hF22heLNqKu0V3lydMoSvdT1f0OM9l5iA1b7X4tUSw
         tZhQJfPJAMjoCFTDxG7cewmRTKZRJXfpQ3Yxsw5Dta+d0qPVeW/uoYMkjrED+81k5bVk
         vQT7gviVMiNS+IFblboTx8d1CpFh6n2xM1uP0P2b7/dZVckHexawzSFjkvNX+IP0CC6b
         fNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694009769; x=1694614569;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcA87f7IDYxz7y3I45FXG8AorIU9MANnxA2ejhiG8bA=;
        b=dVTLiMoEUGdT6ZDOHtsn4Xu0Txh7qvrKP876NxgAFZai5Ehy1Fc1UZMSa6D9QddKX6
         jVwGK0PWwTCuwXwA33UyMpWyFYBdb93eklF4/CICJ/5WKRa/V5wW0DTGHjfBOm2qD5W4
         vvz4MPoEw78xIsn+CLk3c+rjBgJZ9P/rV4QYg87osbvryKKs679OOBZCi6spWH9/XgdE
         gGs/eJapbFH3XiTlBKeMiGjHd0xaWLimhJszAVW0CysRl3PBeN6lpeptf9WcDsSQwcNw
         YkBxNq9xlJWwBqb3pevwStiEavQ7fk0N/FRcb77c7uxdNSVj+3612S/DRGmQxuA8Nsyl
         56JA==
X-Gm-Message-State: AOJu0Ywc7+qtGb/CkE7pOg5HBp+vmZ6FTCzIrmd1pLU2gnFdxZvDTUmU
	TtKBo2IenqRlIF++JPIV2uSkjFXebXaarpFNP5A=
X-Google-Smtp-Source: AGHT+IFaS4qE5ji6oTYLtwptU3eQLh9+EQ8IdO1MQ/wpPH9LNpMYIrQwy3bk59w7Qwwj5lsietLnGQ==
X-Received: by 2002:a17:902:e88d:b0:1b8:a3e8:51d0 with SMTP id w13-20020a170902e88d00b001b8a3e851d0mr15386417plg.45.1694009769614;
        Wed, 06 Sep 2023 07:16:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jb4-20020a170903258400b001bb97e51ab4sm11133974plb.98.2023.09.06.07.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 07:16:08 -0700 (PDT)
Message-ID: <64f889a8.170a0220.a0187.7939@mx.google.com>
Date: Wed, 06 Sep 2023 07:16:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.46-cip4-14-g09ffd7fb38ff
Subject: cip/linux-6.1.y-cip baseline-nfs: 24 runs,
 1 regressions (v6.1.46-cip4-14-g09ffd7fb38ff)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 14:16:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12991

cip/linux-6.1.y-cip baseline-nfs: 24 runs, 1 regressions (v6.1.46-cip4-14-g=
09ffd7fb38ff)

Regressions Summary
-------------------

platform   | arch | lab         | compiler | defconfig           | regressi=
ons
-----------+------+-------------+----------+---------------------+---------=
---
imx6q-udoo | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.46-cip4-14-g09ffd7fb38ff/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.46-cip4-14-g09ffd7fb38ff
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      09ffd7fb38ffdf82d678f31aa0cdf232090410d5 =



Test Regressions
---------------- =



platform   | arch | lab         | compiler | defconfig           | regressi=
ons
-----------+------+-------------+----------+---------------------+---------=
---
imx6q-udoo | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/64f8815a78172100e5286d91

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4-14-g09ffd7fb38ff/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs=
-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4-14-g09ffd7fb38ff/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs=
-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64f8815a78172100e=
5286d92
        failing since 47 days (last pass: v6.1.31-65-ge66be31505fa, first f=
ail: v6.1.38-cip1-10-gf4eb42f19246) =

 =20

