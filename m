Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2662FC47DA7
	for <webhook@archiver.kernel.org>; Sat, 13 Jan 2024 07:27:29 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web10.15247.1705130848038049372
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Jan 2024 23:27:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=DzApCmUs;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3ed1ca402so66514965ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 12 Jan 2024 23:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705130847; x=1705735647; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vBjXmG6UTyXuVkl2o4lU25R59xTeip9AoyYp9I2RZWs=;
        b=DzApCmUsVAH3vv+WEP9Q1SEH2Pdx4siN4MbCpcsQ/SiSJhw2JyaJYMogeJe4j71TlJ
         CnsGmk/DCjLNIOd49UyDEr7A9HXjpzdI840xC0XGoz5rHomX30QtKsUfq0NfWeGZmnuT
         08IyZclWQYStns9mMC1AnA2CRC3Egim9xn5LRcvz8ksx95kNZBTG90DCi0YGF6Tl/9/y
         6Zy28IsgLinJg/+bQSyes/i+u/Ow7LIc1e3N19sbUclVayGIx0lASu7dVEC2M/onL4DU
         60Esemu0/pHh/cevWYMm6VR+xOYjZ2vJM1a0esq3qg4RNjpHme6QxP4h4B7eLck3Cxms
         p/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705130847; x=1705735647;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBjXmG6UTyXuVkl2o4lU25R59xTeip9AoyYp9I2RZWs=;
        b=QERg9SkZP+4REY4LPyREot3e3ISh7rqw/XRuZGyAcEYIDiuQmL6EyjkYCto8hyzusp
         7V7NZLeQ+reVknLr+YepwLJ0tjaT8GIP36dFdoXVoI/tAQQQDUZ0FzNte49NzqWWHK9E
         vdmcIZ3vb5k2qX+5ZOqElyHWlzk4EKJm59rvKw9+K89zIoOcR7cF4NXVFX5V+nmL7od6
         Rx5C+vJPQSjs6DOV8tLMfkuaqnZwnsvXCsQdMvJsIJIU/wXIZCmdVyQKB0wtU2o0kk0F
         Uu2MVTCywkKLLA/lnHEw3jwmNaLL0G5DOUxSljf/mrKua8MscP9dwe3r9Njn5LnlLvH8
         BX1A==
X-Gm-Message-State: AOJu0YyJTrb8chwbEhbBHrKLbU/vEQGnmAjrAurMCcli0033nbSUw6sY
	Dpm9BNSy3ZVsKfgpbmW4PXARvkb2mmx6Zu3f18sZ3oErpnA=
X-Google-Smtp-Source: AGHT+IFhG7hDPu0D63TF+LnCRZvavFDEdFj0q3pMoWi5waRNjrPKFJShHZ+rvOIDG8lasVxknyVsCA==
X-Received: by 2002:a17:902:db09:b0:1d5:92de:c3f3 with SMTP id m9-20020a170902db0900b001d592dec3f3mr3098746plx.39.1705130846934;
        Fri, 12 Jan 2024 23:27:26 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b001d3ecbccb52sm4282559ple.213.2024.01.12.23.27.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 23:27:25 -0800 (PST)
Message-ID: <65a23b5d.170a0220.32018.f065@mx.google.com>
Date: Fri, 12 Jan 2024 23:27:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.205-905-gb40421b142370
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 12 runs,
 2 regressions (v5.10.205-905-gb40421b142370)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Jan 2024 07:27:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14364

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 12 runs, 2 regr=
essions (v5.10.205-905-gb40421b142370)

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
Flinux-5.10.y-cip-rc/kernel/v5.10.205-905-gb40421b142370/plan/kselftest-fut=
ex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.205-905-gb40421b142370
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b40421b142370404ab8c5dae183e5541de854979 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65a2280268a6790ba552a4de

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook/=
gcc-10/lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig+arm64-chromebook/=
gcc-10/lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/65a2280268a679=
0ba552a4df
        failing since 71 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65a22da1481a319d1552a42b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-cip/ks=
elftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-905-gb40421b142370/arm64/defconfig/gcc-10/lab-cip/ks=
elftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/65a22da1481a31=
9d1552a42c
        failing since 71 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

