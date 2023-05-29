Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E7EC7EE2F
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 08:06:42 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.45069.1685347601958380235
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 29 May 2023 01:06:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=QDXIGryG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1b011cffef2so26881875ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 29 May 2023 01:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685347601; x=1687939601;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BUEZ8IONSuWPK6ZvD6JmGKSLzF0PjY8TFgOO+1RKDGs=;
        b=QDXIGryG9KMA2Rw1faT9qEKYCFJYlnoKVo0x/HqfM5pRLmlJ0N8b7h9dNgYz0GoObJ
         72bi92ImJDthIwUnv1VMNJss/TsepwzZy8hJMH7boyhEs3Q3gFaFGlS8/1t7oGtt2gej
         UrKqYk8DadiBHkBc64LqDXO1RwidCg5FUibQpblaMDGfW9qip22WNmLlLxBd6zhKCfil
         VWTkkwLOMawPthAZN/SGuruS0yApfFXYx8TgqfNEtPxJMqvVsHJusv9HftWn3l2hwMn7
         ds5EL2i7O/umz2OHHhdcNwJ+5T8QsHC6+jKq1Vf+pBGfi6qQ5LXsf2T8OiO0CAZBXOW1
         KDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685347601; x=1687939601;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BUEZ8IONSuWPK6ZvD6JmGKSLzF0PjY8TFgOO+1RKDGs=;
        b=Sqwz+Seit0bOXe5OIBIDp09J8eW5xnvP8n36UEM8ZCP08Tj2UIGyjE4lLNMAi1VHdl
         0eGxhHXUr9a41nKjsHDwxSpEMQxqQX0Q9NDdAdafqD3cKdntOT/vIjYknv3hoFHigbcR
         vuC5aEGHPjiD1moHGPSt37XG9Ogcl5uhgJ75GMtv07VhuEkiuC4jqXbnQaEKjTc5NCso
         wQ/DGmN1VoTP67rkOzMeKnM1bVvAI/ixRM8LzQi1H8zrKFtxHMMAC5/bOJ0n9t0ClRAb
         izIN2acw0QxiVzprxMSWoOxTUUTm2/ovU6kf6WJTSxNOHBeb1gsUM48wPSN0Iok4mz7c
         LIVQ==
X-Gm-Message-State: AC+VfDyg152iaeU1+2L2JYcuVfpL7j/aRwR1czaf/TtrolRQVClPrxJn
	4Ow/ksvh6IMegW8/+D9tnvW4OphSrwXp1xg9dtuKlA==
X-Google-Smtp-Source: ACHHUZ4+qdVansZdyU0BYJEaOb5Be6favow3orgxR5MmEZt+gbK8defZ4QPfKwPyUSsPaidw4rhnIg==
X-Received: by 2002:a17:902:d50c:b0:1b0:4b65:79e8 with SMTP id b12-20020a170902d50c00b001b04b6579e8mr539621plg.44.1685347601015;
        Mon, 29 May 2023 01:06:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b14-20020a170903228e00b001a285269b70sm7537848plh.280.2023.05.29.01.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 01:06:40 -0700 (PDT)
Message-ID: <64745d10.170a0220.a55e8.e6cd@mx.google.com>
Date: Mon, 29 May 2023 01:06:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip34
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip smc: 6 runs, 2 regressions (v5.10.180-cip34)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 May 2023 08:06:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11693

cip/linux-5.10.y-cip smc: 6 runs, 2 regressions (v5.10.180-cip34)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip34/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip34
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      aa80091745d6b40c944d419c12ba8cb65b1a57a5 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64744db85371ac21442e8603

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/64744db85371ac2144=
2e860f
        failing since 328 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-05-29T07:00:52.524886  <8>[   17.174325] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/64744db85371ac2144=
2e8610
        failing since 328 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-05-29T07:00:52.511446  <8>[   17.160792] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

