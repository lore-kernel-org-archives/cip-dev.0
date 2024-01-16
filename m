Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657C7C4706C
	for <webhook@archiver.kernel.org>; Tue, 16 Jan 2024 04:45:12 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web10.4743.1705380302141787645
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 15 Jan 2024 20:45:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=nmKIsz+R;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d5dfda4319so3043985ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 15 Jan 2024 20:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705380301; x=1705985101; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UKtAKPVv4NBDcrcLWHVBgstyK+reydJTo5oScxnVi3w=;
        b=nmKIsz+RiUMmafCmYiIvdV2xBeVKiOg4R9rgSpijNxyWwnNnTqzQpXWCVY6E81+OQi
         Z73b3e326GDo2nHjwig5Qm+rMeqI1LJ657llPJBbzCW0lE3YGyhj0ubGqZFvK0yJlqJE
         PoKnFJZNUHW16UsZBSCQixg1afvV5MqjV/Ai105+FLhO3yYqyELF95zUwraPfixtp9Vw
         37bPeb1LYAc+CvDk7BVaX5qvESVg0R+c5AB6FJN04mYTxAPlCfIH/JrGw5h/oMV6oh34
         hxmhOFAQxp/NtA4nBL/m6PR/p4sl3I8TviLwPizAQbRNkWX4MZHmMvD38tarc5BlM5Jk
         d0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705380301; x=1705985101;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKtAKPVv4NBDcrcLWHVBgstyK+reydJTo5oScxnVi3w=;
        b=LyJDQTG2bQMwEU+eufo1UJhp6BYeOffMUXKEvVDk2+NuIvzAby+p7f1wswIAPo+7H7
         EsF8yVxpYO1CI3NrKgCDCjjqwehbXbinBD9bASR1OP4kWoyEErNdLzg1vdnzlKGTaDzt
         0MPhvinlP1XG6TZM0vuESP6lf70Zb9tKQrzVq36oNCUYWfNFoaz0syQ4EB1wJ9M6gfuw
         m3DuUlsK2BvQDHb9Gk0R3pOqscow28jrCt4xYvYBSkxCYUgyP7cTkEu1lGwb9cEFj8Vr
         ra1vsjPO3UdfyyfTiN/9Pg9Dr9H5rJr9PF94frjNMlZRg3EPzLVMLem5qA/0rp+gJyx7
         RP2Q==
X-Gm-Message-State: AOJu0YyHie8R+57Q652ABaigK9QZg+f1me92lcXff9diyQnrdEdBhdJK
	dxLFYXzcJHzn65L8gBxw5kPNnk462LwBXts/ea0lDOEFtN6H5Q==
X-Google-Smtp-Source: AGHT+IFdAN6CtMNW1RWc1qCl5NgQJZsC3HkLtg83jigV7Vvn3YEPU9vUYcgZCYBAVsuRShgbX2PmTA==
X-Received: by 2002:a17:902:ecc4:b0:1d5:e8ef:bc59 with SMTP id a4-20020a170902ecc400b001d5e8efbc59mr254666plh.115.1705380301220;
        Mon, 15 Jan 2024 20:45:01 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902c9c400b001d5e652fa5fsm359875pld.106.2024.01.15.20.45.00
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 20:45:00 -0800 (PST)
Message-ID: <65a609cc.170a0220.75a5a.13ec@mx.google.com>
Date: Mon, 15 Jan 2024 20:45:00 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.304-cip106-27-gf3e967c370d44
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc kselftest-futex: 10 runs,
 1 regressions (v4.19.304-cip106-27-gf3e967c370d44)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jan 2024 04:45:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14391

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc kselftest-futex: 10 runs, 1 regr=
essions (v4.19.304-cip106-27-gf3e967c370d44)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.304-cip106-27-gf3e967c370d44/plan/kselfte=
st-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.304-cip106-27-gf3e967c370d44
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f3e967c370d44f37d5b1b2cc02e9898573c4a4ee =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65a5fc3f4c0cc19dda52a443

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-27-gf3e967c370d44/x86_64/x86_64_defconfig+x86=
-board/gcc-10/lab-collabora/kselftest-futex-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-27-gf3e967c370d44/x86_64/x86_64_defconfig+x86=
-board/gcc-10/lab-collabora/kselftest-futex-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/65a5fc3f4c0cc1=
9dda52a444
        new failure (last pass: v4.19.299-cip105-289-gad0914f265af) =

 =20

