Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4FEC678D4
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 00:28:47 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web10.33962.1674088126872688023
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 16:28:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=vIuxaK4t;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id o13so776087pjg.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 16:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HmxbFKziR6AE4rOjb9YjtRSJQ3eyVdJ0Icn8A26Vhs0=;
        b=vIuxaK4tUnHRNyv+PFHkqhBFxavXnd2cFvxcrz7GG69nABXb2KDm5wlaQrhICIehjO
         zRS1y/oxtUmCxwBeRUgjJDfAFVp9nJglehjlapwP6ptMbdWn3fDwsV1mTfMaGho9STKT
         +S90GRIwx7Q1tmgMECZU+mnEvDjVG7ZLB9B9Ge6eVFGiD4A4wGqyEcdh7a1/Hu3K7jrI
         qCwoMqcC2JXON0jR0fPaOlL8yjhCdRJG9Ma1mG1PJwI8vQzV/sGc0t7tQslMu8z1IfS/
         M/j3Pu8rp/5yo3lv4Gcqmxh+7uX5qWJ5R570iijvpBFJsLlcNEMpHjG+MPkKb0JkK6NM
         MI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmxbFKziR6AE4rOjb9YjtRSJQ3eyVdJ0Icn8A26Vhs0=;
        b=B0dTzg+Z5UIqqs9wROv5vLy7jr8hdQYj9SXP2wMJKNrfCrIwG6D7SOeLdZmpwLp8kY
         U0L9eR2ruBsgbPj85TH5TAw7NX9366e2TV3Ew+VJlvXCZPL1a3O4jT15UUf+hliwNPuK
         uQd4rtTIOz/CrG8ls1AA4zJNZwqqaRiymxhCXGZrNt9cbIHr3z15P3iECDOhqZ53VZAP
         nUf9lZjtlqQD9i88elDoRwADV5rxCHJNlr8Rm5tGj4EiIVZya/GLVTq48IVTITkRWpy0
         /4QQKpa/IFwgZlHe/6IXScGrWmu4GSnViN7b2JmwIz++HCtIKkKcQRwscfQEv1ewq/lu
         do6A==
X-Gm-Message-State: AFqh2kpH2cr4IXjUvP6JjHKqJRyfNNPs6Tt+HnIEeaMPFyV3rIYKL317
	pK9PkDg1LmPZF3MqXx7huQncH7OYWjpFJaFT6haqOQ==
X-Google-Smtp-Source: AMrXdXsuyshrwCz7vrbaKi1AXMwu8M+XXxuBtBdJrTlP0aQDnhJkZW0yCgwh5VFe+mr9jG8tk0UiIg==
X-Received: by 2002:a17:902:b28a:b0:194:996e:aafd with SMTP id u10-20020a170902b28a00b00194996eaafdmr9584258plr.34.1674088125744;
        Wed, 18 Jan 2023 16:28:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902e84a00b0018975488514sm2293501plg.126.2023.01.18.16.28.45
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 16:28:45 -0800 (PST)
Message-ID: <63c88ebd.170a0220.9572a.4334@mx.google.com>
Date: Wed, 18 Jan 2023 16:28:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.269-rt119-858-g4aae57dbf650
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 8 runs,
 1 regressions (v4.19.269-rt119-858-g4aae57dbf650)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 00:28:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10417

cip-gitlab/ci/pavel/linux-test kselftest-futex: 8 runs, 1 regressions (v4.1=
9.269-rt119-858-g4aae57dbf650)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.269-rt119-858-g4aae57dbf650/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.269-rt119-858-g4aae57dbf650
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4aae57dbf650bb88d187f251ebdbd3984020b619 =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87bf87df42ca9a1915ee3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230114.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/63c87bf87df42c=
a9a1915ee4
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =20

