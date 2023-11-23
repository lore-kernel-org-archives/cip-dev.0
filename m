Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EA3C636BD
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 12:20:57 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web11.89643.1700742047279277131
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Nov 2023 04:20:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=OASF6TZi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2839b418f7fso621243a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Nov 2023 04:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700742046; x=1701346846; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BBUWrvXhUtQNtSUIrlxCk4hMui7lqZy2suA8gP8P86U=;
        b=OASF6TZi5wUlBVT7NMuL5pHrCUbU4puuUnGFbgBuB17nVp7uZWpSNXtHBPRE1ak/62
         /LKM2T8btugaSEyHSh7LKYYO5x7DUyYSI6uy0/ssYlokm+vC587wCurFRuxtMCOdb55P
         t++n9qXFQje+rItoaXrX4CmejzMnwUW+xUoARyf5HCMUK4Huhj3IeygRlqYz4Y6iLi7z
         tdI89Q59OKi83vuEjsqSq9sLVqRnWEniKIY7brnb/RvZwepDQMgMOb9q9UaGYNiMVs7L
         81ddkcubY2u2CyiDUiXV1u0AVOd4+hbDasP4aH9zRV8Y5TqO2Kyf36vnsWzophXCnBHK
         7VZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700742046; x=1701346846;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BBUWrvXhUtQNtSUIrlxCk4hMui7lqZy2suA8gP8P86U=;
        b=No9174ys/flBorshihij7Z5iu6b2HwyQ9L1h761zsUhlzwW13WNM1sWjwq5Ll/PL46
         lVvlc6CCnMWx4bgAsatS5vT6eoBpkEDvMIHsdXzuXBGVPJT5dRE7JKYbE+ws+L2sTUj3
         ehRt9UIzgFehPdfNW5yCtO4TDzv4/Lh2FYhTti5T9fN4d/ClSZ4ljOFZuuEvNUr8mmpn
         iZ8c83efO1es32e//cSoBvUJiScXaoXHVOY+4bSzkcaPu2BD+TeNvYu4UZEyaVEAi30J
         RKJWqJ1S74tPepaAtfEzAWF4HA1awRrn2dfk8Ft6FWd+6gGnvjRwJk234/dV9aEIx61p
         0oiA==
X-Gm-Message-State: AOJu0Yya2OZ6lwIXxs5U7zl5k6avc6kamr7z4gDivFOpo1JQ41uH/68J
	k6+eyqOi3fi5t7wh+ifePj8OjLVhEuTCxawkMDQ=
X-Google-Smtp-Source: AGHT+IE3k0r118ZmdWvEwUUP9n+qAUbf4M5dUjRrouynPN4NHeBGMiCJWqOOs9uw+9+5VfMbS032qA==
X-Received: by 2002:a17:90b:1bcf:b0:27d:76e2:ab18 with SMTP id oa15-20020a17090b1bcf00b0027d76e2ab18mr5057229pjb.9.1700742046171;
        Thu, 23 Nov 2023 04:20:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t19-20020a17090a951300b002800d17a21csm1425671pjo.15.2023.11.23.04.20.45
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 04:20:45 -0800 (PST)
Message-ID: <655f439d.170a0220.dc6c.3c6e@mx.google.com>
Date: Thu, 23 Nov 2023 04:20:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v6.1.62-cip9-13-g34c303883a305
Subject: cip-gitlab/ci/pavel/linux-test baseline: 61 runs,
 1 regressions (v6.1.62-cip9-13-g34c303883a305)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Nov 2023 12:20:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13663

cip-gitlab/ci/pavel/linux-test baseline: 61 runs, 1 regressions (v6.1.62-ci=
p9-13-g34c303883a305)

Regressions Summary
-------------------

platform      | arch | lab         | compiler | defconfig          | regres=
sions
--------------+------+-------------+----------+--------------------+-------=
-----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.62-cip9-13-g34c303883a305/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.62-cip9-13-g34c303883a305
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      34c303883a305f474c4a18745cf56101db5e9b39 =



Test Regressions
---------------- =



platform      | arch | lab         | compiler | defconfig          | regres=
sions
--------------+------+-------------+----------+--------------------+-------=
-----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/655f390f52b223517c7e4ade

  Results:     48 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-13-g34c303883a305/arm/multi_v5_defconfig/gcc-10/lab-broonie/b=
aseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-13-g34c303883a305/arm/multi_v5_defconfig/gcc-10/lab-broonie/b=
aseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655f390f52b223517c7e4b17
        new failure (last pass: v5.10.200-cip40-513-g195b5d2b5c744)

    2023-11-23T11:35:14.599433  + set +x
    2023-11-23T11:35:14.599923  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 264958_1.5.2=
.4.1>
    2023-11-23T11:35:14.713755  / # #
    2023-11-23T11:35:14.816927  export SHELL=3D/bin/sh
    2023-11-23T11:35:14.817717  #
    2023-11-23T11:35:14.919767  / # export SHELL=3D/bin/sh. /lava-264958/en=
vironment
    2023-11-23T11:35:14.920560  =

    2023-11-23T11:35:15.022596  / # . /lava-264958/environment/lava-264958/=
bin/lava-test-runner /lava-264958/1
    2023-11-23T11:35:15.023987  =

    2023-11-23T11:35:15.027554  / # /lava-264958/bin/lava-test-runner /lava=
-264958/1 =

    ... (12 line(s) more)  =

 =20

