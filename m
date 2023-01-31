Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D353C636D3
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 14:11:34 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web11.13212.1675174290054792011
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 31 Jan 2023 06:11:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=uZxPXhmP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.170, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f170.google.com with SMTP id r18so10116368pgr.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 31 Jan 2023 06:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j62ALxbAYDaGgrz+iLFOgvxsmOrDTerXQ3V1UOVEynE=;
        b=uZxPXhmPJ4lhI34sAS4K0DrQw+P41tOU447iA5ogyn2QOh2f78W9ZcY37LibKKjjTV
         DQhYYwUUFWglI/zgicAX+bGtfZZhT+i2dFUib+bsO1u+522PHPKWS05x99h3hQWY99Sd
         VhJ6gYG8MZI4Ptg26Q/130gKw80kOQO2dMaCoqg00LEQCMXmvcezUn/mlWUWyEasHIL/
         yJl9Cm0c4rVFALW03lmeuZeCqVFDXYOLFkhmtCDpNRKu5lsYrKUQStGgOcjDLusk6jZL
         wV0jsCDfoPyb2ta9hBDtidT4Qo2vwETGwkGBnbW0fjX7oa9tWZ1SSwbERN2yw9ou+GUk
         ueBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j62ALxbAYDaGgrz+iLFOgvxsmOrDTerXQ3V1UOVEynE=;
        b=ZJCYiL2Q/c62+1xmZ//py9ay6nRBXihubHVc59/oYhsCqP6FI4lMTkycj6MZ/pTnB4
         +vDqbrV+7kK3XQrB822Ga3c2I8HT2WAg7QMXsrpqmM++dR+vfMNBDCKDyo6Yq+iq7xSA
         LeTBxwLXGl3q9RgqRvsMBsSSsb3AFs0KpfCw8e+pkr6mWygWv7W85uEhE5+Jnp96r75s
         3/pmFbx8XsrkU0y/JSW57pwXJ38oKi9tVbbRkPiVoXhlQVTVEnj//shvVAQQPKfCeT6o
         VeLs4kY4l16V+eezPeE1cCWW+o28iLrCjOCciCmzUkI63+Pa4UZ1XqgXs+AQ8q5nXDtW
         Dbsw==
X-Gm-Message-State: AO0yUKVrWzW5IekeZ8O9ZVi3z7nBIC9v714OdVB9Pc4c3tV2IPHGNVfM
	fsC0VsFoHeuOhymihmmE76iJSXpHMe7Hw/Ka+Zn2rQ==
X-Google-Smtp-Source: AK7set+qZCGIdzJD3KrR013PhASP+QzX4ntQCvRaiM92Ejcu2KFnMW/YX45CpJMYcX0oOP1cwuW4iQ==
X-Received: by 2002:a05:6a00:a04:b0:593:3c37:fa75 with SMTP id p4-20020a056a000a0400b005933c37fa75mr20764558pfh.1.1675174289132;
        Tue, 31 Jan 2023 06:11:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z20-20020aa79f94000000b0058b9c9def36sm9592406pfr.139.2023.01.31.06.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 06:11:28 -0800 (PST)
Message-ID: <63d92190.a70a0220.ebf6d.0262@mx.google.com>
Date: Tue, 31 Jan 2023 06:11:28 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.165-cip25
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip smc: 5 runs, 2 regressions (v5.10.165-cip25)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 14:11:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10544

cip/linux-5.10.y-cip smc: 5 runs, 2 regressions (v5.10.165-cip25)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.165-cip25/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.165-cip25
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      52aae1dc6afe62fedb14c89fd4feca1d8bb13416 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63d90fbf870bc55039915eda

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/63d90fbf870bc55039=
915ee6
        failing since 211 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-01-31T12:55:22.310312  <8>[   12.802757] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/63d90fbf870bc55039=
915ee7
        failing since 211 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-01-31T12:55:22.296725  <8>[   12.789200] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =20

