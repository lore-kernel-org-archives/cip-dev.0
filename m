Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E96FC4828D
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 05:35:39 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.14233.1707284129591649610
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Feb 2024 21:35:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=HIIZgrAu;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d9b2400910so2014415ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Feb 2024 21:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707284128; x=1707888928; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V9f2pZaaz/wfuM23OlbPtUV3jml6gi4eUqjO5F1WBp4=;
        b=HIIZgrAuo4amYae0W1B02uSvhptvooKQrpENHPgOPj3yrWsg401w3uoXY7w4Nkq60O
         7LeQfT7icy3zPc6THtamkXZ6KfltpDzbKkvwwPNkFEBOa0vQWBIdhvH+IYAIXN7YJdaO
         Ja/32s0CPRyylgQ2dIvnuSdaYksWy2bY/CLr8VNBxkmCZ6ORPsyNinoMyrwO2At66P8N
         lPCyZiHoMDmcE2mbwN2ou8yrKjBZGjR8jTt+hEeOrQK3oTxk9gEbHOgp+Wu0gmL1mNJD
         QXnNFqU92Tl8I/O36D+VQ6v2VJnPKcTnJ+wDE1NymA7qFtHPshKYOoWvHIKruI5C5uvV
         Csuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707284128; x=1707888928;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V9f2pZaaz/wfuM23OlbPtUV3jml6gi4eUqjO5F1WBp4=;
        b=pH8STyZCKO3MQbg9P1W7Y/wAblGfoS4ltq8x5FDwCsqspIjTJi180qeIJuPB9pgCd9
         BgPCgJMZuZPJy1HI4reUOZfvOY3gMRSK1mTI0i0C2S31EjnHkmaCeAX6N3K0+ElDAxd2
         4hpPPhvOWcIST9TuSiaQwKD9RV7md2wdGT15+GjSm1IxF70pDCXKnBQs/yeDhVEXS/PJ
         CGeZSwoa/up0/67zbn3gfbASFYNxIajVDHy+V9QRTQ23WdO/Oeqmu/zRZGNs37jkzQQ0
         A724H8OwWX3X5P2Yt0j1PiJPWRToTNEouSRgE3strKEGlo+13TdWVcM/b4Q1AtOBF3W+
         IRFw==
X-Gm-Message-State: AOJu0Yww14hP7wyX1wht/jLffKzD8tKadedv4PROameLMYjdHLkOWV9a
	jaJWtO4AJjZVDBwoQacdqgYPYdms9mRYKn9VaTZXIxCs17KerCuRv0yqFiJ3fs2y5TAitErBt3k
	p
X-Google-Smtp-Source: AGHT+IHzMeBFCPdVoTsXdECbjPKTJnY5XviKFt+f1eIiUQMJfgf1SNBiOSlM/LLoYzLXu8BnzOIRRQ==
X-Received: by 2002:a17:902:d4cb:b0:1d8:ffbe:82d9 with SMTP id o11-20020a170902d4cb00b001d8ffbe82d9mr6081191plg.14.1707284128605;
        Tue, 06 Feb 2024 21:35:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXoYVuH31xXLKXfD8hVb1dpyV4BCE1u0hwBQN8xjNibn9sjtna+L1SG5Dts50UxpOnsujMxaZ5mv2eUupbssZ/ReX89tVFz8MhRZblfL6pk5GFdZwilNJUDEop3hRAeigIj1r0YUlGRlNFKbuwGhCZdvw==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l18-20020a170902d35200b001d95a6afbc2sm487411plk.244.2024.02.06.21.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 21:35:26 -0800 (PST)
Message-ID: <65c3169e.170a0220.77564.1638@mx.google.com>
Date: Tue, 06 Feb 2024 21:35:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1250-gd530578b1386
Subject: cip/linux-4.4.y-cip baseline: 66 runs,
 2 regressions (v4.4.302-cip72-1250-gd530578b1386)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 05:35:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14871

cip/linux-4.4.y-cip baseline: 66 runs, 2 regressions (v4.4.302-cip72-1250-g=
d530578b1386)

Regressions Summary
-------------------

platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig | =
2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-1250-gd530578b1386/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-1250-gd530578b1386
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d530578b1386a94e84c4ef7993e59fd028af441d =



Test Regressions
---------------- =



platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig | =
2          =


  Details:     https://kernelci.org/test/plan/id/65c31231b0b1ed47678e1e98

  Results:     37 PASS, 22 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1250-gd530578b1386/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1250-gd530578b1386/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/65c31231b0b1ed47678e1ec1
        failing since 377 days (last pass: v4.4.302-cip71-1-g61333eee4869, =
first fail: v4.4.302-cip71-590-g22fc523bf881)

    2024-02-07T05:23:35.473538  [   24.606364] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-driver-audio-present RESULT=3Dfail>

    2024-02-07T05:23:35.496214  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2024-02-07T05:23:35.496463  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/65c31231b0b1ed47678e1ec2
        failing since 377 days (last pass: v4.4.302-cip71-1-g61333eee4869, =
first fail: v4.4.302-cip71-590-g22fc523bf881)

    2024-02-07T05:23:35.444747  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2024-02-07T05:23:35.444881  =


    2024-02-07T05:23:35.448535  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2024-02-07T05:23:35.448785  =


    2024-02-07T05:23:35.453299  Print numbers from FIRST to LAST, in steps =
of INC.

    2024-02-07T05:23:35.455434  FIRST, INC default to 1.

    2024-02-07T05:23:35.455652  =


    2024-02-07T05:23:35.458808  	-w	Pad to last with leading zeros

    2024-02-07T05:23:35.460923  	-s SEP	String separator

    2024-02-07T05:23:35.464451  /lava-12711562/1/../bin/lava-test-case
   =

 =20

