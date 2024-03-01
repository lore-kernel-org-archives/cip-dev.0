Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B432AC54E55
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 21:13:36 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web10.35400.1709327614551756785
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 13:13:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=tAX/vlU0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.182, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d8b276979aso1943687a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 13:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709327613; x=1709932413; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=msSZgI6FBXpehkV5LUkih4ivXpYf//MxLzdoVO26sd0=;
        b=tAX/vlU0exqQyAuGBtyW5dOVkIWEIEv82hY9qBm5UaU3PmCY7lRcObGXJF8bxi/9gJ
         2Lg3+bYSBWaafX+hxYXViergvScdTaUGuBuoFgUBXrUMv1YSXL1vKkY1+QfufPfDatTo
         7Me6DwUePaMX1HMfxc4ke7Y8qnOqoirjWLFs0S8Ef14dab7CpZCzDQF0UOtFujAcUxs1
         yyKi3Uzya71IeQy/XA3cYvgHOud1a2ffpkGj4OoXCcEq47hR18ourNMxi34gIh6e1EEj
         mPyGigjePUJNSaZtLi0ilCEWy/KFNPf2XScRBHOGJYrnWXY1gB4oINf8DQTyPR7zceoO
         FEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709327613; x=1709932413;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=msSZgI6FBXpehkV5LUkih4ivXpYf//MxLzdoVO26sd0=;
        b=EXjCtQYxruAW//isE0SbGwn6OJ9K7zqAJnrdJHoR8ZelhVEoUubDsXtUP1VK7FLuxb
         RzpVtcAjxFPbZcVBo9sW8BxLeAH4zbs0w8Q0Fudbm5yQsxf6wCKH6GOsBn1zCjHLEoDF
         w54XP2k/I5adPl/RjM+TLTggt9nAnVukPt2Ty6DyHM1Nt9m5GFpGoChVJuWf4FCyF1Ux
         89ffQn13UJPnZ/44p9YPGCpqqnedWlc8ImEktnNG9SFkkOQ7mplZmNi8e8SN6K13m09x
         kBTI4k5q1QEp3kEYnxhvgAq6D/kTKv6MFXCEo1PfVPtD1t6S0zD3YHdH/bAlost+fMXP
         YOJg==
X-Gm-Message-State: AOJu0Yw9GG2ORFnCQ+pM+Cf1aBKHmQwwyWNutvXFReWoMtqTWJGaODce
	lUsWpPky9NOskyh+w90moEsH1ZSDv0XWnqOEo8NDjYYKHbMt9yGo08aSWhyWSy4o/J+BSl4WQzO
	fNec=
X-Google-Smtp-Source: AGHT+IFXYErAUQwLxhWkVxtgtZ2WWC8YPl327WmvfanFTwZRMZAra7+/1zrN3g6WTMhgEpG469so6w==
X-Received: by 2002:a17:90a:4615:b0:29b:a59:a12d with SMTP id w21-20020a17090a461500b0029b0a59a12dmr2612697pjg.25.1709327613315;
        Fri, 01 Mar 2024 13:13:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o8-20020a17090a744800b00299d061656csm3632229pjk.41.2024.03.01.13.13.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 13:13:29 -0800 (PST)
Message-ID: <65e244f9.170a0220.74316.19ea@mx.google.com>
Date: Fri, 01 Mar 2024 13:13:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-552-gc0460fb20fc00
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 11 runs,
 1 regressions (v5.10.209-cip44-552-gc0460fb20fc00)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 21:13:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15145

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 11 runs, 1 regressions =
(v5.10.209-cip44-552-gc0460fb20fc00)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-552-gc0460fb20fc00/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-552-gc0460fb20fc00
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c0460fb20fc000a52548daa693788068d4fc9a8e =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65e23a016e9df1d5e6637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-pty.login: https://kernelci.org/test/case/id/65e23a016e9df1d5e66370=
13
        failing since 120 days (last pass: v5.10.182-cip35-289-g3c054954070=
6, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

