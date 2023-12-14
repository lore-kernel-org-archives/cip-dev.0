Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64310C4167D
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 13:50:38 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web11.22456.1702561837385469316
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Dec 2023 05:50:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=YkD+QKU4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d266bfcd10so202787b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 14 Dec 2023 05:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702561836; x=1703166636; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q08XSeMZaIuN7wGHTfzPVL7OG8/AOGotHU/iJSptqm4=;
        b=YkD+QKU4+D5mQaHtfFhuaM1Mh+XGsu6WA5Z4Vas36b3lGWj6WAGs6SLd57Jg/sxYH3
         a7RwXUSTZ+2Jnohro8uvvG0tnxOiARXTO3b7YxueESyhBeqoQHxwLPFQaH5fNxPQgbGD
         2oDAX9yrvoRzsOJzZwaf83rQbsriYm+/GrPwC2g3G1TxnCsgwHmy1b3mMwVFwqX4Z2Gb
         wRCcHBqNEeyszPhD4SBYCOz2Gcn9WMMhKDf0Ir5q3y6C1nAy7xVPmvCzmiZ1bnwzHSca
         CR4NsGjDPSp+xxUU8fSgtD1zgcjk6h2Ya28UXsf+iXUFS2g/cPE1s8C8mfcuakY8hzVc
         wTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561836; x=1703166636;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q08XSeMZaIuN7wGHTfzPVL7OG8/AOGotHU/iJSptqm4=;
        b=ouKcAASYFQMeE2X4jdjrFt0Q0IIi6/hW5baZ4N/kQmp8lRydBJ78z9rSt+c8XFOMvG
         MvYCTaBE/noEfzuTkcAeAWfBjRPxoEjD7h4VUnwc6iTsSk5wGCSpblR1rlfYCt/HnTFL
         rpcuajPoT5LRxAIyjx0I7koY0oAxaofknBbJ4L0uGH4f8gmxBCi/11JTYDQwaIDmKrnw
         5TJJkh/3LD3wr+WAFpTQh702PniVQnIwJtDn5wo/OtlHibTDZm2yoTcDmD/o6pWxxGUS
         zWyWFeVBoEFxvEKAxs8Zd4GxQF2bMcd4q6JEgKJbrqrEbHroYc9uKlXrRIF2KmjBIMZE
         JhCg==
X-Gm-Message-State: AOJu0YzWhf1Rqg6Of2CQn5DBOZdgdB0tnMh0hKFGUDLhARVMC0MqBmn8
	IbyAEMP5B8yGB+bPsBuZljiBsKLSmNPA5CLomdepPA==
X-Google-Smtp-Source: AGHT+IFZKSBiH2Wjq9xCeTy7UleIIuwdmx8A2OiJEdkjRrPF6RJifE1+x9no72BCsyVMqmWukESVoQ==
X-Received: by 2002:a62:ee19:0:b0:6ce:7748:575d with SMTP id e25-20020a62ee19000000b006ce7748575dmr3856452pfi.61.1702561836129;
        Thu, 14 Dec 2023 05:50:36 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x3-20020a056a000bc300b006cea17d08ebsm11790515pfu.120.2023.12.14.05.50.34
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:50:35 -0800 (PST)
Message-ID: <657b082b.050a0220.666bb.4a72@mx.google.com>
Date: Thu, 14 Dec 2023 05:50:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-69-g8f7b450fc28ed
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 7 runs,
 1 regressions (v5.10.201-cip41-69-g8f7b450fc28ed)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 13:50:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14102

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 7 runs, 1 regre=
ssions (v5.10.201-cip41-69-g8f7b450fc28ed)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-69-g8f7b450fc28ed/plan/kselftes=
t-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-69-g8f7b450fc28ed
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      8f7b450fc28ed99196853536c98ae36c2567e160 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657afba2bc67035e41e13498

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-c=
ip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-c=
ip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/657afba2bc6703=
5e41e13499
        failing since 41 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

