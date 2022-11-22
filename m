Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42C3C4332F
	for <webhook@archiver.kernel.org>; Tue, 22 Nov 2022 11:56:19 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web11.17005.1669118179138892632
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 22 Nov 2022 03:56:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=7O73Rne4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id y203so14152445pfb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 22 Nov 2022 03:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xk/ZNTUYd2XieMUPPbwz95RDcZdVJx4QFu93hIoDsNc=;
        b=7O73Rne4En7fH6Ma5bIun8J3meUq/ScFwRycdjCwz8pWZavPns7sDybXYie3wxG+aS
         SbHJDYCdImqf84uaE7G7PGMbrj/1eZ6uODgiFRXOlWt2qWziV1JMc12T/RCNsbgtjKwN
         EEnLcWfKgBQ0o2gPs03ipEmye/THLWOag0ygE8Ct1saiiv/xFS/mOzLOR5NdLSTDdqhR
         9NFKWQI3QacWe/vFoagFFG5PdSvbmdjjSVvWD9s/CHt16Yf+Z1T/qckvu5K7/J8xMtKE
         S42rkU0FgFm+9uZv51y+sWzIwhTgyReuQEy8Ey3w9FpHXFbSgEe+P1/V79MS6HF9K1p7
         ZkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xk/ZNTUYd2XieMUPPbwz95RDcZdVJx4QFu93hIoDsNc=;
        b=gH+P2YerS+eesRRbSjDbMNMpWG4d+0OWpbGrkhxUq8vnknZUpiYMq7pxxNOWXWeOcu
         60SK62GtH2zpjPPD3c85tE6xwdss073Qz0svtgqGm3LRFEAzeUq1uOFT/qQq+Bu6bQ0D
         QX+dEq7sBqf/0mJjp0OI/7aUCRfSx673KI58DYSHREHVOV8JABML3P+D0p9xelf8XKoU
         tvoYl7bSB/+6w6wbaiL07rU6Hdg3mk6A1sq3fCWZJ/6kmF1zdswpcse9yD7amD2YZvlE
         3Xh7Yl9+AMp3FzGzxwBh+b1PeL49AA97KfEhWh+0FWjxFbF3Kz0BX/yf+GN6EwN5tAwE
         +v1Q==
X-Gm-Message-State: ANoB5plqrJWi4tXjcoUG25TxbZQkLA+j5nCE59EUr4QnYJiHUG6AYmW9
	e1ekkO7aNUuOwNH4DuKrE9Co9WKPWrd8+f1WJHE=
X-Google-Smtp-Source: AA0mqf4LKxQjtF+x7VD+nz1VA0zyls6Yck+ZnQTk9g1sZG9RxuunjzTgn/AnxOXWfw0ygpCsCHmhDw==
X-Received: by 2002:a62:a515:0:b0:56e:28b1:56a3 with SMTP id v21-20020a62a515000000b0056e28b156a3mr4004223pfm.43.1669118178136;
        Tue, 22 Nov 2022 03:56:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b5-20020a63eb45000000b00476b165ff8bsm9092213pgk.57.2022.11.22.03.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 03:56:17 -0800 (PST)
Message-ID: <637cb8e1.630a0220.d6c83.d3fb@mx.google.com>
Date: Tue, 22 Nov 2022 03:56:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip70-236-g69445bc0d4209
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip ltp-ipc: 7 runs,
 1 regressions (v4.4.302-cip70-236-g69445bc0d4209)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Nov 2022 11:56:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10075

cip/linux-4.4.y-cip ltp-ipc: 7 runs, 1 regressions (v4.4.302-cip70-236-g694=
45bc0d4209)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip70-236-g69445bc0d4209/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip70-236-g69445bc0d4209
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      69445bc0d4209b0634d1f43657fd58f708cadf81

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  a15eb3cdfa3556203167572e15754f1f59ba26bf =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637cb03ee0acdd5f9f2abcfa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-ipc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-ipc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/637cb03ee0acdd5f9f2abc=
fb
        new failure (last pass: v4.4.302-cip70-98-g7f7838c92740f) =

 =20

