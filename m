Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4972C10DC3
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 21:13:20 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web10.104229.1701983590881246707
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 13:13:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Y+dxMub0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ce6d926f76so861785b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 13:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701983590; x=1702588390; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RacxwGSDmyKL87l+qeXmMJovoh6mEO2zCw38WKBmSdY=;
        b=Y+dxMub0Qt+iYejqBLpchjqrXe0Xbk4jFYcQU5dVlIPHu9tYrmBjzA699CQHeeoY5i
         xjM3xrtvvg2misxqi0e0ipcWEKLw4qmzzLJeqNKey91IsWNQDLuH+6UOI2wQ5jgEyBkE
         9XgIHxIT+XrMl0FU0VR65KVXhUTEWWwl47ffuqyRMLdOd0svBcTjo5ouylbxgLlIA6nP
         U5YdxoEiD4WVKuCl5GxLCeH/NzicqAICwx5uj5lZFDcttOv3zIiIYqpXhGTOdv73cZD6
         eFOkwLRf6izPd2Z7st9cPP2D9jWCUyjqHk0FRoWebXhhPv+DBMZgxflR5eysZ+R0WcXV
         eHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701983590; x=1702588390;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RacxwGSDmyKL87l+qeXmMJovoh6mEO2zCw38WKBmSdY=;
        b=XylJxQ9YhWitqQQuhCU35titmEWR1tdxocS8CfjLyFiTIuwd9/jn3rU+G6+0605z0C
         QMa5HASWbKHe/m/HDHqUZxIE/wo2ua8HKtZk+qGFrUgKmmqBXfI4N1hSY4CXC1b04xRj
         8r3fFgk7mqVNNHE5X6/YpEbOBLHIa6bP3VJELyclsChLwjSPBsY8pv1bX4urhqqUyx9D
         FwGyuax64CcIuYnVPPwXRhXX+n53uBhlp7yEE4ZLBSaHj8pitruKiZqhJIRYYY/uLMDA
         bZEA200hWRmeueonuwpFp+8HnWAEuxdncvkeOoFeXEs22YYDWnp/4G52rWUdgdmQzGgI
         iGGA==
X-Gm-Message-State: AOJu0YzW1seIreqtbiuCX53E4GM315trf5CujieFx7QWw+tWsviWaPUn
	ioT9dQ9dbJ8lIKu7O2fKbB582gKuM9HQ+VaR0yoHUA==
X-Google-Smtp-Source: AGHT+IFfUNHM/p/QlHbubKCnxf2XNadofo4XvfxvocVY6OD9PweqpSOWqPoBBQOv+w+4G0/idNKm4g==
X-Received: by 2002:a05:6a20:6a0a:b0:18b:558e:9e2a with SMTP id p10-20020a056a206a0a00b0018b558e9e2amr7361895pzk.12.1701983589991;
        Thu, 07 Dec 2023 13:13:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z7-20020a63e107000000b005af08f65227sm216629pgh.80.2023.12.07.13.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:13:04 -0800 (PST)
Message-ID: <65723560.630a0220.5c9ce.14e8@mx.google.com>
Date: Thu, 07 Dec 2023 13:13:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-28-ga386bc478aa6b
Subject: cip/linux-5.10.y-cip ltp-mm: 5 runs,
 1 regressions (v5.10.201-cip41-28-ga386bc478aa6b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 21:13:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13919

cip/linux-5.10.y-cip ltp-mm: 5 runs, 1 regressions (v5.10.201-cip41-28-ga38=
6bc478aa6b)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-28-ga386bc478aa6b/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-28-ga386bc478aa6b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a386bc478aa6b422e6dd5d92a540987ddfca9397

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


  Details:     https://kernelci.org/test/plan/id/6572287799f2ba097ce13531

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6572287799f2ba097ce13532
        failing since 695 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

