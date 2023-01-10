Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B348C46467
	for <webhook@archiver.kernel.org>; Tue, 10 Jan 2023 08:26:54 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web11.99304.1673339213920983719
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 10 Jan 2023 00:26:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=bxk6I6pH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id b9-20020a17090a7ac900b00226ef160dcaso10847452pjl.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 10 Jan 2023 00:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E/9HNNIPejQXAwBT0iE0I0eMVvggIvb3cZTXqc+ny34=;
        b=bxk6I6pHcjpdzJjUm4caLe2YPrz9/yAXzH33F/FnQ+XY5qRBwdwMRKp98MPeJzDF8A
         koFk8Rdpv5k6zmFEqTvyK5FivYBpuL+XGXpQYSntMJEIhJQ+/5tLpK/RJYfI2v9cPEaW
         xXn1d/UhcK7B14JY/NwkabgokLhcaLA3ulp6Doy2/RMxCoBg6m4gLBQtzlqiyJaeJeWG
         pxfp9+1moBfSOtB4xaaJAFDeOMMYK9METi+pru3gmWVDTUyWZoAFfvZ24xaqYhVcj1CP
         msZQ36jCVAad/OXxDg3HB/xrKtF56XLCaMH8MvqnGhUVO609S0HK1Rg7PJzNO7qcwAC+
         Yiaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/9HNNIPejQXAwBT0iE0I0eMVvggIvb3cZTXqc+ny34=;
        b=gV6qD3UF72LGOLd/vk+Ef8nIOPhdKYR284Yy/SUck+0eGURS87xE6VLSE65KJEIpxh
         KMoO5o4TqxwNDN+nZZUG6KI4erJsA6nHK73nBo3BGQINVI0M3BblfiWKWVUgxHzPtl8s
         m/jesZ4miZ/Ft+NBi2UzNKxDBqipEEFy5bCUDliJfv5ydJKQ2pXUbZcIedMYQNEjfsmY
         J3KoFLzUn0wUiZE8LCmCeE3DKi4EACZuUqkUzVIGy8zVZxYVm+ytfq69tRSE6YBw0c/3
         Yjz9WRxiqdcMjA4scv8HFLvrzxRMUbXMlu+12xnTAAtBUmnzRhEiJoYsPS36inbri7fH
         pQYw==
X-Gm-Message-State: AFqh2kptSOTWjZGU5WH4lmtCVQuM0pF2dDSOC9fcqZ5YYZhOkgFmuXlz
	War0/zXY4yoyUTQd0ALMBEZLQZkFHx05JyuB5B547A==
X-Google-Smtp-Source: AMrXdXs4/cniT4f84pm6Ai4wxdIKOlDTIgLlwjRmJUDkkpFpMi9b3zINNRnLTzx5IxdN1J+dqklXJA==
X-Received: by 2002:a17:903:2783:b0:193:2b86:bdc6 with SMTP id jw3-20020a170903278300b001932b86bdc6mr7098276plb.48.1673339213047;
        Tue, 10 Jan 2023 00:26:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p13-20020a170902780d00b00186c5e8a8d7sm7418931pll.171.2023.01.10.00.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 00:26:52 -0800 (PST)
Message-ID: <63bd214c.170a0220.f63bd.b631@mx.google.com>
Date: Tue, 10 Jan 2023 00:26:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-799-g1229c813bcd9
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc ltp-timers: 5 runs,
 1 regressions (v4.4-st20-799-g1229c813bcd9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Jan 2023 08:26:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10335

cip/linux-4.4.y-st-rc ltp-timers: 5 runs, 1 regressions (v4.4-st20-799-g122=
9c813bcd9)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-799-g1229c813bcd9/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-799-g1229c813bcd9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1229c813bcd90da9135b1ab2968110362be34bda

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  29a4437646ddbcf389965136680e06d40cbc4722 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63bd0ba35b1f24338f1d39e4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-799-g1229c813bcd9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-799-g1229c813bcd9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230109.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/63bd0ba35b1f24338f1=
d39e5
        new failure (last pass: v4.4-st20-234-g4e6ec7162c8e) =

 =20

