Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AC1C4828D
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 18:41:49 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.6025.1707331308393267919
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Feb 2024 10:41:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=JQWMkBCN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d7232dcb3eso8067725ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Feb 2024 10:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707331307; x=1707936107; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KkEIEK8CKgq80xZfRTNvGvWQr4Tg/ZBdTJOyyMdAAQY=;
        b=JQWMkBCNTNbYob2SHkOK85MmjgsjomE0QD7VtKD73LXz8shYWjayWjj1fOUZbtzK8b
         WQSxR4jpDGdGcVu46k8EMsxaV9MgNq0Ap7nZsSdp1UexomL93aMW5ar9VcvXDhJ9mqlP
         C5vo/ML0AkkCTGBoL9sV2tmc7xbutaRzppxb6ztr9t3fDmLQ8gq+U/OkArV1xPjaQMQs
         ITfArmQTPsafHIbPMkdAVQni7GO/vFLkC/tw6nfMZ4SDN4jjnSY01b1nQ0QOcvtzoJVS
         uvHaM4Ab93ertNu5dyWYbX/+jtwBwykpQ2X8WqfPccW3o2ZytF0mY5H5DM7A4gbc1dtk
         vZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707331307; x=1707936107;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KkEIEK8CKgq80xZfRTNvGvWQr4Tg/ZBdTJOyyMdAAQY=;
        b=o316iJjBcm9sTKr258DosdQqdUAHHOxToml7P6Fp1vp/VRtVQcLNdq1YXTz2Yv8kLp
         shNqvYut3nhEkyn6D3TQXVNFpjVfrYcZWoiW4pA2lWKKgRJncMXSXmzUSbclD8HpN38Z
         kAM8axgh9Mg7FklU8092hB55e7r3veN5Ds7gPy2I+UJznd738MsRqWqElaGtUYE29UTd
         H2up2F6hA9Lh2ekdLfFJG15gz+JeaXOrJA5srB6BiMJFKbhXCW4gEuZ2isvaxW50S084
         /bziM6yZXUcS8The5/prgEDmdSq+N2+Vbbx339wH/hBm0ZQjwadMV7P2wc0VsH0R/npN
         91Xg==
X-Gm-Message-State: AOJu0YzKIwKfruqFIwqKLsJlqvJniCd4VzJYfZfi8B23/5A51TXJN/X5
	tyZguR21btp+sBtrOtueP2AgFoFF5ZhvgkF7U2OMVC+NKoYusU9b7apofHTHUedo7fmUsEdE1nc
	HFgM=
X-Google-Smtp-Source: AGHT+IFMZDY4Sic+/hCfCuMM1OsEE3g8VnN8729RfIl30g80+H3ozLw+mYcFevOd7fqqkn6QOi4OLQ==
X-Received: by 2002:a17:902:d485:b0:1d8:eb2b:7b26 with SMTP id c5-20020a170902d48500b001d8eb2b7b26mr6607896plg.49.1707331307398;
        Wed, 07 Feb 2024 10:41:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWTv1CVvze/Z1sja1l/VsHnf8mVmHdc5UXbCGCybl+5jwMLcQGi96U/JMKVgDklY2VT7vLSx43E4NUS67Way60F5/ig16GVntuMaKzswd+shNTEYzCs+sZO+mylEzDAPCpSJCAy1efkwamywkm4sMYZpg==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s9-20020a170903320900b001d9b537ad0bsm1760772plh.275.2024.02.07.10.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 10:41:45 -0800 (PST)
Message-ID: <65c3cee9.170a0220.b995f.5e59@mx.google.com>
Date: Wed, 07 Feb 2024 10:41:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.304-cip106-3-gaf120b32b886e
Subject: cip/linux-4.19.y-cip ltp-timers: 5 runs,
 2 regressions (v4.19.304-cip106-3-gaf120b32b886e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 18:41:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14903

cip/linux-4.19.y-cip ltp-timers: 5 runs, 2 regressions (v4.19.304-cip106-3-=
gaf120b32b886e)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 2      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.304-cip106-3-gaf120b32b886e/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.304-cip106-3-gaf120b32b886e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      af120b32b886ebb728032aa594bafc1d152eb9f5

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
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 2      =
    =


  Details:     https://kernelci.org/test/plan/id/65c3bd0f13523f2f1f8e1e79

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1=
-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1=
-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65c3bd0f135=
23f2f1f8e1e7e
        new failure (last pass: v4.19.304-cip106-2-g5723c66be3b0) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65c3bd0f135=
23f2f1f8e1e7e
        new failure (last pass: v4.19.304-cip106-2-g5723c66be3b0) =

 =20

