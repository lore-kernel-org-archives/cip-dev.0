Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4D3CD611D
	for <webhook@archiver.kernel.org>; Mon,  9 Oct 2023 18:17:21 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.70791.1696875438314204266
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 09 Oct 2023 11:17:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=MvEHS4Er;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1c8a6aa0cd1so6442015ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 09 Oct 2023 11:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696875437; x=1697480237; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YAjMIOL/AsZI93q7kkBsljk/4ECPGXGKVzHUc6KOqZQ=;
        b=MvEHS4EroHJEtBtPDp7MujlVSH9o+3QdamHrpyWOWw2xiD5nsG1m8Mg2LHATOR/bmt
         IlRtbY+1beTpJxbmNzqvK3BBFctJXlQacNzkiEA92OUTNktJKL1Uq61dmc22EEy4pmDk
         ehcALi8wINcbqoGcczNbUeS2zsfgxUG70KFGPIf4NrIoL/tBQvu2nAQP7JX96NMaqni/
         Y9h3mj9l7rJjP1dROBVFlF5LLMMNHIrLVT7TdYEcpI9pRGgELo61Pcmu8BaujIT8839J
         6dGo56kM//xqZgj5d+hDGbY71HxNcOPaVenbhFL7CU5bPtnqnc3tA9lRsX6E7342xaqP
         3Wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696875437; x=1697480237;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YAjMIOL/AsZI93q7kkBsljk/4ECPGXGKVzHUc6KOqZQ=;
        b=bIuZAf0PmQ3rkAtHukdxuShURm3JuM6b+/3OmVpZDH4eWdZmLjo1fKRPP74W0qfoKo
         RI/43DZCPGP1LlVXwbRcBcxBfTvrQ4gcNNj8gg1U08Y75o6Fn2Z3wGEHqRAjRxBKQVSD
         w/jZSDqadYMBYmj3lrSz0vzgyJkEpqC9Ew/jJJHhB8O9RL+YyyFKpLtQMP0Rw1wiKsuF
         JYlC0P3K71uqYCGBT82N9fTaeLvEkF31qSdAStA7tQj1s812Y6v4q9nEDZo6Tp+ZXtea
         +RsCgUIJO5Rr2tgghF8Vnk5EgDOPMcDec5bxplf62Gx5tTX9wpsPo8kMDLURFcIusgdr
         Ag4A==
X-Gm-Message-State: AOJu0Yz6/gRBFAtkFQoaEn4p/tLsTep5s3TbIMymAKSGAPd8v8twn247
	amYNpb+pjwqYJZP4URFxsL2opbX0S0UZaZLzQIf0jw==
X-Google-Smtp-Source: AGHT+IG+j3c2OvRLZAyvm+Xd+Xfm0aL87GZhX1/XpvqCEE+Pt3nitEe9v/y+KOUxS1GWNS0Oa2QPfw==
X-Received: by 2002:a17:902:d488:b0:1c8:9a60:387f with SMTP id c8-20020a170902d48800b001c89a60387fmr4071583plg.56.1696875437322;
        Mon, 09 Oct 2023 11:17:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i19-20020a170902eb5300b001c63429fa89sm9922359pli.247.2023.10.09.11.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:17:16 -0700 (PDT)
Message-ID: <652443ac.170a0220.da99a.9107@mx.google.com>
Date: Mon, 09 Oct 2023 11:17:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-1778-g3b01feff09495
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-st baseline-nfs: 27 runs,
 1 regressions (v4.4-st20-1778-g3b01feff09495)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Oct 2023 18:17:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13326

cip/linux-4.4.y-st baseline-nfs: 27 runs, 1 regressions (v4.4-st20-1778-g3b=
01feff09495)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st/kernel/=
v4.4-st20-1778-g3b01feff09495/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st
  Describe: v4.4-st20-1778-g3b01feff09495
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3b01feff09495bfdcf43283997a6ea6c6bf6c649 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65243f824bd95d5adcefcf1f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
778-g3b01feff09495/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
778-g3b01feff09495/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65243f824bd95d5ad=
cefcf20
        failing since 189 days (last pass: v4.4-st20-939-g5ff13a6decb9, fir=
st fail: v4.4-st20-1098-g8d34bf42efd9b) =

 =20

