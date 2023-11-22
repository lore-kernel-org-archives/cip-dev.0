Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30257C61D97
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 20:34:42 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web11.35380.1700685281686642834
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Nov 2023 12:34:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=fEwC+58U;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-285196556fcso201181a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Nov 2023 12:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700685280; x=1701290080; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+eULknT/OlL7/L0NeVTNVheA2gyuqdMtCKP+fM3bKbg=;
        b=fEwC+58UsDV9OrqITk0hDWKpwaHUJiXSB7nmFsiMeKuz1FbzqlBYnO8NwQUgBg6qTO
         M+IVaA8rcZ539P2o70FEwYapSICF97nbSc1TtcVyuldvJh6V6McPyNE48e9gIsWWpzh5
         3kUrBPGJzy89lcl42lZD8DsXoBPo5gMWuxc2MAnJNVfOzIhgOqWM/mK4GX2Fm6cv9aoG
         MhBTXlJ+p7H6Je5wlI0MytXWMvLyWBqFlyc3DPJixhPMFMGbRMd8RNaNdQQCgep7/zjb
         87URGYUw522YwSXj4bjEFWUrivDPa+/0u3coxAhUxlfWhT8dRJ5GwoQ3SBqANWPkqpXV
         oAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700685280; x=1701290080;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+eULknT/OlL7/L0NeVTNVheA2gyuqdMtCKP+fM3bKbg=;
        b=Rmpau2OYCn/oWLN7nzTzsJyJSPfKMo2xuBHWg1t56cY2vjQkFJjHAaT3DpQjHniGBP
         8UeoeYAKDAyUONDomdRQmhQ+Yun+V+/XPtxlx8J+Jn4JEShsNH/Tw6vV3ooeAcHk3WuN
         95wWo1Oc7Wbask8aZ3ur0xQrMAGwZ4eg21XVtTVEmf/zKXC5BYwvFtiTm8wrTUDYSaeQ
         QBQPNA/yK8UWUJ2JcfX8eqO3ztE7TdiSUrtO9w36Ff9+r8+JBUWp2gq0M9IT0bvqPM4X
         aXSYI17k8T3fzgeR/mFLVeUY0iscY3bGaPT9juvIYZ2cFY2fmzxPpjXUzETagYOl8ALi
         2gTw==
X-Gm-Message-State: AOJu0Yy9AXL6ENJIrOIpPXDEP+QS3DUKcwb6o343/83voeBsHl9EzRgU
	XXQFnULYemK2b9VW+/+dIWcya9GR9hoxuNlJoHY=
X-Google-Smtp-Source: AGHT+IH66KGFMrwrxJ5PS9lnMU/u0im0mi4CpgdPMALjcMXYRQO0RmLQdntrVa2gGZE9pNNv3bvlpw==
X-Received: by 2002:a17:90a:354:b0:280:18ba:f016 with SMTP id 20-20020a17090a035400b0028018baf016mr4029590pjf.47.1700685280401;
        Wed, 22 Nov 2023 12:34:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t14-20020a170902e84e00b001cf59cccb10sm97812plg.23.2023.11.22.12.34.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 12:34:39 -0800 (PST)
Message-ID: <655e65df.170a0220.15517.0abb@mx.google.com>
Date: Wed, 22 Nov 2023 12:34:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.200-cip40-188-g33d0b44cd71d
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 9 runs,
 1 regressions (v5.10.200-cip40-188-g33d0b44cd71d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 20:34:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13643

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 9 runs, 1 regre=
ssions (v5.10.200-cip40-188-g33d0b44cd71d)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.200-cip40-188-g33d0b44cd71d/plan/kselftes=
t-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.200-cip40-188-g33d0b44cd71d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      33d0b44cd71d9f81944784e605bc1def7fa0b71e =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/655e53b1c43fd89ce27e4a80

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/655e53b1c43fd8=
9ce27e4a81
        failing since 20 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

