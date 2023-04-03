Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FFCC761A6
	for <webhook@archiver.kernel.org>; Mon,  3 Apr 2023 12:52:15 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web11.69256.1680526329036424335
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 03 Apr 2023 05:52:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=1PZK4UEt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso32464886pjb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 03 Apr 2023 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680526328;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0x6qvP5J66Kd7ecZ/+y6koTwTMeWc5FzSWprt4HbI4o=;
        b=1PZK4UEtHbfPnBZKZ1Qf3tFSOkx0X9S3vG5qWY+pF1AGxG9tI1sRXU4zEZonBR8Cko
         vodMxa/pOPn7iep5iyUIIMnY0ZaAtCVgU/cMZT6F+M+CP5d7L/88TuCzfBDJaMahC4eY
         rTpAf+t9oCjRprAoW+i4gBawfc9hk3FRcoB+nnEEcGEZ5sRPrNwdvKZebhJVSsendVNd
         6Dr242paDtWQLO9tKFxR9qI8cVdSBNqHsm9IoRg0R8Rwz130nqYIXQzSSa06EFDBSoHm
         WvhpRjBlwH5yy2vyC+5WGgwE8jyOCvnhcKZ0u/sX3NimozJPyYt6T9hvukyDNhpyaAFA
         CQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680526328;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0x6qvP5J66Kd7ecZ/+y6koTwTMeWc5FzSWprt4HbI4o=;
        b=psch7AV9c4KztT2TQ73Ah+U+q9ihh4tu0ODnkuEsk1Z4C/2Nj+M1P0M9uBJ3vn7woZ
         JYmZr73sOLzLyr9U5gf51PEuSitypblN9kVruR4lVcnpNN9Mp1t9YQHYhBUO+zcMjD3M
         FWtzwuR/ey4lT6ala7vJTKDwUf42PzD5s0jKJE1O6S0ciEuhmQ95biQO70cY3ZlQEyjf
         MVBX12BZ2ijE11mM+1X54vxnKd6lRehRsT8Mhh4HlyK3tQrmqDAKXHrJwFXqTs0T+82D
         3IVv65nBRG9juzlHgjD6fCiRG7HFw7+OnkYRxpLXXi1jFVwrt8Sp6fkighDCpRkzdsU0
         SXEQ==
X-Gm-Message-State: AO0yUKXzviPyfNjCzJEXX6Yqkfb1P/RsTdoBqMisyitpxPtB+4FFx9uh
	FZxoQu3z0u1SPcWyQVXMnlf9ahmjcx+ontns2n8=
X-Google-Smtp-Source: AK7set/TxBZiE+kIvivbQpfmJ3qFbXhUD876Eis5xFJC1jcV34K8jCaRIlfl8Z3AjPH7bYJcHzs1hQ==
X-Received: by 2002:a17:90a:9485:b0:23c:feb9:2cea with SMTP id s5-20020a17090a948500b0023cfeb92ceamr41238584pjo.42.1680526328314;
        Mon, 03 Apr 2023 05:52:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id mq6-20020a17090b380600b00233864f21a7sm9614084pjb.51.2023.04.03.05.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 05:52:08 -0700 (PDT)
Message-ID: <642acbf8.170a0220.f2d06.256a@mx.google.com>
Date: Mon, 03 Apr 2023 05:52:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-1098-g8d34bf42efd9b
Subject: cip/linux-4.4.y-st ltp-timers: 7 runs,
 1 regressions (v4.4-st20-1098-g8d34bf42efd9b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Apr 2023 12:52:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11155

cip/linux-4.4.y-st ltp-timers: 7 runs, 1 regressions (v4.4-st20-1098-g8d34b=
f42efd9b)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st/kernel/=
v4.4-st20-1098-g8d34bf42efd9b/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.4.y-st
  Describe: v4.4-st20-1098-g8d34bf42efd9b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8d34bf42efd9bbd9f2b159d4e40217ea530ba3ff

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


  Details:     https://kernelci.org/test/plan/id/642abfc04268f70bdc62f76e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
098-g8d34bf42efd9b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
098-g8d34bf42efd9b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230324.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/642abfc04268f70bdc6=
2f76f
        failing since 20 days (last pass: v4.4-st20-821-g39bdf0444b23, firs=
t fail: v4.4-st20-939-g5ff13a6decb9) =

 =20

