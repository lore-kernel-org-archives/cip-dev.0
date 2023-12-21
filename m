Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AECC3DA6E
	for <webhook@archiver.kernel.org>; Thu, 21 Dec 2023 01:30:05 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web10.42397.1703122202153613525
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 20 Dec 2023 17:30:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=O+qKuZCt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d741fb7c8eso301072b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 20 Dec 2023 17:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703122201; x=1703727001; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2da1Of0o6sbGos2lQBUyxTJL2SdHwN5V37AZmNPXprE=;
        b=O+qKuZCtqeEiUPO159QmnL+oViWJ9/TXYyKHvGB4uVHedmxOUwh2yKUZye/tdYXc4x
         89bCWEiv4kQ4TYUVboMDSCErZE6BHTbpFvqsBNfv7rUwxgRXLfRheE6o7nedaT9ibWDR
         fE0nituJq5CrWkh/wJ95tc56YqMT7PWbWkWfBPhy28g+TN+9ywLOB4r2BPTNq7wOVGxR
         HGIE+4SCc0J8bVV1P2Wwcsnzx8Pbmw5TyfQDCDkteOg5BDz5W9qDx0pekfvIsvjyaA7J
         +jQMXoZJeqo2IW7PZs7TM5D4O6Ncfqs4rpEZHP7sNTArXyl+YkwaFFfomj0FdxkC+RrR
         W+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703122201; x=1703727001;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2da1Of0o6sbGos2lQBUyxTJL2SdHwN5V37AZmNPXprE=;
        b=CJju2E9kBjDvSfmia/9rlwwv4UE+3V2v2X1zhxyioZUV5dp2OZRwCwSare7xKcJF2s
         m06zeu8QWCEZjnYF2fUAgmJeKargaGZeuENgIvnYA1fHBi0CkJaqPhwp1Vp1uRefP5f0
         e4EwtoaTt5hIO9sqQYxa32hHIsHzC+WtUV7OBqDx6iYMiWfUNIGYtGSd/x2zH1DLTmZc
         io0tj3jzlthDdfvM1muyAkeTcXh3BA2D1ntG8U3fDDsdB8jLkM6YlSZCyKjqkDeNWynD
         9yqZtxxdVt2dkliy9icz8gUXun5XCl4SqrOVKdP4QApd6mmcmyGgjY+YnBZ2ES0/GLoq
         PqHA==
X-Gm-Message-State: AOJu0Yx9ujdH/QPo+DQcS4ZzXHbrwSagbjuRKEOOXlyKf9RnFGMrcpIO
	1/l0a0Y8fSGLuOYc276aL95c2mPFypN1C0SOcW4=
X-Google-Smtp-Source: AGHT+IFRcMPThHNRt/nzSbsJ+R370DLGDIVcoaYmZ4StkdRwKXsxxjsrfK/NRFpM3+KRDGv/cHtCIw==
X-Received: by 2002:a05:6a20:7346:b0:18f:97c:6159 with SMTP id v6-20020a056a20734600b0018f097c6159mr740018pzc.86.1703122201165;
        Wed, 20 Dec 2023 17:30:01 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bk3-20020a17090b080300b0028ae8a31664sm473383pjb.35.2023.12.20.17.29.54
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 17:29:55 -0800 (PST)
Message-ID: <65839513.170a0220.99b8d.213b@mx.google.com>
Date: Wed, 20 Dec 2023 17:29:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-540-g3640150b3b169
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 14 runs,
 2 regressions (v5.10.201-cip41-540-g3640150b3b169)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Dec 2023 01:30:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14181

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 14 runs, 2 regressions =
(v5.10.201-cip41-540-g3640150b3b169)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-540-g3640150b3b169/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-540-g3640150b3b169
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3640150b3b169fcd03031a9e8aab166a9730a1f9

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/658388a4bfa66ee200e1347b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/658388a4bfa66ee200e134=
7c
        failing since 48 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65838a63d928d7c4fce134a1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig/gcc-10/lab-=
cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig/gcc-10/lab-=
cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65838a63d928d7c4fce134=
a2
        failing since 22 days (last pass: v5.10.200-cip40-188-g33d0b44cd71d=
, first fail: v5.10.201-cip41-197-g2d08925b44e52) =

 =20

