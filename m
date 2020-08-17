Return-Path: <SRS0=pwIo=B3=lists.cip-project.org=bounce+64572+5124+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8984C433E1
	for <cip-dev@archiver.kernel.org>; Mon, 17 Aug 2020 09:29:34 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 335E4207DF
	for <cip-dev@archiver.kernel.org>; Mon, 17 Aug 2020 09:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="U3S9OenQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 335E4207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5124+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id bwAcYY4521723xsrnIihZSlW; Mon, 17 Aug 2020 02:29:33 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web11.39870.1597656571760696562
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Aug 2020 02:29:33 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 07H9TSLj016209
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2020 11:29:29 +0200
X-Received: from md2dvrtc.fritz.box ([167.87.24.184])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 07H9TRbi029755;
	Mon, 17 Aug 2020 11:29:27 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: daniel.sangorrin@toshiba.co.jp, cip-dev@lists.cip-project.org,
        jan.kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [cip-kernel-config ][ RFC 0/1] Remove Remaining configs from isar-cip-core
Date: Mon, 17 Aug 2020 11:29:26 +0200
Message-Id: <20200817092927.14658-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <OSBPR01MB2053E648BDBD2C9934BAD1A8D04B0@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <OSBPR01MB2053E648BDBD2C9934BAD1A8D04B0@OSBPR01MB2053.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: NQBNDJoLSQrcOewkdPRaHwibx4520388AA=
Content-Type: multipart/mixed; boundary="GIDPoaHAIQa2ZMfwYcBU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597656573;
 bh=R94LWaZ1uxs6hzPeK7XxpCvZJDZJkbiSGOCcsSZTAzA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=U3S9OenQCJwAUA8i4LXLbpQSh6KBGGjQhtxTaYykOb2YG6eYA6BaK2oWRD+kUjqiUSy
 swfPGEfcoAELo5bbqd7yGd+d7xSXF7QkDX1QmyQQ7Ibui7Vxn7+4u8K5MbR5ppzbvRrDa
 L6fDWt122SghJUxBx9BtLrezS10hzJ3J+Lk=

--GIDPoaHAIQa2ZMfwYcBU
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Hi Daniel,

I check the cip_bbb_defconfig and swupdate should work with the current config.

The following patch contains the additional config switches from isar-cip-core.

If someone needs one of these switches active we should imported them into
the cip_bbb_defconfig.

Quirin

Quirin Gylstorff (1):
  4.19.y-cip/cip_bbb_defconfig: Add config switches from isar-cip-core

 4.19.y-cip/arm/cip_bbb_defconfig | 339 +++++++++++++++++++++++++++++++
 1 file changed, 339 insertions(+)

-- 
2.20.1


--GIDPoaHAIQa2ZMfwYcBU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5124): https://lists.cip-project.org/g/cip-dev/message=
/5124
Mute This Topic: https://lists.cip-project.org/mt/76240453/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--GIDPoaHAIQa2ZMfwYcBU--
