Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B9EC4828F
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 23:04:47 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web10.6719.1706915085041282820
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 02 Feb 2024 15:04:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=1C+9ISfs;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6dddf4fc85dso2094230b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 02 Feb 2024 15:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706915084; x=1707519884; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LO3bYTW768sUttel0wSCHU0o/kU0J8VR2/FvRLE2/iU=;
        b=1C+9ISfs/wOSz3aeSmqFqg/ezOi8tuIDdSSAdf/QIncNlv8RbjFzcMfCm5OtZ7H9Oj
         +ep/Inw292mEoDkbvk8JpRBTAKtkyqNNYXyAC+QrT3wy8M8uU60/idPm3hilK5M6YVvk
         7Kl7zevw3ba9HqwpgjR9U3dYT71ZCA4gd5ZkIVzPTlde2WC1tHnQlQzYfBTDEse59uod
         uEQid+nVA/kuKhPNg4PsUf5nkzVxbopWRqL2GGmnARF2ZFkiabZr4a1BZinhij4jBupS
         uxNRCQ7CupbYAKO8X8C5baDanbwWW9zbkYIS1GAJ59nAQqPFVJaz106lHAeTzJXCjNvT
         w1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706915084; x=1707519884;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LO3bYTW768sUttel0wSCHU0o/kU0J8VR2/FvRLE2/iU=;
        b=oycnILIYchy2KzVgNFzlVk/ZICrpDwBe1TYfUwOTVtRmn+fViO1+7BMt0dLXenoJFC
         ZiWmEVyEmLRrStLBHyeyD7+yEGAr8XgMX4sVrazdFo2cBuoP5b/UF9KIGAqV3dWSC6V1
         Z/zkU+/fj1Iep4LLX8ruVO7OvQwxg/KHRx6gDv+o6Cl+rBR4GP8kiYevei+xesfF7RjH
         V8vlpc6Zeadvm49/8IDvwstbzmS5BDpA4eohTfcuXt2ybmd6rzmxm/LKUD5t6WFsgs+C
         JJ20rTdEM71BWVtbtU64vlreTPEb5bPGsKoRwEvY+sJ8uChEYQHZXd+uMkOyF5lZKWH6
         foRw==
X-Gm-Message-State: AOJu0YyWkIX8wuzVSrEo1Oztb9eZC9s1PqZzR7hSRtiTmPWQXnGbk7wx
	lHyjE3FE7pYGce2FZUGAT3J9H5o+OQklEhCgliT1o1rsv7gATe8TeGxMyqgkYEinuhJhWo0N2tl
	IND2wXQ==
X-Google-Smtp-Source: AGHT+IG2qyT8lmkngeouP/D6vR3X1zH7MSJ940XBmqqmgLd+ZC1OKHEOPk72mHuf4hvYYXl1QxGUaA==
X-Received: by 2002:aa7:8502:0:b0:6d9:b266:16c3 with SMTP id v2-20020aa78502000000b006d9b26616c3mr3749426pfn.4.1706915083855;
        Fri, 02 Feb 2024 15:04:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW9rqdYq233MC2TX6XE+MwexvNDLCcqLR+EoEvlkLSkoK5V4nLJyumvJlf7wxqTvophkJeG+aGzaBp9iYdMJZ6nw/KpK3XDz0h3w3r6LEc97UOQIR3EsX10XNrharYsBAJOEoOO0BmVYHA+EqkcFcxyWg==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q7-20020a056a00088700b006d638fd230bsm2224200pfj.93.2024.02.02.15.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 15:04:43 -0800 (PST)
Message-ID: <65bd750b.050a0220.f93f0.96ff@mx.google.com>
Date: Fri, 02 Feb 2024 15:04:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Kernel: v4.4-st20-2045-g32c8d563e356f
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st ltp-fcntl-locktests: 3 runs,
 1 regressions (v4.4-st20-2045-g32c8d563e356f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Feb 2024 23:04:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14638

cip/linux-4.4.y-st ltp-fcntl-locktests: 3 runs, 1 regressions (v4.4-st20-20=
45-g32c8d563e356f)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st/kernel/=
v4.4-st20-2045-g32c8d563e356f/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-st
  Describe: v4.4-st20-2045-g32c8d563e356f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      32c8d563e356f1b156afc0ba28f0aee7561dd2b6

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
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65bd682b15880a584100a056

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-2=
045-g32c8d563e356f/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/l=
tp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-2=
045-g32c8d563e356f/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/l=
tp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65bd682b15=
880a584100a057
        new failure (last pass: v4.4-st20-2023-g7107c2a794ba) =

 =20

