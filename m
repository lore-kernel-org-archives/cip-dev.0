Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4AAEB64D9
	for <webhook@archiver.kernel.org>; Tue,  4 Jul 2023 07:26:07 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web11.53471.1688455559854336661
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 04 Jul 2023 00:25:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=VY6U/mHj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-666ed230c81so4346505b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 04 Jul 2023 00:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688455559; x=1691047559;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PO4A2x5GUIYxPzfDj539MCrbY+t143bxSSBcSlFUf/I=;
        b=VY6U/mHj9XHmHAF1mto3KUXcTYGpAvswHo5IR6RW26nTvCrfG0kbdtO0pf17aKJ8E6
         O0mPKLhjDUcYAV7hshflme1OE+ZJdYQmc2cVK+7Jbc7ZXLuTOtMVWKGJ6ig+WkFdz49q
         3imdDyhjYmq3gL9pJb0YXxA3AeTTdrWgrZm+cbgfuF/U5omhimKH8xW8cNJQYSxMmd1f
         RN17Cbl6DvlabLcrswz3M0v8eBuoFDGxLwjzIG3FSwWoTIew9lemGYDE9g9P5/Ql5HKp
         K3t+0gEzqTuzu3vO9ndBjDgXLOKh6T0BHgN0/xgRO4N9GrvZMCKjl6Bqh9Cq9cPDcqEY
         ecmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688455559; x=1691047559;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PO4A2x5GUIYxPzfDj539MCrbY+t143bxSSBcSlFUf/I=;
        b=WO/4Lst6afKCcxAto3vFDeknyNvY/WY9q9Kp7UK39Zuel7aFvBtbN8u6kEzAPPofyD
         4xFtTqVtjeaSEl8ZbBODsTq+Dds4kA0DDXfzQNAtymf9KxvI+zhLZnx1/pqy79Whu2Z1
         EKPDj73dWaM+ORC94DeYRoxGr3W+xPta2g+7R5a+NUGtEuqS2ec5bVYb9dBKNK7QVx4I
         qeAqh7Sc1m8w48EO475TmdXB5hgzVrbyQJJQRMw0c8oO6WIzDeMmaeq1q064OOSGyY71
         GpSjQfkCCm2mcWe0tMjdic3J0pZEzKZpmCekj8L74cycqUr70BLcvKhwhEwAn4OSOvQx
         UF5A==
X-Gm-Message-State: AC+VfDwqNZpbFJR8my5ejlWC5gru18pWYlaacm/kMywKKDLPjcgsDUyL
	OWRFKcvBHm7APMzuPAKprDsrbkdYxlWAOsv/0W9Eqg==
X-Google-Smtp-Source: ACHHUZ6npKrcXCbCrHXtRR6M+s6OHylVI8cF0bfHhzAevjMFs3i3WHKyUJqu5B9/U8yh/456RPoovg==
X-Received: by 2002:a05:6a20:511:b0:12c:8871:26dd with SMTP id 17-20020a056a20051100b0012c887126ddmr13599214pzp.25.1688455558698;
        Tue, 04 Jul 2023 00:25:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c18-20020a62e812000000b0063d2d9990ecsm10527401pfi.87.2023.07.04.00.25.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 00:25:57 -0700 (PDT)
Message-ID: <64a3c985.620a0220.f4de6.4f87@mx.google.com>
Date: Tue, 04 Jul 2023 00:25:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.184-cip36-10-ga711f789c23e1
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 10 runs,
 1 regressions (v5.10.184-cip36-10-ga711f789c23e1)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jul 2023 07:26:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12207

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 10 runs, 1 regr=
essions (v5.10.184-cip36-10-ga711f789c23e1)

Regressions Summary
-------------------

platform         | arch | lab     | compiler | defconfig          | regress=
ions
-----------------+------+---------+----------+--------------------+--------=
----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.184-cip36-10-ga711f789c23e1/plan/kselftes=
t-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.184-cip36-10-ga711f789c23e1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a711f789c23e157efd79724aec812ad47941364b =



Test Regressions
---------------- =



platform         | arch | lab     | compiler | defconfig          | regress=
ions
-----------------+------+---------+----------+--------------------+--------=
----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/64a3bdc310647b3ef6bb2a80

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/kselftest-futex-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/kselftest-futex-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/64a3bdc310647b=
3ef6bb2a81
        new failure (last pass: v5.10.182-cip35-289-g3c0549540706) =

 =20

