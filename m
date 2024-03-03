Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CE6C48BF6
	for <webhook@archiver.kernel.org>; Sun,  3 Mar 2024 12:03:02 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web10.71736.1709467372466500873
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 03 Mar 2024 04:02:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=WFm87bEO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.170, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so3316418a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 03 Mar 2024 04:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709467371; x=1710072171; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KJa+ZSaQdEifunlq1zXTDBo2VCdl4Z+x2Zs9tx2vQxg=;
        b=WFm87bEOT7/4NNguFPZYFEQ7aVsh7rgu+lp8Ip4SKh9Gad10qUOQ4W2isCjn/jyDxj
         Q+A1MmfP/HrTuJ058//5dNO6nlMwC+pL77IrQ2jayHxfuP2UjLZ9KZ6oJcf/FLeINKPa
         LOvDd7Mtc9FP6jf2sQK76uQmPL8QYhtvWO/R2c9fzfxINgxlNe42kUFqrkBT8P1wO1zG
         oHpztymCEB3aRNYf67+KQ4R5l/Jyj1N8v7bZm2JkP2J7l+jWEE3Uxgd5lzgoxtfImP8/
         tqy+sEt23ViVil2WUoPeNXH226Wye8IELkjJCWXunLGT/SCI/JLV35wmXGb7g0xGowYr
         1Y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709467371; x=1710072171;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJa+ZSaQdEifunlq1zXTDBo2VCdl4Z+x2Zs9tx2vQxg=;
        b=ikpbURV2L8w/CShtPjuCAllSveFcE2CgIFbMknFZqsB0m3mYyKK5skUBvusRaU3h6A
         E64DwvLMOGZWWARYBCdrm/SLCRknanPSvUKK8N3dVOXVP0nhB63coKTd2hOO73azvY/j
         scctn8/TC8T+++ecc956mCKG6Uo3DKpDgPs1HiKIU4oSBB9tkt35ncnZ1vFkOSrMZ5Gb
         8JO177m+OSzrTl4lBKqQzdrJfo548cRJ4YKk3TdT1JroZciY8OdbxFj8nN/CNWs+ZzJA
         5gIP/0UAO2113ivQoUoICkUwD31N8OzyLrA5UNah8EpTtQhUHEOIy+4EGJdLaVVVdqZI
         vGog==
X-Gm-Message-State: AOJu0Yzg9IHY7Cr5df8qNa4T/t4gt4GYwHMpKFRomJ7zhRV5sEO3ZVnM
	ty6RlfQVZbPs5OYS4/ONxw9UVW59IiwBFxZozE+oILLVvzpqJZ56MeHMd5Mhd8JngXUeZZqDw/7
	bkA4=
X-Google-Smtp-Source: AGHT+IHdwmnzfSNVmoqRUqS5nv12LMyACMT+IfzKDJ8sDdmzngc6cP72ipte0nAgiDyvnKxZpYo4DQ==
X-Received: by 2002:a17:90a:f489:b0:29a:7100:2519 with SMTP id bx9-20020a17090af48900b0029a71002519mr4063529pjb.35.1709467371290;
        Sun, 03 Mar 2024 04:02:51 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id rs11-20020a17090b2b8b00b0029af7dfd49asm7888091pjb.50.2024.03.03.04.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 04:02:50 -0800 (PST)
Message-ID: <65e466ea.170a0220.d7b94.1f41@mx.google.com>
Date: Sun, 03 Mar 2024 04:02:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Kernel: v6.1.80-cip16
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip baseline: 137 runs, 1 regressions (v6.1.80-cip16)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 03 Mar 2024 12:03:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15175

cip/linux-6.1.y-cip baseline: 137 runs, 1 regressions (v6.1.80-cip16)

Regressions Summary
-------------------

platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.80-cip16/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.80-cip16
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c4a8a3898cc297c755b7d041d731243bf2338f24 =



Test Regressions
---------------- =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65e45940ac0fa530ec637012

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.80-ci=
p16/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.80-ci=
p16/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e45940ac0fa530ec637017
        failing since 100 days (last pass: v6.1.59-cip8, first fail: v6.1.6=
2-cip9-12-g3a5321f469b07)

    2024-03-03T11:05:38.183832  / # #

    2024-03-03T11:05:39.262074  export SHELL=3D/bin/sh

    2024-03-03T11:05:39.263352  #

    2024-03-03T11:05:40.747003  / # export SHELL=3D/bin/sh. /lava-12925587/=
environment

    2024-03-03T11:05:40.748299  =


    2024-03-03T11:05:43.460655  / # . /lava-12925587/environment/lava-12925=
587/bin/lava-test-runner /lava-12925587/1

    2024-03-03T11:05:43.462021  =


    2024-03-03T11:05:43.477559  / # /lava-12925587/bin/lava-test-runner /la=
va-12925587/1

    2024-03-03T11:05:43.530528  + export 'TESTRUN_ID=3D1_bootrr'

    2024-03-03T11:05:43.530603  + cd /lava-129255<8>[   28.463318] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 12925587_1.5.2.4.5>
 =

    ... (40 line(s) more)  =

 =20

