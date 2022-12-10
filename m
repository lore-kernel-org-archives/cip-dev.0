Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25449C4332F
	for <webhook@archiver.kernel.org>; Sat, 10 Dec 2022 02:13:39 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web10.6051.1670638409720934673
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Dec 2022 18:13:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=qEtMV4Si;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so6781218pjj.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Dec 2022 18:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L5KTonvz5ZeIjYQHHwYOD5eXyi4TEpxgeC0mhOovaUk=;
        b=qEtMV4SiKRL4naOAyR8j8yITMYQpujZ+6hKXvDiMhILaP1QxPKkxwIk0TMJk9OAv3n
         NigARlzmoSIJjg7DC0EeCrjU+MMdlTGj0iC3cyg7aNonVKeC4PUwcbiex/D02kAhom5k
         1pgJK3xKBIZnwMExu12U6Aj5hvM7t4vus/VQ0ntmfV0NI9ItMIDv66ADr62/WnDhsNEW
         +kJon6/PNR63Da90pGt/9PH02eJxRq19GoxAfdSovP6YvM8pDCT54moHj2SDb73oih38
         1R+bvo2CAiAHIPTinmpMIsjM9Q4Kmd1Cr3jm7kvStYoFqyL5qON/5ag3LbEd30Qkb8gt
         jMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L5KTonvz5ZeIjYQHHwYOD5eXyi4TEpxgeC0mhOovaUk=;
        b=IjZo6duFTCmQSZjt99Q5XU9M5WqWpmNOephuO5cnwMt33yA377uOy1es3X2hsV0l6Q
         vgKu0BcGRm/S4lsw7fvmilDRDx1Dw2cPuycxe6z0adlE2TBeQ3xA3AVxjD9UPxqF0yqO
         jqA3SgWgBprzQrPYJbX2AW/fFIc8ojXrML/EehX+RqPkB9tvhwT35KfQnBoO/UqmkgkL
         GAgjQ1rZlSNWMAYVwjXDShPTHTcEiMjrI7B/sCEdZe8mZR0Lj+KwwhhPELhDzgR68Uyi
         9F2sPzteAkGRv3ABcemE3zK4YanNZm7Stv1+DiAIfNc/faB79smKQzzSX9UynO1F0a7L
         QLWw==
X-Gm-Message-State: ANoB5pnimyOTtCTu2lEEklZdGaYfZF1wX5hyIYcb23g6JGxIMsZ9QkRx
	d4+LP4BLZWottSIl+YVBS8MzeD4ywrLYjfY7P1U=
X-Google-Smtp-Source: AA0mqf5d0RT2i3qqGYyZdvOQZC+m9DN96+1IhbGRTUeb8b7vpxi9gYMi+UnZdWjXIcS66C8hQDxf6w==
X-Received: by 2002:a17:902:e0d2:b0:189:6591:f6d0 with SMTP id e18-20020a170902e0d200b001896591f6d0mr7005510pla.10.1670638408906;
        Fri, 09 Dec 2022 18:13:28 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902654900b00176b63535adsm1906554pln.260.2022.12.09.18.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 18:13:28 -0800 (PST)
Message-ID: <6393eb48.170a0220.ca27e.4a57@mx.google.com>
Date: Fri, 09 Dec 2022 18:13:28 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.268-cip87
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip smc: 5 runs, 2 regressions (v4.19.268-cip87)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 10 Dec 2022 02:13:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10186

cip/linux-4.19.y-cip smc: 5 runs, 2 regressions (v4.19.268-cip87)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.268-cip87/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.268-cip87
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      268e570d0a5691ceb479fa0368a6c73c5b080f89 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6393dbe6fc9135d67a2abe27

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.268=
-cip87/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.268=
-cip87/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221125.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/6393dbe6fc9135d67a=
2abe33
        failing since 154 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2022-12-10T01:07:36.834132  <8>[   11.085394] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/6393dbe6fc9135d67a=
2abe34
        failing since 154 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2022-12-10T01:07:36.823248  <8>[   11.074536] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =20

