Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013D5C48292
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 16:07:58 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web10.66787.1707149275543809139
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 08:07:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=FTfNNs7M;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d74045c463so35635405ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 08:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707149274; x=1707754074; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NjHhsx6ayKB7g8k7Suk7pzz2ITatKDXSM4AIjJGUmD4=;
        b=FTfNNs7MTMuJ+W7bjn/cTeStV0wEVgsvIfKmZipzp4V0Ef3iSpLPfWJnldXexBRiKQ
         OklifWV7opjcSylJNAO5vIq+S5qNs3E/zKjl2ND1MlRFcKOPXQBqTAbPMyLAD5JJXOTt
         1DK0wGDuNPeOtl7mPj1fEc7mHIyfEG0uZxdW6SSSPwRSTxjW3VWDXZjag6q6t6WdRxCt
         FCIqIQKuEdJCbZNVcpiq0ZP8szjzQPhScv+VI3YodVNDDMjHW/1iFTGPF76YAOoO4oXF
         SULIMYEYs/xJEzU6Og60btg+Q0HJKUiDjVMFIfAuS+Wcm0dQ0zKdkAR7wTrr1x5f5xs9
         vaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707149274; x=1707754074;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NjHhsx6ayKB7g8k7Suk7pzz2ITatKDXSM4AIjJGUmD4=;
        b=IaRSkhMJRX0Kzgizr22GZf05y9TuHpcZcPNeKLMgSIS/b7AVyMa0cIgjOoiC1iAdMr
         vo+jP0DMlsZZhUSeE8KQMNWUG/MmV633ta6R1nwRw7iAvH1J+eyjCto4+WK304NVY5xI
         ZxFLZ3gkW45rm/ApAbo2ghA8R+arQRaJcW1MPjNVqHw2Ex8kbWJPBX7ZUdQmT9Y1xThJ
         wF50UGwnTm/8NXUcye+0WZjRjJ0UXLdG39Go+31DifyZRae8y7bISDsvfiinq/pZJUsk
         HsuYKJYBnyr8/BlIxyiS9V5dyGMkWcMyS/CwLhc1M1aTYkytc8ls+/uvTUA0pz2YYtLh
         2rqA==
X-Gm-Message-State: AOJu0YwkGyoOreVTPywfqCq/tfPgmWkp5f9/8yYy+YdUK6HUBGXmQgaI
	vfQCpXeH2N/4wnvgzLZ0KR6G+e1+kEtpid7kI3VAjPqY+xIouW/lH2YkT2bllL8izUe1vVWiDNm
	T
X-Google-Smtp-Source: AGHT+IEs2oTZijiYgVnnXhtJvUKgAnzkd8g84jSJOTRpcb2SzP/0ppnF+IrMPqRKXhcioVUj4ii2ag==
X-Received: by 2002:a05:6a20:d044:b0:19e:3356:a6cc with SMTP id hv4-20020a056a20d04400b0019e3356a6ccmr9155709pzb.51.1707149274334;
        Mon, 05 Feb 2024 08:07:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k1-20020a63d841000000b005ceac534e47sm111551pgj.51.2024.02.05.08.07.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:07:51 -0800 (PST)
Message-ID: <65c107d7.630a0220.d5c5e.0e20@mx.google.com>
Date: Mon, 05 Feb 2024 08:07:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.209-cip44-rebase
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 7 runs,
 1 regressions (v5.10.209-cip44-rebase)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 16:07:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14738

cip-gitlab/ci/pavel/linux-test ltp-mm: 7 runs, 1 regressions (v5.10.209-cip=
44-rebase)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.209-cip44-rebase/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.209-cip44-rebase
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      17e47f846f71ff31baabe74a720660536794686d

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0f54f1b5fe6c3b100a0c3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.209-cip44-rebase/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collab=
ora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65c0f54f1b5fe6c3b100a0c4
        new failure (last pass: v6.1.75-cip14-6-ga817aa655908) =

 =20

