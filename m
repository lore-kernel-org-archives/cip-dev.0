Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670E2C4332F
	for <webhook@archiver.kernel.org>; Fri, 25 Nov 2022 13:12:18 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web10.46760.1669381933733125023
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 25 Nov 2022 05:12:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=YfFThlum;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id 140so4127693pfz.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 25 Nov 2022 05:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u5ZJQzM4Rg/W0cV+hs0jy/uYy9/FyTraObiTMZtWbVA=;
        b=YfFThlumOmJMsTXydl/95m2KPG9OyaCbPEZ4J8yUBw3NZV/BorosBS6ItvNQlC1GNx
         T2dWumPgedkxlgeoPyksKFyY8Ti8jVREtRc0rAIExg/VvI8oyXUaSF1KQQbxjsP1Y0RS
         tTmMwrBr9KZYnRK836CnxwLY/mt7j5+GU3FFc55T+8oZLZz8zykOJwNyrRXOlkTqYbL6
         HwAPPGScrfV/zt59lT46ebFxrbDBbQ9Q6ny3e5VIp6qGFo1tlJQ7/pbI7BdGlelaRoYr
         OP3Hyq7h6FIHZ6yFG7OjBokZshsvSpEJtYjuJUzZJq8G5tgQn/NUIjYJcWhhICsm7tgM
         3cDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u5ZJQzM4Rg/W0cV+hs0jy/uYy9/FyTraObiTMZtWbVA=;
        b=zuTeqUo7O8LS0RBMjXXdPxu52AGUmAoSO6xtytZSDX4+4M3RPemGYi05BOcnrj82io
         XVsZlgcPG2ao5BymoTmyZruqwx4vwV/dOuioLKJVUK16kNMHaA7yDymuPmq8/SRU3Bpp
         0PsHLiI3nNaka0nr1wg5ClzJmdy6Xm8pSf2vegd8nO2zx4Dr+EZnM3iZumU0H84ZRi1L
         GqRewd+hLq1BNDlVru9KyAQUNsOmUBUhvbHBUxDPVvdKHEBPfQot8DTnfhaPHra6itwD
         yrGi+4IT886kX2sqi4XIzI19XBJpVpNKGi1qKboI1GeC7xWdvIAFdqJyKc7RmN5hlj66
         X1PQ==
X-Gm-Message-State: ANoB5pmMyXKVAPK+Gp4KL9CH/gTqvG7cpJ52ymVAD+ksLxnqVCobCxO0
	3qzTPoHUwNkI3NgqkS5GieDSHzTfg78+3+e1tEQ=
X-Google-Smtp-Source: AA0mqf4/LzKlYGXAp1/nHnk6x1vdHy4Mhzt0n8jGziWXY2yRAXQV7bFtETqFJfWO05F4iqUrBwzYxQ==
X-Received: by 2002:a63:180c:0:b0:476:848f:1ecd with SMTP id y12-20020a63180c000000b00476848f1ecdmr34309082pgl.589.1669381932758;
        Fri, 25 Nov 2022 05:12:12 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q11-20020a17090a1b0b00b00217090ece49sm2918431pjq.31.2022.11.25.05.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 05:12:12 -0800 (PST)
Message-ID: <6380bf2c.170a0220.22721.3e94@mx.google.com>
Date: Fri, 25 Nov 2022 05:12:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip70-236-g69445bc0d420
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip ltp-fcntl-locktests: 3 runs,
 1 regressions (v4.4.302-cip70-236-g69445bc0d420)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Nov 2022 13:12:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10109

cip/linux-4.4.y-cip ltp-fcntl-locktests: 3 runs, 1 regressions (v4.4.302-ci=
p70-236-g69445bc0d420)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip70-236-g69445bc0d420/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip70-236-g69445bc0d420
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      69445bc0d4209b0634d1f43657fd58f708cadf81

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  a15eb3cdfa3556203167572e15754f1f59ba26bf =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6380b9aa90339e81b12abd00

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-236-g69445bc0d420/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-236-g69445bc0d420/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6380b9aa90=
339e81b12abd01
        failing since 3 days (last pass: v4.4.302-cip70-98-g7f7838c92740f, =
first fail: v4.4.302-cip70-236-g69445bc0d4209) =

 =20

