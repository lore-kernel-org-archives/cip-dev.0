Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD760C678D4
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 05:00:58 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web11.38865.1674104456623128848
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 21:00:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=etwV9RDr;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso732525pjf.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 21:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=htBSSEnQNh0TuKxU0EesX+6wO43sURbrI6Zgoo0xcLo=;
        b=etwV9RDr0h8oi5ZvhAqx6m3DNh7wGR40Mn07SSYgKoLxmdBZsw6ND+vYsKZGwDAwf2
         VzuXhgdD1dA2rDMOdmovqmXIeGh+MdDqeoAM61OnxiTbeHO2mohWUSjWqorQAHqidehT
         qs3QPQ9ljEeLDp/0dSzLm16Ao9XJ+yivmxII52nNn5epIpsueCF+moSTgKQ4Uz8njCnh
         TD2GY+oSGWABYUfT3jggHdayAeepEtzWtittsfr30fcT/p5TmMuAADO1MDZ/e4PuPlKP
         ElGO9VrZO6iS+V6aazAGkWSNZrTgf36Spil2gfbabKYbHY+y8fnm9Zmm5t1yY37EHH5K
         8FDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htBSSEnQNh0TuKxU0EesX+6wO43sURbrI6Zgoo0xcLo=;
        b=hfZxY0igAW5c6jMjjfc1WpnU15ZLBdkH8yS5rwlzZaJPv3i+dwH32qNs88zPp7TJx8
         ba9sIVSnEIkWq2fs/VzL+5IdHeIxZVeh00DFLAXeG5eJx4EGchI7WenWFqnukrV9HSMr
         B36Qbi+ZZeHC8sr7ETTPrS2VQhzGiUg6oB1XAAvPDvc0YaOA3CRQIGXXPz3OnCS4gdr4
         Fcll9eLydUDx6l3wwPJ/QIH96vHKh8vw6qejeXPlR9cSlKwkM7JkXQDmpcFLznaiT5HX
         VzH6B5WN+Xc9AKKsW5dpksaGkaCNTtgyZOskk/9baKgiSl2GMMHXDTGVrZzminasVGvk
         JJ7Q==
X-Gm-Message-State: AFqh2koi+LFAI/C1kdAPd8Kb53+LBO6ZrA3VHiwsbqzRNY1avbwNwNwc
	iyiF3s8IzBRXggdUuoQfEFuD9mMQQ25NSPGRaTJmpg==
X-Google-Smtp-Source: AMrXdXsgJwQL2gXV0cG+00gJZuxD6jd+a/8Kr81mFvKg5oA+DICexCslg+Q27OwI9j4XD9T6n/dvSQ==
X-Received: by 2002:a05:6a20:9c89:b0:b8:72f9:8e5d with SMTP id mj9-20020a056a209c8900b000b872f98e5dmr9726565pzb.62.1674104455754;
        Wed, 18 Jan 2023 21:00:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k7-20020a170902ce0700b001929827731esm23900853plg.201.2023.01.18.21.00.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 21:00:55 -0800 (PST)
Message-ID: <63c8ce87.170a0220.a8293.7183@mx.google.com>
Date: Wed, 18 Jan 2023 21:00:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.269-cip88-rt28-rebase
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 5 runs,
 1 regressions (v4.19.269-cip88-rt28-rebase)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 05:00:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10425

cip-gitlab/ci/pavel/linux-test kselftest-futex: 5 runs, 1 regressions (v4.1=
9.269-cip88-rt28-rebase)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.269-cip88-rt28-rebase/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.269-cip88-rt28-rebase
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      09932a66d6b63564f8b94b34721b1f2d38ea9575 =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b8b67c51e9c3ce915ebf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230114.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/63c8b8b67c51e9=
c3ce915ec0
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =20

