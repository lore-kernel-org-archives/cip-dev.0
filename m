Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E346DC4332F
	for <webhook@archiver.kernel.org>; Sun, 13 Nov 2022 09:19:12 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.1131.1668331152544036265
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 13 Nov 2022 01:19:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=MF633tIY;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so11277633pjc.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 13 Nov 2022 01:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t+0QST6dKhnD/aDXJ4L4ZAwaGtsq8OyhSKph+PefdSo=;
        b=MF633tIYerEjJnS1LVdQG66RzvM2j3pbIAA5v9MBKQBz1x5l1rIqFyeNk3zzzK34Pc
         Dp/kDknhJD25ZbsWxqJd7HevWMHT3qyUPRhJACzrE3bFFUZgnhXNS4etVeGT4w4+cvgC
         eotgqkhkCgOxVV1H/vpM5jooAYRZ3/ajCp//Y1glerGdCN1oLVmniGGWkaFy+t0W2oX9
         DEJ9U+enTZ2NcoWhQDAe2LzJXUnxT1tb/s0d534jY5oaFePCExHi1EwH+VxvhHexHNz2
         31uqeo4xyi08rACCSzDbcdqr79rWKhvLul70jPAtQd9FM/KSqQAoV1ymn9cEvPoURquq
         ugCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+0QST6dKhnD/aDXJ4L4ZAwaGtsq8OyhSKph+PefdSo=;
        b=FGnekTrCNnPGue0J9XUy0b7Oqo7/rT2QS5witc6B08xLY8dFWGTx2z1xScxRLZWS5/
         Rp2mekcblqm1XCvbaf4uklezLGKvYraIaWkHY3Mvw4Xy1pMklkO3ZDD0oFPmO9YXWR2o
         vIXakFDcud+HH9d4TIsGjFuhz26KicNHCJaFrC2bRKY48Of/5mSmwNV0wgU/mdLHbunk
         5qH2eBQ6LwKTwN8KIcYfD4NF6n5hP6DdTfgzTklZq9b0jTS0UwrCHhaqBclQ99vGn/yJ
         T9ni0oEj1psjOlJSNIdGXAOGHPTNunwcOy5FpTImB7JjrhdpMM4sCGrhs+2a7L7wZEFl
         XEpw==
X-Gm-Message-State: ANoB5plHwBQxaOkZ0Nb8euiwvmNoN16q8dDJ7Yqrpf9JdaloI5IH1KFs
	ucYTQA3gQoQGctXKGW1JanKLVmUYjpkUvMXJ3Gg=
X-Google-Smtp-Source: AA0mqf7f6XKHl8MWg08UqgOZSQ08jnbWNPGBMexFVe2TIgbGdMy16rSTOAVqUT2IMcbm8emP3pg54w==
X-Received: by 2002:a17:903:328c:b0:186:9c2b:3a39 with SMTP id jh12-20020a170903328c00b001869c2b3a39mr9578674plb.115.1668331151848;
        Sun, 13 Nov 2022 01:19:11 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n13-20020a170902e54d00b0017f73dc1549sm4821007plf.263.2022.11.13.01.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 01:19:11 -0800 (PST)
Message-ID: <6370b68f.170a0220.fb78e.712b@mx.google.com>
Date: Sun, 13 Nov 2022 01:19:11 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.154-cip20
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip smc: 9 runs, 2 regressions (v5.10.154-cip20)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 13 Nov 2022 09:19:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10032

cip/linux-5.10.y-cip smc: 9 runs, 2 regressions (v5.10.154-cip20)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.154-cip20/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.154-cip20
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      efa0ded8f5c8a9e3835e4aea63caa6cffb0ccda8 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6370a358bb9e678a3fe7db7a

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.154=
-cip20/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.154=
-cip20/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/6370a358bb9e678a3f=
e7db86
        failing since 132 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2022-11-13T07:57:07.292840  <8>[   13.169095] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/6370a358bb9e678a3f=
e7db87
        failing since 132 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2022-11-13T07:57:07.274487  <8>[   13.150883] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =20

