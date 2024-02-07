Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95119C4829A
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 18:41:49 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web10.5934.1707331306337494331
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Feb 2024 10:41:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=HNkJIiJs;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d746856d85so7823485ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Feb 2024 10:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707331305; x=1707936105; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C1O8V+bEua2Q0GgZpRD6NKAtImsGSFY1OAQMOI1f1wk=;
        b=HNkJIiJss7pFeKuI1M8yc/RCMVbCXhPZGxcGglOxEJxgWWimrCNi6IXmKE6UkzgoMH
         KPjS5dGA14S1+ExE2FscQwYOHhhHEkjy396uMCvP2f9o4LhhEIG7uSEMpv83Dh57/3rN
         t0lfitKRGracS+77oyKFhFhl+2v8l2xZLeCppxnXKKn1D+0XSHNuqjFU9r5u+YxtrhcW
         /DHStn1MEr77hnJtAHl9rY5fu4KHVgY/SYJ0MR29mFqIia39txin1MadfwDBjmilyTvD
         +ogaXmfMVQY76R8GXi2uqk+kEMF6YumZ0BCubsGGTKWfrhf4JErgkKwV1ZOYUpJzjnpx
         w3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707331305; x=1707936105;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1O8V+bEua2Q0GgZpRD6NKAtImsGSFY1OAQMOI1f1wk=;
        b=iKL+56ib9kAXxbP8quxuT63DDpUORgiMpX532scuXyLzcpX6RQ553eQIrL1fqkZywL
         bxqDfqw+HUavcxMUWV7XzvY36fk/nbNpAa9E5wsj7O4VdjLmxkJkiBE7WTjRPDfVZHLs
         sYKZ8f3FcMpcHcBj9WFzuWpPHztutvoPyyrAhbGaElOb4WWs2mfZ6W4wV2o0XykKa+wv
         bB3YCH83yYQH8JvVFiG0/fKlJ4mTXFd3IPldXEwY/+lX4Tgh0xo+6zGOVeXPOXpZRHJn
         jKOygEvlXZphiYg7u0tlQ2yII7kZTdTFmN4Dda+mpm9htDuRuqpqG4jhadMXM2WRaOKf
         lP5Q==
X-Gm-Message-State: AOJu0Yz81SyPuw1FvQChyWPVSXKHbunfaTOo+ZYKFWuswl86+yDtlYbQ
	C+PPD9Wq8UEubKLsgjo3pMknssw/CZ616y/mn2Md188m/mYSPp4HYW/EnyacOBR/1MyVUVx6HD2
	Zrlo=
X-Google-Smtp-Source: AGHT+IHD2qpJig/HI9Kymg57uHFzIC5rADcWPTRKYPDA4vnzmKfvQDSWJ28hUxlDi2u48QxS3/6RpA==
X-Received: by 2002:a17:902:ed46:b0:1d5:bc5c:7b6c with SMTP id y6-20020a170902ed4600b001d5bc5c7b6cmr5464347plb.55.1707331305142;
        Wed, 07 Feb 2024 10:41:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXzFDqA9oTXEKnTTGffWYK45LlAWv4XsPrQ8xzHt0UqDEW731COPCUFY4MgKggbEPJhPXkuBA3PhGnmmHtDHuEV3gowkphv4bjR3ZX/L4+41I/qqlFxW6QevwgUS/t5tZ7AX93jnYJzqBLySLcSHhZv3Q==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902e84200b001d8ee19ab34sm1782029plg.29.2024.02.07.10.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 10:41:44 -0800 (PST)
Message-ID: <65c3cee8.170a0220.52d0b.5c32@mx.google.com>
Date: Wed, 07 Feb 2024 10:41:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.304-cip106-3-gaf120b32b886e
Subject: cip/linux-4.19.y-cip kselftest-lkdtm: 3 runs,
 1 regressions (v4.19.304-cip106-3-gaf120b32b886e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 18:41:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14900

cip/linux-4.19.y-cip kselftest-lkdtm: 3 runs, 1 regressions (v4.19.304-cip1=
06-3-gaf120b32b886e)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.304-cip106-3-gaf120b32b886e/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.304-cip106-3-gaf120b32b886e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      af120b32b886ebb728032aa594bafc1d152eb9f5 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3bc7cbf013521c98e1e87

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65c3bc7cbf0135=
21c98e1e88
        new failure (last pass: v4.19.304-cip106-2-g5723c66be3b0) =

 =20

