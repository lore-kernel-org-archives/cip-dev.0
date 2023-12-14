Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E000AC3DA79
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 16:15:49 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web10.26653.1702570544652765549
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Dec 2023 08:15:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=15JkbQbf;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.54, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28b05a2490bso982555a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 14 Dec 2023 08:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702570543; x=1703175343; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CeOgeNZVlYJmnMHj+JOtIjiezGeFwJ5vkj3qAPo/THU=;
        b=15JkbQbfOpYZ8CLOp5Y9ppuJ1wTA7RZLp5vAdYXyZCoPpSHmWaQ5TFcih3xMgGMZL9
         LJpgVxeJnyV8ac6ZmWcvQikNaDq1Ekfyr+XcW5urjB6xpDtO7amQ2NGOF9xKKp0BBb+9
         Ty1z4YCXf9rXuWTNO/gXdz/GxfS2lNhOPJJdENd04d7QLcm8G48sS3uE6Li8e99/5Jhm
         fkpIifcrjGeh6ZhuzaPavgHqy5SlZMb5Zf3MALFiBNJ0rgRjn49LYLIX2XqpVu13Vdm7
         eBmDPNT1SB9LQ7bMceA4MkisOBwuaHQkl9C+wQMxgPSrN0+0eupSqk868geUZJpFbhlu
         pGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570543; x=1703175343;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CeOgeNZVlYJmnMHj+JOtIjiezGeFwJ5vkj3qAPo/THU=;
        b=BJr07RS1Ka9mkgEz+HUFgA9vOtmI/4rEQe8biUr1xrf1RDLW21jwFdRccYjkhK768I
         ubX63U3wV9NNgNJ0U3xf8Ha8hXLTdrfVlWPgxuZkt4Dlg1habEmLu61sZkCqeMgqiBFy
         Y+c2fHNMi21SOugL8uq0BTjUESFCT6U1AOPUNNqfrJHaCv+P3ElGlS4NyKWItSNIa+0V
         ye7ouIC2zwDsG54kGPF/q38IChlUx5XqrmMIY7uveCAchQUBcseo57rNRxlcpAAKC9k1
         xpEf/Bpj23/IzJrGgnL/afWCMpVP4RpgLwX0B3kJRkQ+DyJRe3G0RZhKDb2Ra6+PL0py
         Blnw==
X-Gm-Message-State: AOJu0YzGYWZP0J+ZTbFR1GDkozbHGdzp80RPwH2Bfti5pINtrmtiJRrI
	b6zCOnjBzbYhOwDZPVe7jLfpVWfXoGgyEFF+idI=
X-Google-Smtp-Source: AGHT+IEz6WD23CMwexYBKZNJW8xBsAKdVA4PZJnk3UgWHglpoUYjLKBEnrgwRweb/qDJqBI+YC3IRQ==
X-Received: by 2002:a17:90b:2ecb:b0:28b:56:95bc with SMTP id ss11-20020a17090b2ecb00b0028b005695bcmr1343195pjb.39.1702570543339;
        Thu, 14 Dec 2023 08:15:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902d2c200b001cfd0ddc5b9sm12566897plc.262.2023.12.14.08.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:15:41 -0800 (PST)
Message-ID: <657b2a2d.170a0220.cd2b4.6d71@mx.google.com>
Date: Thu, 14 Dec 2023 08:15:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-69-g8f7b450fc28ed
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 1 runs,
 1 regressions (v5.10.201-cip41-69-g8f7b450fc28ed)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 16:15:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14116

cip/linux-5.10.y-cip kselftest-lkdtm: 1 runs, 1 regressions (v5.10.201-cip4=
1-69-g8f7b450fc28ed)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-69-g8f7b450fc28ed/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-69-g8f7b450fc28ed
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8f7b450fc28ed99196853536c98ae36c2567e160 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657b19467f7ad21445e13484

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/657b19467f7ad2=
1445e13485
        failing since 71 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

