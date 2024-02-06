Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2A3C48260
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 03:10:12 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web11.13865.1707189008053204083
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 19:10:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=MtEOrDHx;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29631796acdso2474262a91.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 19:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707189007; x=1707793807; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6RSoxxesl0Ua+YpGg+BLAm2oZnouIND24dfiWxzsFQ8=;
        b=MtEOrDHxKhXXqKS6Zyi65RvN3K0lo5NFrNwbQJS1FBAvLkqP1tmDCpqhWUwDzf5+eG
         vNTBqkA0TWwbnZvTt6dXwbXFm3n/9E9G4QEqzylWIGKnj2iaAlYLcY7vuGrlJMK+fwFE
         561h5Be8Q+Kh3USmLvguYbrwDG0H4H74MRDsH9v/dCI8hADeVcpnKZ0l3FVyHzak++WF
         X4CT/SZ1whF/jrt8ouC8xggDVRWQ/NyfSJLpnxWveZcCvhUshj/9QwTByWu3Kwe/zZKq
         VYNRfonQ+WBTi65E7duS05EvR55ktuivGtqsQVEWxz81TFN7X553bIfMwPpbLY81RyC4
         MFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707189007; x=1707793807;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6RSoxxesl0Ua+YpGg+BLAm2oZnouIND24dfiWxzsFQ8=;
        b=c3g2KY4bZz7VkNiVDX3bwOklutHwo0/5HIwWaub2Qxhdln6FFKzgnQPj0OGp1g37+4
         9v8NlsPzEDygsNnMNbVd+ARE6hYIM7xwr2tzToEmJxBpNLbS+OZWEhsvi7NmwDNMFGzc
         tnoxMxqHjdlarLJGLlYuNzNv5qPM4zWcrS0N8B+y+RZgHvz41ZRH9Ggl0sJSCF+DTMwi
         pm9sCzNH9Bx7NjoZYbe59+6EdrvioV0CM1SHLYgyEYzv2ckvjumLnR03oNjvrLSmDeZ1
         IgoQoVW/0akP/CU1xCIOVY1UwCCEFMdSApIaiyQokHwpi1ClV0oTlvjWO/v/YrsUNzQ4
         EIEg==
X-Gm-Message-State: AOJu0Yw+TzuncUcQawW24SAlaZg5ImDs0nKc1M+nWdNHxEQZdcDfvc7q
	XiUe6q70OWOynIX8AUvLmkRhZKrf4Ka6mxBDQ5iJZsfdFpZA2E6heWyDT7djGY1lQNGz6moejzw
	A
X-Google-Smtp-Source: AGHT+IFUfoxvA3WzDURw54vHH9ktL5bku6n+zBxyV+6u62sRDNMUssY0CBa+dOjjydIrsDXUE2baqg==
X-Received: by 2002:a17:90a:c590:b0:296:a767:f6d2 with SMTP id l16-20020a17090ac59000b00296a767f6d2mr1201860pjt.38.1707189006768;
        Mon, 05 Feb 2024 19:10:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSFXw7o+KIn9vOANpsfzGhMoplLf/mMxd/07sRHUaj00Uk4UVjxvzOiUpFqyP2UnchNGWBShc4oHCDHabNbO9DCKIKedZwR0dSVL0N9zk1/rFbwebO/ct7OgUhANzVm/lQE/oFPt0MDTYckuLul676yA==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id mg13-20020a17090b370d00b002966dbf4d82sm259431pjb.26.2024.02.05.19.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 19:10:05 -0800 (PST)
Message-ID: <65c1a30d.170a0220.216ca.0d1d@mx.google.com>
Date: Mon, 05 Feb 2024 19:10:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.209-cip44-rt18
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt ltp-pty: 18 runs,
 3 regressions (v5.10.209-cip44-rt18)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 03:10:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14771

cip/linux-5.10.y-cip-rt ltp-pty: 18 runs, 3 regressions (v5.10.209-cip44-rt=
18)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
      | regressions
-------------------------+-------+-------------+----------+----------------=
------+------------
qemu_smp8_riscv64        | riscv | lab-broonie | gcc-10   | defconfig      =
      | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+preem=
pt_rt | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
      | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.209-cip44-rt18/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.209-cip44-rt18
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d814befd12dcf6c81b483cb36f507d70112c1097

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
      | regressions
-------------------------+-------+-------------+----------+----------------=
------+------------
qemu_smp8_riscv64        | riscv | lab-broonie | gcc-10   | defconfig      =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/65c19501332dbdaacc00a08a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/riscv/defconfig/gcc-10/lab-broonie/ltp-pty-qemu_smp8_riscv64=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/riscv/defconfig/gcc-10/lab-broonie/ltp-pty-qemu_smp8_riscv64=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65c19501332dbdaacc00a0=
8b
        new failure (last pass: v5.10.201-cip41-rt17) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
      | regressions
-------------------------+-------+-------------+----------+----------------=
------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+preem=
pt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65c196c9a48b30fe5c00a04b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig+preempt_rt/gcc-10/lab-cip/ltp-pty-r8a774a1-h=
ihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig+preempt_rt/gcc-10/lab-cip/ltp-pty-r8a774a1-h=
ihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65c196c9a48b30fe5c00a0=
4c
        failing since 74 days (last pass: v5.10.184-cip36-rt14, first fail:=
 v5.10.201-cip41-rt17) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
      | regressions
-------------------------+-------+-------------+----------+----------------=
------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/65c19990508d3eb41b00a04d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m=
-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m=
-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65c19990508d3eb41b00a0=
4e
        failing since 74 days (last pass: v5.10.179-cip32-rt13, first fail:=
 v5.10.201-cip41-rt17) =

 =20

