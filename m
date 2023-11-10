Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02499C04A95
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 07:16:53 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.23088.1699600606740823772
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 09 Nov 2023 23:16:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ASfsvwM8;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1cc316ccc38so14972285ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 09 Nov 2023 23:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699600605; x=1700205405; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6jPT6IECMpbBDvti8TdDmJsdH+/3UgHpDeJEi+ZGEmc=;
        b=ASfsvwM8UGjxXGISuUePabBnGN3uPDA03N9zBr06th9JFCikftBZgL2EY7dSlToJMK
         c0Q22MR6lsRx5A6a4NuWjYLKyqDJMZvGt1EI8sdIswQ2IdCduiLHd1lOCNMFnsO7EJFP
         zLQ/uK7cqFXmXHe/D6ijDP79/fxVJIg7XKQVTDYTNd2wMmSiT3/CF+nYheH0jGbYQnOi
         K95ThY9Wfp1bBpwavq9T+gdlXY4RqZDIt9QKxrMsBaBfz37XaKbKX2AMcOvU4edGVd0n
         PMmDVdMzJhVkaJm+cIYNrEwjofRxAWTJsRNuyl96qIBdc4UVieZNaPM+QfwZljxgYBAh
         b1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699600605; x=1700205405;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jPT6IECMpbBDvti8TdDmJsdH+/3UgHpDeJEi+ZGEmc=;
        b=DOk89W7ZuSzaE2i2aZA/lRG44Say7SxQ+Xz2zsu8SQwyaqMajlAEQg/IZ40DZnKE37
         DKvKkZgHKAenStS0H0LHvv3d0gbi7QfQQ7PGXGyZILM0rGxjScfu0DfbP0o0ZevgaoUR
         MjImGwna2HUEHehKwJI1r+r2fhhP8iMwHW4Y7FQfY3eAWa38ui4QsmUE1DxDDdSEnvL2
         LXluKpuWie/uDHqesv5vr/PlWOcoCgzyCuQvLkgCjIBw65T+TAuVcW+ZbKFxeFJNYic4
         0USK5SCIMODfpe53YTAle9I7yUiCfWxqgD/qzkAoYiaKzEiyEF9VC05j+xjTmbbsrOfS
         TL/g==
X-Gm-Message-State: AOJu0YzJ+bGUtqeXkC8KjMj1MzGwtJi+HWACaJ/J15ipVQmN/AGzynpJ
	APoMABRv8YEUiInNf9JKhXU0Nzq8NOA8yYJ4ET/e1A==
X-Google-Smtp-Source: AGHT+IH7no96dl57fedub1Mm0wnWDwDoLKxw39uw0dN1l7Ko3Z9j3tlfIbyttbMYW13WvRq0EiI4Dg==
X-Received: by 2002:a17:903:44d:b0:1cc:5a1c:3da0 with SMTP id iw13-20020a170903044d00b001cc5a1c3da0mr6498128plb.63.1699600605264;
        Thu, 09 Nov 2023 23:16:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ik26-20020a170902ab1a00b001c9c5a1b477sm4769598plb.169.2023.11.09.23.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 23:16:40 -0800 (PST)
Message-ID: <654dd8d8.170a0220.47b0f.e8fa@mx.google.com>
Date: Thu, 09 Nov 2023 23:16:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.200-cip40
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip ltp-fcntl-locktests: 6 runs,
 1 regressions (v5.10.200-cip40)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Nov 2023 07:16:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13562

cip/linux-5.10.y-cip ltp-fcntl-locktests: 6 runs, 1 regressions (v5.10.200-=
cip40)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.200-cip40/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.200-cip40
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      166400a23a22e665f5d880a99149b73abede402d

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
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/654dcc0c457d6b7890efcf95

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-hihope-r=
zg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.200=
-cip40/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-hihope-r=
zg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/654dcc0c45=
7d6b7890efcf96
        failing since 147 days (last pass: v5.10.182-cip35-1-g7cde3fba93966=
, first fail: v5.10.182-cip35-8-gdba81ae6f2be) =

 =20

