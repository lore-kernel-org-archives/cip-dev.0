Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839DFC77B75
	for <webhook@archiver.kernel.org>; Tue, 16 May 2023 21:11:55 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web11.34142.1684271511795342865
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 May 2023 14:11:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=VUZcMghB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6439b410679so9761936b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 16 May 2023 14:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684271510; x=1686863510;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MWQt+WfQc/P0bRVto2gDNZofeNPM3Jy+P4zsFgwfTms=;
        b=VUZcMghBMc6Vb2/is+wGHqo1tIWtFe8xDsrvQbQNZfZapSIF5HBuy5CrxRu0h+5Zar
         8fzOOTPxC4GLzX+VN3f1wzBBy0BuOD4MJV7keU7uzI3iMzDk/eA8NsIBI5Ba1TAwnhf9
         3kjSItE8eQ/unu94dHNYjXwvP8fr1MHaJnAaO2+/yrMYpOIAd/ZtSSTFjeLA3BKz4Z8M
         WrvMaoDfJEKLoICxu7L25GuCimjK2Vgk3BVK0/ZsnRCo9SnQ4mSrKYOv2QCunBBCLIzO
         lzOxMFwEkLpyWRR6sZ8nRxqTM1FftrdICsyuRntajeeTa52cqGMdmbQEzloBiyDNy31c
         htjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684271510; x=1686863510;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWQt+WfQc/P0bRVto2gDNZofeNPM3Jy+P4zsFgwfTms=;
        b=Wk+2ayfmZ+pKg+5CORJNUzVz7T3oA1l3ss3j6ElCsh3Pvl8z0vwGW87Gl1VaQdF15K
         wU8zBTxOPmx+2Hib98JacBz1E2INcriWoCQqWYEwNwy/rWZ61Dp/oVfWFeQCJjoR9ZI7
         t7gr7A1bzXCZSdrfnj/hcAQ5ACOZiRZHL7uKNvdYNGt7dkDbE2CMKCVDXxLCIbHhcukT
         5n6CzbqWApFJUKjd1qp5TwDFHVfVN4398ujSAFnRplaehFCdrlqlJz60pVSveJgeI2mE
         tUzvy3vU++gygnHcSmwxBauQF1rFuYxiTcwCVJ0QrtdqSyZzCXrUkTFIoL9Hqm6Bu1oT
         Xhvg==
X-Gm-Message-State: AC+VfDzHDpc6g4pAK33Ok0SquIbnwQboGwXoEoqqcuchEep9qQqYVPdU
	dzlGt+lhVnvh8f/0CRaRH306oBFVXDHOovI1yfh4Iw==
X-Google-Smtp-Source: ACHHUZ7KSRFOieEPO7DmfcsInTtD3luKmcK7ABFIKtOWErPjq5VwSRkKEWrMAAlRM26LU3NTp8qQmw==
X-Received: by 2002:a05:6a00:2285:b0:64a:5cde:3a7d with SMTP id f5-20020a056a00228500b0064a5cde3a7dmr25927841pfe.27.1684271510086;
        Tue, 16 May 2023 14:11:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d9-20020aa78149000000b005a8173829d5sm13849996pfn.66.2023.05.16.14.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 14:11:45 -0700 (PDT)
Message-ID: <6463f191.a70a0220.9bfb9.ca7f@mx.google.com>
Date: Tue, 16 May 2023 14:11:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.179-cip32-4-gd8c029e4780f
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip smc: 6 runs,
 2 regressions (v5.10.179-cip32-4-gd8c029e4780f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 May 2023 21:11:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11481

cip/linux-5.10.y-cip smc: 6 runs, 2 regressions (v5.10.179-cip32-4-gd8c029e=
4780f)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.179-cip32-4-gd8c029e4780f/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.179-cip32-4-gd8c029e4780f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d8c029e4780f8e18a07a1a17c1a9de1e01f3adae =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6463e6f9e1fb52ca392e8616

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.179=
-cip32-4-gd8c029e4780f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/6463e6f9e1fb52ca39=
2e8622
        failing since 316 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-05-16T20:26:27.306596  <8>[   13.481768] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/6463e6f9e1fb52ca39=
2e8623
        failing since 316 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-05-16T20:26:27.292999  <8>[   13.468182] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

