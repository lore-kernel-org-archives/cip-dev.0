Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE9CC4708D
	for <webhook@archiver.kernel.org>; Sat, 10 Dec 2022 02:19:39 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web10.6171.1670638771041740981
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Dec 2022 18:19:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=8IebPejg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so10016599pjj.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Dec 2022 18:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vTC1jCdKF+N6VelJwaKABOxWwmLOjZXZGp+eokCmxZQ=;
        b=8IebPejgk9vD6PfiC+c+i+7+f5Ie0j5s5CEZW5npbDRJNA1n91AUXYy+VonR7h4wB6
         rEFLgy6x76rN4He/2+ymRtrjtginYYcAS78N8gur918/CrH+Nj6kNQoaHFy78S5qddfv
         ltCzd3/5EWHIFI9T+pY3ApAzuD6F3hMiy6fzvDUnJoTrBtDW6nry1bXl3lW84JZZLTb2
         rxZ0/dtqBRlkjaewKbY9pQfCiXQABDTXS9pClTpT1/iZL1Pko80viYEpkYrGm85+Yt/H
         74rplt36QX1jxPcoQuceuA0POtrMQPlVQnlpoqm8+eypSUXmA6vHmEk+udFunGpeBHyv
         lTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTC1jCdKF+N6VelJwaKABOxWwmLOjZXZGp+eokCmxZQ=;
        b=cSsza1gXhTi50oMbIbGKA6kViSxDuq/8trVeAIPLXxBCmfP+NHyqbxOf8HQjWlhvyy
         Zcjbhd1pf7Hpwfv2U3ds8m7kXkoLJ+57Mc+7z3QtQjOFWiliRYybRnVb16vDqqgUhEJ3
         2uHDF2Eqm/2vMbJWKa1K0UeGaUWFKFZloKhqrXXneGxs7xeBcwNFPnOanzLjGqBTEHUH
         NKvY52I+QK/X9ReZ3EA5rcC/rDcgXApgQARRprSe6x4kNqvhF30MNkE0uzuMCuyES1W+
         W5icS67XPHh5S49hM6c6OnpD/rZ9un3a/DvJwT1KTvnAeeeEoxmuhFgTMdWyxSeRHMVo
         ukDw==
X-Gm-Message-State: ANoB5pmgGWQAahxkJ0i/qyy56gqq5Y/cVtymyQz59YW1LuMXqtLJbEGU
	niv8eVz+NLz4RIQQs8h82UNV5oZYFwqdcwFENOw=
X-Google-Smtp-Source: AA0mqf7XgOSFVydP1MAWOtlESx4cE8SBuvKTg/WOyA1Xaj9ciqdzVkEAlaSlFOgVcyHAY0rbTfVDFw==
X-Received: by 2002:a17:903:264b:b0:189:ec62:3b2d with SMTP id je11-20020a170903264b00b00189ec623b2dmr8270395plb.4.1670638770151;
        Fri, 09 Dec 2022 18:19:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902e80c00b00188ea79fae0sm1956293plg.48.2022.12.09.18.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 18:19:29 -0800 (PST)
Message-ID: <6393ecb1.170a0220.5d193.47d9@mx.google.com>
Date: Fri, 09 Dec 2022 18:19:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.158-cip22
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip ltp-fcntl-locktests: 6 runs,
 1 regressions (v5.10.158-cip22)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 10 Dec 2022 02:19:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10190

cip/linux-5.10.y-cip ltp-fcntl-locktests: 6 runs, 1 regressions (v5.10.158-=
cip22)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.158-cip22/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.158-cip22
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f37e570b7c4ab8bcfacf36780a9e204878f2c181

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  e76de05a93390f5ec7fae2941d8f24d367c9b2b8 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6393ebd95d2afeaf142abd13

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-fcntl-locktests-=
r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-fcntl-locktests-=
r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221202.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6393ebd95d=
2afeaf142abd14
        new failure (last pass: v5.10.154-cip20) =

 =20

