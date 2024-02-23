Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E331AC54798
	for <webhook@archiver.kernel.org>; Fri, 23 Feb 2024 12:06:56 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web10.9111.1708690009455477837
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Feb 2024 04:06:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=E9f0WjJC;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e4e2380588so273789b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 23 Feb 2024 04:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708690008; x=1709294808; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tuPkdtq9LHY/Qn47gQyKDNxBy4zBerQgmwmdHq9D61w=;
        b=E9f0WjJC0jtZItji2dLfstXnxE/V4W0P296k8V9TQF+R/2AjeuVyA7lqngp+aboHjK
         EmpwbHErhDpgP6Lb21sw8L6+LoYt8YA3RAZuIt7TyVrdDHAupyUj8E7BFtQVKFoNyuh/
         OOU6Xwpxv7fAtD0sADJRjfN97Y7nFJLW6vp8Y8TakR2EigPlfkkhJsx4C8A0FXKB5Fto
         BDa4QRInxF+UcD3GC5uYIS7aCFhXj2oURhjw7RxtIHI7yIY0bweIYOHsBNTwEjrtbZ6T
         +uX4+u5nQi4P5qu7mvP9ZvE/CBP53Z/uR3yi5qODB6Ac1QbVocvbbeQOoGCz5/isnY23
         uKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708690008; x=1709294808;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tuPkdtq9LHY/Qn47gQyKDNxBy4zBerQgmwmdHq9D61w=;
        b=td6ASMDlkGPFW87xjxnor9qrE7BkVlSOQktPR+D2efJ7CIXGedCDcOiuozlsB464Fq
         /KrHDnDkKjltetnAVB8ABJNNBkSMvV1f03PNXDOgyHzg0giRpDANv1VJKjTIDvp+X80V
         M1LU0Zp5YB3VV78pyzo835Gs4nm1aa47RBJ9fNrHVcgIMbxRPzDLpmAqrSqjcVHb6V3+
         wHi9CSFH1SFF9KtQGUgzJJPTD3lI9e3tGrDkFcDFyDisy/jtoMgv0IkWCG0vzBebO8vs
         TLjOKyjT9vluNTwIYBpEXJQhW95b70Q3JWYGUtMeaGta9sjZgEtOgl8G9Y96izoTTBOF
         i1gA==
X-Gm-Message-State: AOJu0Yy3P3pGsMDWEB8ObqWB3FrSwHDgdxttwx+Ftq+a+1D5NMYirj9Y
	l9Kw2Q4UT5o9HCNAJ5RKWnOnruj+1Ede/ZXjJtQY99vHgLy8T64euPj5wATzdunjFuMWJHNhodA
	jSZs=
X-Google-Smtp-Source: AGHT+IF5AhesK8M8Dm2d+AKBf4rS77m8/TvWMcHT6L1d+wgwYssaS3qnY7xf+oTq1qjZOupSvAvdCw==
X-Received: by 2002:a62:ce0e:0:b0:6e3:f013:463 with SMTP id y14-20020a62ce0e000000b006e3f0130463mr1364678pfg.28.1708690007777;
        Fri, 23 Feb 2024 04:06:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y12-20020aa79e0c000000b006e3e72a4f87sm11075613pfq.0.2024.02.23.04.06.47
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 04:06:47 -0800 (PST)
Message-ID: <65d88a57.a70a0220.af1e4.53e2@mx.google.com>
Date: Fri, 23 Feb 2024 04:06:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-424-g38943e302f8c8
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 10
 runs, 1 regressions (v5.10.209-cip44-424-g38943e302f8c8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Feb 2024 12:06:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15071

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 10 runs, 1 =
regressions (v5.10.209-cip44-424-g38943e302f8c8)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-424-g38943e302f8c8/plan/ltp-fcn=
tl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-424-g38943e302f8c8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      38943e302f8c8bda23c2853f688afa5e35cae90d =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65d87d15882f68022e637032

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/ltp-fcntl-locktests-meson-gxl-s905x-libretech-cc.t=
xt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/ltp-fcntl-locktests-meson-gxl-s905x-libretech-cc.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65d87d1588=
2f68022e637033
        new failure (last pass: v5.10.205-905-gb40421b142370) =

 =20

