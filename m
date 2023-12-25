Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94186C3DA6E
	for <webhook@archiver.kernel.org>; Mon, 25 Dec 2023 07:12:43 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web11.56626.1703488354515664000
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 24 Dec 2023 23:12:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=j1EKMdTZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.172, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cdfa676fa3so1230048a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 24 Dec 2023 23:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703488353; x=1704093153; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8A3RGyZWHwJqKE33Ccn8Ly8rCpKxNaRKK7sfZw2jcU8=;
        b=j1EKMdTZ4qR4RXQliK9+20u3e5nnqw8zC1+5H71xc/8T57kx/twKF0emin7vHCrmOX
         tw394bBBNMko3croR7AgOmMtr83MfwPAtevBPJmn+FjsjRxko3YJPTj3A2ujuiOF2Dai
         4tLSQ2Vnd62b2Fgid4f3wgUfUixdgI0AHSRnTuu/380e2D/74V3AAlnJy+CGDBTVWPzI
         nTOmKc8OLeDclJVCFKjuFa9dF7fk7YL9cQdPWcsEhMh0ykJRTNx8SK9HrL9Due5myXOv
         oKUCpoz6dXy46WQtnDqwT3Umxo3XTG4gUo556INkeHdZfP4kPvoZQD4MZwspXKGg1ZXO
         m8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703488353; x=1704093153;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8A3RGyZWHwJqKE33Ccn8Ly8rCpKxNaRKK7sfZw2jcU8=;
        b=qKUylbC21++Y1hCbvbF3S7OwoAXPDGWj2AdVsgwP16P8IJBHvN2p2KYktG4JJSoQeW
         38RUmd2zRsmim5ngpsPxxsxdBs2cwsK+VjRvdjNj2a3gyvLDXSx4SarhbGl5f3TPcYNs
         txptelTTe48+oToOR07+VPs62SdOgTDL+pca5uAjzc0UlsA+6hPrEUqE28bncNjX1/ZZ
         KuYIAonHkf9jNCfgTbVCY4Hc2/U07K351vQL9OSX+zRImCbzrpsBnWSrPXf33V7Ypa/Z
         A1mvsELhW1cSGUj1306fucnY3QBnpld/vXGGuZACFFP/cY81LrOl7Y24EIX5xhlqzmZf
         xR6A==
X-Gm-Message-State: AOJu0YykgSazMQjHb4viLbwX/yr0PQLqUYCbSPZtvtk317bopQy8LbrO
	gUfq7jRz98oJyPAHNWcl4ragMWiBK0uM7lBY9YebBB2c+us=
X-Google-Smtp-Source: AGHT+IEp/Fv6s8UPCg9A6AiHDxJCTXT/8OwXwdM7ppULypesk4puK13P4SmxkMGTu35yPJtN1ZS0KQ==
X-Received: by 2002:a17:90b:3449:b0:28b:8519:112d with SMTP id lj9-20020a17090b344900b0028b8519112dmr5875987pjb.13.1703488353236;
        Sun, 24 Dec 2023 23:12:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a7-20020a17090a688700b0028ad32914basm7683197pjd.41.2023.12.24.23.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 23:12:32 -0800 (PST)
Message-ID: <65892b60.170a0220.afc42.3c69@mx.google.com>
Date: Sun, 24 Dec 2023 23:12:32 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.67-cip12
Subject: cip/linux-6.1.y-cip ltp-timers: 16 runs, 2 regressions (v6.1.67-cip12)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Dec 2023 07:12:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14194

cip/linux-6.1.y-cip ltp-timers: 16 runs, 2 regressions (v6.1.67-cip12)

Regressions Summary
-------------------

platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.67-cip12/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.67-cip12
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      33a81955d654c80f6f9626f5bd3def02b8e85b3a

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/65891d55bd4dd9a845e13490

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.67-ci=
p12/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.67-ci=
p12/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65891d55bd4=
dd9a845e13495
        new failure (last pass: v6.1.66-cip11-1-g2d3d776d703d7) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65891d55bd4=
dd9a845e13495
        new failure (last pass: v6.1.66-cip11-1-g2d3d776d703d7) =

 =20

