Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C270C54E55
	for <webhook@archiver.kernel.org>; Thu, 29 Feb 2024 09:57:02 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.21177.1709200616787756281
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 29 Feb 2024 01:56:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=dEjWL1Xw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d944e8f367so5636905ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 29 Feb 2024 01:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709200616; x=1709805416; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ayU3nVKRZzkvCWUCEGAayrZlq4rbNL81ThnEzPXBqD0=;
        b=dEjWL1XwTZKF94bwX24YyhtioLWfY4u8aFjjU2L0sst21EbzU/IDDoMbcs3rKueNgX
         bKKBXXUpzVLvrbRaFFfe2lm/ryUGh4l9FUtw/Pxfen1LKE9sXrOL6Gpd9yl9YiKIFJ3g
         N/Os3B97fLcRbNi+sFq+AvtkRaSLkvwS/IAdKcfPeK7FaCx9n2fis+R6dqkyqyb2mwVT
         aWH2eqqMnW0TrbvMO5mZY5eX0AQmgw+YIqlsFiUnhgxUHbK2Ak8gGI2qNkrREesm3KFQ
         Bt7CM0TcQOguwfYbkL9a6pdUiRRrzwGvBzGqK+3+Vp9p/rTlTuq5gAJleRj7yYVJwWnU
         /HEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709200616; x=1709805416;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayU3nVKRZzkvCWUCEGAayrZlq4rbNL81ThnEzPXBqD0=;
        b=SHD3TPxCSGLPjo8cFYkHlahIpUCdcmW+cwWcG1eLBzTyHOWMHCgfcyz0X0kWaRMwXE
         zoUEAblswv6J63sjiIB2ppRcakm2SOYqZPyNv7z9ofBR0G4fHBcm/upAnfjl3aFhtv7z
         ckDVJ6Eq4B8/U1SuGqiiuNcj4tMKsIt1nYEefiCxBaC6PflG+u487dmOpCeFUaLdJKs3
         92NWa8IG7P0cnRzMKHkoMEvAJ1FPxVp9G5ZKbOtgHr4cquRyKVvqajT3mvMvd696vRDz
         Z5c4RIdWxCcU8fqScg1xkFkCDIroaXEcAGX9V8E1QJeoYay6qEF0uMs3tuKQAYQzRFxk
         KZ4A==
X-Gm-Message-State: AOJu0Yyjf8sAB7ChymtWDnz9ntKGAhzkRY1MGfPNsB8YZabrrtu5gKpP
	cs7J6wyRPeQufvhCuHd/OM503JJmTftDxWm818C+oM5+3+Ub2fOfLG2w5IEz/dsjWfoVDfRROlz
	atjQ=
X-Google-Smtp-Source: AGHT+IH2UpzPVEz1tfJanLg754WQdgxc1FehBLRpNs3LCSd+gOCAxBl/k8a9Kk0btQnTy9VKeeNAog==
X-Received: by 2002:a17:90a:17ea:b0:29a:b136:56a6 with SMTP id q97-20020a17090a17ea00b0029ab13656a6mr1747537pja.27.1709200615666;
        Thu, 29 Feb 2024 01:56:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id pw15-20020a17090b278f00b0029930881068sm3223976pjb.49.2024.02.29.01.56.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 01:56:53 -0800 (PST)
Message-ID: <65e054e5.170a0220.95f9d.eec5@mx.google.com>
Date: Thu, 29 Feb 2024 01:56:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-56-g55117716ac0fd
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-mm: 5 runs,
 1 regressions (v5.10.209-cip44-56-g55117716ac0fd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Feb 2024 09:57:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15109

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-mm: 5 runs, 1 regressions (v=
5.10.209-cip44-56-g55117716ac0fd)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig+x=
86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-56-g55117716ac0fd/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-56-g55117716ac0fd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      55117716ac0fd541adb5a35e66eb21c45107b040

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig+x=
86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e047aa990cc7a7ae637026

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/x86_64/x86_64_defconfig+x86-=
board/gcc-10/lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/x86_64/x86_64_defconfig+x86-=
board/gcc-10/lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65e047aa990cc7a7ae637027
        new failure (last pass: v5.10.209-cip44-424-g38943e302f8c8) =

 =20

