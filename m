Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56385C38142
	for <webhook@archiver.kernel.org>; Sat, 21 Jan 2023 20:12:58 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.5070.1674331970819747681
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 21 Jan 2023 12:12:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=uobAYbPc;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9so8115209pll.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 21 Jan 2023 12:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rdxMyb5bmulY3uGtC/Bapls9PmrIDi57EVJ4jwFCvbE=;
        b=uobAYbPcIgu6iihki7f7fJGAGxF1CmE9YCW121NX9b8l4IAkvWOd/taTcNFsKnr6Te
         oH6lno+x6YCls+xudgc7rrvkjX+mrNx+iUtTjndzN+CUTXVe2yR6VSW7GnZC+SclYvNS
         s0HqLgdgfSJW8K4Zv0Z6H1MhlqsVyzlgpI8SvWEpmzguWPlTld1IoD4WCWZeDiksye1m
         w40GiAu/MllsZ73U5o1dIjxbM9pCplx03kwh0L/ti8txWYMf+7rX5vI4Kn/bmSXGy1ed
         l6GWIzd9P7acKBUkdMceWwjFbahTekRAB2SLurFasUhchYTdWod3lRudJc6AGAKTHKp3
         ZHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rdxMyb5bmulY3uGtC/Bapls9PmrIDi57EVJ4jwFCvbE=;
        b=mOqNelfOX58B6dgsDW2dRdgUssOh4fD6m/rTiaUbjISkj8GYbGybOzFqaVakHJnNUv
         D7t4XtG4H6XwixEXKQEFRN+tGo9Nwqfj5Xf5m5p8akbYq5BlrFJBGcBUw6pigqOeUgDj
         d1X/ypEqDal4oFq1RwJ/faW41hR4FalZ/EO/q1Evs8jnRVo18KyyflzV/qBpH5NAgHxM
         i0n3eD1xKGMo7IQL0zewiwQLYIFVB1gpFxgyrNV2lUKzFw+rygcgS8d0xUvlLEGLO4et
         CFC1foQC+K0PcclbA1PYk13AYwXRji3pHqrOlFwdEXHxFUgT5WDn3gz0U+REqjZ6HdEa
         G2WQ==
X-Gm-Message-State: AFqh2kpceH9ycw9Sd0ym4Zm29hMBnjr6AMnE27d0sugskoq2ur1mKLOK
	H+yfxPqlR2KfrAeYBHbFhY3IleRqQ4MwYFru/Cg=
X-Google-Smtp-Source: AMrXdXsgJB9Gjdo9KW46fVNtbRca1HNo3B5VxSmkYQ22VW+C1BYroDGCbqvH09WQgS2K+71nepGVLg==
X-Received: by 2002:a17:90a:5a0f:b0:229:a0f4:fad2 with SMTP id b15-20020a17090a5a0f00b00229a0f4fad2mr19738903pjd.15.1674331970203;
        Sat, 21 Jan 2023 12:12:50 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u30-20020a17090a51a100b0022badab0dbasm3619395pjh.3.2023.01.21.12.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 12:12:49 -0800 (PST)
Message-ID: <63cc4741.170a0220.56be4.546d@mx.google.com>
Date: Sat, 21 Jan 2023 12:12:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.270-cip89
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip smc: 4 runs, 2 regressions (v4.19.270-cip89)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 21 Jan 2023 20:12:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10457

cip/linux-4.19.y-cip smc: 4 runs, 2 regressions (v4.19.270-cip89)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.270-cip89/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.270-cip89
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8cbf38242b91f4f98d6fc776bae10cc74740eff2 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63cc377a4b0293f8f8915ec7

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.270=
-cip89/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.270=
-cip89/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/63cc377a4b0293f8f8=
915ed3
        failing since 196 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-01-21T19:05:24.759724  <8>[   11.588312] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/63cc377a4b0293f8f8=
915ed4
        failing since 196 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-01-21T19:05:24.749782  <8>[   11.578203] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =20

