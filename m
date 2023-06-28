Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BA8EB64D7
	for <webhook@archiver.kernel.org>; Wed, 28 Jun 2023 11:53:07 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.14089.1687953179002682307
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 28 Jun 2023 04:52:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=XO/I2cNW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1b7db2e162cso24293355ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 28 Jun 2023 04:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687953178; x=1690545178;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5qhnLs3lERlNzezFY/Jyfdx0GRVuLE1Z7dUjymx90IY=;
        b=XO/I2cNWthStYTbGCh+ZP7o3EZYT70ldku/ZFWWMPSSZplyDcnrlgoa8wBvJNUDZdv
         ckO9TpRUxrNP7NY5ZlRH3BFrFXPDit0D7B2cpC6Jau8THatxcQFjacZrJCVgY8X45joz
         eMeIv4fVUqJ8n5vek1yzAKyf+yXrIGdYzQ9ZK8OJ4GK/W/pYMfFxchk5X5WnZY++hPNj
         I7dWa8S7LRLJCHdH89NDD7Zgc65esJ5H148DUqo7kW4eEnxAPLijSXoLmItOYE4kXVw6
         4NaNJyprLFPtdeY7x0FggwRYwpBfgi25l+ZtpQ/YZBrEoP/187QUSXPh8McZ2lkfycAM
         SiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687953178; x=1690545178;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qhnLs3lERlNzezFY/Jyfdx0GRVuLE1Z7dUjymx90IY=;
        b=LQjvN2qm4DvDh5sESP8AMeMIQLLu917ICRT73U1sSDkGYmL2QPAr+Je6igVocIhKuE
         swgnx2AkTT3fbomTw0TS7rgslW8kUwCSUsGjWe1s0HAcG9mzhjBsVgcfsYXJYHI3hLDN
         8RQ0wqk3t7wKMKiCVj1+STmkzkhmeIQMODsFj7IIfYXZ8cTLCY+Jo9jmXorgV/+BpZVa
         V36hM4pKskqDn7rWoOHomDRxCdkWkp066rTxbTsVjeLvbsdfVGzYEREf/2M1vl9yTXmn
         J3mP/2cpn7uCI9YotSPzIWSeK5uQr/xgk4J6K1XreijqHKZAJj5aef5Tw455UMwxMuL3
         MoQg==
X-Gm-Message-State: AC+VfDyb2blijhKN/nCU7PTFDXUGjwumtjpSdYjHt2tbnkV+ZEtVRGaq
	nqx/lbcs9l7XedmGAZXKfRRDA5RvG70ZNsHqJ7dHmQ==
X-Google-Smtp-Source: ACHHUZ6hg4S1yr/3Jvy4XLXPOpz+InB+9HWNfTtjo+rVXVmbaH8ofoaFumizYGUEUmdJ8kiKq1yoSw==
X-Received: by 2002:a17:902:ef94:b0:1b7:edcd:8dcd with SMTP id iz20-20020a170902ef9400b001b7edcd8dcdmr7011641plb.21.1687953177975;
        Wed, 28 Jun 2023 04:52:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c08400b001b7fd4de08bsm5759395pld.129.2023.06.28.04.52.57
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 04:52:57 -0700 (PDT)
Message-ID: <649c1f19.170a0220.da135.b1dc@mx.google.com>
Date: Wed, 28 Jun 2023 04:52:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.287-cip100-43-g1a6518aa81690
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-ipc: 7 runs,
 1 regressions (v4.19.287-cip100-43-g1a6518aa81690)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jun 2023 11:53:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12159

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-ipc: 7 runs, 1 regressions (=
v4.19.287-cip100-43-g1a6518aa81690)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.287-cip100-43-g1a6518aa81690/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.287-cip100-43-g1a6518aa81690
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1a6518aa81690648c06d59e0ab6b686571c63fed

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/649c1e91e2769a46bbd7d620

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.287-cip100-43-g1a6518aa81690/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/ltp-ipc-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.287-cip100-43-g1a6518aa81690/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/ltp-ipc-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/649c1e91e2769a46bbd7d6=
21
        new failure (last pass: v4.19.284-cip99-114-g02e97826987bf) =

 =20

