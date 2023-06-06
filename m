Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8EDC7EE2C
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 11:26:40 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web11.6441.1686050795455216405
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Jun 2023 04:26:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=yCwZYzI2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.54, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-25692ff86cdso4888623a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Jun 2023 04:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686050793; x=1688642793;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0BCjUhXZv5XSdJBMHoA91crFGn4g2Tvaxfgw8a6aZgI=;
        b=yCwZYzI26JQIbIqtYwD2gRm+cE5B2eoxXCuBtiDNZFnE9jv94zgcZhhfhieIUDTfcg
         4L4nrQ80zNu2ghRfNTkRE/v5O2Mcw8CPqNgLTT72rxO5HK+Gs+xAbgEWlxbxMqaqR1sd
         3AzHHlqPbBOSnS/txGvDY6zGDCz+dh2r6UY1d8HR2PMQyGx8/QC2xhS3M2oUE3CWKDms
         uBTHPXb0fL5TtdIioXi7kBOKiLs7eZpDDCQF29cWWQpUjbmGiUt2fKzA6KAx0IYS3py8
         H+izizXhaYPVHJimeMM5JfpaV/JRPPVq4lrjhg9iBIcRHTVsbEhOIEcyy1T/uL7eh7Qf
         5imw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686050793; x=1688642793;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0BCjUhXZv5XSdJBMHoA91crFGn4g2Tvaxfgw8a6aZgI=;
        b=C//wzw4eBbJgSoCI60/UZoYj1CWDEVkb1z5cXhUPpPQN5zyT6mDmr0RICo3pngSkTk
         0YIZpOjDGvQOOKt3glvIkezU10pFeSRyghf0wJEqeftvNqeAmizJSzcUqPuh186a3x5j
         rc1RrOJnfqw5LKHcHbE61agrYXMTzATUxhSX+wCrbgGflLXqaLIqcVXh6Qgn7OEtvveZ
         k3lhdO/ewkY2Gms5GdOL7EFHmGz/ddh10pSfUdrozmclJDGbdZ887CgfTrVLmQ/fKY1S
         KLQJd2/zDLMV2QpfPySnr1X1kd/nQa+fOE+4Ncmloxf6CsW89r/ba4nxleOcVrZJJ9kd
         zjoA==
X-Gm-Message-State: AC+VfDwAa/8R9cUWO0ZfBTgbyReB6fPejD6m0kioR5L//XLQJtmrUwAh
	UN2o5GFx1/wEpt1WouHBgBFaN05vNY7UZQVoPWT1hQ==
X-Google-Smtp-Source: ACHHUZ6sScOrpNrXSbSNXcdZ4VZyh7+KWsqtH1W6pi9gwuVLtylw+NqDHFMVpHwdfFmnmqbR0XIXoQ==
X-Received: by 2002:a17:90a:4d:b0:255:b07a:3d55 with SMTP id 13-20020a17090a004d00b00255b07a3d55mr1849282pjb.28.1686050793533;
        Tue, 06 Jun 2023 04:26:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id fw8-20020a17090b128800b002565a84c848sm9302524pjb.43.2023.06.06.04.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 04:26:32 -0700 (PDT)
Message-ID: <647f17e8.170a0220.41548.0ee9@mx.google.com>
Date: Tue, 06 Jun 2023 04:26:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-26-g462b2292d23e6
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip smc: 4 runs,
 2 regressions (v5.10.180-cip34-26-g462b2292d23e6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 11:26:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11873

cip/linux-5.10.y-cip smc: 4 runs, 2 regressions (v5.10.180-cip34-26-g462b22=
92d23e6)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip34-26-g462b2292d23e6/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip34-26-g462b2292d23e6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      462b2292d23e6b1dc941676861a2951dd3a98d13 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/647f03febf27a049b5f5df31

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-26-g462b2292d23e6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/647f03febf27a049b5=
f5df3d
        failing since 337 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-06-06T10:01:12.813222  <8>[   16.920368] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/647f03febf27a049b5=
f5df3e
        failing since 337 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-06-06T10:01:12.799102  <8>[   16.906656] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

