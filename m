Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA30C47DA6
	for <webhook@archiver.kernel.org>; Fri,  5 Jan 2024 21:08:58 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web11.35006.1704488938342487685
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 05 Jan 2024 13:08:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=sgjeYiFP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28c179bf45cso29401a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 05 Jan 2024 13:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704488937; x=1705093737; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t4tNudFoFtJoNKd9ATNtxrsZf+s7bd+YVJnTl4lSg4I=;
        b=sgjeYiFP0rcYnllIx2XfInKYoj77nuYHLmsIwf4Rk1YMyW+3eCUKNrFYMzOQOQAFFS
         DzwXOGhXsuU9ab8YaJEi1/KWLQHPXNjbFbBqd2ojOF/PFsmpNk2KU/G8VLH8cA38ulFS
         1ZlW9oQRoVcdJlIlTvyy+O9nsirZyS0Vn4zWdAIgj6C5U1wl7cf3imKjZZ7JD06QEdQG
         LrkB1ZcVAfpkEC2R8OFNGHtnP0KCf8AU/QzsexPt4EQyl8vxSSL1mjKWiuc7IESyqQBK
         Hn3rtMO8tK7S6EOkFRU7zaFX1q9u4GZEuM1XTRELoj3r1KycjoUW1BEWtvvxZ14m+j5C
         x7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704488937; x=1705093737;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t4tNudFoFtJoNKd9ATNtxrsZf+s7bd+YVJnTl4lSg4I=;
        b=F6WhunknkKtan7s98Chw0NuthKcn2oL9cyaPh4S/4R3NxOxY4ADseXepIzYcAEgGoA
         pNefW0VCT5wqCq5SuXxL/WCo4VZf+3qkdLgbWAst9b+3Ke3vrn8T3cy+LdrITV8tBX1K
         Y0CfDyozrrlX9yuDqaoe3Ti2iJ6O3DaqZD6Fp6gkgp7OhH4OGfP19xWwHLRtmgxvYsF3
         mBbmlNVKNSj5i6enZgJtl53yoGlW++1Rgj/q5bTbSBlUG9sb7d58T20jeSQSA9AaWmkY
         H96InDXq5fHP1aSQWGLa3q4fXKPIFVMHrqs+edXujJccz3HMvZYiTRUoedHruUUPrijg
         Wexg==
X-Gm-Message-State: AOJu0YwV7xZTLamXtHp6RKR4dM3dHr1X6b/ypQg4WxmCOHTdn/xy4xXW
	4PrM7qwO6SRAWRuhJ1bTERKL6qlfljxPmUSBiijDxndDV9Q=
X-Google-Smtp-Source: AGHT+IHM81Vj2Ju5JWFzmssPVdZCnXFeu3Oq/RynfDoa/wAhbVfxO/6x0ReTVwtK8ZTYeQs2Tb/2Hg==
X-Received: by 2002:a17:90a:9f42:b0:28c:8477:3ee1 with SMTP id q2-20020a17090a9f4200b0028c84773ee1mr76668pjv.23.1704488936853;
        Fri, 05 Jan 2024 13:08:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090ac88c00b0028aecd6b29fsm1727683pjt.3.2024.01.05.13.08.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 13:08:51 -0800 (PST)
Message-ID: <65986fe3.170a0220.18c07.3abd@mx.google.com>
Date: Fri, 05 Jan 2024 13:08:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.205-897-gcc9858ae2881
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 8 runs,
 1 regressions (v5.10.205-897-gcc9858ae2881)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jan 2024 21:08:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14268

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 8 runs, 1 reg=
ressions (v5.10.205-897-gcc9858ae2881)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.205-897-gcc9858ae2881/plan/kselftest-secc=
omp/

  Test:     kselftest-seccomp
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
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6598643ae8d35ada5652a3f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+kselftest/gcc-10/l=
ab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.205-897-gcc9858ae2881/arm64/defconfig+kselftest/gcc-10/l=
ab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6598643ae8d3=
5ada5652a3f2
        failing since 64 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

