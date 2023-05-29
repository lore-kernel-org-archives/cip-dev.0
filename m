Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AACC7EE2F
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 00:57:10 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web10.40526.1685321822333206013
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 28 May 2023 17:57:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=xQvIMbbu;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-256766a1c43so346121a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 28 May 2023 17:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685321821; x=1687913821;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dfwxH/zfecwd9QW0GQ76mmR5RLGjrriEuRZFMW3UnLs=;
        b=xQvIMbbu6FK95pXkmBrjdBSTUBgNTQ7jtGSv8HnPrzsEogUuxaA730H3IRWL7mQE9B
         Idsmh1JKyRcRoIepXDCOgHKNsrJApqLw+JCJ6bcOql+CELPWtTBKH83Ffewe8okE3xVD
         B0VIO18/o9hbB0B+LifeKU/biBQixityCnUUTaLRvXU3hAEEFak9Udugldu+ChNYds7A
         SePtpimepc2AP6xZk3/NCm8mFGIdjXBqRlFWv1LvldvJXLHCBtrlLhF4qN32yJ+iAef7
         dsWrrN9odLMqFqZMW6TPc/bwVPbrkgbTKpQGZ+GQhMGi3+Tyzp+MAADD8n3cXtuzolbJ
         uzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685321821; x=1687913821;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dfwxH/zfecwd9QW0GQ76mmR5RLGjrriEuRZFMW3UnLs=;
        b=OIT2+oy6L5aFO4Cg59dL8WPfbehJ6SYq3oT6P1rcpzaUSBcJYbMhYNWKpFxWcDwn+e
         lUix4mhNNSZHFwwjE40FaDbHiBHtKqmeKp94QS8Zs6lQfgMHLMBHOkXjok8mRCeS3qTD
         lkVSisVV+yVqYnkO/5LLs+KjwTOS2fPULci4wihRH4iq63SIi40UFqy9VAr74jx43VmF
         1csOl2HcQ121Bqe1/9moYqPZ1OuVOCgfPGGVrOyDKj4/LlvGUFWH07CQD/isIAvr54bx
         MboabUIZY0IATCOGDDNT8ytv/alxxzVSx25l3HAuHi5IZCAvghG2B5uGpkWqilmyM+C8
         YtwQ==
X-Gm-Message-State: AC+VfDxww7pBlLV+B5pwBOY+d4O0iWrmYGPDooAGq7nC0OAxKGVajfkL
	0O4z+7rEmxKiuCDanPcCR9FQiAMrH8fVfp+LYEQ7tA==
X-Google-Smtp-Source: ACHHUZ59HdPlqSVYNMkryM1Mnd2BIOWkyRbzSUnxJ8kFU0Oyh72SomvowPzOCkl9pg78nJP4HwGjrA==
X-Received: by 2002:a17:902:db0a:b0:1ab:28ec:bf10 with SMTP id m10-20020a170902db0a00b001ab28ecbf10mr10884394plx.51.1685321821345;
        Sun, 28 May 2023 17:57:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m10-20020a1709026bca00b001add2ba4459sm6770065plt.32.2023.05.28.17.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 17:56:59 -0700 (PDT)
Message-ID: <6473f85b.170a0220.fa898.ce0a@mx.google.com>
Date: Sun, 28 May 2023 17:56:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip33-21-g8eb0cdf459a2
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip smc: 6 runs,
 2 regressions (v5.10.180-cip33-21-g8eb0cdf459a2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 May 2023 00:57:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11679

cip/linux-5.10.y-cip smc: 6 runs, 2 regressions (v5.10.180-cip33-21-g8eb0cd=
f459a2)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip33-21-g8eb0cdf459a2/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip33-21-g8eb0cdf459a2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8eb0cdf459a2bb2971bbf3eecc4f894d2717cff9 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6473e777450a8f3a2b2e85e9

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-21-g8eb0cdf459a2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/6473e777450a8f3a2b=
2e85f5
        failing since 328 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-05-28T23:44:35.759073  <8>[   14.671432] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/6473e777450a8f3a2b=
2e85f6
        failing since 328 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-05-28T23:44:35.745799  <8>[   14.657762] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

