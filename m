Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0713C4167B
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 17:42:05 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web11.42245.1702057319727230368
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Dec 2023 09:41:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=QxlAwc7i;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ce76f0748fso1831150b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 08 Dec 2023 09:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702057318; x=1702662118; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nMwlvcRefF7JjOwz3aPdyHza3bmLOTe93hE+GgxWo/c=;
        b=QxlAwc7iBGyoEJGO1SuQaN2bB8utWDd2lafIWsZyJNKZnzdshGHeHn3qa1WAzi4zBC
         hwhyuoG8hYC80iB4UVgfzlfgIuYdZ1WX27Zlf5k8TXK4cTmCvyxLdD89E1urJeN7qypX
         fyUmnCt89OzU8JlSGGhSYPXMwYyA9PFkwJLvuu42UVCzivCWtgs3rF1Ijmd5yN/FjjJ7
         54PswZ6cP9myS83B+jJvQEzK9cbV8Wj3VHMJtGvTZO3wy1TochtQPQnQ+t3SsEhXWi5l
         cci3CsqLzHSujMMfZBkFHClqo5xipY5VYTJLqEe2XRdIyyW7tSIpjc1xeVb1UFjLT4jG
         epmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057318; x=1702662118;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMwlvcRefF7JjOwz3aPdyHza3bmLOTe93hE+GgxWo/c=;
        b=sSDzo6nMOHrrqW5M4E13rLCu6VcpfuIZ4iS8C3FTXMaigTGxdHhXkZocWqQlnA8o6N
         WCiAIrw81q3Cm0jv5UWL7Bi1DxlXSvtGN/QN8kHI0h6KYvJTlya/5Sr8ODhJRLCiC8tW
         kHYwVPnlcMuCCD87HV3z3Yx0UWVOi1aRK+9pen7lsHq84cE3dwbB1qxvFXZfQJC8dKX6
         sTWlLw0LPSSBC+rSwWQSUf/IgPxbHRSv+4Lp7t4DQGYLP/H62WoIgrzeEE4lZhuA3g7F
         ktnMKjTdFIE0lJ9bnmU4M6wOOJyPFv17G8YU/qFXaiHHyZ+u3EUNGmj3QNetVuB6YeQd
         w54A==
X-Gm-Message-State: AOJu0YyZAhzpttO6ZDdI6orqv2HL5pc8a32Xll1KQflrfG3JiDKqna9K
	2aWUsoLPdmrmJGwKvMbgRAnOo7T4ee0lsljfb4FJsQ==
X-Google-Smtp-Source: AGHT+IHvXnpUWmt7o5wm87vshPJohmheqQ+N2AJkz4ZjaJMt8++j4KmK9653dv4izq3xEUa7ctegyA==
X-Received: by 2002:a05:6a20:4b21:b0:18f:f310:5bad with SMTP id fp33-20020a056a204b2100b0018ff3105badmr372463pzb.32.1702057317967;
        Fri, 08 Dec 2023 09:41:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h26-20020aa786da000000b006ce4f01f769sm1841799pfo.45.2023.12.08.09.41.57
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:41:57 -0800 (PST)
Message-ID: <65735565.a70a0220.44568.6a14@mx.google.com>
Date: Fri, 08 Dec 2023 09:41:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-63-gfdfe1fbf93bc6
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 5 runs,
 3 regressions (v5.10.201-cip41-63-gfdfe1fbf93bc6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 17:42:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13976

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 5 runs, 3 regressions (v5.=
10.201-cip41-63-gfdfe1fbf93bc6)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =

r8a774c0-ek874           | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-cip41-63-gfdfe1fbf93bc6/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-cip41-63-gfdfe1fbf93bc6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      fdfe1fbf93bc6fe6ed2708f11c2613bef556fdeb =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65734ca3dcc10261c6e13525

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/baseline-=
cip-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/baseline-=
cip-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65734ca3dcc10=
261c6e13526
        failing since 458 days (last pass: v5.10.131-cip13-84-g5fcbe4a63ab4=
d, first fail: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65734efd644d89feeee13484

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/baseline-=
cip-nfs-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/baseline-=
cip-nfs-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65734efd644d8=
9feeee13485
        failing since 18 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543e=
, first fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774c0-ek874           | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65734e0d24ee7a22f1e1349a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/baseline-=
cip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/baseline-=
cip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65734e0d24ee7=
a22f1e1349b
        failing since 18 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543e=
, first fail: v5.10.200-cip40-513-g195b5d2b5c744) =

 =20

