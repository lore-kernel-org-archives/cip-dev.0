Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6341C47258
	for <webhook@archiver.kernel.org>; Wed, 31 Jan 2024 13:21:37 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web11.13625.1706707288149699091
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Jan 2024 05:21:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=udff02O3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.182, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d8b519e438so2820921a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 31 Jan 2024 05:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706707287; x=1707312087; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=blrGDmYFGyKkP87DRF02/eQ8VZrE135dLyPvoIaDKdM=;
        b=udff02O35Gqzg2Fv0KLeCJAcq4y/75K7u5Ziz62rOKmzYLR5dWmcB4eoMQgsqOdvrt
         Mq52e8CjO0o+HxmO5SGXAc3m5+OsgbVlTVimazteTz1FCDX+SX0kljsZCA5XS+W5zY9a
         rN6c2S+s1aJPhOKRw8TjGdX79cDPrbw2mG2BCyZ7ceHfKZwi6Emn1jr6yZL3cRB8h/1t
         V7oFvm8yP88Ek2K58Wl1/paTd9pFfQQGLdOeeGdtRWtNy+T0hxPSN+JnKv2dIbGvmAjM
         CEE0g7zuaYWjfxlZ93q7x4JGteD871qP9648G/r5LeYJtQ3T0p/GRYaPutw2WtGWwbye
         EJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706707287; x=1707312087;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=blrGDmYFGyKkP87DRF02/eQ8VZrE135dLyPvoIaDKdM=;
        b=bUbWwTLkO2jZGKshKc0nHNXhZrEI/4DpnX5btv2ENjJjgTBmkcH12+NCOKbVLFlACl
         SlXqKX5x8edXgzqUGZ/Q9KxLNOlritOGoJHcaXd9lnaEIOwhpa1uPkZSAz20fBgsD/vH
         cCWtLzZjpEqA7dpcGT576O/aD7iBNwj7Z9l3i+y6y2NIZ3x161o+qCVzUI01m3b0a3sw
         FLFW4gpFHdZ1nhRzX3tQ/YkDQWehmPAwwyIhYwmFQ/ytn6pkF5S7LZt5vABh1/RN49gG
         vPvcfZGq05E0YCoSOlbPVRlI5eDKG2yuqB1RdXaWl0cs1f6aK/avGKN0c8oDoknNlvVA
         /6BQ==
X-Gm-Message-State: AOJu0YxlvtqUy0G+U0RGlpf8UsNW/KbGqPnHw40m0NEhYZXp26SYVmNc
	+ShZr+60Th4u7+DxMf0/tzXDrKJDlz6AcwM2oevU0eaKItyq1XNrECYp2Rq0No76pPmU/IoQdrY
	6
X-Google-Smtp-Source: AGHT+IEXGDF80jljD2FP6a4XDgdbi+7fOyp+Do6Lwh4a3JTaLeCn4G69gvxGOz8DqHEGT8SGT2Q9Ig==
X-Received: by 2002:a05:6a20:b2aa:b0:199:8ed6:746e with SMTP id ei42-20020a056a20b2aa00b001998ed6746emr1299005pzb.58.1706707286653;
        Wed, 31 Jan 2024 05:21:26 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p26-20020a62ab1a000000b006d9be753ac7sm9875971pff.108.2024.01.31.05.21.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:21:26 -0800 (PST)
Message-ID: <65ba4956.620a0220.d0868.e439@mx.google.com>
Date: Wed, 31 Jan 2024 05:21:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.72-cip13-32-gf60d2e8cb51c
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 16 runs,
 1 regressions (v6.1.72-cip13-32-gf60d2e8cb51c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jan 2024 13:21:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14563

cip-gitlab/ci/pavel/linux-test ltp-ipc: 16 runs, 1 regressions (v6.1.72-cip=
13-32-gf60d2e8cb51c)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.72-cip13-32-gf60d2e8cb51c/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.72-cip13-32-gf60d2e8cb51c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f60d2e8cb51c9da65ffcfe73144286c27725ceea

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


  Details:     https://kernelci.org/test/plan/id/65ba32d2e93463b69b00a078

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a7=
74a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a7=
74a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65ba32d2e93463b69b00a0=
79
        new failure (last pass: v4.19.299-cip105-1134-gc868d5e4adaa) =

 =20

