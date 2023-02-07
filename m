Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90C5C636CC
	for <webhook@archiver.kernel.org>; Tue,  7 Feb 2023 08:15:59 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web10.78720.1675757758507905607
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 07 Feb 2023 00:15:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=jeCa1oeM;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso17785947pjj.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 07 Feb 2023 00:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6OetqUD/WVuL68lObBVs2CSOp7Lo91tjf+rDz8kE9wE=;
        b=jeCa1oeMpkJ9AblXon58vX4EAIs93DKZbgBB5rqc7XZZHUJNzQVhOLQvD26ZrhleC4
         xM9e9/OlfbKrMytmRFOKdDrtH1rjFA8hQTgq0Ox7nHBXP+y9uh5Ek0V1v+B6ovOVsxRj
         e8IL+yHaG5eEYGtFRnYtBfpjEOqT/XBwajnEebxcxEUVo2MtOfJhyuw3RzKklh+uslXd
         SPvQdk+DsXTqmBeXKVCP6zHXtMTzF5zNsfYD7Lqla3UNFQc/xtYjhhuU/5oyrUuYF5xi
         9DBlRTeesK8RKZhVqIl8tQBUM0/p5BDjsP0y/3OokuogzgboPkkvmegUU8MD7aGYg+dM
         +tEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6OetqUD/WVuL68lObBVs2CSOp7Lo91tjf+rDz8kE9wE=;
        b=iaHngr+Y6Do3fsT/jUsRsSqEjrVuXiyFvby5rkpF5HKwe0nu5CzOVdfOAsAHCNsNEK
         b44ee0Cw03bMXN9uwx3t073Tfm+hbX5l+9N1Z3KkLrRiKhRJuQ88SZUibWU3bI5ZJPFP
         cnMfoKrcjavaFeJ79p4GWgSAxClS3f99XqVZbULwbfZN8HTT10hdPx65z7dkW/zwnkGz
         ACu+UeVPsMv5gXxOj/IB6mq8zAfqdijpql18a5Nlj00hI/dUQWDuepnLkIVERYMaTdi5
         rZF1N0l4UzOsC0JJpBP/VuyI3g3dSMpyEJ/vzK0c3xfXIW4HTlF+Dr+DrQYM2fGaWmEW
         z36Q==
X-Gm-Message-State: AO0yUKXIW3XXM9kJ1+gXrLeuu6QHHapyD7/ZuNQi1WaEO08FNntitKxk
	Mil9vB8wGCHWwXEYLKYNE4FiSoVyPUUpJe+XS7jq2A==
X-Google-Smtp-Source: AK7set9XRNAxUKbRFP2TOvkwCSNiIJg+WrOrI2w9QgJ6JI6+aTGH0DUoX77LijcZnrtSWgE2gtBVeg==
X-Received: by 2002:a17:902:e0cb:b0:198:c6d1:cc03 with SMTP id e11-20020a170902e0cb00b00198c6d1cc03mr1751280pla.24.1675757757828;
        Tue, 07 Feb 2023 00:15:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r21-20020a170902ea5500b001990f71d9easm4009403plg.226.2023.02.07.00.15.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 00:15:56 -0800 (PST)
Message-ID: <63e208bc.170a0220.5cc93.6aa1@mx.google.com>
Date: Tue, 07 Feb 2023 00:15:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.4.302-cip72-rt42
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test smc: 3 runs,
 1 regressions (v4.4.302-cip72-rt42)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Feb 2023 08:15:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10624

cip-gitlab/ci/pavel/linux-test smc: 3 runs, 1 regressions (v4.4.302-cip72-r=
t42)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip72-rt42/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip72-rt42
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      fe1cf8ef6e9d76107c4a6e1bf8cc27263abe6698 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e1fad41edb63e3f38c8637

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-rt42/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230203.0/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/63e1fad41edb63e3f38c8638
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =20

