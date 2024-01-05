Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BEFC4707B
	for <webhook@archiver.kernel.org>; Fri,  5 Jan 2024 21:08:58 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.34999.1704488932278971910
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 05 Jan 2024 13:08:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=db/uotcW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d3e6c86868so14513205ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 05 Jan 2024 13:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704488931; x=1705093731; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ubpDoN0vnl9h/8b6Lwfa9rLG4N/X6e3pLszBz43ubYM=;
        b=db/uotcW58fCryZGKzSsSRWjVNu4HtqfL1iLjLYilWEwQqFFmpSsO1lqZ7gahvFiiH
         27bMD2eqXlcZlYdy/Op53vDEP8GzBPXC1oXgBHkZ03mLRO+luUGyZ4rJ9g6mwLVmST+b
         6yP18HeUkLMWvH4TdMeFRqKknUWLr/n5IxFLqFwlIKr0g6m2S39YlgzbW31rYlue0xKp
         vngMHSoIUI2AJ+yZ6oe5caiGj/H4tu3JDFcG5mMSR/GPUovgo5jowqHeHXPAzoKAgl4o
         GnUnLd9iiida7wwIU0tdrmyopEiwoyMY2sRhzPnmqXhvnlYcmTeBVxArjDCjznf9kX8n
         TmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704488931; x=1705093731;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ubpDoN0vnl9h/8b6Lwfa9rLG4N/X6e3pLszBz43ubYM=;
        b=j5CSA0ky9aYFm1MR2l/39cqmdmDGeUZqpgOlXatZKg3G8aSDZhK4WH6AGoI82cc4yV
         GJ/L7G9gxSri1XWPho1YMCDsktTJI1Qt6JcDtgvYBsQ4iXSftCnPR3VOAQDPSHD1htIa
         UkbsoUwm/AHik2QHI205ZvpFl/pJPXoi962DuoH/n7/OrdcOQpiClM0miMylRRmWZ6Js
         BkWsKoghkqihx35V/3GXbFw3FG0chJeGt/tNKnGTFrwNjmFGPLul1Sseyaee4qpw7t2X
         DsJwmdiXsAHRIYjSaUlK8C/ZBZtm16o9CUHfxsWkhiMc/GhBc2cEAZ4y/4lz/S3OBJvQ
         Gk9Q==
X-Gm-Message-State: AOJu0Yz1xfQJqq+ASFG++Ue2EynUSNUcRGO7WqqOz3OzYPLAmXoLWipg
	l/2gcw8txYTrNdgGuoR+ur6tCDEPALy2G7ju4jaMVNK9BQ4=
X-Google-Smtp-Source: AGHT+IGxs0t0XILRegAlM9uQuetxXFBao39xeplMZgnrFEYFkNjUJIMCcVqLPWtgnz6ci9AGiRNpsA==
X-Received: by 2002:a17:902:6b04:b0:1d4:6b2c:fc41 with SMTP id o4-20020a1709026b0400b001d46b2cfc41mr51642plk.1.1704488931156;
        Fri, 05 Jan 2024 13:08:51 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id sk15-20020a17090b2dcf00b0028cb82a8da0sm1721137pjb.31.2024.01.05.13.08.50
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 13:08:50 -0800 (PST)
Message-ID: <65986fe2.170a0220.e1ac9.3c25@mx.google.com>
Date: Fri, 05 Jan 2024 13:08:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.205-897-gcc9858ae2881
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 10
 runs, 2 regressions (v5.10.205-897-gcc9858ae2881)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jan 2024 21:08:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14261

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 10 runs, =
2 regressions (v5.10.205-897-gcc9858ae2881)

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
Flinux-5.10.y-cip-rc/kernel/v5.10.205-897-gcc9858ae2881/plan/kselftest-file=
systems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.205-897-gcc9858ae2881
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      cc9858ae2881ce2dd7cb1eab9e7038ce843f1bfe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65986017daff98b3a252a425

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+arm64-chromebook/g=
cc-10/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/65986017=
daff98b3a252a426
        failing since 197 days (last pass: v5.10.182-cip35-191-gf4efde51295=
9, first fail: v5.10.182-cip35-289-g3c0549540706) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/6598614d16118b66f352a42a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig/gcc-10/lab-cip/kse=
lftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig/gcc-10/lab-cip/kse=
lftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/6598614d=
16118b66f352a42b
        failing since 44 days (last pass: v5.10.194-cip39-915-g96fa7f16cf02=
, first fail: v5.10.200-cip40-188-g33d0b44cd71d) =

 =20

