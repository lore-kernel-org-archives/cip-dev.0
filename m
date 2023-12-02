Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66709C4167B
	for <webhook@archiver.kernel.org>; Sat,  2 Dec 2023 00:36:53 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web11.8783.1701477409254045429
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Dec 2023 16:36:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=aCkkFFKR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6cdde2aeb64so2608281b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Dec 2023 16:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701477408; x=1702082208; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OcLO/1cdxBeoSjq09F1M6Zfx0vDBEX7LkAUEGIQeIGA=;
        b=aCkkFFKRI5P4+rNl5iG7nUpE5mlmZYCMH1Jrf5Lrh8zaez9lbwUGAYhzXeTzoTmB8g
         8MVtRlEVDccy+GkkMf7C6+aYyLw74gvIhxh03ZGuOfL8pJwQdyZXfJwCeTJtGJ8kmq5E
         5dy7PojlogT89amJogmB7Nir7JM7xYqcYp+23F7X/5zzpqKUx+vIsz3pFb4fUCDOsRvd
         uvHTTabQolFsVWZL13iuVqwMZq1aLytAQcdrx4UuWVWBzMcHTU/yoFBKsV6EwwIfUMpX
         Pl8E8BXFOi7WABJoPPfuo+jNxAzjU7x9LnaMfgBurVylime4p3n+Gil6sSZZuPnkI699
         sp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701477408; x=1702082208;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OcLO/1cdxBeoSjq09F1M6Zfx0vDBEX7LkAUEGIQeIGA=;
        b=cR+pRNFeVAB7vf7PrizPhoNEtvsSLNJEDVyQkO8e86v1KvrXZLJFPLpJZ0gIFX/fQm
         SKbJgc+VfjdlTBAQ0nwCVx65hJI6G79cLGzZLV1CBLSMdFgZ+aP4f2P7En4P5WxNBi69
         KfF8aNdldhiJHxUabWsmtGRw1rVoIp+SK6hPgpg04+IhehKR5uijQZLPNO+OSKXXwOOZ
         8rYEchwYc6RGqyQfn9Ugz4V5pGfFKKqw1Iz/V4oFhUI9SdWzLqWQFz8zeOqmggJti1Ij
         smEcZEzy8BPUkacjNEp95gYK8Uq97mpBZVRMHvMWQUAAZjvXT1KUBfr6g+WxbVlZFj2z
         xr1w==
X-Gm-Message-State: AOJu0Yxg9XEEUkHP8U+62R3YIoQNcnQaYUEkoexptmC0QO59oXk40m8E
	QBlsaEwUrNrGq9hSe1ZxtQDH512PkYC69FtaDPvY1g==
X-Google-Smtp-Source: AGHT+IEEzsdO7ZyGa1SBSJE8XfL41OumqzJy9B0u6w3kFAsZOA+rQpA2YDZjxTW2jdrvxFp+BaRwTQ==
X-Received: by 2002:a05:6a20:258a:b0:18f:97c:6153 with SMTP id k10-20020a056a20258a00b0018f097c6153mr547472pzd.80.1701477407743;
        Fri, 01 Dec 2023 16:36:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g25-20020aa78759000000b006cbacf3bcfbsm3554333pfo.52.2023.12.01.16.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 16:36:47 -0800 (PST)
Message-ID: <656a7c1f.a70a0220.6a358.c88c@mx.google.com>
Date: Fri, 01 Dec 2023 16:36:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.64-cip10
Subject: cip/linux-6.1.y-cip ltp-mm: 5 runs, 1 regressions (v6.1.64-cip10)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Dec 2023 00:36:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13772

cip/linux-6.1.y-cip ltp-mm: 5 runs, 1 regressions (v6.1.64-cip10)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.64-cip10/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.64-cip10
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      6eab166db6d4f9b10eb2993de0fcd289a09024bd

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/656a7175a99e55fd31e135bf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.64-ci=
p10/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/ltp-mm-hp-x360-1=
2b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.64-ci=
p10/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/ltp-mm-hp-x360-1=
2b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/656a7175a99e55fd31e135c0
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07) =

 =20

