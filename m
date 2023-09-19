Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE174CE79A8
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 22:26:34 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.23803.1695162389657079765
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 19 Sep 2023 15:26:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=RydjhSBt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1c47309a8ccso2066325ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 19 Sep 2023 15:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695162389; x=1695767189; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LMzCjhYKIiVsWHNPzwa8rMlSON7Z7mA28rhsC8K/NJY=;
        b=RydjhSBtvKgiRwBGq1VShxx4hKiSKY9naVf5aQGQULiPZZofuNF9nWogUV5BSZVJX3
         b+LCDKnAK/hY8oWgvrQm6VoYhfbu7XWvasJfv1UncnYbMqqHqCY5ssr0E1JbeMZ++LXM
         ZsHbJyRChXC4+Mj+q07jTIgjHCcKSh0AHs5Unoi3argP6fh0oAfbe9qLkg0wzRi4WFk4
         jLPsNYoTKZ/EqHBjdHMvGBexPjSSIw3uGLnWYMZg49+jG10eGM/ICeQD90QwfWtG4XYo
         sRmJoTcdcunM+qW2k6f3TAXNrHcLU0OA8jVatI6LzU5F98fGpqIAFbuyFqAS4CPXuG6g
         cz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695162389; x=1695767189;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LMzCjhYKIiVsWHNPzwa8rMlSON7Z7mA28rhsC8K/NJY=;
        b=NAZ0oMslm/uv/eiTd91mcdUVidJPU5HuH7fqD9T/2KJ/83inuMN1qz7b11/TPBqbiz
         /my92iPCRcmlUrMkCjL8kC6Lm7VY12SzXhiS4bZYnoVW9zzCtvxaiqcMIqMDxtUVWEcY
         BVX8K8wuUMEpq72ivv4mMVWW91KzY34JrPT6u9HcXQlTmZ/04BNaB7+mrQNENyrTsqbT
         eBSHsCeJZJd0K2bFJaVl3cQSa5t6+gn/GzKPB15wiMtyun86NMKdRFIPbanMDl7T/z0D
         gNfYw6HhGFesbiR5a5cG4Hi5nAA9SyR2G26XreFJpG+pnYbw2TrHPeoBLF6iQkge7YLG
         kQBQ==
X-Gm-Message-State: AOJu0Yz/nk3hMR3nhLONHrUld86+GGMvGJmHh7YrcMaECE06uR8CAXWy
	1H/2jjvM4EgvMjVvhfv4HkMR11k62oZzZHBI+eHK5w==
X-Google-Smtp-Source: AGHT+IFFESyOfl+AK6mUl7PiH92siA0xowg4+AvqLpEwEt1yPBF1wGTDqsbjQDY7KRtwj19iQjDsdQ==
X-Received: by 2002:a17:90a:de82:b0:274:7de5:10c7 with SMTP id n2-20020a17090ade8200b002747de510c7mr4660094pjv.11.1695162388659;
        Tue, 19 Sep 2023 15:26:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090a134e00b00265c742a262sm80339pjf.4.2023.09.19.15.26.27
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 15:26:27 -0700 (PDT)
Message-ID: <650a2013.170a0220.b7f28.0786@mx.google.com>
Date: Tue, 19 Sep 2023 15:26:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.194-cip39-500-gc5c4e5fc16817
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 6 runs,
 2 regressions (v5.10.194-cip39-500-gc5c4e5fc16817)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 22:26:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13166

cip-gitlab/ci/pavel/linux-test ltp-pty: 6 runs, 2 regressions (v5.10.194-ci=
p39-500-gc5c4e5fc16817)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig  =
                | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-cip39-500-gc5c4e5fc16817/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-cip39-500-gc5c4e5fc16817
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c5c4e5fc16817fa66c225fdaa51cf126889d5c5b

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650a0eea3c0e057f278a0b27

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/ltp-pty-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/ltp-pty-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/650a0eea3c0e057f278a0b=
28
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/650a13e224279abf8d8a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig/gcc-10/lab-broonie/ltp-=
pty-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-500-gc5c4e5fc16817/arm64/defconfig/gcc-10/lab-broonie/ltp-=
pty-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/650a13e224279abf8d8a0a=
43
        new failure (last pass: v5.10.191-cip38-29-g9e1aa2001db86) =

 =20

