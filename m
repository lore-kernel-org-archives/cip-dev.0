Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9FEC10F1E
	for <webhook@archiver.kernel.org>; Sat, 10 Dec 2022 02:19:39 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.6180.1670638772953285907
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Dec 2022 18:19:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=PdM8AezD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id o12so6610645pjo.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Dec 2022 18:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uvXdVfhguyjLNaDq9jrBxI7PXb6mEQQBUow5kKIvD/A=;
        b=PdM8AezD6fsRRgd/m4Y0FMNrxbjHpOrUK2iorMhNajxegfRnqOfPfFKccXbvpeQJuu
         s7zKaiT0IlW31RphlSeIaDM8NHm8CKEwIDYS3jXDHzaVZ345iMW2HZ97rqmOPfeSbsud
         FgQh15fV/Iy7FjRUUaKfMR5xnD8dKbD5YA6au9+Os843JqpoVf9QRdJdfdeRVeodWJHd
         qbj3v+AitvfUyTZXQTP5IzLr5DCiZ8bCgGOd1eGeyEcbm6zu1Gl3WcALFEikgd69J0fw
         Q7kOt3aZBkabTqR6ZlR21GzpMcCJia1A8UMU6UEh0akUogpEvmtexXDwm0LfeVdbTZI3
         FkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvXdVfhguyjLNaDq9jrBxI7PXb6mEQQBUow5kKIvD/A=;
        b=M0IdWIAiBCee1X7+ksNDYywU7PKEvoBbHMNplFNWxstSMsZr4ZlEZ8RaSsekz9vCtn
         zTO4oO3aFQDJ/BDNP5lE2rgH//UgL/7eF1olkX7VQP1hiLrfKxW0s6t80xTwRRE/5Kiq
         260jlZoqghQEyKsGre5wzoHeA5v+BIn6teFUXqs8+HoatJzZZ/CrZ24lZ9DpbA3vsfGc
         fsaFHnR4OhTH5k2mYBVUWtDriMZfMA19egouEPzLED+xAN6vubATa5vyRGOcG5OJ6kPi
         5eqwvWVKC7hlLSiWkHQKfdqFEy5K7JgLd4vvMtc0BLhWpboPI87BmWjZ+EgmUxq+kEKQ
         cAvw==
X-Gm-Message-State: ANoB5pk1cG3+WMDL02bFLBeFdzU0o8H6fMVA8+fda3Pd3BZW4nG6fUEX
	FaOPayqjppSP3mXcdqKmToOpsmrUx3S1g+jN1Y4=
X-Google-Smtp-Source: AA0mqf7oL3Jbb5TyduG9ujobq17Kb59QZC39nH9YY01/ClRi3qGi7N22AbryEuj/1STrsAkp0ZhmQA==
X-Received: by 2002:a17:90a:c38e:b0:219:6c57:c3ea with SMTP id h14-20020a17090ac38e00b002196c57c3eamr8161132pjt.12.1670638772097;
        Fri, 09 Dec 2022 18:19:32 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s13-20020a17090a764d00b00218c5bdb983sm1641620pjl.22.2022.12.09.18.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 18:19:31 -0800 (PST)
Message-ID: <6393ecb3.170a0220.4951a.3d5c@mx.google.com>
Date: Fri, 09 Dec 2022 18:19:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.158-cip22
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip smc: 2 runs, 2 regressions (v5.10.158-cip22)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 10 Dec 2022 02:19:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10193

cip/linux-5.10.y-cip smc: 2 runs, 2 regressions (v5.10.158-cip22)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.158-cip22/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.158-cip22
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f37e570b7c4ab8bcfacf36780a9e204878f2c181 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6393df4ad7896d3d1a2abd24

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221125.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/6393df4ad7896d3d1a=
2abd30
        failing since 158 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2022-12-10T01:22:08.758375  <8>[   12.710311] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/6393df4ad7896d3d1a=
2abd31
        failing since 158 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2022-12-10T01:22:08.739803  <8>[   12.692065] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =20

