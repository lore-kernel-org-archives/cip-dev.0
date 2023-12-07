Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAF9C10DCE
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 23:14:51 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web11.106758.1701990890343307832
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 15:14:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Yp5XKF4E;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28a1625b503so836714a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 15:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701990889; x=1702595689; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YpBxKmgw4g5j7F8V/GPZccAAaEilMdYxgLwTbnRHUCI=;
        b=Yp5XKF4EC+rKU2tsOl9TYrY3zt+Tkp6M66LZBu6CXxrFvQ1IwTeYVAiVOsL9bX8vkx
         dDV0XxNy7kyK9dXkJoec0K5SKUhvNlEhAxu7/8i9gHpG8e85mDuUGTbhQAHQRJWybIvw
         KxiyWhL5abHhWMViKF6NO8vuqgK1efRxLmQziFfHa6XC9e1/bDogTr9+o2+YmfqyeLpE
         iLHYTK72r4brHhEl4IwRUq213GCB1Fwce5HcAJSEjVjeSRHtI5P4TspBH2bOaxPbPqm4
         17YGu1u5/dypHiUNVtAOZpTbT8XOWMQIXN3PrUHhLj9m61Lp9F/MheApHTjC6cSHT2tN
         3qqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701990889; x=1702595689;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YpBxKmgw4g5j7F8V/GPZccAAaEilMdYxgLwTbnRHUCI=;
        b=M5Ke/M3TXwWAG8wwoSK5cZXice2Jj+RbijQCi2ZlG9seRA7lGUm1Dy7Kp3QcHPE2Ik
         AguWibIdaAtzcY4Y8AQeJzDFhVqjsiabdUaleIAPm6y3H6tWV/nERm/xpHfL4eQ4GyfY
         yePmFm4JeII3C7kRo2pfCbNprEZ4Yhytl+e631nENRslVPogmRla3RR3a+f8B53A2EF5
         o7cgg3AMH7IoX5SvGed3uJ6M2u1nsgHGXGLCLcnqRO3e2lsoA2F0M77JmVvSSoYcRZ/b
         HsnMeHD07NmImT5ujyV/47wcAX8vRz1iu5z3155WSIxYxmJf9qUYRKo7eOATnYfmOktg
         jmLw==
X-Gm-Message-State: AOJu0Yyel263GX0hismORXY/go1nDCYK62/LAl65PyTBuUt4z8zzi3n0
	GNOWC356CxNHQOF1ebFefQrek63FTRPrIbo6tYgLtA==
X-Google-Smtp-Source: AGHT+IFUFtOgZrv2e1Ub6CefzmDshjtyMpbSWCxkVKqEQfjdrtnWw8iZqTN4OnRkcZ1rfqAX4HzY7g==
X-Received: by 2002:a17:90b:1c0e:b0:286:bc8c:a23d with SMTP id oc14-20020a17090b1c0e00b00286bc8ca23dmr3805879pjb.45.1701990889264;
        Thu, 07 Dec 2023 15:14:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 26-20020a17090a005a00b00286596548bcsm497608pjb.37.2023.12.07.15.14.48
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 15:14:48 -0800 (PST)
Message-ID: <657251e8.170a0220.a17b3.29ec@mx.google.com>
Date: Thu, 07 Dec 2023 15:14:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-63-g2bc5a8583f4a8
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 4 runs,
 1 regressions (v5.10.201-cip41-63-g2bc5a8583f4a8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 23:14:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13932

cip-gitlab/ci/pavel/linux-test kselftest-futex: 4 runs, 1 regressions (v5.1=
0.201-cip41-63-g2bc5a8583f4a8)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-cip41-63-g2bc5a8583f4a8/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-cip41-63-g2bc5a8583f4a8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2bc5a8583f4a8a28f328fe05c444332335079a44 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6572462f1e2fa3751de13486

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm64/defconfig/gcc-10/lab-broonie/kself=
test-futex-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm64/defconfig/gcc-10/lab-broonie/kself=
test-futex-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6572462f1e2fa3=
751de13487
        new failure (last pass: v5.10.201-cip41-28-g38e219eb6aa85) =

 =20

