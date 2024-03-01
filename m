Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47181C5478C
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 15:57:55 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web10.26798.1709308674858261398
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 07:57:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=R4gOrIQF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d94b222a3aso23813715ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 07:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709308674; x=1709913474; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EL12mY07CjNnmvP2pSwieI/mDLm+EuvJdZvLeY79Xjs=;
        b=R4gOrIQF46OEjzHEdf0REOdMx3R7mF6Q9I1JXDfT9NyhjVUT6WulitQejsdinvTYMW
         n4IU4CwuHug5CfS8cEyWEexhR1+H3Ch1virJBRMjUyEa1UTOf+okge7J5+/JF3Jl5oR5
         9z00+Loga3AcWiYNg3ErFkSIh36AYcxClNAOrSsQUZb531Y/BP5eidgnC5B37QbIK+/b
         7vF9+POsudF9DQSOVNFbFaCuecYlfcZzib2t7JiMC8YD1+6Na+w7AXztzyKGdYCo4R7Y
         PLil7ancF99sqztRADqm/i9P46rpPoE9NtphZin4psLVop6Y+mj2yTB6ZNYUQ/UEt1kO
         HT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709308674; x=1709913474;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EL12mY07CjNnmvP2pSwieI/mDLm+EuvJdZvLeY79Xjs=;
        b=EV229aG/ybQ3UImVpv6P/N95oNzZvXxgeTjzGENP0oAG/9Re/4n4Bv3hWqPtZXwOlq
         nX5/VethIzzuCPej11Yzy/C7BzDAifjFuMPlGtF4Mi5S1vavarMaeoWgbFsFdwyIs/WQ
         uz/Y0BhzO1V7+sSkucoPuaC6bZBxQuJ6EUH64bop7bz5i8EQfxBbHBfFQYfwnuvr/OPR
         2R+kXk3Qx8iK+kkHbncwz25jCG5AJ1DVt0WZW4QMMnhOb9/IkI6EqYeMivYSYAxPgwur
         C0anREsZWDTBK3Tiy2NxUqgV0QKhYThQxjqcVj12IQ61/i/GfTDw3/+0ge4XPimtWfJE
         8JEA==
X-Gm-Message-State: AOJu0Yyf+S1DCyw8FYHODgzyUEx//VGy4jJQEXoGdl6EJzlNlK8f9TFw
	tT7OBkVvXX8ExsArq+kO798wcY17a4gUlyuzm2xc9bDBel17zoSGPLhg+grA+atmq/DYddZSVKK
	VGEU=
X-Google-Smtp-Source: AGHT+IGrKwq0srPi2twMwNW1pIMXFbCy3qnB1E0Rw0u7usdv42ixDin4XKTEsLRI7C6LRDe8S567Bg==
X-Received: by 2002:a17:902:6ac3:b0:1db:9fa2:3408 with SMTP id i3-20020a1709026ac300b001db9fa23408mr1819271plt.42.1709308673874;
        Fri, 01 Mar 2024 07:57:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k12-20020a170902c40c00b001db5ca97817sm3602389plk.68.2024.03.01.07.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:57:53 -0800 (PST)
Message-ID: <65e1fb01.170a0220.45aa5.fe3a@mx.google.com>
Date: Fri, 01 Mar 2024 07:57:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44-56-g6ff909810a18d
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-pty: 10 runs,
 1 regressions (v5.10.209-cip44-56-g6ff909810a18d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 15:57:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15127

cip/linux-5.10.y-cip ltp-pty: 10 runs, 1 regressions (v5.10.209-cip44-56-g6=
ff909810a18d)

Regressions Summary
-------------------

platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44-56-g6ff909810a18d/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44-56-g6ff909810a18d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      6ff909810a18da01523521db983d48116abb28ec =



Test Regressions
---------------- =



platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1ec3eb39af1d9e0637086

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/riscv/defconfig/gcc-10/lab-broonie/ltp-pty-qemu_sm=
p8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/riscv/defconfig/gcc-10/lab-broonie/ltp-pty-qemu_sm=
p8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



  * ltp-pty.login: https://kernelci.org/test/case/id/65e1ec3eb39af1d9e06370=
87
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da) =

 =20

