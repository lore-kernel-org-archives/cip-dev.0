Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6ACC25B08
	for <webhook@archiver.kernel.org>; Wed, 17 Aug 2022 12:08:14 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web12.27859.1660738087726507863
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 17 Aug 2022 05:08:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=TXDSKM0g;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id p18so11834699plr.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 17 Aug 2022 05:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=Ba6hMtAxJooE7jEkrHBvTfLRzaI8Gv6yL5lM3ZJzgQQ=;
        b=TXDSKM0gMjeZXVhI9lUNpxHzwwREmFirroBsBjROTLNmZwoiNi3R2rBf8U+mDwh9sD
         waY67w6X7Xu5y39b05iH9IKOt/KzjRXai6KQ+NxnnFRAKctBJ0RUdMGgry4Y86f9Kxij
         6KwLg6j83k09+yANBlqPHDRYvZ66rXEMzvYc/6hCR3lTgJC7vN37aTv3IImL+g3W6CL6
         MGkxxGVRTm+mlskOKPDpznKrgKrAt6xhefo9Nvnnyy/GoVGJ8zN+xKlleQ2yYM94yJ5Q
         VrZYz5EZcmRZTmsI9MN0QIDMgSngKFTchfVfmspNCxFqF2fd8mCg+iG/kjqwyzrlJI9B
         oNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Ba6hMtAxJooE7jEkrHBvTfLRzaI8Gv6yL5lM3ZJzgQQ=;
        b=Y++vfx5dqmooyCMnibuiuAw4UdQ1n36y6FH9MkkB0Im5MsPd4MbooVOn2yOx//atug
         h6DSRlenI0qO+sjYdrJdt5H4OcUTRv/13Y3GoW/6UQ8LGm4TdIQ0V0Y8uR4BHvNKTgzI
         qdMzfCM+Vd0OYzayUtebVGmQxvfzx4COfdqFr7Q1ZMwS9VrYiJsTX5pGZ1XyaqSc+uda
         m6swZkdU11p5NCfj/pVRF54UgW5q3WqfGiVFuOQp4lxJUWwZSFSCh/8Cqvcbk4ebYt4E
         7MryAXb4elZaP8F/AFR6iyVAikHXFqiw6h9SjtqjcDPLMb2wlLUp+XezOQEKL1maHdzW
         OHlw==
X-Gm-Message-State: ACgBeo0Pn4jnk4hFQhbRvteldG8a9W8uLm/TeFaoGKIzlSVVNQ92ljN+
	rcO1uL4TgC8WXvAfcmiUop7WvofRTTh4ffmr
X-Google-Smtp-Source: 
 AA6agR4J0ZBRMx7zfo4hBXlO3BKfbvVzEWqKMxmwF0T4EkqRlDAkFIVrrrm+uyEhM/sY9cRX+YtnVQ==
X-Received: by 2002:a17:90b:33cb:b0:1f4:f635:93f8 with SMTP id
 lk11-20020a17090b33cb00b001f4f63593f8mr3600482pjb.74.1660738087089;
        Wed, 17 Aug 2022 05:08:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 l124-20020a622582000000b0052ac12e7596sm10207722pfl.114.2022.08.17.05.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 05:08:06 -0700 (PDT)
Message-ID: <62fcda26.620a0220.67558.13d3@mx.google.com>
Date: Wed, 17 Aug 2022 05:08:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-84-g3b53e4dbd9f41
Subject: cip/linux-5.10.y-cip ltp-mm: 2 runs,
 1 regressions (v5.10.131-cip13-84-g3b53e4dbd9f41)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Aug 2022 12:08:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9279

cip/linux-5.10.y-cip ltp-mm: 2 runs, 1 regressions (v5.10.131-cip13-84-g3b5=
3e4dbd9f41)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.131-cip13-84-g3b53e4dbd9f41/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-84-g3b53e4dbd9f41
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3b53e4dbd9f41171cf639b3ba0b107f6d6f444ac

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  bccfa7395fce4accfd30cbf7196c0a6e8db37728 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/62fcd43deb26e4cef73556a7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220812.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62fcd43deb26e4cef73556a8
        failing since 217 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

