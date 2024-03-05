Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B508C54798
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 04:46:02 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web11.14530.1709613956290876738
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Mar 2024 20:45:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Gfozo2wV;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-299ea1f1989so3439716a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 04 Mar 2024 20:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709613955; x=1710218755; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SZo9GrAhD6fPMrEGFwxjdLVUg7V4fiHHtI1FUZn1Lf8=;
        b=Gfozo2wVEw8kHn9tseo0MXxAzpBNdIGIRFZRJ+gChIuQMTErjoQbA8oGqO0xVaAfHb
         WUe+o4gC66lOYBOC8IxG8fAgXSE+zZmwcDEONVK1ilt9hDvJmds5+LUsC+T30U54Htz5
         MHnbbeMRnsY4WA6lQiigVstmLcwaEJxabhzO1uxsbJsSzK1POL0s5Gn6uS9yaVLhYri9
         1oymvUokGgQ/GS9Oh0Wl6rytGfjbpVpR6Kz9XgyQJ/R6kYraVowV3kEs7Tu/rW8ps01f
         RtX2nn3d+U0G7jYSjkBaBsq/EFdwYSpeSqBRClYEucthU7UnUDgmKuMq17lvjY/1WNAs
         5sMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709613955; x=1710218755;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZo9GrAhD6fPMrEGFwxjdLVUg7V4fiHHtI1FUZn1Lf8=;
        b=iw93J8IJJtVhFAN/HMMWky+AM0Frui0d18gETTpRBqeTxvmn9uH9snWDg3t1ytAofJ
         ejxm0twe5aoIhpL1+IJaaRomhyTHM6xzP2nKcEY6YYUprwqb2Z1bzJJuM4MCuAs2HhiI
         THVSsaGYcfb0xnL5QC24s804YLovlaOP80jiZyDFpCs9pJlS0Rl91R7In56lGTSADCwy
         DB7GSBZxdr+DpTdzTWZtQGSPqREDsFkan9ef1Q4lsKAMn1nMrH7CEDQnCdWDJPTb5gzq
         l9t4mvJen5yZ0rPmBa8pNP07anpp9ca9Bx+PjX+CNuod3FuYXrF/h2dAGIh9kd7E6tiY
         oBoQ==
X-Gm-Message-State: AOJu0YxHA1x1a4X50Hw3Cdq0Ae/HV5sTVxoHFLc0fBKxNnYhtxWW/In6
	NZMGXsw41KdB1SDu684PQ9Dkatw827dndScX0hO/H4MBMVMAgvVQWudhJRGpnlvqRBcGgh3wNha
	elYE=
X-Google-Smtp-Source: AGHT+IGgmwOo3jv0T0kqPLfvTbIj6adrsmzqCkNzhl7CvSnNX4Bsa8U+4pVCxFMNL4RAkEJSVCJ3HA==
X-Received: by 2002:a17:90b:3b52:b0:29b:6a22:8626 with SMTP id ot18-20020a17090b3b5200b0029b6a228626mr44154pjb.0.1709613955180;
        Mon, 04 Mar 2024 20:45:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w8-20020a17090ad60800b00296a23e407csm10760988pju.7.2024.03.04.20.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 20:45:54 -0800 (PST)
Message-ID: <65e6a382.170a0220.53031.da6b@mx.google.com>
Date: Mon, 04 Mar 2024 20:45:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-2244-g20d1c7153f15
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc ltp-pty: 2 runs,
 1 regressions (v4.4-st20-2244-g20d1c7153f15)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 04:46:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15204

cip/linux-4.4.y-st-rc ltp-pty: 2 runs, 1 regressions (v4.4-st20-2244-g20d1c=
7153f15)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-2244-g20d1c7153f15/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-2244-g20d1c7153f15
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      20d1c7153f15fe1c99de6372d626390a1fb2ca2c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e69eb37caeb094fd4c4359

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-2244-g20d1c7153f15/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora=
/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-2244-g20d1c7153f15/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora=
/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65e69eb37caeb094fd4c43=
5a
        failing since 88 days (last pass: v4.4-st20-1872-g0dd3085de20bc, fi=
rst fail: v4.4-st20-1987-g9e48fc479c400) =

 =20

