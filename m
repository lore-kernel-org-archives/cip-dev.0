Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F88BC001DF
	for <webhook@archiver.kernel.org>; Fri, 20 Oct 2023 10:33:17 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web10.51223.1697797990222694860
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 20 Oct 2023 03:33:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=y8Sx+7Fo;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6bd96cfb99cso569250b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 20 Oct 2023 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697797989; x=1698402789; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tTiUp9lSDxSAm4pupJ3NDzR0J17oZiAW59LyOw8yURc=;
        b=y8Sx+7FoKTbwk97cdqBvZFSKkFRWNYOW9y9sdbzNQMui+Uy9X2aYUNCdWUiDbPxQud
         3kaoP2bU+NM4jftFMdymWAk6uUPMhwwNalWXjgL1IALp9K76EOic723d9nzqfdTt0GUH
         liqY7X/MG5Xo68B0ABp/1pjSR0y9zy2OKojkBg9F7iPq1OmHix7zUDXxUjTxd/kYGsna
         3FUutH+uJlHIXNJRhPGat7U/W8t8ac6D+wp32RtBkk0fLDqaC+cm1ULkX1065S9ebtJc
         yz37vya6H/UZC9j5uJ2sTRGnih81gupHMyATQ48PEGtFYnrhdJy+ng/ZlaJdzZZV2Hkk
         t8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697797989; x=1698402789;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTiUp9lSDxSAm4pupJ3NDzR0J17oZiAW59LyOw8yURc=;
        b=BklKIxbKRDMZ5MQWLEJVAY3NnFD5og2GN1h8VfFliFMjBdBCSCmL9rW9RBM2mhrsZX
         F2UOPD1DDgHm6tnPCaviLelvzlkqtdvGdyRZO2kgP+wihDre5qtjU8fWYpFY4v2DMJw8
         8b65U/Cl6/A1G8DIcE47Q9Ytua9H29qcII49LRTHY9MZMrBR32DqAqqpoKVLwgyU6HF4
         Euuv9aFYMh9xAjWEoXFtRlIgVOZBo37CBuQjXGgaksOgiJV5cI1cC7+0GX4O+q/1NggD
         PinSkxiv8IoceD0ON5Ew7nv+T0SPb8+ns8WjhOZBv7/yhxMibOlY/vvf+8oMEnykzeAP
         P7iQ==
X-Gm-Message-State: AOJu0YxO1Wtd9tOFg4if6MBYGY/ZTKR2PHNp6Bg3v2qeWs2d7b4NnR/V
	SsJ1DlIjtKp3W3MuXsoUgiu2F6mzmZfqX0XnKIjvlA==
X-Google-Smtp-Source: AGHT+IFYe3pQvN0st52P3KDGphFOFaJSHwQZJi+jeJIthXiqYUkX1GUdS6/Grq/TT3DlQqketecS9g==
X-Received: by 2002:a05:6a21:998a:b0:161:3120:e865 with SMTP id ve10-20020a056a21998a00b001613120e865mr1425945pzb.52.1697797989029;
        Fri, 20 Oct 2023 03:33:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d6-20020a170903230600b001c5bcc9d916sm1208075plh.176.2023.10.20.03.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:33:08 -0700 (PDT)
Message-ID: <65325764.170a0220.38088.3db2@mx.google.com>
Date: Fri, 20 Oct 2023 03:33:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.58-cip7
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-6.1.y-cip kselftest-futex: 9 runs,
 1 regressions (v6.1.58-cip7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Oct 2023 10:33:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13410

cip/linux-6.1.y-cip kselftest-futex: 9 runs, 1 regressions (v6.1.58-cip7)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.58-cip7/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.58-cip7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      5608f0095a5ba83c76af0e5824c2e2d3f41231b5 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/653247db8c1b1c82bbefcf10

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.58-ci=
p7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/kselftest-fu=
tex-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.58-ci=
p7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/kselftest-fu=
tex-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/653247db8c1b1c=
82bbefcf11
        new failure (last pass: v6.1.31-53-g486caac40d06) =

 =20

