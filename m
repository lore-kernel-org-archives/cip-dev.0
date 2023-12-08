Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F5CC10F05
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 17:49:16 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web11.42463.1702057751618336571
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Dec 2023 09:49:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=IsjQanws;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ce9e897aeaso1913373b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 08 Dec 2023 09:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702057751; x=1702662551; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FTn3Z3y/Ge0OrzK/tAYid0gVF9OXDlWs5gJh8A0TBdk=;
        b=IsjQanwsFM7RrIts/sR9gRYKH6+y5F7kkxhgsOpSiecppBt0++D4DEP+xOx7Q8KqUT
         Bv5V18naNypno9VyMLO1ZF9J8su9VbCHy216T/hQJ38+BEGMWQBqZ0J6DNj9l/oYHJcl
         ajgKZmp07SRwhuf7YKnX46vYpsAluwJDKip363eGTFSMlKge8e1rcNJqsJer560w9Ak0
         xAh0xmCSlxKAK42SlFn8ikC2J4+JUZ+k6/IwimJjvoNPtDkBRqTjmeTX7vYnwBmtg0VC
         CzEzIc9Gcuk2Xha0n2nBn4ZJ1jppCSy1WmpWfGpnO8FtKggSEOO2U2WIo+QpM7Sxo98k
         vndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057751; x=1702662551;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTn3Z3y/Ge0OrzK/tAYid0gVF9OXDlWs5gJh8A0TBdk=;
        b=d2rGYEMLW5BLR9D/CMjMdkpbtaWfnphiaqQCN8djQEzxQZcVyUAOnDKYZB2RIb3wjE
         /HX6Qo6yewdgOcuWBfxrdYKO1jXUBpEtPZnxBJ34ykTlIYu2EJ2YL1cXBkwnP+iOjW/x
         wl5q/cO0UFQr1u67fS7hGUcmMdUNztaQRS+OWP5EXUirxeJDu9hXEykJMiVfu03CJijI
         x2XR8ImiAc41Wn11Z8meB8rgrZRxXAvmZS0+WFxS7dfrgTfY3YrbWaSAapkv+K3TvDXV
         Yvy6PiDuNq1HJ/f8c8LA2MO8NWxeYX/qBK/uuOugw+MkG9Kr0xGMbkeMmzaEDZvn9dch
         fb5w==
X-Gm-Message-State: AOJu0YxXguLmj/HVJ/F+sX3XG0rkMHdQlhH5z4UM4jvJ2ll9dEt6beJU
	1mkouWVWGbfT4biEErIW2fKokA3brHRdSc/ej+bnuA==
X-Google-Smtp-Source: AGHT+IFCTbR9JoxqRKyGsKxwjhb32XqVcqe/YfqM+3+0JG9m7c+a64ZNx8BLTWfBD+Oi1Ga9McbNBQ==
X-Received: by 2002:a05:6a20:1047:b0:190:fca:72d8 with SMTP id gt7-20020a056a20104700b001900fca72d8mr384379pzc.109.1702057750715;
        Fri, 08 Dec 2023 09:49:10 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ff14-20020a056a002f4e00b006ce7a834b1bsm1856879pfb.58.2023.12.08.09.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:49:06 -0800 (PST)
Message-ID: <65735712.050a0220.26ab5.68e4@mx.google.com>
Date: Fri, 08 Dec 2023 09:49:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-46-g596f4c151d286
Subject: cip/linux-5.10.y-cip ltp-mm: 5 runs,
 2 regressions (v5.10.201-cip41-46-g596f4c151d286)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 17:49:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13987

cip/linux-5.10.y-cip ltp-mm: 5 runs, 2 regressions (v5.10.201-cip41-46-g596=
f4c151d286)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
               | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-46-g596f4c151d286/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-46-g596f4c151d286
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      596f4c151d286c71a3612a2120ab33f4ac885d2e

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65734b0504ea891387e13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-colla=
bora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-colla=
bora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65734b0504ea891387e13476
        new failure (last pass: v5.10.201-cip41-28-ga386bc478aa6b) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
               | 1          =


  Details:     https://kernelci.org/test/plan/id/657348df00b58d0710e1349b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/657348df00b58d0710e1349c
        failing since 695 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

