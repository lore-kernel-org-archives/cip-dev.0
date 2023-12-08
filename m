Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D43C4167B
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 17:49:15 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.42752.1702057752054078980
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Dec 2023 09:49:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=m+5F7KUM;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d0bb7ff86cso26358885ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 08 Dec 2023 09:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702057751; x=1702662551; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RHZ24wql9ahQpzxomRfPeHazdvY0ZiQY44xvLXIn/NU=;
        b=m+5F7KUMCDqRZQMGvB/OSd85+UEZdbP1hkXodr8wqmnmlpHvjrRcTmTtPoFwLbWQrP
         AYL8oHDuVMVRPGgBy/WXZlpBgf2l8O+oKtxHS7sU5MChV1gbPmwJI6d2S8eSxeDD3uGV
         4N3hZLgrTq7CMCgtbAn6GwPePhj4UBspKV9/GMjkqE/Ku6aTGAwQFA33gT52WKW+r6Zt
         4NlnuS7QZd29h8uw4jJWm3fB2HOBy6T112rljswB+jRLqCA1BAgOWNjOn32S2DldJc/4
         yg+vYvUmuCbzNoS1WGQw3sbuHp8IiD1lda1qSElxCyO2HRf5XaWdag+MhTrEZPyAwdi0
         rzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057751; x=1702662551;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHZ24wql9ahQpzxomRfPeHazdvY0ZiQY44xvLXIn/NU=;
        b=voFVSFXMVD6gZRRFIXW38cgNobHsflI80Iw29488E0wZhsaHsJlSovrQD4q/eH0MZW
         yPOzrJpDt0P/4wR3gV2FjXHDhBrBPZk7p4+jkE6vXs5xOZdRF1iXzp6KbPjOH/tJRFEh
         p0JfGULD+irK5SZhaMVaMXGLTQlsFz1997nGKNHQFBN8XgHIpIaOLQvbygAJ42PckK/p
         QKlxEmszSTk/NJ9Ov7ZUDY9IF5mGKcnLMz3ALdSpSPn05vtJD+11JrHyuzpx39ZfiDXm
         FMyxITR3Lh4g9vywpeSa8Gpy9ZGyzreHH+dwd1mTcB5OjD8mnBgn7u/eFMU/GZEqfGCn
         w6Uw==
X-Gm-Message-State: AOJu0Yx6KkbgMRsnTgkkNfSWG2KhHJKF1MYHYO91MbyrQxqocxDm9Zuz
	V7B7Ef8kKrv/IH/2LozZKavEdqSOYS7Jt8hl+uoKTA==
X-Google-Smtp-Source: AGHT+IESbthGNq8wIfteVraMD79TI36T9cpqPay1kXMYsIA8xWLuH7X2tu1wQyWE1U7flDthAapuEw==
X-Received: by 2002:a17:903:18a:b0:1d0:acd4:e711 with SMTP id z10-20020a170903018a00b001d0acd4e711mr599678plg.15.1702057751127;
        Fri, 08 Dec 2023 09:49:11 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902ee4d00b001cfc2d024edsm1981016plo.29.2023.12.08.09.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:49:06 -0800 (PST)
Message-ID: <65735712.170a0220.d7ed2.6dd9@mx.google.com>
Date: Fri, 08 Dec 2023 09:49:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-46-g596f4c151d286
Subject: cip/linux-5.10.y-cip ltp-timers: 9 runs,
 1 regressions (v5.10.201-cip41-46-g596f4c151d286)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 17:49:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13988

cip/linux-5.10.y-cip ltp-timers: 9 runs, 1 regressions (v5.10.201-cip41-46-=
g596f4c151d286)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-46-g596f4c151d286/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-46-g596f4c151d286
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      596f4c151d286c71a3612a2120ab33f4ac885d2e

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6573473fb9b09b4b69e134df

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1=
-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1=
-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6573473fb9b09b4b69e=
134e0
        failing since 28 days (last pass: v5.10.194-cip39-1-g53e59f50ca3ff,=
 first fail: v5.10.200-cip40) =

 =20

