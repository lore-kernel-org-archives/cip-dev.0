Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ED6C46467
	for <webhook@archiver.kernel.org>; Sat, 14 Jan 2023 14:17:22 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web10.116527.1673705839210690238
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 14 Jan 2023 06:17:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=w/51JrHs;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id q64so25090366pjq.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 14 Jan 2023 06:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ajz+tInpEFw4a7i+mJAmUADN7/qpcP3i4NniwZ2tfXY=;
        b=w/51JrHsPQNNmKbhQ4iV8bCvYmYkxcXXI9GjzGWBgJfuC0rbX38mkSQV33Ygdd3wqQ
         jQx62xpY4fucDYU6kYmPcg2vDh7i5wQ3v3s71AHI6Ovarua+pkmz+Nvla2GuPjqNsRkx
         6B1Jms1KBr2gl/hp/UeKhLOxsAfM2gTLik/MRD5SmmpxGdvq5CKaMalvxqzmlsConne+
         a9Mj49nqnjSUFTFk+xtY4WN3klX1nrFng1wGU6HTSaVq0RccDHj+fxPBXCnXU7FnyFf5
         YsgcikY4Mmv0oQJrsv8OpkbHNgLLIJ/V9BBn1Aa0tPqmHxa/lsKTxztpUXZIKjwGoUdZ
         2aPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ajz+tInpEFw4a7i+mJAmUADN7/qpcP3i4NniwZ2tfXY=;
        b=al+XS318V6c1yH3c9zySagR9D1oXmIIudq2dYdrUO7qwFUAFgPMLEqiEGmxKtJmiAX
         +rSm8uL7wPeB0Vva/gc6fj21xS9D6uXptP1tgK+RmxsEUqrEfEzRHCU6QE/QlLVdXahR
         /RKqt/ExpYKTAzeb0viZppgDTwj538YhjrNCc/nTRFdMjqrgYS2aEF2nbBZFoct8UPSU
         798uPfdZRnCXOkQrvbVtfsTd1dMjjz1V+01/63ZoRKYhaRucfsJbJsqOp3zNd0XzFdIY
         DzTkUL9q4DSW5/jqAnkvSjSaICM8qJ1SJlC/xmt6MMNSPVzrEWnEfuyCzI0Ccj4syQfT
         k/Vg==
X-Gm-Message-State: AFqh2krQUb/ACCLEk5F0cJrjpCebczxV5Kgeg2N0UMEmUJ2R5XezCnyr
	uyvTKNjEe9DZ1SPrV8btzHsnAFok7wy/M0sC1lCrLQ==
X-Google-Smtp-Source: AMrXdXvw77hgkkHyvdyOHaYG0yvO25sBNI/cOYTVfIx9j08L/5w8QMykzl+SvRdYkcMPgSaSOMRyHw==
X-Received: by 2002:a17:902:e80a:b0:194:6f0e:990 with SMTP id u10-20020a170902e80a00b001946f0e0990mr9139697plg.39.1673705838171;
        Sat, 14 Jan 2023 06:17:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902d48900b00186acb14c4asm3671527plg.67.2023.01.14.06.17.17
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 06:17:17 -0800 (PST)
Message-ID: <63c2b96d.170a0220.4b65e.6232@mx.google.com>
Date: Sat, 14 Jan 2023 06:17:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.162-cip24-788-g63c30712099cf
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 10 runs,
 1 regressions (v5.10.162-cip24-788-g63c30712099cf)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 14 Jan 2023 14:17:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10363

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 10 runs, 1 regr=
essions (v5.10.162-cip24-788-g63c30712099cf)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.162-cip24-788-g63c30712099cf/plan/kselfte=
st-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.162-cip24-788-g63c30712099cf
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      63c30712099cff890a9fa023533c2971e6a4f87e =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/63c2aa10b3a5f4dcc41d3a02

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-788-g63c30712099cf/arm64/defconfig/gcc-10/lab-=
cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-788-g63c30712099cf/arm64/defconfig/gcc-10/lab-=
cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230109.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/63c2aa10b3a5f4=
dcc41d3a03
        new failure (last pass: v5.10.161-cip23-65-gca8c192cb189) =

 =20

