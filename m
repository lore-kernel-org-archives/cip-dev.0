Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BECFC46CD2
	for <webhook@archiver.kernel.org>; Fri,  5 Jan 2024 21:08:58 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.35090.1704488937833078069
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 05 Jan 2024 13:08:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=JDXEJGLw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d4d4542526so15083615ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 05 Jan 2024 13:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704488936; x=1705093736; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3r3RCG1ap02nKGJrTbW9jmrAnKZWac4WYXLF2Mo66Tg=;
        b=JDXEJGLwASDv1F3i4Qk9GXnPinCqNQgJFKKlW3VlDHGcRV4OBJeJv0UXEvzGk+948B
         WJ1hWxWPwsCe9J3xm79oQ0Pb3x0OkmWU8qhe7YwZT8cPSw0xp4iKZICSqHzHuSpHF6ee
         wTq28ZxHsB73gfP/cCghTOArfZaD9erwMzIz8HseReI3WgTjZTIZCtRCiUpb/XoCpa0h
         YxXHwREAXeMHM/B9E3DqDJbVeAYJ4avevrXO8QyGUuSgo99SDwVJgUPMOr5MGkwe30B8
         xlp62A2Ro8qQd1kzAeClxGwk2laZuku4YRVTj4NMuaOn89hdAJEOQTFQ3iV3gTb9wk+8
         HyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704488936; x=1705093736;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3r3RCG1ap02nKGJrTbW9jmrAnKZWac4WYXLF2Mo66Tg=;
        b=u7akQdEdmtryS0X0Gcu9zUjmd9bMvJgUZGsAX7NpOXyKTpy2JIr7uNYwf4fwAzbNI8
         YKfY7dNBDgV2pCm9GRwVx1oRr71EUsRGEDYKhnKP1lwPnQaujNg9j58PlMuSAQkdnEZg
         SN1wafnJV+I7CdOW+iSy6TtSX26+YJBMO+J2ZHzkNE/LqsUNHatVyiaQ76hs/JUmBqzB
         FdQ6Fok/W6cjPthvwJRW6KT+H6BP+L79/jmsO5TgynKTm6tTclMOuy7xlgN9Frus/NHT
         stlzIxql1sGRVvDkCiCgi1JqG6SkU2ow7MOVSzR9srvzZi6tIOebN+h9k2MltPkFdizG
         tkaw==
X-Gm-Message-State: AOJu0YyW8oml6wN0q8qOx4uQTfST/5gkWi6/66iX4jZYcdJp2kKIFNnZ
	YquHkfsvEVHz825v/4gs+60WUdiraxpvnqAZ2iH72Wdd/kw=
X-Google-Smtp-Source: AGHT+IEKEAK/Au8I3fRBMxlKtjPUTd0Zjm3OqTMdsQZ/r1wuF/DU5gnUyab7cpI0vVTmKbdCRc6DfQ==
X-Received: by 2002:a17:902:e881:b0:1d4:ca3c:f2ef with SMTP id w1-20020a170902e88100b001d4ca3cf2efmr60791plg.100.1704488936466;
        Fri, 05 Jan 2024 13:08:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902968700b001cf96a0e4e6sm1811770plp.242.2024.01.05.13.08.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 13:08:51 -0800 (PST)
Message-ID: <65986fe3.170a0220.3fd10.40eb@mx.google.com>
Date: Fri, 05 Jan 2024 13:08:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.205-897-gcc9858ae2881
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 7 runs,
 2 regressions (v5.10.205-897-gcc9858ae2881)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jan 2024 21:08:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14266

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 7 runs, 2 regre=
ssions (v5.10.205-897-gcc9858ae2881)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.205-897-gcc9858ae2881/plan/kselftest-lkdt=
m/

  Test:     kselftest-lkdtm
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
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/659864a82423001dbc52a3f5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+kselftest/gcc-10/l=
ab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+kselftest/gcc-10/l=
ab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/659864a8242300=
1dbc52a3f6
        failing since 64 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/659864ce9e5bf4685a52a451

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+arm64-chromebook+k=
selftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+arm64-chromebook+k=
selftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/659864ce9e5bf4=
685a52a452
        failing since 64 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

