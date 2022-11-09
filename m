Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA7AC4321E
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 22:37:27 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web08.314.1668033442226494332
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 09 Nov 2022 14:37:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=p8coRx+U;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso91741pjc.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 09 Nov 2022 14:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GqM1dbze5jxIWvaUKI3SxXN0DhWWYDPGiNNWu3Q44Vw=;
        b=p8coRx+UIdIPMiP0n6KqIB5RZTphpOi7iWTqqFldBkN5teDnQAmBFtgpbBUWqNLERT
         26ca/hPOaIL3vdH+R/OiZhlKi17zYp6F1Qp3vyFx2b4Gu0c3t9VIqw7DTpAKVZkVIILv
         Joscr96hmF8xZmOyYCxIF733JEiL16K64QiUUFe7qU2MNH+LXiGKbcfzKMuuE2Kbfzr+
         eY9TJ17Y0igyLeOYSHOxVwq3G7MZO7wGOkVneAUhkeCMOZ1wQZpJhCjMzMAO796Fu4+7
         onjqmnhmx5kpg5xStEyRXD/5/f8B/KlK/sQ3R4uIl9FyVuwngTCnDXBaumnmOKHm+/HB
         fRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqM1dbze5jxIWvaUKI3SxXN0DhWWYDPGiNNWu3Q44Vw=;
        b=5rpU/zf825PjsG7TgfS1q9+0jB2L/utzhec39cg27yiUSXpvvsgXXSOokw3yLg1K3T
         A9NIBjBzCHQ4GbAOh3ZWzLuXrV2ghUF2mPUD4Tk75yZZIQMrdcWsE9QXI1c4U7VQVO8f
         ZL1Vbnaphn99YnXTUs55GQt8YIrQQ/c9pAIjWaHaqh/ZhcP6zlC8jQnK/lKJvcRrwdJp
         W7BcaXILN25xmrGHXyr7lGnKwDyYSnlSuBJY3iu5jhBa+8N86R17DYvbuSw0pSLWFTqT
         +xJxsoxSeiDIii6ZWu4DGn67ttHMh+h6zBEuOs2YW1G6rkulGSkjRKWF/C2UvVD5KzJ2
         VV+g==
X-Gm-Message-State: ACrzQf2d6Ql5LgkeqGGEgiyzELy4nC/BdpGaT67u2DyWC5PnMT6fL8Cg
	ITNPIrGCNY1A7ib7/ccScBCqRWjfF8F9rvvj9EQ=
X-Google-Smtp-Source: AMsMyM5O3NH5rxkjXCVApiGf24CuYnPSt1z5nsDSIY2hxDcvsrSJRpJBuB830A9UO7eL+GmV8BjN0A==
X-Received: by 2002:a17:902:c643:b0:186:9efc:67a1 with SMTP id s3-20020a170902c64300b001869efc67a1mr62373138pls.30.1668033441581;
        Wed, 09 Nov 2022 14:37:21 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id nd2-20020a17090b4cc200b00212e5fe09d7sm1734824pjb.10.2022.11.09.14.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:37:21 -0800 (PST)
Message-ID: <636c2ba1.170a0220.3df5b.318d@mx.google.com>
Date: Wed, 09 Nov 2022 14:37:21 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19-3-gc76f4e7e5c71
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip smc: 5 runs,
 2 regressions (v5.10.153-cip19-3-gc76f4e7e5c71)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 22:37:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9982

cip/linux-5.10.y-cip smc: 5 runs, 2 regressions (v5.10.153-cip19-3-gc76f4e7=
e5c71)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.153-cip19-3-gc76f4e7e5c71/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.153-cip19-3-gc76f4e7e5c71
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c76f4e7e5c7160107c9b5d8ec188f61fe326cec3 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/636c18d93242936448e7db8f

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19-3-gc76f4e7e5c71/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19-3-gc76f4e7e5c71/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/636c18d93242936448=
e7db9b
        failing since 128 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2022-11-09T21:17:04.107986  <8>[   13.134142] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/636c18d93242936448=
e7db9c
        failing since 128 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2022-11-09T21:17:04.090129  <8>[   13.116037] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =20

