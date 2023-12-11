Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D939C10F07
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 10:52:52 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web11.5755.1702291969934021122
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 11 Dec 2023 02:52:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=1T4hRRix;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d05199f34dso24265775ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 11 Dec 2023 02:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702291969; x=1702896769; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DaYBEPVRlPuKj6Wbuvd1D+R104wCBwi+hrXVYat513w=;
        b=1T4hRRix6PrJQ/8Z9Bno5tXx81pKiSFOlRo/noYKxWJDW5jfINtxoFa5HE3hr4XUjr
         kHaqDzjHXkOTyOuMiIB/SlY+OHo5hyIExjJUPqHXZAEaw7Yuo1CSTGkY97rdpMsD4A+D
         tCqFr/e8ZkhAAlP2bPG8s0dAiNpm3FtYj1MlhHDSumRNfS3tMNI0UF5xWMGdSF2M+NqW
         kp8Z0s4pspkIHtYGJfXBThHMe0UskbXPsVSJB+IB1MHhb4HFBqmzA/yeVSj72INHrOw3
         oQ315E6BdFBRYMVOW4OQYPiE7krwnhV2HypLkIhnolTyHzz/N+Th45oQEv2QWou4N0Mq
         HyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291969; x=1702896769;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DaYBEPVRlPuKj6Wbuvd1D+R104wCBwi+hrXVYat513w=;
        b=VQxAxoR0KXMgglbfeIosys9yT0+kuBRJiw+Aaewo6/iqZvYpKgsmEDvKa4BkM2XYeq
         oqXBL5K7M5OTBp1IQdHUMbjmo3CrxM5w+sb6f51O5KFY70rYtO+qRlshEp5/iEr6mlI6
         yzsltH/YByjOAhjK/ToXArdc6s4hbSn1vPljvKpZLE+Cb8CXNYwVoO96fvGTa4tF7xYF
         w7D1HyRHMfTZIZm1+EwNKkWniklx5o6HRoHWXgWaTlUHwyD8UHxwQsnVCMUeYNvxXO2g
         2GAcqG/oFldDk3+r8WoaYXOS1bjA+BbBxr2q5+getz4ClWvGNc1BMvwzQ4DvU4MxZNXE
         ZIrw==
X-Gm-Message-State: AOJu0YzLbZphnNkV/mpTOdB3vBuj0p1TcS+jRLvTwuegMKIpdrmEojvz
	pPHaMUxd7uXNRtwVLAOBLXLhuJ456Oi3MMwMq2sbAQ==
X-Google-Smtp-Source: AGHT+IFUMm3AiCTtAA0Tu0oq3HMoL8DJeRK536Tpjr8vdgnLOlxdi1H48U3LKQfBHlRSeDa3C47EzA==
X-Received: by 2002:a17:903:40ca:b0:1d0:ba36:eea3 with SMTP id t10-20020a17090340ca00b001d0ba36eea3mr2040264pld.7.1702291969079;
        Mon, 11 Dec 2023 02:52:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902ecc200b001d05fb4cf3csm6342823plh.62.2023.12.11.02.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:52:45 -0800 (PST)
Message-ID: <6576e9fd.170a0220.9126.11d2@mx.google.com>
Date: Mon, 11 Dec 2023 02:52:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-63-gfdfe1fbf93bc6
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 2 runs,
 1 regressions (v5.10.201-cip41-63-gfdfe1fbf93bc6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 10:52:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14014

cip/linux-5.10.y-cip kselftest-seccomp: 2 runs, 1 regressions (v5.10.201-ci=
p41-63-gfdfe1fbf93bc6)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-63-gfdfe1fbf93bc6/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-63-gfdfe1fbf93bc6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      fdfe1fbf93bc6fe6ed2708f11c2613bef556fdeb =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6576e0134b337cedc8e1347b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-seccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6576e0134b33=
7cedc8e1347c
        failing since 67 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

