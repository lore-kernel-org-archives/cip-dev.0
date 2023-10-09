Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26220CD6123
	for <webhook@archiver.kernel.org>; Mon,  9 Oct 2023 18:47:02 +0000 (UTC)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
 by mx.groups.io with SMTP id smtpd.web11.71066.1696877221260791058
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 09 Oct 2023 11:47:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=euifOYmz;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.176, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3af609c3e74so3539072b6e.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 09 Oct 2023 11:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696877220; x=1697482020; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AFsTo4LPmayaWZ8l9En/oahBnuLjFNz1kAZWG644Tps=;
        b=euifOYmzWP1C/zfDbIYMbZJ3W6m2NKAM2glbZEHg5R7Umep6ZkD+QGEsf+S+pIK2yo
         1gZV56yLE8vBsJQE9Px8NKvSIqfMjMeKWdbzhhCMFB0EFbEThU99bYxbNaF7tTGDMbrq
         iObj/q2mhtHtII5cskvEot/+fUvBRKEF7JeXObY1nSI8kHwV/5SS+BJu8vd5GPzXGWYP
         hWNLBmPpaiq9d/gydm2IMEsm0/IW5SmfptLXiaOxQ6qklORdSdgB8SGTBdWzsvyt3vSJ
         IFGMDan0mYHJQUGxJWKzLhabS2fM7TUCgBvI4D+DLJ8Q57OfLH2SdfHbZ66B7iqHidUz
         CrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696877220; x=1697482020;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFsTo4LPmayaWZ8l9En/oahBnuLjFNz1kAZWG644Tps=;
        b=C0nzyt5wtMbVdK0ro3J4OC4Cv/KwUvM2PJz3FhdCb/MEZtM6MRadTvk0K4XaGVo0MF
         nnx+CLc02uAh72OPI07cDiOpx9PSFRbgoiSzOL/msKkh74x4L1VBjbeEPrk0iAHLmEGO
         2i8ue5f1F15yDqz5mJ7I752iF+U/jXEkHo/CPgxJTRlLVr4uN2iGuGjy3NQIl9+elQFM
         8+eEefMIcVmoLi3Jkb8k0yb5knq1txuZSh5Tr9HeuKcw3ZD/PdRD9bviQGCLVgauuVNo
         j02Rqe44+m606tOc49jV/GQFhCJ5pxEdUUQLQ7IkMk78CF3wo8KSHpenCEc3BPj2CztO
         au8w==
X-Gm-Message-State: AOJu0Yyaob2mq+blf3jGRYidxJTOubZLsYRHC0hVcbUMF5jy0FO3Bn+v
	ozjPQRMBvGKAJ/nsjsf/0y5NPiGZ/PJCm0lNYUQrFg==
X-Google-Smtp-Source: AGHT+IEypiPVDDucsToyTYrb4z3Irt5GTRyadaAfDVR7mcTI3PzuLWA9I+ggGwlTzJgIebnp9tY7LQ==
X-Received: by 2002:a05:6808:1829:b0:3ab:84f0:b49d with SMTP id bh41-20020a056808182900b003ab84f0b49dmr23976585oib.3.1696877220147;
        Mon, 09 Oct 2023 11:47:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z24-20020a637e18000000b0057411f9a516sm8837028pgc.7.2023.10.09.11.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:46:56 -0700 (PDT)
Message-ID: <65244aa0.630a0220.eb7fb.673f@mx.google.com>
Date: Mon, 09 Oct 2023 11:46:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-1778-gc774a35d86d2
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-st-rc ltp-pty: 3 runs,
 1 regressions (v4.4-st20-1778-gc774a35d86d2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Oct 2023 18:47:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13330

cip/linux-4.4.y-st-rc ltp-pty: 3 runs, 1 regressions (v4.4-st20-1778-gc774a=
35d86d2)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1778-gc774a35d86d2/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1778-gc774a35d86d2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c774a35d86d261f0d49d25d9a02dbaf95cfd288c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6524426fa1a53b4c8cefcefe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1778-gc774a35d86d2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1778-gc774a35d86d2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6524426fa1a53b4c8cefce=
ff
        failing since 165 days (last pass: v4.4-st20-1097-g52d843097a439, f=
irst fail: v4.4-st20-1186-g2516b357b2e3a) =

 =20

