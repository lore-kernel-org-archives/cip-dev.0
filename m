Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79226C433F5
	for <webhook@archiver.kernel.org>; Fri, 30 Sep 2022 11:50:08 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web08.4761.1664538597417644801
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 04:49:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=RjPCQs0I;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f175.google.com with SMTP id v4so3947582pgi.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 04:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=h1fxJAZ6IlUgt78BgI5pIcmBlbpE1M45BKmZZHQpTq4=;
        b=RjPCQs0I39kHTOF5olxKemqS730JHvi4/cLuCr7PCmmlArcTTgE5zXu0LDDuLRm3Nj
         eINEY0Da9xdNfR6aObxIgNxuEOpjRMtoMfwEABK8bLf0Wbr9rQ4ED8V5SzcMOB+abvmC
         VqvhKZvQtJ/inv44H+GOv6rDKAUo4rEMloUykg1HnoGDFphm/VVuoVxI1K7IDBj5sbHd
         1G8d+hu78y7UuWmIPEzLKOYuos6J0aEALy7gHjmkG1sq3NVHUJjtGR6cApRvUd8M+HXD
         L1q0l5KmfrbBG6Ns7xC+MKHbWxbjqpKr+qXPOqCSuYFqZyjFB1wqZt2qZVYycXUwfvdp
         SjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=h1fxJAZ6IlUgt78BgI5pIcmBlbpE1M45BKmZZHQpTq4=;
        b=5tqUUcVB/J2vovyPFk7YdkxfO6dy1x4x7CnFNQ+DHkEuhhebtqH5qj5RcHmhLaVa9E
         2PIbtGNHiV6I0c8N0NAxZk5f9cWUfWkXouZ2+b4uKCIB1d7lATS8JFV7aQiqiWignkrq
         c6vaN9jSXlYfVfPgjFBQbbdY2fGJvwWCsf6aAkOS+YEdGxkfl+sh4IXTJ8Fl+2buieOO
         Y0gF9dImk/BA2Odn19Kr+wWq2TMExNEGcGsNGGIIS4kcygbVpTYJQUiGKkF16235s+2P
         vFh/8DfLWNJGvy1Nne1ZJstFwjd11Og6TZZ+mhJd5eR4MAF6B850wI6/2FllVF6v4ieH
         DAzA==
X-Gm-Message-State: ACrzQf1nBzkeZuXQMnlCZkWhYXDHmHtsQx4y0ZEEWVWKneFQMLVEHe3z
	xeMM6FxIiOPAg1m/bykwcn5LViDwS2FB7gc/s38=
X-Google-Smtp-Source: 
 AMsMyM5ykakWjpMrGuZm5htwQ1DSVt/vOMDOYKcbWV6ZlEr/9walDuvKvKE9KpqJM77WfngJvwb9Gw==
X-Received: by 2002:a63:fe4b:0:b0:443:4b49:7d86 with SMTP id
 x11-20020a63fe4b000000b004434b497d86mr271516pgj.326.1664538596767;
        Fri, 30 Sep 2022 04:49:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 k195-20020a6284cc000000b0052d46b43006sm1590019pfd.156.2022.09.30.04.49.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 04:49:56 -0700 (PDT)
Message-ID: <6336d7e4.620a0220.5e2ca.2b86@mx.google.com>
Date: Fri, 30 Sep 2022 04:49:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-cip17-422-g411cd76b5afe8
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test smc: 9 runs,
 1 regressions (v5.10.145-cip17-422-g411cd76b5afe8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 30 Sep 2022 11:50:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9586

cip-gitlab/ci/pavel/linux-test smc: 9 runs, 1 regressions (v5.10.145-cip17-=
422-g411cd76b5afe8)

Regressions Summary
-------------------

platform    | arch   | lab           | compiler | defconfig        | regres=
sions
------------+--------+---------------+----------+------------------+-------=
-----
qemu_x86_64 | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.145-cip17-422-g411cd76b5afe8/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.145-cip17-422-g411cd76b5afe8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      411cd76b5afe81569858976d0e9819ab48717fcb =



Test Regressions
---------------- =



platform    | arch   | lab           | compiler | defconfig        | regres=
sions
------------+--------+---------------+----------+------------------+-------=
-----
qemu_x86_64 | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/6336c722c10da48f61ec4ed3

  Results:     15 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-422-g411cd76b5afe8/x86_64/x86_64_defconfig/gcc-10/lab-coll=
abora/smc-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-422-g411cd76b5afe8/x86_64/x86_64_defconfig/gcc-10/lab-coll=
abora/smc-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/6336c722c10da48f61=
ec4ed5
        failing since 44 days (last pass: v5.10.131-cip13-49-g1145e9c6352e6=
, first fail: v5.10.131-cip13-84-g5fcbe4a63ab4d) =

 =20

