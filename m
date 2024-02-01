Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F32C48286
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 22:20:44 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web11.9120.1706826034530336054
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 01 Feb 2024 14:20:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=mv/VMmF9;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cedfc32250so1322341a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 01 Feb 2024 14:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706826033; x=1707430833; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LWU9Dlp0/G2YXw8sD8RT4VD5n/kZfVWVlbZvdrjDUvc=;
        b=mv/VMmF9fxolB+8aiZjuaZbz77N3c3zZOyLudhLW9sGSwMTdVdgdjJkGqAoTwVGMfh
         ZKItGwJd0iXoaDjx3gUznZolG+h6U7UEVOUDmF+l+pxUs/DRdrvK/NnTKoTDqkwSmIZC
         a63S9Mq+OM8077u8zm92BKmsrgPQsDRQmT2IhDTQ88IJPbnrSMMkgNRaEkI81RqeMYMp
         SMOwCAu2AQZyP9wbIB+xQD1hbnRQPmEpm43h1qRRbXHegc5n5Z9qWdxjhbUeOY/68TlI
         /P9FlSfL8OO7crDCdUgJ5MgAGDW+AVkHXKmcxGGFvfTOfBU4hf1e3z3tHSyLrapGwoho
         AfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706826033; x=1707430833;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWU9Dlp0/G2YXw8sD8RT4VD5n/kZfVWVlbZvdrjDUvc=;
        b=vKtSCLq6mxJ7orZ9OZoEHPgIXsXsBJhb4TMZEPUFr5YXvU+2DwLtadpKxYxybjnGkE
         YnTJNtf/Y0jYYskBe9/Y38GYCCx0pS1jqVAGtfOrTDXp8qVZrcKb0tQEiytZdnAzUQoy
         1xltBjG8hO9w+iH838hr80aUf/E3Uh7DM3/nMAYFTH6ezWx8EhuaBl5X/KJPFn7kHo67
         HEbAspMWNFFishEloDZgu+ixES2OvkN46buMWpMaIFKC4xNahMDWOszCEMmHWiOO9l/l
         ep2rKasFLA/LvuqmCCV6bvP1p+Hgj4pdtg7UzGeUn+vahqKocXk381WS2JsRwRgn/M1K
         32+Q==
X-Gm-Message-State: AOJu0YwnpEAVKr+vDJ1PJlW5Im+SX1xptXctYOsk4cFj+OpcSfT3Qp+9
	Z7ldO+goZE0bj/hBi8Czn/nl05T2HRD9i2jRl9uIXcFDIT39dgm5CZD4lCCuFQLCgaxd4L7ChSt
	Q
X-Google-Smtp-Source: AGHT+IHaSnzjf6KrUFgjgyUUzKaSXfgI+VS4Mth4wA6bMHuS9xz8w0qKeY6HNTzaZgyTUIThW+8REQ==
X-Received: by 2002:a05:6a20:f398:b0:19c:9a26:b958 with SMTP id qr24-20020a056a20f39800b0019c9a26b958mr243072pzb.35.1706826032816;
        Thu, 01 Feb 2024 14:20:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUwNwZ9OPpibE8tCxcvRZEIHJHWWGFOV3jRsIUoc/fG8LrLQqr+lWebkabLd9aZE5YDokMTLfq1Z5T01vwHenGl0Jm8QqXyYT+Dib7ux1rhuUXOyRrmVpf1rv8ibP4MQehU5wAIyU+b0PEY58ECI0xmHQ==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w20-20020a17090aea1400b00295f2cb67d1sm3545060pjy.16.2024.02.01.14.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 14:20:31 -0800 (PST)
Message-ID: <65bc192f.170a0220.c26de.e2b5@mx.google.com>
Date: Thu, 01 Feb 2024 14:20:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.208-cip43-4-g1c63c70fb18b8
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-lib: 3 runs,
 1 regressions (v5.10.208-cip43-4-g1c63c70fb18b8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Feb 2024 22:20:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14592

cip/linux-5.10.y-cip kselftest-lib: 3 runs, 1 regressions (v5.10.208-cip43-=
4-g1c63c70fb18b8)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.208-cip43-4-g1c63c70fb18b8/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.208-cip43-4-g1c63c70fb18b8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1c63c70fb18b87b5bcfe5d7ddf0096c92a1557ed =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0b88991ce2436100a07f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-=
lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-=
lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65bc0b88991ce243=
6100a080
        failing since 120 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =20

