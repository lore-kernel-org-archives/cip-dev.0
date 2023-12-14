Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B26C4332F
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 13:50:38 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web10.22499.1702561837077508721
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Dec 2023 05:50:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=CJXJGKmG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28af0b85f58so867007a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 14 Dec 2023 05:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702561836; x=1703166636; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EOAmNQ6EPjnY/4oKXxk3u4rD9oWa9tA9m7tyQJkthyg=;
        b=CJXJGKmGNplIDBN43b1pPoCwLQTRv6OwGln0qgABPkNCaowDas12cdG3fIVNd6rGEs
         5JRI9kL3rBtmkkaeIw5pDTXgGGB9kj+/efuP2j8tMOtnpZyUmVvSMDLE8an1Jz3EoCk+
         +7Q/YEVSY6gdzY86OvVXzjZsjwJg1oRDIW/gzKQQBkKtPgwKHGB4G4u4Ep5NfXtWI4vI
         NlUjvMtoaadJF+db+qio8QGw+enHWVLcHxhAwg+55RZhXHPgaPXKZNNhfcVU+HdTrE4K
         Grz9vr7OU0Zpi54TGVhs05sgeULH0+EO4ZAlkwxCpFK3Eq+6do3e75S1YJJj8Onf71kC
         GSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561836; x=1703166636;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EOAmNQ6EPjnY/4oKXxk3u4rD9oWa9tA9m7tyQJkthyg=;
        b=VcCaDhwXKasiIKc7fHNlG/+WBHBl4YZXBsAnVF1kmlXKFpiG7Upd2xy9OnSBc67aEf
         OKRGPq5U6Nfxb6eRIq9EqPjkkQ9h4vRUZOptma5QzpEtf46ab8qkAPeTpSXeEBECV2vs
         1LgufdKcdsiYkHmeFsXxlgJ0N1l0KZE2UifXtRCW//Ag0PViPURWBmEQlkux8t0khVD8
         L/eEHTj+Yt1PEz9B5E59unZ3gEmRzbJIMg8Bjtw95nCWCrADvikYe7xgccZO6o005nHj
         sk4Jj53hcGrXOdubFk7X3DvxOTwdt9MIBH6jf7uxxB2REMjQSojzGJEZXj4b09hjRSwq
         mm/w==
X-Gm-Message-State: AOJu0YwO7sB01WTZgDqGkMmtEkFSiZiu2z0fyeWG1yQ8YyK0awbUNVjw
	+IKCZ4c00vaOHlyE8JL/8MQQ3rvTHqq0Ku+sZeifZw==
X-Google-Smtp-Source: AGHT+IGOI1qw7escVEbVyBmqX1SWA1FhSElKalk/ZYJh3Iu4UGNBJda7ZfHbGLKKNp+aSPgWkxtYcA==
X-Received: by 2002:a17:90a:aa17:b0:28a:b3d2:a63d with SMTP id k23-20020a17090aaa1700b0028ab3d2a63dmr2116177pjq.7.1702561835663;
        Thu, 14 Dec 2023 05:50:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a199700b0028afd8b1e0bsm2174661pji.57.2023.12.14.05.50.34
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:50:35 -0800 (PST)
Message-ID: <657b082b.170a0220.8310f.8099@mx.google.com>
Date: Thu, 14 Dec 2023 05:50:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-69-g8f7b450fc28ed
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 7
 runs, 1 regressions (v5.10.201-cip41-69-g8f7b450fc28ed)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 13:50:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14101

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 7 runs, 1=
 regressions (v5.10.201-cip41-69-g8f7b450fc28ed)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-69-g8f7b450fc28ed/plan/kselftes=
t-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-69-g8f7b450fc28ed
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      8f7b450fc28ed99196853536c98ae36c2567e160 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657afaecd6bcbbb27be13486

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-c=
ip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-c=
ip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/657afaec=
d6bcbbb27be13487
        failing since 21 days (last pass: v5.10.194-cip39-915-g96fa7f16cf02=
, first fail: v5.10.200-cip40-188-g33d0b44cd71d) =

 =20

