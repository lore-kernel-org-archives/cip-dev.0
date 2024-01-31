Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7109C47DDF
	for <webhook@archiver.kernel.org>; Wed, 31 Jan 2024 13:21:37 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.13591.1706707290158478954
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Jan 2024 05:21:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=n1tklJqx;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d70b0e521eso36514475ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 31 Jan 2024 05:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706707289; x=1707312089; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rCn00BRY0zzTaucwLy4RCWWqkC5tY8/TUN0L33aH27k=;
        b=n1tklJqxPozZpJXdMxSjvfSDGE66Ypb0U3ECfcwTVMlylBaWKBukm0ejmaIuQ9XqmG
         iGODWfvCvkHKZV9xfsCahTsS42koP6/N1Xusr3Wd9Ire7EtzAWGBYKc3eOcu9Hif+RVL
         1DWCPTX+zOcAbGWsh763XxvGX1MMODTjEp3ET68SUcCwuwM0q9PYuoC8qfVQykQskVBe
         ZVGrU7TwixORLFzSxFWLTljuNfdOQl05cq0odbqE4WKrvN6K2+JCbCPtD/KHWPgu6Tbc
         OW4zNEfIpSjjMuWR7/rLODGk09Ev7BtFEfayjPavUVsk/PkxlAvOWhT16GF2EQR7bOL2
         WV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706707289; x=1707312089;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCn00BRY0zzTaucwLy4RCWWqkC5tY8/TUN0L33aH27k=;
        b=oJYEn2X6BxwAQihr8tvqc+aZhUwRbiV7gXQ5Q2hGOP9+3aotcVmii1lkzeCFwXsugl
         ZPlEYMs/9BjJV/VmhZ6b6gqSIf4ZKMNCej1GzT44YE3u0k/C5UKwtp6fnnhjbH9K8/By
         drTKzATQ4abl1UeV8HE13IsFt4aQ9K2d87DExlgcXbwtSOUQo2BTPYvtMN41T7Y+y6QO
         RTNtS+WmFLYctgnYZ50LD89NBB/xpKhfW6yAbRLWPi3X1jj5QJq/zXe8L1e3wskpTDmW
         vMBILtqeaoOcwO2l175PNVLoF0cBOu+QFSCBcTOpokopAtwqDgC8ezYi/K3JYqddrk30
         QQ7w==
X-Gm-Message-State: AOJu0Yw9kspVj9KQtyLuvz8FnHg66jPnHM+Z8w2hV1u+iHlyH0GDjPbA
	4ErHZZglye2VkObQREdbGVleMTyp7iW5WTVKc6Kl3K3vXWIZzj2a8WJ/GEMumtqcT2EEUE/inSg
	S
X-Google-Smtp-Source: AGHT+IH7zUPnOzdfE4mOOlh+WYwrNOh+hI9YKQZprEphepnMESp5PYdJFkTXNxcIcogmxqeim/s0Qg==
X-Received: by 2002:a17:903:40d0:b0:1d8:d58d:7ea1 with SMTP id t16-20020a17090340d000b001d8d58d7ea1mr2014280pld.59.1706707289102;
        Wed, 31 Jan 2024 05:21:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id az10-20020a170902a58a00b001d7284b9461sm8932786plb.128.2024.01.31.05.21.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:21:27 -0800 (PST)
Message-ID: <65ba4957.170a0220.8b390.b04b@mx.google.com>
Date: Wed, 31 Jan 2024 05:21:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.72-cip13-32-gf60d2e8cb51c
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 10 runs,
 1 regressions (v6.1.72-cip13-32-gf60d2e8cb51c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jan 2024 13:21:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14566

cip-gitlab/ci/pavel/linux-test kselftest-futex: 10 runs, 1 regressions (v6.=
1.72-cip13-32-gf60d2e8cb51c)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.72-cip13-32-gf60d2e8cb51c/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.72-cip13-32-gf60d2e8cb51c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f60d2e8cb51c9da65ffcfe73144286c27725ceea =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65ba32d788cf1288f400a039

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm64/defconfig/gcc-10/lab-cip/kselftest-fu=
tex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm64/defconfig/gcc-10/lab-cip/kselftest-fu=
tex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/65ba32d788cf12=
88f400a03a
        new failure (last pass: v4.19.299-cip105-1134-gc868d5e4adaa) =

 =20

