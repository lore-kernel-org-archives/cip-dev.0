Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8587FC64ED8
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 11:31:39 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web10.15505.1677238291181915433
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Feb 2023 03:31:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=CmhFgCTz;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id z20so2370090pfa.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Feb 2023 03:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=61WRyaOO9emyqKA7ZHgAHmw8s9i8ukH3sV+0Fhzke8g=;
        b=CmhFgCTzBoXYl/tkTteglk4YEBQ1wDoW5sYs5yYyoyGhA8yWXL0qfYNWWQrBZeXSoU
         fKPcED99pMxhL4NrvOqyF6o4haj6LJmucGc+0sl4brner+zqTpjWjM3mimTWCU9hWpyO
         8RI9ZlPaJfspy4NexHg3oyebu7vfL6PyERshIcnyBwGEHF/NGS9rgXvNH+OM1gqoSJBo
         6oVJI2J3RQds981H1PcI1eoUU2WvIq01nYRUbvLQCcrpoNjBgJDv989wRmCPSRxK+KFS
         An3mP0PWW4zZ6Hq1PP0Ynlw+8j0Ojstr8LihuVUhrVkVptjru/LFqENeLsf9rb4OHqO/
         RtGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=61WRyaOO9emyqKA7ZHgAHmw8s9i8ukH3sV+0Fhzke8g=;
        b=x8BFjQWxqcuA29mzoNcEDI9vIscMDbFMcJaw2M1mxeu3BHQC2GIEbtS94uJJ49p0Lc
         dDKQo9Ers3FUdmyzxcPGUrDg7XHxGwP+K4Xmqdx8l4PELMdimE1iqf5n6+nDXnCgrYjb
         zDCQL6DNS/2AmDuO8aYu01EoGE0kDe9/FMj6gbnbS+q/Su9vyIQOwoLCrRwUS/560Dtb
         3YtkS/OJONdw+DyhN9aSmD0g4jbyKQCOh8MJ0QlyY+96ApYlFXBYoUZBK5w9tc4PR0JN
         Hr3qoj5TvQiA4s8sBd6LgTHHt/wcerQLo59TkhHG2zRG70D4EcDVcabO4GAJsXpWs8PG
         0Uuw==
X-Gm-Message-State: AO0yUKWCkaIg9Xt2dKEgfKrOJB3VDoW4zzGFKvO9usgr/x0glbYbqDei
	iphEdYwSjeFSfJJ0uXUbbZnUGZPMLIHCN58PLBEmTA==
X-Google-Smtp-Source: AK7set+KVr9UuGunFhhhrE5pAOxu3On+BOF59+OCkWd/eSgeWrc8ayT+wRT9pzCf6buyJW5CtYzUWg==
X-Received: by 2002:a62:7b42:0:b0:5a8:cc65:5766 with SMTP id w63-20020a627b42000000b005a8cc655766mr12039852pfc.6.1677238290476;
        Fri, 24 Feb 2023 03:31:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p5-20020aa78605000000b005afda1496c6sm2902927pfn.31.2023.02.24.03.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 03:31:30 -0800 (PST)
Message-ID: <63f8a012.a70a0220.3976c.4e86@mx.google.com>
Date: Fri, 24 Feb 2023 03:31:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.168-cip27
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip smc: 4 runs, 2 regressions (v5.10.168-cip27)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Feb 2023 11:31:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10813

cip/linux-5.10.y-cip smc: 4 runs, 2 regressions (v5.10.168-cip27)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.168-cip27/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.168-cip27
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      cc82f737b68c179240070fa34771bcfd0a5fa421 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63f88d4766dd86f5488c862f

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/63f88d4766dd86f548=
8c863b
        failing since 235 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-02-24T10:11:00.479448  <8>[   13.003048] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/63f88d4766dd86f548=
8c863c
        failing since 235 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-02-24T10:11:00.465652  <8>[   12.989321] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

