Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3904C4332F
	for <webhook@archiver.kernel.org>; Wed,  8 Nov 2023 13:30:56 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web10.13463.1699450247734705362
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 08 Nov 2023 05:30:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=S/Zdy6ZU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.175, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5bde80aad05so242859a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 08 Nov 2023 05:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699450246; x=1700055046; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=flcC6c0KaqnNOLsIEP1Z7T/iRgNC3QCl6C0y2rSlnpY=;
        b=S/Zdy6ZUkfTEgjHBP7sJlm+q2+njAQP58b+W1bno72Q5uE/trMrz9IhXQXN5IxXXTR
         wqdao+QqC8kncKEusuVeQ185RHHtY1eS/UXFrJS8wVwYierL4+99XoPld4cC4BErCT/b
         fW2hDNz0POWXQ8tOlo1RPXhF9byxW0CoYWWcA+D+QT5r0lJRFYc+1nbg11gVNrlbX4VU
         3kWvxVkkjKaJWhqql3rTHPczkZo1+UbK3eyf0g4Udh+HQMnUsVew0p5GHNU/AdCl0tpu
         IbrtN8Ml8uMIx9kD6lKlQnnuO8il7tYEj0LIU2QnwL7vMNBew3bqafTlYuVsMH9Mva/w
         N00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699450246; x=1700055046;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flcC6c0KaqnNOLsIEP1Z7T/iRgNC3QCl6C0y2rSlnpY=;
        b=jrX1SVO25PJPldYWCRMFQsq+hcTgsKMqnwOeeVXIB3XZLY1KIP5wI8r2KC2APVnieg
         HU391oQI7Z4nRspjqqSnu/LpN6ZsTE4B4SVS6ineNcdEsUdRSxHD/Ek9UrpXnKkUhLfU
         D/XlK/Bsxg0YpwQJ+CJfEmi62IN5yNGM2VwKrSN7R6nYF2aoLa5d1tpj+JY9H05y/OCI
         D79N2COqBfpVktqmuS8exzPaocw0u2lS+X9yiaD8hMHSyXvYao+urBBQKaYyCmSKnCBf
         0dr6FPEIwTT3JdOKmf3BYTL0fiIqW2BHJN733wODSe7BJ6b9kVM1yCTeeYZryFANekJJ
         2gMA==
X-Gm-Message-State: AOJu0YzA7ulUQ9nJFKFuElHZR43WCjCUV8GnZwx7xOHlbgQGP1ebjFXW
	xXwDySaOgnHYaVdBaJDuAmujx/JgR6TfqdUyC8XtQA==
X-Google-Smtp-Source: AGHT+IGVw3I9uk5Gvr4gn1p+HPH4XQFISwtEKNEyOhpIWpu53NbpOfc4dg0F3HsxqmOSVWU+Dxhmvw==
X-Received: by 2002:a17:90b:1a8b:b0:280:18bd:ffe7 with SMTP id ng11-20020a17090b1a8b00b0028018bdffe7mr1514957pjb.48.1699450246202;
        Wed, 08 Nov 2023 05:30:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d6-20020a17090ac24600b0028018af8dc2sm1582897pjx.23.2023.11.08.05.30.45
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 05:30:45 -0800 (PST)
Message-ID: <654b8d85.170a0220.719e2.45d5@mx.google.com>
Date: Wed, 08 Nov 2023 05:30:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.297-cip104-63-ge7301d2e196ae
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 11 runs,
 1 regressions (v4.19.297-cip104-63-ge7301d2e196ae)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Nov 2023 13:30:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13542

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 11 runs, 1 regressio=
ns (v4.19.297-cip104-63-ge7301d2e196ae)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig+x=
86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.297-cip104-63-ge7301d2e196ae/plan/ltp-tim=
ers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.297-cip104-63-ge7301d2e196ae
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e7301d2e196ae60b103ce909a0740547e15c30ea

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig+x=
86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/654b871ca248acb4c5efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.297-cip104-63-ge7301d2e196ae/x86_64/x86_64_defconfig+x86=
-board/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.297-cip104-63-ge7301d2e196ae/x86_64/x86_64_defconfig+x86=
-board/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/654b871ca248acb4c5e=
fcef4
        new failure (last pass: v4.19.295-cip103-193-g33550555e507c) =

 =20

