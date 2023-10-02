Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA6BE74902
	for <webhook@archiver.kernel.org>; Mon,  2 Oct 2023 17:47:46 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web10.89060.1696268865064563797
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 02 Oct 2023 10:47:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=SF0xToU4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1c737d61a00so469365ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 02 Oct 2023 10:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696268864; x=1696873664; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W18VJn8BT0xR4XMhS7AhkTTXbVHaDBPE6R5fPWWFK9s=;
        b=SF0xToU4LM+mryzwn/EsIp1V0S0Gebde1Zqv4k3Q+7GKFXGTKLeEN/1bmwziKbZOo1
         NUCggUEcGwaskC1KH1IDKbDuIfTsySb5C/ppdYMbAvjvzi3t4auO1hBSc3qCxQzEBs8H
         pxKdJwGki5icyU+gB6ZODUczoUg+mGYPBpo1tUUa6/dUurMDbo+BgzpjYqtezeIzds/y
         xsK9rcVM3e+iTu9hLlruvIErVgB+Eu16WCBlk8S/qo+OZBNZi06Eu7PJuEPDEkXaT5z2
         EwvQwrLY3oJUV2FRfBASznA4Tk55extR5nqUN2yzKc5X9XUXdZSd8d8uUQVeQunHAqy+
         m1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696268864; x=1696873664;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W18VJn8BT0xR4XMhS7AhkTTXbVHaDBPE6R5fPWWFK9s=;
        b=BSm6vR9MI/F2bqEIRe00yO7Szt2YTAajm4fH9FzzhwhV3e99wgGbjuSqT5uW5DU8OJ
         PLIm7V/DMpX+XHyyrQqbyeXhHi0kCRTrn3bcoDRaUcu4taU2b+1A1rrpVTxWtbouHb5g
         uYuDGIB6O7v10IGeXCbkVye6IEpLvEkLOdFVr1Oopvv6GHfNghgOX7eLCDyRqPijr2zs
         Tqkk3ucxw8LF2/VWrp//ESW/rWh1iLwYRovEaVyfxMugYWnwsvi7y3FVyY4bk0X5icYE
         UHqHnjQWgXgnirep4lMBqUatHEFA+OYnsInOouZQNyYJYUFMlCqx4F9zkQJvQE0aBpv1
         Qrpg==
X-Gm-Message-State: AOJu0Yx71EgnsOAX7kojLNVpN7UTlRMrArNYHqjAyT/U3BLg/opwv3D7
	kyQTTP5hzfraQVdZNxLSGriGwgp/p1KPEiIFzc44CQ==
X-Google-Smtp-Source: AGHT+IGD0ZlcPza4AafwKZDLh/ET9EU6GVgz8EzBgDLiEFKx6CIEpbUCsa+b0kvKLvaGjcnQnQg49A==
X-Received: by 2002:a17:903:120e:b0:1bc:7001:6e5e with SMTP id l14-20020a170903120e00b001bc70016e5emr14221150plh.32.1696268863929;
        Mon, 02 Oct 2023 10:47:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g11-20020a170902868b00b001c22292ad7esm10836565plo.232.2023.10.02.10.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:47:43 -0700 (PDT)
Message-ID: <651b023f.170a0220.25212.eeb5@mx.google.com>
Date: Mon, 02 Oct 2023 10:47:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-1779-g48d33e0df7175
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc baseline-nfs: 26 runs,
 1 regressions (v4.4-st20-1779-g48d33e0df7175)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Oct 2023 17:47:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13261

cip/linux-4.4.y-st-rc baseline-nfs: 26 runs, 1 regressions (v4.4-st20-1779-=
g48d33e0df7175)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-x360-14-G1-sona | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1779-g48d33e0df7175/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1779-g48d33e0df7175
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      48d33e0df7175b69a683cece4408dc61d3daf8dc =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-x360-14-G1-sona | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651afd838e0c04c3118a0a55

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1779-g48d33e0df7175/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1779-g48d33e0df7175/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/651afd838e0c04c31=
18a0a56
        failing since 265 days (last pass: v4.4-st20-234-g4e6ec7162c8e, fir=
st fail: v4.4-st20-799-g1229c813bcd9) =

 =20

