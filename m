Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0FAEB64D9
	for <webhook@archiver.kernel.org>; Thu, 15 Jun 2023 10:38:10 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web11.15032.1686825481644376298
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 15 Jun 2023 03:38:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=5kdMMOKG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-666a59b24bdso216448b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 15 Jun 2023 03:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686825480; x=1689417480;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wXMX8WkAwWfvTLgCJ0VYP3wPsbcxaNviMVFf107UYSw=;
        b=5kdMMOKGG1KjjGCXZxDYzCaWgMxv/ZkB7Nsm2AcgPJ9DkOYGy3Gek0pzIMOoDk1ovI
         XAcvx8Aa+plyazD/Zx/LQ7gKaLgqkemxdGLMv1F1asFoB1IuMZGq3LGmGiZaarO3kaSB
         1SP7WPjmpxuBZVYemdpYPFa6LpF7zTtNtuwFhpCT5QRaAuBEZMJPey4DGVt6ZvIJCUho
         2kbSWmUWFmXatA+MJHjcHvArM+3uaSvMvqZRkfC24tgqVxjrQvkHjFb8FDZK0slQuW7S
         gOqeAgm+LjVPhvwz1ln38t87dq5RChB1egjc4zawDKyYa4t//fG4pINgaBgPgGF7rwuI
         E5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686825480; x=1689417480;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXMX8WkAwWfvTLgCJ0VYP3wPsbcxaNviMVFf107UYSw=;
        b=mGY/0w1N/O8hLRNkQOcxTIQuS54gFzDEkxcr+7twc7/zZI5YxMNkipRuQv+fnhqHi0
         cAMfFSpgVV365UVVP0qcK/icboXGTZZtC99SL3w4EHFAxWTJR5Hl4elfyRKH3AowcXm2
         kFlprUtZ6L7CJhFM7406ZzWyjgRsakh5c1T3Pz0C8c2rzUrPRxrbUciJcw+FyWVwYNjr
         VZo8XZxMaB51iJ/RjzVRuJ8Q/3wYjcT7o+deQH7osU6woKz25usROJfGUuFtwsPVCYC7
         16/Faym6jnRavrU25Kl+mSwy5kCPANUzOVAulg6aOsG6Vps2Hd/H4lAAK7q36ODGL4cR
         xfOQ==
X-Gm-Message-State: AC+VfDzhZcrZ+9tn1f0yj58TbBBB2LDkecMVhj0MY3hu3/2Yk0+ik3DH
	7jeB3zyYWFpDX71xhKK5YbjfaW5nIsY07svQ3h2EjQ==
X-Google-Smtp-Source: ACHHUZ6g8Ad52LLxvHLa5nhoAgae6ApqnnhRx39X/lFloQjrtQ/TyQJj4JDvTyETqVa2m+7aqGVUmg==
X-Received: by 2002:a05:6a00:1890:b0:643:b653:3aa with SMTP id x16-20020a056a00189000b00643b65303aamr4851619pfh.32.1686825480315;
        Thu, 15 Jun 2023 03:38:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c8-20020aa781c8000000b0064d5b82f987sm12161654pfn.140.2023.06.15.03.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 03:37:59 -0700 (PDT)
Message-ID: <648aea07.a70a0220.61d8b.8316@mx.google.com>
Date: Thu, 15 Jun 2023 03:37:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-8-gdba81ae6f2be
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 1 runs,
 1 regressions (v5.10.182-cip35-8-gdba81ae6f2be)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jun 2023 10:38:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12048

cip/linux-5.10.y-cip kselftest-lkdtm: 1 runs, 1 regressions (v5.10.182-cip3=
5-8-gdba81ae6f2be)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.182-cip35-8-gdba81ae6f2be/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.182-cip35-8-gdba81ae6f2be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dba81ae6f2be7f7d87f3a29a8566758d2e0017ae =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/648adeb98c69155fb2306143

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-l=
kdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-l=
kdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230609.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/648adeb98c6915=
5fb2306144
        new failure (last pass: v5.10.182-cip35-1-g7cde3fba93966) =

 =20

