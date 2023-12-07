Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF581C10DCE
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 21:13:20 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web10.104232.1701983591367953650
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 13:13:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=07qPv2Lv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2851a2b30a2so1202408a91.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 13:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701983590; x=1702588390; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/6WL4axNwmFHgVkU/Yd66PDMh6HIbvGa3Sfo9tCYScU=;
        b=07qPv2LvSV44dBpN6mgQVBvt0a/rLv1mYuqWKFcF/LLh5vru5S3hlqjJC9PseDh91R
         1JLzD7z6D3pLpkPNWK/nnV4MjEbJNf3jFecDXhWkTGmXE3Yk1MZOTRxoXL3n/2GIKOFB
         XWi0cjrRWOjhGEr0PcpaQTh+r98tI1Nk7tNV2Chxulm3RWHdcBZsN00MamQtwdqQuUzo
         QIzXs+2KGuLgIhzAHhM+msfZbFf2PTto3eNiZRgE76nvDPef6ix0hi5Ie3xEC2pEb9aN
         hPL/OVuUb4/M/TpSw8eiW7YFcre7iRhevXoFgKZTmqb3h3giAdmPrl462XiXEOQUGbgB
         bC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701983590; x=1702588390;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/6WL4axNwmFHgVkU/Yd66PDMh6HIbvGa3Sfo9tCYScU=;
        b=OpPwL3xlAq1jKjbQe97mO9GoW7PtFs9QVQgCLGTq6AUE/alLXICQXaOMXpEqkUkx4f
         LzDE5arhwQajXD1B+s2Jiw/zVUrBnhNO11LOVsGNHoX4Y3Ojki5hUuhoNFdbtaynjWHP
         a1Yb/KDW8JUKlxci/jHQDgimE5kZJY2kRPAkJTUnQ/9S6xkdiqaSyBkiVTxccHwzCZ0O
         5l4H9OSyju5pIpiYjWeYOM1LqEz1vMaUXGcDPjTMBjMaXhpIRgDkv40T8VMjoKlwNnsQ
         VByaC6//yxxtizc9fSSDsbgzBNQZk5hhJnDA0zdjM1nhwHxO8mWkvfqDmnTnA5HC9hSi
         BaCA==
X-Gm-Message-State: AOJu0YxwDDRkro0vGXEmYvp2zfWIONIBZdbQ0/tORZ2AZ5yAnZ3UF1ln
	fhXBtZTKtHSwx2lWaelxoKCo7bS9z0y05ufpGOZnjg==
X-Google-Smtp-Source: AGHT+IGaFTC+QuBkujvgKCtjEBGmHr0N4rK7w7DGNP/ARBZj0yxe6g8R4tWG2S+aWBiNbZDyqqFfgw==
X-Received: by 2002:a17:90b:4c0a:b0:286:a27a:f244 with SMTP id na10-20020a17090b4c0a00b00286a27af244mr2580539pjb.22.1701983590402;
        Thu, 07 Dec 2023 13:13:10 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id px6-20020a17090b270600b002609cadc56esm356894pjb.11.2023.12.07.13.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:13:04 -0800 (PST)
Message-ID: <65723560.170a0220.dede0.1de3@mx.google.com>
Date: Thu, 07 Dec 2023 13:13:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-28-ga386bc478aa6b
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 2 runs,
 2 regressions (v5.10.201-cip41-28-ga386bc478aa6b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 21:13:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13920

cip/linux-5.10.y-cip kselftest-seccomp: 2 runs, 2 regressions (v5.10.201-ci=
p41-28-ga386bc478aa6b)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-28-ga386bc478aa6b/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-28-ga386bc478aa6b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a386bc478aa6b422e6dd5d92a540987ddfca9397 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65722afae805f5748de134b5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig+kselftest/gcc-10/lab-broonie/kself=
test-seccomp-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig+kselftest/gcc-10/lab-broonie/kself=
test-seccomp-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65722afae805=
f5748de134b6
        new failure (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/657225f8d67a8e37f8e13482

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-seccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/657225f8d67a=
8e37f8e13483
        failing since 64 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

