Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916F6C4725D
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 14:11:05 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web10.7544.1704723058478025723
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 08 Jan 2024 06:10:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ryKF/EeT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28b82dc11e6so697144a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 08 Jan 2024 06:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704723057; x=1705327857; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ObvY7UKclktWRCDdk15ceqibExRIEU+Q4H6bbde9Z6Y=;
        b=ryKF/EeTc0pY9i3wzJvggF4cg57wzBWfHZ1A1ug88EGGy44gxrXF1zzs6pYORR+vs5
         fHlSBKQXDlMF+ygnDbmsH/YfjH2x/a051Z4+E9G4PhKTttRkY9fE7YY0ufyUhyvVQ0QZ
         a+/K8rggCkYiKk9RcFXwczhhk87peEWxMKBbjLNWp4aLRiw5DzZePeI7MFbupOQ3RUrR
         SZeIbHpAnULjlUsNm/Uvy/ICQsyrbvWQ0lw+TIpTTx2nVT3jBSBolJFhHks22/2ge3tk
         1+nVxmNzDcR1CpVQOS13U/bGKXxa4KMF/jzxoIH3BZhd+6qgorpi36thrj01lw8mXJ6Y
         AcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704723057; x=1705327857;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ObvY7UKclktWRCDdk15ceqibExRIEU+Q4H6bbde9Z6Y=;
        b=eVyTVe7vK7Fg/w3z413CzaE7waZ/ZnjEj5rFlQkiemXD7NuBKugp5mG6QmzZlcK9Gh
         +S8Fe/zyevsK0O3LuToCZ59jHrTNhyN9crOfNtDRMFOE7aZuP7GldDi9FbECnWxpEVxW
         cbTXBNMsuD2BHysfHoCS7gOvsqUC/PGBYE0t9s4A/O4AP2ekz0N8TY1Hztkb7bsQVXi8
         pqf3TFKf51mYmuLWjEZlaCmVynhttQYaYD6Pkh7gvsVxNRHWS0exXmk3g3KPRTXsVW8R
         86gQeK/o38qTDWo0waQ5c7L3OBfzmiXybxVvzIgGWV6+A95TEnE3xUhuuIfwd0Ec35eS
         8C+w==
X-Gm-Message-State: AOJu0YwMjvsxqLxWMf2eldAOycM950RlIG+nxZopaz2kayw8itJJvRMC
	1+8d/e13yjy4SXuOq2HaVBdNUCu+rkbZoA5gE7awQv27hDo=
X-Google-Smtp-Source: AGHT+IF+giJ5k4D1ng8m1owGOSc3IVFzR3xfgrqo1mkxhQXVIHFykXcis6qP4QOqf/bhjJHKjSVJkA==
X-Received: by 2002:a17:90a:94c8:b0:28c:1551:54b0 with SMTP id j8-20020a17090a94c800b0028c155154b0mr1038249pjw.44.1704723056766;
        Mon, 08 Jan 2024 06:10:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d3-20020a17090ad98300b0028ce507cd7dsm6447848pjv.55.2024.01.08.06.10.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:10:55 -0800 (PST)
Message-ID: <659c026f.170a0220.771ab.ddb9@mx.google.com>
Date: Mon, 08 Jan 2024 06:10:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.299-cip105-289-gad0914f265af
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-ipc: 9 runs,
 1 regressions (v4.19.299-cip105-289-gad0914f265af)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jan 2024 14:11:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14283

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-ipc: 9 runs, 1 regressions (=
v4.19.299-cip105-289-gad0914f265af)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.299-cip105-289-gad0914f265af/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.299-cip105-289-gad0914f265af
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ad0914f265af139fd53d721f0db787b707de20ef

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/659bfaee2f82c6c8fb52a480

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/arm64/defconfig/gcc-10/lab-=
cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/arm64/defconfig/gcc-10/lab-=
cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/659bfaee2f82c6c8fb52a4=
81
        new failure (last pass: v4.19.299-cip105-158-g856c181dce342) =

 =20

