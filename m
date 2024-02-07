Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F152AC4828D
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 01:39:37 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web11.10752.1707269971281814499
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Feb 2024 17:39:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Le2zIDIk;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.177, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so46775a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Feb 2024 17:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707269970; x=1707874770; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Uq5HyjFP77sPbJk8c9wEg984SAOMsKDGr0nRUhVl6Bg=;
        b=Le2zIDIkrXDkx5vF9or0mRJCXzfyy1i8I+cjsj82uNo3MvirlRJIZHWi/tlmxXfd+m
         zNJ2cDz/F3UvEiRlcvr7KdMCuLEmIC7Z8E1kPhLB5KFKvsy+NXAbkn5dNS0RwIz8CJVY
         Ax4NKJ+W7LbuBi4P3gNKBFBFzR8E4HObRg6hIsW9Hlv5zzJv6BIOd/87BxAIwwAlwdhA
         WjeqIRvStG/RrNs5BTshl6ZZDXVigxgITV7j3UC4XCDUcneP2SEUJ0UrZp4L19ZczJHl
         5gL2jGtYj2Zezk/oCIVIwlTV9LYQNrCXIQyuVZsj4n3FxWEOXWXTZNhfLbv4xfYvgknn
         S8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707269970; x=1707874770;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uq5HyjFP77sPbJk8c9wEg984SAOMsKDGr0nRUhVl6Bg=;
        b=ClyV6hatiItgKuDq1NgTpb1QNVoRwDkpFPCcvlnAq2R2O6Vt8cyczDco+y0y9c7i7a
         SpyKdswSjcv3WRohaFlZ1maTJr9SkrjE2Xe3hdhyMmBHc+EW30C+xDVs2GMebSS0jbAw
         /88zlViyOX0nvZmmmng0aa6Bgy9KWHhEjD57GtCaf0b4DAOksGl6iy+/HSK6vBo8e6hc
         bmcE/Cdf+OCkH0lL9AfCgdjBlveJBKwA6pV3vLReFDV9qM4R9BmbJvqzVod+Wp2ovWvL
         /OhrDkZK9VNX1lKL4aRK1bxRTUspkd0pm52fs773JyQoe8plf1uZ24BLzWDKvkc6tHHp
         sYIw==
X-Gm-Message-State: AOJu0YwVqUoqse0VGYMb7xjlN6WFOllzRhcDnaQZ9cKZy3kQJOBtrsLy
	Kil0k/H8HCkvlU8wFXKP/quIik7M5otSf7tT8D8IxRNkZw66iI07mQkKeXHXe0fRRf7MHWb6PXy
	F
X-Google-Smtp-Source: AGHT+IHeemuuTYcmEzzzs/qRW0fzB+Jk9Ee6hdk+uZzO15eiRehz7LQHvTyTB7i7gWf43eM/Z9bQ2Q==
X-Received: by 2002:a05:6a21:187:b0:19c:58fa:5a71 with SMTP id le7-20020a056a21018700b0019c58fa5a71mr3480511pzb.54.1707269969977;
        Tue, 06 Feb 2024 17:39:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWyDkD6b7rk+Deu604tjLUMvjTRz77du7KLdDiuG6G2PyPkJ0C6bD95sqYYWXsegwaQ25IuIAXUUY9wYnRe5qEyMjiCJaZpzvGoCarCYL3wUV4FqeuPuWrhHyLaeBvbadD2NkseqDkMQnsEf4ZjehkYEA==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id qd3-20020a17090b3cc300b0028ce81d9f32sm233541pjb.16.2024.02.06.17.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 17:39:29 -0800 (PST)
Message-ID: <65c2df51.170a0220.309e9.0ec9@mx.google.com>
Date: Tue, 06 Feb 2024 17:39:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.209-cip44-50-ga624abaa85d7
Subject: cip/linux-5.10.y-cip kselftest-lib: 3 runs,
 1 regressions (v5.10.209-cip44-50-ga624abaa85d7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 01:39:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14850

cip/linux-5.10.y-cip kselftest-lib: 3 runs, 1 regressions (v5.10.209-cip44-=
50-ga624abaa85d7)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44-50-ga624abaa85d7/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44-50-ga624abaa85d7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a624abaa85d7f3ff289eb2e257db5c4485d11d18 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d36ae5ef229b488e1e7e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-=
lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-=
lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65c2d36ae5ef229b=
488e1e7f
        failing since 125 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =20

