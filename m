Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D32C7EE26
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 15:14:49 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web10.29043.1684509283119010885
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 19 May 2023 08:14:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=IzZLkOUN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ae52ce3205so23408965ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 19 May 2023 08:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684509282; x=1687101282;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fDo5b7aRaqK03OcgAVge2UqsBd8uERH22arpw1G4esE=;
        b=IzZLkOUNrVX2/FiIjyxZ9qW33ULFoLzibPJ80ZFfmlDyLjYXpDgA+sxB3gTNtiF1bg
         B/7JWqH4Hz52QtTG6Jr0C3lwHuEbYnMHzBJ9PNZgIAGSP8F8jGSPZ/+L421MHLX+7WDN
         NOMVohj8z6GqcNEwYZHKCNtMTy3JE9A9zYSzTrxExHCfC4NrZ3NojzoPcTwRRtT9kyO2
         CCHp7t5gfNemDSVmWYuOT1Uvypq8dqYYw0EgWxXzRX4wGcBaOyXh0e7KLI2BsBGddYnU
         3LVBzfcTC9ORwcUB9Vk9FCyQX/01sg9UfKqboSuxgyqZIPT2ko2GeK/tLJoMoYZT9vRx
         RICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684509282; x=1687101282;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDo5b7aRaqK03OcgAVge2UqsBd8uERH22arpw1G4esE=;
        b=FuE3imyX7j9EDw6M2PKBUyIUpg4W+9p8YmJCZFUMMserocpwtcREC+86xBOBx/TI/h
         zVViGr97y4/tJkixXnmihnbsZ9Ew1JVSXkwRa9m1lsR9M4ZW7f8UJD3bfFHoLwLZF8Qf
         Lso2OHBjlNs2B/+pik1GqE9Tu/jsPRW6iNWJS/Kskbykqxz0uvKmnOG4VcIQOSZDeTds
         jUV2Y+boNCX02VMgUvw+9hzrf6Soty+FI6ig1MEtv0lKRqp/obBFxvwk+QMVHaE38w1M
         SmCDpjnO1askB6KXrafHECN7GRmW657hkeIfPnB002k3hn6MXMGF9Q27dNPu6mt8kY9w
         pHRw==
X-Gm-Message-State: AC+VfDwdo3tQP7qoCXGkQTh7UWSYhz+9enFsPw3u3SMsEgsu6m2NAvaX
	EX+AzoNlCfZvheSeH9uXcnDJaNXyVXSfw7suMZf7jw==
X-Google-Smtp-Source: ACHHUZ6cGErT71muEmDjOBH6CyUu5eCbR5R2Lo/RwQneJR2s0P4MqF1TSxDxvz9Jx3V9vZyp6+3HgA==
X-Received: by 2002:a17:902:bf06:b0:1ae:2e0f:1cf6 with SMTP id bi6-20020a170902bf0600b001ae2e0f1cf6mr3120242plb.36.1684509282145;
        Fri, 19 May 2023 08:14:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v23-20020a17090331d700b001ac7af57fd4sm3591228ple.86.2023.05.19.08.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 08:14:40 -0700 (PDT)
Message-ID: <64679260.170a0220.5a499.6372@mx.google.com>
Date: Fri, 19 May 2023 08:14:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.283-cip98
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip smc: 6 runs, 2 regressions (v4.19.283-cip98)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 15:14:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11570

cip/linux-4.19.y-cip smc: 6 runs, 2 regressions (v4.19.283-cip98)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.283-cip98/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.283-cip98
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      31603fc59adb456f6eb0f58de8bb989b41572c2a =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64678bb4bb175a8c262e85f3

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.283=
-cip98/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.283=
-cip98/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/64678bb4bb175a8c26=
2e85ff
        failing since 314 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-05-19T14:46:05.185241  <8>[   11.667355] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/64678bb4bb175a8c26=
2e8600
        failing since 314 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-05-19T14:46:05.175272  <8>[   11.657417] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

