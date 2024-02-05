Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6525FC48297
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 18:21:28 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.1331.1707157283818081649
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 10:21:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=etVmn4nM;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d94b222a3aso38624125ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 10:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707157283; x=1707762083; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R3+xG4GCjX0smfPyv+b1UxRI+Z0CefsVboOPbfnhhrc=;
        b=etVmn4nMiyBrzCkmjidNT9MeI/2GyS9gx2ae4+In6AVrogQRWCMTLlwcEC2u/cu5rs
         7yE7GorPU4JS+35OAyNHKY1u3U/eZHHGSrM4P+2Muzqq+NP8+Pvmz+mgXMMMcj84ljio
         oR8b3/FP9RNawmBue6lVT9YGaKW8oHHzbnvhVsSjKqDGCQhlGbvW0fBpw3MU/aO0Vzwk
         bvXaJCnvwq3DS8QaD0PNO/kI3ESlShR8RGeneG49Cs6Ml4FVALYnEfWwaZ+jRPNrHhZj
         w8N6vykF7tEnus3DbXZc4vGLIxIkBmvpMjdHbZDVGizNY9NwOZDnZVPuamj1HZcmTLVl
         XUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157283; x=1707762083;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3+xG4GCjX0smfPyv+b1UxRI+Z0CefsVboOPbfnhhrc=;
        b=TEOqpY1G/UsDOBUCQe1tn8Q6/gG49AKnfCutxul8CYGsWi8B1VJfLde5qTx0JWboAx
         9xH/eZK/IrDbAphK0Qdbxcte4K6pJiWvcjTix4wEyzYjUxFwk4sJdB8V0WlQv5xb//lV
         iphoIrVQ9qedtRdc+dUe0bMbNyR6+at7Bc7m2hDQRehacj764VCYWWejXoYm74VlW+AN
         9NTqo4i2ZNKQxzVFGsosX5KTGkKaN9wDRmltGapQzTrSD4Yeavv/Dwk7qdn90IWj+NTZ
         8T3MlY/6wFitw/D5YgS0dkv3RZ4NAPXLE7Aeld9/7X8+WCBeMA8h/b19WJin54WY23an
         1oSA==
X-Gm-Message-State: AOJu0YxvxZ5AGJeVVL9ZDbfuoStMMG3wEs2YEr0mtSEsgiVh/pteMMyD
	JDtVSpIu63yjoi9pCQJSJ4WeiinBq47SDc01b57hhegizVeXG3wA2FBaSbHaSFFdfTva0d14UsM
	8
X-Google-Smtp-Source: AGHT+IE0zTRHFA09jFo0FKXaykOOon+S3eBBQdjsNz1ANFc5iSwcQnByhtnjUec+eiXCo2gR4vh0hw==
X-Received: by 2002:a17:902:ce81:b0:1d9:a7b9:313a with SMTP id f1-20020a170902ce8100b001d9a7b9313amr298105plg.47.1707157282965;
        Mon, 05 Feb 2024 10:21:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVIZ4vkbXaP8hKEw8pkCK7BQOu6rZUDVk0VcHBOjyYjEmoOCm2lvRFUVN/0l3zQV2GnbHblLGb1o/hOfQP2mSNvbKPa6qPnSvdD/RNZpzoM5wdDR+4V8jTD8V/gMq10KkP5rmnDGcMUpBm6QnBd+3DoJA==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id mn8-20020a1709030a4800b001d7207fa2a7sm165218plb.152.2024.02.05.10.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:21:20 -0800 (PST)
Message-ID: <65c12720.170a0220.9f33b.11cb@mx.google.com>
Date: Mon, 05 Feb 2024 10:21:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-pty: 11 runs, 2 regressions (v5.10.209-cip44)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 18:21:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14753

cip/linux-5.10.y-cip ltp-pty: 11 runs, 2 regressions (v5.10.209-cip44)

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


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2fa4c25ee66abaa707e8d165c790bb96e883cca4

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


  Details:     https://kernelci.org/test/plan/id/65c11770fc69b046d500a07f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-pty-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-pty-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65c11770fc69b046d500a0=
80
        new failure (last pass: v5.10.208-cip43-4-g1c63c70fb18b8) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c11b26b046eaec1b00a0e1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65c11b26b046eaec1b00a0=
e2
        failing since 87 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.200-cip40) =

 =20

