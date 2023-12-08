Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAE3C46CC6
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 17:49:15 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web11.42457.1702057747636995100
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Dec 2023 09:49:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=1tfieGbD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d0897e99e0so18308075ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 08 Dec 2023 09:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702057746; x=1702662546; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7cGIeYKu9dtou7oa4kQNSgUD3DZG80osDD0m2rQgpUM=;
        b=1tfieGbDsa9h2ZogFlU8TKvgc4DpGgejtP+YVGs3XBgLvsayJmpQ5NCz6E2SbDxmHF
         WcXzl5AtOBSKmnl6sgnpzpvSS/LkmRCB3CWW/625dIWqSHvMAnKy7c7zYIRAVbdPTuqB
         eb6Jp9Diai/sSdNYb2bkc7I5fI5QPaWJ7IPBh6I7+TBDaskiyQc1U5uqZTgtP8ifz+9o
         iR+MQNANnkCmoVP1laFwepsb544+XMPeQKURjKMPiEanT/1czmwOZx+ay91XmshFgKGG
         iiMlbKV8zi/DAkiYkQTbXyI+EGIfOoACaRNmTZOE9kzTaL9NeNRRsG5dvu55ZFVfRcAq
         Lw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057746; x=1702662546;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7cGIeYKu9dtou7oa4kQNSgUD3DZG80osDD0m2rQgpUM=;
        b=AJT5vEp/qbdFM9LYDFDjcB54dj/OBh5BiSW6BY84S0sLAOQ9HE8wAqppQ3E+SjCUgf
         NyTkXOk4qaMEdMmaKce75OLF8tS0VYPKqCxgo27GgE0vJASQ7syVpYuT7ohWD/Csxqin
         A50Y8J9muBjcjoKGGnpCswEixeL8tNz0QZ+1xOpvBT5haPTAhPEKsgni+CS4NbIVxgfM
         89j5opdbMUwIq0qo+Wsozmyd4sm44KwQ37/rk68Tq/1pHOT3wmi4IFB7uWHcDDr4Z92p
         e9npEcB4UoqS4IXV+I2wCpdK2BGVqH5lDuO0QFXigWryJa0xlI3uxWOhTNfNj4I3Xwim
         W0Pg==
X-Gm-Message-State: AOJu0YyySwYJ/XdVBEiDgKKwYU26ANzSbStAFYlPJw5isiAgfdzzhb4X
	/Ik+O/QR+m8XBcYBA9G9tXXLN0MXwhWm5PeVCBi1CQ==
X-Google-Smtp-Source: AGHT+IEfNWHC+zw/kOAERvsIGqK/7xf8CGUEbcDb1KiV1OsGv4YKtmKdt+Zn9JxWMP6DKEimHnOYaw==
X-Received: by 2002:a17:903:41c3:b0:1d0:45bb:aa08 with SMTP id u3-20020a17090341c300b001d045bbaa08mr345290ple.7.1702057746583;
        Fri, 08 Dec 2023 09:49:06 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x16-20020a170902ec9000b001cfa0c04553sm1978282plg.116.2023.12.08.09.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:49:04 -0800 (PST)
Message-ID: <65735710.170a0220.16bca.6c99@mx.google.com>
Date: Fri, 08 Dec 2023 09:49:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-46-g596f4c151d286
Subject: cip/linux-5.10.y-cip kselftest-lib: 2 runs,
 1 regressions (v5.10.201-cip41-46-g596f4c151d286)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 17:49:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13983

cip/linux-5.10.y-cip kselftest-lib: 2 runs, 1 regressions (v5.10.201-cip41-=
46-g596f4c151d286)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-46-g596f4c151d286/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-46-g596f4c151d286
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      596f4c151d286c71a3612a2120ab33f4ac885d2e =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65734a371bfbb7b076e134cd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65734a371bfbb7b0=
76e134ce
        failing since 65 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

