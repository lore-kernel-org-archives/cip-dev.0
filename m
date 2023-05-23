Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89ACCC7EE2D
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 01:46:36 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web11.11056.1684806387186131976
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 May 2023 18:46:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=L9uGkXhB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-64d2c865e4eso3477994b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 22 May 2023 18:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684806386; x=1687398386;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gLnz5CVD7vrl5iy2bGdov9vobsCJ5hB4rlMMz5HKSfM=;
        b=L9uGkXhBtJ/HyzA7doOCNJCSJwEasC3pSLSwUF6yJuqmzLxP4iuSY38HVWPtIgcARc
         Axna7RMeFtZRWA03K0ftGXAa//HfWFTILQjeP59ZQgP79iTK3YRzSX+BGI9PWs9Yy2ez
         fKuFno+HQDrGgzzsknMnATZ1RRz7fsNBh28rLCYUAxMOgj2p04i00+4VcsTx4xFAVP7c
         Pr8JsQgrNae2UfiHJ6t/oSDGhOzyg9yJvxhfNDSr6LCfAId+X2LTlI842Suev4MLpPi1
         5/EeUzJNjJj57ZDWAoaUm5/wH3HhX5Cxc4S5Uk8h9WH0gDcA7ZBmj20MnpnlK4j3OOa1
         lguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684806386; x=1687398386;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLnz5CVD7vrl5iy2bGdov9vobsCJ5hB4rlMMz5HKSfM=;
        b=ginS/mxHTEzOkyDyLXFyMXTgchUVPRlF80IoI7VWPkURptAKMYqcpwpuH22GwlngNc
         WIwcrSliMdqx5sNMX/M4sg7idbTHZG6xf+VgAGeVxlqQHvFUFszAO7a8YKiLzRbQHK1n
         3eLxCNu9fKmrhkFMChTruo8y07XSqZYcmVxCKfCIwqXwZlnl4EXsZs4EY9ZxqCNUNS8c
         X4/kBnEBWXjuUAVpfj19fi/ojsoYr6BTnfa4FiDluDqu52WCJabDQW+sWKUB8Gpj5EMX
         pIxUZ0xqGlb1H12m1xdkvI0k8lkA4O1wwV15PqEapoxSW94rpGsJOjrYr8T0j9i/TQt9
         Wyvg==
X-Gm-Message-State: AC+VfDwVG6JZIh2z/Q9bz5DG3egnB2gGLJO7ycqbjHsa37MxHS4SqhNd
	KP7rWh9ZXfvI800hCwUraR4jVQx2K8S1n3fkQXRIOQ==
X-Google-Smtp-Source: ACHHUZ5n1dtGBcfxKpKytQZnfgqWHJ7aJHPzwHVCcZpXayvtKmQgMtaf6ODIQNCLU1p/nLzJjAHwUw==
X-Received: by 2002:a17:903:481:b0:1af:9b8a:9c7b with SMTP id jj1-20020a170903048100b001af9b8a9c7bmr7848837plb.47.1684806386195;
        Mon, 22 May 2023 18:46:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b001a95f632340sm5429504plg.46.2023.05.22.18.46.25
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 18:46:25 -0700 (PDT)
Message-ID: <646c1af1.170a0220.2c05e.9557@mx.google.com>
Date: Mon, 22 May 2023 18:46:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.280-cip95-rt30
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 6 runs,
 1 regressions (v4.19.280-cip95-rt30)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 01:46:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11600

cip-gitlab/ci/pavel/linux-test ltp-mm: 6 runs, 1 regressions (v4.19.280-cip=
95-rt30)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.280-cip95-rt30/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.280-cip95-rt30
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      dcee20e65677ab5d0e0d47c572f2c71dae6074a1

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0cf008bbafb1c52e860a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/646c0cf008bbafb1c52e860b
        failing since 1 day (last pass: v5.10.179-cip32-471-g18129e1b68691,=
 first fail: v5.10.180-cip33-11-gfea7994097935) =

 =20

