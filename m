Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77956C48BC0
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 04:58:29 +0000 (UTC)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
 by mx.groups.io with SMTP id smtpd.web11.13755.1707281901357674635
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Feb 2024 20:58:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=TAEtnN2M;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.42, mailfrom: bot@kernelci.org)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e117e0fee8so73301a34.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Feb 2024 20:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707281900; x=1707886700; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VYYZJ8h+SsQIA2HaSFWvs4wt8woVMQuynGnVor6I+xY=;
        b=TAEtnN2MgDpDBMxWtvt0ueiLFEyYLJ20RfzxERTlaxSYoyarUl7ZvGzd7E2dRaeBTE
         DO+nc0QfRZ9vubDRA/DRaG1pj9NX2NjyacAEVn9SxQ96dgJTb6YgeHfzm9EnRTet656i
         lDO/8GryCNBVqODDuaarZ7sRDJy4APwP+bQMRXhitDgVB/MOt7byn2EdKOJQ0qlwmjVp
         UmkDLxFn1tsj7EzHNPE2+Vze96K7+dtASl77M6NdhjAlyYed1GXOrBbRletjxZ5Uxxc7
         xAa2bxylIvY9gTUDryXjSyDcOim6D3baQxjyh/qHJTt+k+x0P579m1/kssbtlJ0jweWk
         pZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707281900; x=1707886700;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYYZJ8h+SsQIA2HaSFWvs4wt8woVMQuynGnVor6I+xY=;
        b=jc622+o1AZex/dgA/kMjD90zBOPQfoTwFj7uVPXEDQL6rj1GhzNs/FCihf2SenR8Mf
         LyHOHz4fcnv2rc7NXNuTQ8QIcrKv+kXDeas6VNX6LzR5nqqAjZN/a1b3zBZMN0mUaFct
         FKtlHyTi6WtK96M3Z7ILA/OJrsDjdQwof4x0iPQ0oOfChZlVRtQD/qcIPL0K068ds8iz
         Ale+a0VrVaqbicaxeBZ01ovMlZsx8+rJPt/FiTidNWAnQTrrNXHEd2V2tBfLY2FKnFrG
         PO2CkbiDshsx2asTKOzy6W9vWwi13o8kQb0u/QvBOXinhbn6NUa/unqSIxgVUBhJnT2J
         NKUA==
X-Gm-Message-State: AOJu0Ywwv3JC9a/HSTbgfPcTkc1MUrux/f/V4/RzT+BQSRVPyF6Cv1rX
	B/UjIov9HRrVJSaN5WToMRSGkkuPLJk8bqZkAWc1rxl+6Q7cvViZWmc0NqsIHAR6635hMyimY0l
	e
X-Google-Smtp-Source: AGHT+IE8anUfT+Gz71vcv6PS/+U6/OstMDNj+EdgefYBwMYz/rPqa0jIz2d8DnOclbBZLlDyOE+dFA==
X-Received: by 2002:a05:6358:93a3:b0:178:b0c9:118f with SMTP id h35-20020a05635893a300b00178b0c9118fmr1828497rwb.26.1707281899869;
        Tue, 06 Feb 2024 20:58:19 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c19-20020a17090ad91300b0028feef1f7adsm479358pjv.50.2024.02.06.20.58.18
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 20:58:18 -0800 (PST)
Message-ID: <65c30dea.170a0220.d36c8.1720@mx.google.com>
Date: Tue, 06 Feb 2024 20:58:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-1250-g39ff255b75f5
Subject: cip-gitlab/ci/pavel/linux-test smc: 2 runs,
 1 regressions (v4.4.302-cip72-1250-g39ff255b75f5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 04:58:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14863

cip-gitlab/ci/pavel/linux-test smc: 2 runs, 1 regressions (v4.4.302-cip72-1=
250-g39ff255b75f5)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip72-1250-g39ff255b75f5/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip72-1250-g39ff255b75f5
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      39ff255b75f5caee714b345c0c47b1c44b88dbe0 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2fdcd64c3ae931c8e1e80

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip72-1250-g39ff255b75f5/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/65c2fdcd64c3ae931c8e1e81
        new failure (last pass: v5.10.209-cip44-526-gbbb905888ca85) =

 =20

