Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74578C48292
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 18:21:28 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web10.1294.1707157279799481252
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 10:21:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=nEpMiwx6;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.182, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5dc13cbce45so1364966a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 10:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707157278; x=1707762078; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+l96v8rshzdA6pl6kUId2yTWCn4pna5EhwsolK5nDpQ=;
        b=nEpMiwx6hfqHo1II18/HqWs5DdqvUhngmIjuU67pazJ0UG2mCmDSBnJFEGMFwyghEr
         uPFBj0AYhSlLFbKwl1D40CVb6z6GYI5aRBuqf/UGP95v/0/IyuYLF57wVOnV1zvTCL80
         lCoeEyQ0C97MYaakDpI3tpCVxHnehenPGIs7RXN1h8RORseDI9RenWNKFSqHeh3OjGzL
         KQtlpEMHgEAbja0iO8FGrZcSq2ZVAVBguxB/zOR9c3rmBjRT2IyQNYgashmmUTrvXb2X
         Fam5ll1G8ZKab7TE8qg3oGq1M2SX383oft5y7qbJkbnTVcQCuWX0Wf9Aw/z0IF3i54Yp
         hazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157278; x=1707762078;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+l96v8rshzdA6pl6kUId2yTWCn4pna5EhwsolK5nDpQ=;
        b=WdOqblSi97asgqgN2zzpogOSaeNXRQGX2hAxJj+6wEXDIL/+QTYk5YIjUJBUdF1iOP
         06x7LfAI+907UJfbwWHqEubciOuT1/7O3xAM+iPpPKCHTO/JXfFQOBkT4s5N4+s2iZeN
         m8CQmMwTJwOTayWKtzcIDYXzCb99IvUpmATqX2Qy+dYkV7XNpCsg1WgzAFLLMmes5zQH
         WlcOMR1M/dcrXxfSwSgu4u9X3BmAHWSft+C3AZA8DFmONtWCfOFtALP+l1DH/cursUBj
         e33rDwYuXJF8e4IvU0ACiqBpXmfXTowuKE9YGy8U5L5dF/NxWrsQ7tLowqJaOlrazjCe
         Vikg==
X-Gm-Message-State: AOJu0Yw2p0D2FihmvR5d2XaKjhdRul/UHBtQG/efr82mmDeVD78ADgJe
	1fAOGFrrUDUH3/oUiXcQ/ZIP42GW3ZEvoTEO0QohZO9aWKIGJgoJxWaDVsPZQ1KiuCtywq5gbsS
	5
X-Google-Smtp-Source: AGHT+IFZMjMX3t0qNJeVRklM8iJS56XssE6E+Kx4HuScvBD2qnmCRKNSf6NgNknOQlOfVoV6zxg9xg==
X-Received: by 2002:a05:6a20:26a7:b0:19e:371f:c03f with SMTP id h39-20020a056a2026a700b0019e371fc03fmr291216pze.37.1707157278299;
        Mon, 05 Feb 2024 10:21:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWDawrur7Z8/KNpdXnd3Hx2oVUVxSKSnQ63WwB62DzE0sVOLHkUouUY+fiNIH8uLSVXeRfWIGUcbwcmBX+X0TX3f/30VP2N1JVQp7CFgPT0utii8P/m534lZVWjZOc3C61jhscpF+HOsmKbH7DTAQngOQ==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q22-20020a056a00085600b006e03bc76711sm143258pfk.165.2024.02.05.10.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:21:17 -0800 (PST)
Message-ID: <65c1271d.050a0220.d9c0d.0f3e@mx.google.com>
Date: Mon, 05 Feb 2024 10:21:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 2 runs,
 1 regressions (v5.10.209-cip44)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 18:21:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14748

cip/linux-5.10.y-cip kselftest-seccomp: 2 runs, 1 regressions (v5.10.209-ci=
p44)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2fa4c25ee66abaa707e8d165c790bb96e883cca4 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65c115c246a3450e5900a05b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-=
hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-=
hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65c115c246a3=
450e5900a05c
        failing since 124 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =20

