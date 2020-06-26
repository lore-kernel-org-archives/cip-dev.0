Return-Path: <SRS0=cz4l=AH=lists.cip-project.org=bounce+64572+4843+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EFFC433DF
	for <cip-dev@archiver.kernel.org>; Fri, 26 Jun 2020 16:57:21 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1C62207E8
	for <cip-dev@archiver.kernel.org>; Fri, 26 Jun 2020 16:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="tWA//Iop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C62207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4843+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HV5mYY4521723xXmmzGwrooI; Fri, 26 Jun 2020 09:57:20 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web11.33.1593190614657920041
 for <cip-dev@lists.cip-project.org>;
 Fri, 26 Jun 2020 09:56:55 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 05QGupfx008134
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 26 Jun 2020 18:56:52 +0200
X-Received: from md2dvrtc.ad001.siemens.net ([167.87.38.233])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 05QGupRh020562;
	Fri, 26 Jun 2020 18:56:51 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core PATCH v2 0/1] Cleanup
Date: Fri, 26 Jun 2020 18:56:50 +0200
Message-Id: <20200626165651.26960-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <b7714d3d-256d-2ec7-441b-a04b3029205f@siemens.com>
References: <b7714d3d-256d-2ec7-441b-a04b3029205f@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: NTtUohunY68ktereSCK4vdEpx4520388AA=
Content-Type: multipart/mixed; boundary="kKHyEOUYldCxTJyDyZuD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593190640;
 bh=QzvBwUn/q7slNpsJEld5K3A2jQ3eDCEJUFmsVj+gdiA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=tWA//IopSSbgz9mg+wdgwUpL/+LcqzJwJdtmo9WClBJXskD+07yp/Oy7kqm8Fr5a4g5
 pau3978nhaSzKS7AsLaj+GuKMRtkJfBzM4fqr3+uek9spes0cHe5WGzs1uQkZmZkSTpUl
 9STn8qM8A25d61kkcjJcGX+n2pjF7j1LgEM=

--kKHyEOUYldCxTJyDyZuD
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Move kas related files into folder kas for a cleaner repository root.
Update isar to remove patches folder for now

Changes V2:
 - move kas-cip back to repository root
 - remove applied Update ISAR patch

Quirin Gylstorff (1):
  kas: Restructure kas files.

 .gitlab-ci.yml                                            | 8 ++++----
 README.md                                                 | 4 ++--
 kas.yml => kas-cip.yml                                    | 0
 board-bbb.yml => kas/board/bbb.yml                        | 0
 board-iwg20m.yml => kas/board/iwg20m.yml                  | 0
 board-qemu-amd64.yml => kas/board/qemu-amd64.yml          | 0
 board-rzg2m.yml => kas/board/rzg2m.yml                    | 0
 .../board/simatic-ipc227e.yml                             | 0
 opt-4.4.yml => kas/opt/4.4.yml                            | 0
 opt-rt.yml => kas/opt/rt.yml                              | 0
 opt-stretch.yml => kas/opt/stretch.yml                    | 0
 opt-targz-img.yml => kas/opt/targz-img.yml                | 0
 12 files changed, 6 insertions(+), 6 deletions(-)
 rename kas.yml => kas-cip.yml (100%)
 rename board-bbb.yml => kas/board/bbb.yml (100%)
 rename board-iwg20m.yml => kas/board/iwg20m.yml (100%)
 rename board-qemu-amd64.yml => kas/board/qemu-amd64.yml (100%)
 rename board-rzg2m.yml => kas/board/rzg2m.yml (100%)
 rename board-simatic-ipc227e.yml => kas/board/simatic-ipc227e.yml (100%)
 rename opt-4.4.yml => kas/opt/4.4.yml (100%)
 rename opt-rt.yml => kas/opt/rt.yml (100%)
 rename opt-stretch.yml => kas/opt/stretch.yml (100%)
 rename opt-targz-img.yml => kas/opt/targz-img.yml (100%)

-- 
2.20.1


--kKHyEOUYldCxTJyDyZuD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4843): https://lists.cip-project.org/g/cip-dev/message=
/4843
Mute This Topic: https://lists.cip-project.org/mt/75128488/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--kKHyEOUYldCxTJyDyZuD--
