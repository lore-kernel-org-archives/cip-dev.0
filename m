Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62484C636D3
	for <webhook@archiver.kernel.org>; Fri, 10 Feb 2023 11:37:55 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web11.12216.1676029065239660664
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 10 Feb 2023 03:37:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=PLlAPpuF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so5295828pjp.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 10 Feb 2023 03:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cFY2lgbVu4NtXpv8bOUreZNWSNIpcrfEBSAmC8HU8W0=;
        b=PLlAPpuFui/dGRvQnpT93aCyaloD9q4aoXz2qOa2OqlZvGM7zYdL1N+pj4BImRIW5N
         CnrvFI/9eYWae1Nia7dQJOn+mCUZQIhz1Irz0VobGqd5tISQZBMXNt6PBl1Q9gzDEU5Z
         W9UfIoqJuLNGcvRI+VtZFHbVfH/d/c7gsnSKRaLG6vwQ4EINVx0nZBGeXcinLGnGmeuy
         stVLoPMVClPN8GG3NwCjcAzZ1m3UdmUsOkmjbLFo8Ocre1Of7lupBhS86kMFUwxVFmKY
         AxVtSLxy9UG7HOTCbznjZgxw9TMKIk40B21cq2qMP+IIzjjQ5pUVM540poDVgLgMG07h
         5YDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFY2lgbVu4NtXpv8bOUreZNWSNIpcrfEBSAmC8HU8W0=;
        b=GyV+k68VSYWH6M3mljaoWEzib7qRMKt0E3osYbj4HXwiYFPc9/iSkqzH3YFNVVF4g0
         YZGOz/Qul/B1GTRYpa3wsPabMZ9NNaXBCnc0j0KHPzkCrMw8IrIR+cEefdSOwbPtpzfS
         7eWzk7WezglrcfMVR1jx/6eE+67E2kVe3jW/OvgrTXQcb7RNL25goEOdgJ1K/eVVW0a9
         nUwavX3o8EAiinSTCgezsZcu09z0EKhtAFdJ3E9qLkon+PoEG5iQv78fh48m3Th3b1i3
         DKbL+puM8h0+E9aLqGRj1nvPy8dgnsQeXHTiK8za3AkAa1E9mz5aNOvotXB/ax6oY6u7
         Ksag==
X-Gm-Message-State: AO0yUKUj/d9EkdmzO0jtDBOcpmnR2wG7pIyxmrqGB5Gi1W3GWsSsifMH
	gD6pgtDHVpAa9jAb4Fw1xHgS74TEpX7yXdbk8Uf27w==
X-Google-Smtp-Source: AK7set86ehXNPnWyxrISRQz6csxiZHHJpT+mGyAExtm8JhhGa8umU7R8fLAbwCx8yl2lbUB2xd4LtQ==
X-Received: by 2002:a17:903:283:b0:198:de07:f3d with SMTP id j3-20020a170903028300b00198de070f3dmr18540192plr.41.1676029064535;
        Fri, 10 Feb 2023 03:37:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ja15-20020a170902efcf00b0019607547f29sm3167390plb.304.2023.02.10.03.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 03:37:44 -0800 (PST)
Message-ID: <63e62c88.170a0220.3092f.5a60@mx.google.com>
Date: Fri, 10 Feb 2023 03:37:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.167-cip26
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 7 runs,
 1 regressions (v5.10.167-cip26)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Feb 2023 11:37:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10642

cip/linux-5.10.y-cip kselftest-seccomp: 7 runs, 1 regressions (v5.10.167-ci=
p26)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.167-cip26/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
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


  Details:     https://kernelci.org/test/plan/id/63e61bf16042adf0a58c863c

  Results:     87 PASS, 3 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-seccomp-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-seccomp-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230203.0/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_benchmark: https://kernelci.org/test/=
case/id/63e61bf16042adf0a58c863e
        failing since 92 days (last pass: v5.10.153-cip19, first fail: v5.1=
0.153-cip19-3-gc76f4e7e5c71) =

 =20

