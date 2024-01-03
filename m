Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99329C47074
	for <webhook@archiver.kernel.org>; Wed,  3 Jan 2024 08:43:03 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web10.13768.1704271383070419921
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Jan 2024 00:43:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=1LBEiOmu;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so4330897b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 03 Jan 2024 00:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704271382; x=1704876182; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=12SBhIiQaMJJhCJpIgVZMDDcrz5hIAfFrQghbRGTKkg=;
        b=1LBEiOmu3WNmGk+Br5DpbdfKgoYo8exW869e0ah75rpUsl6nbtjTK59ThoQf8ymRt0
         2J3LZWLLiGJdgl2DXjjVMflTgf6Ief8oJjs9uBjMIhl37kZoJzvDeht+ggFKA53V+FHF
         KFxHBnbMauN9nlpmUTJ90n/McmBEMQYUH9HbysEDdfTNyeRMSwNBeEGCykPKyBTiQgGO
         WXeTYjeL7EsJ4RO4617zxSj0WvHwPTdsDAbUV/DWNL2R1mx0Y38MJcAd+vwQkmvWU14E
         tEWCjqbnZcHAFe5omhJLFJubAASXlykHxCWEOAEKP1lBIgTyxzGpkO0/ofEY9vYUE1Co
         fgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704271382; x=1704876182;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12SBhIiQaMJJhCJpIgVZMDDcrz5hIAfFrQghbRGTKkg=;
        b=WelEKsS3Xmhd9BS8YJ9zPuDw/daMczvzM4eHFIkhR+C2e3kZHRbZCnESZZnQwk+DUh
         RwwAJiOQxByjNLc75Ge3rt92sds4MAApmnalMZ/zBGTy9DqgKIaDtGHdZP+uCRyC63UK
         Xxy0rqD8Q39Vx8A5PFKsg2nTPNXYFDzn7Cx2RRAlIuei1jNt1SxiRixqq1LLfaPuxMLW
         yN6IFoJ/hV8fsavqAb4UM3nml4XLn7I/iCoMKAaAQ3N0LP9hH10TLywgi4FuZ9F4ALCF
         ihghFzJb7WVHq+Bs3G/RFBqgh2RIE6+1D9u6sO0dVJxhiLpcAkBhkXLGVPBTStQNFXZu
         rK8w==
X-Gm-Message-State: AOJu0Yx3g7e7Qu5y7uiK7hVJxXMaR1QGVOwOPDMGhIUVHoQIQ4k42pDO
	hdjFE+eX1dMSIZygNsE3tBJFZkJ6sRaTJD7DfT58zqA/HeA=
X-Google-Smtp-Source: AGHT+IESRrbVta2wwxBf2PhGYG3O8uXhPS5e8C3mOghupYuqOE1Jqtq1O7B9SE2LgKvHk2XOG19bYQ==
X-Received: by 2002:a05:6a00:22d4:b0:6d9:aab8:a5bd with SMTP id f20-20020a056a0022d400b006d9aab8a5bdmr19773754pfj.19.1704271382002;
        Wed, 03 Jan 2024 00:43:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x37-20020a056a000be500b006d9c16b2089sm15450980pfu.188.2024.01.03.00.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 00:43:01 -0800 (PST)
Message-ID: <65951e15.050a0220.5958d.e801@mx.google.com>
Date: Wed, 03 Jan 2024 00:43:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1224-ga0ac575eeff8
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip ltp-fcntl-locktests: 3 runs,
 1 regressions (v4.4.302-cip72-1224-ga0ac575eeff8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Jan 2024 08:43:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14242

cip/linux-4.4.y-cip ltp-fcntl-locktests: 3 runs, 1 regressions (v4.4.302-ci=
p72-1224-ga0ac575eeff8)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-1224-ga0ac575eeff8/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-1224-ga0ac575eeff8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a0ac575eeff89882d3aa16d67979a86e668f5d1d

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65951170acd237142f77b59c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1224-ga0ac575eeff8/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1224-ga0ac575eeff8/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65951170ac=
d237142f77b59d
        new failure (last pass: v4.4.302-cip72-1187-g657481329b53c) =

 =20

