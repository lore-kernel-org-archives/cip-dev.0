Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38BFC47070
	for <webhook@archiver.kernel.org>; Thu, 21 Dec 2023 01:30:05 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web11.42027.1703122201763984292
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 20 Dec 2023 17:30:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=TlFkYnPt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.54, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28bd09e35e8so168645a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 20 Dec 2023 17:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703122201; x=1703727001; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W7abaOS0yZu1p/Q6grAKAIPgq0LfOsjC+fnw48VlX+A=;
        b=TlFkYnPtRosAJ9u9yfKuLltn1Mk/x4085LSvY9H1Ysnqg0y0XuIou0noimzyPavAgh
         JcIRMge9EUmc60e71qBD0ZS6EJnzOUGKuzFk6/ucwVwd3VqtK81B9BQ7U4OyUXFs6m/q
         81y6QZbNIv5Mk32XdoVKbUlCtxr6hvT/xI1qMeVjHVVMSdWmPWnKxqmB7iTqFTQ1o18y
         c4zoo7Ttu1GqUnJvYjaCi23gT6W1ZIWG9i78x2eZ0H7fRMQHRFKdl0cdWrmk7fYqcg5y
         5LbdezhxYUv7KjjZRmw4+TftNzA3jW5tzpbMH/Z+DGOnnee5TOy4XjuSWB8uewh6BeMD
         Y2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703122201; x=1703727001;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7abaOS0yZu1p/Q6grAKAIPgq0LfOsjC+fnw48VlX+A=;
        b=sGzogZqI5GiWysFJKGYDnhMrJHNjpbQczramLAJyzSjhJV01RCOtVOo38ICDo8Eh/k
         2irVvWZF0LH5deA+/S9I8zqAm736GY0zJSF/1Lx446VZm3pbdEZa6RjO9S85W+54yBrQ
         gMvNoSNl9LhpDIi29LM/N5/Y9xZQtG9qmFN+Fw1JpV9tdUHSyY+2ebMDWXA1uHt9MYEB
         EKAtZ3H+sy/CZYXMgAFU3Ea6JeLSeqoI6kTtmyTXnneTfCz+t0lj0ASvfwMo48sGuxhR
         A4+apjMml2aw66oXC8Uojn+z2iAPN1xuI0dq3yOQ75UAWwcSuCWzInbmM/H1fa1UinjM
         Dr6w==
X-Gm-Message-State: AOJu0YwFC93itzvBjho6Hr6+P88x5eCp3Ocq0stvgTTmonW+o6KgblfG
	OJtjaxNJJd4rly5dtqb4Hv56wyqKgms6mmHuHok=
X-Google-Smtp-Source: AGHT+IE41VrXVgP/r7PyWYfFjRZSSHfWesEkdGubTMTTWmFM+6ndcAJ3Mdn4krsn7Zn162UPiYGCCQ==
X-Received: by 2002:a17:902:c946:b0:1d0:7d69:16e9 with SMTP id i6-20020a170902c94600b001d07d6916e9mr12163815pla.51.1703122200666;
        Wed, 20 Dec 2023 17:30:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902dad100b001d3f42edb4dsm346057plx.294.2023.12.20.17.29.54
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 17:29:55 -0800 (PST)
Message-ID: <65839513.170a0220.f06c2.192f@mx.google.com>
Date: Wed, 20 Dec 2023 17:29:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-540-g3640150b3b169
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 8 runs,
 2 regressions (v5.10.201-cip41-540-g3640150b3b169)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Dec 2023 01:30:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14180

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 8 runs, 2 reg=
ressions (v5.10.201-cip41-540-g3640150b3b169)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-540-g3640150b3b169/plan/kselfte=
st-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-540-g3640150b3b169
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3640150b3b169fcd03031a9e8aab166a9730a1f9 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65838458109a62971ae13478

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.t=
xt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65838458109a=
62971ae13479
        failing since 48 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/65838605bc44096a81e134ea

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+kselftest/g=
cc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+kselftest/g=
cc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65838605bc44=
096a81e134eb
        failing since 48 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

