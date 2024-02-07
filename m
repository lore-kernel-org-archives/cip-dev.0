Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5FEC4828D
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 21:14:41 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web11.1722.1707340478135964450
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Feb 2024 13:14:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=uopDnAzP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d71cb97937so11367975ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Feb 2024 13:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707340477; x=1707945277; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UdoWpPHsWb6lTS6AmQ62iWUihH9vZMyKfa/dz1YlxNM=;
        b=uopDnAzP4+etmuF3W108COk69aiFXH/unY8fyL2TdkeyGKVoOqETGhpLnfUQoySB3V
         R7UqMgrzwfslufTWTeiDFqBdw9PGZgJPdqctpDU84T721CSy/+jP4D6pJlKqx1Xliimt
         0HhSGe2KzHnU4QfILxzE3mQfwywqIBKv69kfAll7Z6ACo/dWfYaQD9upep1oqsXUe07L
         /WZNkBnYFe8TnXTcepqcrGvgc3fyybIEj42R+Oc5SQLHUxPzr73g/2Z7Bc4HhH8Z7bn2
         bWkHDfMnkClLZo0VHXP1YtjLj0wxbT8dhsjGIFeSlx30jkgcxIKngeUwBSEfuT+jGtxm
         gomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707340477; x=1707945277;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdoWpPHsWb6lTS6AmQ62iWUihH9vZMyKfa/dz1YlxNM=;
        b=xJhRQ7Nz7uuyYan32pUko1lOFymliiubjOeyU3lwC6LPj8eZzPue1mIwTP/qBhQImy
         /nCsugF1L/7W3I6NeA1uwLCypwUYn2zk/ix76QRJ31OfIG+bTql0EHlb6aatFQlu7JY/
         UCktnwNyEdRB8xuOB6c1+C4uCkbSfzVSInPNg9tuGCMiXrrAmpFnR3LM6t9ZhhKcTCx+
         DymRRp+hHRTlZ+M3MV7huF53KNHnEDKx2SfwLc3L5NpbOIQIzdUnFkvsupmZiA2mXWYE
         5mZYmbNxA6w+mRu+DNM3Ab946M7ioNzBd+5BFks4Y94r44Z5w0Dq1Mrf3hytdS+VpAZj
         3bkw==
X-Gm-Message-State: AOJu0Yw3UDxKI6WGlOg7G0mLNGn0Xj+OucLaTyJztVY1OhL9JlTu7VB8
	jU2pfIV85XfD3cNE0xZRqDPYaGbHjn13PPIuF8Z0yGcJqSMvNXk5HO3o+ijgX9s2YC1bonH9TUO
	yk2E=
X-Google-Smtp-Source: AGHT+IHbu9nsz5Kx831xHUw8hMSRajBueTRsWPhZ6Hm0CwurcbkXobVuZCgJJoPOHFryoQOAG/q5dw==
X-Received: by 2002:a17:902:a514:b0:1d9:ac42:6ff with SMTP id s20-20020a170902a51400b001d9ac4206ffmr5491611plq.18.1707340477108;
        Wed, 07 Feb 2024 13:14:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCdXqnQ6osRYwLsgo22WyQbjAe/DcX5054YwErt0vfs1yu/iT9razAC+ioNXOE5LKgT6CuV0sh9PT3KGhRmje+rbI+sQ4q8PdhO4iDHuT5sx0IzSLhuQhdqd3T78/3A9kOdw3XSqmG737Qz97lTy+gtw==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902ed4400b001d9fc53514esm457891plb.66.2024.02.07.13.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:14:36 -0800 (PST)
Message-ID: <65c3f2bc.170a0220.b83ca.2e4c@mx.google.com>
Date: Wed, 07 Feb 2024 13:14:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1251-g681701bd9bc1f
Subject: cip/linux-4.4.y-cip ltp-ipc: 6 runs,
 1 regressions (v4.4.302-cip72-1251-g681701bd9bc1f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 21:14:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14909

cip/linux-4.4.y-cip ltp-ipc: 6 runs, 1 regressions (v4.4.302-cip72-1251-g68=
1701bd9bc1f)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-1251-g681701bd9bc1f/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-1251-g681701bd9bc1f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      681701bd9bc1f65237982eebce24afcffab64f4f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c3dda218cf29cce08e1eac

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1251-g681701bd9bc1f/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-colla=
bora/ltp-ipc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-1251-g681701bd9bc1f/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-colla=
bora/ltp-ipc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65c3dda218cf29cce08e1e=
ad
        new failure (last pass: v4.4.302-cip72-1250-gd530578b1386) =

 =20

