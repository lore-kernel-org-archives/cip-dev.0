Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686E0C6FA8F
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 20:38:01 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
 by mx.groups.io with SMTP id smtpd.web10.1339.1693427879967681386
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 30 Aug 2023 13:38:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=tzjZA39I;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.181, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3a8614fe8c4so27624b6e.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 30 Aug 2023 13:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693427878; x=1694032678; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W5UHdx9C1WNnaeU15khDTyui8aw/+Z5XLhcpxLPCQHA=;
        b=tzjZA39IJeRyYDO5XnYkcpd3A3torSl6WwydNKH4qtzQVGF68fvssW54sJAZqV33lh
         vKfSxSPLVxsmiBbLtbUGZ74u1sAVdWd88pdO6PZ9vlCsEULFFopnQG9nJbrViU/wLXTK
         P+a+/nOkDhTwOaHXBCV1IWC2rKV7XQx45mmTH3T3BMUdJbBBrOuyLJ/q1Szw3tHcgeGh
         357U3tjogXbvPJ4WnLAFZNOUGnJpPumjFn5gdLgAMRCMVcnSBuTISyQ4gmgbwfItumFd
         v2hEUXluChdqVZlU9SI1gFsyjxi+bqocH5DoyjsiB1Vrq3GUT1QQv6GD9qO2U+DI8ey5
         Ue4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693427878; x=1694032678;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W5UHdx9C1WNnaeU15khDTyui8aw/+Z5XLhcpxLPCQHA=;
        b=DY4Nt6BwmK3702iezEc2JgsetCrdyDGbP6a+ecGEn9crfYbsbgboWpiXwpZnBRP/ta
         LiBgo+DlS0GTxBxJDA2cbDKKHG48qJAOOf6JhVOhtfyEfkZfyHJMLwUbTUJFZ8F7rxxS
         /ena2tqtU9JBd1fe7dksk6hs2B1DxFHtwHMFw6GTwakRWtyYQIUg0BGiZD/9HtcKELwQ
         HvgTc8p9AMIiSZjDoUVX8SzJnBh6u+OwVGMBUgknCeNQ/RSFNXD5Wm5On9ws0fNq68WV
         ivogfurrkvhdJrl6JBwBgYqy+apUzzD0av/iYRj4u0PDv2EbBAEguMjOA5gAiC10w/Mm
         VfIA==
X-Gm-Message-State: AOJu0YyPUevr6B8E3WFnAIhsz0wequ9/TC08jzcB5gBQH70xLitiqZJk
	wIxMWnG9MiR6CXHwuIkiRvAbzXvIL6iFdKrWfLA=
X-Google-Smtp-Source: AGHT+IFecz3JPkpD6t5Y32xxCqid5MZ6n/+KL7HuKOHqbhkX2QasYoeUs1oCIVmCKD/4FRZYWrJK1A==
X-Received: by 2002:a05:6808:8f6:b0:3a4:34c8:f84e with SMTP id d22-20020a05680808f600b003a434c8f84emr3156284oic.2.1693427878527;
        Wed, 30 Aug 2023 13:37:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z3-20020a63ac43000000b005658d3a46d7sm3397pgn.84.2023.08.30.13.37.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 13:37:57 -0700 (PDT)
Message-ID: <64efa8a5.630a0220.1e03e.0027@mx.google.com>
Date: Wed, 30 Aug 2023 13:37:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.191-cip38-218-g9947ff6f0dba7
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 5 runs,
 1 regressions (v5.10.191-cip38-218-g9947ff6f0dba7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Aug 2023 20:38:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12925

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 5 runs, 1 regressions (=
v5.10.191-cip38-218-g9947ff6f0dba7)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.191-cip38-218-g9947ff6f0dba7/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.191-cip38-218-g9947ff6f0dba7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      9947ff6f0dba77de14d710cf958ecb42c2f4c10f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/64ef970a18df4d54a8286d71

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/riscv/defconfig/gcc-10/lab-=
collabora/ltp-ipc-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/riscv/defconfig/gcc-10/lab-=
collabora/ltp-ipc-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/64ef970a18df4d54a8286d=
72
        failing since 4 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4c8=
, first fail: v5.10.186-cip37-982-g80a0585c0aa62) =

 =20

