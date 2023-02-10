Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2F5C636CD
	for <webhook@archiver.kernel.org>; Fri, 10 Feb 2023 11:37:55 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web11.12215.1676029065134349360
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 10 Feb 2023 03:37:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=jOeq+qj7;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id g9so3283073pfo.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 10 Feb 2023 03:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E422h9hPWlzrjpqJAkzMKY3iDDL1JNCqRGnR43Nh5t8=;
        b=jOeq+qj7UDmHo4idpMUVxAYzAooTbJBFG6v1c5w8j7jKme/b8b3wgSuE4kQxA4YD9C
         7G/XrJ+4Ndbtd3eVncmi2rUZPABX71bFyM8vk3zY5oNdILL2PCPWki1kGhW4VTpZFO4d
         olV3qv1au0kf+mqXLZgsALg63oc+vKROQA+V3MLLVZtBgfwmzA0l7DLK6bOgVuoHYcnP
         F8PyJwHlYN0i1qAuSn2pdxoYknuEbpGC6okPjGopEGE/+vF4LwyMBduSCUpcfRyd2q3z
         cC//rc4D8vEdS04R2jvslcug0x/skoCv4Egq89a+ZIFr3DvjU6oRlcuGK+tnD/k5JC+B
         ipog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E422h9hPWlzrjpqJAkzMKY3iDDL1JNCqRGnR43Nh5t8=;
        b=XYDArbcy4l/SDvVods2FPFiJPUan/oeo3PAOhkxtCvl0UyuvJzrL9WFaZLYUMkbF2b
         54grFwEykDA428J+DALUS6mc5nlI3fz4bcVSe5GXDD6ovQKVNvw4SToKkPXu2Dz7RavA
         Ci72LvJSH/G6MEJ9P2xX6fjFqDLCpLJV4rSUQNLl5iXuiwwHPe5VwJX6D0q7w9HuTyHE
         Mbiilrf9QjYWSrpg3OS9OE0R9VUxs/v9owdIkPz45xHWqh38FLoKh9kKY7ZWXLykBT7S
         PbNGhW6aNaqaoFYFro7wrBf9/CzEOVBs2uJJMxaDrvaP12i6V89jB7gp67wYvM7NmNON
         9JuQ==
X-Gm-Message-State: AO0yUKXppwSmxahE0v8YCDGQ+a9RSpoqWnRmv6Jzujb4Arzj2Ct5O7AC
	3+vloUDoyBhCMct/XRAuaSMvw73budd4/4ZJJ28+kQ==
X-Google-Smtp-Source: AK7set+GiZr07B7D1Gf9BaQtimOmYTM/Z7WQFFX/txRQoFE6rxJTcHfO5wOL5/aEWfTgI/5feto9mA==
X-Received: by 2002:a62:6d85:0:b0:590:7616:41eb with SMTP id i127-20020a626d85000000b00590761641ebmr11045127pfc.30.1676029064312;
        Fri, 10 Feb 2023 03:37:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f15-20020aa782cf000000b005a84de344a6sm3222052pfn.14.2023.02.10.03.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 03:37:43 -0800 (PST)
Message-ID: <63e62c87.a70a0220.d1cca.5afa@mx.google.com>
Date: Fri, 10 Feb 2023 03:37:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.167-cip26
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 6 runs,
 2 regressions (v5.10.167-cip26)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Feb 2023 11:37:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10641

cip/linux-5.10.y-cip kselftest-lkdtm: 6 runs, 2 regressions (v5.10.167-cip2=
6)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.167-cip26/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.167-cip26
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dd0dd3e572fd82c1c232ad1f089ca628d7dc16de =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63e61bc07e04be7d6a8c86b9

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230203.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/63e61bc07e04be7d6a8c86bf
        failing since 227 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63e62128531089a8cc8c865f

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230203.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/63e62128531089a8cc8c8665
        failing since 227 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =20

