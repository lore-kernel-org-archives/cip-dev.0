Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C4AC4829D
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 18:21:28 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web11.1323.1707157279502557039
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 10:21:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=lf/Kc/Gw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.172, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c66b093b86so4200320a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 10:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707157278; x=1707762078; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0D2qe5DGxsvx/f1z84Br1ZElQEVL3bMMNphVUK9vC20=;
        b=lf/Kc/GweXHe5qiGkIWnA5yjua7nETLJIRlnJoFRbpf/iVLSIsOaj0sDVEKGKVagX5
         1tb34uA2H8be1jaL8rZD2xgf0zhAKAC3ME10nUUS7dY3qkG3G2vQ91x2v134NqlV639q
         3hKscC+XAVBCCqSXTvwdt5zSlXQR8n5WRfTsS9GZuoLdAGwoJETIfQ3YBP/TqislXjWN
         /nQv32SUSBUWOKlOsJVpvgj5BKZw+oi4gqjqnNj3QeghsyFCBUXJWDbhIfSAmAvQymxi
         yjhKf/fkTq0ziMPLjtQ11OLELeK6QOjnjiAKXYThWQYxVkQfkiWEdOQ/JD5xxvON5qBm
         Guyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157278; x=1707762078;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0D2qe5DGxsvx/f1z84Br1ZElQEVL3bMMNphVUK9vC20=;
        b=E50/lHBWv5oG5AGdgPlAbkjbiP52oz6iRvcS754f0wwHND2UftzNAyp+JtpVMt+6j5
         f/dgH+V7hJvdBUHVG7IM1dwdsczMKENKGr09gzrmwKgfATnT6Uz0v+GoYLw0SZOHTUoB
         8vmSdpVQD7f2Zx6VL3HRHUf8OU8Wn8QqNwyBrMUx9XQs1fF9ISiqPgdR/t5eYLCkK9AO
         Fxan4BTbcNvQj5f1BeKTOMFGSXUp5JQ+IiaEexlon0nUKXIGahIG1DmGkFBcJnojgBNI
         XIGQs70uadU0INQhPatf8k9eGGmcHC9WWRKYX/MDEUBy6+421SyxHr+YZV5EymbFwLSm
         fzaw==
X-Gm-Message-State: AOJu0YzlLSANCrx18USg2qIrGlE9C66e667AVnI+2S6u0cLx3RHbZNpW
	/gEJ7PNfBfDZ6T9jMvUe93a0R79/YVt7Sektybv71zlMdq6R58keyWs5X6bJBJyMt2hKjaDt8De
	o
X-Google-Smtp-Source: AGHT+IGfUvvSu53+eItAwGX0iOJjglqy8ewWqbrKhOzIqHsqYBy1vP5V/JvYbCXyRVIFg/vVT6grOQ==
X-Received: by 2002:a17:90a:c912:b0:295:f706:add5 with SMTP id v18-20020a17090ac91200b00295f706add5mr502238pjt.24.1707157277960;
        Mon, 05 Feb 2024 10:21:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU4XudwM9AqLv/us61BD5UUTv2rjqgq6bxXtUKmM01hD6hOfJSsfF1H9+9cA8TTIMrvFfXOmH/MkNgeDkYmOxzBNXBRWwKe9o7kNF9cvJw+5G0XZQvjvdXzKhrWSyW/a0gamGNm8FtRQN+xmYKrmWXywQ==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id pd7-20020a17090b1dc700b0028df5c748e4sm293095pjb.44.2024.02.05.10.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:21:17 -0800 (PST)
Message-ID: <65c1271d.170a0220.cbb72.242c@mx.google.com>
Date: Mon, 05 Feb 2024 10:21:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-lib: 3 runs,
 1 regressions (v5.10.209-cip44)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 18:21:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14747

cip/linux-5.10.y-cip kselftest-lib: 3 runs, 1 regressions (v5.10.209-cip44)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2fa4c25ee66abaa707e8d165c790bb96e883cca4 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65c115ca46a3450e5900a061

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-lib-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-lib-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65c115ca46a3450e=
5900a062
        failing since 124 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =20

