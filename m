Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C72BC4829A
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 19:06:16 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web11.22107.1707851174697235948
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 13 Feb 2024 11:06:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=CpaiwtDF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d746ce7d13so40338265ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 13 Feb 2024 11:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707851173; x=1708455973; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RLSYbBYb0qyDtDSuDnufpQubhHf57Hz7sXfELJKRuoQ=;
        b=CpaiwtDFP5/6zLWrg033ofB8HkyK0AAScNOgBwTPm+OXf7CCSrZAZbq3zBBNM+s0CX
         M0Q6VyHQznp6q3UPuuxyBEczae+SqtM4vR2Kep7HB8pH68t2gCchyxoOA7Ish3PQEoN7
         NXto0pBtq73GaraoDargNbIvksf6VRdQhJGeyC655lHG6NlgDgtJ+ns9hguFrwDs3W5z
         QaezqTEzjETWNzz31EJfigYIgKyB/HiortLnGevvyqesldqUKBsd/CgyP/UXu4rCH4wC
         eQyMmVF7yGKQ4bx8Fw4lkLSk/p+SlYM4xpZ8VKfSGZedUj0DHT1pztavoy0Zt1FVXjeb
         btTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707851173; x=1708455973;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLSYbBYb0qyDtDSuDnufpQubhHf57Hz7sXfELJKRuoQ=;
        b=fjqDLMWqEZha3MxCF/KxiDKJfTwTXX+4vL9D0z4MOtkPOYSWHVNgjPHJ/1CW56Ui1e
         /4r0WQViMUj/vwnoWMGagkLIUU5qB6sYGn2f3oJqDpvLG7wsAC3fDkFQ5EYXFqJOeR40
         l9TVstciuJpxiFoV4Hi7SaXXqi3O02ryO6D47nS7EtBuhAq6JjwpMCHJqm+Jj3qSkjiC
         fBnMg5JKq+Q9YnWhjEllalCtJwBQPRPuBOZtKUCfCZybv1lmkJ5TQa66u+LRZOWTmDrQ
         lIqo43iSIImRD6ftCxuZgN05BvG0BpuO8YC0dQGplc9b6R/SDS6eZtRxPMSoPmV9o82o
         gcKQ==
X-Gm-Message-State: AOJu0YzngV8/3fxQtqocM6ShwcZbk0Ra6NFK6lON8N4Dcl8iRcngqeZ2
	+zVcVyd2gJXSQRl6db3scvNtQQZntjGzhi5NI0vjYI4oxCmbKJGsGelS7n5/TlCeASHGcO4kbcf
	knck=
X-Google-Smtp-Source: AGHT+IHU+mZqhBwKn/bbhTXdgPyxKMLad7/UDWQz87T/7tOFNirbYREFFRWggOQz7oWXMzcbBTFEeg==
X-Received: by 2002:a17:902:bb88:b0:1d9:7a79:c366 with SMTP id m8-20020a170902bb8800b001d97a79c366mr431580pls.19.1707851173669;
        Tue, 13 Feb 2024 11:06:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWBAmyiGXvZF5+7O1apPDleM+Wo0K3KuN1MS4QvV6Xuh1RhJqOWcuGNud0hopZUjdP+tnPxvQMnuKAXXZLRJxHfFYhajQUYHf3Xjd3Hh0YHZrZjosQ3on9jI0yG477L2MRcSN1/BeOyxR5RI1O95jeSXg==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bw28-20020a056a02049c00b005dc36417f35sm2406955pgb.34.2024.02.13.11.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 11:06:12 -0800 (PST)
Message-ID: <65cbbda4.050a0220.e8f88.7e1a@mx.google.com>
Date: Tue, 13 Feb 2024 11:06:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44-51-gdb99ac443b0da
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 1 runs,
 1 regressions (v5.10.209-cip44-51-gdb99ac443b0da)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Feb 2024 19:06:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14947

cip/linux-5.10.y-cip kselftest-lkdtm: 1 runs, 1 regressions (v5.10.209-cip4=
4-51-gdb99ac443b0da)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44-51-gdb99ac443b0da/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44-51-gdb99ac443b0da
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      db99ac443b0da75f00a4fc49e0040ac5dfa47e72 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb291f520ef498b637024

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65cbb291f520ef=
498b637025
        failing since 132 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =20

