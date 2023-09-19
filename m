Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34161CE79A9
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 23:42:06 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web10.25363.1695166925745672234
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 19 Sep 2023 16:42:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=eyga/nGb;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.176, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-57790939a2bso4332532a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 19 Sep 2023 16:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695166924; x=1695771724; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cdy9VbBPgwFGg9fQatPTS9+s8LQU/vanGV5538ncos4=;
        b=eyga/nGbQgPbiCzdxutAnem/VDPQFs2T3kRTOoHG9DPCxqm8dJ8RHXZhlPQCbZDy6m
         InR+YoPLARNXbATMvzWpIjAQLUArelFd0eJDhXeT9IRjnKFeU1X/hfq3naXqsO/ln84Z
         Csbz7ocQqdbDnsPrdxVrom+quFaERGrFPYN1xo2zGQJWmfkFx14y0on8iBAvBfPDcz1K
         hWRkzIyyi0LQOwMheqPeOtVKeXwhE3oWuP5Nn99cgrKyHBwUa0Tpvw8gltwiomLs38EU
         cMV5BOOryV1Q3pz4KuT/V6I0g87MXR/aPaqd4v8Lz7zYnzFAkzcIOD8KAcbEPamUlowK
         lXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695166924; x=1695771724;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdy9VbBPgwFGg9fQatPTS9+s8LQU/vanGV5538ncos4=;
        b=EFiSt0fTd8aVtPCUpge+1SheCsxdY1wP+THI3gXudU2zqfNuAJjuVAfz1Mx5LF4W8M
         LAZVkCMxYlsVdbkoUAykMtIv3Efjq2un39cGfDABIn5qQGC5LzpHwMoC+pjsZw2X0OJJ
         BHZwYZUhrmOxmmUg0UYBSeq7ieAQY4XfdENLJEvFmiypQoJHU58x8YSFj7wdy11CjvF4
         cvTpmiZI8KV62f/e56hodpRM/N3GEwnX1o8N0WGCFMQtz0cl/F2vQvi2icP3e1as/Oxo
         puZqIur/ob3OvvvfDbqoooWwZl5iCU3WE3oXFnMIM0tzJZ/CPf2lQYHw4uhY/PbVl2Nf
         JCqA==
X-Gm-Message-State: AOJu0YyyNaJHVrRiq5p2umeKf2dWbgzZiQkePz90BEDj1QxsB8vvgiEp
	MEK3FQ/UaJs5iloGQSILOaSAFQqdBxF/lPPLNer+ww==
X-Google-Smtp-Source: AGHT+IGkIOZPaG1us1Ucs57Ujctd3PVd1fmXlyaMkSGLjlqIdxO6L5wzRY9j2Srw408gsgF6HEcIFA==
X-Received: by 2002:a05:6a20:1608:b0:15a:f4e:620e with SMTP id l8-20020a056a20160800b0015a0f4e620emr1009712pzj.59.1695166924465;
        Tue, 19 Sep 2023 16:42:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902b94300b001b66a71a4a0sm10493259pls.32.2023.09.19.16.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 16:42:03 -0700 (PDT)
Message-ID: <650a31cb.170a0220.6bc4d.64cb@mx.google.com>
Date: Tue, 19 Sep 2023 16:42:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.194-cip39-rt16
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt ltp-pty: 6 runs,
 1 regressions (v5.10.194-cip39-rt16)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 23:42:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13171

cip/linux-5.10.y-cip-rt ltp-pty: 6 runs, 1 regressions (v5.10.194-cip39-rt1=
6)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.194-cip39-rt16/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.194-cip39-rt16
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7aa1fa8ed3b5d0130443043c96b985082bf55241

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/650a22d23ec7031d838a0a4b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm64/defconfig/gcc-10/lab-broonie/ltp-pty-meson-gxl-s905x-l=
ibretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/arm64/defconfig/gcc-10/lab-broonie/ltp-pty-meson-gxl-s905x-l=
ibretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/650a22d23ec7031d838a0a=
4c
        failing since 66 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v5.10.186-cip37-rt15) =

 =20

