Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC904C46CA3
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 16:15:49 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.26655.1702570544840162385
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Dec 2023 08:15:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=PSsks9JA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d32c5ce32eso6237555ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 14 Dec 2023 08:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702570543; x=1703175343; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lxMoCBuKQzsXee8fbZJmiyq3cLIfvekMY1Uy1vVJmGs=;
        b=PSsks9JAG6OACcx2+xQN0JGkznMwEfDfPw2YQpzGQ7OU4GdDyBpJr/xFQYZ+h2S2U+
         pvlyTAY6yf7BQfDRkH/xWcccLxVATn8i0hBRTH1hdWOL3NjKqHSM/93JCikn/WYMmojA
         kCC04PGpAdyTNnwpAzRo/4+AHrZ+/B8gQHYUeQWELsUdBDQ1NF0CbO0wBNt7mnORaDxS
         wKvGDaNY0zk9nA9jiwydAH4NwYT0ldeD/NMcR+g94fon2PaVCuoUklO0ekCCS+DSSGpO
         ktO3xKI5xJl0WhVRAH7KhVly4ailLeGJbX0M8zbCzO3mczJqRUdChjdUfUTW0muCfi7I
         Oo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570543; x=1703175343;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxMoCBuKQzsXee8fbZJmiyq3cLIfvekMY1Uy1vVJmGs=;
        b=SXsbe1plKVk6qxCVazXht1KwwyQDMelDScU7No8bwi+NsuS2Aq9i6Y7EUQZlomLQ2P
         JM8Klum6WmPG7QXNhvXXkjQneTQQiDtKXWTsDiWmWncclWp+p18ORPg+DyxZJR+Iq+DZ
         03uXcv3qlX1dOQeKqFygBEfG0ChDHdysIMsq3PYO/zd2Qe5BjpSfveG6DxaIAhP0Kyom
         zx56RvZ0li1O46kAwmZJAOUMh7msdGqujzfug8jvGXmBmDL/AOcq3ht7c9GFEQ1Hw2vO
         OMbwx9cDUN6VeC0CWkHZjBMekgaszdOlOXuPT6tnXA8JlHsw/3QdTGtgkU/HJIaKxLrz
         lksg==
X-Gm-Message-State: AOJu0Yzc8PmZgSunaTjgCFCpKEvcmXU0YCPoU1qGmzVDrzks/UJNRaHf
	K9XDTNsojQCjXlURQt+G3AoZyMw7KJZmVDjd8Do=
X-Google-Smtp-Source: AGHT+IF/G78zTxf02SMNOMtZ8b1FrqcdTAbyn9KHHn875drO/4BnsZfS9Qtxd91uY8mNwt+WCjyTag==
X-Received: by 2002:a17:902:fa8c:b0:1d3:798b:9d99 with SMTP id lc12-20020a170902fa8c00b001d3798b9d99mr378380plb.16.1702570543715;
        Thu, 14 Dec 2023 08:15:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id li5-20020a17090b48c500b0028b2262e0cdsm138285pjb.56.2023.12.14.08.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:15:41 -0800 (PST)
Message-ID: <657b2a2d.170a0220.47792.0e1e@mx.google.com>
Date: Thu, 14 Dec 2023 08:15:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-69-g8f7b450fc28ed
Subject: cip/linux-5.10.y-cip ltp-pty: 8 runs,
 1 regressions (v5.10.201-cip41-69-g8f7b450fc28ed)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 16:15:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14117

cip/linux-5.10.y-cip ltp-pty: 8 runs, 1 regressions (v5.10.201-cip41-69-g8f=
7b450fc28ed)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-69-g8f7b450fc28ed/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-69-g8f7b450fc28ed
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8f7b450fc28ed99196853536c98ae36c2567e160

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657b1e020c180bba99e134bb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hi=
hope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hi=
hope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/657b1e020c180bba99e134=
bc
        failing since 34 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.200-cip40) =

 =20

