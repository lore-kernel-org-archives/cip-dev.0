Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7B8C10DC3
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 21:13:10 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web10.104222.1701983584176023532
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 13:13:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Zm1+nuXZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-286e03467a3so1273607a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 13:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701983583; x=1702588383; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g8nsV6aOsvQSsNip0gdyldZmNroTGQUt9mg4H3RyTd0=;
        b=Zm1+nuXZok+xiUVBgqxi62+32biJcst/6eeoCNrkPmZ2XB7L/83VuwBJDbnTkymikX
         eGD1LiAky7aF6HDhvbsQMAwX0Rs5CIw8cVjFU2uRKJK9k9bgp2aGslLoflqs5wo7bnlm
         RuVubSt6hddUTS0Smu5IstNnjjUygVSlGncF813Ho9CuVCyNI0O8ZsfcC3pQb7a/qxZy
         bGNqS3x60GgBjEfY6aXtGSnY3lD4vQouN20ujWobcB+foR9SvivqTuUb/S8FpHYswFVK
         RG7fXJVP4oDZzNTbOtVxBBH8hIjFV4t7pMEEmBwPqB10CSShqFZ5rJ8bGENixdVjxgb5
         PYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701983583; x=1702588383;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g8nsV6aOsvQSsNip0gdyldZmNroTGQUt9mg4H3RyTd0=;
        b=acVYHUQ1vVB/pnTMgm2yznD43RikrnDdFGUD3HCVV7YuTYOZStHVErcrXymsWX29b1
         sIC+cbIQir9TsHdhwM4lBj8jOgcT89F0q9Zjz4C2INxql6Ca7fWXFVdpzhOjyRrMfzK5
         zNJY47E4K7m4CYbJzVYdmrhlTFCEk5QN1PTChI7neq56nSOWiMpHN77pQLE/xblsnCdB
         jWRibx+Gj8RW3ub0hMZrX688MxiSTv1EMnP92IUkpYsbyfV9+4V+zrqA5Lr4QbiCb8eR
         2sL4QapekQ7XvZGreVMjeyJBKTzB6r0gCvSTrde8r2e7wNkEueoj22YYqbhXFw1MdpJB
         /Vig==
X-Gm-Message-State: AOJu0Yzwg12HbJNk7reUubJq47mLjHiI+/MHLER9OhaCf0oniHb+bVKY
	Hilw7KrInIhFGIDBxTtSDyosNaOmUL8O1HEgQM15aQ==
X-Google-Smtp-Source: AGHT+IGR/vqULBiawA/s/go8tjqTuCQD4vj5BbEt1yqdZ222WZhA2jPlmoAMOtm5YGstY20K2LZPng==
X-Received: by 2002:a17:90a:1999:b0:286:c018:dbda with SMTP id 25-20020a17090a199900b00286c018dbdamr2568085pji.44.1701983582929;
        Thu, 07 Dec 2023 13:13:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090ad48c00b002839d7d8bf3sm1849168pju.55.2023.12.07.13.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:13:01 -0800 (PST)
Message-ID: <6572355d.170a0220.6089f.5885@mx.google.com>
Date: Thu, 07 Dec 2023 13:13:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-28-ga386bc478aa6b
Subject: cip/linux-5.10.y-cip kselftest-filesystems: 9 runs,
 1 regressions (v5.10.201-cip41-28-ga386bc478aa6b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 21:13:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13912

cip/linux-5.10.y-cip kselftest-filesystems: 9 runs, 1 regressions (v5.10.20=
1-cip41-28-ga386bc478aa6b)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-28-ga386bc478aa6b/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-28-ga386bc478aa6b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a386bc478aa6b422e6dd5d92a540987ddfca9397 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6572280ed91f0a6fb4e13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-cip/kselftest-filesyste=
ms-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-cip/kselftest-filesyste=
ms-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/6572280e=
d91f0a6fb4e13476
        failing since 64 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

