Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8B7C6FD1C
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 08:33:02 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web11.37603.1679473977585313671
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 01:32:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=4n/kd93B;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so7920046pjb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 01:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679473977;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AdLG6iFJnCBxBJfRZyrr+IsYiea6+e6afiHd/dxyK2Q=;
        b=4n/kd93Bgcy6jG67b8Ko01q34qdoJ3AykoUDzAqzFv18fXpSU+uSbgf9ppAnyV6TV9
         gPGxqW0P+AWG3HbcyMYKxn+0uabiMop8949smjSF42kgbD0e378CD5DDUWo+77cK77sv
         ERyw86ZabLhL22R24mdRkLkhgPRHpCy8SJAO8Sw8WarxaX25B7p/m8u3gt7/F+BIJSKE
         Yjc9teymF3tI8XMH86fwLis/r35UXv1hutSYx0KmmgJwrT2c8b/9GAqTxH5m7/Aexvso
         xq0Gmg4uzW7hmzMcW6HEIGO3KPVcbeh+ub0zIQHSoUKeMmaT1bDd0x9b385CuZXixMLd
         qWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679473977;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdLG6iFJnCBxBJfRZyrr+IsYiea6+e6afiHd/dxyK2Q=;
        b=xkywlM4QklyyalapF/yF3CUy6nyVAT+4mWXXnYpGdYiBPElVloXBKL456Mz+ypsCZP
         GNOF2dQ5g1KeVmWiqnzyu/P3GTamvK9pbfojYaWaMglf9VtYUzt1ZEB7PXZqMAumsELK
         5BQhFygSKLib/YYPie2TkrMuMjULmBjui6GMIOtCQ/KiZURcV0S2UHJEf20ViPC3/g4I
         QVSP5vzDzbX2w9OMsr7rmgNigg5QdwnYhiVUcgubTxBpSbVNKZluMXW0vTulswRNCFyg
         Dw4fcpZmupT/LC9O4S2nqqMU8lvXzJ6cN/lmufKil6QX/kzqW3JaWRX2JwfSy7uPHvjb
         OxBw==
X-Gm-Message-State: AO0yUKUD5qipedorSQGw7a0wDycKfnxY9+aMFP42OMDQQ2ILRErgLjlj
	w9dt6IxFCEOy+gX+8q+0EPb6M0KrA3OABOiLZLY=
X-Google-Smtp-Source: AK7set/ewyCSR4DZgQxmcEpZNLHx9dgLQJAcuexLQNw53X4+Uv8aVwPQjFS5CsoXwFljpc19RMbwrw==
X-Received: by 2002:a17:90b:3eca:b0:233:ee67:8eb3 with SMTP id rm10-20020a17090b3eca00b00233ee678eb3mr2953838pjb.24.1679473976873;
        Wed, 22 Mar 2023 01:32:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p5-20020a1709026b8500b001a1aeb3a7a9sm8787154plk.137.2023.03.22.01.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 01:32:56 -0700 (PDT)
Message-ID: <641abd38.170a0220.ef1ff.f99d@mx.google.com>
Date: Wed, 22 Mar 2023 01:32:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.175-cip29
Subject: cip/linux-5.10.y-cip kselftest-filesystems: 9 runs,
 1 regressions (v5.10.175-cip29)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 08:33:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11054

cip/linux-5.10.y-cip kselftest-filesystems: 9 runs, 1 regressions (v5.10.17=
5-cip29)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.175-cip29/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.175-cip29
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      bb7267e6d2a6f131bb46ba14f0d3c418379e8bd4 =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aa961bcd66af1329c9512

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/kselftes=
t-filesystems-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/kselftes=
t-filesystems-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230317.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/641aa961=
bcd66af1329c9513
        new failure (last pass: v5.10.173-cip28) =

 =20

