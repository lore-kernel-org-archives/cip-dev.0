Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CBDC4829C
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 18:41:49 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web11.6023.1707331306644054173
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Feb 2024 10:41:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=PZ0YgGAN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d72f71f222so8337105ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Feb 2024 10:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707331305; x=1707936105; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S2kFAe6Nm//iuv5gy14gzbCFpj3V8TiVY43OxyvvLiY=;
        b=PZ0YgGANzUS5xEj7oeveGURw9eBvpQxioSFwMOn+9eEG0DCG70wI8631dZ8uW9w5mS
         QTj0XpIBLYhCwIxEGLNlWoTaCk0SSeDfwf3zo0gyoOC19eATyRr7/M0mlXlxmLNmI0l8
         aFdrmXd4ESqQC6llVV3BhpPHQRHIayeGP8LUJ+0rITPBEYAyCl+zCRZmN07EwHvaonPF
         dpqeX7vQfBSVj3K1TVO+komNcA6CP/fKMADAnaty24ziqrgL7zU1mFXcsilvAE7X1/aP
         44hDxRFPcE4pzkNKz8Du2ypjWtewb/Tul2UBn0mx5eTYMrouSJwLLe4QOQlqw9IcwrKZ
         PRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707331305; x=1707936105;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S2kFAe6Nm//iuv5gy14gzbCFpj3V8TiVY43OxyvvLiY=;
        b=tPvtAbiUqOdqTViQ932H2a3MHyXe7noL4D3C8BjZxKbh0aJN+1fH7q1UCjlYs+trx4
         TcnBVU1f4ucH4GSKwVanIWfokMwWTZm3yqcInqO3DFf8m4MfNHu/vQqfwmsJ1wvxb3ca
         6P3JpWu1Qoend2JMoCal2JdJQ++60wCYfk0FWranULVYVUu8IcBoQd2AZ4oi0hjWUfNd
         fwr8xHZes5yusFK5SXHlycvv9yFG7CyHKUO5eXmytJ0t5WTC+iuKPByrpmkbDl0TUWSN
         NAGQj2bL07IG/0QgimsfH/s54KmMimyOs9uqg+konu+K0AgUmdKMgcdocIvh9zj5LmlC
         QHRw==
X-Gm-Message-State: AOJu0Yw1m3p+DEpQZ7NlOCurorIJdkdLB/J8c6ADv2miLY5SRrsxGZV3
	MRXRpSGykpbC4kPO2bQXINgjuYWWQlqDCnq9CcPqPN7Ik/ng3D58VFl22+L0FZ2SfLE8hy4Wejq
	fpn8=
X-Google-Smtp-Source: AGHT+IHbjbL6UatQ3a+nZ6C3Ek8Qx1S3hrz45uKUKb5mjZR1MrfmQoCCwjLNB5Hq3lJC8CTsv3+oyQ==
X-Received: by 2002:a17:902:be14:b0:1d4:e237:2c3f with SMTP id r20-20020a170902be1400b001d4e2372c3fmr5576375pls.28.1707331305476;
        Wed, 07 Feb 2024 10:41:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUnt8C2NNxJd1LNWxnVuNmKUHb6hVK0wfl1QxCuH92YFYREp79ECqqzWhBJWZwQw9qS0cWh5DDbEBo4ObNY57VvxfIJN91R1LVfAZ6Afc0FdHWCAcvzC9aWOwtYjgvgNWhQofNoeAyErECwrGvX1MAlSA==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y5-20020a170902ed4500b001d9df9589e5sm1793713plb.10.2024.02.07.10.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 10:41:44 -0800 (PST)
Message-ID: <65c3cee8.170a0220.b77f6.5b6a@mx.google.com>
Date: Wed, 07 Feb 2024 10:41:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.304-cip106-3-gaf120b32b886e
Subject: cip/linux-4.19.y-cip kselftest-seccomp: 4 runs,
 1 regressions (v4.19.304-cip106-3-gaf120b32b886e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 18:41:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14901

cip/linux-4.19.y-cip kselftest-seccomp: 4 runs, 1 regressions (v4.19.304-ci=
p106-3-gaf120b32b886e)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.304-cip106-3-gaf120b32b886e/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
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


  Details:     https://kernelci.org/test/plan/id/65c3bc7ea32da6506f8e1e92

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-3-gaf120b32b886e/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-seccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65c3bc7ea32d=
a6506f8e1e93
        new failure (last pass: v4.19.304-cip106-2-g5723c66be3b0) =

 =20

