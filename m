Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A473C47258
	for <webhook@archiver.kernel.org>; Fri,  5 Jan 2024 21:08:58 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web10.35086.1704488935387210819
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 05 Jan 2024 13:08:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=tb2fj9Rq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.176, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso1166439a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 05 Jan 2024 13:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704488934; x=1705093734; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xllMmHnTEztyTCgd9AGlJptDSI7WLGyi5CXLHvOqqQ0=;
        b=tb2fj9Rq9MGtaGMBAsDFH6a3rUDNQvAuurQaI97r4WIjFB4Ghqa1ITTwsm/dglbuy/
         Z72bn8qHF52o1+D2CJXV+GyCJj7U52jN4mGwTfz+Pc6TpABC/mqZa4OLPvsnKum4ZmlU
         TOwwqIX6BIiSJwCdI6Byjp9JzANoz0vlFRTgvWg4xpZP3lHG7xr2vdS1r5QT3ZY4Tui/
         xZVo1kePPvnZeNnUhSYXCqS0uoRAMQ6loB6n1FX3Xdtdq4oSrAlA/Ex18EbDylFNB2k5
         m1IgVW9yrbR6EEWf7aZa3dNcOLrQfeb15w8q7dHbhzckTvFdbaQgC+6VezxrUS9jDjJ6
         CNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704488934; x=1705093734;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xllMmHnTEztyTCgd9AGlJptDSI7WLGyi5CXLHvOqqQ0=;
        b=riOpDUHT+P9ki0+x5yWU3nk8U/klkQZCwyAQSApB3aG55O0uBqA22MZfvSEEER4pg1
         Q2qyHUSzePz6HaJS2SruuHhiD54catLyKZreRnguHONBrMrclLAob/UIlmTpcRRKj9aG
         sIQBd5OPdmjpIecrXP3o/K2rsELmBKp4HxNuDwwpBrRApbWJvEjvLYMsN1WY4cskYgRf
         4ipPZ+IM5pBSJ4fvUqj6Zme2A1qDxzxhp0TqhJa+mQB0vtK6sGPPOPeYeoRlku0sRDLt
         pY9+ytf4kdhCj2lDy6n9yssG61Rl3SoIKcrIc1UoP5HsYn2JO/oIrqwbrAVIe7QE4eu3
         8lzQ==
X-Gm-Message-State: AOJu0YyFUyuVXkqEwV0HVe4doKpgJeHRbsxtivpdo4WlC5JjWLecItmT
	Qx5PwfwGOT3y1CwCpOFBFE1U664185H7G5HFCU27jF88VZk=
X-Google-Smtp-Source: AGHT+IENhDRZTg6/y+n8cerUwat8RAvV0W1DOodIa4J0IgPzonUo9b56ykuil5md1itKZ8QIaohRmA==
X-Received: by 2002:a17:90a:8584:b0:28d:1df3:252 with SMTP id m4-20020a17090a858400b0028d1df30252mr76365pjn.18.1704488934315;
        Fri, 05 Jan 2024 13:08:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090a2a8200b0028ae54d988esm1850390pjd.48.2024.01.05.13.08.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 13:08:51 -0800 (PST)
Message-ID: <65986fe3.170a0220.c2bec.4133@mx.google.com>
Date: Fri, 05 Jan 2024 13:08:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.205-897-gcc9858ae2881
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 14 runs,
 2 regressions (v5.10.205-897-gcc9858ae2881)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jan 2024 21:08:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14264

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 14 runs, 2 regressions =
(v5.10.205-897-gcc9858ae2881)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.205-897-gcc9858ae2881/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.205-897-gcc9858ae2881
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      cc9858ae2881ce2dd7cb1eab9e7038ce843f1bfe

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65985e7a70657a9ebb52a40d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65985e7a70657a9ebb52a4=
0e
        failing since 64 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/659861c6e680324c7a52a3f3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig/gcc-10/lab-cip/ltp=
-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig/gcc-10/lab-cip/ltp=
-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/659861c6e680324c7a52a3=
f4
        failing since 37 days (last pass: v5.10.200-cip40-188-g33d0b44cd71d=
, first fail: v5.10.201-cip41-197-g2d08925b44e52) =

 =20

