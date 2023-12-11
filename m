Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFDEC10F09
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 09:16:11 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web11.4453.1702286161982483010
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 11 Dec 2023 01:16:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=mzeAcPT4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ce6caedce6so2534290b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 11 Dec 2023 01:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702286161; x=1702890961; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oIZZPWdsh+asze9aqglCNmyA1SW3PRc6jb0+kIswQAA=;
        b=mzeAcPT4RyiNizUYqtHhFOhW3O3ywIVp68ODgOEm5v6Kp7fsGBTJMYzNqHJt5jGAJ8
         42wghuk2t56ZZq7Pi5YjllxZsj2ieLisdW4hGi4HipcoycqR9Yexki2KoCXGSR8/KVOt
         6Mq3zSTivwV5zZ6mmAgxqDJ224nAqihq3t/n461NBuWkT5knnuTSYGFpHHj9VysrcKks
         OyNrJ9w2EihwEHKgkkgnpwJnStKQaFg9lj3+dZjeMXYS5++l0STiQ2NGpNSq1pcw5g/q
         VncSEhCvcYF/WSPZaji3g18AZ1aV+IPNSLg0YL7UshIqBZ39/6fAxu2Beh3BjxJwnTVq
         Be9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702286161; x=1702890961;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIZZPWdsh+asze9aqglCNmyA1SW3PRc6jb0+kIswQAA=;
        b=AWs1FbMbKAQq2XEiGImSlKPAsJIn6Yr+p9ErS7dfRonvr9KV/spuyTm+g2jkflBWjK
         nmABm7aFo8Y+iCXFq3lhEp8FNdg8mQ30vjyejoegh0o8KRnzgi9GruUPyIYxi5QTjbP0
         FeIhtcAyscNx/hRtj4SlKkGMSawAOweZoo4RtO270jZu5VBiKt4iqVrtYxwX9Pd9zMgi
         OL3MbWrg5ribmouU5D7rHWXU1fS15RT2ghoNN5lW7+gXsk9GsZmDwu+LtecUoeZeUegi
         n/WKy/9uQUIXZ2hm9cuA0WPTMv4+kC1A1qqSrkYwTmSjvAaallxGnyDWiYh6eYaS/th+
         mv+w==
X-Gm-Message-State: AOJu0Yw/FXP/bDnJImDTIbIAqBX+SdT6PreI56J82vqaZHcc8zWfkK1b
	uKwh01iQwEEN2oE1qBWI3FOJwgbL4fDTSSGbovXW7A==
X-Google-Smtp-Source: AGHT+IFUbOJJY3Fpj95URNFwVdUyW8bUIdlgHsqkavvfwRdWPp5KVvwgCEqsWIRj6ZEL+rVlveP3vg==
X-Received: by 2002:a05:6a20:bc88:b0:18f:97c:4f71 with SMTP id fx8-20020a056a20bc8800b0018f097c4f71mr1564546pzb.125.1702286160766;
        Mon, 11 Dec 2023 01:16:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902768c00b001d076c2e336sm6051279pll.100.2023.12.11.01.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 01:16:00 -0800 (PST)
Message-ID: <6576d350.170a0220.34c14.0090@mx.google.com>
Date: Mon, 11 Dec 2023 01:16:00 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1187-g657481329b53c
Subject: cip/linux-4.4.y-cip baseline: 57 runs,
 3 regressions (v4.4.302-cip72-1187-g657481329b53c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 09:16:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13999

cip/linux-4.4.y-cip baseline: 57 runs, 3 regressions (v4.4.302-cip72-1187-g=
657481329b53c)

Regressions Summary
-------------------

platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
r8a7743-iwg20d-q7 | arm  | lab-cip       | gcc-10   | shmobile_defconfig | =
1          =

rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig | =
2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-1187-g657481329b53c/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-1187-g657481329b53c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      657481329b53c9dc746b686cfa529666e967e8c8 =



Test Regressions
---------------- =



platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
r8a7743-iwg20d-q7 | arm  | lab-cip       | gcc-10   | shmobile_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/6576cd0991226e7fb8e13487

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1187-g657481329b53c/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1187-g657481329b53c/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6576cd0991226e7fb8e13=
488
        failing since 221 days (last pass: v4.4.302-cip72, first fail: v4.4=
.302-cip72-372-ga3bc58e64f55) =

 =



platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig | =
2          =


  Details:     https://kernelci.org/test/plan/id/6576cfed13709c6bd0e134e1

  Results:     37 PASS, 22 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1187-g657481329b53c/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1187-g657481329b53c/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6576cfed13709c6bd0e1350a
        failing since 319 days (last pass: v4.4.302-cip71-1-g61333eee4869, =
first fail: v4.4.302-cip71-590-g22fc523bf881)

    2023-12-11T09:08:35.366741  [   24.592003] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-driver-audio-present RESULT=3Dfail>

    2023-12-11T09:08:35.407574  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-12-11T09:08:35.407720  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6576cfed13709c6bd0e1350b
        failing since 319 days (last pass: v4.4.302-cip71-1-g61333eee4869, =
first fail: v4.4.302-cip71-590-g22fc523bf881)

    2023-12-11T09:08:35.286254  [   24.512425] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dfail>

    2023-12-11T09:08:35.327368  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-12-11T09:08:35.327681  =


    2023-12-11T09:08:35.331530  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-12-11T09:08:35.331754  =


    2023-12-11T09:08:35.336219  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-12-11T09:08:35.338469  FIRST, INC default to 1.

    2023-12-11T09:08:35.338693  =


    2023-12-11T09:08:35.341884  	-w	Pad to last with leading zeros

    2023-12-11T09:08:35.344076  	-s SEP	String separator
 =

    ... (1 line(s) more)  =

 =20

