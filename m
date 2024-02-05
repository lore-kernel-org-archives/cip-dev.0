Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F08C4828D
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 13:44:07 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web10.63108.1707140638476291537
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 05:43:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=L2tFuQhk;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-296a79e6295so414555a91.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 05:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707140637; x=1707745437; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LchYiWmmrsAgGVlBA6vLfBSl/dZwHHY/Bj2mMkrxIWU=;
        b=L2tFuQhkaiLN4F2fIplMJcy55z5c0v2SIPHz3keS9trrwRgKyoCBDJG0brN/8Hvkta
         iw7vPAyd1huu/RHOnzBcx6ODOdPdwnIF+rzkTYRLpVDH2i4hv/09zAMtHnf9ZaclZBW6
         h2109wowtB6gmdcD7RdFdj0E0x1BHr16/TLUD0CtSMjrb5CcNUvrURJdXPdcYSXKx4ox
         V4dL49JqXYn3mLxKqE3dIx4zxF0JAR/63hwvFpeNb9noa7xNOUkHuiTFdejuHljq9aex
         U+McRUJG9iEjYwMaI7kJYdCuCIJP0bOHH0vkT5sczxBGMyH0XKaHC3TmdD9803GCaSAv
         ByhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707140637; x=1707745437;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LchYiWmmrsAgGVlBA6vLfBSl/dZwHHY/Bj2mMkrxIWU=;
        b=ZW6ZVZaZsjeFu3EH7uJ+LKDyhB6yNK4xGHj6XmUvQeg3uQlWlE22Cbh8HeQK0acW4H
         hyAhpuao4BFVR0K9ERqZ3YMTZT9XqCT+wbRLURHXVZVJ24QPg6yKeMnxLEo5M9OGvYJj
         agZAbg8APjX8V9QYdYM4YpTefy0/dCt6aCqrprr5wKBtieHluRrz3Ge8Nyvd44kgQ4Ol
         7hHY5uc/g1MUOgzeM05eezXgwJZXzlLC4PPL2XfOpuIS/WE58IDmBGifkBX+aJnB/fze
         91RbOPp7Jfnq6/SfQclp60QzmRB0q2t7lZMqUnUV9g/TrF/Ma8xo8OCahtK3D0nrzXaW
         AsIA==
X-Gm-Message-State: AOJu0Ywifo3TyBhYBkO4Dnqs5OeyGxC9pm2uf5RKrppm5OBirnewBweL
	VODpXIZ82DFXCvFMIpKc7Jbkvg8KFOV7LKduNlBk+Ct7goyB58FOzVf8uFBVCoHR84Fb8pSEYad
	h
X-Google-Smtp-Source: AGHT+IFGJ7DS+wDavfusJ0IyNFxi+D6uMqhn4aOSQSgfmVvKyuS4D4HBQArTfPhN0hztbAgzjpF8VQ==
X-Received: by 2002:a17:90a:c596:b0:296:5ba4:99c9 with SMTP id l22-20020a17090ac59600b002965ba499c9mr8186466pjt.28.1707140637323;
        Mon, 05 Feb 2024 05:43:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t7-20020a17090a4e4700b002969d5db646sm1986994pjl.9.2024.02.05.05.43.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 05:43:56 -0800 (PST)
Message-ID: <65c0e61c.170a0220.28055.515e@mx.google.com>
Date: Mon, 05 Feb 2024 05:43:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.75-cip14-6-ga817aa655908
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 18 runs,
 1 regressions (v6.1.75-cip14-6-ga817aa655908)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 13:44:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14725

cip-gitlab/ci/pavel/linux-test ltp-ipc: 18 runs, 1 regressions (v6.1.75-cip=
14-6-ga817aa655908)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.75-cip14-6-ga817aa655908/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.75-cip14-6-ga817aa655908
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a817aa655908e54b6999ed3d0663c3f370d059ec

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


  Details:     https://kernelci.org/test/plan/id/65c0da2fa69686cf3000a03e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a77=
4a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a77=
4a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65c0da2fa69686cf3000a0=
3f
        failing since 5 days (last pass: v4.19.299-cip105-1134-gc868d5e4ada=
a, first fail: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =20

