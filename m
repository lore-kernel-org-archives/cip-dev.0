Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CD0C54E4A
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 21:13:36 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.35757.1709327612619387812
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 13:13:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=mT9BqreD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29a74c88f74so1810946a91.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 13:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709327611; x=1709932411; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m7DazOzRdtyycNvRxhSq6E+Q/BXPi7kdBCuDuYGJrVY=;
        b=mT9BqreDeHBRhQU+w6iODSNfvHP0d4qNyjjOIZE8IRvPL8rjA776rfhKWvGcPSRGe0
         6YLxbuAPB9zz4e6ru1Lt+xUqBDVC54HGXO4pChuuAIS1NKUtUELcNxNLg/Fx+UTG/uE/
         88Jd1gXgzxBwiojY+zqRW/DPaOw3KaOb8sv3V5eRxKlyMbU2Ry2RJR07bpXQ5cxImdL7
         fM/+pXc8EVep2PLgxmN92QCoYwEAwp6k7VfC7UNixZMg3GyWgD6ZClQ3uLmn+fwtUXwj
         Htv5/m/yulAxvU88qm2dm6atfGUvN5RKgy9jA2gqqDM18FuxS8pAGObPgPEuHmaSekzQ
         XjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709327611; x=1709932411;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7DazOzRdtyycNvRxhSq6E+Q/BXPi7kdBCuDuYGJrVY=;
        b=GA7XGG5OT6a55enUMZnIeAvC+xiOZ6NG86qcK39+Qk8tSW43Zf2Obibn0LksBETw7P
         W/uTV1aHLJRGfcL9yJsR1nYjjEkYtmjkkpTmwRK0Z1fBU8H9QRXZKuem1bC+XKdanTX/
         7i8aCu/iLSS1cpu7OVZ5y+/q+/S9gKcmOQoBDomAMzruDVCFLw8wRdxjTaB1DdqLPT/L
         56zdR3BMC5B80pk1O5S+bGt3bxYgWfQF6EFzfnCc9yDa8GGQMXcmCtSspQQbcg7RF4rS
         R+FTTahwPxAfWQHUhOsa3hH7Ob6dCurtWko6CX8RB7rWbrwAMMoLGYSCc4KQlFPxHtN0
         QOAg==
X-Gm-Message-State: AOJu0YyEzKMccS24eECWFnpE6TOz33lotY1zoyhjNZllF/D5dSbStRFL
	RX3iM3peLj6RcYd7R1rCBpg/v9px5neuodHYHj7nRt7v1mxLHA0+CzQKkubYH9k34WknGLrmvoS
	myJU=
X-Google-Smtp-Source: AGHT+IH554VryR3poiwaLlz2IwOzlWEymtS0i1QQcge0wECyP79tQaNen9xSwNUSltlGdQsRtYm/mQ==
X-Received: by 2002:a17:90a:53c6:b0:299:7120:e08c with SMTP id y64-20020a17090a53c600b002997120e08cmr2708030pjh.22.1709327611053;
        Fri, 01 Mar 2024 13:13:31 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090adc0c00b0029a7df64720sm5826883pjv.53.2024.03.01.13.13.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 13:13:29 -0800 (PST)
Message-ID: <65e244f9.170a0220.a76b0.d885@mx.google.com>
Date: Fri, 01 Mar 2024 13:13:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-552-gc0460fb20fc00
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 11
 runs, 2 regressions (v5.10.209-cip44-552-gc0460fb20fc00)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 21:13:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15143

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 11 runs, 2 =
regressions (v5.10.209-cip44-552-gc0460fb20fc00)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
qemu_riscv64             | riscv | lab-broonie | gcc-10   | defconfig      =
            | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-552-gc0460fb20fc00/plan/ltp-fcn=
tl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-552-gc0460fb20fc00
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c0460fb20fc000a52548daa693788068d4fc9a8e =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
qemu_riscv64             | riscv | lab-broonie | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65e23137c4632f746e637034

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/riscv/defconfig/gcc-10/lab-=
broonie/ltp-fcntl-locktests-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/riscv/defconfig/gcc-10/lab-=
broonie/ltp-fcntl-locktests-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65e23137c4=
632f746e637035
        new failure (last pass: v5.10.209-cip44-56-g55117716ac0fd) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65e237f31cdde74368637034

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-552-gc0460fb20fc00/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65e237f31c=
dde74368637035
        failing since 120 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

