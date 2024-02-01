Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F71DC4828D
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 22:20:34 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.9118.1706826033378703980
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 01 Feb 2024 14:20:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=bc8TaB89;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d9607f2b3aso1384355ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 01 Feb 2024 14:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706826032; x=1707430832; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dVSEcJN7JXegdJj4LN7KxPEe7iQr6npUnawiqSOX5c0=;
        b=bc8TaB89Azv6Yv6sAD3BS4/kTPIAgixkk4yY+AG8fXNSPXAb+szhbHXvkiRZKlYapP
         yS6TEq+Z56K2tYLEd7CgjrF57NSYka4xNg8pxuIpq4bO+DEkly85wOntzgWArit/mxQM
         tad+3ZpVpOWhQ1vhaIO9lYTE9TctIDnFlIyaIjy/nkQ6rtEorzoVjEsy4GYDGNcWeA5M
         PXYd5UmTg5txPbqSYIopAn9zlwALJVx9Pg2Zuzu8DEg5BnCUb+RZB8CnzTmLeCdmYpuX
         Iziv7MlUGIi13TOj5qE2BQuTDhYJ77NJAFEnosds7iZVFONsnwgov0EmxH04ySqtvxaQ
         A/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706826032; x=1707430832;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dVSEcJN7JXegdJj4LN7KxPEe7iQr6npUnawiqSOX5c0=;
        b=tROXZsoj3bDOrW5Cjz55Fh6E1V7nOm9xN5/ninvGEU8slPaSQjoFp48ciJSxr96vjG
         NFUB5rmLwElVK/Kg60NCrpubL6ZI7QiZhbRenHr//qF/jTNNb9/SNVjHWHRnpXs0UeUV
         46OJbHlAIFC7ZFUxyxgHvafpxaD4fRatb7aN8FG5aEdXjMz6yQkvGBFRnJ4uVWwXyHF8
         2uYU4RKefxKy7cIAYwFlh7MUsdMz/dA2cT/xe/g/1tIPPaP6LIYCRmFO5PNYlsz4h3Of
         +mvW4d+VueIbrg67mISbp2wSAfjKw70IQZs74LXV/qlHpLQSZ695wGUqpM9mSQ/AFsOH
         Qshw==
X-Gm-Message-State: AOJu0YyjqGFKnWTsHyvw/Z4KP7cndRLmIC4rzIPJF8S9xpzhZteFyh2+
	VNV9q37oB8flYrc75A5kQr28BVDn6IQo+TSrJ1rU7PreLUB5e/M6Xac2YJlw69y8eZliyMd/NvE
	2
X-Google-Smtp-Source: AGHT+IEjzMDNU83a3S8B2ULGyJgTvgpm6R3dAhX3jXVUv6LvudUw+rGWxCjAu60vX/csBxczOfpSLg==
X-Received: by 2002:a17:902:ceca:b0:1d7:1ef4:1512 with SMTP id d10-20020a170902ceca00b001d71ef41512mr561546plg.20.1706826032251;
        Thu, 01 Feb 2024 14:20:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXORaBqEUBrSPqqVst5oEa9ByizEl4QqyupLT4fNYndUzInhnQI+LFxfVxeDs/qCXXXNfLPQmWsHwzgvxOdOMjBUCRgpx0/QHPu5hbRL8BhUzoEd9D0OhkWuK4TmRLshSsxzBTwQVPfjlU01RjkLhuE1A==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c20c00b001d91e985247sm296111pll.201.2024.02.01.14.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 14:20:31 -0800 (PST)
Message-ID: <65bc192f.170a0220.3406a.219f@mx.google.com>
Date: Thu, 01 Feb 2024 14:20:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.208-cip43-4-g1c63c70fb18b8
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 2 runs,
 1 regressions (v5.10.208-cip43-4-g1c63c70fb18b8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Feb 2024 22:20:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14590

cip/linux-5.10.y-cip kselftest-lkdtm: 2 runs, 1 regressions (v5.10.208-cip4=
3-4-g1c63c70fb18b8)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.208-cip43-4-g1c63c70fb18b8/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
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


  Details:     https://kernelci.org/test/plan/id/65bc0cb161a5115d0500a149

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-=
lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-=
lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65bc0cb161a511=
5d0500a14a
        failing since 120 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =20

