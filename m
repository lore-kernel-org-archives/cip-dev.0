Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CB4C46467
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 21:20:46 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web11.29544.1674076844759245571
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 13:20:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ojelOBep;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.178, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f178.google.com with SMTP id d10so25487838pgm.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 13:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CVxZnmwuc8Nu4b1G8894sEEo1jjHEWhEcEftV3ZetnM=;
        b=ojelOBepcOUR7qoVJNuiCl2rE0YDQXPCSFX/xuh5B3P6orL116T6NXXEUZocYuSWHR
         j9aHCylVMBKJcZqQ7HjdmCllO+F1OV3v5+vSkj+oUQG0/tmgm6eOqngCihEYi0GtfPoC
         xdpyd4PB72NvGsnadm36eqic2RwMTdKow8uDXFSNzmfDH8nwjXKqYcdjlS64RWnd3AVb
         lwPwTor+7k1mBgD4R0DsQFBPc7sURK+lPFvu1i6BDIIizW9jbCEO/DFt4ssJ6IJf9KAy
         XcwL+yH+wvdpPAcuL1sAfx6c8Q8p2RRJARgdXGe0kPaqVm+ZtXIHaDpfkx/Hb8IYptJa
         dAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CVxZnmwuc8Nu4b1G8894sEEo1jjHEWhEcEftV3ZetnM=;
        b=IUcQzMAMwJEiKQIKLSmo/NHPvvmGhfTBfHhWBqQWzkfloaCtmN20Ch60v2JnArIcZV
         IiPUJKB3vNFpCPOjO4RmETnKsysWsPYmOAths/5spycIh77wEOF9VnvkZ3wAnJhwfXhG
         N+L7Si3Td/Hm38fZe46a5O21yYgH8W0tjg7TReKSaEMO3QgTs+KRF5HWb8+7VdbsoSCR
         g4UT0BVbszcM3xMA0JaoAp0wqB1tegSf4BOeuinaryAkRrc7hUzteyVrt203nsl7zUDE
         YfO7lB3IiuYE+mZd0AjAFfPFKq7jv/P6T/6RKaT73IpenhuUzfy79OHlz3BcOzkFsHO/
         /3lw==
X-Gm-Message-State: AFqh2koKTgxQiZB0nfaPKxhPcVM1VxZR7ZzzUslPNc7HVvZXuOJRrkPO
	lhA4I+aU54ZHKAQi4OCowOQTeGBonhFIwmqaXFDPaw==
X-Google-Smtp-Source: AMrXdXtasJrNX2V/KxTMP9l5iIXrt3LvphdjvlDWQqE8IzdpQJt5ZTdJzJy4Vj5ep0EP9oRGTfbSJQ==
X-Received: by 2002:a05:6a00:1887:b0:58c:b0a:e504 with SMTP id x7-20020a056a00188700b0058c0b0ae504mr11191814pfh.18.1674076843794;
        Wed, 18 Jan 2023 13:20:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y15-20020aa7942f000000b0058d92d6e4ddsm7325275pfo.5.2023.01.18.13.20.43
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:20:43 -0800 (PST)
Message-ID: <63c862ab.a70a0220.90171.be40@mx.google.com>
Date: Wed, 18 Jan 2023 13:20:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.269-rt119-1495-gc851fb1e222f
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 4 runs,
 1 regressions (v4.19.269-rt119-1495-gc851fb1e222f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 21:20:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10401

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 4 runs, 1 regressions=
 (v4.19.269-rt119-1495-gc851fb1e222f)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.269-rt119-1495-gc851fb1e222f/plan/kselftest-filesyste=
ms/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.269-rt119-1495-gc851fb1e222f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c851fb1e222f4acf955da1ad9b020f3fc8a51c4b =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8541a44b15a4b70915f3a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230114.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63c8541a=
44b15a4b70915f3b
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =

 =20

