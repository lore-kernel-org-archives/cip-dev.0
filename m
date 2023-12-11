Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB88C4167B
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 10:52:52 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.5792.1702291964784771352
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 11 Dec 2023 02:52:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=u7kVeKfF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d04dba2781so25102705ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 11 Dec 2023 02:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702291963; x=1702896763; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V/MmvQTXO0GCZKXCtzRQIVdEiFRG2yjp1iwG2qmFPM0=;
        b=u7kVeKfFj/bcPAkUnvuZrUW6dwuPRpo7tFotXx3TtJ2I+TzzyXQQeNwf9SwtqdQ8az
         1Sqgg27W/qk+O3jENSSwb7TtG/PS8ycwfdBlm8BfcQB23SaAKLDwIXAcP5sC9gsFE0Yu
         ciC54mRmJgutXdWOjztQvSsdRJdfTQROXQ6wCuC8MVSRHuBEAhOaNIAtqzOUjgKWhhMi
         UY8kHIm0CDXh50htD2clXsI/J6l3mWEc7MYAMJiKN1y5P4HYUcb8rfoy1JjA9MyRMWPN
         WxuH673+NEOGWWKKxJ4o8TezzPRxOQnZQRJD7l9ibSkkwyfzfs3DCd1ApGaBRHE+Mtf1
         OsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291963; x=1702896763;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/MmvQTXO0GCZKXCtzRQIVdEiFRG2yjp1iwG2qmFPM0=;
        b=CYgQAwTlT5TkfhZmMjnkf2sIGZoVTwRYUmNVBIQ2Aj9N7FdsLYtVIU0WKRU7fM/Ek7
         UOY4Sgnrs4Fj9/379nQK3lluazU98Ofc5kp08mMn7bK3nn2diPPqUomcmsGxu1ker9Pr
         ZxfdSrp7zWwzc6+0lWi2UYtQUOVBuiP/EPdLIvBNRpDxMmWLXbksaiFjWYV2xA02vC5B
         a7QqtAhpGjjBM5jfXTE1ptKdoI+oqIIFA0P1AtJ2mXd5yvyfMP0nUEh1sbOXv9zYTM9F
         jYgsrGX14+g5uDdxy8aNsgAVUMzrrjmAhF99UuzIAA3gdrEGTAs+Jx7kDfI+N67b0zPA
         DXBA==
X-Gm-Message-State: AOJu0YwNFSa5L0rC92oBGEe3p4FKw9++tAm0r6vMvRMX38XtVKvRPjtv
	2B9T+dzOP8lAnvYyf+JQsbPKPGMMnE/B49zL692FBQ==
X-Google-Smtp-Source: AGHT+IEBspsmH13u3ss5yZfU2ZhmRcRzN+ZLUOXBTLcYuDwsX5PAlFV2xajZHagLjK+U9LcASY19ig==
X-Received: by 2002:a17:903:185:b0:1d0:a084:a1e8 with SMTP id z5-20020a170903018500b001d0a084a1e8mr1810685plg.106.1702291963593;
        Mon, 11 Dec 2023 02:52:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090322c700b001cfb14a09a4sm6307035plg.126.2023.12.11.02.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:52:43 -0800 (PST)
Message-ID: <6576e9fb.170a0220.1c3a3.0ba1@mx.google.com>
Date: Mon, 11 Dec 2023 02:52:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-63-gfdfe1fbf93bc6
Subject: cip/linux-5.10.y-cip kselftest-filesystems: 8 runs,
 1 regressions (v5.10.201-cip41-63-gfdfe1fbf93bc6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 10:52:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14008

cip/linux-5.10.y-cip kselftest-filesystems: 8 runs, 1 regressions (v5.10.20=
1-cip41-63-gfdfe1fbf93bc6)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-63-gfdfe1fbf93bc6/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-63-gfdfe1fbf93bc6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      fdfe1fbf93bc6fe6ed2708f11c2613bef556fdeb =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6576de33c07cb54d86e13487

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/kselftest-filesyste=
ms-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/kselftest-filesyste=
ms-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/6576de33=
c07cb54d86e13488
        failing since 67 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

