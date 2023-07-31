Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078E9C001DC
	for <webhook@archiver.kernel.org>; Mon, 31 Jul 2023 01:15:14 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web10.85278.1690766113551084558
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 30 Jul 2023 18:15:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=GKWc85rp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1bb7b8390e8so23656575ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 30 Jul 2023 18:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690766112; x=1691370912;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rG8mT9s1fnnc7ZxnMtBqx8QsRmxFG3at3mubXKLypbM=;
        b=GKWc85rps9iej+GJQcFHAqz6gRzIKqStzWfjjRrVLvxzApUOYlsO8SniNLwFcx4oh4
         ruig9cgqMbMHCd3UQBSJO62dSGmtCBGGKFGtTwBr0hyGG3hcCabK5WCzGbp8BIrV1Gdh
         RVfYPpBIXv3ihwbzUL86295HODV4DkOVhhRtyP+TH7tmeCDxfN9NuwuByKgGm8cfpx4t
         NTeemmoH1SAHAC19TbbW0SNHuYeptjPmoqZvtbHvUMt0XumoRuuAddgB0ECocDuWpDcU
         9nBORlS/ZpRGxxU29EzIPUKKHXMpWkpEJi08miJrJ2bcPfdCopWjO2jX6as9C5fL9irZ
         849A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690766112; x=1691370912;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rG8mT9s1fnnc7ZxnMtBqx8QsRmxFG3at3mubXKLypbM=;
        b=eZHK/YbQgjTOf9aU61hq36qD++0h4kbZ0sBE8OjisX7+XRJNlXOdBz8jlmH2+2so3f
         HkYuDw7/JE+t2LPYX0ogYovXSiQuVuikwH8Yb/kqlQVsQPm/EvF31+VfWgTqXKJqqkE4
         vG2aK6dsvA+7tYCwdE717XM0jcTauelN1/vh5TyoDpmlbh79digTU9p5OBPNHiqq34r0
         wP8sElbJynJSrzAl1ErVS/DWWWAWN35eZah8YjEECtcMTGbar4ByaXtHQ9s6iNG+GNdT
         V3ylv/svTsJ3j1HvL72BdGm9YlVdE3VoDlwZ9ia3KgDMH2vKOna/4tkGhAZ0WtPejERl
         BOnQ==
X-Gm-Message-State: ABy/qLYfLWL6Z1XdPXR1dQN8ugT91O9NQPs/0pzRKLxtfPRItlqzL9AK
	waPIWa1dDr4sPBhFxumAJkGsWJAy3NZtZ6Au4VS9/A==
X-Google-Smtp-Source: APBJJlFy3dm+oJWYyLhfZuVrMwsjZSUK+u+FavTbpduvGw8nuPBeU+kpsy7KFuU95KAgpuS6YUmwWQ==
X-Received: by 2002:a17:902:e74f:b0:1b8:6cae:4400 with SMTP id p15-20020a170902e74f00b001b86cae4400mr9484481plf.37.1690766112333;
        Sun, 30 Jul 2023 18:15:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b11-20020a170903228b00b001b8943b37a5sm7191649plh.24.2023.07.30.18.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 18:15:11 -0700 (PDT)
Message-ID: <64c70b1f.170a0220.e4f78.c9a5@mx.google.com>
Date: Sun, 30 Jul 2023 18:15:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Kernel: v6.1.42-cip2
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip ltp-fcntl-locktests: 5 runs,
 1 regressions (v6.1.42-cip2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Jul 2023 01:15:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12527

cip/linux-6.1.y-cip ltp-fcntl-locktests: 5 runs, 1 regressions (v6.1.42-cip=
2)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.42-cip2/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.42-cip2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0d2ec524c820bab8eabc0f1b34aa41ff55d4e9b1

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c6f5a2dd8c85544c8ace22

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.42-ci=
p2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-fcntl-lo=
cktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.42-ci=
p2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-fcntl-lo=
cktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/64c6f5a2dd=
8c85544c8ace23
        new failure (last pass: v6.1.38-cip1-7-g5cff59cac977b) =

 =20

