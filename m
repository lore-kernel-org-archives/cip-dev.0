Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F650C197A0
	for <webhook@archiver.kernel.org>; Mon, 20 Nov 2023 11:21:49 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web10.48100.1700479305165773827
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 20 Nov 2023 03:21:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=hbmXGf8m;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6c115026985so4392067b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 20 Nov 2023 03:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700479303; x=1701084103; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oLu2hKaYNVRb644SqJHmRwcxpDBkGVwD/HD20gGyQco=;
        b=hbmXGf8mKwNM5nh8cJcD6nMBFOcq4sjrB2RMAaoyvGPiqaL0KM+o1BWoSMeqb2kmG1
         WSYYsloGLX7/Rm5MI63OKsA1qf3bJYWnQQUKS1PXBlA2gdkMQzXGlbQe4URK6H9Y69d+
         0tBgcOANvegugfGXTmDjLX6w2c9S8IkHvdd5tR7g4pq0pUM6hpQW/0DXg3mMMAzbQJKx
         /kKEKrpxYFvwgeHIbsnt73if6De3T4iMhbu+sTSakvuCjt29AvPQ5ucghW6AyU6Zrg1m
         qUKkbejqI7RnAEBNrgv0Y4cqKSUJbNGUeY+CYreY+E4FsWSRmLqmg+0cz57f+1haNd88
         Ff9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700479303; x=1701084103;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLu2hKaYNVRb644SqJHmRwcxpDBkGVwD/HD20gGyQco=;
        b=L27FvMDgUJvVvqvlDl3u+9q2TgfXNrqy+B0CI7yw8GzuOcKBPEIWKv0MOYFDPsRE8Z
         OJyJS8yR4Kp6eYAdQ5039kD9cU0RFRTY80Tnq09NVpW+rFfRarw6Twz0hgxcsG6NPpEo
         mPuZcYjQPxCAijF6J9MhHMngpSVj8kyEKoZZy8RbWcVDaax41iG5u/J1XYZMQoK12zKI
         lkCgBZ9wlFv10gt4wsLJnamwI2ToVH3x55Wxu5IJQLeYM/Da8KTzZM0fRTYZU2LNgnKj
         rudYalKoqatOMXsFdrM8apsOwGY/qlz9nLWbpBcwf3iObOILeVpe0Jo0HBdU2cM27R86
         oXlQ==
X-Gm-Message-State: AOJu0YwrBIpLwiodvEiVcwwqbdkAfDP6pgaH9EXk5KPoeQofkPx3fCPJ
	8JvEEoCyodU5BxLNeQs0xsSdKxfJDqjwKCnunV8=
X-Google-Smtp-Source: AGHT+IGgCIcF+JM7hNI70tUV89m6tvrmPC5qC5MZCgD3FgUEHH7qqDMBcCBqXywJr3sQZCLlY+MbUA==
X-Received: by 2002:a05:6a20:e588:b0:187:9521:92a7 with SMTP id ng8-20020a056a20e58800b00187952192a7mr7624859pzb.18.1700479303400;
        Mon, 20 Nov 2023 03:21:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c20-20020a056a00249400b006c0678eab2csm6018646pfv.90.2023.11.20.03.21.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 03:21:42 -0800 (PST)
Message-ID: <655b4146.050a0220.ca788.e99d@mx.google.com>
Date: Mon, 20 Nov 2023 03:21:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.200-cip40-513-g195b5d2b5c744
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 9 runs,
 1 regressions (v5.10.200-cip40-513-g195b5d2b5c744)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Nov 2023 11:21:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13600

cip-gitlab/ci/pavel/linux-test ltp-ipc: 9 runs, 1 regressions (v5.10.200-ci=
p40-513-g195b5d2b5c744)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.200-cip40-513-g195b5d2b5c744/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.200-cip40-513-g195b5d2b5c744
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      195b5d2b5c7445a89862b44b490b78e540906e81

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/655b3542703cd04e157e4a71

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm64/defconfig/gcc-10/lab-broonie/ltp-=
ipc-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.200-cip40-513-g195b5d2b5c744/arm64/defconfig/gcc-10/lab-broonie/ltp-=
ipc-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/655b3542703cd04e157e4a=
72
        new failure (last pass: v6.1.59-cip8-106-g65bd536c294e) =

 =20

