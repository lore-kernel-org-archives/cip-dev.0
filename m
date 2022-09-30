Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0114FC433FE
	for <webhook@archiver.kernel.org>; Fri, 30 Sep 2022 16:44:19 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web10.1283.1664556251595075156
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 09:44:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=b8bklYFU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id
 v10-20020a17090a634a00b00205e48cf845so9591840pjs.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 09:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=B/lPlo2yCW/LQIvvF4/b0VFgILufa2RNWuBLMPhlugo=;
        b=b8bklYFUKNHbWpKEc559oRarHKdAbzpQ12EXPyICmM1nIY9jeJq5efZLTIVG/cvzxP
         SsNqvtEMX72lNBeeOujty3NkYcKd3nfHfyHIBFroZbbfx+KFWjX+bho6jLIbzQ0Rp+GU
         fgvCwToP0KOyohz1Anx8UxvsgBdTw6FporwlZMTh+rlFZ7enGnBZYw0rKRvHimuME1NF
         DX0KPaxpfEztczoUvVqIs9qw7X9mhdsQTYMt/5ilCqcFmSFAw4VfMigvnwLbCXegj2PF
         xFD/nVIJ5Y9YBb8zu0IrcVMXST7/DauyqgjhkUw1plXQdkaQMN0iusHhaA/Vmo2mmV2H
         rE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=B/lPlo2yCW/LQIvvF4/b0VFgILufa2RNWuBLMPhlugo=;
        b=RAlZzWc22zVCzugVJzTB7zGFTybyYunTOdYE/YeL2vkEG22GVT90Gx3ZbquB1Es39a
         4HefLsrSErlJ7SsprugglfCFKx1Hm9qQze/kjlOe7dj+g/89iqKQJA9MCc0r6lKlhuNP
         21vtu0BAowDrOS81avWq/hZYAJf7LMtelTrP4T7AW3gZYpfycG9eeM46birL4hEtZ0Zp
         96jYyFaQOEAT4JHf3gxhiOIuerMLlaAPGRqBjCmHUYL6urzlQttgyAcx/eB5w8YWQ+ng
         wRRWIUcWdLOhlJF18WHv70uEv/VQ9enMmXMghqVyIAoTqHZoOd9kXYkpWHPjFKEjbQM8
         OszA==
X-Gm-Message-State: ACrzQf3uFh8W0B+extwWPayROoMVHGcuAZhBDxJ4fAHHTwW0SEBEQeJL
	edZLFQ7wclnRWAxalmtkhcL0s9z3lCfAC78MxwA=
X-Google-Smtp-Source: 
 AMsMyM76PuuSL7NH/5ROpZmGNYHgPIDYrlE21P9vBib0lcBn6nddxIdIKFjsPnoApUbsfw7Z52mTBA==
X-Received: by 2002:a17:90b:1bc3:b0:203:84d:59b1 with SMTP id
 oa3-20020a17090b1bc300b00203084d59b1mr23445659pjb.37.1664556250746;
        Fri, 30 Sep 2022 09:44:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 o3-20020a62cd03000000b0053e66f57334sm2017997pfg.112.2022.09.30.09.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 09:44:10 -0700 (PDT)
Message-ID: <63371cda.620a0220.1b693.3ebb@mx.google.com>
Date: Fri, 30 Sep 2022 09:44:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip70-98-g7f7838c92740f
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip ltp-pty: 3 runs,
 1 regressions (v4.4.302-cip70-98-g7f7838c92740f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 30 Sep 2022 16:44:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9600

cip/linux-4.4.y-cip ltp-pty: 3 runs, 1 regressions (v4.4.302-cip70-98-g7f78=
38c92740f)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip70-98-g7f7838c92740f/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip70-98-g7f7838c92740f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7f7838c92740fa423a5a3f12c00ed02d92851254

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  48cfd7a9977e6268b4aa2600608cebad7e0e42b8 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63370f7c5673a802d9ec4ee0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-98-g7f7838c92740f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-98-g7f7838c92740f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/63370f7c5673a802d9ec4e=
e1
        failing since 78 days (last pass: v4.4.302-cip69-296-g52de9431d314,=
 first fail: v4.4.302-cip69-508-gd887d54a1be6) =

 =20

