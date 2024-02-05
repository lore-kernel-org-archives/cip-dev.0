Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793C2C48298
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 18:21:28 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web11.1329.1707157282636712180
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 10:21:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=cGqq3Vme;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d9bd8fa49eso7869325ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 10:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707157281; x=1707762081; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qb8scDHdujILOTWT9lwPBcVc9FuidqGPDYDjDCraWN4=;
        b=cGqq3Vmeaq7odlJ1xkFx2g7Eg0nD77qE9dUJ0UoNY5ABAEk8tfzVpvmHWx1Y8+sk/R
         OnZdaj+T5tYkD8Fg9cym+V9GfxwN5v/WhpdJ4Bt1aUGd5rS+bkVZ36DIGzZaw9afZXz6
         GatR5nHlAXMQMglHr/3cTqdBGVCINj0TW9KJdKDSBqatguy2lB6NhEjO4OEgkORKZl4O
         mtQ6VahbRr8HOoDQuhQRoBF58wB2IfJmTNXUOhiDYFgTV8mh6cAcmmDTXn24HeF9evGW
         NGog9t+q/gmf+sJUQw3KwFuL7x3h5gBWQt6RrWeC9KGDekiZQhhbppkGi5b67TeE4E2S
         3riQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157281; x=1707762081;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qb8scDHdujILOTWT9lwPBcVc9FuidqGPDYDjDCraWN4=;
        b=Y/ks3yioGoJ7ptwAnI15Wv/GSvjgemFpWVXQUvhJdfz6EwDYku9TtyJbxKB+AN1xqr
         qoK6MVw2LVAN86AYY+JKcsaOZMf8db+7UK9UnVEmSx3NZweFpJFSJVY2TtABoIejqfGS
         8+08LU2L7JSrwHMK7pKwzz3Js9/rdcLzab+Vpgsl4cmq7MTRYEgyhqqakccH9HWOCVpX
         7s6R4L+vVlnh0OzVqJE+dSc2+caeg0ui0VeAx5ziQu//3hi0O8PCBXZV6/dl8GSJRX6M
         1mbDpClE0GEMP/Wm0sXSnA1S9/L+SZ4C4VMFzg3vv5VFQ3Ctnp51zTsSsCN0pQvRmUvz
         w+cw==
X-Gm-Message-State: AOJu0Yx+vh52Dc9eB3LiksZ0FZnqdxXMeKvz2X9RRx5wzY4jgTLZy1EZ
	wsP9k5SH5vz/Fgk0haA9piOdmWjsHOaD9NtE/au5ZYtqfgDDC+o/sOL81gi/GYzKlYnV0v0RdND
	F
X-Google-Smtp-Source: AGHT+IH4kweQmZwoUgU2n8k6KwJzknAg+KtLwnFkEJ/l09RC4AhnSn1tvaUypN4s7FiRkNlZwpXEaQ==
X-Received: by 2002:a17:902:ecd1:b0:1d8:cc30:bb18 with SMTP id a17-20020a170902ecd100b001d8cc30bb18mr367097plh.52.1707157281452;
        Mon, 05 Feb 2024 10:21:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXbZAw4SY3iV65MnanvKr3HO75DKHmMKi7SZQiw+98XgYpM4wnNvbdA4M85bmFO1wqOMfmz/j9OznW88RngGgao2obQEiOKZ+R9Ty8mg8j7PAc350Yu8huMzF1BDTG9iqmtewshQKOgnNcj345OpG4POQ==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902eb0d00b001d5d736d1b2sm161319plb.261.2024.02.05.10.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:21:19 -0800 (PST)
Message-ID: <65c1271f.170a0220.985ac.1326@mx.google.com>
Date: Mon, 05 Feb 2024 10:21:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-timers: 18 runs,
 6 regressions (v5.10.209-cip44)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 18:21:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14752

cip/linux-5.10.y-cip ltp-timers: 18 runs, 6 regressions (v5.10.209-cip44)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =

qemu_smp8_riscv64        | riscv  | lab-broonie   | gcc-10   | defconfig   =
               | 1          =

qemu_smp8_riscv64        | riscv  | lab-collabora | gcc-10   | defconfig   =
               | 1          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
               | 1          =

rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2fa4c25ee66abaa707e8d165c790bb96e883cca4

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
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c11959f2453463f300a039

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/ltp-timers-as=
us-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/ltp-timers-as=
us-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c11959f2453463f30=
0a03a
        new failure (last pass: v5.10.208-cip43-4-g1c63c70fb18b8) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
qemu_smp8_riscv64        | riscv  | lab-broonie   | gcc-10   | defconfig   =
               | 1          =


  Details:     https://kernelci.org/test/plan/id/65c11a2efdb502679400a076

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c11a2efdb50267940=
0a077
        new failure (last pass: v5.10.208-cip43-4-g1c63c70fb18b8) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
qemu_smp8_riscv64        | riscv  | lab-collabora | gcc-10   | defconfig   =
               | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1193a34df5a296700a0c5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu_smp8_riscv64.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c1193a34df5a29670=
0a0c6
        new failure (last pass: v5.10.208-cip43-4-g1c63c70fb18b8) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c118aefc59e3c74100a039

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-timers-r8a774a1-=
hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-timers-r8a774a1-=
hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c118aefc59e3c7410=
0a03a
        failing since 124 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
               | 1          =


  Details:     https://kernelci.org/test/plan/id/65c119aa1c0c47882b00a03a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c119aa1c0c47882b0=
0a03b
        failing since 3 days (last pass: v5.10.201-cip41-69-g8f7b450fc28ed,=
 first fail: v5.10.208-cip43-4-g1c63c70fb18b8) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c11f74dd669f336500a06e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c11f74dd669f33650=
0a06f
        new failure (last pass: v5.10.208-cip43-4-g1c63c70fb18b8) =

 =20

