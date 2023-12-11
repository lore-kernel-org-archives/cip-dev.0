Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA46C10F14
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 10:52:52 +0000 (UTC)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
 by mx.groups.io with SMTP id smtpd.web10.5799.1702291968700613912
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 11 Dec 2023 02:52:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=sRhndq+K;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.172, mailfrom: bot@kernelci.org)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-35da93ba227so12930175ab.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 11 Dec 2023 02:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702291967; x=1702896767; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MBww7bJW1kmKhNSkp2OCa8sqguFxm4eeSlibLBqDzeI=;
        b=sRhndq+KnuPiP2d3Uc8ebgAeHdBGIGMls7NjovwpMvgv6nEQJqpFcvqMw3wp/4LvVt
         Mex2GvcuhiAkW0J6Evpx793WioeXmo3T63itgsZcfaacC+cgBata9ic9omm2NNOS/LRm
         VKSnsgeAStY1sPDjgyRBIpjH5zhEx6z6hO3Nn91w+CMcrpo0fTyKmPdzdHtKljWK2A1z
         c8VhJO7tUV8/jfufswNLLDx0Rw8+vsbiMNpXm3fxDpw4wP3kFdQeI3xT6XrZEz5KhKXF
         X4nBSr5loQlGa+O1EpdDDuJq4BBlD1mLdfMfI+hL0mYGJ7eidjPscFVNcjJgcRR9jos5
         vj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291967; x=1702896767;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBww7bJW1kmKhNSkp2OCa8sqguFxm4eeSlibLBqDzeI=;
        b=n1LQt6Xmk8eeGKDhONbKmMrv3X1hJrzUm9XklZobvRFzfVcpPq24MEAaoN5VS+nlLv
         oYhQIBEUI0KKLKJ/w9TuZW4Z2K3HMfaY6ZvZk6icxkVFIttv7PVKeRsFXAd7H9dxnDPU
         Wf+PMicmRI6xomcxDHzcxkcIPdv1nG1G2pbI5Ufc82A0a06qElFx+GxP8MCJeTn8aVuf
         smC5TFLvRgmTsdg7K/LmXLkp5++pJUne/0jXJK6J76blHU/Xw9QenqvbGJzekVnYBF6n
         LaHEdSwahyHhhx3ahwVlpKjgOgjDFwJrfDfz5FMs897jHdvVGitgh70A9eH/uG6HWuMG
         kl5A==
X-Gm-Message-State: AOJu0YzYL81+lxZVluRhYf82nQ9UI9nIBdsG6GbL1WRd1yk0xx/9NTBL
	OfWJZXgqJ4YdH6RQ9Rvv/UTFljUUzWpez3mfNDGAdA==
X-Google-Smtp-Source: AGHT+IFQI92Pv/uiWYSiZ+O6WXndXDMUwFYhN6y8Wt6sWXe17yUGGdJ1GErT+yjUHjmOSyxpV4bUkw==
X-Received: by 2002:a05:6e02:33a1:b0:35d:59a2:be4 with SMTP id bn33-20020a056e0233a100b0035d59a20be4mr3482508ilb.122.1702291967388;
        Mon, 11 Dec 2023 02:52:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n8-20020a654508000000b005c65fcca22csm5193479pgq.85.2023.12.11.02.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:52:44 -0800 (PST)
Message-ID: <6576e9fc.650a0220.fc765.c590@mx.google.com>
Date: Mon, 11 Dec 2023 02:52:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-63-gfdfe1fbf93bc6
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 1 runs,
 1 regressions (v5.10.201-cip41-63-gfdfe1fbf93bc6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 10:52:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14012

cip/linux-5.10.y-cip kselftest-lkdtm: 1 runs, 1 regressions (v5.10.201-cip4=
1-63-gfdfe1fbf93bc6)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-63-gfdfe1fbf93bc6/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-63-gfdfe1fbf93bc6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      fdfe1fbf93bc6fe6ed2708f11c2613bef556fdeb =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6576df8ea70ce9abc2e1347f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6576df8ea70ce9=
abc2e13480
        failing since 67 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

