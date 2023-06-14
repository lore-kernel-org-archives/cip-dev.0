Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2B7EB64D7
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 03:25:01 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
 by mx.groups.io with SMTP id smtpd.web11.3535.1686713098765201703
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 13 Jun 2023 20:24:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Q6KE2rkf;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.51, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-558cf3e9963so236048eaf.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 13 Jun 2023 20:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686713097; x=1689305097;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SzmoMtNPMt0Nb3ZGl6BLHI9JBw4j/5ffRXgdQD0cSU8=;
        b=Q6KE2rkfvjJrIahm5+3a6bVWOLdg9Q0Vhrgcc6rY210jkTaYw2M1GLr1Kp0tStymPd
         JbT2sZfY2pb2anGfxaPw9JQhp22mFLGCxUlPwOxYGpWCr4V58J1t0GK4i0fdYpK51dYX
         lT89fCK6oL2VHm7ycXZXxCVFAw3S/WyHagKUTxG44V/C1XF6ppHUB8W4mUUirV2uCLaO
         KIWIBDFzB50INMbhvNDd9rglz8anKikeE7rKW5VfHdFYmhs2qdBHZzPMFtryNzgyZdS9
         Ke1g4V2gGsM8nofRP/19PKgctwJPP7C9OwBcYz3Z8PjV8Uj8w/hgrAJv3KoV8dxX5SRv
         UAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686713097; x=1689305097;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SzmoMtNPMt0Nb3ZGl6BLHI9JBw4j/5ffRXgdQD0cSU8=;
        b=MByw5BPYme5tjAgJo+kT0iU1YolLcHsiUmt9tx6O3DCXY5WYqlpwjGZOLmhy1lcQa/
         jFpvnP4/joVBsaHZuj833R3AX6WZveNvusft2ea+GMPnYHe4Ihw0WQeTUzKAGqVQFm/7
         qkKK464p8AQlHxBwLaof23J6Au20lsLsxJSAZApdsejL/I0jU4GJ1Sql2ZjMfPetEZRC
         RnzHx3v5gb/bsg5UqJSwu/FqFpuzv0lIf5NrCS4iaBtYI9KSM6/UX6m/Wg6CMt5IiAeu
         eYBPTgSTZ49CJL1NhtlfUNXMW3+0LyUBU66rtk0umucaLFq+zAtn2vQnripNcRhPSEjj
         M6lQ==
X-Gm-Message-State: AC+VfDxBmosOhvUy4FCSGUa90Um8fIPEHurmuxxZc4qKg7/AbqL+5h1i
	KiI+SoO4cVROmcnUj2bYfaa6SYvTVh7OCNEWN1aVpw==
X-Google-Smtp-Source: ACHHUZ40DiqwdBPN9vmwurVQ0KYPjS47snp1k81N00gTlED01+u5KIHBqdC1TecqHnp17qBRU9yPMw==
X-Received: by 2002:a54:4585:0:b0:394:31e1:41a1 with SMTP id z5-20020a544585000000b0039431e141a1mr9160799oib.6.1686713097058;
        Tue, 13 Jun 2023 20:24:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902c74500b001ac591b0500sm10945586plq.134.2023.06.13.20.24.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 20:24:55 -0700 (PDT)
Message-ID: <64893307.170a0220.42b20.5ef8@mx.google.com>
Date: Tue, 13 Jun 2023 20:24:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-8-gc3d08808cfa7
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 7 runs,
 1 regressions (v5.10.182-cip35-8-gc3d08808cfa7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 03:25:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12002

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 7 runs, 1 regressions (=
v5.10.182-cip35-8-gc3d08808cfa7)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.182-cip35-8-gc3d08808cfa7/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.182-cip35-8-gc3d08808cfa7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c3d08808cfa768cd3cc5ecfba684f72db3e04b9f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  97c2fdb137a68e1eefed07c900db1a862edcdbf8 =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/648923100e0f353395306154

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/riscv/defconfig/gcc-10/lab-col=
labora/ltp-pty-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/riscv/defconfig/gcc-10/lab-col=
labora/ltp-pty-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30609.0/riscv64/rootfs.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/648923100e0f3533953061=
55
        new failure (last pass: v5.10.180-cip34-236-g6d219c607dc68) =

 =20

