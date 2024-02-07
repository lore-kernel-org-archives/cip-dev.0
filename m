Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E036C48297
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 01:39:38 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web11.10759.1707269975184843911
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Feb 2024 17:39:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=PhgPW5Aa;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e05f6c7f50so96839b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Feb 2024 17:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707269974; x=1707874774; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sWC8zKXngeYu2tPHs2p/U4A42zkgzUDYXQb8Fwy3Ecw=;
        b=PhgPW5Aa6ReOmlte7Z72LgFKtROh2dFCtni6bE7IwtNCCq2MKW5n4Bbkq+Je21omHG
         DSXuewNcfsL/H2CHTRV9V+1f3et1IPFa8c48iRydOJqUu8VMK66apJteFydfDcQw7IGS
         o0RjmoOBrXkNKCnLeZ+WyPm1+FaDFB5SQVSJyJHmW0tJSMSr99fPipSjXxh6mLtwjDDQ
         ZQp/3y8IF56vkobEs3LPZV/mq35tY7bt7ayfS+MSi6Q0LedAKjFqj/j6kB+f1M8raQZA
         dCwqHP0jgHGfQBSoIcNAf60vYjrnGMQKtq2IZ1O3xRPSuLj7+KwHSORjT0c0nEOOKsO8
         s/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707269974; x=1707874774;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWC8zKXngeYu2tPHs2p/U4A42zkgzUDYXQb8Fwy3Ecw=;
        b=n4KQ45Caz2ajsq0dmWLrJK4d1qQevoWaGAV2zOteQLDGzx5g1ZEMH9sMR7ljsXO6js
         HF/mefmKsITLcS8VIpCx+tPZV4PCqitLU3FnH/3Dx8gWJ6V7sH/2HZLdwfoxssCw6Qke
         8/b6qExholWUOIe7J6U8mhdBi6m6v+DxwlrWj2wm5fUvGBdc5TgTVjt9q7jKeS0Ljamk
         9Fs1ZmUy+fs2aYSY+CxPTruCqNytdElJYLJGsJURkhb1sDAfabt7ijcv/i7ipJV/ntfo
         Cly2CD7ZZ5cGWynKNfPDQvSJIYA5qUFiKeIjjbgDgOr3X9nsajyHECtDByRElqAvsUvL
         1nHQ==
X-Gm-Message-State: AOJu0YxCKQABXzMXwnZ3HCwEknOAA5ayR21E1PAzSak//6JkAI2DEiMm
	pkPc8l+9GG/pjcYx8i9rhrh0xF6gcfICjKQOgUV2XEgeYZk/fDJo96tluI5DI/UIoRNfhkRT6Mm
	j
X-Google-Smtp-Source: AGHT+IH5muFa6yJC/nYwLT+FFG8RNIloDdjQwzghb9dpd2t1TeW48pjdFxBPka/rc20BMz4F3ewy6w==
X-Received: by 2002:a05:6a20:d80b:b0:19e:99fd:3f5c with SMTP id iv11-20020a056a20d80b00b0019e99fd3f5cmr3416405pzb.25.1707269973988;
        Tue, 06 Feb 2024 17:39:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUnybJnlLaCM8IMvNJSXwovGXbj3cSfWRj3xg7ZfaPPGRrn+qYktQOgw9A7ShA5A9bKmvX/mPLnE7gy29v8cn3MiCfF/iwP3jrS3AkavJiOgIqNXtNLJGXxwqPXMfb9Zx8v86vDxKZiabostAKRZtDlHg==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090a728800b0029668aee138sm2446808pjg.40.2024.02.06.17.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 17:39:30 -0800 (PST)
Message-ID: <65c2df52.170a0220.c8659.9274@mx.google.com>
Date: Tue, 06 Feb 2024 17:39:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.209-cip44-50-ga624abaa85d7
Subject: cip/linux-5.10.y-cip ltp-pty: 10 runs,
 2 regressions (v5.10.209-cip44-50-ga624abaa85d7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 01:39:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14855

cip/linux-5.10.y-cip ltp-pty: 10 runs, 2 regressions (v5.10.209-cip44-50-ga=
624abaa85d7)

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
l/v5.10.209-cip44-50-ga624abaa85d7/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44-50-ga624abaa85d7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a624abaa85d7f3ff289eb2e257db5c4485d11d18

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
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d0cba3fd9811da8e1f6e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65c2d0cba3fd9811da8e1f=
6f
        failing since 88 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.200-cip40) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d386e5ef229b488e1f18

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65c2d386e5ef229b488e1f=
19
        failing since 1 day (last pass: v5.10.208-cip43-4-g1c63c70fb18b8, f=
irst fail: v5.10.209-cip44) =

 =20

