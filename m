Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759DCEE01E0
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 16:54:21 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web11.2113.1694624057642732711
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Sep 2023 09:54:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=DpPkQsWt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-68fac346f6aso3804380b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Sep 2023 09:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694624056; x=1695228856; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xK+JcP4jvxWgqQiF+RTn2/NL1NZ1IXPLchR5deCezEc=;
        b=DpPkQsWtQYT591EUJyZN0NF4gwhh6QfKUKx/C47WLOAjrx6I6re36z/O5UeKOm9EN7
         jGJ6rtppz9KqVK7PfvA9XIUvrqhi8QWznwXg5smUe7dwO6NIosfYf67OEHhKuRz9f4jE
         zPDu32G0g+pAHZM/ZycgsRttfangyo9IsJBTGIQVYvK+p5i8hJTdkWwOJya009W+d9lB
         bEvOEK2vdDYDRpgZS6qGll//jWz1fe9f7YJmaLm/zX+0FhnxVqvaAR8M2XT/7a1DbmeX
         TQrULWgDQBhfXyycQLwOQZExg+wLe0BMYBouN9g8y4BGZ+XVzxztjbcPnNEP+51Uxo0P
         NZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694624056; x=1695228856;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xK+JcP4jvxWgqQiF+RTn2/NL1NZ1IXPLchR5deCezEc=;
        b=I2QVl5RpDVTD2wjfw/SsEvfFYU5lofoH/tEqpqpVh+Az5zC00gCtPI1ibIRcuQcqK8
         s1wPQ68mbb6E13/B/6rmGSIg+Lhkln8eh092CJtKv43kZnylPd7Qsw2I9AnllsY7NkTq
         SAvvDwSj1mJJJzaa4n20VS6SxZMM9yo5cI02DLpaDSRfk15MMjC0W4+X+UZ8xgqS/I4G
         4o+X3jbWvDX7nv5Xkh35+nACUgF7khZVg2c1Vcwhw2ky8jQV6lcZf0BV0kEYUS495u6Z
         K70Fk0chyBfDMf7EvLDS5cE3Ji3OsH0x1tLAbU4l6IpdtXm7aX66xmv/KCbtHrT8+A7o
         mAKA==
X-Gm-Message-State: AOJu0Yz1IUdA42Bpg9sXsJ+cFZEcKu5nuenT2JsDsjjaCYAk7s5+C6ed
	T3BPxG1p/y52dMnR5q+JUK3y3pkhTwx5NXHKy94=
X-Google-Smtp-Source: AGHT+IHGyqwAQEikyFHbhk1FD7urHllH6jGHwqrhlOkrCzAF+4beyZgKDtuesQr4hQUEgq88ozCfZA==
X-Received: by 2002:a05:6a20:8425:b0:148:82d6:aa16 with SMTP id c37-20020a056a20842500b0014882d6aa16mr3575333pzd.25.1694624056591;
        Wed, 13 Sep 2023 09:54:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902d34d00b001bdeb6bdfbasm10740361plk.241.2023.09.13.09.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 09:54:15 -0700 (PDT)
Message-ID: <6501e937.170a0220.a55ff.eddf@mx.google.com>
Date: Wed, 13 Sep 2023 09:54:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.191-cip38-17-g8dad6b499cfe5
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip smc: 3 runs,
 2 regressions (v5.10.191-cip38-17-g8dad6b499cfe5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 16:54:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13112

cip/linux-5.10.y-cip smc: 3 runs, 2 regressions (v5.10.191-cip38-17-g8dad6b=
499cfe5)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.191-cip38-17-g8dad6b499cfe5/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.191-cip38-17-g8dad6b499cfe5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8dad6b499cfe588bb00bdbed4e46649fe88260b1 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6501de214785e1e3cd8a0a57

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/6501de214785e1e3cd=
8a0a63
        failing since 436 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-09-13T16:06:53.538237  <8>[   17.341446] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/6501de214785e1e3cd=
8a0a64
        failing since 436 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-09-13T16:06:53.524348  <8>[   17.327710] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

