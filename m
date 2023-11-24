Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1301C636D3
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 00:19:02 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web10.122026.1700785136339610451
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Nov 2023 16:18:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=MXr1lXpM;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-28396255b81so1048740a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Nov 2023 16:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700785135; x=1701389935; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1PNaEsDGrJPXaEGPIWQfIfx81Fi9XU9zor/B7l5bZww=;
        b=MXr1lXpMiqOsBQOzrLP614DdNDPTixadoCgyQP7nsU53jtEAavMk5IhhMeZ9kwiZNi
         0sgtL40/FLwD5h4chH4C+Y2ppdhujXSHKfj0b7pHtDfV33iAjQy7omsv/VWAhTOwLtk5
         BKx57XiXX8ap543jCpgjvl7K66ppwbvNTWedaWYRcF7b27mIRMvnd7YmtwJuDjPb/NFm
         evjoUloQDYlBQ6SPOt69uPVX9dUH7pXzUayXFB6Ej0GdmHPLwZPSZb1BGvfWavIhB2mz
         HELrf6UbMLlh+5vhkuXniy9pPVCE9OAkeksfV7FaNU2vaDr/ZQOtA+7EY2BnmCQ3Vr4x
         Ueeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700785135; x=1701389935;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PNaEsDGrJPXaEGPIWQfIfx81Fi9XU9zor/B7l5bZww=;
        b=lYeJxw4/q9FzRNDMV4jswhpPZRaIZcgAWf/AgjSKRkH3yxRIh+nztojvClccLtWYBA
         vIE4562WTTh5BwR49YPdkB5fVquN5yUVr5+6FOJkEkeEbmM9JM+pK57wIbA4DiBGAT+k
         6UcyJGgW+KjXDqMAR6srx5F64pYFB7ylO+L9CEOEhZq5n2LIeZnGygpiNjJfjwImnPBh
         ugttPCKGw1EhqYkT1cn4ajTV5eOevY+dmvbvtdrwWbXi99fwaENnbTcdTcFkLwVKDAda
         6NdlVj6uCO++zBIBAN1Vuw0OTpo2NS7h3MWORsP6k0aAqqJz1Us4VdgmEMj8IW3MAt4g
         3IFw==
X-Gm-Message-State: AOJu0YxgaMGcilZWFv88ffyrSwvzfHGvqjlkhoOcS+OPjBLa3sHWbU6p
	wgjeSMLt/c+Tx3qGYu+H6EDzui1g+f94ZNv1l/A=
X-Google-Smtp-Source: AGHT+IHJ3k8A6nwMOz9zJkhPaFxiu8ue9Gw/yt03NCOKJdPlWCAhLdfKTt99cCXZjvCOilkSuJZtLA==
X-Received: by 2002:a17:90b:4a05:b0:285:71e1:3b71 with SMTP id kk5-20020a17090b4a0500b0028571e13b71mr958613pjb.29.1700785135187;
        Thu, 23 Nov 2023 16:18:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ci8-20020a17090afc8800b0027d0adf653bsm1826099pjb.7.2023.11.23.16.18.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 16:18:52 -0800 (PST)
Message-ID: <655febec.170a0220.ae4b3.4b49@mx.google.com>
Date: Thu, 23 Nov 2023 16:18:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.201-rt98-828-g27523c64bc5dd
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 5 runs,
 1 regressions (v5.10.201-rt98-828-g27523c64bc5dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 00:19:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13697

cip-gitlab/ci/pavel/linux-test ltp-mm: 5 runs, 1 regressions (v5.10.201-rt9=
8-828-g27523c64bc5dd)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-rt98-828-g27523c64bc5dd/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-rt98-828-g27523c64bc5dd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      27523c64bc5dd6f1af1b227b80017fea69e616b6

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


  Details:     https://kernelci.org/test/plan/id/655fe0b41b2694080b7e4a84

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/655fe0b41b2694080b7e4a85
        new failure (last pass: v6.1.58-cip7-132-gb38ea1474c159) =

 =20

