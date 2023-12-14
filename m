Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B356C4332F
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 13:50:48 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.22458.1702561839089270694
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Dec 2023 05:50:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=v0sn6sbh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d35a721340so9162755ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 14 Dec 2023 05:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702561838; x=1703166638; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iRCkq2HqOj9BpBnMFgszzb4gGe0a2TaO+01npyRIeKo=;
        b=v0sn6sbh5Lmhpv0zWTYDjX0yLGUTfK3ah8INId321bN+Jn0RE0gMH2M92mWoljq6Bq
         xSm3xqp6/nDiTrQ0KmVlk2NjpEuYLBMvuFIeBgFlniDN2A1+RkPKW2GITP2ofL6MS8pQ
         sKefoVkll9rg4nTrP1QrJfzdx3jahg/VVyFdu7uGljzd7rIs5tjJMCarVP3LpzQv9Ai7
         D/GOsKRph5BiwQokAE5qDLfqsY/AUuxm+AMQHqQa+TK8SjKRoUJoNeIvDQ19OMOE4nu/
         zUnmkEe7bn33PRn457iIGZr9DDUgkHo2QPGhsebW3qy08jskRbmhDxo4Q6qjry6gC9PE
         jJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561838; x=1703166638;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRCkq2HqOj9BpBnMFgszzb4gGe0a2TaO+01npyRIeKo=;
        b=gicvGBuITLxukYSV8cbxFAPKvij3jLYuVLES2MAlpvUZooJrY8U2PIl6MKXTxW++Nz
         D2WZK+z/jMu0PX65U6RdWaXJvM0FxXHD9pdH7GiE1eDasej1658Veb0xRikvIxSjJ2fR
         7Mep4OoMdLKB0Gy6EFeFHM0Mr2WqxB4GIwpXoyMSabenzCAAoydJ9Gp5CakrKjt0EjBp
         sQRKQYSWYgHExv95wbQyZmTE5RKVVmXDi8hqr8stjawqLucAXQlRhetE3bc+nUEmWFO9
         eGelSSszE8W8SVo2Gqz8mGI89tcizu+wRX30hei+5j4EAVLm7xnGSYRVjjPHva3imH0G
         zWNA==
X-Gm-Message-State: AOJu0YwuegH+yKgnjB7Gc2NXxqyvkGoUXEwlLL5MQMoRHgzi0vYKAwLv
	ktuxQDOb8lA51W9UNpPRoO29/R03fvzZ3DotqPe72w==
X-Google-Smtp-Source: AGHT+IGRMIEqz0zsKKOSjXVq78FW41L3PUPuGcaeraz7/qEI6M8Oznr0TOjGNKxYxw1/nVH3m62vTw==
X-Received: by 2002:a17:903:230d:b0:1d0:6ffd:cea4 with SMTP id d13-20020a170903230d00b001d06ffdcea4mr5652139plh.93.1702561838101;
        Thu, 14 Dec 2023 05:50:38 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ec8400b001d05456394csm12416404plg.28.2023.12.14.05.50.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:50:35 -0800 (PST)
Message-ID: <657b082b.170a0220.5dfbd.5ecb@mx.google.com>
Date: Thu, 14 Dec 2023 05:50:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-69-g8f7b450fc28ed
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 4 runs,
 1 regressions (v5.10.201-cip41-69-g8f7b450fc28ed)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 13:50:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14104

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 4 runs, 1 regre=
ssions (v5.10.201-cip41-69-g8f7b450fc28ed)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-69-g8f7b450fc28ed/plan/kselftes=
t-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-69-g8f7b450fc28ed
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      8f7b450fc28ed99196853536c98ae36c2567e160 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657af2fd75ae196af6e13551

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gc=
c-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gc=
c-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/657af2fd75ae19=
6af6e13552
        failing since 41 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

