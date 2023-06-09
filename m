Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CE0C7EE2E
	for <webhook@archiver.kernel.org>; Fri,  9 Jun 2023 16:27:19 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.17850.1686328035674770195
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Jun 2023 09:27:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=2IrmQeW/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-650c8cb68aeso1692641b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Jun 2023 09:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686328034; x=1688920034;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/dZI8cHTLDUwUCEOukK+qbLwrreP/3f8KR+phYYFzgk=;
        b=2IrmQeW/EV4B8YJ6BlUjBTfvQsc9vJcd8EuEF5l1NtalxrO1+UB6pFsDcLZQBEPF4m
         dePVTAtJ8MXtH2TyBgMJ2A7RsucaJCcCJklMXQHxEHaKNvh9EtGjH7D1bhMVJcFQ55nC
         0PsObCWp0IeaycLJHicBBhf+ramUCeX2CSeJUnG4euUm3MdHIQ1XeHjPQUs3MN6Us7qT
         kIMpSpIFIaCC9QNkDxlYp6R6RHwDcCfKjDtsGu5aTvWNpCu4l70HEXvkfHr7s3T6aVlC
         Zgd5M8/Ss3UaTOcoVmw7lHf0Se4yiOlM444wPDCzqITZyfRkFOtGFisO/4/qslW5ruFU
         LKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686328034; x=1688920034;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/dZI8cHTLDUwUCEOukK+qbLwrreP/3f8KR+phYYFzgk=;
        b=BmZKEPWK6j/ag2RyiYrCRdt6C7Bk60gD98upuFabR8wCMjfg4n6gisgGiC+82bVphf
         kbvw/QvNEWtI7DHTbNK1cPQYnRGdTtJDYzNFoONw7i/GIvyUKPNjb/vAeY811ZRIjK5P
         M9iCdqLl89F2eTlDMEd5UaWJ06Tn5pI1ejQRo7XME+zqRWZiv8AwxUa6jE9brHJpVFnJ
         AL3Y8oJD2eFlM7NjVIn5FLDZktTxDSa+L9mBy4BmK9LYL1ecBI/ukIFhxjEOSExVK3gO
         PD2fYWRw8fPG7dujvpQsJTmVxPuZGkGgNoTS4Oz4pnun4NYAclt/P8ZZ7EOH3VWLZ7zJ
         Iyqg==
X-Gm-Message-State: AC+VfDzKtNcrK1ceQ9rSPAQ3oehwGBnaCD/w7j11NJOuzKJwVLeUCceI
	VyXZ2mcWw3zqVYJ1CykxgMl7Jbd1INntZeG+lLMgBA==
X-Google-Smtp-Source: ACHHUZ51SKI5IRyYVtMGcDD9ETtH2S7d72npxgPOjKzyYkBywa0RDin4g/xn4iztU7AIrKlIR/LvoQ==
X-Received: by 2002:a05:6a20:1584:b0:101:4348:3e4e with SMTP id h4-20020a056a20158400b0010143483e4emr1559012pzj.42.1686328034666;
        Fri, 09 Jun 2023 09:27:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 128-20020a630686000000b00502ecc282e2sm3175261pgg.5.2023.06.09.09.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:27:13 -0700 (PDT)
Message-ID: <648352e1.630a0220.bfa5a.6879@mx.google.com>
Date: Fri, 09 Jun 2023 09:27:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35
Subject: cip/linux-5.10.y-cip smc: 3 runs, 2 regressions (v5.10.182-cip35)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jun 2023 16:27:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11950

cip/linux-5.10.y-cip smc: 3 runs, 2 regressions (v5.10.182-cip35)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.182-cip35/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.182-cip35
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      52f00829380df13d144d530b732464a175350508 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6483474e7841b2821c3061bc

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/6483474e7841b2821c=
3061c8
        failing since 340 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-06-09T15:37:59.964351  <8>[   13.080956] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/6483474e7841b2821c=
3061c9
        failing since 340 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-06-09T15:37:59.950378  <8>[   13.067282] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

