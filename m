Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3CDC61D97
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 12:59:47 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.134670.1700830784198255446
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Nov 2023 04:59:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ciABp3Uy;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1cfa5840db3so3499385ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Nov 2023 04:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700830783; x=1701435583; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4pkjgJCTuBbBr6rOYvYuxGCvN+zyyOygn8GIpVmA+LQ=;
        b=ciABp3Uyzx0BEtVXL17oL5f+jmujIcSLxTqZ32XEyi/We4o7BE/wAUVmrUDfHEf/DS
         7e0cyL+GRo9UEFU55YNi0vdX1P07ksnJxcuO677zYzGsBzSW01N5I8ns+bfdFdDkJTYS
         WFHVs+auMoF1sHj41df6HO1yKq5Ox40LaUYx+B1HeEMvkQSzkbzZR7ZkqOyiaPswzMFZ
         gQtHzs4/8dJUP3UkDsrkrwrIkjWWobdvkq+MQQCfCM98Y1+XMwl7xCXynfShf6m3oVJ8
         efDoCFwSR9y5NBdXeaPjT8RJqlE19XWwQwhgYhQtAtz71Va/MvLtRyL4XdqYKrsBLCdD
         DK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700830783; x=1701435583;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4pkjgJCTuBbBr6rOYvYuxGCvN+zyyOygn8GIpVmA+LQ=;
        b=f70CdQVP3wfD/6FZZIruxJ7a7hu+FTPqDbea5ZITmf7mSP1HBx4EAvrWYMaWbIdM4D
         4VQSq4eGssnVA9xGUmGsJjEEqUgijFh7l8k0eMyDfrvLpiaKCml9lT9vNt0xs6Lg+4Ie
         gmXuvXsMkF7x1ThBT83L/TtTfsFyUzPfvlOxD+emooGSkZPnr8HRxC0KBTI6Fx/6s5Ul
         AuW7lYtdQGA8ZkHzrdsTf+I9P6eJ8KBOKjy5sWZnLSRsrGL+VmN6a/r/Qz+/dvhTBeUo
         82XnejRNHQgT2dTrvLkC0Gr1om7sYA1JcmdTvaTqmduEDKcV7ZX7viJiTFZYPVfYw2YT
         WkNg==
X-Gm-Message-State: AOJu0YzZMRi4qST59i8DC6B+dVjyOLcke6TVcA0FLO+QgFSAWmy+Uq7E
	dyxAaUjRIc96GlHXyr7SEcCfpRkSk0O5kt+dhns=
X-Google-Smtp-Source: AGHT+IG9HUgQZK4lJzLJ+F/J2mtCz9LHi+Pls7O95G9KKASQ5zGiJmBGWiFa6hKNQ0CMlbQgqzJiSg==
X-Received: by 2002:a17:903:120a:b0:1cf:665a:926 with SMTP id l10-20020a170903120a00b001cf665a0926mr3645754plh.49.1700830782902;
        Fri, 24 Nov 2023 04:59:42 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ee8900b001b7f40a8959sm3135134pld.76.2023.11.24.04.59.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 04:59:40 -0800 (PST)
Message-ID: <65609e3c.170a0220.3fc22.73d6@mx.google.com>
Date: Fri, 24 Nov 2023 04:59:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v6.1.62-cip9-12-g3a5321f469b07
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 15 runs,
 1 regressions (v6.1.62-cip9-12-g3a5321f469b07)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 12:59:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13745

cip-gitlab/ci/pavel/linux-test ltp-ipc: 15 runs, 1 regressions (v6.1.62-cip=
9-12-g3a5321f469b07)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.62-cip9-12-g3a5321f469b07/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.62-cip9-12-g3a5321f469b07
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3a5321f469b07e6124d325d7faaa2f8f1993f67c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65608e118178ed88437e4ada

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm/omap2plus_defconfig/gcc-10/lab-broonie/=
ltp-ipc-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm/omap2plus_defconfig/gcc-10/lab-broonie/=
ltp-ipc-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65608e118178ed88437e4a=
db
        new failure (last pass: v5.10.201-rt98-828-g27523c64bc5dd) =

 =20

