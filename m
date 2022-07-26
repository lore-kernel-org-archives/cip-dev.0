Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD93CCA48A
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 01:32:50 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web11.1610.1658799161790747460
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Jul 2022 18:32:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=jANxXAdq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id
 t3-20020a17090a3b4300b001f21eb7e8b0so15343206pjf.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Jul 2022 18:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=berYeowVUnw9Sdlr71NVB4IyTNovwHRTz2X0KqZ8vkY=;
        b=jANxXAdqq/SDj1c02SrU/1GjAPAKbvG6CXQlJE7enYFRcErQHpsoxtdoCdpF85L7wJ
         Y615U86X7umcx++Cgqidquqs+wMhT8OXCz4Lm1h9B6Wyiz8ZyzviMmAMXUFNTMsgFE7f
         btYOhS2PQbg7GwjBzHU98TzUsO4ekKzLsAWg0136rjDMs0UPRRfz8oKFgm1wytT/TahH
         S2PS8xTOF/Tl9eDdg7UJILKRbN+SnQ8n+JFYDRDvFKZEFuWvEHyn8PBSW7ZnJnwP0abI
         bMWWJGjf4KttVF6s1Z5jUOPrEkL1xYX8eWUWqfZaKZJha07DyO4UCP99XqIfd7lKpM70
         ny5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=berYeowVUnw9Sdlr71NVB4IyTNovwHRTz2X0KqZ8vkY=;
        b=dqyQGtnZnpgDNzQaLp6fV5fayhIazrSQ9pcEc1Q4Hi+HOosGXQHTuv087yoPkTEJjS
         3YKc/ai37V/nCVy8gYU5DC1qSrgrhPxAAt3dSAp/H04vDDZz/L1K7ex4XBe04GB+xn9P
         7TGb7kXvN5bVtHYoWPlYZJw+PIeGyDmSYiZWC9PdmMliOCIjj0haDfHDoJbcnlh6RJWr
         zpQjybmfTEn/QzB4Olb7x5soXlUTr/fFLG6etoxz8iziyMLuv3dCP4QV3uob6o/QSXC5
         biZGF+uscMi+034R2xtO3YJdXyCpzzGPH0moaDOGlOa/mgIkWu4nQu0banGLh5rTcuz1
         jslA==
X-Gm-Message-State: AJIora8UqRINwARJfQnX4c24xWWZF7ZXcq1Kq8BPfPJJBc2eMrMTjlA5
	iQNKX2dvjRVgncL7tErRej4qwjj7XZSN4RYb
X-Google-Smtp-Source: 
 AGRyM1vf00U7jiAQn4GdBa6JlctREJGkcyimJBG+kECGj2eVsnoAJjQMS2INbXPSpHE0EWtW2+Xyaw==
X-Received: by 2002:a17:902:e5c6:b0:16d:9d4a:249d with SMTP id
 u6-20020a170902e5c600b0016d9d4a249dmr936423plf.118.1658799160804;
        Mon, 25 Jul 2022 18:32:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 d10-20020a170902654a00b0016a7b9558f7sm9895939pln.136.2022.07.25.18.32.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 18:32:40 -0700 (PDT)
Message-ID: <62df4438.1c69fb81.d0686.ffa3@mx.google.com>
Date: Mon, 25 Jul 2022 18:32:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-36-g21d9d56f4de5a
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 8 runs,
 1 regressions (v5.10.129-cip12-36-g21d9d56f4de5a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 01:32:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8915

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 8 runs, 1 regressions (=
v5.10.129-cip12-36-g21d9d56f4de5a)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.129-cip12-36-g21d9d56f4de5a/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.129-cip12-36-g21d9d56f4de5a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      21d9d56f4de5acd415b12aecf82f754e9e6065fb

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  bda92ad659a52d38ac810099f69adff626b064c6 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/62df3626524b7fca18daf0e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.129-cip12-36-g21d9d56f4de5a/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl=
-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.129-cip12-36-g21d9d56f4de5a/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl=
-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/62df362652=
4b7fca18daf0e8
        new failure (last pass: v5.10.112-cip6) =

 =20

