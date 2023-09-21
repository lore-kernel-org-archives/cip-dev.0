Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE01E706FB
	for <webhook@archiver.kernel.org>; Thu, 21 Sep 2023 09:29:39 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.12050.1695288576179036570
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Sep 2023 02:29:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=PoNKsLNh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1c5dd017b30so671785ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 21 Sep 2023 02:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695288575; x=1695893375; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VzFEDjibYsShzG+if1M0ioX2SMYUHaQ17QAsKZfMOXs=;
        b=PoNKsLNhQVk+7up5JfuLmzW1CVoB643fBVkOLrNOiuXXpk06gLScKO2jILc9YBxHwy
         iZGmc+9EKENbLla5ZPKQDODvLlFJubIrZMrdO5u5MVitX9+6tvBgFk3NNZO29UbivCjQ
         Q5nTVOhtC+1PKg8Hbp5ypvRvw1m4w4qXVbrLN5c/rj3qG8hmvDgkiS1a6MRiszZJmkjj
         3TSoO68a9bkb8xXiQ2QV1+0e/HRcoSIrd/EG4Vlpjn8wSCSn3C/6GZkU6kuGswnjcZsg
         in+CoWUYQZW1vHcelOBmUor6/tNRQ3OPDzyFBwAm9J8kNiymbqZnM+sK/IKq5IDoSEoB
         veVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695288575; x=1695893375;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VzFEDjibYsShzG+if1M0ioX2SMYUHaQ17QAsKZfMOXs=;
        b=vIhy7oQ9fFRED5XyLYQhLxcZS8IQFgzBrYL/fYUvAK29oWb6OngnT7pgwg5qQwf18e
         ylQiEbk0yNREnmsIXHSXUHyAKFc1Ewx58/p2BSnoczSwqqcUyFaA5qTxYVQFJOab7CUw
         0Hf4BZnM+ckUdnO+MGc05ihiq1tBjb0J3lNLtCiGOfqDiQXNUOttw/va7lfnWNjgyryV
         N3jmUNzUeQcb0Mk1DlchLrm1bFHLKQM9vzIYhbkl+fd3rPW21QA7vOrRHdMHM/me7h9P
         3+IOHxKoax3jiARTyUgIcS5VWx/VmJGxXI1sMBCvVdE9h27QEsUmUwsfUEHt2ujQhQxw
         HONg==
X-Gm-Message-State: AOJu0YydlXEWLel7d0qq11EurTrSi3gGkY3dPUne9VY4R0bmQkBvDAh+
	QGbg7V9o943/PsVMM6xbmtz6hMGdopkAeNKk0gVrDA==
X-Google-Smtp-Source: AGHT+IGPierWcM9VGMl74lMylPC4AkvidEGtGbXEdKbNZ4ZVgcHITb7SVWijTXMnxfjJVKAOSel37A==
X-Received: by 2002:a17:902:c950:b0:1b0:3ab6:5140 with SMTP id i16-20020a170902c95000b001b03ab65140mr6839132pla.4.1695288575138;
        Thu, 21 Sep 2023 02:29:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h19-20020a170902f7d300b001b8953365aesm987334plw.22.2023.09.21.02.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 02:29:34 -0700 (PDT)
Message-ID: <650c0cfe.170a0220.a699f.27ec@mx.google.com>
Date: Thu, 21 Sep 2023 02:29:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v6.1.54-cip6
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip ltp-mm: 1 runs, 1 regressions (v6.1.54-cip6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Sep 2023 09:29:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13189

cip/linux-6.1.y-cip ltp-mm: 1 runs, 1 regressions (v6.1.54-cip6)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.54-cip6/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.54-cip6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      5f8461a2ec855187b1bab7e4aa419338772fe9bc

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650bfe8758efc5bf8c8a0a44

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.54-ci=
p6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-hp-11=
A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.54-ci=
p6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-hp-11=
A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/650bfe8758efc5bf8c8a0a45
        new failure (last pass: v6.1.52-cip5-29-g9fee06894d49) =

 =20

