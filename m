Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A885C48292
	for <webhook@archiver.kernel.org>; Sun,  4 Feb 2024 05:40:36 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web11.33494.1707025229134390772
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 03 Feb 2024 21:40:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=hOFB/6pR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-295c8b795e2so2429619a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 03 Feb 2024 21:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707025228; x=1707630028; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mzLatyYUtOK1jSO7cHiI1CgLJCPjfHxG/tSyYhZitsY=;
        b=hOFB/6pRJnphIUyHGUDIc/jm9c7p1mdozjJOXGnzqHs1VYdTccf6pI82VB34f/0GVn
         VvzFcDEAEFJgrl4IZ9Ar7NuF1xNBktmVZNR88qFnGz2JOSjf8J+sHYSlQ1D8vIEQHKF6
         xQmU/beyPgii/sEpKsx+oW4rCEGq2+nZxrKeNMEL9T7DzFBeQ6E9aBO6tbpshgpQJuM/
         Xul2LdcL3icCiOhC/okZ5uR8cx77+xp8NCdN/lxEAAtDFc/UW9R7Y3dlcngXMqU0Y1QZ
         rSQXZ42k2PbzrYAfFmKOjI5EB+dw2ArdlakhJz1kfY3WEyG7D0S9XfWzcuSY28CqTa3c
         wMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707025228; x=1707630028;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzLatyYUtOK1jSO7cHiI1CgLJCPjfHxG/tSyYhZitsY=;
        b=vSVSUI69yNJnVlQTPwetPXJHzwBzv9ySLekx10BD00d4gYr7NFAyW++xK/S54Jgk+0
         eWYBFIgpsVR/RAtqkNYrYTY/u/9ec9uEHvxf0uzrAsTM6z2bAdDFAOXZE4R2rHHQNyk1
         ku0kYxFKpdYtQ66dHbF7/wXtV8RD/IOdcHDUPpEG5N/IHjaHD5nnbFp5XH4IZUiha44o
         cs91BhOqxO4NKVPReS2TJsHPks81srJGHwYcis1AiIq3jcpvR044v5CHyD9wBlbxV2SQ
         U5UMsVGOxhhMWPr22kUFlBrsJH8aStczetAtCLJWcusIJxkzMxHhxlZcFPOBCCqi2ZDE
         mgkQ==
X-Gm-Message-State: AOJu0Yx82l2TbEcYnRvyFBRoM0BYieLVXmcUxPQGQj1Nz9+cAVqty8Wo
	w2BEwCDE71llZGwUCEUv8j/M1IUKeDttqnf9Eq/7vT6YYvH5O0z30k0eaFq1r4Dx7WvTnwc6Uzw
	V+M8=
X-Google-Smtp-Source: AGHT+IElZ/nzi6opfj9ruAUNeyKcWA7rvb4WGN9odoD1EK5z1CcsxhGieqRAxdCGTNpS7FxMs7ff+g==
X-Received: by 2002:a17:903:11cf:b0:1d9:3d3:4854 with SMTP id q15-20020a17090311cf00b001d903d34854mr10272957plh.34.1707025228027;
        Sat, 03 Feb 2024 21:40:28 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o11-20020a170903008b00b001d94c01ae96sm4039529pld.66.2024.02.03.21.40.25
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 21:40:27 -0800 (PST)
Message-ID: <65bf234b.170a0220.9fa85.e193@mx.google.com>
Date: Sat, 03 Feb 2024 21:40:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.75-cip14-132-g6e54756fbd6c2
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 12 runs,
 2 regressions (v6.1.75-cip14-132-g6e54756fbd6c2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 04 Feb 2024 05:40:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14651

cip-gitlab/ci/pavel/linux-test kselftest-futex: 12 runs, 2 regressions (v6.=
1.75-cip14-132-g6e54756fbd6c2)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
| regressions
-------------------------+-------+---------+----------+--------------------=
+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | multi_v7_defconfig =
| 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.75-cip14-132-g6e54756fbd6c2/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.75-cip14-132-g6e54756fbd6c2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6e54756fbd6c2a85eb65a7be04700955d2e49b68 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
| regressions
-------------------------+-------+---------+----------+--------------------=
+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | multi_v7_defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/65bf1a1f8a6612b3c100a03e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm/multi_v7_defconfig/gcc-10/lab-cip/kse=
lftest-futex-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm/multi_v7_defconfig/gcc-10/lab-cip/kse=
lftest-futex-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/65bf1a1f8a6612=
b3c100a03f
        new failure (last pass: v6.1.72-cip13-30-g79e2886a5da69) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
| regressions
-------------------------+-------+---------+----------+--------------------=
+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/65bf11978ccefc70a500a078

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig/gcc-10/lab-cip/kselftest-=
futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig/gcc-10/lab-cip/kselftest-=
futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/65bf11978ccefc=
70a500a079
        failing since 3 days (last pass: v4.19.299-cip105-1134-gc868d5e4ada=
a, first fail: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =20

