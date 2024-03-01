Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27706C5478C
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 15:58:05 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web11.26929.1709308675271121693
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 07:57:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=uDKj0X7p;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dcb3e6ff3fso7391095ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 07:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709308674; x=1709913474; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lF7GPrYFR0cWo2MOCuY+QwLp+OqOp3ICxJDktBLf5PQ=;
        b=uDKj0X7p64kdNnJV7SOZpZzRTbOeSQ2tVWWzZWIlMFpJTJY46cWJsqUtbNd3tDtCjo
         as8CNrOXHzbH9iQBeDSRnSmMdbu15CPpYG6nBSadg1IQXnII5butfGMxKXyKe/3ivrgY
         aRpQPiNu8Vi2xULWtkGknlkzWbEz+1CJchDmwncoPcEG4KPRUmrDYTm3PyjmXPs4RTLc
         VhzN53a5qLLLIBlMykD8MrcVN6JCLbIcTEIK3N2ZlzQd0lXjYPxz+2ZpVjhzJVR/fAOt
         as+vfkLn8ArEyA9sW1GvhDjGVkEid57oE8w5U8vCgWyJGv2v8kLcBPLEEkZWGjCo1Ao9
         kLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709308674; x=1709913474;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lF7GPrYFR0cWo2MOCuY+QwLp+OqOp3ICxJDktBLf5PQ=;
        b=qqNkACY9jtwwm/02lbbL4MexJnVQ/yOtllJKS1JxT4jt2BbAdMS0YCDKIj8jhJ+neN
         8PWL8/BhoKodsg+Z4HxoTTMZDntSJzAgh3IM7agiDAeut70Ksk+lDgqY05QjKjzCSIHd
         HrNOSMo3U5ZITaD4BjmUIhyAAa8GP4TNFBSEi2mK4hMrHwkVpgHVROwBFtZR7e0F+Yav
         Uf7LvfJinAhyuwO/ihvjf3RCzH1S2IAdWfliUAkq2CZwCNqyK6qyLr7IDZvIALeM7EI5
         IkAXKU1ZPnuqgGAGH6VzcPeEfmeOY8s0HJUi2jMcJz7pSVHlPTH9+kJmMrPOTrGBHP+D
         utbw==
X-Gm-Message-State: AOJu0YzCXaX6pglso28fE1hW5duNMQBnutKdgiRMRQd7qsFL6d2jiGuY
	lme7BZN22YKcYCSXdU98xf2WZtzDcjoZcFcafAxYnkb9zWhAkmdK8g0I+VFgZLoDrtHXXB4jY7x
	iIqE=
X-Google-Smtp-Source: AGHT+IFJRBq5yQkckdB+jxh3O2ftQBEKVoeKWh6in19nZIWWrg4iR+j5nsSMe5QXNsjP8BkxdI+NJw==
X-Received: by 2002:a17:902:d58a:b0:1db:de64:97ac with SMTP id k10-20020a170902d58a00b001dbde6497acmr2386001plh.15.1709308674370;
        Fri, 01 Mar 2024 07:57:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902ec8100b001d8b8bf8e45sm3612475plg.37.2024.03.01.07.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:57:53 -0800 (PST)
Message-ID: <65e1fb01.170a0220.84a70.00af@mx.google.com>
Date: Fri, 01 Mar 2024 07:57:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44-56-g6ff909810a18d
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-ipc: 15 runs,
 1 regressions (v5.10.209-cip44-56-g6ff909810a18d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 15:58:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15128

cip/linux-5.10.y-cip ltp-ipc: 15 runs, 1 regressions (v5.10.209-cip44-56-g6=
ff909810a18d)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44-56-g6ff909810a18d/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44-56-g6ff909810a18d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      6ff909810a18da01523521db983d48116abb28ec =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1f9fddf8188624563701d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/lt=
p-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/lt=
p-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65e1f9fddf818862456370=
1e
        failing since 149 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =20

