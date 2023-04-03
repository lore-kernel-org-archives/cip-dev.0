Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA84C77B60
	for <webhook@archiver.kernel.org>; Mon,  3 Apr 2023 13:11:05 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web10.69648.1680527460080019435
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 03 Apr 2023 06:11:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=2e0nDb3z;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so30455086pjl.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 03 Apr 2023 06:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680527459;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eg79vTXsjPWZf2SHhtJ7Q3/2UGsBcRoiBI/E2leXpOk=;
        b=2e0nDb3zySXUOQBKKbPFyNaKsY//CM5OKRb+x20FZW9kLKZX2/jKAV8J1Tv1uMVY8e
         q2gVI2Kow65TLiv+T6Hhb1Y/K60Wd4vSpQE0I2cfNkxtFpNH//5n8BKMg6AloWDGnwYb
         Z0v84FAFm02ZvuM73DKgqCsafM3Xa21HEwsf7iq9WcQLyMhrjqVNjHzqfw0ZdRYYzugK
         JnTfU4ulrwXc0R0OtWyYPNuEiY0od3Nj9Xvva8rVJdtWNnafB/ptJBVRrZ3XG4HpTGgE
         iUBwCNA47wtjsOCKhrl7kx5disdrwhbJEkCxsZwbFr057mZZifOIhdsVmAGDeaoN+YVC
         P0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680527459;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eg79vTXsjPWZf2SHhtJ7Q3/2UGsBcRoiBI/E2leXpOk=;
        b=Pu7GJsP7rqyflYaLk+lvO9pkGxCD9paQkSVMhGkazUKeFY6WjZ19dJ4cf8fb2jO2WZ
         pHa4gw1NXFJJpEUPWmKiyezXiPU8PxGJZy2wE4bf7Pj+rO+Uu3UI6jMPABkQK7F+U6Fo
         udD8CwTmUvnbdlrfxTnFvNKAa76osEP32gTnqjRmuO3jeukhltrQ8KVd95L5+PL3eFi5
         iesoqdPGkx/eo6RKdEm/dKER2hIYKsK/Zg2Oj/2s/+95vlz2eg5+JibOqptQzuRqMYs4
         onW2jNnmOSSccA7R21nwGdBU8mLzPH0I+rfKEt/KjCjdilqVcvUE1mysOM1xTA3kk+NN
         w4Ag==
X-Gm-Message-State: AAQBX9cv1eei+pEcIUo6Eg0L2vXVHsFz+osh33H7I03aDB6QWZAUf37S
	j/QnwrzhJtDcQdnricP6wYLfeWIaffWg+aOgADs=
X-Google-Smtp-Source: AKy350ZMojrjfK7SQeAaPztf3ccyRtcGKTVo5FGegzbyvM2Iuo7VQ8gVhKaTQ2BsmdCGpoA8x35Hrw==
X-Received: by 2002:a17:902:cec5:b0:19c:bcb1:d8c3 with SMTP id d5-20020a170902cec500b0019cbcb1d8c3mr46576220plg.54.1680527459371;
        Mon, 03 Apr 2023 06:10:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jb21-20020a170903259500b001a042f532cfsm6620032plb.27.2023.04.03.06.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 06:10:59 -0700 (PDT)
Message-ID: <642ad063.170a0220.c447b.c99b@mx.google.com>
Date: Mon, 03 Apr 2023 06:10:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-1097-g52d843097a439
Subject: cip/linux-4.4.y-st-rc ltp-timers: 7 runs,
 1 regressions (v4.4-st20-1097-g52d843097a439)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Apr 2023 13:11:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11158

cip/linux-4.4.y-st-rc ltp-timers: 7 runs, 1 regressions (v4.4-st20-1097-g52=
d843097a439)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1097-g52d843097a439/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1097-g52d843097a439
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      52d843097a439b3e38b2dde18a7c7fc256a94f4e

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  f41e8a2fa6f048d456ec2b136db9af50c7e42de8 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642ac3a944234bb6e262f78a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1097-g52d843097a439/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1097-g52d843097a439/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230324.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/642ac3a944234bb6e26=
2f78b
        new failure (last pass: v4.4-st20-1097-gd51b0e04681f) =

 =20

