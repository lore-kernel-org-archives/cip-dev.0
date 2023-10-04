Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E244E7B5FB
	for <webhook@archiver.kernel.org>; Wed,  4 Oct 2023 11:41:30 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web11.16085.1696419689434401073
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 04 Oct 2023 04:41:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=qOpRVyCG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-694ed84c981so1562250b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 04 Oct 2023 04:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696419688; x=1697024488; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tTndZKwMyaThClhMKW5powNi4fOVbNG3n0IdJ1uYB/s=;
        b=qOpRVyCGZB78H6/KMjdsIi8KwNFjTNo2JwMDM4AA1TLBS713wSL9UFzuWKD1y7COC4
         4ilf71MoQL28mMQBraj0AYTQFKjC5YVYOCD7HdSMpVfZeafMV4KVz0MWiT0qKdGf8aus
         7ChIQkkrvVI/6E2UxEel4DWj+LfqB4GxQmePw4DoR9x5z5kY40ZLrEasyyGw3+dHTLZ1
         3b/JmDDvfCb/DFnq6/uewSGtRPtFoW+o+mCTGH7F9W++Igss+ZGOVtNcAZ9jl4p67tJQ
         MV2RqElkSCiyBB0+ZSGE9+bR42pMgdUcDGrvUVXtEmLFweE+0cShMJl0ihdOJGBwkMVv
         ekwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696419688; x=1697024488;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTndZKwMyaThClhMKW5powNi4fOVbNG3n0IdJ1uYB/s=;
        b=EX3mSEWdbv7qi57TS+fZwA/quYpK1eVjpzFrxm51PWhrELrr2CnDMkDiqPgUAL6IG1
         33yOJs7yS6ZEVM+bHw9ABj1vgAA1uy1VIgWvx8rVeXqwTfnOgMw7IYwSxNjIZG1N55+i
         9RxyEWXYRk1Ly9pGbLiIT6DeGdW7FWNYuQU1XaRnZLH8RxeQ5Gpa5qkfvxjcYb108ZWi
         NzcF3abllxc713dvXAnIYUO46hQisQIwdxYwWbgvxym/q/hp/DWLV18hUrFK0hld8rs3
         EsCECUqbiWBRErltfLnPkrs2pm9k+JP1R1rexr2PYX4hfY+0MwWPtm82HOl8rAUIhcPS
         s6zQ==
X-Gm-Message-State: AOJu0YwCy6Dsw4hct5HGh/nAGjtkImyOZrY5FLT06ImsGXqfwKMmaTUt
	MsjKTakkoia4SzModPUKKDySAGRJMjHarInAm9bhyw==
X-Google-Smtp-Source: AGHT+IE+jWErXDdku/pEOsBDwGVCnl2DvEn3x+16brAw2IHyNePYxVmvJfQ1u92OtBDfO/bCZTUUMA==
X-Received: by 2002:a05:6a00:248a:b0:690:d008:8d02 with SMTP id c10-20020a056a00248a00b00690d0088d02mr2412419pfv.19.1696419688307;
        Wed, 04 Oct 2023 04:41:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fi13-20020a056a00398d00b00690f622d3cdsm3018172pfb.126.2023.10.04.04.41.25
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 04:41:25 -0700 (PDT)
Message-ID: <651d4f65.050a0220.83823.79ee@mx.google.com>
Date: Wed, 04 Oct 2023 04:41:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.194-cip39-1-g53e59f50ca3ff
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 18 runs,
 3 regressions (v5.10.194-cip39-1-g53e59f50ca3ff)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Oct 2023 11:41:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13275

cip-gitlab/ci/pavel/linux-test ltp-ipc: 18 runs, 3 regressions (v5.10.194-c=
ip39-1-g53e59f50ca3ff)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =

qemu_smp8_riscv64        | riscv | lab-collabora | gcc-10   | defconfig    =
              | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-cip39-1-g53e59f50ca3ff/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-cip39-1-g53e59f50ca3ff
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      53e59f50ca3ff023b612a48397ad7e057a9fd408

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651d42df343374622b8a0abb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/651d42df343374622b8a0a=
bc
        failing since 111 days (last pass: v6.1.26-1320-g1ddf4b637f785, fir=
st fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
qemu_smp8_riscv64        | riscv | lab-collabora | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/651d40456f3263f72a8a0a8c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/riscv/defconfig/gcc-10/lab-collabora/ltp-=
ipc-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/riscv/defconfig/gcc-10/lab-collabora/ltp-=
ipc-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/651d40456f3263f72a8a0a=
8d
        new failure (last pass: v6.1.54-cip6-101-gb060fea6ba099) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/651d48ba24f53e68248a0a54

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-cip39-1-g53e59f50ca3ff/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/651d48ba24f53e68248a0a=
55
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70) =

 =20

