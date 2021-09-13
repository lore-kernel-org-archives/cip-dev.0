Return-Path: <SRS0=09GK=OD=lists.cip-project.org=bounce+64572+6728+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C0EC433F5
	for <cip-dev@archiver.kernel.org>; Mon, 13 Sep 2021 00:27:39 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5DA660F35
	for <cip-dev@archiver.kernel.org>; Mon, 13 Sep 2021 00:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C5DA660F35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jDYnYY4521723x6FMiyCl0J4; Sun, 12 Sep 2021 17:27:38 -0700
X-Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web11.23025.1631492857912317663
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 12 Sep 2021 17:27:38 -0700
X-Received: by mail-pg1-f174.google.com with SMTP id w8so7777216pgf.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 12 Sep 2021 17:27:37 -0700 (PDT)
X-Gm-Message-State: LNJTjKmK4aJCx02AVN4fQI1Xx4520388AA=
X-Google-Smtp-Source: ABdhPJzhGX7qJLyxe+XCNSdhkiilheGS+JaQLeGprQKc9fQkLAPeI1bygLm7WTG4ddnUsJVc61duHg==
X-Received: by 2002:a05:6a00:c8a:b0:3fb:dbcc:e1d7 with SMTP id a10-20020a056a000c8a00b003fbdbcce1d7mr8473404pfv.51.1631492857237;
        Sun, 12 Sep 2021 17:27:37 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p3sm4851018pfw.71.2021.09.12.17.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 17:27:36 -0700 (PDT)
Message-ID: <613e9af8.1c69fb81.5d386.d19b@mx.google.com>
Date: Sun, 12 Sep 2021 17:27:36 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.283-cip62
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
Subject: [cip-dev] cip/linux-4.4.y-cip baseline-nfs: 43 runs, 1 regressions (v4.4.283-cip62) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="NRwdWqlgXd5NROaNAQRw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1631492858;
 bh=7Fty0IGACiPamfU2+yLfTGUtfZEh8mko66OswEfPUPE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=hjcapT0FyychAVLL7LRmYnW3ZWP4QBP/Iw2jNwi047MvQrrhjg/di1aabvdB9PkrTHj
 Mny5A0pTmC1SrBNz5ZXKjReuszle29zNlqKBNcfA2A2gwcQW6Ww4Uo/sKoHRoaiLQHQyg
 LP0ko8i6gv1zPR8Us8VmG6sI+VB4OyDhrjQ=

--NRwdWqlgXd5NROaNAQRw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.4.y-cip baseline-nfs: 43 runs, 1 regressions (v4.4.283-cip62)

Regressions Summary
-------------------

platform                  | arch | lab          | compiler | defconfig     =
  | regressions
--------------------------+------+--------------+----------+---------------=
--+------------
sun7i-a20-olinuxino-lime2 | arm  | lab-baylibre | gcc-8    | sunxi_defconfi=
g | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.283-cip62/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.283-cip62
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      823da4b312f214a4d0f750f9cb6157dcd47769fb =



Test Regressions
---------------- =



platform                  | arch | lab          | compiler | defconfig     =
  | regressions
--------------------------+------+--------------+----------+---------------=
--+------------
sun7i-a20-olinuxino-lime2 | arm  | lab-baylibre | gcc-8    | sunxi_defconfi=
g | 1          =


  Details:     https://kernelci.org/test/plan/id/613e946916de8eed4cd5969d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/sunxi_defconfig/gcc-8/lab-baylibre/baseline-nfs-sun7i-a20-olinuxin=
o-lime2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/sunxi_defconfig/gcc-8/lab-baylibre/baseline-nfs-sun7i-a20-olinuxin=
o-lime2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0827.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/613e946916de8eed4=
cd5969e
        failing since 118 days (last pass: v4.4.262-cip55, first fail: v4.4=
.268-cip57) =

 =20

--NRwdWqlgXd5NROaNAQRw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6728): https://lists.cip-project.org/g/cip-dev/message/=
6728
Mute This Topic: https://lists.cip-project.org/mt/85564415/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelci
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--NRwdWqlgXd5NROaNAQRw--
