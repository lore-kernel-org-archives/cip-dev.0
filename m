Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56B7C10DC3
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 23:14:51 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web11.106760.1701990891646098496
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 15:14:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=supdA/bd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d03bcf27e9so12953875ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 15:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701990891; x=1702595691; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLZQPNIkL1wwMHQM/ckVgcsugUW7cmVSVsRLU/Th0tg=;
        b=supdA/bd2WxNkrgzPwTZvHBU9HguqmpEYgey5vHrqW5FKuCRIyDpAuRLeV5eFLz6YX
         /EWjJ/VFkbco/MtvsGkxnyX8pJPJ49zCxFeEWOeHGc62EzT55hKsCzuYJdRS/w3dzmcw
         bmqkI7CSnPoQNEvJe6QryDRp0nmL89ykNtUucWfVs/J9D9krMbPFDvXjkaJN6zcKZEWY
         8/Cx+v4ClvSkKzQDCPMAhkel0xhQS+i+xzmO7AFI8vwYi9iskHWRVriudXYUtaz7jSN2
         qdHuRZvolYr2QowuF0I3M3JZtki2VOC6l5cGThyVDkl0AxH2GzV47hYdrMxCu3Sb4/Od
         j1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701990891; x=1702595691;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZLZQPNIkL1wwMHQM/ckVgcsugUW7cmVSVsRLU/Th0tg=;
        b=PtuHpEqqzgxpUZqEpflxUYTXBb9I7sgM7nYQFnJQ9v/TDRq+BTi6Q7NWkTJptFD3lr
         V7buUJ18ndt7ChJ3Up5dpFLOCjcKgqw8NdYPHJ7ULnYWu2FKjlHCPgy0xpbFPNf7i3vd
         9/RWXsLyfPPb5XXAUOOA76kbcXCx/XuwTBygLWT0hR3RfhbP4DEfG7d1gcOCBK9K9408
         LZZW4dt6Pl8Y6kY+YuoX1mg7+kRj1RAtUbrL7dzlk/e8ryEZfFPy0JLx1wHHcC7+9fKT
         drUndyjxR3ZHsUE1xJLuUacRO5bUB0rDjJz+KUSxd9RK91EFNWZTCGFq6DgqqG0BR8Qt
         qRCg==
X-Gm-Message-State: AOJu0YxReGkQsmisyje+L8P3TBkIrZmyvZROEqzvgfaKYyBor9/7Bxfx
	8NtT8rKkwAvsWS9JIH/Dtit8U7PDUTLTFu2jSVzy3Q==
X-Google-Smtp-Source: AGHT+IEU3A88KtarbN5oxMq/MJVG1Gp1Wh40WgSCivk2kWPvaYBPuylV4QL6fnPwF7V4frUkU1WJvw==
X-Received: by 2002:a05:6a20:914a:b0:190:228e:4c12 with SMTP id x10-20020a056a20914a00b00190228e4c12mr815990pzc.88.1701990890677;
        Thu, 07 Dec 2023 15:14:50 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a018500b0028658657e9csm496422pjc.46.2023.12.07.15.14.49
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 15:14:49 -0800 (PST)
Message-ID: <657251e9.170a0220.32a7a.294c@mx.google.com>
Date: Thu, 07 Dec 2023 15:14:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-63-g2bc5a8583f4a8
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 9 runs,
 1 regressions (v5.10.201-cip41-63-g2bc5a8583f4a8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 23:14:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13934

cip-gitlab/ci/pavel/linux-test ltp-ipc: 9 runs, 1 regressions (v5.10.201-ci=
p41-63-g2bc5a8583f4a8)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-cip41-63-g2bc5a8583f4a8/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-cip41-63-g2bc5a8583f4a8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2bc5a8583f4a8a28f328fe05c444332335079a44

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/657245a3e35152a461e13490

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/ltp-ipc-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm/omap2plus_defconfig/gcc-10/lab-broon=
ie/ltp-ipc-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/657245a3e35152a461e134=
91
        new failure (last pass: v5.10.201-cip41-28-g38e219eb6aa85) =

 =20

