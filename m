Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6446C46CC5
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 17:49:05 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web11.42454.1702057744338736736
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Dec 2023 09:49:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=qU2ldN5n;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ce32821a53so1589924b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 08 Dec 2023 09:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702057743; x=1702662543; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A5VbGEQbNY4dTHwje4JlNt9nSr1BUNalea/B/J+J1ro=;
        b=qU2ldN5nu/q3d9rnR/mgME6ArQ7cEmFBKOyGjoGxDec+ZL8lQTqecseB5eJw7yDxDg
         aSFfWE2/FRxxY/fXmMXVoAKcXPQTMWmm+RFotVk/NgVRl7jBnFk7iVqc4xNdId5ZAjEA
         /Y4ZQcKiAt5PFP/zQe/9JnP9WxisO1Ka7Zwf65xaJKxT2ntRMwrQHl85EsagDeop9AtF
         yniuADG0XtAYUW4O6g9++SwuHndSy//DHFemLrPlP2TZxRDXUZZWrSsmkvZFadwkUWI6
         xjGJ+EfDYPN+ny/8cVFtwN3RYLdm0ghJgYQenYm/WcRDtXXboPYVC5rLijcAc+egSK3M
         RUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057743; x=1702662543;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A5VbGEQbNY4dTHwje4JlNt9nSr1BUNalea/B/J+J1ro=;
        b=eNzR5t1jwxo5QOT5bFh+2VKDMlmHM90NkYa8AqC6iNyAv4ZJK1YcsFbC4I63QQj5K0
         hBBVsCghxIhmJyQk/2Hu+N251CrhZ8/rScD6frC2zce35R8oIFaVXBx19dZ230knnS88
         k4AekPPrK+rwI4/F9oBo0XtfCWP0QVjclZNcS5qqdH0qs7jw+oD2gXOzRS4Hiyqu02lD
         /XywJYrk22pFh0t+wuZVXC2M/pT11vtmVkTdh+5jMvPSE06+ksvkdL2pcTyR9YQSa3pa
         20qba+WQ+MALbrJa9xVX4lYVDzjwmiWPOb3rbQPOmZ1dBPISnTnCBPHj/3In9cnKo3Rc
         YAvw==
X-Gm-Message-State: AOJu0YzSQIg0iGcXICZAUhCUXkrx8dToACAPQmxLrniPqRxsNOlsSav3
	UVBqeS4EQpndyXe1VxMx7aHRFQL7HsprqW26Rvo/EA==
X-Google-Smtp-Source: AGHT+IGF7WPKKkmSGIwrFg5Lb8aRhLsrpmAGvrJokvVo/3sQY85WpllIy/EH5Sv1BP2QelMfDuikZA==
X-Received: by 2002:a05:6a20:3d02:b0:18c:4800:b0ac with SMTP id y2-20020a056a203d0200b0018c4800b0acmr446276pzi.23.1702057743263;
        Fri, 08 Dec 2023 09:49:03 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id pd15-20020a17090b1dcf00b00286ab9bb87dsm2121095pjb.42.2023.12.08.09.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:49:02 -0800 (PST)
Message-ID: <6573570e.170a0220.51698.7581@mx.google.com>
Date: Fri, 08 Dec 2023 09:49:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-46-g596f4c151d286
Subject: cip/linux-5.10.y-cip kselftest-filesystems: 8 runs,
 1 regressions (v5.10.201-cip41-46-g596f4c151d286)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 17:49:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13980

cip/linux-5.10.y-cip kselftest-filesystems: 8 runs, 1 regressions (v5.10.20=
1-cip41-46-g596f4c151d286)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-46-g596f4c151d286/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-46-g596f4c151d286
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      596f4c151d286c71a3612a2120ab33f4ac885d2e =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65734842530729218de134c0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-cip/kselftest-filesyste=
ms-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-cip/kselftest-filesyste=
ms-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/65734842=
530729218de134c1
        failing since 65 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

