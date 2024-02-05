Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9086FC4829C
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 18:21:28 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
 by mx.groups.io with SMTP id smtpd.web11.1325.1707157281438071558
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 10:21:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=tu1TFEb1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.51, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59502aa878aso11034eaf.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 10:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707157280; x=1707762080; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PhCj4WLpLogXTbGTPlPJE5L0fZb7iT3hS3s0TwfDygg=;
        b=tu1TFEb1BGpZmFc3D1mmovds8BapAoKC1fNwSn0ccuVKLp0cTNdGqWjqAWzh3uyB7L
         LsRCtC5lV7bCjKr4Yi6kUeh94utLCKikCudxajz5Qt4C/BC5hL83xTWn47FAEv+oY7Qu
         p3jguXXqNkwflaWqZIv36x2/gj3Fdyyo9WgLn1YI5Zg8EmewoEsPLNeobPodjQQ31+LE
         gAqZiveSHEqCeoFckSi9Lhc63xp91ocSxY8A7De/rLgclJlqflF0QXIEyrEnDBJ2Cb+/
         YpxwFbME/fR3ux7gRIaS4QiHfN0ConGq9/AhHJ36rL+Azj6JTV+YRHJRsWLeAMB7EVO4
         1gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157280; x=1707762080;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PhCj4WLpLogXTbGTPlPJE5L0fZb7iT3hS3s0TwfDygg=;
        b=gDOW2qRcvyf1EoOFLLT9spsPgiB/w6Q0i7L+5WCgeOBAskvQURVHoZry5ki4XIQKxz
         Gcj7339MaEf0W+fUp4N4aHGgnDzryDDMOQuc2+TMCiRCfY04O6P76jyJ0pf0icLu59qu
         RsLrCDU+iLtZvQKbgHqCEPFh11Sg+2s7vvVnY8yjMQp5l3kwzcfjJ9ZZUEgU0m3eObyd
         40DNjIhyhcgBFoI9hilfRvRdF3s80AOG8UF0BeGrkvZ/hrRdkl5G0FAp5gWbdme2RENs
         bnOKQiGMOpzKacGlP5Jed28bDhORIM7ZuCKJAgXxz/t1LrUczWcSXWrFpTTsVreBEo/d
         oKhA==
X-Gm-Message-State: AOJu0YyLYjMaiNAvemExjib4jFrvupqAQxMPqlOKZOEcqAFkipIXcUNg
	owEEAQc+KaN87mGpuipbrtI1uGAGQSI11axWDJnVHFPq0KmjL63T03mYHPLXOZLFPQQ1JhAmg2N
	j
X-Google-Smtp-Source: AGHT+IGBay+36ZAOcaisp/uQfJxtpxHjjUcoTPTLo7WH54w0Aw/2r3g7Ji4TAOeGSDRL80rIz8BpJg==
X-Received: by 2002:a05:6358:89b:b0:176:5c73:393b with SMTP id m27-20020a056358089b00b001765c73393bmr746449rwj.18.1707157279964;
        Mon, 05 Feb 2024 10:21:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV+1qlq4uwScTa/8WInGHToArMCTjtKdHMr7IpmPAIDFfSig32ZbZ96hE0GmID3z7F4Q2OhZQlPtxQcOahYv2wRD2fQZ5o4jt9eQSixvYn6mBPG7AHHPrPvSF6A6+qHMy6z2hDxP1g3xniBCpKCLN43PQ==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id by35-20020a056a0205a300b005cf5bf78b74sm295197pgb.17.2024.02.05.10.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:21:17 -0800 (PST)
Message-ID: <65c1271d.050a0220.5711d.1f37@mx.google.com>
Date: Mon, 05 Feb 2024 10:21:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-fcntl-locktests: 13 runs,
 2 regressions (v5.10.209-cip44)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 18:21:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14749

cip/linux-5.10.y-cip ltp-fcntl-locktests: 13 runs, 2 regressions (v5.10.209=
-cip44)

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
l/v5.10.209-cip44/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
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


  Details:     https://kernelci.org/test/plan/id/65c1181ada23d125a300a060

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-fcntl-locktests-=
r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-fcntl-locktests-=
r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65c1181ada=
23d125a300a061
        failing since 124 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c118d6fc59e3c74100a04d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-hihope-r=
zg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-hihope-r=
zg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65c118d6fc=
59e3c74100a04e
        failing since 235 days (last pass: v5.10.182-cip35-1-g7cde3fba93966=
, first fail: v5.10.182-cip35-8-gdba81ae6f2be) =

 =20

