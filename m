Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33628C61D9D
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 20:34:52 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.35328.1700685283457652092
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Nov 2023 12:34:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=nzcogemu;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1cf856663a4so1220255ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Nov 2023 12:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700685282; x=1701290082; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2Qx7cghAeEE8Z+srFtSZp3nWwkBYS1R7mZqHpLiO1os=;
        b=nzcogemuHqSAkn/CsC3GpUAxibH0PGkdOwXszimA8aLmoy3EhbaVrIhx/Qgts3hh8c
         qpK7ceLDfz9cGU0VB+mCY8z/gJikDvGSK4Ltm8loputGtPU5mjIFx/lyqQ38WYUVNKUR
         KnO4qmpLUOptIUJerGhb5UcbLbtFYJrV736uwZEOghXBBAch80zth+yDXWw1NLRI5WPY
         /T7E5/mKPpXJ0q+gEHnYJRqw4aZz06wUWCgBakYNzSyWtGJIuJspDT+OM6LoXoZv0Mtz
         Pb1xYapNYrwJZeHcoxfv+axVj3Bt0potypoWLfUUNc0jV6fIgDvrNASHUe8MjbyeedWW
         upwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700685282; x=1701290082;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Qx7cghAeEE8Z+srFtSZp3nWwkBYS1R7mZqHpLiO1os=;
        b=leGm0AkveE3AVA3J8MfsFljsHf6YK/5SWfc4yQq49bw4ysI1/dBrvWFr2CFHuS9LNy
         iU3jvrENKr1zXuK1ELWb9q754zNfOy+/2YrxSOtABFGFT3snMmsEZt8LJP1MmDZndb5y
         0muw39A/dCefAb3/kS7yRdqJ6ddssZMaILHJOUmI7yhqEIKrUb1xaE7guZuYUXgzRwHM
         zZCq1VTpWAQnYvM9yL9gJym2rlWENNUc5F5HQbDXB/72oMq7wXXUGqV9YIDLy7VxtIwd
         kZgfye/RfXJksJ94WeOlvMeTVNoGuHm6XR2zSycW/QMR4gGv86w7Q5jTKWy7qU8yCb6r
         k2jQ==
X-Gm-Message-State: AOJu0Yy2qyDTlPUHVuxk2TlKjBUHLU+ffm69icUc/3sbFKpbPpYBxUXb
	btICjDXCGjj7TbedGLEMVh0VEOX3nzAMwLLwGdM=
X-Google-Smtp-Source: AGHT+IEsrwdh22YTgdpstg3mzj+2QpEcgjyRpLz8N99jlbf5kHSxIEGrabN42OS+MSwzE3FVe6b4jg==
X-Received: by 2002:a17:902:ecc9:b0:1cc:32df:40e7 with SMTP id a9-20020a170902ecc900b001cc32df40e7mr3748818plh.66.1700685282367;
        Wed, 22 Nov 2023 12:34:42 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b001cf658f20ecsm97470plc.96.2023.11.22.12.34.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 12:34:41 -0800 (PST)
Message-ID: <655e65e1.170a0220.8a5ac.0817@mx.google.com>
Date: Wed, 22 Nov 2023 12:34:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.200-cip40-188-g33d0b44cd71d
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 10 runs,
 1 regressions (v5.10.200-cip40-188-g33d0b44cd71d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 20:34:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13645

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 10 runs, 1 regres=
sions (v5.10.200-cip40-188-g33d0b44cd71d)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.200-cip40-188-g33d0b44cd71d/plan/kselftes=
t-lib/

  Test:     kselftest-lib
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.200-cip40-188-g33d0b44cd71d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      33d0b44cd71d9f81944784e605bc1def7fa0b71e =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/655e511b5442218eac7e4a6e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig+kselftest/gc=
c-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig+kselftest/gc=
c-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/655e511b5442218e=
ac7e4a6f
        failing since 20 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

