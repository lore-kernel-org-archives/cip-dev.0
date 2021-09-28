Return-Path: <SRS0=K174=OS=lists.cip-project.org=bounce+64572+6756+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177B4C433FE
	for <cip-dev@archiver.kernel.org>; Tue, 28 Sep 2021 18:49:54 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6955260ED7
	for <cip-dev@archiver.kernel.org>; Tue, 28 Sep 2021 18:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6955260ED7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 7XPnYY4521723x2DnKy23jvy; Tue, 28 Sep 2021 11:49:53 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web08.753.1632854991757344521
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Sep 2021 11:49:52 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 18SInnZS010904
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Sep 2021 20:49:49 +0200
X-Received: from md2dvrtc.fritz.box ([139.22.32.51])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 18SInmgw026555;
	Tue, 28 Sep 2021 20:49:49 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, dinesh.kumar@toshiba-tsip.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH 0/2] Fix for issue gitlab #14
Date: Tue, 28 Sep 2021 20:49:46 +0200
Message-Id: <20210928184948.737071-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 9ZzMNvDGo8UBOKNhq4Y9dF48x4520388AA=
Content-Type: multipart/mixed; boundary="rjsCWkHTPhzGrYxMlYBS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1632854993;
 bh=Iyl8fSm79EiCfacDAl1HmRS3u/erVWDOC4unXcQT5/Y=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=wD1wFuP3Yc/PL5Vto9sxweIfPDVwXYGp9iQ5ytogiYFPOw18uhD+IzwovKYHOMVe9YS
 VrctZZ3+Im2vgOW3f/7beewCdlzofoebKkbpDsRM/xZ9Q3W0g+NGTFC09oSJjkBQQDjO0
 lZJFyfuJ/B+DqsLDBAx3ZCR3disFri/b8C8=

--rjsCWkHTPhzGrYxMlYBS
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This Fixes [1]
.swu file is not getting generated for checking new swupdate handler (#14)

This issue occured due to [1]: If multiple `?=` assignments are used
the first of those assignments ends up getting used.

[1]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/14
[2]: https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-metadata.html#setting-a-default-value


Quirin Gylstorff (2):
  kas/opt/swupdate: Change assignment of IMAGE_TYPE and WKS_FILE
  kas/opt/efibootguard: Move setting of IMAGE_TYPE

 kas/opt/efibootguard.yml |  1 -
 kas/opt/swupdate.yml     |  4 ++--
 kas/opt/wic-img.yml      | 19 +++++++++++++++++++
 3 files changed, 21 insertions(+), 3 deletions(-)
 create mode 100644 kas/opt/wic-img.yml

-- 
2.30.2


--rjsCWkHTPhzGrYxMlYBS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6756): https://lists.cip-project.org/g/cip-dev/message/=
6756
Mute This Topic: https://lists.cip-project.org/mt/85931979/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--rjsCWkHTPhzGrYxMlYBS--
