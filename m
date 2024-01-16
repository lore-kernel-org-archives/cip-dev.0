Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9B0C4706C
	for <webhook@archiver.kernel.org>; Tue, 16 Jan 2024 04:15:12 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.4243.1705378502823529512
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 15 Jan 2024 20:15:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=M0nK2dt/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28e7b2f1988so35857a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 15 Jan 2024 20:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705378502; x=1705983302; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NVEVZCK4LnEMHlCciazRsWJW81uVOZebYElbvHJhMsI=;
        b=M0nK2dt//9bg6eQTxKIgekbkcbRWdkKo63oSkQZNzbUNGcWBvLjOuPtOZPGvCmuIkV
         +SEFExCri1/tmx4ye9qm7Ao27lHyt8hWFj851/KGV6dyEsdloJ94vo1XIw5RVXIjh37O
         Wn/XxzlHnATKs4bI6lX+4iJb3VZaaTioRLfGpjRAv2OhHQbI56S3KIeMSa0v+/ikypdb
         cVaAs1p472VWPEfq4BPVDpUNyk7va1pbDqcfInOLLJpQdyo0/zFWm/UZpbY+158CnV3F
         inferRPFVkY66tTR107/m0dJTfdF+eSMo6F2RCMivWAI1XMtlsD0NJw1JEZ3XGWImYI0
         Nuxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705378502; x=1705983302;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NVEVZCK4LnEMHlCciazRsWJW81uVOZebYElbvHJhMsI=;
        b=LJ40zlVVZY14Pm1q1Zq1prFA/efYM/PBJ5cjnU7tiHYXdrFU+vp7S7W+MvrAmqRtfe
         W5RkTX2H93pbOOqFt9WAxU1UR6FeU4TmyroHW6gZrfIDAkAcDwBCCOOl/+Ftow5+c9A2
         3n+dgE7ObVG9W3Oqv1kOhPJnlFP9oDQDfy/vT7i0YOJwm4X0MBwVjPi+IVbFpljaFxkY
         hQNwwpGz8/7B2kzcG/Bcp0LbgSKXKh7ORLhjcX48any9vSldneBVr4lNgSZ7W+aTLQHb
         3Vk88Xl3CgXQD/903CyQA053ejpAEiDnMK6dasM72IYbFzyapMnrVt1eRC80KxjhLKaX
         jPUA==
X-Gm-Message-State: AOJu0Yynxf2Vf75dzvDXcoInbG3BXBjV3u6RTeOJFFEb5jwILORz09va
	Qv9sA9OngPEADvaA4X+stc08mhusTFpX166XfISn/RT+JZSz0Q==
X-Google-Smtp-Source: AGHT+IFFMwfR9U6xUyEcMz3SAvcGVrLAlSSj40GtwkpPXSvpYyJUpSWl/Tjgjvs4vhu7qVAM0i4GhQ==
X-Received: by 2002:a17:903:1d0:b0:1d5:bd8b:b438 with SMTP id e16-20020a17090301d000b001d5bd8bb438mr2061888plh.108.1705378501752;
        Mon, 15 Jan 2024 20:15:01 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jx6-20020a170903138600b001d331bd4d4csm8373498plb.95.2024.01.15.20.15.01
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 20:15:01 -0800 (PST)
Message-ID: <65a602c5.170a0220.2e6c3.b32c@mx.google.com>
Date: Mon, 15 Jan 2024 20:15:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.304-cip106-27-gf3e967c370d44
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 37 runs,
 1 regressions (v4.19.304-cip106-27-gf3e967c370d44)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jan 2024 04:15:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14390

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 37 runs, 1 regress=
ions (v4.19.304-cip106-27-gf3e967c370d44)

Regressions Summary
-------------------

platform      | arch | lab         | compiler | defconfig          | regres=
sions
--------------+------+-------------+----------+--------------------+-------=
-----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.304-cip106-27-gf3e967c370d44/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.304-cip106-27-gf3e967c370d44
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f3e967c370d44f37d5b1b2cc02e9898573c4a4ee =



Test Regressions
---------------- =



platform      | arch | lab         | compiler | defconfig          | regres=
sions
--------------+------+-------------+----------+--------------------+-------=
-----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/65a5fd5ce9837a745f52a3f4

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-27-gf3e967c370d44/arm/multi_v5_defconfig/gcc-=
10/lab-broonie/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-27-gf3e967c370d44/arm/multi_v5_defconfig/gcc-=
10/lab-broonie/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65a5fd5ce9837a745f52a429
        failing since 97 days (last pass: v4.19.284-cip99-114-g02e97826987b=
f, first fail: v4.19.295-cip103-95-ge42cfc8bb88b7)

    2024-01-16T03:51:09.391403  + set +x<8><LAVA_SIGNAL_ENDRUN 0_dmesg 4619=
70_1.6.2.4.1>
    2024-01-16T03:51:09.508378  #
    2024-01-16T03:51:09.610422  / # #export SHELL=3D/bin/sh
    2024-01-16T03:51:09.611206  =

    2024-01-16T03:51:09.713055  / # export SHELL=3D/bin/sh. /lava-461970/en=
vironment
    2024-01-16T03:51:09.713812  =

    2024-01-16T03:51:09.815800  / # . /lava-461970/environment/lava-461970/=
bin/lava-test-runner /lava-461970/1
    2024-01-16T03:51:09.817100  =

    2024-01-16T03:51:09.820578  / # /lava-461970/bin/lava-test-runner /lava=
-461970/1
    2024-01-16T03:51:10.174848  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

