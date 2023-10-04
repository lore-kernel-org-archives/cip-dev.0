Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A898E7B5F9
	for <webhook@archiver.kernel.org>; Wed,  4 Oct 2023 12:23:01 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web10.16885.1696422178010721156
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 04 Oct 2023 05:22:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=kRmtmgLt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1c3bd829b86so16253945ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 04 Oct 2023 05:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696422177; x=1697026977; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uNxybEQ0Y+MIAcq2jm2TmqllVdsZ5bFyD/gaoKrRQfE=;
        b=kRmtmgLttCMkh1G7DEjRGnCTW9C6zhLBKgPQOgEIkarWj7kWKmz6iTZZkUZNnxpIu1
         lU8jCSwLMV1Kb1GPfpzbWlQZDqhQET62kXiHQPV6sskKfp4Llt+MLTi1V7atBt3gsXjl
         QRGBjNM5j7WTFiyHQzqEz9NOzaUTaSsSM7vxqdkmGWOkio0cdoC9tP9ipYGS+G0ix54A
         +NDsjayd/jI1nt8J6/x6SEAgcosPSeZQs9wnmPr2AupjpCg+xVisz6HJJB5qaWLiKfH1
         uhltKxxsrm0riLeUnnXWgyPxggX9tkcXlKLnHvmW+k2QEWwGQYLz1NTRJBPvlCJ/On+G
         cMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696422177; x=1697026977;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uNxybEQ0Y+MIAcq2jm2TmqllVdsZ5bFyD/gaoKrRQfE=;
        b=JmYbxJ3F8if8whah3KIgeY23lcHiaQZwaljxnHfq9Kt2NlNk0mo3zq1BJ8jqbQWa6B
         mbHEdq1zaIXsnhnIbRohmawy/zDdp8n9hYH5/dWW76w6+XnyGhbhJx9Pzxi1Z1ALjJv/
         lmOFQf5b667rWqDP1RhlQrx0n6d7kV2Sf63v8LDYLTVkjfyoOdONTOrQHemakVdzL6tS
         o9WnQi1pPKJD2qi6cjqBEh6wa3jYqE4cuL+E5HxTrmx8A0/m3IjXYwSwxxl1J6uPgTrT
         a6zSsUfsNgrCZwHdcN47Fb/yoJQkT43J1djoivBCKz+IbO5FZHrnbNLckJbDGtGI8F+2
         6jWQ==
X-Gm-Message-State: AOJu0Yzf0JbgL0EzmwRq0k2+eEinw0VxGUZrnbqmkCR4wVkt4S3bHfgJ
	RFf2Ya/gYDbWVazvpwWTbaMqlBTBTVwaSjpCtZtEQQ==
X-Google-Smtp-Source: AGHT+IHfW4zAVwRLnoxqvtX7rjre1s/i+1E1NjEgWW+nbfcZqSHxVT70kOEAkv2CiNpgLmmpfC8v7g==
X-Received: by 2002:a17:903:110f:b0:1c6:25c2:e784 with SMTP id n15-20020a170903110f00b001c625c2e784mr2652780plh.35.1696422176868;
        Wed, 04 Oct 2023 05:22:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902eb1100b001b8062c1db3sm3566667plb.82.2023.10.04.05.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 05:22:55 -0700 (PDT)
Message-ID: <651d591f.170a0220.e230.950c@mx.google.com>
Date: Wed, 04 Oct 2023 05:22:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.194-cip39-1-g53e59f50ca3ff
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-filesystems: 10 runs,
 2 regressions (v5.10.194-cip39-1-g53e59f50ca3ff)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Oct 2023 12:23:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13279

cip/linux-5.10.y-cip kselftest-filesystems: 10 runs, 2 regressions (v5.10.1=
94-cip39-1-g53e59f50ca3ff)

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


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.194-cip39-1-g53e59f50ca3ff/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.194-cip39-1-g53e59f50ca3ff
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      53e59f50ca3ff023b612a48397ad7e057a9fd408 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/651d4cdf326fc8869c8a0a46

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-cip/kselftest-filesystem=
s-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig/gcc-10/lab-cip/kselftest-filesystem=
s-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/651d4cdf=
326fc8869c8a0a47
        new failure (last pass: v5.10.184-cip36) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651d55128b68a54c568a0a4a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/kse=
lftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/kse=
lftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/651d5512=
8b68a54c568a0a4b
        new failure (last pass: v5.10.184-cip36) =

 =20

