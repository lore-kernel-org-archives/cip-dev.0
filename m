Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A79C7EE2A
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 15:14:49 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.29038.1684509281720186638
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 19 May 2023 08:14:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=3oUyNR8B;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ae8ecb4f9aso1919525ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 19 May 2023 08:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684509280; x=1687101280;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SVVxNsM2889qBo7IY2HuMDxLGdJ7fh8nxv/RaqRBwoc=;
        b=3oUyNR8BZ5gYoldGUzrIEUAMOwoeitduommc8bxkoYLrwWmEKlVhWVBNBsMmqhNgur
         dvyWFie/SmYYqhjOGJO3iuaqwBhBdggvJo49h6I8eOCkIudWAKEKVogEy0ok1SYvo7Qv
         KU75vRiLfTEYnCd0A7+BN652UaZKkQ57oz50w8ePPMoCApfZyGTv697XobTG2eqNpe6P
         fXV9ubcWnWZ99L5W16ez+QmTnC4iLJ0YtHaHoDsSHebkEr9aQFKQDnmBsIMbuWT5OWnL
         +TFeR5OuJ/Pe6IPKTTHmvPAuJ5hWCkdphVnD9H9MXCqa9CPMztH7dPGRvuUQgQc5iK8u
         VmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684509280; x=1687101280;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVVxNsM2889qBo7IY2HuMDxLGdJ7fh8nxv/RaqRBwoc=;
        b=dTpVi95aHiA6gKq8qy3yAc6bgxALg03cd6p1cQ0byQs8XysvcbwC+UbzQnUr0RRQiD
         e9Dg/93qQhThoSYH9nlJqsp4osnPB+GRx49khl9l6Xx33XrRIUD6JmPN33g1Mwqy5+sb
         yY6AKsQIAyWrguDa3p4mvbA8NzRI92+PJEn1zzMPHzurq6sxMXgrWsoUQiSoCUDzL6Ef
         Gs2fxpdyMrqtQf4yNygHp+7Gb6cfNFVSJb6XnnGho2EdFGmeV17P6vrVfBDJ5xIW2gM0
         m+ZCbbCdrrdFuCzBL5Ap8b4uACQ5KerbAFRGX5Dq3XtOUaszooFshyS5ZACieWRT6B1v
         NUIg==
X-Gm-Message-State: AC+VfDzWUpc4By8T8E/xhAKvCNyyZUAbQDYsXwT5jr64DhUQBYXhHz7e
	1gy6+Sq1O7lg3cOWkyae5BLjPPQWWrKr3fG/nsAqZA==
X-Google-Smtp-Source: ACHHUZ6bcnS+7v5g6sdyjgXqspswInYeoblPtxmrX0QcXCKEa5xV9B9CZaWuUsm9+u9mRXxz6EkO4A==
X-Received: by 2002:a17:902:ee8d:b0:1ac:8ad0:1707 with SMTP id a13-20020a170902ee8d00b001ac8ad01707mr3472720pld.1.1684509280571;
        Fri, 19 May 2023 08:14:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902b78600b001ab25a19cfbsm3549795pls.139.2023.05.19.08.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 08:14:40 -0700 (PDT)
Message-ID: <64679260.170a0220.5dfb5.6704@mx.google.com>
Date: Fri, 19 May 2023 08:14:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.283-cip98
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip ltp-mm: 6 runs, 2 regressions (v4.19.283-cip98)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 15:14:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11568

cip/linux-4.19.y-cip ltp-mm: 6 runs, 2 regressions (v4.19.283-cip98)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.283-cip98/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.283-cip98
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      31603fc59adb456f6eb0f58de8bb989b41572c2a

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64678734718a18d24d2e861d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.283=
-cip98/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.283=
-cip98/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/64678734718a18d24d2e861e
        failing since 489 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64678b375e3ef28d422e85ee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.283=
-cip98/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.283=
-cip98/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/64678b375e3ef28d422e85ef
        failing since 489 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =20

