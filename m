Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BCAC61DF7
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 12:07:26 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web10.133845.1700827637350552084
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Nov 2023 04:07:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=lE3kCRw0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6c115026985so1780477b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Nov 2023 04:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700827636; x=1701432436; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c33CZB9wEpC1iXwnzyA9HdUeXrbEnZl7iE7uR1orIEE=;
        b=lE3kCRw059bCNktIWbbszj7slrOK0WAHil88X/jlmTLnSCPtRFR68mTO/ZczbOIINk
         S0TyN6Y3P23WvTuFLPDjFdX5wizwr2zhS6eOVKVrF+pJnkz7/IrqnZSTe8+JZl6wJdPZ
         WM1yE1G/XWij2jeB7hb+KndOnPb06SejuX0BPphpLnJg6F7ww7XlAR/2Ez5POidIVzmS
         Vy9klE4tanc2y+e1GJd8WYfA0d26/yb9AF+q9iWS6O4Jg/jjsLQ6kR8QxQMQvI3aL8EB
         t9Qj6yjTMwTV/TaEzahq0hMz8PScEutIiOTLiClK0BZMMMigRoVcX9T9YNxqIEARQ+ws
         44LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700827636; x=1701432436;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c33CZB9wEpC1iXwnzyA9HdUeXrbEnZl7iE7uR1orIEE=;
        b=BdvzzCXa4kJtMIAMSome5r/0ieL0/J4dIlVNOWWEOKs+13SCT19kc+KHRdu4WoN/VI
         sOhBawAuomp78zIv+v6o/2aCPCxe3nRs8jI6XuwvoZC/If4T/d0noJpbQQKLZmRa5fl1
         n0iDt2lvdLjcU2mjc+xd/40y133rF8FcS201gQ2dKd+UHB0+TwW2vmHQcDH3eRS/3dH9
         ibK3x7wMStCrK9GcBMjb7qRB4cIIFC3zpBeOSSLaRte8P1QIfgzm+lVwXTrAzEXsySyc
         pXX6sUpsoCMOC5ycNqKbDHz+KtluQ8l/PLsIE0nF8PPvhyVS9meoiSwhtnFHW8ZuRuBX
         KXSw==
X-Gm-Message-State: AOJu0YzRlHmbOowoQZfDAobwDLA5cIE0qmsi6tmA2Wc0+/i3OjkiDqEA
	o0F4+LLoefUg8nZYGd5nZXODL2E2JIstrELvHho=
X-Google-Smtp-Source: AGHT+IEcoXSegpdYD/2QJ5R+QS2FAr4mmtEWEZ5IA8B3if/1dsWq5ItqQ+iJIlrTNZe5souJkdH0/Q==
X-Received: by 2002:a05:6a00:21c9:b0:6cb:8ec7:ad01 with SMTP id t9-20020a056a0021c900b006cb8ec7ad01mr3206043pfj.10.1700827635993;
        Fri, 24 Nov 2023 04:07:15 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 16-20020aa79150000000b006c2fcb25c15sm2742812pfi.162.2023.11.24.04.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 04:07:12 -0800 (PST)
Message-ID: <656091f0.a70a0220.908d1.689c@mx.google.com>
Date: Fri, 24 Nov 2023 04:07:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.201-cip41-11-ga539098fe70dd
Subject: cip/linux-5.10.y-cip ltp-ipc: 13 runs,
 2 regressions (v5.10.201-cip41-11-ga539098fe70dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 12:07:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13737

cip/linux-5.10.y-cip ltp-ipc: 13 runs, 2 regressions (v5.10.201-cip41-11-ga=
539098fe70dd)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-11-ga539098fe70dd/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-11-ga539098fe70dd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a539098fe70dd29de0ce67ad5a39c40867ba5b2c

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


  Details:     https://kernelci.org/test/plan/id/65609010df532932e47e4a81

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-broonie/ltp-ipc-meson-g=
xl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-broonie/ltp-ipc-meson-g=
xl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65609010df532932e47e4a=
82
        new failure (last pass: v5.10.200-cip40) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6560827a5cd5071ea57e4b1e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hi=
hope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hi=
hope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6560827a5cd5071ea57e4b=
1f
        failing since 50 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

